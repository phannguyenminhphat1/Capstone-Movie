import { Module } from '@nestjs/common';
import { MoviesService } from './movies.service';
import { MoviesController } from './movies.controller';
import { AuthModule } from 'src/auth/auth.module';
import { UsersModule } from 'src/users/users.module';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [MoviesController],
  providers: [MoviesService, PrismaService],
  imports: [AuthModule, UsersModule],
})
export class MoviesModule {}
