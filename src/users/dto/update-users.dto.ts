import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import {
  IsBoolean,
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsOptional,
  IsPhoneNumber,
  IsString,
  IsStrongPassword,
  Length,
} from 'class-validator';
import { UserRoleEnum } from 'src/constants/enum';
import { USERS_MESSAGES } from 'src/constants/messages';

export class UpdateUsersDto {
  @ApiProperty({ required: false })
  @Transform(({ value }) => value?.trim())
  @IsOptional()
  @IsEmail({}, { message: USERS_MESSAGES.INVALID_EMAIL_FORMAT })
  @IsString({ message: USERS_MESSAGES.EMAIL_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.EMAIL_IS_REQUIRED })
  email: string;

  @ApiProperty({ required: false })
  @Transform(({ value }) => value?.trim())
  @IsOptional()
  @IsStrongPassword(
    { minLength: 4, minNumbers: 1, minUppercase: 1, minSymbols: 1 },
    { message: USERS_MESSAGES.PASSWORD_MUST_BE_STRONG },
  )
  @Length(4, 25, { message: USERS_MESSAGES.PASSWORD_LENGTH })
  @IsString({ message: USERS_MESSAGES.PASSWORD_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.PASSWORD_IS_REQUIRED })
  password: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @Length(2, 100, { message: USERS_MESSAGES.NAME_LENGTH_MUST_BE_FROM_2_TO_100 })
  @IsString({ message: USERS_MESSAGES.NAME_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.NAME_IS_REQUIRED })
  name: string;

  @ApiProperty({ required: false })
  @Transform(({ value }) => value?.trim())
  @IsOptional()
  @IsPhoneNumber('VN', { message: USERS_MESSAGES.PHONE_IS_NOT_VALID })
  @IsString({ message: USERS_MESSAGES.PHONE_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.PHONE_IS_REQUIRED })
  phone: string;

  @ApiProperty({
    enum: UserRoleEnum,
    default: UserRoleEnum.USER,
    required: false,
  })
  @IsOptional()
  @IsEnum(UserRoleEnum, { message: USERS_MESSAGES.USER_ROLE_IS_INVALID })
  @IsNotEmpty({ message: USERS_MESSAGES.USER_ROLE_IS_REQUIRED })
  role: UserRoleEnum;

  @ApiProperty({
    enum: [true, false],
    required: false,
    default: false,
  })
  @Transform(({ obj, key }) => {
    return obj[key] === 'true' ? true : obj[key] === 'false' ? false : obj[key];
  })
  @IsOptional()
  @IsBoolean({
    message: USERS_MESSAGES.DELETED_IS_INVALID,
  })
  deleted: boolean;
}
