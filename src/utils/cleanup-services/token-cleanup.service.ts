import { Injectable } from '@nestjs/common';
import { Cron } from '@nestjs/schedule';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class TokenCleanupService {
  constructor(private prisma: PrismaService) {}

  @Cron('0 0 * * *')
  async handleCleanup() {
    const currentDate = new Date();

    await this.prisma.refresh_token.deleteMany({
      where: {
        ngay_het_han: {
          lt: currentDate,
        },
      },
    });

    console.log('Deleted expired refresh tokens');
  }
}
