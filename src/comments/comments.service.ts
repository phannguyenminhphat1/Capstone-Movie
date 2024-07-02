import { Injectable } from '@nestjs/common';
import {
  COMMENTS_MESSAGES,
  MOVIES_MESSAGES,
  USERS_MESSAGES,
} from 'src/constants/messages';
import { CreateCommentsDto } from './dto/create-comments.dto';
import { NotFoundException } from 'src/utils/exceptions/not-found.exception';
import { Request } from 'express';
import { binh_luan } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class CommentsService {
  constructor(private prisma: PrismaService) {}

  private convertDateString(date: Date): string {
    return new Date(date).toLocaleDateString('vi-VN', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
    });
  }
  async getComments(): Promise<object> {
    const comments: binh_luan[] = await this.prisma.binh_luan.findMany();
    const result = comments.map((comment) => ({
      ...comment,
      ngay_binh_luan: this.convertDateString(comment.ngay_binh_luan),
    }));

    return {
      message: COMMENTS_MESSAGES.GET_COMMENTS_SUCCESS,
      comments: result,
    };
  }

  async comment(
    createCommentsDto: CreateCommentsDto,
    req: Request,
  ): Promise<object> {
    const { movieId, content } = createCommentsDto;
    const [currentUser, movie] = await Promise.all([
      this.prisma.nguoi_dung.findUnique({
        where: { tai_khoan: req.user.tai_khoan },
      }),
      this.prisma.phim.findUnique({
        where: {
          ma_phim: movieId,
        },
      }),
    ]);
    if (!currentUser) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    if (!movie) {
      throw new NotFoundException(MOVIES_MESSAGES.MOVIE_NOT_FOUND);
    }
    await this.prisma.binh_luan.create({
      data: {
        tai_khoan: currentUser.tai_khoan,
        ma_phim: movieId,
        noi_dung: content,
        ngay_binh_luan: new Date(),
      },
    });

    return { message: COMMENTS_MESSAGES.POST_COMMENT_SUCCESS };
  }

  async deleteCommentMe(
    req: Request,
    commentId: number,
    movieId: number,
  ): Promise<object> {
    if (!movieId) {
      throw new NotFoundException(MOVIES_MESSAGES.MOVIE_ID_IS_REQUIRED);
    }
    const [currentUser, findMovie] = await Promise.all([
      await this.prisma.nguoi_dung.findUnique({
        where: {
          tai_khoan: req.user.tai_khoan,
        },
      }),
      await this.prisma.phim.findUnique({
        where: {
          ma_phim: movieId,
        },
      }),
    ]);
    if (!currentUser) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    if (!findMovie) {
      throw new NotFoundException(MOVIES_MESSAGES.MOVIE_NOT_FOUND);
    }

    const findComment: binh_luan = await this.prisma.binh_luan.findUnique({
      where: {
        ma_binh_luan: commentId,
        ma_phim: findMovie.ma_phim,
        tai_khoan: currentUser.tai_khoan,
      },
    });
    if (!findComment) {
      throw new NotFoundException(COMMENTS_MESSAGES.COMMENT_NOT_FOUND);
    }
    await this.prisma.binh_luan.delete({
      where: {
        ma_binh_luan: findComment.ma_binh_luan,
        ma_phim: findComment.ma_phim,
        tai_khoan: findComment.tai_khoan,
      },
    });
    return {
      message: COMMENTS_MESSAGES.DELETE_COMMENT_SUCCESS,
    };
  }

  async deleteComment(commentId: number): Promise<object> {
    const findComment: binh_luan = await this.prisma.binh_luan.findUnique({
      where: { ma_binh_luan: commentId },
    });
    if (!findComment) {
      throw new NotFoundException(COMMENTS_MESSAGES.COMMENT_NOT_FOUND);
    }
    await this.prisma.binh_luan.delete({
      where: {
        ma_binh_luan: commentId,
      },
    });
    return {
      message: COMMENTS_MESSAGES.DELETE_COMMENT_SUCCESS,
    };
  }
}
