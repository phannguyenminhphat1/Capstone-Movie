import { Optional } from '@nestjs/common';
import { Transform } from 'class-transformer';
import {
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsOptional,
  IsPhoneNumber,
  IsString,
  IsStrongPassword,
  Length,
  Matches,
} from 'class-validator';
import { UserRoleEnum } from 'src/constants/enum';
import { USERS_MESSAGES } from 'src/constants/messages';
import { REGEX_AVATAR } from 'src/constants/regexs';

export class UpdateUsersDto {
  @Transform(({ value }) => value?.trim())
  @IsOptional()
  @IsEmail({}, { message: USERS_MESSAGES.INVALID_EMAIL_FORMAT })
  @IsNotEmpty({ message: USERS_MESSAGES.EMAIL_IS_REQUIRED })
  email?: string;

  @Transform(({ value }) => value?.trim())
  @IsOptional()
  @IsStrongPassword(
    { minLength: 4, minNumbers: 1, minUppercase: 1, minSymbols: 1 },
    { message: USERS_MESSAGES.PASSWORD_MUST_BE_STRONG },
  )
  @Length(4, 16, { message: USERS_MESSAGES.PASSWORD_LENGTH })
  @IsNotEmpty({ message: USERS_MESSAGES.PASSWORD_IS_REQUIRED })
  password?: string;

  @Transform(({ value }) => value?.trim())
  @IsOptional()
  @Length(2, 16, { message: USERS_MESSAGES.NAME_LENGTH_MUST_BE_FROM_2_TO_100 })
  @IsString({ message: USERS_MESSAGES.NAME_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.NAME_IS_REQUIRED })
  name?: string;

  @Transform(({ value }) => value?.trim())
  @IsOptional()
  @IsPhoneNumber('VN', { message: USERS_MESSAGES.PHONE_IS_NOT_VALID })
  @IsNotEmpty({ message: USERS_MESSAGES.PHONE_IS_REQUIRED })
  phone?: string;

  @IsOptional()
  @IsEnum(UserRoleEnum, { message: USERS_MESSAGES.USER_ROLE_IS_INVALID })
  @IsNotEmpty({ message: USERS_MESSAGES.USER_ROLE_IS_REQUIRED })
  role?: UserRoleEnum;
}
