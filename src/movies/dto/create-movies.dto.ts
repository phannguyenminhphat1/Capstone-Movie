import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import {
  IsBoolean,
  IsDateString,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  Length,
  Max,
  Min,
} from 'class-validator';
import { MOVIES_MESSAGES, USERS_MESSAGES } from 'src/constants/messages';

export class CreateMoviesDto {
  @ApiProperty()
  @Length(2, 100, { message: USERS_MESSAGES.NAME_LENGTH_MUST_BE_FROM_2_TO_100 })
  @IsString({ message: USERS_MESSAGES.NAME_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.NAME_IS_REQUIRED })
  name: string;

  @ApiProperty()
  @Transform(({ value }) => value.trim())
  @IsString({ message: MOVIES_MESSAGES.TRAILER_MUST_BE_A_STRING })
  @IsNotEmpty({ message: MOVIES_MESSAGES.TRAILER_IS_REQUIRED })
  trailer: string;

  @ApiProperty()
  @Length(5, 150, {
    message: MOVIES_MESSAGES.DESC_LENGTH_MUST_BE_FROM_5_TO_150,
  })
  @IsString({ message: MOVIES_MESSAGES.DESC_MUST_BE_A_STRING })
  @IsNotEmpty({ message: MOVIES_MESSAGES.DESC_IS_REQUIRED })
  desc: string;

  @ApiProperty({
    example: '2024-02-03',
    description: 'Release date of the movie',
  })
  @IsDateString({}, { message: MOVIES_MESSAGES.RELEASE_DATE_MUST_BE_A_DATE })
  @IsNotEmpty({ message: MOVIES_MESSAGES.RELEASE_DATE_IS_REQUIRED })
  releaseDate: string;

  @ApiProperty({ example: 3, default: 0, description: 'Rating of the movie' })
  @Transform(({ value }) => parseInt(value, 10))
  @Min(0, { message: MOVIES_MESSAGES.RATE_LENGTH_MUST_BE_FROM_0_TO_5 })
  @Max(5, { message: MOVIES_MESSAGES.RATE_LENGTH_MUST_BE_FROM_0_TO_5 })
  @IsInt({ message: MOVIES_MESSAGES.RATE_MUST_BE_A_NUMBER })
  rate: number;

  @ApiProperty({
    enum: [true, false],
    default: false,
  })
  @Transform(({ obj, key }) => {
    return obj[key] === 'true' ? true : obj[key] === 'false' ? false : obj[key];
  })
  @IsBoolean({
    message: MOVIES_MESSAGES.HOT_IS_INVALID,
  })
  hot: boolean;

  @ApiProperty({
    enum: [true, false],
    default: false,
  })
  @Transform(({ obj, key }) => {
    return obj[key] === 'true' ? true : obj[key] === 'false' ? false : obj[key];
  })
  @IsBoolean({
    message: MOVIES_MESSAGES.COMMING_SOON_IS_INVALID,
  })
  commingSoon: boolean;

  @ApiProperty({
    enum: [true, false],
    default: false,
  })
  @Transform(({ obj, key }) => {
    return obj[key] === 'true' ? true : obj[key] === 'false' ? false : obj[key];
  })
  @IsBoolean({
    message: MOVIES_MESSAGES.SHOWING_NOW_IS_INVALID,
  })
  showingNow: boolean;

  @ApiProperty({ type: 'string', format: 'binary' })
  image: any;
}
