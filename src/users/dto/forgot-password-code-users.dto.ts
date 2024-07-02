import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';
import { USERS_MESSAGES } from 'src/constants/messages';

export class ForgotPasswordCodeUsersDto {
  @ApiProperty()
  @IsString({ message: USERS_MESSAGES.FORGOT_CODE_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.FORGOT_CODE_IS_REQUIRED })
  codeId: string;
}
