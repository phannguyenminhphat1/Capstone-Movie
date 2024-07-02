import { Module } from '@nestjs/common';
import { TheatersService } from './theaters.service';
import { TheatersController } from './theaters.controller';
import { AuthModule } from 'src/auth/auth.module';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [TheatersController],
  providers: [TheatersService, PrismaService],
  imports: [AuthModule],
})
export class TheatersModule {}
