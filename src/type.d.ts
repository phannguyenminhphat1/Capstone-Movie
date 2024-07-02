import { TokenPayload } from './models/TokenPayload';
import * as express from 'express';

declare global {
  namespace Express {
    interface Request {
      decode_access_token?: TokenPayload;
      user?: TokenPayload;
      tempAccount?: string;
    }
  }
}
