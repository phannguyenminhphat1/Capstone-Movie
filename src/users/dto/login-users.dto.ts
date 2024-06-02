import { Transform } from 'class-transformer';
import { IsEmail, IsNotEmpty, IsStrongPassword, Length } from 'class-validator';
import { USERS_MESSAGES } from 'src/constants/messages';

export class LoginUsersDto {
  @Transform(({ value }) => value.trim())
  @IsNotEmpty({ message: USERS_MESSAGES.ACCOUNT_NAME_IS_REQUIRED })
  account: string;

  @Transform(({ value }) => value.trim())
  @IsNotEmpty({ message: USERS_MESSAGES.PASSWORD_IS_REQUIRED })
  password: string;
}
