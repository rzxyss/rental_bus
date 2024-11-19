-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versi server:                 8.0.30 - MySQL Community Server - GPL
-- OS Server:                    Win64
-- HeidiSQL Versi:               12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Membuang struktur basisdata untuk rental_bus
CREATE DATABASE IF NOT EXISTS `rental_bus` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rental_bus`;

-- membuang struktur untuk table rental_bus.akun
CREATE TABLE IF NOT EXISTS `akun` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  `telp` varchar(13) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','customer') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Membuang data untuk tabel rental_bus.akun: ~2 rows (lebih kurang)
INSERT INTO `akun` (`id`, `nama`, `telp`, `alamat`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
	(1, 'Admin', '08123456789', 'Bandung', 'admin', 'admin', 'admin', '2024-11-18 04:36:27', '2024-11-18 04:36:27'),
	(2, 'Customer', '081234567890', 'Bandung', 'customer', 'customer', 'customer', '2024-11-18 04:36:46', '2024-11-18 04:37:15');

-- membuang struktur untuk table rental_bus.bus
CREATE TABLE IF NOT EXISTS `bus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_bus` varchar(100) NOT NULL,
  `kapasitas` int NOT NULL,
  `harga_sewa_per_hari` decimal(10,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 Untuk Diproses, 1 untuk tersedia, dan 2 untuk dibatalkan',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Membuang data untuk tabel rental_bus.bus: ~0 rows (lebih kurang)

-- membuang struktur untuk table rental_bus.pembayaran
CREATE TABLE IF NOT EXISTS `pembayaran` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_sewa` int NOT NULL,
  `jumlah` decimal(10,2) NOT NULL,
  `tanggal_pembayaran` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_sewa` (`id_sewa`),
  CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_sewa`) REFERENCES `penyewaan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Membuang data untuk tabel rental_bus.pembayaran: ~0 rows (lebih kurang)

-- membuang struktur untuk table rental_bus.penyewaan
CREATE TABLE IF NOT EXISTS `penyewaan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_akun` int NOT NULL,
  `id_bus` int NOT NULL,
  `tanggal_sewa` date NOT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '0 Untuk Diproses, 1 untuk tersedia, dan 2 untuk dibatalkan',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_akun` (`id_akun`),
  KEY `id_bus` (`id_bus`),
  CONSTRAINT `penyewaan_ibfk_1` FOREIGN KEY (`id_akun`) REFERENCES `akun` (`id`),
  CONSTRAINT `penyewaan_ibfk_2` FOREIGN KEY (`id_bus`) REFERENCES `bus` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Membuang data untuk tabel rental_bus.penyewaan: ~0 rows (lebih kurang)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
