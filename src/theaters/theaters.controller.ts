import { Body, Controller, Get, Post, Query, UseGuards } from '@nestjs/common';
import { TheatersService } from './theaters.service';
import { ApiBearerAuth, ApiQuery, ApiTags } from '@nestjs/swagger';
import { CreateShowtimesDto } from './dto/create-showtimes.dto';
import { AuthGuard } from '@nestjs/passport';
import { RolesGuard } from 'src/guards/roles/roles.guard';

@ApiTags('Theaters')
@Controller('api/theaters')
export class TheatersController {
  constructor(private readonly theatersService: TheatersService) {}

  @ApiQuery({
    name: 'id',
    description: 'Theater System ID',
    required: false,
  })
  @Get('get-theater-systems')
  getTheaterSystem(@Query('id') id: string): Promise<object> {
    return this.theatersService.getTheaterSystem(id);
  }

  @ApiQuery({
    name: 'theaterSystemID',
    description: 'Theater System ID',
  })
  @Get('get-theater-complexs')
  getTheaterComplexs(
    @Query('theaterSystemID') theaterSystemID: string,
  ): Promise<object> {
    return this.theatersService.getTheaterComplexs(theaterSystemID);
  }

  @ApiQuery({
    name: 'theaterSystemID',
    description: 'Theater System ID',
  })
  @Get('get-showtimes-by-theater-system')
  getShowtimesByTheaterSystem(
    @Query('theaterSystemID') theaterSystemID: string,
  ): Promise<object> {
    return this.theatersService.getShowtimesByTheaterSystem(theaterSystemID);
  }

  @ApiQuery({
    name: 'movieId',
    description: 'Movie ID',
  })
  @Get('get-showtimes-by-movie')
  getShowtimesByMovie(@Query('movieId') movieId: string): Promise<object> {
    return this.theatersService.getShowtimesByMovie(Number(movieId));
  }

  // ROLE ADMIN

  @ApiBearerAuth()
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Post('create-showtimes')
  createShowtimes(
    @Body() createShowtimesDto: CreateShowtimesDto,
  ): Promise<object> {
    return this.theatersService.createShowtimes(createShowtimesDto);
  }
}
