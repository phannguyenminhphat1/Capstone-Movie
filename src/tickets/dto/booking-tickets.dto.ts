import { ApiProperty } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import {
  ArrayMinSize,
  IsArray,
  IsInt,
  IsNotEmpty,
  ValidateNested,
} from 'class-validator';
import { TICKETS_MESSAGES } from 'src/constants/messages';

export class SeatDto {
  @ApiProperty()
  @IsInt({ message: TICKETS_MESSAGES.SEAT_ID_MUST_BE_A_NUMBER })
  @IsNotEmpty({ message: TICKETS_MESSAGES.SEAT_ID_IS_REQUIRED })
  seatId: number;
}

export class BookingTicketsDto {
  @ApiProperty()
  @IsInt({ message: TICKETS_MESSAGES.SHOWTIME_ID_MUST_BE_A_NUMBER })
  @IsNotEmpty({ message: TICKETS_MESSAGES.SHOWTIME_ID_IS_REQUIRED })
  showtimeId: number;

  @ApiProperty({
    type: [SeatDto],
    example: [{ seatId: 1 }, { seatId: 2 }],
  })
  @IsArray({ message: TICKETS_MESSAGES.SEATS_MUST_BE_AN_ARRAY })
  @ArrayMinSize(1, { message: TICKETS_MESSAGES.SEATS_LIST_IS_REQUIRED })
  @ValidateNested({ each: true })
  @IsNotEmpty({ message: TICKETS_MESSAGES.SEATS_LIST_IS_REQUIRED })
  @Type(() => SeatDto)
  seats: SeatDto[];
}
