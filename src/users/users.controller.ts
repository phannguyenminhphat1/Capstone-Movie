import {
  Body,
  Controller,
  Delete,
  Get,
  HttpException,
  HttpStatus,
  Param,
  Patch,
  Post,
  Query,
  Req,
  UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { LoginUsersDto } from './dto/login-users.dto';
import { RegisterUsersDto } from './dto/register-users.dto';
import { AuthGuard } from '@nestjs/passport';
import { RolesGuard } from 'src/guards/roles/roles.guard';
import { CreateUsersDto } from './dto/create-users.dto';
import { FileInterceptor } from '@nestjs/platform-express';
import { uploadOptions } from 'src/utils/upload';
import { UpdateUsersDto } from './dto/update-users.dto';
import { Request } from 'express';
import {
  ApiBearerAuth,
  ApiBody,
  ApiConsumes,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { LogoutUsersDto } from './dto/logout-users.dto';
import { UpdateMeUsersDto } from './dto/update-me-users.dto';
import { PaginationUsersDto } from './dto/pagination-users.dto';
import { UploadAvatarUsersDto } from './dto/upload-avatar-users.dto';
import { ForgotPasswordUsersDto } from './dto/forgot-password-users.dto';
import { ResetPasswordUsersDto } from './dto/reset-password-users.dto';
import { RefreshTokenUsersDto } from './dto/refresh-token-users.dto';
import { ForgotPasswordCodeUsersDto } from './dto/forgot-password-code-users.dto';

@ApiTags('Users')
@Controller('api/users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post('register')
  register(@Body() registerUsersDto: RegisterUsersDto): Promise<string> {
    return this.usersService.register(registerUsersDto);
  }

  @Post('login')
  login(@Body() loginUserDto: LoginUsersDto): Promise<object> {
    try {
      return this.usersService.login(loginUserDto);
    } catch (error) {
      console.log(error);

      throw new HttpException('Lỗi .......', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'))
  @Post('logout')
  logout(
    @Body() logoutUsersDto: LogoutUsersDto,
    @Req() req: Request,
  ): Promise<string> {
    return this.usersService.logout(logoutUsersDto, req);
  }

  @UseGuards(AuthGuard('refresh-jwt'))
  @Post('refresh-token')
  refreshToken(
    @Body() refreshTokenUsersDto: RefreshTokenUsersDto,
  ): Promise<object> {
    return this.usersService.refreshToken(refreshTokenUsersDto);
  }

  @Post('forgot-password')
  forgotPassword(
    @Body() forgotPasswordUsersDto: ForgotPasswordUsersDto,
  ): Promise<object> {
    return this.usersService.forgotPassword(forgotPasswordUsersDto);
  }

  @Post('forgot-password-code')
  forgotPasswordCode(
    @Body() forgotPasswordCodeUsersDto: ForgotPasswordCodeUsersDto,
  ): Promise<object> {
    return this.usersService.forgotPasswordCode(forgotPasswordCodeUsersDto);
  }

  @Post('reset-password')
  resetPassword(
    @Body() resetPasswordUsersDto: ResetPasswordUsersDto,
  ): Promise<object> {
    return this.usersService.resetPassword(resetPasswordUsersDto);
  }

  @Get('get-user-roles')
  getUserRoles(): Promise<object> {
    return this.usersService.getUserRoles();
  }

  @Get('get-users')
  getUsers(): Promise<object> {
    return this.usersService.getUsers();
  }

  @Get('get-users-pagination')
  getUsersPagination(
    @Query() paginationUsers: PaginationUsersDto,
  ): Promise<object> {
    return this.usersService.getUsersPagination(paginationUsers);
  }

  @Get('search-users-pagination')
  searchUsersPagination(
    @Query() paginationUsers: PaginationUsersDto,
  ): Promise<object> {
    return this.usersService.getUsersPagination(paginationUsers);
  }

  @ApiQuery({
    name: 'searchKey',
    required: false,
    schema: { default: '' },
    description: 'Search by name,email,phone',
  })
  @Get('search-users')
  searchUsers(@Query('searchKey') searchKey: string): Promise<object> {
    return this.usersService.searchUsers(searchKey);
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'))
  @Get('get-me-info')
  getMeInfo(@Req() req: Request): Promise<object> {
    return this.usersService.getMeInfo(req);
  }

  @ApiConsumes('multipart/form-data')
  @ApiBearerAuth()
  @ApiBody({
    type: UploadAvatarUsersDto,
  })
  @UseGuards(AuthGuard('jwt'))
  @UseInterceptors(FileInterceptor('avatar', uploadOptions))
  @Post('upload-avatar')
  async uploadAvatar(@UploadedFile() file: Express.Multer.File): Promise<{
    url: string;
  }> {
    return await this.usersService.uploadAvatar(file);
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'))
  @Patch('update-me')
  updateMe(
    @Body() updateMeUsersDto: UpdateMeUsersDto,
    @Req() req: Request,
  ): Promise<object> {
    return this.usersService.updateMe(updateMeUsersDto, req);
  }

  // ADMIN
  @ApiBearerAuth()
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Get('get-user-info/:account')
  getUserInfo(@Param('account') account: string): Promise<object> {
    return this.usersService.getUserInfo(account);
  }

  @ApiBearerAuth()
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Post('create-user')
  createUser(@Body() createUsersDto: CreateUsersDto): Promise<string> {
    return this.usersService.createUser(createUsersDto);
  }

  @ApiBearerAuth()
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Patch('update-user/:account')
  updateUser(
    @Body() updateUsersDto: UpdateUsersDto,
    @Param('account') account: string,
    @Req() req: Request,
  ): Promise<object> {
    return this.usersService.updateUser(updateUsersDto, req, account);
  }

  @ApiBearerAuth()
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Patch('delete-user/:account')
  deleteUser(@Param('account') account: string): Promise<string> {
    return this.usersService.deleteUser(account);
  }

  @ApiBearerAuth()
  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Delete('delete-user/:account')
  deleteUserImmediate(@Param('account') account: string): Promise<string> {
    return this.usersService.deleteUserImmediate(account);
  }
}
