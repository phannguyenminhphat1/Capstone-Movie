import { ApiProperty } from '@nestjs/swagger';

export class UploadImageMoviesDto {
  @ApiProperty({ type: 'string', format: 'binary' })
  image: any;
}
