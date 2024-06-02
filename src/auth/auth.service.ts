import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { JwtPayload } from 'src/models/jwt-payload.interface';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
    private config: ConfigService,
  ) {}

  signToken({ payload }: { payload: object }): string {
    return this.jwtService.sign(
      { data: { payload } },
      {
        algorithm: 'HS256',
        expiresIn: this.config.get('TOKEN_EXPIRES_DATE'),
        secret: this.config.get('SECRET_KEY'),
      },
    );
  }

  verifyToken(token: string): JwtPayload {
    return this.jwtService.verify(token);
  }

  decodeToken(token: string): JwtPayload {
    return this.jwtService.decode(token);
  }

  extractTokenFromHeader(authorization: string): string {
    if (!authorization) {
      throw new HttpException(
        'Authorization header is missing',
        HttpStatus.UNAUTHORIZED,
      );
    }
    if (!authorization.startsWith('Bearer ')) {
      throw new HttpException(
        'Invalid authorization header format',
        HttpStatus.UNAUTHORIZED,
      );
    }
    return authorization.split(' ')[1];
  }
}
