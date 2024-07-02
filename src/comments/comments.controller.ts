import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { CommentsService } from './comments.service';
import { ApiBearerAuth, ApiQuery, ApiTags } from '@nestjs/swagger';
import { CreateCommentsDto } from './dto/create-comments.dto';
import { AuthGuard } from '@nestjs/passport';
import { Request } from 'express';
import { RolesGuard } from 'src/guards/roles/roles.guard';

@ApiTags('Comments')
@Controller('api/comments')
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}

  @Get('get-comments')
  getComments(): Promise<object> {
    return this.commentsService.getComments();
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'))
  @Post('post-comment')
  comment(
    @Body() createCommentsDto: CreateCommentsDto,
    @Req() req: Request,
  ): Promise<object> {
    return this.commentsService.comment(createCommentsDto, req);
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'))
  @Delete('delete-comment-me')
  deleteCommentMe(
    @Req() req: Request,
    @Query('commentId') commentId: string,
    @Query('movieId') movieId: string,
  ): Promise<object> {
    return this.commentsService.deleteCommentMe(
      req,
      Number(commentId),
      Number(movieId),
    );
  }

  // ROLE ADMIN
  @ApiBearerAuth()
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Delete('delete-comment')
  deleteComment(@Query('commentId') commentId: string): Promise<object> {
    return this.commentsService.deleteComment(Number(commentId));
  }
}
