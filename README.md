# Movie API

## Tổng quan

Movie API là một API để quản lý dữ liệu liên quan đến phim, bao gồm lịch chiếu, quản lý phim, đặt vé và quản lý thông tin người dùng. API này được xây dựng với NestJS và Prisma, cơ sở dữ liệu MySQL.

## Công nghệ sử dụng

- [NestJS](https://nestjs.com/)
- [Prisma](https://www.prisma.io/)
- [TypeScript](https://www.typescriptlang.org/)
- [Express](https://expressjs.com/)
- [MySQL](https://www.mysql.com/)

## Điều Kiện Tiên Quyết

Các gói cài đặt để chạy dự án:

```bash
- Node.js >= 20.11.1
- Yarn >= 1.22.19
- Docker >= 20.10.21
```

## Cài đặt

1. Clone repository:

   ```sh
   git clone https://github.com/phannguyenminhphat1/Capstone-Movie
   cd capstone-movie
   ```

2. Cài đặt các dependencies:

   ```sh
   yarn install
   ```

3. Cấu hình môi trường:

   - Tạo file `.env` và cấu hình các biến môi trường cần thiết.

4. Chạy ứng dụng:
   ```sh
   yarn start:dev
   ```

## Test API

Sử dụng Postman để test các endpoints của API. Bạn có thể import Postman của tôi bằng cách sử dụng file `postman.json` tôi cung cấp sau đây

```sh
   https://drive.google.com/file/d/1cthey8ZnCI1bADUtbg-1R1JOWfoQ8wBd/view?usp=drive_link
```

1. Mở Postman.
2. Chọn `Import` và chọn file `postman.json`.
3. Thực hiện các request.

hoặc có thể test API thông qua link swagger sau đây:

```sh
   http://61.14.233.242:8080/swagger#/
```

## Cách sử dụng

**Quản lý người dùng:**

|              **Path**              | **Method** |           **Description**           | **Param** |      **Query**       | **Authorization** |                **Request Body**                |
| :--------------------------------: | :--------: | :---------------------------------: | :-------: | :------------------: | :---------------: | :--------------------------------------------: |
|        /api/users/register         |    POST    |               Đăng ký               |     x     |          x           |         x         |       account,password,name,phone,email        |
|          /api/users/login          |    POST    |              Đăng nhập              |     x     |          x           |         x         |                account,password                |
|         /api/users/logout          |    POST    |              Đăng xuất              |     x     |          x           |   access_token    |                  refreshToken                  |
|      /api/users/refresh-token      |    POST    |            Refresh Token            |     x     |          x           |   access_token    |                  refreshToken                  |
|     /api/users/forgot-password     |    POST    |            Quên mật khẩu            |     x     |          x           |         x         |                     email                      |
|  /api/users/forgot-password-code   |    POST    |     Xác minh code quên mật khẩu     |     x     |          x           |         x         |                     codeId                     |
|     /api/users/reset-password      |    POST    |          Đặt lại mật khẩu           |     x     |          x           |         x         |                    password                    |
|      /api/users/upload-avatar      |    POST    |          Tải lên hình ảnh           |     x     |          x           |   access_token    |                     avatar                     |
|        /api/users/update-me        |   PATCH    |            Cập nhật tôi             |     x     |          x           |   access_token    |                     avatar                     |
|     /api/users/get-user-roles      |    GET     |    Lấy danh sách loại người dùng    |     x     |          x           |         x         |                       x                        |
|        /api/users/get-users        |    GET     |      Lấy danh sách người dùng       |     x     |          x           |         x         |                       x                        |
|  /api/users/get-users-pagination   |    GET     | Lấy danh sách người dùng phân trang |     x     | page,limit,searchKey |         x         |                       x                        |
|      /api/users/search-users       |    GET     |              Tìm kiếm               |     x     |      searchKey       |         x         |                       x                        |
| /api/users/search-users-pagination |    GET     |   Tìm kiếm người dùng phân trang    |     x     | page,limit,searchKey |         x         |                       x                        |
|       /api/users/get-me-info       |    GET     |        Lấy thông tin cá nhân        |     x     |          x           |   access_token    |                       x                        |
|      /api/users/get-user-info      |    GET     |      Lấy thông tin người dùng       |  account  |          x           |   access_token    |                       x                        |
|       /api/users/create-user       |    POST    |         Tạo mới người dùng          |     x     |          x           |   access_token    |     account,name,password,phone,role,email     |
|       /api/users/update-user       |   PATCH    |         Cập nhật người dùng         |  account  |          x           |   access_token    | account,name,password,phone,role,email,deleted |
|       /api/users/delete-user       |   PATCH    |           Xóa người dùng            |  account  |          x           |   access_token    |                       x                        |
|       /api/users/delete-user       |   DELETE   |           Xóa người dùng            |  account  |          x           |   access_token    |                       x                        |

**Quản lý phim:**
| **Path** | **Method** | **Description** | **Param** | **Query** | **Authorization** | **Request Body** |
|:---------------------------------:|:----------:|:-----------------------------:|:---------:|:---------------------------------:|:-----------------:|:-------------------------------------------------------------------------------:|
| /api/movies/get-banners | GET | Lấy danh sách banner | x | x | x | x |
| /api/movies/get-movies | GET | Lấy danh sách phim | x | x | x | x |
| /api/movies/get-movies-pagination | GET | Lấy danh sách phim phân trang | x | limit,page,name | x | x |
| /api/movies/get-movies-by-date | GET | Lấy danh sách phim theo ngày | x | limit,page,name,startDate,endDate | x | x |
| /api/movies/get-movie-info | GET | Lấy thông tin phim | movieId | x | x | x |
| /api/movies/create-movie | POST | Tạo phim mới | x | x | access_token | name,trailer,desc,releaseDate,rate,hot,commingSoon,showingNow,image |
| /api/movies/upload-image | POST | Tải lên hình ảnh | x | x | access_token | image |
| /api/movies/update-movie | PATCH | Cập nhật phim | movieId | x | access_token | name,trailer,desc,realeaseDate,rate,hot,commingSoon,showingNow,imageUrl,deleted |
| /api/movies/delete-movie | PATCH | Xóa phim | movieId | x | access_token | x |
| /api/movies/delete-movie | DELETE | Xóa phim | movieId | x | access_token | x |

**Quản lý rạp:**
| **Path** | **Method** | **Description** | **Param** | **Query** | **Authorization** | **Request Body** |
|:---------------------------------------------:|:----------:|:------------------------------------------:|:---------:|:---------------:|:-----------------:|:-------------------------------------------------:|
| /api/theates/get-theater-systems | GET | Lấy danh sách hệ thống rạp | x | x | x | x |
| /api/theaters/get-theater-complex | GET | Lấy danh sách cụm rạp | x | theaterSystemID | x | x |
| /api/theaters/get-showtimes-by-theater-system | GET | Lấy danh sách lịch chiếu theo hệ thống rạp | x | theaterSystemID | x | x |
| /api/theaters/get-showtimes-by-movie | GET | Lấy danh sách lịch chiếu theo phim | x | movieId | x | x |
| /api/theaters/create-showtimes | POST | Tạo lịch chiếu | x | x | access_token | movieId,movieTheaterId,movieShowtimes,ticketPrice |

**Quản lý đặt vé:**
| **Path** | **Method** | **Description** | **Param** | **Query** | **Authorization** | **Request Body** |
|:---------------------------------:|:----------:|:------------------------:|:----------:|:---------:|:-----------------:|:--------------------------:|
| /api/tickets/get-showtime-tickets | GET | Lấy danh sách lịch chiếu | showtimeID | x | x | x |
| /api/tickets/booking-tickets | POST | Đặt vé | x | x | access_token | showtimeId,seats[{seatId}] |

**Quản lý bình luận:**
| **Path** | **Method** | **Description** | **Param** | **Query** | **Authorization** | **Request Body** |
|:-------------------------------:|:----------:|:-----------------------:|:---------:|:-----------------:|:-----------------:|:----------------:|
| /api/comments/get-comments | GET | Lấy danh sách bình luận | x | x | x | x |
| /api/comments/post-comment | POST | Thêm bình luận | x | x | access_token | movieId,content |
| /api/comments/delete-comment | DELETE | Xóa bình luận | x | commentId | access_token | x |
| /api/comments/delete-comment-me | DELETE | Xóa bình luận tôi | x | commentId,movieId | access_token | x |

**Quản lý yêu thích:**
| **Path** | **Method** | **Description** | **Param** | **Query** | **Authorization** | **Request Body** |
|:----------:|:----------:|:-----------------:|:---------:|:---------:|:-----------------:|:----------------:|
| /api/likes | POST | Thích và bỏ thích | movieId | x | access_token | x |

### Thông tin liên lạc

Nếu bạn có bất kỳ câu hỏi hoặc cần hỗ trợ thêm, vui lòng liên hệ với tôi qua email: _[phannguyenminhphat1@gmail.com](mailto:phannguyenminhphat1@gmail.com)_.
