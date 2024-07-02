import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsInt, IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { MOVIES_MESSAGES, USERS_MESSAGES } from 'src/constants/messages';

export class PaginationMoviesDto {
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

  @ApiProperty({
    default: '',
    description: 'Search by movies name',
    required: false,
  })
  @IsOptional()
  @IsString({
    message: USERS_MESSAGES.NAME_MUST_BE_A_STRING,
  })
  name: string;
}
