-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_capstone_movie
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner` (
  `ma_banner` int NOT NULL AUTO_INCREMENT,
  `ma_phim` int DEFAULT NULL,
  `hinh_anh` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ma_banner`),
  KEY `ma_phim` (`ma_phim`),
  CONSTRAINT `banner_ibfk_1` FOREIGN KEY (`ma_phim`) REFERENCES `phim` (`ma_phim`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner` VALUES (1,1,'banner1.jpg'),(2,2,'banner2.jpg'),(3,3,'banner3.jpg'),(4,4,'banner4.jpg'),(5,5,'banner5.jpg'),(6,6,'banner6.jpg'),(7,7,'banner7.jpg'),(8,8,'banner8.jpg'),(9,9,'banner9.jpg'),(10,10,'banner10.jpg');
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `binh_luan`
--

DROP TABLE IF EXISTS `binh_luan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `binh_luan` (
  `ma_binh_luan` int NOT NULL AUTO_INCREMENT,
  `tai_khoan` varchar(100) DEFAULT NULL,
  `ma_phim` int DEFAULT NULL,
  `ngay_binh_luan` datetime DEFAULT NULL,
  `noi_dung` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`ma_binh_luan`),
  KEY `tai_khoan` (`tai_khoan`),
  KEY `ma_phim` (`ma_phim`),
  CONSTRAINT `binh_luan_ibfk_1` FOREIGN KEY (`tai_khoan`) REFERENCES `nguoi_dung` (`tai_khoan`),
  CONSTRAINT `binh_luan_ibfk_2` FOREIGN KEY (`ma_phim`) REFERENCES `phim` (`ma_phim`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `binh_luan`
--

LOCK TABLES `binh_luan` WRITE;
/*!40000 ALTER TABLE `binh_luan` DISABLE KEYS */;
INSERT INTO `binh_luan` VALUES (2,'helloworld',2,'2024-06-23 03:15:41','Đây là 1 bộ phim rất nà hayy lun lắm lun'),(3,'helloworld',2,'2024-06-23 03:27:08','Đây là 1 bộ phim rất nà hayy lun lắm lun'),(4,'helloworld',2,'2024-06-23 04:07:32','Đây là 1 bộ phim rất nà hayy lun lắm lun');
/*!40000 ALTER TABLE `binh_luan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code`
--

DROP TABLE IF EXISTS `code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `code` (
  `ma_code` varchar(100) NOT NULL,
  `tai_khoan` varchar(100) DEFAULT NULL,
  `ngay_tao` datetime DEFAULT NULL,
  `ngay_het_han` datetime DEFAULT NULL,
  PRIMARY KEY (`ma_code`),
  KEY `tai_khoan` (`tai_khoan`),
  CONSTRAINT `code_ibfk_1` FOREIGN KEY (`tai_khoan`) REFERENCES `nguoi_dung` (`tai_khoan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code`
--

LOCK TABLES `code` WRITE;
/*!40000 ALTER TABLE `code` DISABLE KEYS */;
INSERT INTO `code` VALUES ('bE4I6U','miphat123','2024-06-24 16:25:42','2024-06-24 16:35:42'),('m73q3t','abc123','2024-06-24 15:55:30','2024-06-24 16:05:30'),('UXFwIr','miphat123','2024-06-24 15:59:28','2024-06-24 16:09:28'),('zU4qjW','miphat123','2024-06-24 16:26:23','2024-06-24 16:36:23');
/*!40000 ALTER TABLE `code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cum_rap`
--

DROP TABLE IF EXISTS `cum_rap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cum_rap` (
  `ma_cum_rap` varchar(100) NOT NULL,
  `ten_cum_rap` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `dia_chi` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ma_he_thong_rap` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ma_cum_rap`),
  KEY `ma_he_thong_rap` (`ma_he_thong_rap`),
  CONSTRAINT `cum_rap_ibfk_1` FOREIGN KEY (`ma_he_thong_rap`) REFERENCES `he_thong_rap` (`ma_he_thong_rap`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cum_rap`
--

LOCK TABLES `cum_rap` WRITE;
/*!40000 ALTER TABLE `cum_rap` DISABLE KEYS */;
INSERT INTO `cum_rap` VALUES ('bhd-star-3-2','BHD Star - 3/2','Lầu 5, Vạn Hạnh Mall, 11 Sư Vạn Hạnh, Quận 10','BHDStar'),('bhd-star-bitexco','BHD Star - Bitexco','Lầu 3-4, TTTM Icon 68, 2 Hải Triều, Quận 1','BHDStar'),('bhd-star-pham-hung','BHD Star - Phạm Hùng','Lầu 4, Satra Phạm Hùng, C6/27 Phạm Hùng, Bình Chánh','BHDStar'),('bhd-star-quang-trung','BHD Star - Quang Trung','Lầu 5, Vincom Plaza Quang Trung, 190 Quang Trung, Gò Vấp','BHDStar'),('bhd-star-thao-dien','BHD Star - Thảo Điền','Lầu 5, Vincom Mega Mall Thảo Điền, 159 Xa Lộ Hà Nội, Quận 2','BHDStar'),('bhd-star-vincom-ba-trieu','BHD Star - Vincom Bà Triệu','Lầu 5, Vincom Center Bà Triệu, 191 Bà Triệu, Hai Bà Trưng, Hà Nội','BHDStar'),('bhd-star-vincom-le-van-viet','BHD Star - Vincom Lê Văn Việt','Lầu 4, Vincom Plaza, 50 Lê Văn Việt, Quận 9','BHDStar'),('bhd-star-vincom-long-bien','BHD Star - Vincom Long Biên','Lầu 4, Vincom Center Long Biên, 5 Long Biên 2, Hà Nội','BHDStar'),('bhd-star-vincom-nguyen-chi-thanh','BHD Star - Vincom Nguyễn Chí Thanh','Lầu 6, Vincom Center, 54A Nguyễn Chí Thanh, Ba Đình, Hà Nội','BHDStar'),('bhd-star-vincom-nguyen-xi','BHD Star - Vincom Nguyễn Xí','Lầu 5, Vincom Plaza, 12 Phan Văn Trị, Bình Thạnh','BHDStar'),('cgv-aeon-tan-phu','CGV - Aeon Tân Phú','30 Bờ Bao Tân Thắng, Tân Phú','CGV'),('cgv-crescent-mall','CGV - Crescent Mall','Lầu 5, Crescent Mall, 101 Tôn Dật Tiên, Q.7','CGV'),('cgv-hung-vuong-plaza','CGV - Hùng Vương Plaza','Lầu 7, Hùng Vương Plaza, 126 Hùng Vương, Q.5','CGV'),('cgv-imc-tran-quang-khai','CGV - IMC Trần Quang Khải','Lầu 4, Tòa nhà IMC, 62 Trần Quang Khải, Q.1','CGV'),('cgv-liberty-citypoint','CGV - Liberty Citypoint','Lầu M, 59 - 61 Pasteur, Quận 1, TP. HCM','CGV'),('cgv-pandora-city','CGV - Pandora City','Lầu 3, Pandora City, 1/1 Trường Chinh, Tân Phú','CGV'),('cgv-paragon','CGV - Paragon','Lầu 5, Siêu thị Parkson Paragon, 03 Nguyễn Lương Bằng, Phú Mỹ Hưng, Quận 7','CGV'),('cgv-pearl-plaza','CGV - Pearl Plaza','Lầu 5, Pearl Plaza, 561A Điện Biên Phủ, Bình Thạnh','CGV'),('cgv-satra-c-trung-chanh','CGV - Satra C Trung Chánh','Tầng 3, TTTM Satra C, Quốc lộ 22, Trung Mỹ Tây','CGV'),('cgv-thao-dien-pearl','CGV - Thảo Điền Pearl','Tầng 2, TTTM Thảo Điền Pearl, 12 Quốc Hương, Thảo Điền, Quận 2','CGV'),('cgv-vincom-dong-khoi','CGV - Vincom Đồng Khởi','B1-00, TTTM Vincom Center Đồng Khởi, 72 Lê Thánh Tôn, Q.1','CGV'),('cgv-vincom-go-vap','CGV - Vincom Gò Vấp','Lầu 5, TTTM Vincom, 12 Phan Văn Trị, Gò Vấp','CGV'),('cgv-vincom-thu-duc','CGV - Vincom Thủ Đức','B1-00, Vincom Thủ Đức, 216 Võ Văn Ngân, Bình Thọ','CGV'),('cinestar-binh-thanh','CineStar - Bình Thạnh','1 Phan Đăng Lưu, Bình Thạnh, Hồ Chí Minh','CineStar'),('cinestar-can-tho','CineStar - Cần Thơ','209 Đường 3/2, Xuân Khánh, Ninh Kiều, Cần Thơ','CineStar'),('cinestar-da-nang','CineStar - Đà Nẵng','62 Nguyễn Chí Thanh, Thạch Thang, Hải Châu, Đà Nẵng','CineStar'),('cinestar-hai-ba-trung','CineStar - Hai Bà Trưng','135 Hai Bà Trưng, Bến Nghé, Quận 1','CineStar'),('cinestar-hai-phong','CineStar - Hải Phòng','30 Trần Phú, Ngô Quyền, Hải Phòng','CineStar'),('cinestar-hoa-binh','CineStar - Hòa Bình','240 Lê Văn Sỹ, Tân Bình, Hồ Chí Minh','CineStar'),('cinestar-nha-be','CineStar - Nhà Bè','1809 Lê Văn Lương, Nhơn Đức, Nhà Bè','CineStar'),('cinestar-nha-trang','CineStar - Nha Trang','50 Lê Thánh Tôn, Lộc Thọ, Nha Trang','CineStar'),('cinestar-quoc-thao','CineStar - Quốc Thảo','271 Nguyễn Trãi, Nguyễn Cư Trinh, Quận 1','CineStar'),('cinestar-vung-tau','CineStar - Vũng Tàu','1 Trần Hưng Đạo, Phường 1, Vũng Tàu','CineStar'),('galaxy-ben-tre','Galaxy - Bến Tre','26A4 Đồng Khởi, Phường 4, Bến Tre','Galaxy'),('galaxy-can-tho','Galaxy - Cần Thơ','1 Đại lộ Hòa Bình, Tân An, Ninh Kiều, Cần Thơ','Galaxy'),('galaxy-huynh-tan-phat','Galaxy - Huỳnh Tấn Phát','1362 Huỳnh Tấn Phát, Phú Mỹ, Quận 7, Hồ Chí Minh','Galaxy'),('galaxy-kinh-duong-vuong','Galaxy - Kinh Dương Vương','718bis Kinh Dương Vương, Bình Tân, Hồ Chí Minh','Galaxy'),('galaxy-long-xuyen','Galaxy - Long Xuyên','64 Lý Thái Tổ, Mỹ Bình, Long Xuyên, An Giang','Galaxy'),('galaxy-nguyen-du','Galaxy - Nguyễn Du','116 Nguyễn Du, Bến Thành, Quận 1, Hồ Chí Minh','Galaxy'),('galaxy-quang-trung','Galaxy - Quang Trung','304A Quang Trung, Gò Vấp, Hồ Chí Minh','Galaxy'),('galaxy-tan-binh','Galaxy - Tân Bình','246 Nguyễn Hồng Đào, Tân Bình, Hồ Chí Minh','Galaxy'),('galaxy-trung-chanh','Galaxy - Trung Chánh','18/21A Nguyễn Ảnh Thủ, Trung Chánh, Hóc Môn, Hồ Chí Minh','Galaxy'),('galaxy-vung-tau','Galaxy - Vũng Tàu','563 Trương Công Định, Phường 7, Vũng Tàu','Galaxy'),('lotte-binh-duong','Lotte Cinema - Bình Dương','Lầu 4, TTTM Aeon Mall, 1 Đại lộ Bình Dương, Thuận An, Bình Dương','LotteCinema'),('lotte-can-tho','Lotte Cinema - Cần Thơ','Lầu 5, TTTM Sense City, 1 Đại lộ Hòa Bình, Ninh Kiều, Cần Thơ','LotteCinema'),('lotte-cantavil','Lotte Cinema - Cantavil','Lầu 7, Cantavil Premier, 1 Song Hành, An Phú, Quận 2, Hồ Chí Minh','LotteCinema'),('lotte-cong-hoa','Lotte Cinema - Cộng Hòa','Lầu 4, Pico Plaza, 20 Cộng Hòa, Tân Bình, Hồ Chí Minh','LotteCinema'),('lotte-da-nang','Lotte Cinema - Đà Nẵng','Lầu 5, TTTM Lotte Mart, 6 Nại Nam, Hải Châu, Đà Nẵng','LotteCinema'),('lotte-go-vap','Lotte Cinema - Gò Vấp','Lầu 3, Lotte Mart, 242 Nguyễn Văn Lượng, Gò Vấp, Hồ Chí Minh','LotteCinema'),('lotte-nha-trang','Lotte Cinema - Nha Trang','Lầu 5, TTTM Lotte Mart, 58 Đường 23/10, Nha Trang, Khánh Hòa','LotteCinema'),('lotte-phu-tho','Lotte Cinema - Phú Thọ','Lầu 3, Lotte Mart Phú Thọ, 940 Lạc Long Quân, Tân Bình, Hồ Chí Minh','LotteCinema'),('lotte-thu-duc','Lotte Cinema - Thủ Đức','Lầu 2, TTTM Sense City, 240-242 Võ Văn Ngân, Thủ Đức, Hồ Chí Minh','LotteCinema'),('lotte-vung-tau','Lotte Cinema - Vũng Tàu','Lầu 3, TTTM Lotte Mart, 36 Nguyễn Thái Học, Phường 7, Vũng Tàu','LotteCinema');
/*!40000 ALTER TABLE `cum_rap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dat_ve`
--

DROP TABLE IF EXISTS `dat_ve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dat_ve` (
  `ma_dat_ve` int NOT NULL AUTO_INCREMENT,
  `tai_khoan` varchar(100) DEFAULT NULL,
  `ma_lich_chieu` int DEFAULT NULL,
  `ma_ghe` int DEFAULT NULL,
  PRIMARY KEY (`ma_dat_ve`),
  KEY `tai_khoan` (`tai_khoan`),
  KEY `ma_lich_chieu` (`ma_lich_chieu`),
  KEY `ma_ghe` (`ma_ghe`),
  CONSTRAINT `dat_ve_ibfk_1` FOREIGN KEY (`tai_khoan`) REFERENCES `nguoi_dung` (`tai_khoan`),
  CONSTRAINT `dat_ve_ibfk_2` FOREIGN KEY (`ma_lich_chieu`) REFERENCES `lich_chieu` (`ma_lich_chieu`),
  CONSTRAINT `dat_ve_ibfk_3` FOREIGN KEY (`ma_ghe`) REFERENCES `ghe` (`ma_ghe`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dat_ve`
--

LOCK TABLES `dat_ve` WRITE;
/*!40000 ALTER TABLE `dat_ve` DISABLE KEYS */;
INSERT INTO `dat_ve` VALUES (1,'helloworld',2,154),(2,'helloworld',2,154),(3,'helloworld',2,153),(4,'helloworld',2,154),(5,'helloworld',2,154),(6,'helloworld',2,154),(7,'helloworld',2,155),(8,'helloworld',1,154),(9,'helloworld',1,155),(10,'miphat123',3,156),(11,'miphat123',3,157),(12,'miphat123',3,156),(13,'miphat123',3,157),(14,'miphat123',3,156),(15,'miphat123',3,157),(16,'miphat123',3,156),(17,'miphat123',3,157),(18,'miphat123',3,156),(19,'miphat123',3,157),(20,'miphat123',3,156),(21,'miphat123',3,157),(22,'miphat123',2,156),(23,'miphat123',2,158),(24,'miphat123',2,159),(25,'miphat123',2,157),(26,'helloworld',2,161),(27,'helloworld',2,160);
/*!40000 ALTER TABLE `dat_ve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ghe`
--

DROP TABLE IF EXISTS `ghe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ghe` (
  `ma_ghe` int NOT NULL AUTO_INCREMENT,
  `ten_ghe` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ma_loai_ghe` varchar(50) DEFAULT NULL,
  `ma_rap` int DEFAULT NULL,
  PRIMARY KEY (`ma_ghe`),
  KEY `ma_rap` (`ma_rap`),
  KEY `ma_loai_ghe` (`ma_loai_ghe`),
  CONSTRAINT `ghe_ibfk_1` FOREIGN KEY (`ma_rap`) REFERENCES `rap_phim` (`ma_rap`),
  CONSTRAINT `ghe_ibfk_2` FOREIGN KEY (`ma_loai_ghe`) REFERENCES `loai_ghe` (`ma_loai_ghe`)
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ghe`
--

LOCK TABLES `ghe` WRITE;
/*!40000 ALTER TABLE `ghe` DISABLE KEYS */;
INSERT INTO `ghe` VALUES (1,'A1','thuong',531),(2,'A2','thuong',531),(3,'A3','thuong',531),(4,'A4','thuong',531),(5,'A5','thuong',531),(6,'A6','thuong',531),(7,'A7','thuong',531),(8,'A8','thuong',531),(9,'A9','thuong',531),(10,'A10','thuong',531),(11,'A11','thuong',531),(12,'A12','thuong',531),(13,'A13','thuong',531),(14,'A14','thuong',531),(15,'A15','thuong',531),(16,'A16','thuong',531),(17,'A17','thuong',531),(18,'A18','thuong',531),(19,'A19','thuong',531),(20,'B1','thuong',531),(21,'B2','thuong',531),(22,'B3','thuong',531),(23,'B4','thuong',531),(24,'B5','thuong',531),(25,'B6','thuong',531),(26,'B7','thuong',531),(27,'B8','thuong',531),(28,'B9','thuong',531),(29,'B10','thuong',531),(30,'B11','thuong',531),(31,'B12','thuong',531),(32,'B13','thuong',531),(33,'B14','thuong',531),(34,'B15','thuong',531),(35,'B16','thuong',531),(36,'B17','thuong',531),(37,'B18','thuong',531),(38,'B19','thuong',531),(39,'C1','thuong',531),(40,'C2','thuong',531),(41,'C3','thuong',531),(42,'C4','thuong',531),(43,'C5','thuong',531),(44,'C6','thuong',531),(45,'C7','thuong',531),(46,'C8','thuong',531),(47,'C9','thuong',531),(48,'C10','thuong',531),(49,'C11','thuong',531),(50,'C12','thuong',531),(51,'C13','thuong',531),(52,'C14','thuong',531),(53,'C15','thuong',531),(54,'C16','thuong',531),(55,'C17','thuong',531),(56,'C18','thuong',531),(57,'C19','thuong',531),(58,'D1','vip',531),(59,'D2','vip',531),(60,'D3','vip',531),(61,'D4','vip',531),(62,'D5','vip',531),(63,'D6','vip',531),(64,'D7','vip',531),(65,'D8','vip',531),(66,'D9','vip',531),(67,'D10','vip',531),(68,'D11','vip',531),(69,'D12','vip',531),(70,'D13','vip',531),(71,'D14','vip',531),(72,'D15','vip',531),(73,'D16','vip',531),(74,'D17','vip',531),(75,'D18','vip',531),(76,'D19','vip',531),(77,'D20','vip',531),(78,'E1','vip',531),(79,'E2','vip',531),(80,'E3','vip',531),(81,'E4','vip',531),(82,'E5','vip',531),(83,'E6','vip',531),(84,'E7','vip',531),(85,'E8','vip',531),(86,'E9','vip',531),(87,'E10','vip',531),(88,'E11','vip',531),(89,'E12','vip',531),(90,'E13','vip',531),(91,'E14','vip',531),(92,'E15','vip',531),(93,'E16','vip',531),(94,'E17','vip',531),(95,'E18','vip',531),(96,'E19','vip',531),(97,'E20','vip',531),(98,'F1','vip',531),(99,'F2','vip',531),(100,'F3','vip',531),(101,'F4','vip',531),(102,'F5','vip',531),(103,'F6','vip',531),(104,'F7','vip',531),(105,'F8','vip',531),(106,'F9','vip',531),(107,'F10','vip',531),(108,'F11','vip',531),(109,'F12','vip',531),(110,'F13','vip',531),(111,'F14','vip',531),(112,'F15','vip',531),(113,'F16','vip',531),(114,'F17','vip',531),(115,'F18','vip',531),(116,'F19','vip',531),(117,'F20','vip',531),(118,'G1','vip',531),(119,'G2','vip',531),(120,'G3','vip',531),(121,'G4','vip',531),(122,'G5','vip',531),(123,'G6','vip',531),(124,'G7','vip',531),(125,'G8','vip',531),(126,'G9','vip',531),(127,'G10','vip',531),(128,'G11','vip',531),(129,'G12','vip',531),(130,'G13','vip',531),(131,'G14','vip',531),(132,'G15','vip',531),(133,'G16','vip',531),(134,'G17','vip',531),(135,'G18','vip',531),(136,'G19','vip',531),(137,'G20','vip',531),(138,'H1','couple',531),(139,'H2','couple',531),(140,'H3','couple',531),(141,'H4','couple',531),(142,'H5','couple',531),(143,'H6','couple',531),(144,'H7','couple',531),(145,'H8','couple',531),(146,'H9','couple',531),(147,'H10','couple',531),(148,'H11','couple',531),(149,'H12','couple',531),(150,'H13','couple',531),(151,'H14','couple',531),(152,'H15','couple',531),(153,'H16','couple',531),(154,'A1','thuong',532),(155,'A2','thuong',532),(156,'A3','thuong',532),(157,'A4','thuong',532),(158,'A5','thuong',532),(159,'A6','thuong',532),(160,'A7','thuong',532),(161,'A8','thuong',532),(162,'A9','thuong',532),(163,'A10','thuong',532),(164,'A11','thuong',532),(165,'A12','thuong',532),(166,'A13','thuong',532),(167,'A14','thuong',532),(168,'A15','thuong',532),(169,'A16','thuong',532),(170,'A17','thuong',532),(171,'A18','thuong',532),(172,'A19','thuong',532),(173,'B1','thuong',532),(174,'B2','thuong',532),(175,'B3','thuong',532),(176,'B4','thuong',532),(177,'B5','thuong',532),(178,'B6','thuong',532),(179,'B7','thuong',532),(180,'B8','thuong',532),(181,'B9','thuong',532),(182,'B10','thuong',532),(183,'B11','thuong',532),(184,'B12','thuong',532),(185,'B13','thuong',532),(186,'B14','thuong',532),(187,'B15','thuong',532),(188,'B16','thuong',532),(189,'B17','thuong',532),(190,'B18','thuong',532),(191,'B19','thuong',532),(192,'C1','thuong',532),(193,'C2','thuong',532),(194,'C3','thuong',532),(195,'C4','thuong',532),(196,'C5','thuong',532),(197,'C6','thuong',532),(198,'C7','thuong',532),(199,'C8','thuong',532),(200,'C9','thuong',532),(201,'C10','thuong',532),(202,'C11','thuong',532),(203,'C12','thuong',532),(204,'C13','thuong',532),(205,'C14','thuong',532),(206,'C15','thuong',532),(207,'C16','thuong',532),(208,'C17','thuong',532),(209,'C18','thuong',532),(210,'C19','thuong',532),(211,'D1','vip',532),(212,'D2','vip',532),(213,'D3','vip',532),(214,'D4','vip',532),(215,'D5','vip',532),(216,'D6','vip',532),(217,'D7','vip',532),(218,'D8','vip',532),(219,'D9','vip',532),(220,'D10','vip',532),(221,'D11','vip',532),(222,'D12','vip',532),(223,'D13','vip',532),(224,'D14','vip',532),(225,'D15','vip',532),(226,'D16','vip',532),(227,'D17','vip',532),(228,'D18','vip',532),(229,'D19','vip',532),(230,'D20','vip',532),(231,'E1','vip',532),(232,'E2','vip',532),(233,'E3','vip',532),(234,'E4','vip',532),(235,'E5','vip',532),(236,'E6','vip',532),(237,'E7','vip',532),(238,'E8','vip',532),(239,'E9','vip',532),(240,'E10','vip',532),(241,'E11','vip',532),(242,'E12','vip',532),(243,'E13','vip',532),(244,'E14','vip',532),(245,'E15','vip',532),(246,'E16','vip',532),(247,'E17','vip',532),(248,'E18','vip',532),(249,'E19','vip',532),(250,'E20','vip',532),(251,'F1','vip',532),(252,'F2','vip',532),(253,'F3','vip',532),(254,'F4','vip',532),(255,'F5','vip',532),(256,'F6','vip',532),(257,'F7','vip',532),(258,'F8','vip',532),(259,'F9','vip',532),(260,'F10','vip',532),(261,'F11','vip',532),(262,'F12','vip',532),(263,'F13','vip',532),(264,'F14','vip',532),(265,'F15','vip',532),(266,'F16','vip',532),(267,'F17','vip',532),(268,'F18','vip',532),(269,'F19','vip',532),(270,'F20','vip',532),(271,'G1','vip',532),(272,'G2','vip',532),(273,'G3','vip',532),(274,'G4','vip',532),(275,'G5','vip',532),(276,'G6','vip',532),(277,'G7','vip',532),(278,'G8','vip',532),(279,'G9','vip',532),(280,'G10','vip',532),(281,'G11','vip',532),(282,'G12','vip',532),(283,'G13','vip',532),(284,'G14','vip',532),(285,'G15','vip',532),(286,'G16','vip',532),(287,'G17','vip',532),(288,'G18','vip',532),(289,'G19','vip',532),(290,'G20','vip',532),(291,'H1','couple',532),(292,'H2','couple',532),(293,'H3','couple',532),(294,'H4','couple',532),(295,'H5','couple',532),(296,'H6','couple',532),(297,'H7','couple',532),(298,'H8','couple',532),(299,'H9','couple',532),(300,'H10','couple',532),(301,'H11','couple',532),(302,'H12','couple',532),(303,'H13','couple',532),(304,'H14','couple',532),(305,'H15','couple',532),(306,'H16','couple',532);
/*!40000 ALTER TABLE `ghe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `he_thong_rap`
--

DROP TABLE IF EXISTS `he_thong_rap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `he_thong_rap` (
  `ma_he_thong_rap` varchar(100) NOT NULL,
  `ten_he_thong_rap` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ma_he_thong_rap`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `he_thong_rap`
--

LOCK TABLES `he_thong_rap` WRITE;
/*!40000 ALTER TABLE `he_thong_rap` DISABLE KEYS */;
INSERT INTO `he_thong_rap` VALUES ('BHDStar','BHD Star Cineplex','https://res.cloudinary.com/dy2bmisbi/image/upload/v1718511122/BHD-logo.jpg'),('CGV','Cgv','https://res.cloudinary.com/dy2bmisbi/image/upload/v1718511122/cgv-logo.jpg'),('CineStar','CineStar','https://res.cloudinary.com/dy2bmisbi/image/upload/v1718511122/cinestar-logo.png'),('Galaxy','Galaxy Cinema','https://res.cloudinary.com/dy2bmisbi/image/upload/v1718511122/galaxy-cinema-logo.jpg'),('LotteCinema','Lotte Cinema','https://res.cloudinary.com/dy2bmisbi/image/upload/v1718511122/lotte-logo.png');
/*!40000 ALTER TABLE `he_thong_rap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_chieu`
--

DROP TABLE IF EXISTS `lich_chieu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lich_chieu` (
  `ma_lich_chieu` int NOT NULL AUTO_INCREMENT,
  `ma_rap` int DEFAULT NULL,
  `ma_phim` int DEFAULT NULL,
  `ngay_gio_chieu` datetime DEFAULT NULL,
  `gia_ve` int DEFAULT NULL,
  PRIMARY KEY (`ma_lich_chieu`),
  KEY `ma_rap` (`ma_rap`),
  KEY `ma_phim` (`ma_phim`),
  CONSTRAINT `lich_chieu_ibfk_1` FOREIGN KEY (`ma_rap`) REFERENCES `rap_phim` (`ma_rap`),
  CONSTRAINT `lich_chieu_ibfk_2` FOREIGN KEY (`ma_phim`) REFERENCES `phim` (`ma_phim`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_chieu`
--

LOCK TABLES `lich_chieu` WRITE;
/*!40000 ALTER TABLE `lich_chieu` DISABLE KEYS */;
INSERT INTO `lich_chieu` VALUES (1,532,1,'2024-06-18 12:30:00',100000),(2,532,2,'2024-06-18 12:30:00',200000),(3,532,2,'2024-06-18 13:30:00',200000),(4,531,2,'2024-06-18 13:30:00',200000),(5,533,2,'2024-06-18 13:30:00',200000),(6,533,5,'2024-06-18 13:30:00',200000),(7,671,2,'2024-06-18 13:30:00',200000),(8,672,2,'2024-06-18 13:30:00',200000),(9,910,2,'2024-06-18 13:30:00',200000),(10,679,4,'2024-06-18 13:30:00',150000),(11,679,4,'2024-06-18 09:30:00',150000),(12,679,2,'2024-06-18 04:30:00',150000);
/*!40000 ALTER TABLE `lich_chieu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loai_ghe`
--

DROP TABLE IF EXISTS `loai_ghe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loai_ghe` (
  `ma_loai_ghe` varchar(50) NOT NULL,
  `ten_loai_ghe` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`ma_loai_ghe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loai_ghe`
--

LOCK TABLES `loai_ghe` WRITE;
/*!40000 ALTER TABLE `loai_ghe` DISABLE KEYS */;
INSERT INTO `loai_ghe` VALUES ('couple','Couple'),('thuong','Thường'),('vip','Vip');
/*!40000 ALTER TABLE `loai_ghe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loai_nguoi_dung`
--

DROP TABLE IF EXISTS `loai_nguoi_dung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loai_nguoi_dung` (
  `ma_loai_nguoi_dung` varchar(50) NOT NULL,
  `ten_loai_nguoi_dung` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ma_loai_nguoi_dung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loai_nguoi_dung`
--

LOCK TABLES `loai_nguoi_dung` WRITE;
/*!40000 ALTER TABLE `loai_nguoi_dung` DISABLE KEYS */;
INSERT INTO `loai_nguoi_dung` VALUES ('KhachHang','Khách hàng'),('QuanTri','Quản trị');
/*!40000 ALTER TABLE `loai_nguoi_dung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nguoi_dung`
--

DROP TABLE IF EXISTS `nguoi_dung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nguoi_dung` (
  `tai_khoan` varchar(100) NOT NULL,
  `ho_ten` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `so_dt` varchar(20) DEFAULT NULL,
  `mat_khau` varchar(255) DEFAULT NULL,
  `anh_dai_dien` varchar(255) DEFAULT NULL,
  `da_xoa` tinyint(1) DEFAULT NULL,
  `ma_loai_nguoi_dung` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tai_khoan`),
  KEY `ma_loai_nguoi_dung` (`ma_loai_nguoi_dung`),
  CONSTRAINT `nguoi_dung_ibfk_1` FOREIGN KEY (`ma_loai_nguoi_dung`) REFERENCES `loai_nguoi_dung` (`ma_loai_nguoi_dung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nguoi_dung`
--

LOCK TABLES `nguoi_dung` WRITE;
/*!40000 ALTER TABLE `nguoi_dung` DISABLE KEYS */;
INSERT INTO `nguoi_dung` VALUES ('abc123','Tôi là user abc123','nguyenvana@example.com','0901234567','$2y$10$abcdefghijklmnopqrstuv','avatar01.jpg',1,'KhachHang'),('abc789','Đỗ Thị J','dothij@example.com','0901234576','$2y$10$abcdefghijklmnopqrstuv','avatar10.jpg',0,'QuanTri'),('abcd1','Tui Là ABC','abcd@gmail.com','0703114632','$2b$10$jfFgyNogYRE0qk2t4po2F.MKi69pG66qZ3fumFZ.t/83UfL3Psr.u','https://res.cloudinary.com/dy2bmisbi/image/upload/v1716211691/npwxuahrosftm8qvtfqf.jpg',0,'QuanTri'),('def456','Trần Thị B','tranthib@example.com','0901234568','$2y$10$abcdefghijklmnopqrstuv','avatar02.jpg',0,'KhachHang'),('ghi789','Lê Văn C','levanc@example.com','0901234569','$2y$10$abcdefghijklmnopqrstuv','avatar03.jpg',0,'KhachHang'),('helloworld','Hello World','helloworld@gmail.com','0703114632','$2b$10$8cqMBwotgAqqyCBqgWDzKOWRgI4mMKh8kvfQDgqCnYZysEr33cYPW','https://res.cloudinary.com/dy2bmisbi/image/upload/v1716211691/npwxuahrosftm8qvtfqf.jpg',0,'QuanTri'),('helloworld2','Hello World','helloworld2@gmail.com','0703114632','$2b$10$HuO6PcteLuQzjkbz/2yN9.uu9CY2lb.ru1uLfeTdeUv.FUwhjUEZK','https://res-console.cloudinary.com/dy2bmisbi/media_explorer_thumbnails/eaba9abebf0752561c049b0b9b808801/detailed',0,'KhachHang'),('helloworld3','Hello World','helloworld3@gmail.com','0703114632','$2b$10$LTTpnO0bw3mCppKgwTuqYe84J7g9FjEi1lk6ZeZl/QbAYMQqPlolC','https://res-console.cloudinary.com/dy2bmisbi/media_explorer_thumbnails/eaba9abebf0752561c049b0b9b808801/detailed',0,'KhachHang'),('helloworld4','Hello World','helloworld4@gmail.com','0703114632','$2b$10$yNbnSIZuSw7.Kh00KgWOYOGWlMcJagaW7tDB8nWUksgaSBtotGNyC','https://res.cloudinary.com/dy2bmisbi/image/upload/v1716211691/default-avatar.jpg',0,'KhachHang'),('helloworld5','Hello World','helloworld5@gmail.com','0703114632','$2b$10$poBiUX4yw.ufyMZLzMTWsu2hceHuF.KzLY9oP/dvamW9mQMZnq2tu','https://res.cloudinary.com/dy2bmisbi/image/upload/v1716211691/default-avatar.jpg',0,'KhachHang'),('jkl012','Phạm Thị D','phamthid@example.com','0901234570','$2y$10$abcdefghijklmnopqrstuv','avatar04.jpg',0,'KhachHang'),('miphat12','Mi Phát','miphat12@gmail.com','0703114632','$2b$10$1QPHGBqSPMOXJQmwbN7ipOa2u0RjLtWKaWKdrg7Ie80.QpdEU/e02','https://res.cloudinary.com/dy2bmisbi/image/upload/v1716211691/npwxuahrosftm8qvtfqf.jpg',0,'KhachHang'),('miphat123','Tôi là User vừa Update','phannguyenminhphat1@gmail.com','0703114632','$2b$10$BRTttsVkb0yRExBwZ7VX/.dHgf9FB6cyBuqzqI4KG1QC4PS.GI/MC','http://res.cloudinary.com/dy2bmisbi/image/upload/v1719556972/thlbmgsnzmbde1tce61y.jpg',0,'KhachHang'),('miphat1234','Minh Phát','miphat1234@gmail.com','0703114632','$2b$10$IHD0YbxmmgxHWhQLKf242O4JW3ivH.JFfjRmJ57U.3589TGPxn5EO','https://res.cloudinary.com/dy2bmisbi/image/upload/v1716211691/npwxuahrosftm8qvtfqf.jpg',0,'KhachHang'),('miphat12345','Minh Phát','abcasdbashdjb@gmail.com','0703114632','$2b$10$cIY.uxhE0iD9oL/xvwYn1.x4ioZ1gPdOgEAscDAlteH3W0qW2sYF.','http://res.cloudinary.com/dy2bmisbi/image/upload/v1718207019/zzodb25n8y2nshgs4ng8.png',0,'KhachHang'),('mno345','Vũ Văn E','vuvane@example.com','0901234571','$2y$10$abcdefghijklmnopqrstuv','avatar05.jpg',0,'KhachHang'),('nguyenminhphatphan','MiPhatNek','havantrung@gmail.com','0703114632','$2b$10$rXul7s.VuPHigvdAxl/HGuKv38NeuHEu2wUSz1K7ktn1ISe8aol4m','https://res.cloudinary.com/dy2bmisbi/image/upload/v1716211691/npwxuahrosftm8qvtfqf.jpg',0,'KhachHang'),('PostMan','Post Man','hellworld5@gmail.com','0703114632','$2b$10$OMY.RoUwXUi59htezx1WbOxKB77TtVldHA2fynrSus6krxTiWR7ke','https://res.cloudinary.com/dy2bmisbi/image/upload/v1716211691/default-avatar.jpg',0,'KhachHang'),('PostMan123','Post Man','postman123@gmail.com','0703114632','$2b$10$3y34zHBhPpP4jyWCd4lMH.QVX5SXNl7Sd.RTi26DilfkE34XeLLJG','https://res.cloudinary.com/dy2bmisbi/image/upload/v1716211691/default-avatar.jpg',0,'KhachHang'),('pqr678','Đặng Thị F','dangthif@example.com','0901234572','$2y$10$abcdefghijklmnopqrstuv','avatar06.jpg',0,'KhachHang'),('stu901','Hoàng Văn G','hoangvang@example.com','0901234573','$2y$10$abcdefghijklmnopqrstuv','avatar07.jpg',0,'KhachHang'),('vwx234','Ngô Thị H','ngothih@example.com','0901234574','$2y$10$abcdefghijklmnopqrstuv','avatar08.jpg',0,'KhachHang'),('yz5678','Bùi Thị I','buivani@example.com','0703114632','$2b$10$OPBU/jADRwv2Q52cXQIjfesw.Ft1tLjUvKUmpNE/MhAucs2Lo95gK','avatar09.jpg',1,'QuanTri');
/*!40000 ALTER TABLE `nguoi_dung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phim`
--

DROP TABLE IF EXISTS `phim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phim` (
  `ma_phim` int NOT NULL AUTO_INCREMENT,
  `ten_phim` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `trailer` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `hinh_anh` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `mo_ta` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ngay_khoi_chieu` date DEFAULT NULL,
  `danh_gia` int DEFAULT NULL,
  `hot` tinyint(1) DEFAULT NULL,
  `dang_chieu` tinyint(1) DEFAULT NULL,
  `sap_chieu` tinyint(1) DEFAULT NULL,
  `da_xoa` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ma_phim`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phim`
--

LOCK TABLES `phim` WRITE;
/*!40000 ALTER TABLE `phim` DISABLE KEYS */;
INSERT INTO `phim` VALUES (1,'Đây là phim Mắt biếc vừa update','https://www.youtube.com/watch?v=ITlQ0oU7tDA','http://res.cloudinary.com/dy2bmisbi/image/upload/v1719557729/frhbiveym1jz7sbabnan.jpg','Một câu chuyện tình đẹp và đau buồn giữa Ngạn và Hà Lan, từ những ngày thơ ấu cho đến khi trưởng thành.','2023-12-05',5,1,0,0,0),(2,'Hai Phượng','https://www.youtube.com/watch?v=Rf6fxWKnPOM','hai_phuong.jpg','Hai Phượng là một người mẹ đơn thân, cô phải chiến đấu để giải cứu con gái mình khỏi một tổ chức buôn người.','2019-02-22',8,1,0,0,0),(3,'Cua Lại Vợ Bầu','https://www.youtube.com/watch?v=fTF8O2M72KQ','cua_lai_vo_bau.jpg','Một câu chuyện hài hước về cuộc tình tay ba và những tình huống dở khóc dở cười.','2019-02-05',7,1,0,0,0),(4,'Em Là Bà Nội Của Anh','https://www.youtube.com/watch?v=WXGQ_g0K4Kc','em_la_ba_noi_cua_anh.jpg','Một bà cụ già hóa thân thành cô gái trẻ và bắt đầu cuộc sống mới đầy thú vị và cũng không kém phần rắc rối.','2015-12-11',8,1,0,0,0),(5,'Tôi Thấy Hoa Vàng Trên Cỏ Xanh','https://www.youtube.com/watch?v=NiL2P1m3Lw4','toi_thay_hoa_vang_tren_co_xanh.jpg','Câu chuyện về tuổi thơ đầy ắp kỷ niệm tại một làng quê Việt Nam.','2015-10-02',8,1,0,0,0),(6,'Lật Mặt 4: Nhà Có Khách','https://www.youtube.com/watch?v=5V7Ulgp4wj0','lat_mat_4.jpg','Một nhóm bạn đối mặt với những hiện tượng kỳ lạ trong ngôi nhà hoang.','2019-04-12',7,1,0,0,0),(7,'Chị Mười Ba: 3 Ngày Sinh Tử','https://www.youtube.com/watch?v=H21b8mJxtWc','chi_muoi_ba.jpg','Tiếp tục câu chuyện về nữ giang hồ Chị Mười Ba và cuộc chiến sinh tử.','2020-12-18',7,1,0,0,0),(8,'Người Bất Tử','https://www.youtube.com/watch?v=wU7GZpRmxk4','nguoi_bat_tu.jpg','Một người đàn ông tìm kiếm sự bất tử thông qua các phương pháp kỳ bí và phải đối mặt với hậu quả khôn lường.','2018-10-26',7,1,0,0,0),(9,'Sống Cùng Lịch Sử','https://www.youtube.com/watch?v=C1y1ghOC6dY','song_cung_lich_su.jpg','Câu chuyện về những người lính Việt Nam anh dũng trong cuộc chiến tranh.','2014-08-01',6,1,0,0,0),(10,'Bỗng Dưng Muốn Khóc','https://www.youtube.com/watch?v=RmD1ivE5x-U','bong_dung_muon_khoc.jpg','Câu chuyện tình yêu hài hước giữa một chàng trai giàu có và một cô gái nghèo.','2008-04-14',8,1,0,0,0),(11,'lkjdhabsddd','https://www.youtube.com/watch?v=DEuLBOS3cdE','http://res.cloudinary.com/dy2bmisbi/image/upload/v1718340457/xqgi0ukicrugqajz1pij.jpg','abhsdfashbfshdjabfashbfhjabfhajbfahjbfsdhabfjhasfj ajbfasjhdfsjadfsajhfsajhfajhsbfhsadbfhsjafsajbfahfba','2024-01-03',0,0,0,1,NULL),(12,'assk','https://www.youtube.com/watch?v=DEuLBOS3cdE','http://res.cloudinary.com/dy2bmisbi/image/upload/v1718343877/zqa3aww80vjkjuxqk5qw.jpg','abhsdfashbfshdjabfashbfhjabfhajbfahjbfsdhabfjhasfj ajbfasjhdfsjadfsajhfsajhfajhsbfhsadbfhsjafsajbfahfba','2023-02-08',0,0,0,1,NULL),(13,'asskwwww','https://www.youtube.com/watch?v=DEuLBOS3cdE','http://res.cloudinary.com/dy2bmisbi/image/upload/v1718344056/dnayaipfqbbqusgplamx.jpg','abhsdfashbfshdjabfashbfhjabfhajbfahjbfsdhabfjhasfj ajbfasjhdfsjadfsajhfsajhfajhsbfhsadbfhsjafsajbfahfba','2023-02-08',0,0,0,1,0),(14,'asskwwwws','https://www.youtube.com/watch?v=DEuLBOS3cdE','http://res.cloudinary.com/dy2bmisbi/image/upload/v1718344246/cxk9dlyzqtoncahkezri.jpg','abhsdfashbfshdjabfashbfhjabfhajbfahjbfsdhabfjhasfj ajbfasjhdfsjadfsajhfsajhfajhsbfhsadbfhsjafsajbfahfba','2023-02-08',1,0,0,1,0),(16,'asskwwwwssaddd','https://www.youtube.com/watch?v=DEuLBOS3cdE','http://res.cloudinary.com/dy2bmisbi/image/upload/v1718347516/e2ujzpbapcbfoebfosyh.jpg','abhsdfashbfshdjabfashbfhjabfhajbfahjbfsdhabfjhasfj ajbfasjhdfsjadfsajhfsajhfajhsbfhsadbfhsjafsajbfahfba','2023-02-08',1,0,0,1,0),(17,'Cảm mơn rất nhiều','ASJhdajdkbaskdjbnjbb','http://res.cloudinary.com/dy2bmisbi/image/upload/v1718368403/c5vta0uhti7bpxys0wl0.jpg','ajsfbahbfshjdbfsdfhsdvgdfhs','2024-06-14',3,0,0,0,0),(18,'Cảm mơn rất nhiềuu','ASJhdajdkbaskdjbnjbbs','http://res.cloudinary.com/dy2bmisbi/image/upload/v1718368504/jcvrzsaioqqjwh5zw4ya.png','ajsfbahbfshjdbfsdfhsdvgdfhss','2024-06-15',4,1,1,1,0),(19,'Test Phim Thôi','asdhbashdbsahdbsahdbadhb','http://res.cloudinary.com/dy2bmisbi/image/upload/v1718431916/dzwzsel3umra4tmu92pz.jpg','dhbashdbashbashdbashdbasdhjasbdhabshdb','2024-02-03',3,0,1,0,0),(20,'ddasdsad','https://www.youtube.com/watch?v=DEuLBOS3cdE','http://res.cloudinary.com/dy2bmisbi/image/upload/v1718436184/f5dfn34qj6x7qd5w0qui.jpg','abhsdfashbfshdjabfashbfhjabfhajbfahjbfsdhabfjhasfj ajbfasjhdfsjadfsajhfsajhfajhsbfhsadbfhsjafsajbfahfba','2023-02-08',1,0,0,0,0),(21,'Đây là 1 bộ phim mới tạo','https://www.youtube.com/watch?v=DEuLBOS3cd','http://res.cloudinary.com/dy2bmisbi/image/upload/v1719557661/elmcuhl99hworff9bgrm.jpg','đây là mô tả của phim','2023-02-08',1,1,0,0,0);
/*!40000 ALTER TABLE `phim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rap_phim`
--

DROP TABLE IF EXISTS `rap_phim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rap_phim` (
  `ma_rap` int NOT NULL AUTO_INCREMENT,
  `ten_rap` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ma_cum_rap` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ma_rap`),
  KEY `ma_cum_rap` (`ma_cum_rap`),
  CONSTRAINT `rap_phim_ibfk_1` FOREIGN KEY (`ma_cum_rap`) REFERENCES `cum_rap` (`ma_cum_rap`)
) ENGINE=InnoDB AUTO_INCREMENT=1061 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rap_phim`
--

LOCK TABLES `rap_phim` WRITE;
/*!40000 ALTER TABLE `rap_phim` DISABLE KEYS */;
INSERT INTO `rap_phim` VALUES (531,'Rạp 1','cgv-aeon-tan-phu'),(532,'Rạp 2','cgv-aeon-tan-phu'),(533,'Rạp 3','cgv-aeon-tan-phu'),(534,'Rạp 4','cgv-aeon-tan-phu'),(535,'Rạp 5','cgv-aeon-tan-phu'),(536,'Rạp 6','cgv-aeon-tan-phu'),(537,'Rạp 7','cgv-aeon-tan-phu'),(538,'Rạp 8','cgv-aeon-tan-phu'),(539,'Rạp 9','cgv-aeon-tan-phu'),(540,'Rạp 10','cgv-aeon-tan-phu'),(541,'Rạp 11','cgv-crescent-mall'),(542,'Rạp 12','cgv-crescent-mall'),(543,'Rạp 13','cgv-crescent-mall'),(544,'Rạp 14','cgv-crescent-mall'),(545,'Rạp 15','cgv-crescent-mall'),(546,'Rạp 16','cgv-crescent-mall'),(547,'Rạp 17','cgv-crescent-mall'),(548,'Rạp 18','cgv-crescent-mall'),(549,'Rạp 19','cgv-crescent-mall'),(550,'Rạp 20','cgv-crescent-mall'),(551,'Rạp 21','cgv-hung-vuong-plaza'),(552,'Rạp 22','cgv-hung-vuong-plaza'),(553,'Rạp 23','cgv-hung-vuong-plaza'),(554,'Rạp 24','cgv-hung-vuong-plaza'),(555,'Rạp 25','cgv-hung-vuong-plaza'),(556,'Rạp 26','cgv-hung-vuong-plaza'),(557,'Rạp 27','cgv-hung-vuong-plaza'),(558,'Rạp 28','cgv-hung-vuong-plaza'),(559,'Rạp 29','cgv-hung-vuong-plaza'),(560,'Rạp 30','cgv-hung-vuong-plaza'),(561,'Rạp 31','cgv-imc-tran-quang-khai'),(562,'Rạp 32','cgv-imc-tran-quang-khai'),(563,'Rạp 33','cgv-imc-tran-quang-khai'),(564,'Rạp 34','cgv-imc-tran-quang-khai'),(565,'Rạp 35','cgv-imc-tran-quang-khai'),(566,'Rạp 36','cgv-imc-tran-quang-khai'),(567,'Rạp 37','cgv-imc-tran-quang-khai'),(568,'Rạp 38','cgv-imc-tran-quang-khai'),(569,'Rạp 39','cgv-imc-tran-quang-khai'),(570,'Rạp 40','cgv-imc-tran-quang-khai'),(571,'Rạp 41','cgv-liberty-citypoint'),(572,'Rạp 42','cgv-liberty-citypoint'),(573,'Rạp 43','cgv-liberty-citypoint'),(574,'Rạp 44','cgv-liberty-citypoint'),(575,'Rạp 45','cgv-liberty-citypoint'),(576,'Rạp 46','cgv-liberty-citypoint'),(577,'Rạp 47','cgv-liberty-citypoint'),(578,'Rạp 48','cgv-liberty-citypoint'),(579,'Rạp 49','cgv-liberty-citypoint'),(580,'Rạp 50','cgv-liberty-citypoint'),(581,'Rạp 51','cgv-pandora-city'),(582,'Rạp 52','cgv-pandora-city'),(583,'Rạp 53','cgv-pandora-city'),(584,'Rạp 54','cgv-pandora-city'),(585,'Rạp 55','cgv-pandora-city'),(586,'Rạp 56','cgv-pandora-city'),(587,'Rạp 57','cgv-pandora-city'),(588,'Rạp 58','cgv-pandora-city'),(589,'Rạp 59','cgv-pandora-city'),(590,'Rạp 60','cgv-pandora-city'),(591,'Rạp 61','cgv-paragon'),(592,'Rạp 62','cgv-paragon'),(593,'Rạp 63','cgv-paragon'),(594,'Rạp 64','cgv-paragon'),(595,'Rạp 65','cgv-paragon'),(596,'Rạp 66','cgv-paragon'),(597,'Rạp 67','cgv-paragon'),(598,'Rạp 68','cgv-paragon'),(599,'Rạp 69','cgv-paragon'),(600,'Rạp 70','cgv-paragon'),(601,'Rạp 71','cgv-pearl-plaza'),(602,'Rạp 72','cgv-pearl-plaza'),(603,'Rạp 73','cgv-pearl-plaza'),(604,'Rạp 74','cgv-pearl-plaza'),(605,'Rạp 75','cgv-pearl-plaza'),(606,'Rạp 76','cgv-pearl-plaza'),(607,'Rạp 77','cgv-pearl-plaza'),(608,'Rạp 78','cgv-pearl-plaza'),(609,'Rạp 79','cgv-pearl-plaza'),(610,'Rạp 80','cgv-pearl-plaza'),(611,'Rạp 81','cgv-satra-c-trung-chanh'),(612,'Rạp 82','cgv-satra-c-trung-chanh'),(613,'Rạp 83','cgv-satra-c-trung-chanh'),(614,'Rạp 84','cgv-satra-c-trung-chanh'),(615,'Rạp 85','cgv-satra-c-trung-chanh'),(616,'Rạp 86','cgv-satra-c-trung-chanh'),(617,'Rạp 87','cgv-satra-c-trung-chanh'),(618,'Rạp 88','cgv-satra-c-trung-chanh'),(619,'Rạp 89','cgv-satra-c-trung-chanh'),(620,'Rạp 90','cgv-satra-c-trung-chanh'),(621,'Rạp 91','cgv-thao-dien-pearl'),(622,'Rạp 92','cgv-thao-dien-pearl'),(623,'Rạp 93','cgv-thao-dien-pearl'),(624,'Rạp 94','cgv-thao-dien-pearl'),(625,'Rạp 95','cgv-thao-dien-pearl'),(626,'Rạp 96','cgv-thao-dien-pearl'),(627,'Rạp 97','cgv-thao-dien-pearl'),(628,'Rạp 98','cgv-thao-dien-pearl'),(629,'Rạp 99','cgv-thao-dien-pearl'),(630,'Rạp 100','cgv-thao-dien-pearl'),(631,'Rạp 101','cgv-vincom-dong-khoi'),(632,'Rạp 102','cgv-vincom-dong-khoi'),(633,'Rạp 103','cgv-vincom-dong-khoi'),(634,'Rạp 104','cgv-vincom-dong-khoi'),(635,'Rạp 105','cgv-vincom-dong-khoi'),(636,'Rạp 106','cgv-vincom-dong-khoi'),(637,'Rạp 107','cgv-vincom-dong-khoi'),(638,'Rạp 108','cgv-vincom-dong-khoi'),(639,'Rạp 109','cgv-vincom-dong-khoi'),(640,'Rạp 110','cgv-vincom-dong-khoi'),(641,'Rạp 111','cgv-vincom-go-vap'),(642,'Rạp 112','cgv-vincom-go-vap'),(643,'Rạp 113','cgv-vincom-go-vap'),(644,'Rạp 114','cgv-vincom-go-vap'),(645,'Rạp 115','cgv-vincom-go-vap'),(646,'Rạp 116','cgv-vincom-go-vap'),(647,'Rạp 117','cgv-vincom-go-vap'),(648,'Rạp 118','cgv-vincom-go-vap'),(649,'Rạp 119','cgv-vincom-go-vap'),(650,'Rạp 120','cgv-vincom-go-vap'),(651,'Rạp 121','cgv-vincom-thu-duc'),(652,'Rạp 122','cgv-vincom-thu-duc'),(653,'Rạp 123','cgv-vincom-thu-duc'),(654,'Rạp 124','cgv-vincom-thu-duc'),(655,'Rạp 125','cgv-vincom-thu-duc'),(656,'Rạp 126','cgv-vincom-thu-duc'),(657,'Rạp 127','cgv-vincom-thu-duc'),(658,'Rạp 128','cgv-vincom-thu-duc'),(659,'Rạp 129','cgv-vincom-thu-duc'),(660,'Rạp 130','cgv-vincom-thu-duc'),(661,'Rạp 1','bhd-star-bitexco'),(662,'Rạp 2','bhd-star-bitexco'),(663,'Rạp 3','bhd-star-bitexco'),(664,'Rạp 4','bhd-star-bitexco'),(665,'Rạp 5','bhd-star-bitexco'),(666,'Rạp 6','bhd-star-bitexco'),(667,'Rạp 7','bhd-star-bitexco'),(668,'Rạp 8','bhd-star-bitexco'),(669,'Rạp 9','bhd-star-bitexco'),(670,'Rạp 10','bhd-star-bitexco'),(671,'Rạp 11','bhd-star-3-2'),(672,'Rạp 12','bhd-star-3-2'),(673,'Rạp 13','bhd-star-3-2'),(674,'Rạp 14','bhd-star-3-2'),(675,'Rạp 15','bhd-star-3-2'),(676,'Rạp 16','bhd-star-3-2'),(677,'Rạp 17','bhd-star-3-2'),(678,'Rạp 18','bhd-star-3-2'),(679,'Rạp 19','bhd-star-3-2'),(680,'Rạp 20','bhd-star-3-2'),(681,'Rạp 21','bhd-star-pham-hung'),(682,'Rạp 22','bhd-star-pham-hung'),(683,'Rạp 23','bhd-star-pham-hung'),(684,'Rạp 24','bhd-star-pham-hung'),(685,'Rạp 25','bhd-star-pham-hung'),(686,'Rạp 26','bhd-star-pham-hung'),(687,'Rạp 27','bhd-star-pham-hung'),(688,'Rạp 28','bhd-star-pham-hung'),(689,'Rạp 29','bhd-star-pham-hung'),(690,'Rạp 30','bhd-star-pham-hung'),(691,'Rạp 31','bhd-star-thao-dien'),(692,'Rạp 32','bhd-star-thao-dien'),(693,'Rạp 33','bhd-star-thao-dien'),(694,'Rạp 34','bhd-star-thao-dien'),(695,'Rạp 35','bhd-star-thao-dien'),(696,'Rạp 36','bhd-star-thao-dien'),(697,'Rạp 37','bhd-star-thao-dien'),(698,'Rạp 38','bhd-star-thao-dien'),(699,'Rạp 39','bhd-star-thao-dien'),(700,'Rạp 40','bhd-star-thao-dien'),(701,'Rạp 41','bhd-star-quang-trung'),(702,'Rạp 42','bhd-star-quang-trung'),(703,'Rạp 43','bhd-star-quang-trung'),(704,'Rạp 44','bhd-star-quang-trung'),(705,'Rạp 45','bhd-star-quang-trung'),(706,'Rạp 46','bhd-star-quang-trung'),(707,'Rạp 47','bhd-star-quang-trung'),(708,'Rạp 48','bhd-star-quang-trung'),(709,'Rạp 49','bhd-star-quang-trung'),(710,'Rạp 50','bhd-star-quang-trung'),(711,'Rạp 51','bhd-star-vincom-le-van-viet'),(712,'Rạp 52','bhd-star-vincom-le-van-viet'),(713,'Rạp 53','bhd-star-vincom-le-van-viet'),(714,'Rạp 54','bhd-star-vincom-le-van-viet'),(715,'Rạp 55','bhd-star-vincom-le-van-viet'),(716,'Rạp 56','bhd-star-vincom-le-van-viet'),(717,'Rạp 57','bhd-star-vincom-le-van-viet'),(718,'Rạp 58','bhd-star-vincom-le-van-viet'),(719,'Rạp 59','bhd-star-vincom-le-van-viet'),(720,'Rạp 60','bhd-star-vincom-le-van-viet'),(721,'Rạp 61','bhd-star-vincom-nguyen-xi'),(722,'Rạp 62','bhd-star-vincom-nguyen-xi'),(723,'Rạp 63','bhd-star-vincom-nguyen-xi'),(724,'Rạp 64','bhd-star-vincom-nguyen-xi'),(725,'Rạp 65','bhd-star-vincom-nguyen-xi'),(726,'Rạp 66','bhd-star-vincom-nguyen-xi'),(727,'Rạp 67','bhd-star-vincom-nguyen-xi'),(728,'Rạp 68','bhd-star-vincom-nguyen-xi'),(729,'Rạp 69','bhd-star-vincom-nguyen-xi'),(730,'Rạp 70','bhd-star-vincom-nguyen-xi'),(731,'Rạp 71','bhd-star-vincom-ba-trieu'),(732,'Rạp 72','bhd-star-vincom-ba-trieu'),(733,'Rạp 73','bhd-star-vincom-ba-trieu'),(734,'Rạp 74','bhd-star-vincom-ba-trieu'),(735,'Rạp 75','bhd-star-vincom-ba-trieu'),(736,'Rạp 76','bhd-star-vincom-ba-trieu'),(737,'Rạp 77','bhd-star-vincom-ba-trieu'),(738,'Rạp 78','bhd-star-vincom-ba-trieu'),(739,'Rạp 79','bhd-star-vincom-ba-trieu'),(740,'Rạp 80','bhd-star-vincom-ba-trieu'),(741,'Rạp 81','bhd-star-vincom-nguyen-chi-thanh'),(742,'Rạp 82','bhd-star-vincom-nguyen-chi-thanh'),(743,'Rạp 83','bhd-star-vincom-nguyen-chi-thanh'),(744,'Rạp 84','bhd-star-vincom-nguyen-chi-thanh'),(745,'Rạp 85','bhd-star-vincom-nguyen-chi-thanh'),(746,'Rạp 86','bhd-star-vincom-nguyen-chi-thanh'),(747,'Rạp 87','bhd-star-vincom-nguyen-chi-thanh'),(748,'Rạp 88','bhd-star-vincom-nguyen-chi-thanh'),(749,'Rạp 89','bhd-star-vincom-nguyen-chi-thanh'),(750,'Rạp 90','bhd-star-vincom-nguyen-chi-thanh'),(751,'Rạp 91','bhd-star-vincom-long-bien'),(752,'Rạp 92','bhd-star-vincom-long-bien'),(753,'Rạp 93','bhd-star-vincom-long-bien'),(754,'Rạp 94','bhd-star-vincom-long-bien'),(755,'Rạp 95','bhd-star-vincom-long-bien'),(756,'Rạp 96','bhd-star-vincom-long-bien'),(757,'Rạp 97','bhd-star-vincom-long-bien'),(758,'Rạp 98','bhd-star-vincom-long-bien'),(759,'Rạp 99','bhd-star-vincom-long-bien'),(760,'Rạp 100','bhd-star-vincom-long-bien'),(761,'Rạp 1','cinestar-hai-ba-trung'),(762,'Rạp 2','cinestar-hai-ba-trung'),(763,'Rạp 3','cinestar-hai-ba-trung'),(764,'Rạp 4','cinestar-hai-ba-trung'),(765,'Rạp 5','cinestar-hai-ba-trung'),(766,'Rạp 6','cinestar-hai-ba-trung'),(767,'Rạp 7','cinestar-hai-ba-trung'),(768,'Rạp 8','cinestar-hai-ba-trung'),(769,'Rạp 9','cinestar-hai-ba-trung'),(770,'Rạp 10','cinestar-hai-ba-trung'),(771,'Rạp 11','cinestar-quoc-thao'),(772,'Rạp 12','cinestar-quoc-thao'),(773,'Rạp 13','cinestar-quoc-thao'),(774,'Rạp 14','cinestar-quoc-thao'),(775,'Rạp 15','cinestar-quoc-thao'),(776,'Rạp 16','cinestar-quoc-thao'),(777,'Rạp 17','cinestar-quoc-thao'),(778,'Rạp 18','cinestar-quoc-thao'),(779,'Rạp 19','cinestar-quoc-thao'),(780,'Rạp 20','cinestar-quoc-thao'),(781,'Rạp 21','cinestar-binh-thanh'),(782,'Rạp 22','cinestar-binh-thanh'),(783,'Rạp 23','cinestar-binh-thanh'),(784,'Rạp 24','cinestar-binh-thanh'),(785,'Rạp 25','cinestar-binh-thanh'),(786,'Rạp 26','cinestar-binh-thanh'),(787,'Rạp 27','cinestar-binh-thanh'),(788,'Rạp 28','cinestar-binh-thanh'),(789,'Rạp 29','cinestar-binh-thanh'),(790,'Rạp 30','cinestar-binh-thanh'),(791,'Rạp 31','cinestar-hoa-binh'),(792,'Rạp 32','cinestar-hoa-binh'),(793,'Rạp 33','cinestar-hoa-binh'),(794,'Rạp 34','cinestar-hoa-binh'),(795,'Rạp 35','cinestar-hoa-binh'),(796,'Rạp 36','cinestar-hoa-binh'),(797,'Rạp 37','cinestar-hoa-binh'),(798,'Rạp 38','cinestar-hoa-binh'),(799,'Rạp 39','cinestar-hoa-binh'),(800,'Rạp 40','cinestar-hoa-binh'),(801,'Rạp 41','cinestar-nha-be'),(802,'Rạp 42','cinestar-nha-be'),(803,'Rạp 43','cinestar-nha-be'),(804,'Rạp 44','cinestar-nha-be'),(805,'Rạp 45','cinestar-nha-be'),(806,'Rạp 46','cinestar-nha-be'),(807,'Rạp 47','cinestar-nha-be'),(808,'Rạp 48','cinestar-nha-be'),(809,'Rạp 49','cinestar-nha-be'),(810,'Rạp 50','cinestar-nha-be'),(811,'Rạp 51','cinestar-can-tho'),(812,'Rạp 52','cinestar-can-tho'),(813,'Rạp 53','cinestar-can-tho'),(814,'Rạp 54','cinestar-can-tho'),(815,'Rạp 55','cinestar-can-tho'),(816,'Rạp 56','cinestar-can-tho'),(817,'Rạp 57','cinestar-can-tho'),(818,'Rạp 58','cinestar-can-tho'),(819,'Rạp 59','cinestar-can-tho'),(820,'Rạp 60','cinestar-can-tho'),(821,'Rạp 61','cinestar-da-nang'),(822,'Rạp 62','cinestar-da-nang'),(823,'Rạp 63','cinestar-da-nang'),(824,'Rạp 64','cinestar-da-nang'),(825,'Rạp 65','cinestar-da-nang'),(826,'Rạp 66','cinestar-da-nang'),(827,'Rạp 67','cinestar-da-nang'),(828,'Rạp 68','cinestar-da-nang'),(829,'Rạp 69','cinestar-da-nang'),(830,'Rạp 70','cinestar-da-nang'),(831,'Rạp 71','cinestar-hai-phong'),(832,'Rạp 72','cinestar-hai-phong'),(833,'Rạp 73','cinestar-hai-phong'),(834,'Rạp 74','cinestar-hai-phong'),(835,'Rạp 75','cinestar-hai-phong'),(836,'Rạp 76','cinestar-hai-phong'),(837,'Rạp 77','cinestar-hai-phong'),(838,'Rạp 78','cinestar-hai-phong'),(839,'Rạp 79','cinestar-hai-phong'),(840,'Rạp 80','cinestar-hai-phong'),(841,'Rạp 81','cinestar-nha-trang'),(842,'Rạp 82','cinestar-nha-trang'),(843,'Rạp 83','cinestar-nha-trang'),(844,'Rạp 84','cinestar-nha-trang'),(845,'Rạp 85','cinestar-nha-trang'),(846,'Rạp 86','cinestar-nha-trang'),(847,'Rạp 87','cinestar-nha-trang'),(848,'Rạp 88','cinestar-nha-trang'),(849,'Rạp 89','cinestar-nha-trang'),(850,'Rạp 90','cinestar-nha-trang'),(851,'Rạp 91','cinestar-vung-tau'),(852,'Rạp 92','cinestar-vung-tau'),(853,'Rạp 93','cinestar-vung-tau'),(854,'Rạp 94','cinestar-vung-tau'),(855,'Rạp 95','cinestar-vung-tau'),(856,'Rạp 96','cinestar-vung-tau'),(857,'Rạp 97','cinestar-vung-tau'),(858,'Rạp 98','cinestar-vung-tau'),(859,'Rạp 99','cinestar-vung-tau'),(860,'Rạp 100','cinestar-vung-tau'),(861,'Rạp 1','galaxy-kinh-duong-vuong'),(862,'Rạp 2','galaxy-kinh-duong-vuong'),(863,'Rạp 3','galaxy-kinh-duong-vuong'),(864,'Rạp 4','galaxy-kinh-duong-vuong'),(865,'Rạp 5','galaxy-kinh-duong-vuong'),(866,'Rạp 6','galaxy-kinh-duong-vuong'),(867,'Rạp 7','galaxy-kinh-duong-vuong'),(868,'Rạp 8','galaxy-kinh-duong-vuong'),(869,'Rạp 9','galaxy-kinh-duong-vuong'),(870,'Rạp 10','galaxy-kinh-duong-vuong'),(871,'Rạp 11','galaxy-nguyen-du'),(872,'Rạp 12','galaxy-nguyen-du'),(873,'Rạp 13','galaxy-nguyen-du'),(874,'Rạp 14','galaxy-nguyen-du'),(875,'Rạp 15','galaxy-nguyen-du'),(876,'Rạp 16','galaxy-nguyen-du'),(877,'Rạp 17','galaxy-nguyen-du'),(878,'Rạp 18','galaxy-nguyen-du'),(879,'Rạp 19','galaxy-nguyen-du'),(880,'Rạp 20','galaxy-nguyen-du'),(881,'Rạp 21','galaxy-quang-trung'),(882,'Rạp 22','galaxy-quang-trung'),(883,'Rạp 23','galaxy-quang-trung'),(884,'Rạp 24','galaxy-quang-trung'),(885,'Rạp 25','galaxy-quang-trung'),(886,'Rạp 26','galaxy-quang-trung'),(887,'Rạp 27','galaxy-quang-trung'),(888,'Rạp 28','galaxy-quang-trung'),(889,'Rạp 29','galaxy-quang-trung'),(890,'Rạp 30','galaxy-quang-trung'),(891,'Rạp 31','galaxy-tan-binh'),(892,'Rạp 32','galaxy-tan-binh'),(893,'Rạp 33','galaxy-tan-binh'),(894,'Rạp 34','galaxy-tan-binh'),(895,'Rạp 35','galaxy-tan-binh'),(896,'Rạp 36','galaxy-tan-binh'),(897,'Rạp 37','galaxy-tan-binh'),(898,'Rạp 38','galaxy-tan-binh'),(899,'Rạp 39','galaxy-tan-binh'),(900,'Rạp 40','galaxy-tan-binh'),(901,'Rạp 41','galaxy-huynh-tan-phat'),(902,'Rạp 42','galaxy-huynh-tan-phat'),(903,'Rạp 43','galaxy-huynh-tan-phat'),(904,'Rạp 44','galaxy-huynh-tan-phat'),(905,'Rạp 45','galaxy-huynh-tan-phat'),(906,'Rạp 46','galaxy-huynh-tan-phat'),(907,'Rạp 47','galaxy-huynh-tan-phat'),(908,'Rạp 48','galaxy-huynh-tan-phat'),(909,'Rạp 49','galaxy-huynh-tan-phat'),(910,'Rạp 50','galaxy-huynh-tan-phat'),(911,'Rạp 51','galaxy-long-xuyen'),(912,'Rạp 52','galaxy-long-xuyen'),(913,'Rạp 53','galaxy-long-xuyen'),(914,'Rạp 54','galaxy-long-xuyen'),(915,'Rạp 55','galaxy-long-xuyen'),(916,'Rạp 56','galaxy-long-xuyen'),(917,'Rạp 57','galaxy-long-xuyen'),(918,'Rạp 58','galaxy-long-xuyen'),(919,'Rạp 59','galaxy-long-xuyen'),(920,'Rạp 60','galaxy-long-xuyen'),(921,'Rạp 61','galaxy-trung-chanh'),(922,'Rạp 62','galaxy-trung-chanh'),(923,'Rạp 63','galaxy-trung-chanh'),(924,'Rạp 64','galaxy-trung-chanh'),(925,'Rạp 65','galaxy-trung-chanh'),(926,'Rạp 66','galaxy-trung-chanh'),(927,'Rạp 67','galaxy-trung-chanh'),(928,'Rạp 68','galaxy-trung-chanh'),(929,'Rạp 69','galaxy-trung-chanh'),(930,'Rạp 70','galaxy-trung-chanh'),(931,'Rạp 71','galaxy-vung-tau'),(932,'Rạp 72','galaxy-vung-tau'),(933,'Rạp 73','galaxy-vung-tau'),(934,'Rạp 74','galaxy-vung-tau'),(935,'Rạp 75','galaxy-vung-tau'),(936,'Rạp 76','galaxy-vung-tau'),(937,'Rạp 77','galaxy-vung-tau'),(938,'Rạp 78','galaxy-vung-tau'),(939,'Rạp 79','galaxy-vung-tau'),(940,'Rạp 80','galaxy-vung-tau'),(941,'Rạp 81','galaxy-ben-tre'),(942,'Rạp 82','galaxy-ben-tre'),(943,'Rạp 83','galaxy-ben-tre'),(944,'Rạp 84','galaxy-ben-tre'),(945,'Rạp 85','galaxy-ben-tre'),(946,'Rạp 86','galaxy-ben-tre'),(947,'Rạp 87','galaxy-ben-tre'),(948,'Rạp 88','galaxy-ben-tre'),(949,'Rạp 89','galaxy-ben-tre'),(950,'Rạp 90','galaxy-ben-tre'),(951,'Rạp 91','galaxy-can-tho'),(952,'Rạp 92','galaxy-can-tho'),(953,'Rạp 93','galaxy-can-tho'),(954,'Rạp 94','galaxy-can-tho'),(955,'Rạp 95','galaxy-can-tho'),(956,'Rạp 96','galaxy-can-tho'),(957,'Rạp 97','galaxy-can-tho'),(958,'Rạp 98','galaxy-can-tho'),(959,'Rạp 99','galaxy-can-tho'),(960,'Rạp 100','galaxy-can-tho'),(961,'Rạp 1','lotte-cantavil'),(962,'Rạp 2','lotte-cantavil'),(963,'Rạp 3','lotte-cantavil'),(964,'Rạp 4','lotte-cantavil'),(965,'Rạp 5','lotte-cantavil'),(966,'Rạp 6','lotte-cantavil'),(967,'Rạp 7','lotte-cantavil'),(968,'Rạp 8','lotte-cantavil'),(969,'Rạp 9','lotte-cantavil'),(970,'Rạp 10','lotte-cantavil'),(971,'Rạp 11','lotte-cong-hoa'),(972,'Rạp 12','lotte-cong-hoa'),(973,'Rạp 13','lotte-cong-hoa'),(974,'Rạp 14','lotte-cong-hoa'),(975,'Rạp 15','lotte-cong-hoa'),(976,'Rạp 16','lotte-cong-hoa'),(977,'Rạp 17','lotte-cong-hoa'),(978,'Rạp 18','lotte-cong-hoa'),(979,'Rạp 19','lotte-cong-hoa'),(980,'Rạp 20','lotte-cong-hoa'),(981,'Rạp 21','lotte-go-vap'),(982,'Rạp 22','lotte-go-vap'),(983,'Rạp 23','lotte-go-vap'),(984,'Rạp 24','lotte-go-vap'),(985,'Rạp 25','lotte-go-vap'),(986,'Rạp 26','lotte-go-vap'),(987,'Rạp 27','lotte-go-vap'),(988,'Rạp 28','lotte-go-vap'),(989,'Rạp 29','lotte-go-vap'),(990,'Rạp 30','lotte-go-vap'),(991,'Rạp 31','lotte-thu-duc'),(992,'Rạp 32','lotte-thu-duc'),(993,'Rạp 33','lotte-thu-duc'),(994,'Rạp 34','lotte-thu-duc'),(995,'Rạp 35','lotte-thu-duc'),(996,'Rạp 36','lotte-thu-duc'),(997,'Rạp 37','lotte-thu-duc'),(998,'Rạp 38','lotte-thu-duc'),(999,'Rạp 39','lotte-thu-duc'),(1000,'Rạp 40','lotte-thu-duc'),(1001,'Rạp 41','lotte-phu-tho'),(1002,'Rạp 42','lotte-phu-tho'),(1003,'Rạp 43','lotte-phu-tho'),(1004,'Rạp 44','lotte-phu-tho'),(1005,'Rạp 45','lotte-phu-tho'),(1006,'Rạp 46','lotte-phu-tho'),(1007,'Rạp 47','lotte-phu-tho'),(1008,'Rạp 48','lotte-phu-tho'),(1009,'Rạp 49','lotte-phu-tho'),(1010,'Rạp 50','lotte-phu-tho'),(1011,'Rạp 51','lotte-binh-duong'),(1012,'Rạp 52','lotte-binh-duong'),(1013,'Rạp 53','lotte-binh-duong'),(1014,'Rạp 54','lotte-binh-duong'),(1015,'Rạp 55','lotte-binh-duong'),(1016,'Rạp 56','lotte-binh-duong'),(1017,'Rạp 57','lotte-binh-duong'),(1018,'Rạp 58','lotte-binh-duong'),(1019,'Rạp 59','lotte-binh-duong'),(1020,'Rạp 60','lotte-binh-duong'),(1021,'Rạp 61','lotte-can-tho'),(1022,'Rạp 62','lotte-can-tho'),(1023,'Rạp 63','lotte-can-tho'),(1024,'Rạp 64','lotte-can-tho'),(1025,'Rạp 65','lotte-can-tho'),(1026,'Rạp 66','lotte-can-tho'),(1027,'Rạp 67','lotte-can-tho'),(1028,'Rạp 68','lotte-can-tho'),(1029,'Rạp 69','lotte-can-tho'),(1030,'Rạp 70','lotte-can-tho'),(1031,'Rạp 71','lotte-da-nang'),(1032,'Rạp 72','lotte-da-nang'),(1033,'Rạp 73','lotte-da-nang'),(1034,'Rạp 74','lotte-da-nang'),(1035,'Rạp 75','lotte-da-nang'),(1036,'Rạp 76','lotte-da-nang'),(1037,'Rạp 77','lotte-da-nang'),(1038,'Rạp 78','lotte-da-nang'),(1039,'Rạp 79','lotte-da-nang'),(1040,'Rạp 80','lotte-da-nang'),(1041,'Rạp 81','lotte-nha-trang'),(1042,'Rạp 82','lotte-nha-trang'),(1043,'Rạp 83','lotte-nha-trang'),(1044,'Rạp 84','lotte-nha-trang'),(1045,'Rạp 85','lotte-nha-trang'),(1046,'Rạp 86','lotte-nha-trang'),(1047,'Rạp 87','lotte-nha-trang'),(1048,'Rạp 88','lotte-nha-trang'),(1049,'Rạp 89','lotte-nha-trang'),(1050,'Rạp 90','lotte-nha-trang'),(1051,'Rạp 91','lotte-vung-tau'),(1052,'Rạp 92','lotte-vung-tau'),(1053,'Rạp 93','lotte-vung-tau'),(1054,'Rạp 94','lotte-vung-tau'),(1055,'Rạp 95','lotte-vung-tau'),(1056,'Rạp 96','lotte-vung-tau'),(1057,'Rạp 97','lotte-vung-tau'),(1058,'Rạp 98','lotte-vung-tau'),(1059,'Rạp 99','lotte-vung-tau'),(1060,'Rạp 100','lotte-vung-tau');
/*!40000 ALTER TABLE `rap_phim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refresh_token`
--

DROP TABLE IF EXISTS `refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refresh_token` (
  `ma_refresh_token` varchar(500) NOT NULL,
  `tai_khoan` varchar(100) DEFAULT NULL,
  `ngay_tao` datetime DEFAULT NULL,
  `ngay_het_han` datetime DEFAULT NULL,
  PRIMARY KEY (`ma_refresh_token`),
  KEY `tai_khoan` (`tai_khoan`),
  CONSTRAINT `refresh_token_ibfk_1` FOREIGN KEY (`tai_khoan`) REFERENCES `nguoi_dung` (`tai_khoan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_token`
--

LOCK TABLES `refresh_token` WRITE;
/*!40000 ALTER TABLE `refresh_token` DISABLE KEYS */;
INSERT INTO `refresh_token` VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pbmhwaGF0MTIzQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyMyIsImlhdCI6MTcxODE3NDE5NywiZXhwIjoxNzE4Nzc4OTk3fQ.aIREiY2Q66lOJujMT--QMY07Joviqci4NmjMFk7-m4w','miphat123','2024-06-12 06:36:37','2024-06-19 06:36:37'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pbmhwaGF0MTIzQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyMyIsImlhdCI6MTcxODE3NDIyMywiZXhwIjoxNzE4Nzc5MDIzfQ.74aUhFJ3btuRTn4Rz4QwT_KrJM4OVTNH1kEFRoIr_d8','miphat123','2024-06-12 06:37:03','2024-06-19 06:37:03'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pbmhwaGF0MTIzQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyMyIsImlhdCI6MTcxODE3NDIyNywiZXhwIjoxNzE4Nzc5MDI3fQ.ruZLZj4fqMxD-pQHfjYLi8FumRoFYvVyY18TYtaSS_w','miphat123','2024-06-12 06:37:07','2024-06-19 06:37:07'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pbmhwaGF0MTIzQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyMyIsImlhdCI6MTcxODE3NzgwMiwiZXhwIjoxNzE4NzgyNjAyfQ.YqzqC08JR0LHkCpzaWvOaXKB7r4Kfbh4Y1qUuNza9tc','miphat123','2024-06-12 07:36:42','2024-06-19 07:36:42'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pbmhwaGF0MTIzQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyMyIsImlhdCI6MTcxODE3NzgyNiwiZXhwIjoxNzE4NzgyNjI2fQ.8iXIJwczBFSrMZTEqq_rLVfR251476YMgnaeGb-W7aQ','miphat123','2024-06-12 07:37:06','2024-06-19 07:37:06'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pbmhwaGF0MTIzQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyMyIsImlhdCI6MTcxODI1MzI2OCwiZXhwIjoxNzE4ODU4MDY4fQ.WSvGxi7wGqWhal0KRh6IrNyzdm-JIiln1-SX4YOdr14','miphat123','2024-06-13 04:34:28','2024-06-20 04:34:28'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pbmhwaGF0MTIzQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyMyIsImlhdCI6MTcxODQyNzM3NywiZXhwIjoxNzE5MDMyMTc3fQ.Z6YGv2zprqE2hNWUgTYOorpcvZAIYxmztdQBK-9p7j0','miphat123','2024-06-15 04:56:17','2024-06-22 04:56:17'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pbmhwaGF0MTIzQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyMyIsImlhdCI6MTcxODQyNzQzNSwiZXhwIjoxNzE5MDMyMjM1fQ.CWPab-7XUqHHpN7Je5gaJ5GqHV1J4UrVb1WByLiLMn8','miphat123','2024-06-15 04:57:15','2024-06-22 04:57:15'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pbmhwaGF0MTIzQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyMyIsImlhdCI6MTcxODQyNzYwMiwiZXhwIjoxNzE5MDMyNDAyfQ.wvG9SOVSXN7VbtP6QbI5EvZ4a51lESqBzwbrPU9DDCM','miphat123','2024-06-15 05:00:02','2024-06-22 05:00:02'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pcGhhdDEyMzQ1QGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyMzQ1IiwiaWF0IjoxNzE4MjA2OTUwLCJleHAiOjE3MTg4MTE3NTB9._LB7pRSWy02hrBzSejJdw9KmBDqKftr85Etw9WdxorU','miphat12345','2024-06-12 15:42:30','2024-06-19 15:42:30'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pcGhhdDEyQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyIiwiaWF0IjoxNzE4MTc0NDczLCJleHAiOjE3MTg3NzkyNzN9.7BPFE6yKciCl8L1GHCBmO2D9KiJlkZS5AD5oWQH3n9s','miphat12','2024-06-12 06:41:13','2024-06-19 06:41:13'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1pcGhhdDEyQGdtYWlsLmNvbSIsIm1hX2xvYWlfbmd1b2lfZHVuZyI6IktoYWNoSGFuZyIsInRhaV9raG9hbiI6Im1pcGhhdDEyIiwiaWF0IjoxNzE4MTc0NDY5LCJleHAiOjE3MTg3NzkyNjl9.W606tH9TKWPmJY5vjQZoWXPVi6eegUQC1wzdLqi3P7s','miphat12','2024-06-12 06:41:09','2024-06-19 06:41:09'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFiY2FzZGJhc2hkamJAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzNDUiLCJpYXQiOjE3MTgyMDc4NTUsImV4cCI6MTcxODgxMjY1NX0.JuzHRdCK3RljIuhW9OTNmzVKjIHr439JELafYpTii80','miphat12345','2024-06-12 15:57:35','2024-06-19 15:57:35'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFiY2FzZGJhc2hkamJAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzNDUiLCJpYXQiOjE3MTgyMDczMjQsImV4cCI6MTcxODgxMjEyNH0.SXvnVsDDnWxFJvG9DuIfAXWgKEEDfej0EcFRtaQK5MU','miphat12345','2024-06-12 15:48:44','2024-06-19 15:48:44'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFiY2FzZGJhc2hkamJAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzNDUiLCJpYXQiOjE3MTgyNTM5NjIsImV4cCI6MTcxODg1ODc2Mn0.JGcMXbYnPIwK_eo_l52JNkl_cFImcD2jvBExI7vg29E','miphat12345','2024-06-13 04:46:02','2024-06-20 04:46:02'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoiaGVsbG93b3JsZCIsImlhdCI6MTcxODA4Mzk4OSwiZXhwIjoxNzE4Njg4Nzg5fQ.ykUR2SiKUM23PcDFcVxExZvgAOhTyfv6zM6DAXwHfTg','helloworld','2024-06-11 05:33:09','2024-06-18 05:33:09'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoiaGVsbG93b3JsZCIsImlhdCI6MTcxODA4MzkzMiwiZXhwIjoxNzE4Njg4NzMyfQ.AUAXvzt-JbzoHteOVMBOOCO4yfRhbe93jRGrOhumMHw','helloworld','2024-06-11 05:32:12','2024-06-18 05:32:12'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoiaGVsbG93b3JsZCIsImlhdCI6MTcxODA5MTEwNCwiZXhwIjoxNzE4Njk1OTA0fQ.AnahC1gBM8h1HTipD1Zb47KYmbFEmY_HAk7XM8u4Xc0','helloworld','2024-06-11 07:31:44','2024-06-18 07:31:44'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoiaGVsbG93b3JsZCIsImlhdCI6MTcxODE3NDE2OCwiZXhwIjoxNzE4Nzc4OTY4fQ.DmYtxSF4OzhT3_zLUwaerjrZcRf53lSp9z-aNpyaBb8','helloworld','2024-06-12 06:36:08','2024-06-19 06:36:08'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoiaGVsbG93b3JsZCIsImlhdCI6MTcxODEyMTAwMywiZXhwIjoxNzE4NzI1ODAzfQ.ulkVCjTQZaNZsOTfw0ey4aDGRnPdE1cklqFO2YpwHUk','helloworld','2024-06-11 15:50:03','2024-06-18 15:50:03'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJleHAiOjE3MTk4MTcxMTksImlhdCI6MTcxOTIxMjM0OX0.cCzdpT3g4wNUb9iIiVtUq_K2yvCwcXrcXEK9IpCCAJA','helloworld','2024-06-24 06:59:09','2024-07-01 06:58:39'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJleHAiOjE3MTk4MTg4NDgsImlhdCI6MTcxOTIxNDA3OH0.Stq4yYCNif2E_4PJonNl3WQeg2a6VWi2nEXeTZgaR9E','helloworld','2024-06-24 07:27:58','2024-07-01 07:27:28'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg0Mjk4ODQsImV4cCI6MTcxOTAzNDY4NH0.amIh4S_nCnXzh3HV2YAlnT4cTaX_4nDvTxzvRZu3R1Y','helloworld','2024-06-15 05:38:04','2024-06-22 05:38:04'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg0MzA1NDMsImV4cCI6MTcxOTAzNTM0M30.5l_FWaXE--lgs_PW6pMb4Uaod0jlJIKfawGpvkuacF0','helloworld','2024-06-15 05:49:03','2024-06-22 05:49:03'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg0MzAwMTMsImV4cCI6MTcxOTAzNDgxM30.kkIePZUMOHW5M1nRYU3fOd3R4cGHpvSpXc7ipypCAYc','helloworld','2024-06-15 05:40:13','2024-06-22 05:40:13'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg0Mzg2OTIsImV4cCI6MTcxOTA0MzQ5Mn0.J1XT7AMPIQMFb19ke6hZbVo_ppFaGemgs31qyH47RmA','helloworld','2024-06-15 08:04:52','2024-06-22 08:04:52'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg0MzU1OTUsImV4cCI6MTcxOTA0MDM5NX0.5skkoaO52St6af63fqOLCLBf7WjdmwPxeLzRvOKdWuo','helloworld','2024-06-15 07:13:15','2024-06-22 07:13:15'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg1MzQ2NDksImV4cCI6MTcxOTEzOTQ0OX0.dCstXTxgSdtl2ij6cDGwM2d5sqz3l0JYND3RikjZb0Y','helloworld','2024-06-16 10:44:09','2024-06-23 10:44:09'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg2MzY5NTAsImV4cCI6MTcxOTI0MTc1MH0.qrIQWdJ85mN1jXKb91jyxTh_DCLwjwBqmPqpBXKvcvM','helloworld','2024-06-17 15:09:10','2024-06-24 15:09:10'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg3ODE5NzcsImV4cCI6MTcxOTM4Njc3N30.SJ1DdbVWQNE4gBoJgmwJejTGWfEvtJrNQngRjr1CdGA','helloworld','2024-06-19 07:26:17','2024-06-26 07:26:17'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg3ODMxNzUsImV4cCI6MTcxOTM4Nzk3NX0.6L9HXZKIDBvp3U3d0mRKbgBxplOWAaJkzrplo4QylDU','helloworld','2024-06-19 07:46:15','2024-06-26 07:46:15'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg3ODU1NDgsImV4cCI6MTcxOTM5MDM0OH0.4UAiZCJXtN_H5cQdHt71Rpa0dqTNfmGuH7QmqSIgODw','helloworld','2024-06-19 08:25:48','2024-06-26 08:25:48'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg3ODU1NzMsImV4cCI6MTcxOTM5MDM3M30.3aWzMpJaPHgnq8iigj27n4DXbe6sSfzC8Wn2qP7v-Bs','helloworld','2024-06-19 08:26:13','2024-06-26 08:26:13'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg3ODU4NDAsImV4cCI6MTcxOTM5MDY0MH0.iw2WW7qtrOuja7OeJOEpTFYF57XHsRTea_JUKCqVP0c','helloworld','2024-06-19 08:30:40','2024-06-26 08:30:40'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg3ODUzNjksImV4cCI6MTcxOTM5MDE2OX0.6pJLfYDglkr82AkClzrcJcWdXFDzbKms_F0MHbLI8oE','helloworld','2024-06-19 08:22:49','2024-06-26 08:22:49'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg3ODUzNTMsImV4cCI6MTcxOTM5MDE1M30.-2Vta6PBcoHlgbDzg4gH2SacACwlJPC3AXwfAI1fgdY','helloworld','2024-06-19 08:22:33','2024-06-26 08:22:33'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg4NTg3MjMsImV4cCI6MTcxOTQ2MzUyM30._h7sd-EsxHEgbmKZvHkL5ZVAFpTSlI1hyJY1FuUZJaY','helloworld','2024-06-20 04:45:23','2024-06-27 04:45:23'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg5NDk0MzYsImV4cCI6MTcxOTU1NDIzNn0.CC7X4nMiGejtXkYPQQg3qeNvZXeiyNtvHlgHS12eJ28','helloworld','2024-06-21 05:57:16','2024-06-28 05:57:16'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTg5NTEwNzQsImV4cCI6MTcxOTU1NTg3NH0.nN5EHA66nmcWS8-To0cUJl7xq-SMaFABQcfGsVFbmv0','helloworld','2024-06-21 06:24:34','2024-06-28 06:24:34'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgyMDc5ODMsImV4cCI6MTcxODgxMjc4M30.niUARpg_KmurNlAukpOyfggtmv4-wO67W6f0zz0zsNU','helloworld','2024-06-12 15:59:43','2024-06-19 15:59:43'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgyNTgzODEsImV4cCI6MTcxODg2MzE4MX0.FSUN3dpogaWPll_lVd2VgnA0FS2r1_SuM8pXZZLArjE','helloworld','2024-06-13 05:59:41','2024-06-20 05:59:41'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgyNTM5ODQsImV4cCI6MTcxODg1ODc4NH0.Il9ZkGxUmXH2d0NX8FvXYsPK9pkf-4B8jyKNRjJjkKI','helloworld','2024-06-13 04:46:24','2024-06-20 04:46:24'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgyNTMxMTQsImV4cCI6MTcxODg1NzkxNH0.vI02uS5x7G5z73L2wxvKzV3G1FBD3FlAgWC30cPhsM8','helloworld','2024-06-13 04:31:54','2024-06-20 04:31:54'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgyNTQ0NTcsImV4cCI6MTcxODg1OTI1N30.1bZUXVn9-0NvRWnSf6TalBxzEZ0cW4nRcIeMnzkLfN0','helloworld',NULL,NULL),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgyNTQ4ODIsImV4cCI6MTcxODg1OTY4Mn0._RrzzlDCIGKtzM5nmr2cIs4PJPxvpPJiGSW95Zn-jCg','helloworld','2024-06-13 05:01:22','2024-06-20 05:01:22'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgyNTQ5MDAsImV4cCI6MTcxODg1OTcwMH0.BwumG3Db8v8HDybkql2IKV9ZeDoxWNnquqOFuNCvsqU','helloworld',NULL,NULL),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgyNTQzODgsImV4cCI6MTcxODg1OTE4OH0.NYjLgcgjfNynMqFrb8MhT_phHG68Naw1Ju2hIoGa6WE','helloworld','2024-06-13 04:53:08','2024-06-20 04:53:08'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgzMzgyNDAsImV4cCI6MTcxODk0MzA0MH0.9-il1-RrzR-wHKHxUCrcH5elg-D4p_GFcTTwzFh-UIY','helloworld','2024-06-14 04:10:40','2024-06-21 04:10:40'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgzNDU4NDQsImV4cCI6MTcxODk1MDY0NH0.SMIoasd51Vq4HpEgQmN56_ji41Tg0qiU5vVwcw_4F48','helloworld','2024-06-14 06:17:24','2024-06-21 06:17:24'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgzNDY1NjIsImV4cCI6MTcxODk1MTM2Mn0.UmzyZecxPpDHN-lKvkltnJX0RNx4m6-tqylHKEj_iXE','helloworld','2024-06-14 06:29:22','2024-06-21 06:29:22'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgzNDYzODQsImV4cCI6MTcxODk1MTE4NH0.M6UVZDYMB_Bq-c04jJ77C9cdCJEa0Yy-LRGMKu7rE-I','helloworld','2024-06-14 06:26:24','2024-06-21 06:26:24'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgzNjg3MTcsImV4cCI6MTcxODk3MzUxN30.-BuUEy8Lj-Vj2vGS6tuBUSpwqv3FGhjp-A4CJdbXups','helloworld','2024-06-14 12:38:37','2024-06-21 12:38:37'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTgzNjgzMzUsImV4cCI6MTcxODk3MzEzNX0.iLfzV5IbLDYk2lxCtOwZLb4ya6hIj4OUkIkkfInsnkM','helloworld','2024-06-14 12:32:15','2024-06-21 12:32:15'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTk1NTcwOTksImV4cCI6MTcyMDE2MTg5OX0.0w68ZyVT2ONQGRBPPS5XaTUs5b8qW-TygCBPJ1kWO4o','helloworld','2024-06-28 06:44:59','2024-07-05 06:44:59'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTk1NTgzMTgsImV4cCI6MTcyMDE2MzExOH0.4H9C_dNwuBZWz-uISoIsvQ2qTMKM_me1O9BrTasjciA','helloworld','2024-06-28 07:05:18','2024-07-05 07:05:18'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTk2NzE1MjUsImV4cCI6MTcyMDI3NjMyNX0.i0hj_ExzWfGVqXRD3s7QxVOe1EHqOHnuOZvIbsnq9Ok','helloworld','2024-06-29 14:32:05','2024-07-06 14:32:05'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTkwMjk1MTcsImV4cCI6MTcxOTYzNDMxN30.34Q5S8ZGaBnqWiNKuvrXijgwxzAqw0TsqCeFnLD7_8Q','helloworld','2024-06-22 04:11:57','2024-06-29 04:11:57'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTkxMTIzNzAsImV4cCI6MTcxOTcxNzE3MH0.HYymEjpi5DCQadSjquIQuZdOjDblOIIzOm6MkSGdSFc','helloworld','2024-06-23 03:12:50','2024-06-30 03:12:50'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTkxNDAxNDMsImV4cCI6MTcxOTc0NDk0M30.Aw4HZ_eZCwaihQxCNlEP21mrakRBB8WJ4F565460pvg','helloworld','2024-06-23 10:55:43','2024-06-30 10:55:43'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTkxNDAyMzEsImV4cCI6MTcxOTc0NTAzMX0.J6AWNNOBDMX87tYRlgoz-YoiOWN1yK68QsFNMWpwHK4','helloworld','2024-06-23 10:57:11','2024-06-30 10:57:11'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTkxNDAzNzgsImV4cCI6MTcxOTc0NTE3OH0.bnqUM4X5YI20ZyuhwEx7tQ8RjHM7mQU9VpMlISN9-7c','helloworld','2024-06-23 10:59:38','2024-06-30 10:59:38'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTkyMTE2MTIsImV4cCI6MTcxOTgxNjQxMn0.xiKoYUXBsBT4q4Gkh1tH55TEPtbZOANGrHq-oyS1_jg','helloworld','2024-06-23 14:14:08','2024-06-30 14:14:08'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTkyMTMyMDYsImV4cCI6MTcxOTgxNzk1MX0.Fql9BGa2JyBk0rQqfKcd_KjwwdQ0bD7w_Q8KGtintc8','helloworld','2024-06-24 07:13:26','2024-07-01 07:12:31'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhlbGxvd29ybGRAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiUXVhblRyaSIsInRhaV9raG9hbiI6ImhlbGxvd29ybGQiLCJpYXQiOjE3MTkyMTMzMDAsImV4cCI6MTcxOTgxODA0Nn0.AhVWlzdN0aJFHSVqLLz-_rHpV7UAuyXHkP31blNRl-E','helloworld','2024-06-24 07:15:00','2024-07-01 07:14:06'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDEyM0BnbWFpbC5jb20iLCJtYV9sb2FpX25ndW9pX2R1bmciOiJLaGFjaEhhbmciLCJ0YWlfa2hvYW4iOiJtaXBoYXQxMjMiLCJpYXQiOjE3MTg0Mjc2MTAsImV4cCI6MTcxOTAzMjQxMH0.2kmyS5SrYgBbu7TuKohAPGoWmsmoEmTrt5E8v3frEYQ','miphat123','2024-06-15 05:00:10','2024-06-22 05:00:10'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDEyM0BnbWFpbC5jb20iLCJtYV9sb2FpX25ndW9pX2R1bmciOiJLaGFjaEhhbmciLCJ0YWlfa2hvYW4iOiJtaXBoYXQxMjMiLCJpYXQiOjE3MTg0Mjc2NTYsImV4cCI6MTcxOTAzMjQ1Nn0.R_jKbbk0zAkOBN4vPECCPFNoiX69SaQbqCM57liPizU','miphat123','2024-06-15 05:00:56','2024-06-22 05:00:56'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDEyM0BnbWFpbC5jb20iLCJtYV9sb2FpX25ndW9pX2R1bmciOiJLaGFjaEhhbmciLCJ0YWlfa2hvYW4iOiJtaXBoYXQxMjMiLCJpYXQiOjE3MTg0Mjc3MTYsImV4cCI6MTcxOTAzMjUxNn0.1x-mqbrEaK_3YCqOtvk6z-sIlrYatvd0mPJt2X2CGR0','miphat123','2024-06-15 05:01:56','2024-06-22 05:01:56'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDEyM0BnbWFpbC5jb20iLCJtYV9sb2FpX25ndW9pX2R1bmciOiJLaGFjaEhhbmciLCJ0YWlfa2hvYW4iOiJtaXBoYXQxMjMiLCJpYXQiOjE3MTg0Mjc3ODYsImV4cCI6MTcxOTAzMjU4Nn0.kTppQ7RINzfnQchXvSvrleOYl0wZ-RXxXVPEK6oc1_Q','miphat123','2024-06-15 05:03:06','2024-06-22 05:03:06'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDEyM0BnbWFpbC5jb20iLCJtYV9sb2FpX25ndW9pX2R1bmciOiJLaGFjaEhhbmciLCJ0YWlfa2hvYW4iOiJtaXBoYXQxMjMiLCJpYXQiOjE3MTg0MzU1NzIsImV4cCI6MTcxOTA0MDM3Mn0.D1kSKD7SL0YF7HdZaaoi-cTNgQ_4y4NX1qHZIWEq9vY','miphat123','2024-06-15 07:12:52','2024-06-22 07:12:52'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDFAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzIiwiaWF0IjoxNzE5Mjk2NDQ3LCJleHAiOjE3MTk5MDEyNDd9.8AIHFCG34mYnOyn0ZeIadwJZqK-YuPd2EBHXXaQyBMo','miphat123','2024-06-25 06:20:47','2024-07-02 06:20:47'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDFAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzIiwiaWF0IjoxNzE5Mjk2NjY1LCJleHAiOjE3MTk5MDE0NjV9.OvvcOeOPfXYzZFxBkXnU2AxOWnbuX5WW5dzYFF2E-RY','miphat123','2024-06-25 06:24:25','2024-07-02 06:24:25'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDFAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzIiwiaWF0IjoxNzE5MzAyNzIyLCJleHAiOjE3MTk5MDc1MjJ9.DPLzG2hat8_nTpr106JX2trLsIXLzZIJcshyMZkpvLM','miphat123','2024-06-25 08:05:22','2024-07-02 08:05:22'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDFAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzIiwiaWF0IjoxNzE5Mzg4NTE0LCJleHAiOjE3MTk5OTMzMTR9.Htpnk3uhzaubxfotZ7cSNwWxZb-nC3CMLCbNHBTH2Rw','miphat123','2024-06-26 07:55:14','2024-07-03 07:55:14'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDFAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzIiwiaWF0IjoxNzE5MzgyNzI3LCJleHAiOjE3MTk5ODc1Mjd9.l_XOCK2VqZPnlXEKtcJVlSLN2zSC07VFBeDsj5po-Jk','miphat123','2024-06-26 06:18:47','2024-07-03 06:18:47'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDFAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzIiwiaWF0IjoxNzE5NTU1MDU5LCJleHAiOjE3MjAxNTk4NTl9.PB2nC-mcR_8nCmej6mzI0H9j_Va9Vq6nNR2oo4SDY-c','miphat123','2024-06-28 06:10:59','2024-07-05 06:10:59'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDFAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzIiwiaWF0IjoxNzE5NTU2Njc4LCJleHAiOjE3MjAxNjE0Nzh9.ljiPU-4UnxzUIiOo85G1saqtzxBPFyFQQqlK4z4YgKc','miphat123','2024-06-28 06:37:58','2024-07-05 06:37:58'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDFAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzIiwiaWF0IjoxNzE5NTU2ODcyLCJleHAiOjE3MjAxNjE2NzJ9.N0XGaWOdkgr_qprZm8S4yzD4QYW8Ef9oBtH2hkreZPk','miphat123','2024-06-28 06:41:12','2024-07-05 06:41:12'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDFAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzIiwiaWF0IjoxNzE5NTU3MDQxLCJleHAiOjE3MjAxNjE4NDF9.oD7jbJQ2ptnb_O94KKOhrg9L1hAACSwTNdd-OLYR13E','miphat123','2024-06-28 06:44:01','2024-07-05 06:44:01'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW5uZ3V5ZW5taW5ocGhhdDFAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoibWlwaGF0MTIzIiwiaWF0IjoxNzE5NTU4Mjg4LCJleHAiOjE3MjAxNjMwODh9.tpU4SfdP51ucP69-MJ_-DxpMnkrtQqcVQoK3y-tFyik','miphat123','2024-06-28 07:04:48','2024-07-05 07:04:48'),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBvc3RtYW4xMjNAZ21haWwuY29tIiwibWFfbG9haV9uZ3VvaV9kdW5nIjoiS2hhY2hIYW5nIiwidGFpX2tob2FuIjoiUG9zdE1hbjEyMyIsImV4cCI6MTcyMDE2MTI3MSwiaWF0IjoxNzE5NTU2NTA5fQ.RFCscMxiw_He9gDnSFah1SjNNYN72-_SeIYX7y9KmMI','PostMan123','2024-06-28 06:35:09','2024-07-05 06:34:31');
/*!40000 ALTER TABLE `refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yeu_thich`
--

DROP TABLE IF EXISTS `yeu_thich`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yeu_thich` (
  `ma_yeu_thich` int NOT NULL AUTO_INCREMENT,
  `ma_phim` int DEFAULT NULL,
  `tai_khoan` varchar(100) DEFAULT NULL,
  `ngay_tao` datetime DEFAULT NULL,
  PRIMARY KEY (`ma_yeu_thich`),
  KEY `tai_khoan` (`tai_khoan`),
  KEY `ma_phim` (`ma_phim`),
  CONSTRAINT `yeu_thich_ibfk_1` FOREIGN KEY (`tai_khoan`) REFERENCES `nguoi_dung` (`tai_khoan`),
  CONSTRAINT `yeu_thich_ibfk_2` FOREIGN KEY (`ma_phim`) REFERENCES `phim` (`ma_phim`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yeu_thich`
--

LOCK TABLES `yeu_thich` WRITE;
/*!40000 ALTER TABLE `yeu_thich` DISABLE KEYS */;
INSERT INTO `yeu_thich` VALUES (3,2,'helloworld','2024-06-23 07:59:25');
/*!40000 ALTER TABLE `yeu_thich` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-02 13:57:59
