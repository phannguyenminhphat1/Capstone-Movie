import {
  Body,
  Controller,
  Get,
  Headers,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  Put,
  Query,
  UploadedFile,
  UseFilters,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { LoginUsersDto } from './dto/login-users.dto';
import { RegisterUsersDto } from './dto/register-users.dto';
import { AuthGuard } from '@nestjs/passport';
import { HttpExceptionFilter } from 'src/utils/http-exception.filter';
import { RolesGuard } from 'src/guards/roles/roles.guard';
import { CreateUsersDto } from './dto/create-users.dto';
import { FileInterceptor } from '@nestjs/platform-express';
import { uploadOptions } from 'src/utils/upload';
import { UpdateUsersDto } from './dto/update-users.dto';
@Controller('api/users')
// @UseFilters(HttpExceptionFilter)
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get('send-mail')
  sendMail() {
    return this.usersService.sendMail();
  }

  @Post('register')
  register(@Body() registerUsersDto: RegisterUsersDto): Promise<object> {
    return this.usersService.register(registerUsersDto);
  }

  @Post('login')
  login(@Body() loginUserDto: LoginUsersDto): Promise<object> {
    return this.usersService.login(loginUserDto);
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
    @Query('page', ParseIntPipe) page?: number,
    @Query('limit', ParseIntPipe) limit?: number,
    @Query('searchKey') searchKey?: string,
  ): Promise<object> {
    return this.usersService.getUsersPagination({ page, limit, searchKey });
  }

  @Get('search-users')
  searchUsers(@Query('searchKey') searchKey?: string): Promise<object> {
    return this.usersService.searchUsers(searchKey);
  }

  @Get('search-users-pagination')
  searchUsersPagination(
    @Query('page', ParseIntPipe) page?: number,
    @Query('limit', ParseIntPipe) limit?: number,
    @Query('searchKey') searchKey?: string,
  ): Promise<object> {
    return this.usersService.getUsersPagination({ page, limit, searchKey });
  }

  @UseGuards(AuthGuard('jwt'))
  @Get('get-me-info')
  getMeInfo(@Headers('authorization') authorization: string): Promise<object> {
    return this.usersService.getMeInfo(authorization);
  }

  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Get('get-user-info')
  getUserInfo(@Query('account') account: string): Promise<object> {
    return this.usersService.getUserInfo(account);
  }

  @UseGuards(new RolesGuard(['QuanTri']))
  @UseGuards(AuthGuard('jwt'))
  @Post('create-user')
  createUser(@Body() createUsersDto: CreateUsersDto): Promise<string> {
    return this.usersService.createUser(createUsersDto);
  }

  @UseGuards(AuthGuard('jwt'))
  @UseInterceptors(FileInterceptor('avatar', uploadOptions))
  @Put('update-me')
  updateMe(
    @Body() updateUsersDto: UpdateUsersDto,
    @UploadedFile() file: Express.Multer.File,
    @Headers('authorization') authorization: string,
  ): Promise<object> {
    return this.usersService.updateMe(updateUsersDto, file, authorization);
  }
}
