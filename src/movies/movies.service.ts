import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
} from '@nestjs/common';
import { banner, phim } from '@prisma/client';
import { MOVIES_MESSAGES, USERS_MESSAGES } from 'src/constants/messages';
import { PaginationMoviesDto } from './dto/pagination-movies.dto';
import { GetMoviesByDateDto } from './dto/get-movies-by-date.dto';
import { CreateMoviesDto } from './dto/create-movies.dto';
import { UnprocessableEntityException } from 'src/utils/exceptions/unprocessable.exception';
import cloudinary from 'src/utils/cloudinary';
import * as fs from 'fs';
import { NotFoundException } from 'src/utils/exceptions/not-found.exception';
import { CreateMovie } from './models/create-movie.models';
import { UpdateMoviesDto } from './dto/update-movies.dto';
import { UpdateMovies } from './models/update-movie.models';
import { compressImage } from 'src/utils/compress-img';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class MoviesService {
  constructor(private prisma: PrismaService) {}

  private convertDateString(date: Date): string {
    return new Date(date).toLocaleDateString('vi-VN', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
    });
  }

  private convertResult(movies: phim[]): phim[] {
    return movies.map((movie) => {
      return {
        ...movie,
        ngay_khoi_chieu: this.convertDateString(movie.ngay_khoi_chieu) as any,
      };
    });
  }

  private parseBoolean(key: any): boolean {
    const parseStringKey = String(key);
    const parseBooleanKey = Boolean(JSON.parse(parseStringKey));
    return parseBooleanKey;
  }

  async getBanners(): Promise<object> {
    const banners: banner[] = await this.prisma.banner.findMany({
      include: {
        phim: true,
      },
    });
    return {
      message: MOVIES_MESSAGES.GET_ALL_BANNERS_SUCCESS,
      banners,
    };
  }

  async getMovies(name: string): Promise<object> {
    const movies: phim[] = await this.prisma.phim.findMany({
      where: name
        ? {
            ten_phim: {
              contains: name.toLowerCase(),
            },
          }
        : {},
    });
    const result = this.convertResult(movies);
    return {
      message: MOVIES_MESSAGES.GET_ALL_MOVIES_SUCCESS,
      movies: result,
    };
  }

  async getMoviesPagination(
    paginationMoviesDto: PaginationMoviesDto,
  ): Promise<object> {
    const { limit = 6, name = '', page = 1 } = paginationMoviesDto;
    const parsePage = Number(page);
    const parseLimit = Number(limit);
    const skip = (parsePage - 1) * parseLimit;
    const searchCondition = name
      ? {
          ten_phim: {
            contains: name.toLowerCase(),
          },
        }
      : {};
    const movies: phim[] = await this.prisma.phim.findMany({
      skip,
      take: parseLimit,
      where: searchCondition,
    });
    const total: number = await this.prisma.phim.count({
      where: searchCondition,
    });

    const result = this.convertResult(movies);

    return {
      message: MOVIES_MESSAGES.GET_ALL_MOVIES_SUCCESS,
      data: result,
      count: movies.length,
      total,
      pageNumber: parsePage,
      totalPages: Math.ceil(total / parseLimit),
    };
  }

  async getMoviesByDate(
    getMoviesByDateDto: GetMoviesByDateDto,
  ): Promise<object> {
    const {
      limit = 6,
      name = '',
      page = 1,
      startDate,
      endDate,
    } = getMoviesByDateDto;
    const parseLimit = Number(limit);
    const parsePage = Number(page);

    const skip = (parsePage - 1) * parseLimit;

    const searchCondition: any = {};

    if (name) {
      searchCondition.ten_phim = {
        contains: name.toLowerCase(),
      };
    }

    if (startDate) {
      searchCondition.ngay_khoi_chieu = {
        ...(searchCondition.ngay_khoi_chieu ?? {}),
        gte: new Date(startDate),
      };
    }

    if (endDate) {
      searchCondition.ngay_khoi_chieu = {
        ...(searchCondition.ngay_khoi_chieu ?? {}),
        lte: new Date(endDate),
      };
    }

    const [movies, total] = await Promise.all([
      this.prisma.phim.findMany({
        skip: skip,
        take: parseLimit,
        where: searchCondition,
      }),
      this.prisma.phim.count({
        where: searchCondition,
      }),
    ]);
    const result = this.convertResult(movies);

    return {
      message: MOVIES_MESSAGES.GET_ALL_MOVIES_SUCCESS,
      data: result,
      count: movies.length,
      total,
      page: parsePage,
      totalPages: Math.ceil(total / limit),
    };
  }

  async getMovieInfo(movieId: number): Promise<object> {
    if (!movieId) {
      throw new BadRequestException({
        message: MOVIES_MESSAGES.MOVIE_ID_IS_REQUIRED,
      });
    }
    const movie: phim = await this.prisma.phim.findUnique({
      where: {
        ma_phim: movieId,
      },
    });
    if (!movie) {
      throw new NotFoundException(MOVIES_MESSAGES.MOVIE_NOT_FOUND);
    }
    const result: phim = {
      ...movie,
      ngay_khoi_chieu: this.convertDateString(movie.ngay_khoi_chieu) as any,
    };
    return {
      message: MOVIES_MESSAGES.GET_MOVIE_SUCCESS,
      movie: result,
    };
  }

  // ROLE ADMIN -------------------------------------------
  async createMovie(
    createMoviesDto: CreateMoviesDto,
    file: Express.Multer.File,
  ): Promise<object> {
    const {
      hot,
      commingSoon,
      desc,
      name,
      rate,
      showingNow,
      trailer,
      releaseDate,
    } = createMoviesDto;

    const findMovie: phim = await this.prisma.phim.findFirst({
      where: {
        ten_phim: name,
      },
    });

    if (findMovie) {
      throw new UnprocessableEntityException(
        MOVIES_MESSAGES.NAME_IS_ALREADY_EXIST,
      );
    }
    if (!file) {
      throw new UnprocessableEntityException(MOVIES_MESSAGES.IMAGE_IS_REQUIRED);
    }

    let input = process.cwd() + '/public/img/' + file.filename;
    let output = process.cwd() + '/public/imgOptimize/';
    const result = await compressImage(input, output);
    if (!result) {
      throw new InternalServerErrorException(
        USERS_MESSAGES.ERROR_WHILE_COMPRESSING_IMAGES,
      );
    }
    const cloudinaryResult = await cloudinary.uploader.upload(
      `${output}${file.filename}`,
    );

    const parseHot = this.parseBoolean(hot);
    const parseCommingSoon = this.parseBoolean(commingSoon);
    const parseShowingNow = this.parseBoolean(showingNow);

    const newMovie: CreateMovie = {
      ten_phim: name,
      mo_ta: desc,
      trailer,
      danh_gia: Number(rate),
      hinh_anh: cloudinaryResult.url,
      sap_chieu: parseCommingSoon,
      hot: parseHot,
      dang_chieu: parseShowingNow,
      ngay_khoi_chieu: new Date(releaseDate),
      da_xoa: false,
    };
    const movie: phim = await this.prisma.phim.create({ data: newMovie });
    fs.unlinkSync(`${output}${file.filename}`);
    fs.unlinkSync(input);
    return {
      message: MOVIES_MESSAGES.CREATE_MOVIE_SUCCESS,
      movie,
    };
  }

  async uploadImage(file: Express.Multer.File): Promise<{
    url: string;
  }> {
    if (!file) {
      throw new UnprocessableEntityException(MOVIES_MESSAGES.IMAGE_IS_REQUIRED);
    }
    let input = process.cwd() + '/public/img/' + file.filename;
    let output = process.cwd() + '/public/imgOptimize/';
    const result = await compressImage(input, output);
    if (!result) {
      throw new InternalServerErrorException(
        USERS_MESSAGES.ERROR_WHILE_COMPRESSING_IMAGES,
      );
    }
    const cloudinaryResult = await cloudinary.uploader.upload(
      `${output}${file.filename}`,
    );
    fs.unlinkSync(`${output}${file.filename}`);
    fs.unlinkSync(input);
    return { url: cloudinaryResult.url };
  }

  async updateMovie(
    movieId: number,
    updateMoviesDto: UpdateMoviesDto,
  ): Promise<string> {
    const {
      name,
      commingSoon,
      deleted,
      desc,
      hot,
      imageUrl,
      rate,
      releaseDate,
      showingNow,
      trailer,
    } = updateMoviesDto;

    if (!movieId) {
      throw new BadRequestException({
        message: MOVIES_MESSAGES.MOVIE_ID_IS_REQUIRED,
      });
    }

    const findMovie: phim = await this.prisma.phim.findUnique({
      where: {
        ma_phim: movieId,
      },
    });
    if (!findMovie) {
      throw new NotFoundException(MOVIES_MESSAGES.MOVIE_NOT_FOUND);
    }
    if (name) {
      const findMovieByName: phim = await this.prisma.phim.findFirst({
        where: {
          ten_phim: name,
        },
      });
      if (findMovieByName && findMovieByName.ma_phim !== findMovie.ma_phim) {
        throw new UnprocessableEntityException(
          MOVIES_MESSAGES.NAME_IS_ALREADY_EXIST,
        );
      }
    }
    const movieUpdate: UpdateMovies = {
      ten_phim: name,
      mo_ta: desc,
      hinh_anh: imageUrl,
      trailer,
    };
    if (rate) {
      movieUpdate.danh_gia = Number(rate);
    }
    if (releaseDate) {
      movieUpdate.ngay_khoi_chieu = new Date(releaseDate);
    }
    if (commingSoon) {
      movieUpdate.sap_chieu = this.parseBoolean(commingSoon);
    }
    if (showingNow) {
      movieUpdate.dang_chieu = this.parseBoolean(showingNow);
    }
    if (hot) {
      movieUpdate.hot = this.parseBoolean(hot);
    }
    if (deleted) {
      movieUpdate.da_xoa = this.parseBoolean(deleted);
    }
    await this.prisma.phim.update({
      where: {
        ma_phim: findMovie.ma_phim,
      },
      data: movieUpdate,
    });
    return MOVIES_MESSAGES.UPDATE_MOVIE_SUCCESS;
  }

  async deleteMovie(movieId: number): Promise<string> {
    if (!movieId) {
      throw new BadRequestException({
        message: MOVIES_MESSAGES.MOVIE_ID_IS_REQUIRED,
      });
    }
    const findMovie: phim = await this.prisma.phim.findUnique({
      where: {
        ma_phim: movieId,
      },
    });
    if (!findMovie) {
      throw new NotFoundException(MOVIES_MESSAGES.MOVIE_NOT_FOUND);
    }
    await this.prisma.phim.update({
      where: {
        ma_phim: findMovie.ma_phim,
      },
      data: {
        da_xoa: true,
      },
    });
    return MOVIES_MESSAGES.DELETE_MOVIE_SUCCESS;
  }

  async deleteMovieImmediate(movieId: number): Promise<string> {
    if (!movieId) {
      throw new BadRequestException({
        message: MOVIES_MESSAGES.MOVIE_ID_IS_REQUIRED,
      });
    }
    const findMovie: phim = await this.prisma.phim.findUnique({
      where: {
        ma_phim: movieId,
      },
    });
    if (!findMovie) {
      throw new NotFoundException(MOVIES_MESSAGES.MOVIE_NOT_FOUND);
    }
    await this.prisma.phim.delete({
      where: {
        ma_phim: findMovie.ma_phim,
      },
    });
    return MOVIES_MESSAGES.DELETE_MOVIE_SUCCESS;
  }
}
