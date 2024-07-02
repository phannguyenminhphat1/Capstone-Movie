import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsNotEmpty, IsString } from 'class-validator';
import { COMMENTS_MESSAGES, THEATER_MESSAGES } from 'src/constants/messages';

export class CreateCommentsDto {
  @ApiProperty()
  @IsInt({ message: THEATER_MESSAGES.MOVIE_ID_MUST_BE_A_NUMBER })
  @IsNotEmpty({ message: THEATER_MESSAGES.MOVIE_ID_IS_REQUIRED })
  movieId: number;

  @ApiProperty()
  @IsString({ message: COMMENTS_MESSAGES.CONTENT_MUST_BE_A_STRING })
  @IsNotEmpty({ message: COMMENTS_MESSAGES.COMMENT_IS_REQUIRED })
  content: string;
}
