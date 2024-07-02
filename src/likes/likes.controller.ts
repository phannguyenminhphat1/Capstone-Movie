import { Controller, Post, Query, Req, UseGuards } from '@nestjs/common';
import { LikesService } from './likes.service';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { Request } from 'express';

@ApiTags('Likes')
@Controller('api/likes')
export class LikesController {
  constructor(private readonly likesService: LikesService) {}

  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'))
  @Post()
  likeAndUnlike(
    @Query('movieId') movieId: string,
    @Req() req: Request,
  ): Promise<object> {
    return this.likesService.likeAndUnlike(Number(movieId), req);
  }
}
