import { ApiProperty } from '@nestjs/swagger';
import {
  IsNotEmpty,
  IsString,
  IsStrongPassword,
  Length,
} from 'class-validator';
import { USERS_MESSAGES } from 'src/constants/messages';

export class ResetPasswordUsersDto {
  @ApiProperty()
  @IsStrongPassword(
    { minLength: 4, minNumbers: 1, minUppercase: 1, minSymbols: 1 },
    { message: USERS_MESSAGES.PASSWORD_MUST_BE_STRONG },
  )
  @Length(4, 25, { message: USERS_MESSAGES.PASSWORD_LENGTH })
  @IsString({ message: USERS_MESSAGES.PASSWORD_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.PASSWORD_IS_REQUIRED })
  password: string;
}
