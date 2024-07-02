import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';
import { USERS_MESSAGES } from 'src/constants/messages';

export class RefreshTokenUsersDto {
  @ApiProperty()
  @IsString({ message: USERS_MESSAGES.REFRESH_TOKEN_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.REFRESH_TOKEN_IS_REQUIRED })
  refreshToken: string;
}
