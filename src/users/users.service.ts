import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
} from '@nestjs/common';
import { AuthService } from 'src/auth/auth.service';
import { LoginUsersDto } from './dto/login-users.dto';
import { REFRESH_MESSAGE, USERS_MESSAGES } from 'src/constants/messages';
import { RegisterUsersDto } from './dto/register-users.dto';
import { UserRoleEnum } from 'src/constants/enum';
import { PaginationUsersDto } from './dto/pagination-users.dto';
import { NotFoundException } from 'src/utils/exceptions/not-found.exception';
import * as _ from 'lodash';
import * as fs from 'fs';
import * as bcrypt from 'bcrypt';
import { CreateUsersDto } from './dto/create-users.dto';
import { UpdateUsersDto } from './dto/update-users.dto';
import { loai_nguoi_dung, nguoi_dung, refresh_token } from '@prisma/client';
import cloudinary from 'src/utils/cloudinary';
import { UserUpdate } from './models/users-update';
import { TokenPayload } from 'src/models/TokenPayload';
import { Request } from 'express';
import { LogoutUsersDto } from './dto/logout-users.dto';
import { UpdateMeUsersDto } from './dto/update-me-users.dto';
import { UnprocessableEntityException } from 'src/utils/exceptions/unprocessable.exception';
import { MailService } from 'src/utils/mail';
import { ForgotPasswordUsersDto } from './dto/forgot-password-users.dto';
import { ResetPasswordUsersDto } from './dto/reset-password-users.dto';
import { RefreshTokenUsersDto } from './dto/refresh-token-users.dto';
import { ForgotPasswordCodeUsersDto } from './dto/forgot-password-code-users.dto';
import { compressImage } from 'src/utils/compress-img';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class UsersService {
  private tempAccount: string;
  constructor(
    private prisma: PrismaService,
    private authService: AuthService,
    private mailService: MailService,
  ) {}

  private signAccessToken(tokenPayload: TokenPayload): string {
    const { email, ma_loai_nguoi_dung, tai_khoan } = tokenPayload;
    return this.authService.signToken({
      payload: { email, ma_loai_nguoi_dung, tai_khoan },
      options: {
        secret: process.env.ACCESS_TOKEN_SECRET_KEY,
        expiresIn: process.env.ACCESS_TOKEN_EXPIRES_DATE,
        algorithm: 'HS256',
      },
    });
  }

  private signRefreshToken(tokenPayload: TokenPayload): string {
    const { email, ma_loai_nguoi_dung, tai_khoan, exp } = tokenPayload;
    if (exp) {
      return this.authService.signToken({
        payload: { email, ma_loai_nguoi_dung, tai_khoan, exp },
        options: {
          secret: process.env.REFRESH_TOKEN_SECRET_KEY,
          algorithm: 'HS256',
        },
      });
    }
    return this.authService.signToken({
      payload: { email, ma_loai_nguoi_dung, tai_khoan },
      options: {
        secret: process.env.REFRESH_TOKEN_SECRET_KEY,
        expiresIn: process.env.REFRESH_TOKEN_EXPIRES_DATE,
        algorithm: 'HS256',
      },
    });
  }

  private signAccessTokenAndRefreshToken(tokenPayload: TokenPayload): {
    access_token: string;
    refresh_token: string;
  } {
    const { email, ma_loai_nguoi_dung, tai_khoan } = tokenPayload;
    const access_token = this.signAccessToken({
      email,
      ma_loai_nguoi_dung,
      tai_khoan,
    });
    const refresh_token = this.signRefreshToken({
      email,
      ma_loai_nguoi_dung,
      tai_khoan,
    });
    return {
      access_token,
      refresh_token,
    };
  }

  private parseBoolean(key: any): boolean {
    const parseStringKey = String(key);
    const parseBooleanKey = Boolean(JSON.parse(parseStringKey));
    return parseBooleanKey;
  }

  private generateRandomString(): string {
    let characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let randomString = '';
    for (let i = 0; i < 6; i++) {
      let randomIndex = Math.floor(Math.random() * characters.length);
      randomString += characters.charAt(randomIndex);
    }
    return randomString;
  }

  async register(registerUsersDto: RegisterUsersDto): Promise<string> {
    const { account, email, password, name, phone } = registerUsersDto;
    const checkAccount: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
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

    const newUser: nguoi_dung = {
      tai_khoan: account,
      email,
      mat_khau: bcrypt.hashSync(password, 10),
      ho_ten: name,
      so_dt: phone,
      anh_dai_dien: process.env.CLOUNDINARY_DEFAULT_AVATAR,
      ma_loai_nguoi_dung: UserRoleEnum.USER,
      da_xoa: false,
    };
    await this.prisma.nguoi_dung.create({ data: newUser });
    return USERS_MESSAGES.REGISTER_SUCCESS;
  }

  async login(loginUsersDto: LoginUsersDto): Promise<object> {
    const { account, password } = loginUsersDto;
    const user: nguoi_dung = await this.prisma.nguoi_dung.findFirst({
      where: { tai_khoan: account },
    });
    if (!user || !bcrypt.compareSync(password, user.mat_khau)) {
      throw new NotFoundException(
        USERS_MESSAGES.ACCOUNT_OR_PASSWORD_IS_INCORRECT,
      );
    }
    if (user.da_xoa === true) {
      throw new NotFoundException(USERS_MESSAGES.USER_HAS_BEEN_DELETED);
    }
    const { access_token, refresh_token } = this.signAccessTokenAndRefreshToken(
      {
        email: user.email,
        ma_loai_nguoi_dung: user.ma_loai_nguoi_dung as UserRoleEnum,
        tai_khoan: user.tai_khoan,
      },
    );
    const decode_refresh_token =
      await this.authService.decodeToken(refresh_token);

    await this.prisma.refresh_token.create({
      data: {
        ma_refresh_token: refresh_token,
        tai_khoan: user.tai_khoan,
        ngay_tao: new Date(decode_refresh_token.iat * 1000),
        ngay_het_han: new Date(decode_refresh_token.exp * 1000),
      },
    });
    return {
      message: USERS_MESSAGES.LOGIN_SUCCESS,
      access_token,
      refresh_token,
    };
  }

  async logout(logoutUsersDto: LogoutUsersDto, req: Request): Promise<string> {
    const { refreshToken } = logoutUsersDto;
    const user: TokenPayload = req.user;
    const currentUser: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
      where: {
        tai_khoan: user.tai_khoan,
      },
    });
    if (!currentUser) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    const findRefreshToken: refresh_token =
      await this.prisma.refresh_token.findUnique({
        where: {
          ma_refresh_token: refreshToken,
        },
      });
    if (!findRefreshToken) {
      throw new NotFoundException(
        USERS_MESSAGES.USED_REFRESH_TOKEN_OR_NOT_EXIST,
      );
    }
    const { ma_refresh_token } = findRefreshToken;
    await this.prisma.refresh_token.delete({
      where: {
        ma_refresh_token,
        tai_khoan: currentUser.tai_khoan,
      },
    });

    return USERS_MESSAGES.LOGOUT_SUCCESS;
  }

  async refreshToken(
    refreshTokenUsersDto: RefreshTokenUsersDto,
  ): Promise<object> {
    const { refreshToken } = refreshTokenUsersDto;
    const decode_refresh_token =
      await this.authService.decodeToken(refreshToken);

    const findRefreshToken: refresh_token =
      await this.prisma.refresh_token.findUnique({
        where: { ma_refresh_token: refreshToken },
      });
    if (!findRefreshToken) {
      throw new NotFoundException(
        REFRESH_MESSAGE.REFRESH_TOKEN_NOT_FOUND_OR_ALREADY_USED,
      );
    }
    const currentUser: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
      where: { tai_khoan: decode_refresh_token.tai_khoan },
    });

    if (!currentUser) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    const [access_token, new_refresh_token] = await Promise.all([
      this.signAccessToken({
        email: currentUser.email,
        ma_loai_nguoi_dung: currentUser.ma_loai_nguoi_dung as UserRoleEnum,
        tai_khoan: currentUser.tai_khoan,
      }),
      this.signRefreshToken({
        email: currentUser.email,
        ma_loai_nguoi_dung: currentUser.ma_loai_nguoi_dung as UserRoleEnum,
        tai_khoan: currentUser.tai_khoan,
        exp: decode_refresh_token.exp,
      }),
      this.prisma.refresh_token.delete({
        where: { ma_refresh_token: refreshToken },
      }),
    ]);
    const decode_new_refresh_token =
      this.authService.decodeToken(new_refresh_token);

    await this.prisma.refresh_token.create({
      data: {
        ma_refresh_token: new_refresh_token,
        tai_khoan: decode_new_refresh_token.tai_khoan,
        ngay_tao: new Date(decode_new_refresh_token.iat * 1000),
        ngay_het_han: new Date(decode_new_refresh_token.exp * 1000),
      },
    });
    return {
      message: USERS_MESSAGES.REFRESH_TOKEN_SUCCESS,
      access_token,
      new_refresh_token,
    };
  }

  async forgotPassword(
    forgotPasswordUsersDto: ForgotPasswordUsersDto,
  ): Promise<object> {
    const { email } = forgotPasswordUsersDto;
    const findUser: nguoi_dung = await this.prisma.nguoi_dung.findFirst({
      where: {
        email,
      },
    });
    if (!findUser) {
      throw new NotFoundException(USERS_MESSAGES.EMAIL_NOT_FOUND);
    }
    const dNow = new Date();
    const codePassword = this.generateRandomString();
    const expirationDate = new Date(dNow.getTime() + 10 * 60000);
    await this.prisma.code.create({
      data: {
        ma_code: codePassword,
        tai_khoan: findUser.tai_khoan,
        ngay_tao: dNow,
        ngay_het_han: expirationDate,
      },
    });
    this.mailService.sendMail(
      email,
      USERS_MESSAGES.RESET_PASSWORD_MAIL,
      `Your reset code is: ${codePassword}`,
    );
    return {
      message: USERS_MESSAGES.RESET_PASSWORD_CODE_SEND_TO_YOUR_EMAIL,
    };
  }

  async forgotPasswordCode(
    forgotPasswordCodeUsersDto: ForgotPasswordCodeUsersDto,
  ): Promise<object> {
    const { codeId } = forgotPasswordCodeUsersDto;
    const dNow = new Date();
    const findCode = await this.prisma.code.findUnique({
      where: {
        ma_code: codeId,
      },
    });
    if (!findCode) {
      throw new UnprocessableEntityException(USERS_MESSAGES.CODE_IS_INVALID);
    }
    if (dNow > findCode.ngay_het_han) {
      throw new UnprocessableEntityException(USERS_MESSAGES.CODE_IS_EXPIRED);
    }
    this.tempAccount = findCode.tai_khoan;

    await this.prisma.code.delete({
      where: {
        ma_code: codeId,
      },
    });
    return {
      message: USERS_MESSAGES.VERIFY_CODE_SUCCESS,
    };
  }

  async resetPassword(
    resetPasswordUsersDto: ResetPasswordUsersDto,
  ): Promise<object> {
    const { password } = resetPasswordUsersDto;
    if (!this.tempAccount) {
      throw new NotFoundException(USERS_MESSAGES.ACCOUNT_NOT_FOUND);
    }
    const currentUser = await this.prisma.nguoi_dung.findUnique({
      where: {
        tai_khoan: this.tempAccount,
      },
    });
    if (!currentUser) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    await this.prisma.nguoi_dung.update({
      where: {
        tai_khoan: currentUser.tai_khoan,
      },
      data: {
        mat_khau: bcrypt.hashSync(password, 10),
      },
    });
    this.tempAccount = null;
    console.log(this.tempAccount);

    return {
      message: USERS_MESSAGES.YOUR_NEW_PASSWORD_HAS_BEEN_UPDATE,
    };
  }

  async getUserRoles(): Promise<object> {
    const result: loai_nguoi_dung[] =
      await this.prisma.loai_nguoi_dung.findMany();
    return {
      message: USERS_MESSAGES.GET_USER_ROLES_SUCCES,
      result,
    };
  }

  async getUsers(): Promise<object> {
    const result: nguoi_dung[] = await this.prisma.nguoi_dung.findMany();
    return {
      message: USERS_MESSAGES.GET_ALL_USERS_SUCCESS,
      result,
    };
  }

  async getUsersPagination(
    paginationUsersDto: PaginationUsersDto,
  ): Promise<object> {
    const { page = 1, limit = 6, searchKey = '' } = paginationUsersDto;
    const parsePage = Number(page);
    const parseLimit = Number(limit);
    const skip = (parsePage - 1) * parseLimit;

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

    const users: nguoi_dung[] = await this.prisma.nguoi_dung.findMany({
      skip,
      take: parseLimit,
      where: searchCondition,
    });

    const total: number = await this.prisma.nguoi_dung.count({
      where: searchCondition,
    });

    return {
      message: USERS_MESSAGES.GET_ALL_USERS_SUCCESS,
      data: users,
      count: users.length,
      total,
      pageNumber: parsePage,
      totalPages: Math.ceil(total / parseLimit),
    };
  }

  async searchUsers(searchKey: string): Promise<object> {
    const result: nguoi_dung[] = await this.prisma.nguoi_dung.findMany({
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
        message: USERS_MESSAGES.USER_NOT_FOUND,
        result,
      };
    }
  }

  async getMeInfo(req: Request): Promise<object> {
    const user: TokenPayload = req.user;
    const currentUser: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
      where: {
        tai_khoan: user.tai_khoan,
      },
      include: {
        loai_nguoi_dung: true,
        dat_ve: true,
      },
    });
    if (!currentUser) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    const { da_xoa, ...userWithoutDaXoa } = currentUser;

    return {
      message: USERS_MESSAGES.GET_ME_INFO_SUCCESS,
      user: userWithoutDaXoa,
    };
  }

  async uploadAvatar(file: Express.Multer.File): Promise<{
    url: string;
  }> {
    if (!file) {
      throw new UnprocessableEntityException(USERS_MESSAGES.AVATAR_IS_REQUIRED);
    }
    let input = process.cwd() + '/public/img/' + file.filename;
    let output = process.cwd() + '/public/imgOptimize/';
    const result = await compressImage(input, output);
    if (!result) {
      throw new InternalServerErrorException(
        USERS_MESSAGES.ERROR_WHILE_COMPRESSING_IMAGES,
      );
    }
    const cloudinaryResult = await cloudinary.uploader.upload(
      `${output}${file.filename}`,
    );
    fs.unlinkSync(`${output}${file.filename}`);
    fs.unlinkSync(input);
    return { url: cloudinaryResult.url };
  }

  async updateMe(
    updateMeUsersDto: UpdateMeUsersDto,
    req: Request,
  ): Promise<object> {
    const { email, name, password, phone, avatarUrl } = updateMeUsersDto;
    const decode_access_token: TokenPayload = req.user;
    const currentUser: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
      where: {
        tai_khoan: decode_access_token.tai_khoan,
      },
    });
    if (!currentUser) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    if (email) {
      const checkEmail: nguoi_dung = await this.prisma.nguoi_dung.findFirst({
        where: { email },
      });
      if (checkEmail && checkEmail.tai_khoan !== currentUser.tai_khoan) {
        throw new NotFoundException(USERS_MESSAGES.EMAIL_IS_ALREADY_EXIST);
      }
    }
    let userUpdate: UserUpdate = {
      email,
      ho_ten: name,
      so_dt: phone,
      anh_dai_dien: avatarUrl,
    };
    if (password) {
      userUpdate.mat_khau = bcrypt.hashSync(password, 10);
    }
    const user: nguoi_dung = await this.prisma.nguoi_dung.update({
      where: {
        tai_khoan: currentUser.tai_khoan,
      },
      data: userUpdate,
    });
    const token = await this.signAccessTokenAndRefreshToken({
      email: user.email,
      tai_khoan: user.tai_khoan,
      ma_loai_nguoi_dung: user.ma_loai_nguoi_dung as UserRoleEnum,
    });
    const { access_token, refresh_token } = token;
    const decode_refresh_token =
      await this.authService.decodeToken(refresh_token);
    await this.prisma.refresh_token.create({
      data: {
        tai_khoan: user.tai_khoan,
        ma_refresh_token: refresh_token,
        ngay_tao: new Date(decode_refresh_token.iat * 1000),
        ngay_het_han: new Date(decode_refresh_token.exp * 1000),
      },
    });
    return {
      message: USERS_MESSAGES.UPDATE_ME_SUCCESS,
      access_token,
      refresh_token,
    };
  }

  // ROLE ADMIN
  async getUserInfo(account: string): Promise<object> {
    if (!account) {
      throw new BadRequestException({
        message: USERS_MESSAGES.ACCOUNT_NAME_IS_REQUIRED,
      });
    }
    const user: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
      where: { tai_khoan: account },
      include: {
        loai_nguoi_dung: true,
        dat_ve: true,
      },
    });
    if (!user) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
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

    const newUser: nguoi_dung = {
      tai_khoan: account,
      email,
      mat_khau: bcrypt.hashSync(password, 10),
      ho_ten: name,
      so_dt: phone,
      anh_dai_dien: process.env.CLOUNDINARY_DEFAULT_AVATAR,
      ma_loai_nguoi_dung: role,
      da_xoa: false,
    };
    await this.prisma.nguoi_dung.create({ data: newUser });

    return USERS_MESSAGES.CREATE_NEW_USER_SUCCESS;
  }

  async updateUser(
    updateUsersDto: UpdateUsersDto,
    req: Request,
    account: string,
  ): Promise<object> {
    const { email, name, password, phone, role, deleted } = updateUsersDto;
    const decode_access_token: TokenPayload = req.user;
    const currentUser: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
      where: {
        tai_khoan: decode_access_token.tai_khoan,
      },
    });
    if (!currentUser) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    if (!account) {
      throw new BadRequestException({
        message: USERS_MESSAGES.ACCOUNT_NAME_IS_REQUIRED,
      });
    }
    const findUser: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
      where: {
        tai_khoan: account,
      },
    });
    if (!findUser) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    if (email) {
      const checkEmail: nguoi_dung = await this.prisma.nguoi_dung.findFirst({
        where: { email },
      });
      if (checkEmail && checkEmail.tai_khoan !== currentUser.tai_khoan) {
        throw new NotFoundException(USERS_MESSAGES.EMAIL_IS_ALREADY_EXIST);
      }
    }

    let userUpdate: UserUpdate = {
      email,
      ho_ten: name,
      so_dt: phone,
      ma_loai_nguoi_dung: role,
    };
    if (password) {
      userUpdate.mat_khau = bcrypt.hashSync(password, 10);
    }
    if (deleted) {
      userUpdate.da_xoa = this.parseBoolean(deleted);
    }
    await this.prisma.nguoi_dung.update({
      where: {
        tai_khoan: account,
      },
      data: userUpdate,
    });
    return {
      message: USERS_MESSAGES.UPDATE_USER_SUCCESS,
    };
  }

  async deleteUser(account: string): Promise<string> {
    if (!account) {
      throw new BadRequestException({
        message: USERS_MESSAGES.ACCOUNT_NAME_IS_REQUIRED,
      });
    }
    const user: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
      where: { tai_khoan: account },
    });
    if (!user) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    await this.prisma.nguoi_dung.update({
      where: { tai_khoan: user.tai_khoan },
      data: {
        da_xoa: true,
      },
    });
    return USERS_MESSAGES.DELETE_USER_SUCCESS;
  }

  async deleteUserImmediate(account: string): Promise<string> {
    if (!account) {
      throw new BadRequestException({
        message: USERS_MESSAGES.ACCOUNT_NAME_IS_REQUIRED,
      });
    }
    const user: nguoi_dung = await this.prisma.nguoi_dung.findUnique({
      where: { tai_khoan: account },
    });
    if (!user) {
      throw new NotFoundException(USERS_MESSAGES.USER_NOT_FOUND);
    }
    await this.prisma.nguoi_dung.delete({
      where: { tai_khoan: user.tai_khoan },
    });
    return USERS_MESSAGES.DELETE_USER_SUCCESS;
  }
}
