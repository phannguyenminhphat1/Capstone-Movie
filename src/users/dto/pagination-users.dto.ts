import { IsInt, IsOptional, IsString } from 'class-validator';

export class PaginationUsers {
  @IsOptional()
  @IsInt()
  page?: number;

  @IsOptional()
  @IsInt()
  limit?: number;

  @IsOptional()
  @IsString()
  searchKey?: string;
}
