import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsInt, IsOptional, IsString } from 'class-validator';
import { USERS_MESSAGES } from 'src/constants/messages';

export class PaginationUsersDto {
  @ApiProperty({ default: 1, description: 'Page number', required: false })
  @Transform(({ value }) => Number(value))
  @IsOptional()
  @IsInt({
    message: USERS_MESSAGES.PAGE_MUST_BE_A_NUMBER,
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
    message: USERS_MESSAGES.LIMIT_MUST_BE_A_NUMBER,
  })
  limit: number;

  @ApiProperty({
    default: '',
    description: 'Search by name,email,phone',
    required: false,
  })
  @IsOptional()
  @IsString({
    message: USERS_MESSAGES.SEARCH_KEY_MUST_BE_A_STRING,
  })
  searchKey: string;
}
