import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { ConfigModule } from '@nestjs/config';
import { UsersModule } from './users/users.module';
import { JwtStrategy } from './guards/strategy/jwt.strategy';
import { MoviesModule } from './movies/movies.module';
import { TheatersModule } from './theaters/theaters.module';
import { TicketsModule } from './tickets/tickets.module';
import { CommentsModule } from './comments/comments.module';
import { LikesModule } from './likes/likes.module';
import { RefreshJwtStrategy } from './guards/strategy/refresh-jwt.strategy';
import { ScheduleModule } from '@nestjs/schedule';
import { TokenCleanupService } from './utils/cleanup-services/token-cleanup.service';
import { PrismaService } from './prisma.service';
import { FileCleanupService } from './utils/cleanup-services/files-cleanup.service';

@Module({
  imports: [
    AuthModule,
    ConfigModule.forRoot({ isGlobal: true }),
    ScheduleModule.forRoot(),
    UsersModule,
    MoviesModule,
    TheatersModule,
    TicketsModule,
    CommentsModule,
    LikesModule,
  ],
  providers: [
    JwtStrategy,
    RefreshJwtStrategy,
    PrismaService,
    TokenCleanupService,
    FileCleanupService,
  ],
})
export class AppModule {}
