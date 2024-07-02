import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { AuthModule } from 'src/auth/auth.module';
import { MailService } from 'src/utils/mail';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [UsersController],
  providers: [UsersService, MailService, PrismaService],
  imports: [AuthModule],
})
export class UsersModule {}
