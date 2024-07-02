import { Injectable } from '@nestjs/common';
import { JwtService, JwtSignOptions, JwtVerifyOptions } from '@nestjs/jwt';
import { TokenPayload } from 'src/models/TokenPayload';

@Injectable()
export class AuthService {
  constructor(private jwtService: JwtService) {}

  signToken({
    payload,
    options,
  }: {
    payload: object | Buffer;
    options: JwtSignOptions;
  }): string {
    return this.jwtService.sign(payload, options);
  }

  verifyToken({
    token,
    options,
  }: {
    token: string;
    options?: JwtVerifyOptions;
  }) {
    return this.jwtService.verify(token, options);
  }

  decodeToken(token: string): TokenPayload {
    return this.jwtService.decode(token) as TokenPayload;
  }
}
