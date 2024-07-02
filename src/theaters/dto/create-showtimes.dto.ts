import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsDateString, IsInt, IsNotEmpty, Min } from 'class-validator';
import { THEATER_MESSAGES } from 'src/constants/messages';

export class CreateShowtimesDto {
  @ApiProperty()
  @Transform(({ value }) => parseInt(value, 10))
  @IsInt({ message: THEATER_MESSAGES.MOVIE_ID_MUST_BE_A_NUMBER })
  @IsNotEmpty({ message: THEATER_MESSAGES.MOVIE_ID_IS_REQUIRED })
  movieId: number;

  @ApiProperty()
  @Transform(({ value }) => parseInt(value, 10))
  @IsInt({ message: THEATER_MESSAGES.MOVIE_THEATER_ID_MUST_BE_A_NUMBER })
  @IsNotEmpty({ message: THEATER_MESSAGES.MOVIE_THEATER_ID_IS_REQUIRED })
  movieTheaterId: number;

  @ApiProperty({
    example: '2024-06-18T19:30:00',
    description: 'Showtimes of the movie',
  })
  @IsDateString(
    {},
    { message: THEATER_MESSAGES.MOVIE_SHOWTIMES_MUST_BE_A_DATE_TIME },
  )
  @IsNotEmpty({ message: THEATER_MESSAGES.MOVIE_SHOWTIMES_IS_REQUIRED })
  movieShowtimes: string;

  @ApiProperty({
    example: 100000,
    description: 'Ticket price for the showtime',
  })
  @Min(1000, { message: THEATER_MESSAGES.MIN_TICKET_PRICE })
  @Transform(({ value }) => parseInt(value, 10))
  @IsInt({ message: THEATER_MESSAGES.TICKET_PRICE_IS_REQUIRED })
  @IsNotEmpty({ message: THEATER_MESSAGES.TICKET_PRICE_IS_REQUIRED })
  ticketPrice: number;
}
