interface ShowtimeTickets {
  movieInfo: {
    ma_lich_chieu: number;
    ten_cum_rap: string;
    dia_chi: string;
    ten_phim: string;
    hinh_anh: string;
    ngay_chieu: string;
    gio_chieu: string;
  };
  seats: {
    ma_ghe: number;
    ten_ghe: string;
    ma_rap: number;
    loai_ghe: string;
    gia_ve: string;
    da_dat: boolean;
    tai_khoan_da_dat: string | null;
  }[];
}
