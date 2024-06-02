import { HttpException, HttpStatus } from '@nestjs/common';
import { USERS_MESSAGES } from 'src/constants/messages';

export class UnauthorizedException extends HttpException {
  constructor() {
    super(USERS_MESSAGES.UNAUTHORIZED, HttpStatus.UNAUTHORIZED);
  }
}
