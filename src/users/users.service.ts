import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { AuthService } from 'src/auth/auth.service';
import { PrismaService } from 'src/prisma/prisma.service';
import { LoginUsersDto } from './dto/login-users.dto';
import { USERS_MESSAGES } from 'src/constants/messages';
import { RegisterUsersDto } from './dto/register-users.dto';
import { ConfigService } from '@nestjs/config';
import { UserRoleEnum } from 'src/constants/enum';
import { PaginationUsers } from './dto/pagination-users.dto';
import { NotFoundException } from 'src/utils/exceptions/not-found.exception';
import { UnauthorizedException } from 'src/utils/exceptions/unauthorized.exception';
import * as _ from 'lodash';
import * as fs from 'fs';
import * as bcrypt from 'bcrypt';
import * as nodemailer from 'nodemailer';
import * as compress_images from 'compress-images';
import { CreateUsersDto } from './dto/create-users.dto';
import { UpdateUsersDto } from './dto/update-users.dto';
import { nguoi_dung } from '@prisma/client';
import cloudinary from 'src/utils/cloudinary';
import { UnprocessableEntityException } from 'src/utils/exceptions/unprocessable.exception';

@Injectable()
export class UsersService {
  constructor(
    private prisma: PrismaService,
    private authService: AuthService,
    private config: ConfigService,
  ) {}

  private async findCurrentUser(authorization: string): Promise<nguoi_dung> {
    const token = this.authService.extractTokenFromHeader(authorization);
    const { data } = this.authService.decodeToken(token);
    const { payload } = data;
    if (!payload.tai_khoan) {
      throw new UnauthorizedException();
    }

    return payload;
  }

  private async compressImage(input: string, output: string): Promise<any> {
    return new Promise((resolve, reject) => {
      compress_images(
        input,
        output,
        { compress_force: false, statistic: true, autoupdate: true },
        false,
        { jpg: { engine: 'mozjpeg', command: ['-quality', '20'] } },
        { png: { engine: 'pngquant', command: ['--quality=20-50', '-o'] } },
        { svg: { engine: 'svgo', command: '--multipass' } },
        {
          gif: {
            engine: 'gifsicle',
            command: ['--colors', '64', '--use-col=web'],
          },
        },
        (error, completed, statistic) => {
          if (error) {
            reject(error);
          } else {
            resolve(completed);
          }
        },
      );
    });
  }

  async register(registerUsersDto: RegisterUsersDto): Promise<object> {
    const { account, email, password, name, phone } = registerUsersDto;
    const checkAccount = await this.prisma.nguoi_dung.findUnique({
      where: { tai_khoan: account },
    });
    if (checkAccount) {
      throw new NotFoundException(USERS_MESSAGES.ACCOUNT_IS_ALREADY_EXIST);
    }
    const checkEmail = await this.prisma.nguoi_dung.findFirst({
      where: { email },
    });
    if (checkEmail) {
      throw new NotFoundException(USERS_MESSAGES.EMAIL_IS_ALREADY_EXIST);
    }

    const newUser = {
      tai_khoan: account,
      email,
      mat_khau: bcrypt.hashSync(password, 10),
      ho_ten: name,
      so_dt: phone,
      anh_dai_dien: this.config.get('CLOUNDINARY_DEFAULT_AVATAR'),
      ma_loai_nguoi_dung: UserRoleEnum.USER,
    };
    const result = await this.prisma.nguoi_dung.create({ data: newUser });
    const payload = _.omit(result, ['mat_khau']);

    const access_token = this.authService.signToken({
      payload,
    });

    return {
      message: USERS_MESSAGES.REGISTER_SUCCESS,
      access_token,
      result,
    };
  }

  async login(loginUsersDto: LoginUsersDto): Promise<object> {
    const { account, password } = loginUsersDto;
    const user = await this.prisma.nguoi_dung.findFirst({
      where: { tai_khoan: account },
    });
    if (!user || !bcrypt.compareSync(password, user.mat_khau)) {
      throw new NotFoundException(
        USERS_MESSAGES.ACCOUNT_OR_PASSWORD_IS_INCORRECT,
      );
    }
    const payload = _.omit(user, ['mat_khau']);
    const access_token = this.authService.signToken({
      payload,
    });
    return {
      message: USERS_MESSAGES.LOGIN_SUCCESS,
      access_token,
    };
  }

  async getUserRoles(): Promise<object> {
    const result = await this.prisma.loai_nguoi_dung.findMany();
    return {
      message: USERS_MESSAGES.GET_USER_ROLES_SUCCES,
      result,
    };
  }

  async getUsers(): Promise<object> {
    const result = await this.prisma.nguoi_dung.findMany();
    return {
      message: USERS_MESSAGES.GET_ALL_USERS_SUCCESS,
      result,
    };
  }

  async getUsersPagination(paginationUsers: PaginationUsers): Promise<object> {
    const { page = 1, limit = 5, searchKey } = paginationUsers;
    const searchCondition = searchKey
      ? {
          OR: [
            {
              tai_khoan: {
                contains: searchKey,
              },
              email: {
                contains: searchKey,
              },
            },
            {
              ho_ten: {
                contains: searchKey,
              },
            },
          ],
        }
      : {};

    const users = await this.prisma.nguoi_dung.findMany({
      skip: (page - 1) * limit,
      take: limit,
      where: searchCondition,
    });

    const total = await this.prisma.nguoi_dung.count({
      where: searchCondition,
    });

    return {
      message: USERS_MESSAGES.GET_ALL_USERS_SUCCESS,
      data: users,
      count: users.length,
      total,
      page,
      totalPages: Math.ceil(total / limit),
    };
  }

  async searchUsers(searchKey?: string): Promise<object> {
    const result = await this.prisma.nguoi_dung.findMany({
      where: searchKey
        ? {
            OR: [
              { tai_khoan: { contains: searchKey } },
              { email: { contains: searchKey } },
              { ho_ten: { contains: searchKey } },
              { so_dt: { contains: searchKey } },
            ],
          }
        : {},
    });
    if (result.length > 0) {
      return {
        message: USERS_MESSAGES.SEARCH_USERS_SUCCESS,
        result,
      };
    } else {
      return {
        message: USERS_MESSAGES.USERS_NOT_FOUND,
        result,
      };
    }
  }

  async getMeInfo(authorization: string): Promise<object> {
    const payload = await this.findCurrentUser(authorization);
    const { tai_khoan } = payload;
    const user = await this.prisma.nguoi_dung.findUnique({
      where: { tai_khoan },
      include: {
        loai_nguoi_dung: true,
        dat_ve: true,
      },
    });
    if (!user) {
      throw new NotFoundException(USERS_MESSAGES.USERS_NOT_FOUND);
    }

    return {
      message: USERS_MESSAGES.GET_ME_INFO_SUCCESS,
      user,
    };
  }

  async updateMe(
    updateUsersDto: UpdateUsersDto,
    file: any,
    authorization: string,
  ): Promise<object> {
    const { email, name, password, phone } = updateUsersDto;
    const payload = await this.findCurrentUser(authorization);
    if (!file) {
      throw new UnprocessableEntityException(USERS_MESSAGES.AVATAR_IS_REQUIRED);
    }
    // const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'svg'];
    // const extension = file.originalname.split('.').pop().toLowerCase();
    // if (!imageExtensions.includes(extension)) {
    //   throw new UnprocessableEntityException(USERS_MESSAGES.AVATAR_IS_VALID);
    // }

    // const checkEmail = await this.prisma.nguoi_dung.findFirst({
    //   where: { email },
    // });
    // if (checkEmail){
    //   throw new NotFoundException(USERS_MESSAGES.EMAIL_IS_ALREADY_EXIST);
    // }
    let input = process.cwd() + '/public/img/' + file.filename;
    let output = process.cwd() + '/public/imgOptimize/';
    const result = await this.compressImage(input, output);
    if (!result) {
      throw new Error('Lỗi năm chăm');
    }
    const cloudinaryResult = await cloudinary.uploader.upload(
      `${output}${file.filename}`,
    );

    const userUpdate = {
      email,
      mat_khau: bcrypt.hashSync(password, 10),
      ho_ten: name,
      so_dt: phone,
      anh_dai_dien: cloudinaryResult.url,
    };
    await this.prisma.nguoi_dung.update({
      where: {
        tai_khoan: payload.tai_khoan,
      },
      data: userUpdate,
    });
    fs.unlink(`${output}${file.filename}`, (err) => {
      if (err) {
        console.error('Error while deleting file: ', err);
      } else {
        console.log('File deleted successfully');
      }
    });
    fs.unlink(input, (err) => {
      if (err) {
        console.error('Error while deleting file: ', err);
      } else {
        console.log('File deleted successfully');
      }
    });
    return {
      message: USERS_MESSAGES.UPDATE_ME_SUCCESS,
    };
  }

  // LÀM CHƯA XONG.
  async sendMail() {
    let configMail = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: 'phannguyenminhphat1@gmail.com',
        pass: 'fzhexxynmvgsljkn',
      },
    });
    let infoMail = {
      from: this.config.get('EMAIL'),
      to: 'phannguyenminhphat@gmail.com',
      subject: 'THƯ',
      text: 'HELLO',
    };
    return configMail.sendMail(infoMail, (err, info) => err);
  }
  // ROLE ADMIN
  async getUserInfo(account: string): Promise<object> {
    const user = await this.prisma.nguoi_dung.findUnique({
      where: { tai_khoan: account },
      include: {
        loai_nguoi_dung: true,
        dat_ve: true,
      },
    });
    if (!user) {
      throw new NotFoundException(USERS_MESSAGES.USERS_NOT_FOUND);
    }
    return {
      message: USERS_MESSAGES.GET_USER_INFO_SUCCESS,
      user,
    };
  }

  async createUser(createUsersDto: CreateUsersDto): Promise<string> {
    const { account, email, password, name, phone, role } = createUsersDto;
    const checkAccount = await this.prisma.nguoi_dung.findUnique({
      where: { tai_khoan: account },
    });
    if (checkAccount) {
      throw new NotFoundException(USERS_MESSAGES.ACCOUNT_IS_ALREADY_EXIST);
    }
    const checkEmail = await this.prisma.nguoi_dung.findFirst({
      where: { email },
    });
    if (checkEmail) {
      throw new NotFoundException(USERS_MESSAGES.EMAIL_IS_ALREADY_EXIST);
    }

    const newUser = {
      tai_khoan: account,
      email,
      mat_khau: bcrypt.hashSync(password, 10),
      ho_ten: name,
      so_dt: phone,
      anh_dai_dien: this.config.get('CLOUNDINARY_DEFAULT_AVATAR'),
      ma_loai_nguoi_dung: role,
    };
    await this.prisma.nguoi_dung.create({ data: newUser });

    return USERS_MESSAGES.CREATE_NEW_USER_SUCCESS;
  }
}
