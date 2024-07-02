import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, IsString } from 'class-validator';
import { USERS_MESSAGES } from 'src/constants/messages';

export class ForgotPasswordUsersDto {
  @ApiProperty()
  @IsEmail({}, { message: USERS_MESSAGES.INVALID_EMAIL_FORMAT })
  @IsString({ message: USERS_MESSAGES.EMAIL_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.EMAIL_IS_REQUIRED })
  email: string;
}
