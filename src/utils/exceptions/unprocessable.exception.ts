import { HttpException, HttpStatus } from '@nestjs/common';
import { USERS_MESSAGES } from 'src/constants/messages';

export class UnprocessableEntityException extends HttpException {
  constructor(message: string) {
    super(message, HttpStatus.UNPROCESSABLE_ENTITY);
  }
}
