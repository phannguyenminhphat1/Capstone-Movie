import { UserRoleEnum } from 'src/constants/enum';

export interface UserUpdate {
  email?: string;
  ho_ten?: string;
  so_dt?: string;
  anh_dai_dien?: string;
  ma_loai_nguoi_dung?: UserRoleEnum;
  da_xoa?: boolean;
  mat_khau?: string;
}
