import { BadRequestException, Injectable } from '@nestjs/common';
import { TICKETS_MESSAGES, USERS_MESSAGES } from 'src/constants/messages';
import { NotFoundException } from 'src/utils/exceptions/not-found.exception';
import { BookingTicketsDto } from './dto/booking-tickets.dto';
import { Request } from 'express';
import { dat_ve, ghe, lich_chieu, nguoi_dung } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class TicketsService {
  constructor(private prisma: PrismaService) {}

  async getShowtimeTickets(showtimeId: number): Promise<ShowtimeTickets> {
    if (!showtimeId) {
      throw new BadRequestException({
        message: TICKETS_MESSAGES.SHOWTIME_ID_IS_REQUIRED,
      });
    }
    const content = await this.prisma.lich_chieu.findUnique({
      where: {
        ma_lich_chieu: showtimeId,
      },
      include: {
        phim: true,
        rap_phim: {
          include: {
            ghe: true,
            cum_rap: true,
          },
        },
      },
    });

    if (!content) {
      throw new NotFoundException(TICKETS_MESSAGES.SHOWTIME_NOT_FOUND);
    }
    const bookedSeats: dat_ve[] = await this.prisma.dat_ve.findMany({
      where: { ma_lich_chieu: showtimeId },
    });
    let result: ShowtimeTickets = {
      movieInfo: {
        ma_lich_chieu: content.ma_lich_chieu,
        ten_cum_rap: content.rap_phim.cum_rap.ten_cum_rap,
        dia_chi: content.rap_phim.cum_rap.dia_chi,
        ten_phim: content.phim.ten_phim,
        hinh_anh: content.phim.hinh_anh,
        ngay_chieu: new Date(content.ngay_gio_chieu).toLocaleDateString(
          'vi-VN',
        ),
        gio_chieu: new Date(content.ngay_gio_chieu).toLocaleTimeString(
          'vi-VN',
          { hour: '2-digit', minute: '2-digit' },
        ),
      },
      seats: content.rap_phim.ghe.map((item, index) => {
        const bookedSeat = bookedSeats.find(
          (seat) => seat.ma_ghe === item.ma_ghe,
        );
        return {
          ma_ghe: item.ma_ghe,
          ten_ghe: item.ten_ghe,
          ma_rap: item.ma_rap,
          loai_ghe: item.ma_loai_ghe,
          gia_ve: content.gia_ve.toLocaleString('vi-VN'),
          da_dat: !!bookedSeat,
          tai_khoan_da_dat: bookedSeat ? bookedSeat.tai_khoan : null,
        };
      }),
    };

    return result;
  }

  async bookingTickets(
    bookingTicketsDto: BookingTicketsDto,
    req: Request,
  ): Promise<object> {
    const { seats, showtimeId } = bookingTicketsDto;
    const currentUser = req.user;
    const findUser: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
      where: {
        tai_khoan: currentUser.tai_khoan,
      },
    });
    if (!findUser) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }

    const findShowtime: lich_chieu = await this.prisma.lich_chieu.findUnique({
      where: {
        ma_lich_chieu: showtimeId,
      },
    });
    if (!findShowtime) {
      throw new NotFoundException(TICKETS_MESSAGES.SHOWTIME_NOT_FOUND);
    }
    const showtimeInfo = (await this.getShowtimeTickets(
      showtimeId,
    )) as ShowtimeTickets;

    for (let i = 0; i < seats.length; i++) {
      const findSeat: ghe = await this.prisma.ghe.findUnique({
        where: {
          ma_ghe: seats[i].seatId,
          ma_rap: findShowtime.ma_rap,
        },
      });
      if (!findSeat) {
        throw new NotFoundException(TICKETS_MESSAGES.SEAT_NOT_FOUND);
      }

      const matchedSeat = showtimeInfo.seats.find(
        (seat) =>
          seat.ma_ghe === findSeat.ma_ghe && seat.ma_rap === findSeat.ma_rap,
      );
      if (!matchedSeat) {
        throw new BadRequestException({
          message: TICKETS_MESSAGES.SEAT_NOT_MATCH_SHOWTIME,
        });
      }
      if (matchedSeat.da_dat) {
        throw new BadRequestException({
          message: TICKETS_MESSAGES.SEAT_IS_ALREADY_BOOKED,
        });
      }

      await this.prisma.dat_ve.create({
        data: {
          tai_khoan: findUser.tai_khoan,
          ma_lich_chieu: showtimeId,
          ma_ghe: findSeat.ma_ghe,
        },
      });
    }

    return {
      message: TICKETS_MESSAGES.BOOKING_TICKETS_SUCCESS,
    };
  }
}
