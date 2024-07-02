import { Module } from '@nestjs/common';
import { TicketsService } from './tickets.service';
import { TicketsController } from './tickets.controller';
import { AuthModule } from 'src/auth/auth.module';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [TicketsController],
  providers: [TicketsService, PrismaService],
  imports: [AuthModule],
})
export class TicketsModule {}
