import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  InternalServerErrorException,
} from '@nestjs/common';
import { Request, Response } from 'express';
import { COMMON_MESSAGES } from 'src/constants/messages';

@Catch(InternalServerErrorException)
export class HttpInternalExceptionFilter implements ExceptionFilter {
  catch(exception: InternalServerErrorException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception.getStatus();

    response.status(status).json({
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: request.url,
      message: COMMON_MESSAGES.INTERNAL_SERVER_ERROR,
    });
  }
}
