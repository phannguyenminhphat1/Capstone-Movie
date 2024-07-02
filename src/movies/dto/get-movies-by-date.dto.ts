// get-movies-by-date.dto.ts

import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsDateString, IsInt, IsOptional, IsString } from 'class-validator';
import { MOVIES_MESSAGES } from 'src/constants/messages';

export class GetMoviesByDateDto {
  @ApiProperty({ default: 1, description: 'Page number', required: false })
  @Transform(({ value }) => Number(value))
  @IsOptional()
  @IsInt({
    message: MOVIES_MESSAGES.PAGE_MUST_BE_A_NUMBER,
  })
  page: number;

  @ApiProperty({
    default: 6,
    description: 'Number of items per page',
    required: false,
  })
  @Transform(({ value }) => Number(value))
  @IsOptional()
  @IsInt({
    message: MOVIES_MESSAGES.LIMIT_MUST_BE_A_NUMBER,
  })
  limit: number;

  @ApiProperty({ default: '', description: 'Movie name', required: false })
  @IsOptional()
  @IsString()
  name: string;

  @ApiProperty({
    example: '2024-02-02',
    description: 'Start date of the range',
    required: false,
  })
  @IsOptional()
  @IsDateString()
  startDate: string;

  @ApiProperty({
    example: '2024-03-03',
    description: 'End date of the range',
    required: false,
  })
  @IsOptional()
  @IsDateString()
  endDate: string;
}
