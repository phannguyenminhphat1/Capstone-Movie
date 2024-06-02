import { Transform } from 'class-transformer';
import {
  IsEmail,
  IsNotEmpty,
  IsPhoneNumber,
  IsString,
  IsStrongPassword,
  Length,
} from 'class-validator';
import { USERS_MESSAGES } from 'src/constants/messages';

export class RegisterUsersDto {
  @Transform(({ value }) => value.trim())
  @Length(4, 20, { message: USERS_MESSAGES.ACCOUNT_NAME_LENGTH })
  @IsNotEmpty({ message: USERS_MESSAGES.ACCOUNT_NAME_IS_REQUIRED })
  account: string;

  @Transform(({ value }) => value.trim())
  @IsEmail({}, { message: USERS_MESSAGES.INVALID_EMAIL_FORMAT })
  @IsNotEmpty({ message: USERS_MESSAGES.EMAIL_IS_REQUIRED })
  email: string;

  @Transform(({ value }) => value.trim())
  @IsStrongPassword(
    { minLength: 4, minNumbers: 1, minUppercase: 1, minSymbols: 1 },
    { message: USERS_MESSAGES.PASSWORD_MUST_BE_STRONG },
  )
  @Length(4, 16, { message: USERS_MESSAGES.PASSWORD_LENGTH })
  @IsNotEmpty({ message: USERS_MESSAGES.PASSWORD_IS_REQUIRED })
  password: string;

  @Transform(({ value }) => value.trim())
  @Length(2, 16, { message: USERS_MESSAGES.NAME_LENGTH_MUST_BE_FROM_2_TO_100 })
  @IsString({ message: USERS_MESSAGES.NAME_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.NAME_IS_REQUIRED })
  name: string;

  @Transform(({ value }) => value.trim())
  @IsPhoneNumber('VN', { message: USERS_MESSAGES.PHONE_IS_NOT_VALID })
  @IsNotEmpty({ message: USERS_MESSAGES.PHONE_IS_REQUIRED })
  phone: string;
}
