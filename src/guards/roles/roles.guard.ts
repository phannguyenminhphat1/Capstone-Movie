import {
  Injectable,
  CanActivate,
  ExecutionContext,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { USERS_MESSAGES } from 'src/constants/messages';
import { TokenPayload } from 'src/models/TokenPayload';
import { ForbiddenException } from 'src/utils/exceptions/forbidden.exception';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private roles: string[]) {}
  canActivate(
    context: ExecutionContext,
  ): boolean | Promise<boolean> | Observable<boolean> {
    const { user } = context.switchToHttp().getRequest();
    const { ma_loai_nguoi_dung } = user as TokenPayload;

    if (ma_loai_nguoi_dung === 'KhachHang') {
      throw new ForbiddenException(
        USERS_MESSAGES.USER_DOES_NOT_HAVE_PERMISSIONS,
      );
    }

    return this.roles.includes(ma_loai_nguoi_dung);
  }
}
