import { ApiProperty } from '@nestjs/swagger';

export class UploadAvatarUsersDto {
  @ApiProperty({ type: 'string', format: 'binary' })
  avatar: any;
}
