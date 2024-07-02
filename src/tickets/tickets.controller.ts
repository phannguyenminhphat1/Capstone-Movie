import {
  Body,
  Controller,
  Get,
  Post,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { TicketsService } from './tickets.service';
import { ApiBearerAuth, ApiQuery, ApiTags } from '@nestjs/swagger';
import { BookingTicketsDto } from './dto/booking-tickets.dto';
import { AuthGuard } from '@nestjs/passport';
import { Request } from 'express';

@ApiTags('Tickets')
@Controller('api/tickets')
export class TicketsController {
  constructor(private readonly ticketsService: TicketsService) {}

  @ApiQuery({
    name: 'showtimeID',
    description: 'Showtime ID',
  })
  @Get('get-showtime-tickets')
  getShowtimeTickets(@Query('showtimeID') showtimeId: string): Promise<object> {
    return this.ticketsService.getShowtimeTickets(Number(showtimeId));
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'))
  @Post('booking-tickets')
  bookingTickets(
    @Body() bookingTicketsDto: BookingTicketsDto,
    @Req() req: Request,
  ): Promise<object> {
    return this.ticketsService.bookingTickets(bookingTicketsDto, req);
  }
}
