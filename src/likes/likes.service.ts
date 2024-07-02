import { BadRequestException, Injectable } from '@nestjs/common';
import { Request } from 'express';
import {
  LIKES_MESSAGES,
  MOVIES_MESSAGES,
  USERS_MESSAGES,
} from 'src/constants/messages';
import { PrismaService } from 'src/prisma.service';
import { NotFoundException } from 'src/utils/exceptions/not-found.exception';

@Injectable()
export class LikesService {
  constructor(private prisma: PrismaService) {}

  async likeAndUnlike(movieId: number, req: Request) {
    if (!movieId) {
      throw new BadRequestException({
        message: MOVIES_MESSAGES.MOVIE_ID_IS_REQUIRED,
      });
    }
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

    const findLike = await this.prisma.yeu_thich.findFirst({
      where: {
        ma_phim: movieId,
        tai_khoan: currentUser.tai_khoan,
      },
    });
    if (findLike) {
      await this.prisma.yeu_thich.delete({
        where: {
          ma_yeu_thich: findLike.ma_yeu_thich,
        },
      });
      return {
        message: LIKES_MESSAGES.UNLIKE_MOVIE_SUCCESS,
      };
    }
    await this.prisma.yeu_thich.create({
      data: {
        ma_phim: movieId,
        tai_khoan: currentUser.tai_khoan,
        ngay_tao: new Date(),
      },
    });
    return {
      message: LIKES_MESSAGES.LIKE_MOVIE_SUCCESS,
    };
  }
}
