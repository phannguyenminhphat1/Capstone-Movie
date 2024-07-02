import { UserRoleEnum } from 'src/constants/enum';

export interface TokenPayload {
  tai_khoan: string;
  email: string;
  ma_loai_nguoi_dung: UserRoleEnum;
  iat?: number;
  exp?: number;
}
