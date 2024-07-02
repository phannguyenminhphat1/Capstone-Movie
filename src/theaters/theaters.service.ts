import { BadRequestException, Injectable } from '@nestjs/common';
import { cum_rap, he_thong_rap, phim } from '@prisma/client';
import { MOVIES_MESSAGES, THEATER_MESSAGES } from 'src/constants/messages';
import { NotFoundException } from 'src/utils/exceptions/not-found.exception';
import { CreateShowtimesDto } from './dto/create-showtimes.dto';
import { CreateShowtimes } from './models/create-showtimes.models';
import { UnprocessableEntityException } from 'src/utils/exceptions/unprocessable.exception';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class TheatersService {
  constructor(private prisma: PrismaService) {}

  async getTheaterSystem(id: string): Promise<object> {
    const theaterSystems: he_thong_rap[] =
      await this.prisma.he_thong_rap.findMany({
        where: id
          ? {
              ma_he_thong_rap: {
                contains: id,
              },
            }
          : {},
      });
    return {
      message: THEATER_MESSAGES.GET_THEATER_SYSTEMS_SUCCESS,
      theater_systems: theaterSystems,
    };
  }

  async getTheaterComplexs(theaterSystemID: string): Promise<object> {
    if (!theaterSystemID) {
      throw new BadRequestException({
        message: THEATER_MESSAGES.THEATER_SYSTEM_ID_IS_REQUIRED,
      });
    }
    const findTheaterSystem: he_thong_rap =
      await this.prisma.he_thong_rap.findUnique({
        where: {
          ma_he_thong_rap: theaterSystemID,
        },
      });
    if (!findTheaterSystem) {
      throw new NotFoundException(THEATER_MESSAGES.THEATER_SYSTEM_ID_NOT_FOUND);
    }
    const theaterComplexs: cum_rap[] = await this.prisma.cum_rap.findMany({
      where: {
        ma_he_thong_rap: findTheaterSystem.ma_he_thong_rap,
      },
      include: {
        rap_phim: true,
      },
    });
    return {
      message: THEATER_MESSAGES.GET_THEATER_COMPLEXS_SUCCESS,
      theater_complexs: theaterComplexs,
    };
  }

  async getShowtimesByTheaterSystem(theaterSystemID: string): Promise<object> {
    if (!theaterSystemID) {
      throw new BadRequestException({
        message: THEATER_MESSAGES.THEATER_SYSTEM_ID_IS_REQUIRED,
      });
    }
    const findTheaterSystem: he_thong_rap =
      await this.prisma.he_thong_rap.findUnique({
        where: {
          ma_he_thong_rap: theaterSystemID,
        },
      });
    if (!findTheaterSystem) {
      throw new NotFoundException(THEATER_MESSAGES.THEATER_SYSTEM_ID_NOT_FOUND);
    }
    const showtimes = await this.prisma.lich_chieu.findMany({
      where: {
        rap_phim: {
          cum_rap: {
            he_thong_rap: {
              ma_he_thong_rap: theaterSystemID,
            },
          },
        },
      },
      include: {
        rap_phim: {
          include: {
            cum_rap: {
              include: {
                he_thong_rap: true,
              },
            },
          },
        },
        phim: true,
      },
    });
    const result = [];
    showtimes.forEach((showtime) => {
      const { rap_phim, gia_ve, ma_lich_chieu, ngay_gio_chieu, phim } =
        showtime;
      const {
        dang_chieu,
        danh_gia,
        hinh_anh,
        hot,
        mo_ta,
        ma_phim,
        ngay_khoi_chieu,
        sap_chieu,
        ten_phim,
        trailer,
      } = phim;
      const { cum_rap, ma_rap, ten_rap } = rap_phim;
      const { dia_chi, he_thong_rap, ma_cum_rap, ten_cum_rap } = cum_rap;
      const { logo, ma_he_thong_rap, ten_he_thong_rap } = he_thong_rap;
      let heThongRap = result.find(
        (item) => item.ma_he_thong_rap === ma_he_thong_rap,
      );
      if (!heThongRap) {
        heThongRap = {
          ma_he_thong_rap,
          ten_he_thong_rap,
          logo,
          cum_rap: [],
        };
        result.push(heThongRap);
      }
      let cumRap = heThongRap.cum_rap.find(
        (item) => item.ma_cum_rap === ma_cum_rap,
      );
      if (!cumRap) {
        cumRap = {
          ma_cum_rap,
          ten_cum_rap,
          dia_chi,
          phim: [],
        };
        heThongRap.cum_rap.push(cumRap);
      }
      let fim = cumRap.phim.find((item) => item.ma_phim === ma_phim);
      if (!fim) {
        fim = {
          ma_phim,
          ten_phim,
          mo_ta,
          ngay_khoi_chieu,
          hinh_anh,
          trailer,
          danh_gia,
          dang_chieu,
          sap_chieu,
          hot,
          rap_phim: [],
        };
        cumRap.phim.push(fim);
      }
      let rapPhim = fim.rap_phim.find((item) => item.ma_rap === ma_rap);
      if (!rapPhim) {
        rapPhim = {
          ma_rap,
          ten_rap,
          lich_chieu: [],
        };
        fim.rap_phim.push(rapPhim);
      }
      rapPhim.lich_chieu.push({
        ma_lich_chieu,
        ngay_gio_chieu,
        gia_ve,
      });
    });
    if (showtimes.length === 0) {
      return {
        message: THEATER_MESSAGES.MOVIE_HAS_NO_SHOWTIMES,
      };
    }
    return {
      message: THEATER_MESSAGES.GET_SHOWTIMES_BY_THEATER_SYTEMS_SUCCESS,
      showtimes: result,
    };
  }

  async getShowtimesByMovie(movieId: number): Promise<object> {
    if (!movieId) {
      throw new BadRequestException({
        message: THEATER_MESSAGES.MOVIE_ID_IS_REQUIRED,
      });
    }
    const findMovie: phim = await this.prisma.phim.findUnique({
      where: {
        ma_phim: movieId,
      },
    });
    if (!findMovie) {
      throw new NotFoundException(THEATER_MESSAGES.MOVIE_NOT_FOUND);
    }
    const movie = await this.prisma.phim.findUnique({
      where: { ma_phim: movieId },
      include: {
        lich_chieu: {
          include: {
            rap_phim: {
              include: {
                cum_rap: {
                  include: {
                    he_thong_rap: true,
                  },
                },
              },
            },
          },
        },
      },
    });
    if (movie.lich_chieu.length === 0) {
      return {
        message: THEATER_MESSAGES.MOVIE_HAS_NO_SHOWTIMES,
      };
    }
    const result = [];
    movie.lich_chieu.forEach((showtime) => {
      const { gia_ve, ma_lich_chieu, ngay_gio_chieu, rap_phim } = showtime;
      const { cum_rap, ten_rap, ma_rap } = rap_phim;
      const { dia_chi, he_thong_rap, ma_cum_rap, ten_cum_rap } = cum_rap;
      const { logo, ma_he_thong_rap, ten_he_thong_rap } = he_thong_rap;

      let heThongRap = result.find(
        (item) => item.ma_he_thong_rap === ma_he_thong_rap,
      );
      if (!heThongRap) {
        heThongRap = {
          ma_he_thong_rap,
          ten_he_thong_rap,
          logo,
          cum_rap: [],
        };
        result.push(heThongRap);
      }
      let cumRap = heThongRap.cum_rap.find(
        (item) => item.ma_cum_rap === ma_cum_rap,
      );
      if (!cumRap) {
        cumRap = {
          ma_cum_rap,
          ten_cum_rap,
          dia_chi,
          rap_phim: [],
        };
        heThongRap.cum_rap.push(cumRap);
      }
      let rapPhim = cumRap.rap_phim.find((item) => item.ma_rap === ma_rap);
      if (!rapPhim) {
        rapPhim = {
          ma_rap,
          ten_rap,
          lich_chieu: [],
        };
        cumRap.rap_phim.push(rapPhim);
      }
      rapPhim.lich_chieu.push({
        ma_lich_chieu,
        ngay_gio_chieu,
        gia_ve,
      });
    });

    return {
      message: THEATER_MESSAGES.GET_SHOWTIMES_BY_MOVIE_SUCCESS,
      movieInfo: findMovie,
      movieShowtimes: result,
    };
  }

  // ROLE ADMIN
  async createShowtimes(
    createShowtimesDto: CreateShowtimesDto,
  ): Promise<object> {
    const { movieId, movieShowtimes, movieTheaterId, ticketPrice } =
      createShowtimesDto;

    const [findMovie, findMovieTheater] = await Promise.all([
      this.prisma.phim.findUnique({
        where: {
          ma_phim: movieId,
          da_xoa: false,
        },
      }),
      this.prisma.rap_phim.findUnique({
        where: {
          ma_rap: movieTheaterId,
        },
      }),
    ]);
    if (!findMovie) {
      throw new NotFoundException(MOVIES_MESSAGES.MOVIE_NOT_FOUND);
    }
    if (!findMovieTheater) {
      throw new NotFoundException(THEATER_MESSAGES.MOVIE_THEATER_NOT_FOUND);
    }
    const showtimeDate = new Date(movieShowtimes);
    const showtimeStartOfDay = new Date(showtimeDate);
    showtimeStartOfDay.setHours(0, 0, 0, 0);
    const showtimeEndOfDay = new Date(showtimeDate);
    showtimeEndOfDay.setHours(23, 59, 59, 999);
    const threeHoursBefore = new Date(showtimeDate);
    threeHoursBefore.setHours(showtimeDate.getHours() - 3);
    const threeHoursAfter = new Date(showtimeDate);
    threeHoursAfter.setHours(showtimeDate.getHours() + 3);

    const invalidShowtime = await this.prisma.lich_chieu.findFirst({
      where: {
        ma_rap: movieTheaterId,
        ngay_gio_chieu: {
          gte: showtimeStartOfDay,
          lte: showtimeEndOfDay,
        },
        OR: [
          {
            ngay_gio_chieu: {
              gte: threeHoursBefore,
              lte: showtimeDate,
            },
          },
          {
            ngay_gio_chieu: {
              gte: showtimeDate,
              lte: threeHoursAfter,
            },
          },
        ],
      },
    });
    if (invalidShowtime) {
      throw new UnprocessableEntityException(THEATER_MESSAGES.INVALID_SHOWTIME);
    }

    const newShowtimes: CreateShowtimes = {
      ma_phim: findMovie.ma_phim,
      ma_rap: findMovieTheater.ma_rap,
      ngay_gio_chieu: showtimeDate,
      gia_ve: Number(ticketPrice),
    };

    await this.prisma.lich_chieu.create({ data: newShowtimes });

    return {
      message: THEATER_MESSAGES.CREATE_SHOWTIMES_SUCCESS,
    };
  }
}
