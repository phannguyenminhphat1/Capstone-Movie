import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
  UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { MoviesService } from './movies.service';
import { AuthGuard } from '@nestjs/passport';
import { RolesGuard } from 'src/guards/roles/roles.guard';
import { FileInterceptor } from '@nestjs/platform-express';
import { uploadOptions } from 'src/utils/upload';
import { CreateMoviesDto } from './dto/create-movies.dto';
import {
  ApiBearerAuth,
  ApiBody,
  ApiConsumes,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { GetMoviesByDateDto } from './dto/get-movies-by-date.dto';
import { PaginationMoviesDto } from './dto/pagination-movies.dto';
import { UpdateMoviesDto } from './dto/update-movies.dto';
import { UploadImageMoviesDto } from './dto/upload-image-movies.dto';

@ApiTags('Movies')
@Controller('api/movies')
export class MoviesController {
  constructor(private readonly moviesService: MoviesService) {}

  @Get('get-banners')
  getBanners(): Promise<object> {
    return this.moviesService.getBanners();
  }

  @ApiQuery({ name: 'name', required: false, schema: { default: '' } })
  @Get('get-movies')
  getMovies(@Query('name') name: string): Promise<object> {
    return this.moviesService.getMovies(name);
  }

  @Get('get-movies-pagination')
  getMoviesPagination(
    @Query() paginationMoviesDto: PaginationMoviesDto,
  ): Promise<object> {
    return this.moviesService.getMoviesPagination(paginationMoviesDto);
  }

  @Get('get-movies-by-date')
  async getMoviesByDate(@Query() getMoviesByDateDto: GetMoviesByDateDto) {
    return this.moviesService.getMoviesByDate(getMoviesByDateDto);
  }

  @Get('get-movie-info/:movieId')
  getMovieInfo(@Param('movieId') movieId: string): Promise<object> {
    return this.moviesService.getMovieInfo(Number(movieId));
  }

  // ROLES ADMIN
  @ApiConsumes('multipart/form-data')
  @ApiBearerAuth()
  @ApiBody({
    type: CreateMoviesDto,
  })
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @UseInterceptors(FileInterceptor('image', uploadOptions))
  @Post('create-movie')
  createMovie(
    @Body() createMoviesDto: CreateMoviesDto,
    @UploadedFile() file: Express.Multer.File,
  ): Promise<object> {
    return this.moviesService.createMovie(createMoviesDto, file);
  }

  @ApiConsumes('multipart/form-data')
  @ApiBearerAuth()
  @ApiBody({
    type: UploadImageMoviesDto,
  })
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @UseInterceptors(FileInterceptor('image', uploadOptions))
  @Post('upload-image')
  async uploadImage(@UploadedFile() file: Express.Multer.File): Promise<{
    url: string;
  }> {
    return await this.moviesService.uploadImage(file);
  }

  @ApiBearerAuth()
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Patch('update-movie/:movieId')
  updateMovie(
    @Param('movieId') movieId: string,
    @Body() updateMoviesDto: UpdateMoviesDto,
  ): Promise<string> {
    return this.moviesService.updateMovie(Number(movieId), updateMoviesDto);
  }

  @ApiBearerAuth()
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Patch('delete-movie/:movieId')
  deleteMovie(@Param('movieId') movieId: string): Promise<string> {
    return this.moviesService.deleteMovie(Number(movieId));
  }

  @ApiBearerAuth()
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Delete('delete-movie/:movieId')
  deleteMovieImmediate(@Param('movieId') movieId: string): Promise<string> {
    return this.moviesService.deleteMovieImmediate(Number(movieId));
  }
}
