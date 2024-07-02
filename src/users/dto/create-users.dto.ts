import { ApiProperty } from '@nestjs/swagger';
import {
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsPhoneNumber,
  IsString,
  IsStrongPassword,
  Length,
} from 'class-validator';
import { UserRoleEnum } from 'src/constants/enum';
import { USERS_MESSAGES } from 'src/constants/messages';

export class CreateUsersDto {
  @ApiProperty()
  @Length(4, 20, { message: USERS_MESSAGES.ACCOUNT_NAME_LENGTH })
  @IsString({ message: USERS_MESSAGES.ACCOUNT_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.ACCOUNT_NAME_IS_REQUIRED })
  account: string;

  @ApiProperty()
  @IsEmail({}, { message: USERS_MESSAGES.INVALID_EMAIL_FORMAT })
  @IsString({ message: USERS_MESSAGES.EMAIL_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.EMAIL_IS_REQUIRED })
  email: string;

  @ApiProperty()
  @IsStrongPassword(
    { minLength: 4, minNumbers: 1, minUppercase: 1, minSymbols: 1 },
    { message: USERS_MESSAGES.PASSWORD_MUST_BE_STRONG },
  )
  @Length(4, 25, { message: USERS_MESSAGES.PASSWORD_LENGTH })
  @IsString({ message: USERS_MESSAGES.PASSWORD_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.PASSWORD_IS_REQUIRED })
  password: string;

  @ApiProperty()
  @Length(2, 100, { message: USERS_MESSAGES.NAME_LENGTH_MUST_BE_FROM_2_TO_100 })
  @IsString({ message: USERS_MESSAGES.NAME_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.NAME_IS_REQUIRED })
  name: string;

  @ApiProperty()
  @IsPhoneNumber('VN', { message: USERS_MESSAGES.PHONE_IS_NOT_VALID })
  @IsString({ message: USERS_MESSAGES.PHONE_MUST_BE_A_STRING })
  @IsNotEmpty({ message: USERS_MESSAGES.PHONE_IS_REQUIRED })
  phone: string;

  @ApiProperty({
    enum: UserRoleEnum,
    description: 'Role of the user: KhachHang, QuanTri',
  })
  @IsEnum(UserRoleEnum, { message: USERS_MESSAGES.USER_ROLE_IS_INVALID })
  @IsNotEmpty({ message: USERS_MESSAGES.USER_ROLE_IS_REQUIRED })
  role: UserRoleEnum;
}
