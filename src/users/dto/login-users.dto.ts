import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';
import { USERS_MESSAGES } from 'src/constants/messages';

export class LoginUsersDto {
  @ApiProperty()
  @IsString({ message: USERS_MESSAGES.ACCOUNT_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.ACCOUNT_NAME_IS_REQUIRED })
  account: string;

  @ApiProperty()
  @IsString({ message: USERS_MESSAGES.PASSWORD_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.PASSWORD_IS_REQUIRED })
  password: string;
}
