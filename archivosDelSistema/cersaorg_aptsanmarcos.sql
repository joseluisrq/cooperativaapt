-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 05-10-2019 a las 11:12:06
-- Versión del servidor: 10.2.27-MariaDB-cll-lve
-- Versión de PHP: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cersaorg_aptsanmarcos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(10) UNSIGNED NOT NULL,
  `estado` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '0 desactivado /1 activo',
  `estadocredito` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0 sin credito /1 con credito'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `estado`, `estadocredito`) VALUES
(14, '1', '0'),
(15, '1', '0'),
(16, '1', '0'),
(17, '1', '1'),
(18, '1', '0'),
(19, '1', '0'),
(20, '1', '0'),
(21, '1', '0'),
(22, '1', '0'),
(23, '1', '0'),
(24, '1', '0'),
(25, '1', '1'),
(26, '1', '0'),
(27, '1', '0'),
(28, '1', '0'),
(29, '1', '0'),
(30, '1', '1'),
(31, '1', '1'),
(32, '1', '1'),
(33, '1', '0'),
(34, '1', '0'),
(35, '1', '0'),
(36, '1', '0'),
(37, '1', '0'),
(38, '1', '0'),
(39, '1', '0'),
(40, '1', '0'),
(41, '1', '0'),
(42, '1', '1'),
(43, '1', '0'),
(44, '1', '0'),
(45, '1', '1'),
(46, '1', '0'),
(47, '1', '0'),
(48, '1', '0'),
(49, '1', '0'),
(50, '1', '0'),
(51, '1', '0'),
(52, '1', '0'),
(53, '1', '0'),
(54, '1', '0'),
(55, '1', '0'),
(56, '1', '0'),
(57, '1', '0'),
(58, '1', '0'),
(59, '1', '0'),
(60, '1', '1'),
(61, '1', '0'),
(62, '1', '0'),
(63, '1', '0'),
(64, '1', '1'),
(65, '1', '0'),
(66, '1', '0'),
(67, '1', '0'),
(68, '1', '0'),
(69, '1', '0'),
(70, '1', '1'),
(71, '1', '0'),
(72, '1', '0'),
(73, '1', '0'),
(74, '1', '0'),
(75, '1', '0'),
(76, '1', '0'),
(77, '1', '0'),
(78, '1', '0'),
(79, '1', '0'),
(80, '1', '0'),
(81, '1', '0'),
(82, '1', '0'),
(83, '1', '0'),
(84, '1', '0'),
(85, '1', '1'),
(86, '1', '0'),
(87, '1', '0'),
(88, '1', '0'),
(89, '1', '0'),
(90, '1', '0'),
(91, '1', '0'),
(92, '1', '1'),
(93, '1', '0'),
(94, '1', '0'),
(95, '1', '0'),
(96, '1', '0'),
(97, '1', '0'),
(98, '1', '0'),
(99, '1', '1'),
(100, '1', '0'),
(101, '1', '0'),
(102, '1', '0'),
(103, '1', '0'),
(104, '1', '0'),
(105, '1', '0'),
(106, '1', '0'),
(107, '1', '0'),
(108, '1', '0'),
(109, '1', '0'),
(110, '1', '0'),
(111, '1', '0'),
(112, '1', '0'),
(113, '1', '0'),
(114, '1', '0'),
(115, '1', '0'),
(116, '1', '0'),
(117, '1', '0'),
(118, '1', '0'),
(119, '1', '0'),
(120, '1', '0'),
(121, '1', '0'),
(122, '1', '1'),
(123, '1', '1'),
(124, '1', '0'),
(125, '1', '1'),
(126, '1', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `creditos`
--

CREATE TABLE `creditos` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcliente` int(10) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `numeroprestamo` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idkiva` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montodesembolsado` decimal(10,2) NOT NULL,
  `fechadesembolso` date NOT NULL,
  `fechakiva` date NOT NULL,
  `numerocuotas` int(11) NOT NULL,
  `tipocambio` decimal(7,6) NOT NULL,
  `tasa` decimal(4,2) NOT NULL,
  `estado` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0 credito desactivado/ 1credito activado/2 credito cancelado',
  `periodo` char(2) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1 mesnual/2 bimensula/3 trimestral/6 semestral /12 anual',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `mora` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `creditos`
--

INSERT INTO `creditos` (`id`, `idcliente`, `idusuario`, `numeroprestamo`, `idkiva`, `montodesembolsado`, `fechadesembolso`, `fechakiva`, `numerocuotas`, `tipocambio`, `tasa`, `estado`, `periodo`, `created_at`, `updated_at`, `mora`) VALUES
(5, 99, 5, 'SM2019014', '1789300', '2500.00', '2019-08-09', '2019-08-09', 2, '3.300000', '13.00', '1', '6', '2019-10-05 09:51:09', '2019-10-05 09:51:09', 0),
(6, 126, 5, 'SM2019015', '1789302', '2500.00', '2019-08-09', '2019-08-09', 1, '3.300000', '13.00', '1', '1', '2019-10-05 10:03:25', '2019-10-05 10:03:25', 0),
(7, 70, 5, 'SM20190013', '1789294', '2500.00', '2019-08-09', '2019-08-09', 1, '3.300000', '13.00', '1', '12', '2019-10-05 10:15:27', '2019-10-05 10:15:27', 0),
(8, 32, 5, 'SM2019012', '1774728', '2500.00', '2019-07-08', '2019-07-08', 1, '3.360000', '13.00', '1', '12', '2019-10-05 10:19:38', '2019-10-05 10:19:38', 0),
(9, 25, 5, 'SM2019005', '1697356', '2500.00', '2019-03-04', '2019-03-04', 1, '3.340000', '13.00', '1', '12', '2019-10-05 10:22:02', '2019-10-05 10:22:02', 0),
(10, 60, 5, 'SM2019007', '1704646', '2500.00', '2019-03-15', '2019-03-15', 4, '3.330000', '13.00', '1', '3', '2019-10-05 10:27:11', '2019-10-05 10:27:11', 0),
(11, 64, 12, 'SM2019006', '1704649', '1700.00', '2019-03-15', '2019-03-15', 1, '3.320000', '13.00', '1', '12', '2019-10-05 10:41:47', '2019-10-05 10:41:47', 0),
(12, 45, 12, 'SM2019009', '1707018', '2500.00', '2019-03-18', '2019-03-18', 1, '3.340000', '13.00', '1', '12', '2019-10-05 10:43:41', '2019-10-05 10:43:41', 0),
(13, 79, 12, 'SM2019011', '1753529', '2500.00', '2019-06-03', '2019-06-03', 1, '3.320000', '13.00', '2', '12', '2019-10-05 10:47:33', '2019-10-05 10:50:48', 0),
(14, 125, 12, 'SM2018066', '47611238', '1700.00', '2019-01-29', '2019-01-29', 1, '3.350000', '13.00', '1', '12', '2019-10-05 10:54:34', '2019-10-05 10:54:34', 0),
(15, 92, 12, 'SM2019004', '1697352', '1700.00', '2019-03-04', '2019-03-04', 2, '3.330000', '13.00', '1', '6', '2019-10-05 10:58:38', '2019-10-05 10:58:38', 1),
(16, 17, 12, 'SM2018047', '1623587', '2500.00', '2018-11-12', '2018-11-12', 1, '3.330000', '13.00', '1', '12', '2019-10-05 11:01:50', '2019-10-05 11:01:50', 0),
(17, 31, 12, 'SM2019001', '1688049', '749.00', '2019-02-13', '2019-02-13', 2, '3.340000', '13.00', '1', '6', '2019-10-05 11:13:30', '2019-10-05 11:13:30', 1),
(18, 42, 12, 'SM2018061', '1665128', '2500.00', '2019-01-13', '2019-01-13', 1, '3.370000', '13.00', '1', '12', '2019-10-05 11:15:56', '2019-10-05 11:15:56', 0),
(19, 85, 12, 'SM2018064', '1668401', '1700.00', '2019-01-21', '2019-01-21', 1, '3.370000', '13.00', '1', '12', '2019-10-05 11:18:37', '2019-10-05 11:18:37', 0),
(20, 123, 12, 'SM2019002', '1688709', '2500.00', '2019-02-18', '2019-02-18', 4, '3.350000', '13.00', '1', '3', '2019-10-05 11:21:15', '2019-10-05 11:21:15', 1),
(21, 122, 12, 'SM2018067', '1676856', '597.00', '2019-02-04', '2019-02-04', 2, '3.370000', '13.00', '1', '6', '2019-10-05 11:27:17', '2019-10-05 11:27:17', 0),
(22, 30, 12, 'SM2019010', '1713274', '1700.00', '2019-03-20', '2019-03-20', 1, '3.340000', '13.00', '1', '12', '2019-10-05 11:29:31', '2019-10-05 11:29:31', 0);

--
-- Disparadores `creditos`
--
DELIMITER $$
CREATE TRIGGER `actualizarcredito` AFTER UPDATE ON `creditos` FOR EACH ROW INSERT INTO creditos_bitacora(idcredito,idcliente_n,idcliente_v,idusuario_n,idusuario_v,numeroprestamo_n,numeroprestamo_v,idkiva_n,idkiva_v,fechakiva_n,fechakiva_v,estado_n,estado_v,condicion)
VALUES(old.id,NEW.idcliente,old.idcliente,NEW.idusuario,old.idusuario,NEW.numeroprestamo,old.numeroprestamo,NEW.idkiva,old.idkiva,NEW.fechakiva,old.fechakiva,NEW.estado,old.estado,'CREDITO ACTUALIZADO')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertarcredito` AFTER INSERT ON `creditos` FOR EACH ROW INSERT INTO creditos_bitacora(idcredito,idcliente_n,idusuario_n,numeroprestamo_n,idkiva_n,fechakiva_n,estado_n,estado_v,condicion)
VALUES(NEW.id,NEW.idcliente,NEW.idusuario,NEW.numeroprestamo,NEW.idkiva,NEW.fechakiva,NEW.estado,NEW.estado,'NUEVO CREDITO')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `creditos_bitacora`
--

CREATE TABLE `creditos_bitacora` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcredito` int(10) UNSIGNED NOT NULL,
  `idcliente_n` int(10) NOT NULL,
  `idcliente_v` int(10) NOT NULL,
  `idusuario_n` int(10) NOT NULL,
  `idusuario_v` int(10) NOT NULL,
  `numeroprestamo_n` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numeroprestamo_v` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idkiva_n` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idkiva_v` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechakiva_n` date NOT NULL,
  `fechakiva_v` date NOT NULL,
  `estado_n` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0 credito desactivado/ 1credito activado/2 credito cancelado',
  `estado_v` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0 credito desactivado/ 1credito activado/2 credito cancelado',
  `condicion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechacambio` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `creditos_bitacora`
--

INSERT INTO `creditos_bitacora` (`id`, `idcredito`, `idcliente_n`, `idcliente_v`, `idusuario_n`, `idusuario_v`, `numeroprestamo_n`, `numeroprestamo_v`, `idkiva_n`, `idkiva_v`, `fechakiva_n`, `fechakiva_v`, `estado_n`, `estado_v`, `condicion`, `fechacambio`) VALUES
(8, 5, 99, 0, 5, 0, 'SM2019014', '', '1789300', '', '2019-08-09', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 04:51:09'),
(9, 6, 126, 0, 5, 0, 'SM2019015', '', '1789302', '', '2019-08-09', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 05:03:25'),
(10, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:05:41'),
(11, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:05:44'),
(12, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:05:58'),
(13, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:05:59'),
(14, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:14:47'),
(15, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:14:49'),
(16, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:14:50'),
(17, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:14:53'),
(18, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:14:54'),
(19, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:15:02'),
(20, 6, 126, 126, 5, 5, 'SM2019015', 'SM2019015', '1789302', '1789302', '2019-08-09', '2019-08-09', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:15:05'),
(21, 7, 70, 0, 5, 0, 'SM20190013', '', '1789294', '', '2019-08-09', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 05:15:27'),
(22, 8, 32, 0, 5, 0, 'SM2019012', '', '1774728', '', '2019-07-08', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 05:19:38'),
(23, 9, 25, 0, 5, 0, 'SM2019005', '', '1697356', '', '2019-03-04', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 05:22:02'),
(24, 10, 60, 0, 5, 0, 'SM2019007', '', '1704646', '', '2019-03-15', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 05:27:11'),
(25, 11, 64, 0, 12, 0, 'SM2019006', '', '1704649', '', '2019-03-15', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 05:41:47'),
(26, 12, 45, 0, 12, 0, 'SM2019009', '', '1707018', '', '2019-03-18', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 05:43:41'),
(27, 13, 79, 0, 12, 0, 'SM2019011', '', '1753529', '', '2019-06-03', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 05:47:33'),
(28, 13, 79, 79, 12, 12, 'SM2019011', 'SM2019011', '1753529', '1753529', '2019-06-03', '2019-06-03', '2', '1', 'CREDITO ACTUALIZADO', '2019-10-05 05:50:48'),
(29, 14, 125, 0, 12, 0, 'SM2018066', '', '47611238', '', '2019-01-29', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 05:54:34'),
(30, 15, 92, 0, 12, 0, 'SM2019004', '', '1697352', '', '2019-03-04', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 05:58:38'),
(31, 16, 17, 0, 12, 0, 'SM2018047', '', '1623587', '', '2018-11-12', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 06:01:50'),
(32, 15, 92, 92, 12, 12, 'SM2019004', 'SM2019004', '1697352', '1697352', '2019-03-04', '2019-03-04', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 06:05:17'),
(33, 17, 31, 0, 12, 0, 'SM2019001', '', '1688049', '', '2019-02-13', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 06:13:30'),
(34, 17, 31, 31, 12, 12, 'SM2019001', 'SM2019001', '1688049', '1688049', '2019-02-13', '2019-02-13', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 06:13:57'),
(35, 18, 42, 0, 12, 0, 'SM2018061', '', '1665128', '', '2019-01-13', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 06:15:56'),
(36, 19, 85, 0, 12, 0, 'SM2018064', '', '1668401', '', '2019-01-21', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 06:18:37'),
(37, 20, 123, 0, 12, 0, 'SM2019002', '', '1688709', '', '2019-02-18', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 06:21:15'),
(38, 20, 123, 123, 12, 12, 'SM2019002', 'SM2019002', '1688709', '1688709', '2019-02-18', '2019-02-18', '1', '1', 'CREDITO ACTUALIZADO', '2019-10-05 06:23:34'),
(39, 21, 122, 0, 12, 0, 'SM2018067', '', '1676856', '', '2019-02-04', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 06:27:17'),
(40, 22, 30, 0, 12, 0, 'SM2019010', '', '1713274', '', '2019-03-20', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-10-05 06:29:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuotas`
--

CREATE TABLE `cuotas` (
  `id` int(10) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `idcredito` int(10) UNSIGNED NOT NULL,
  `numerocuota` int(2) NOT NULL,
  `fechapago` date NOT NULL,
  `fechacancelacion` datetime NOT NULL,
  `saldopendiente` decimal(12,2) NOT NULL COMMENT 'dolares /neto',
  `monto` decimal(7,2) NOT NULL COMMENT 'dolares /neto',
  `otroscostos` decimal(7,2) DEFAULT NULL,
  `descripcion` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0 sin pagar / 1 pagada',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuotas`
--

INSERT INTO `cuotas` (`id`, `idusuario`, `idcredito`, `numerocuota`, `fechapago`, `fechacancelacion`, `saldopendiente`, `monto`, `otroscostos`, `descripcion`, `estado`, `created_at`, `updated_at`) VALUES
(30, 5, 5, 1, '2020-02-09', '2019-10-04 00:00:00', '1250.00', '1250.00', '0.00', NULL, '0', '2019-10-05 09:51:09', '2019-10-05 09:51:09'),
(31, 5, 5, 2, '2020-08-09', '2019-10-04 00:00:00', '0.00', '1250.00', '0.00', NULL, '0', '2019-10-05 09:51:09', '2019-10-05 09:51:09'),
(32, 5, 6, 1, '2020-08-09', '2019-10-05 00:00:00', '0.00', '2500.00', '0.00', NULL, '0', '2019-10-05 10:03:25', '2019-10-05 10:03:25'),
(33, 5, 7, 1, '2020-08-09', '2019-10-05 00:00:00', '0.00', '2500.00', '0.00', NULL, '0', '2019-10-05 10:15:27', '2019-10-05 10:15:27'),
(34, 5, 8, 1, '2020-07-08', '2019-10-05 00:00:00', '0.00', '2500.00', '0.00', NULL, '0', '2019-10-05 10:19:38', '2019-10-05 10:19:38'),
(35, 5, 9, 1, '2020-03-04', '2019-10-05 00:00:00', '0.00', '2500.00', '0.00', NULL, '0', '2019-10-05 10:22:02', '2019-10-05 10:22:02'),
(36, 12, 10, 1, '2019-06-15', '2019-07-31 10:05:19', '1875.00', '625.00', '0.00', 'Cuota pagada', '1', '2019-10-05 10:27:11', '2019-10-05 10:30:43'),
(37, 12, 10, 2, '2019-09-15', '2019-09-18 12:48:01', '1250.00', '625.00', '0.00', 'Cuota pagada', '1', '2019-10-05 10:27:11', '2019-10-05 10:31:38'),
(38, 5, 10, 3, '2019-12-15', '2019-10-05 00:00:00', '625.00', '625.00', '0.00', NULL, '0', '2019-10-05 10:27:11', '2019-10-05 10:27:11'),
(39, 5, 10, 4, '2020-03-15', '2019-10-05 00:00:00', '0.00', '625.00', '0.00', NULL, '0', '2019-10-05 10:27:11', '2019-10-05 10:27:11'),
(40, 12, 11, 1, '2020-03-15', '2019-10-05 00:00:00', '0.00', '1700.00', '0.00', NULL, '0', '2019-10-05 10:41:47', '2019-10-05 10:41:47'),
(41, 12, 12, 1, '2020-03-18', '2019-10-05 00:00:00', '0.00', '2500.00', '0.00', NULL, '0', '2019-10-05 10:43:41', '2019-10-05 10:43:41'),
(42, 12, 13, 1, '2020-06-03', '2019-06-21 18:06:16', '0.00', '2500.00', '0.00', 'Cuota pagada', '1', '2019-10-05 10:47:33', '2019-10-05 10:50:48'),
(43, 12, 14, 1, '2020-01-29', '2019-10-05 00:00:00', '0.00', '1700.00', '0.00', NULL, '0', '2019-10-05 10:54:34', '2019-10-05 10:54:34'),
(44, 12, 15, 1, '2019-09-04', '2019-10-05 00:00:00', '850.00', '850.00', '0.00', NULL, '0', '2019-10-05 10:58:38', '2019-10-05 10:58:38'),
(45, 12, 15, 2, '2020-03-04', '2019-10-05 00:00:00', '0.00', '850.00', '0.00', NULL, '0', '2019-10-05 10:58:38', '2019-10-05 10:58:38'),
(46, 12, 16, 1, '2019-11-12', '2019-10-05 00:00:00', '0.00', '2500.00', '0.00', NULL, '0', '2019-10-05 11:01:50', '2019-10-05 11:01:50'),
(47, 12, 17, 1, '2019-08-13', '2019-10-05 00:00:00', '374.50', '374.50', '0.00', NULL, '0', '2019-10-05 11:13:30', '2019-10-05 11:13:30'),
(48, 12, 17, 2, '2020-02-13', '2019-10-05 00:00:00', '0.00', '374.50', '0.00', NULL, '0', '2019-10-05 11:13:30', '2019-10-05 11:13:30'),
(49, 12, 18, 1, '2020-01-13', '2019-10-05 00:00:00', '0.00', '2500.00', '0.00', NULL, '0', '2019-10-05 11:15:56', '2019-10-05 11:15:56'),
(50, 12, 19, 1, '2020-01-21', '2019-10-05 00:00:00', '0.00', '1700.00', '0.00', NULL, '0', '2019-10-05 11:18:37', '2019-10-05 11:18:37'),
(51, 12, 20, 1, '2019-05-18', '2019-08-19 10:31:42', '1875.00', '625.00', '0.00', 'Cuota pagada', '1', '2019-10-05 11:21:15', '2019-10-05 11:21:42'),
(52, 12, 20, 2, '2019-08-18', '2019-10-05 00:00:00', '1250.00', '625.00', '0.00', NULL, '0', '2019-10-05 11:21:15', '2019-10-05 11:21:15'),
(53, 12, 20, 3, '2019-11-18', '2019-10-05 00:00:00', '625.00', '625.00', '0.00', NULL, '0', '2019-10-05 11:21:15', '2019-10-05 11:21:15'),
(54, 12, 20, 4, '2020-02-18', '2019-10-05 00:00:00', '0.00', '625.00', '0.00', NULL, '0', '2019-10-05 11:21:15', '2019-10-05 11:21:15'),
(55, 12, 21, 1, '2019-11-06', '2019-10-05 00:00:00', '298.50', '298.50', '0.00', NULL, '0', '2019-10-05 11:27:18', '2019-10-05 11:27:18'),
(56, 12, 21, 2, '2020-05-06', '2019-10-05 00:00:00', '0.00', '298.50', '0.00', NULL, '0', '2019-10-05 11:27:18', '2019-10-05 11:27:18'),
(57, 12, 22, 1, '2020-03-20', '2019-10-05 00:00:00', '0.00', '1700.00', '0.00', NULL, '0', '2019-10-05 11:29:31', '2019-10-05 11:29:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` int(11) NOT NULL,
  `reportekiva` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '2014_10_12_100000_create_password_resets_table', 1),
(5, '2019_08_21_021317_create_personas_table', 1),
(6, '2019_08_22_025149_create_clientes_table', 1),
(7, '2019_08_23_132744_create_roles_table', 2),
(8, '2019_08_24_000000_create_users_table', 3),
(9, '2019_08_24_042201_create_creditos_table', 4),
(10, '2019_08_24_042254_create_cuotas_table', 4),
(11, '2019_08_28_014751_create_porciones_table', 5),
(12, '2019_09_18_221405_create_notifications_table', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `id` int(10) UNSIGNED NOT NULL,
  `dni` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidopaterno` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidomaterno` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechanacimiento` date DEFAULT NULL,
  `direccion` varchar(70) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `dni`, `nombre`, `apellidopaterno`, `apellidomaterno`, `fechanacimiento`, `direccion`, `telefono`, `email`, `estado`, `created_at`, `updated_at`) VALUES
(5, '70212063', 'JOSE LUIS', 'RAMIREZ', 'QUIROZ', '1993-03-01', NULL, NULL, NULL, '1', '2019-09-28 19:59:36', '2019-09-28 20:02:05'),
(10, '46845049', 'SONIA MARLENI', 'JARA', 'FERNANDEZ', '1964-05-30', NULL, NULL, NULL, '1', '2019-10-05 08:58:58', '2019-10-05 08:58:58'),
(11, '26622238', 'JOSE ESTANISLAO', 'COTRINA', 'OLANO', NULL, NULL, NULL, NULL, '1', '2019-10-05 08:59:40', '2019-10-05 08:59:40'),
(12, '12341234', 'SAMY', 'BRAVO', 'SANCHEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:00:37', '2019-10-05 09:00:37'),
(13, '33333333', 'SAMY', 'BRAVO', 'SANCHEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:01:07', '2019-10-05 09:01:07'),
(14, '27904107', 'JUAN JOSE', 'CALDERON', 'BURGOS', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:02:50', '2019-10-05 09:02:50'),
(15, '27902918', 'ESTANISLAO', 'CALDERON', 'ABANTO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:03:16', '2019-10-05 09:03:16'),
(16, '27915813', 'JORGE ALBERTO', 'PAREDES', 'HONORIO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:03:43', '2019-10-05 09:03:43'),
(17, '27930080', 'JOSE SANTOS', 'VEGA', 'IZQUIERDO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:04:07', '2019-10-05 09:04:07'),
(18, '27928007', 'JUVAEL', 'PAREDES', 'PORTAL', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:04:34', '2019-10-05 09:04:34'),
(19, '27929644', 'PRIMITIVO', 'MELENDEZ', 'PAZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:04:53', '2019-10-05 09:04:53'),
(20, '27902764', 'APARICIO', 'CERNA', 'PAREDES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:05:14', '2019-10-05 09:05:14'),
(21, '27901911', 'MARIA EUFEMIA', 'SANCHEZ', 'TORRES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:05:33', '2019-10-05 09:05:33'),
(22, '80456618', 'HILDA', 'ALARCON', 'VILCHEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:05:56', '2019-10-05 09:05:56'),
(23, '27901723', 'DEMETRIO CANDELARIO', 'ABANTO', 'CARRERA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:06:23', '2019-10-05 09:06:23'),
(24, '27901748', 'VALENTIN', 'ABANTO', 'CARRERA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:06:53', '2019-10-05 09:06:53'),
(25, '27902877', 'LINO ANDRES', 'PONCE', 'MEDINA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:07:15', '2019-10-05 09:07:15'),
(26, '27902796', 'SEGUNDO VIRGILIO', 'RUIZ', 'SANCHEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:07:38', '2019-10-05 09:07:38'),
(27, '27905054', 'JOSE EUSEBIO', 'RUIZ', 'PORTAL', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:08:16', '2019-10-05 09:08:16'),
(28, '27905022', 'JOSÉ VALENTÍN', 'SÁNCHEZ', 'MELÉNDEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:08:44', '2019-10-05 09:08:44'),
(29, '46077136', 'TADITA AUDILA', 'MELÉNDEZ', 'MACHUCA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:09:22', '2019-10-05 09:09:22'),
(30, '45997675', 'GILBERTO AGAPITO', 'GARCIA', 'HONORIO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:09:49', '2019-10-05 09:09:49'),
(31, '27903790', 'JOSÉ TEOFILO', 'GARCÍA', 'PAJARES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:11:26', '2019-10-05 09:11:26'),
(32, '27907682', 'MARCOS AMADOR', 'BURGOS', 'URBINA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:11:59', '2019-10-05 09:11:59'),
(33, '41803968', 'VILMA MARILU', 'PAREDES', 'PORTAL', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:12:14', '2019-10-05 09:12:14'),
(34, '26702047', 'DOMINGO', 'SANCHEZ', 'TANTA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:12:33', '2019-10-05 09:12:33'),
(35, '27929064', 'ROSA VIOLETA', 'MUÑOZ', 'BUENO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:12:51', '2019-10-05 09:12:51'),
(36, '27916604', 'JULIO', 'CABANILLAS', 'ROMERO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:13:11', '2019-10-05 09:13:11'),
(37, '27901578', 'MARIA', 'HERLINDA', 'MUÑOZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:13:28', '2019-10-05 09:13:28'),
(38, '43728818', 'ERMINDA', 'JARA', 'CHOROCO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:13:48', '2019-10-05 09:13:48'),
(39, '21012004', 'MARIA ESTELA', 'RODRIGUEZ', 'PINEDO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:14:30', '2019-10-05 09:14:30'),
(40, '20962820', 'EVA MARIA', 'ABANTO', 'ARBILDO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:14:56', '2019-10-05 09:14:56'),
(41, '27905558', 'MANUEL JESUS', 'PERALTA', 'TAPIA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:15:13', '2019-10-05 09:15:13'),
(42, '27916819', 'MARINA ALCIRA', 'CARRERA', 'CASTAÑEDA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:15:33', '2019-10-05 09:15:33'),
(43, '42484170', 'CONCEPCION', 'QUILICHE', 'DIAZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:15:57', '2019-10-05 09:15:57'),
(44, '45175673', 'DANY ALEYCER', 'GALLARDO', 'MERCADO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:16:16', '2019-10-05 09:16:16'),
(45, '27928322', 'JULIO CELSO', 'LIÑAN', 'VERA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:16:59', '2019-10-05 09:16:59'),
(46, '27904022', 'MARIA BENEDICTA', 'MACHUCA', 'RUIZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:17:28', '2019-10-05 09:17:28'),
(47, '27901626', 'JOSE NICOLAS', 'ABANTO', 'MUÑOZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:17:46', '2019-10-05 09:17:46'),
(48, '46317371', 'MARÍA PILAR BERTILA', 'RUIZ', 'VERA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:18:04', '2019-10-05 09:18:04'),
(49, '7730519', 'MARÍA NICOLASA', 'CALDERON', 'BURGOS', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:18:19', '2019-10-05 09:18:19'),
(50, '17730519', 'MARÍA NICOLASA', 'CALDERON', 'BURGOS', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:18:49', '2019-10-05 09:18:49'),
(51, '27902763', 'APARICIO', 'CERNA', 'PAREDES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:19:10', '2019-10-05 09:19:10'),
(52, '27905156', 'AURORA ALBERTINA', 'PALOMINO', 'SILVA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:19:27', '2019-10-05 09:19:27'),
(53, '27902544', 'JOSE DOMINGO', 'CALDERON', 'SILVA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:19:45', '2019-10-05 09:19:45'),
(54, '27915436', 'MARIA CECILIA', 'DAVILA', 'ROJAS', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:20:17', '2019-10-05 09:20:17'),
(55, '42257828', 'MARIA FELIPA', 'MACHUCA', 'SANCHEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:20:32', '2019-10-05 09:20:32'),
(56, '47501375', 'MARIA ZARELA', 'MELENDEZ', 'ABANTO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:20:46', '2019-10-05 09:20:46'),
(57, '27904680', 'JOSE CELSO', 'SALAS', 'DURAN', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:21:03', '2019-10-05 09:21:03'),
(58, '27929719', 'FELICITAS', 'ABANTO', 'TERRONES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:21:19', '2019-10-05 09:21:19'),
(59, '43544866', 'MARIA ROSA', 'SEMPERTEGUI', 'ROJAS', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:21:36', '2019-10-05 09:21:36'),
(60, '44840013', 'SAMY SOCORRO', 'BRAVO', 'SANCHEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:21:58', '2019-10-05 09:21:58'),
(61, '80030503', 'MARIA JUANA', 'PASTOR', 'SÁNCHEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:22:19', '2019-10-05 09:22:19'),
(62, '42713896', 'JOEL', 'ALVARES', 'CASTRO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:22:38', '2019-10-05 09:22:38'),
(63, '27908527', 'MARIA ROSARIO', 'LEYVA', 'DE BURGOS', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:22:58', '2019-10-05 09:22:58'),
(64, '27916556', 'FAUSTO', 'QUIROZ', 'PAREDES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:23:17', '2019-10-05 09:23:17'),
(65, '45089846', 'FELIPE EDUARDO', 'ABANTO', 'RIOS', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:23:51', '2019-10-05 09:23:51'),
(66, '74131965', 'MILY', 'VERA', 'CARRERA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:24:11', '2019-10-05 09:24:11'),
(67, '45127097', 'LUCY MAGALY', 'VALDEZ', 'VALDERRAMA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:24:28', '2019-10-05 09:24:28'),
(68, '47173380', 'MARIA ENAMI', 'SANCHEZ', 'MACHUCA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:24:42', '2019-10-05 09:24:42'),
(69, '43544854', 'YANET MARITZA', 'QUISPE', 'URBINA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:24:59', '2019-10-05 09:24:59'),
(70, '19333366', 'DORIS ELISA', 'VALENCIA', 'BARRERA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:25:16', '2019-10-05 09:25:16'),
(71, '27927897', 'VICTOR JESUS', 'VICTOR', 'JESUS', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:25:32', '2019-10-05 09:25:32'),
(72, '40668373', 'TOMASA', 'MELENDEZ', 'MACHUCA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:25:52', '2019-10-05 09:25:52'),
(73, '27930219', 'ADRIANA', 'CERNA', 'RUIZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:26:53', '2019-10-05 09:26:53'),
(74, '27906426', 'ROSA JUSTINA', 'LEIVA', 'DE PERALTA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:27:08', '2019-10-05 09:27:08'),
(75, '42689305', 'SANTOS TERESA', 'FLORES', 'RUBIO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:27:24', '2019-10-05 09:27:24'),
(76, '80457227', 'ENRIQUE', 'HORNA', 'MELENDEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:27:39', '2019-10-05 09:27:39'),
(77, '27900953', 'ELADIO', 'TELLO', 'CHUPE', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:28:05', '2019-10-05 09:28:05'),
(78, '27904857', 'JOSE HIPOLITO', 'COTRINA', 'HONORIO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:28:23', '2019-10-05 09:28:23'),
(79, '42246765', 'GEISER SOLANO', 'VARGAS', 'CORONEL', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:28:40', '2019-10-05 09:28:40'),
(80, '27905157', 'LORENZO MERCEDES', 'ROJAS', 'PAREDES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:28:56', '2019-10-05 09:28:56'),
(81, '27902265', 'ANDRES', 'ESPINOZA', 'CERNA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:29:18', '2019-10-05 09:29:18'),
(82, '40369535', 'YESSICA MARISELA', 'MONTOYA', 'MUÑOZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:29:42', '2019-10-05 09:29:42'),
(83, '26704326', 'SOLEDAD', 'MONTOYA', 'MUÑOZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:30:00', '2019-10-05 09:30:00'),
(84, '27930570', 'JACINTO', 'VEGA', 'IZQUIERDO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:30:19', '2019-10-05 09:30:19'),
(85, '80029892', 'MARIA FRANCISCA', 'ABANTO', 'BAUTISTA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:30:34', '2019-10-05 09:30:34'),
(86, '45272660', 'MARIA GLORIOSA', 'MEDINA', 'JARA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:30:50', '2019-10-05 09:30:50'),
(87, '27923988', 'MARIA ANDREA', 'MACHUCA', 'JIMENEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:31:12', '2019-10-05 09:31:12'),
(88, '46636247', 'DALIA RUBI', 'SARMIENTO', 'MACHUCA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:31:26', '2019-10-05 09:31:26'),
(89, '27904121', 'JUSTINA', 'VARGAS', 'TERRONES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:31:42', '2019-10-05 09:31:42'),
(90, '48768630', 'MARILU', 'TORRES', 'ARANA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:31:57', '2019-10-05 09:31:57'),
(91, '27903118', 'CLEMENTE', 'CALDERON', 'IZQUIERDO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:32:12', '2019-10-05 09:32:12'),
(92, '27930459', 'JUAN CARLOS', 'JARA', 'MORALES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:32:35', '2019-10-05 09:32:35'),
(93, '45257828', 'MARIA FELIPA', 'MACHUCA', 'SANCHEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:32:49', '2019-10-05 09:32:49'),
(94, '27916044', 'JOSE MAGNO', 'MACHUCA', 'RUIZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:33:06', '2019-10-05 09:33:06'),
(95, '27905275', 'ASUNCIÓN ELVIRA', 'FLORES', 'CENTURION', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:33:24', '2019-10-05 09:33:24'),
(96, '27916223', 'ALEJANDRO ABUNDIO', 'ABANTO', 'CERNA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:33:45', '2019-10-05 09:33:45'),
(97, '40756469', 'TANIA MARGOT', 'VELASQUEZ', 'MEDINA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:34:00', '2019-10-05 09:34:00'),
(98, '40556944', 'PERSHING BERSAEL', 'MANTILLA', 'CALDERON', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:34:18', '2019-10-05 09:34:18'),
(99, '47671932', 'JOSE RETILANO', 'VARGAS', 'CORONEL', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:34:33', '2019-10-05 09:34:33'),
(100, '72941394', 'LEYDI', 'ROJAS', 'ALCALDE', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:34:50', '2019-10-05 09:34:50'),
(101, '27929199', 'SANTOS SOCORRO', 'ALCALDE', 'ABANTO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:35:05', '2019-10-05 09:35:05'),
(102, '27902701', 'MARIA NICOLAZA', 'LEZMA', 'COTRINA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:36:17', '2019-10-05 09:36:17'),
(103, '27917033', 'JUANA', 'PAREDES', 'BRIONES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:36:35', '2019-10-05 09:36:35'),
(104, '27930199', 'JOSE ANGEL', 'ALARCON', 'ROJAS', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:36:53', '2019-10-05 09:36:53'),
(105, '44358748', 'MANUEL HERNANDO', 'BURGOS', 'LEYVA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:37:18', '2019-10-05 09:37:18'),
(106, '27917086', 'CRUZ DEL CARMEN', 'YUPANQUI', 'COTRINA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:37:34', '2019-10-05 09:37:34'),
(107, '27917066', 'WILFREDO', 'CASTAÑEDA', 'ROJAS', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:37:51', '2019-10-05 09:37:51'),
(108, '44031023', 'SANTOS EDIS', 'GONZALES', 'VALERA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:38:07', '2019-10-05 09:38:07'),
(109, '43213832', 'ERLITH YARDENY', 'TAPIA', 'MALAVER', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:38:23', '2019-10-05 09:38:23'),
(110, '70523082', 'ANALY', 'MELENDEZ', 'MACHUCA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:38:48', '2019-10-05 09:38:48'),
(111, '27914971', 'MARCELINA BENIGNA', 'MENDOZA', 'PAREDES', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:39:03', '2019-10-05 09:39:03'),
(112, '72042291', 'YULY', 'ROJAS', 'ALCALDE', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:39:20', '2019-10-05 09:39:20'),
(113, '27901900', 'TEONILA', 'SANCHEZ', 'GARRO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:39:34', '2019-10-05 09:39:34'),
(114, '44896104', 'MIRIAN', 'ABANTO', 'MACHUCA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:39:48', '2019-10-05 09:39:48'),
(115, '70408061', 'DIANA MARITZA', 'PAREDES', 'SANCHEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:40:03', '2019-10-05 09:40:03'),
(116, '42484178', 'LUZ MARIBEL', 'BRAVO', 'SANCHEZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:40:21', '2019-10-05 09:40:21'),
(117, '46514971', 'KARINA NOEMI', 'MALCA', 'QUIROZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:40:37', '2019-10-05 09:40:37'),
(118, '27928010', 'MARIA BALVINA', 'CABRERA', 'ROMERO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:40:51', '2019-10-05 09:40:51'),
(119, '19244355', 'JUAN', 'MACHUCA', 'CABRERA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:41:07', '2019-10-05 09:41:07'),
(120, '27905636', 'ROSA JUSTINA', 'LEIVA DE', 'PERALTA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:41:32', '2019-10-05 09:41:32'),
(121, '48206054', 'DEYSI DIANA', 'CALDERON', 'GARCIA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:41:47', '2019-10-05 09:41:47'),
(122, '27905266', 'CONCEPCION', 'MORALES', 'VECORENA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:42:10', '2019-10-05 09:42:10'),
(123, '44366079', 'JHENY LILIANA', 'BURGOS', 'LEYVA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:42:28', '2019-10-05 09:42:28'),
(124, '27916320', 'MARIA BENIGNA', 'RAMOS', 'QUIROZ', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:42:44', '2019-10-05 09:42:44'),
(125, '47611238', 'JULIA', 'SANCHEZ', 'ABANTO', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:42:59', '2019-10-05 09:42:59'),
(126, '41393361', 'ELMER', 'ABANTO', 'MACHUCA', NULL, NULL, NULL, NULL, '1', '2019-10-05 09:43:18', '2019-10-05 09:43:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `porciones`
--

CREATE TABLE `porciones` (
  `idporcion` int(11) NOT NULL,
  `id` int(10) UNSIGNED NOT NULL,
  `idusuario` int(10) UNSIGNED NOT NULL,
  `fechapago` date NOT NULL,
  `fechacancelacion` datetime NOT NULL,
  `monto` decimal(7,2) NOT NULL,
  `otroscostos` decimal(7,2) DEFAULT NULL,
  `descripcion` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 activo / 0inactivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Administrador', 'Administradores del área', 1),
(2, 'Cajero', 'Atencion de pago de cuotas', 1),
(3, 'Analista', 'Asinacion de creditos', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 activo / 0inactivo',
  `idrol` int(10) UNSIGNED NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `condicion`, `idrol`, `remember_token`) VALUES
(5, 'admin', '$2y$10$fSfxHP3tpDo4bgKjJySUgulJrssDYf6iUR151wKPeceL5ioG4naZ2', 1, 1, NULL),
(12, 'BRAVO45', '$2y$10$V8dhIrd.OZhCqOYTa8p0Je9fG3Dh8mtWeAlS9pkYduVl03UZ8oaRG', 1, 1, NULL),
(13, 'BRAVO52', '$2y$10$AIGydXpVflbH3hEO/BEIlu0Ho5BhuUiTSUgyALIA0nWyAws6FYr0y', 1, 1, NULL),
(11, 'COTRINA37', '$2y$10$sf4XVYUJxNsN9C.fyJUFVeVmgnBDD/bDU8BSvYi/GW216LsJc7Cpy', 1, 1, NULL),
(10, 'SONIA35', '$2y$10$7m49wOLYDO6U0NHf6FSiP.gNdDq5gXmG2yeUTZigTMScaJmEd2HYm', 1, 1, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD KEY `clientes_id_foreign` (`id`);

--
-- Indices de la tabla `creditos`
--
ALTER TABLE `creditos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numeroprestamo` (`numeroprestamo`),
  ADD UNIQUE KEY `idkiva` (`idkiva`),
  ADD KEY `creditos_idcliente_foreign` (`idcliente`),
  ADD KEY `creditos_idusuario_foreign` (`idusuario`);

--
-- Indices de la tabla `creditos_bitacora`
--
ALTER TABLE `creditos_bitacora`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idcredito` (`idcredito`);

--
-- Indices de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cuotas_idusuario_foreign` (`idusuario`),
  ADD KEY `cuotas_idcredito_foreign` (`idcredito`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personas_dni_unique` (`dni`);

--
-- Indices de la tabla `porciones`
--
ALTER TABLE `porciones`
  ADD PRIMARY KEY (`idporcion`),
  ADD KEY `porciones_id_foreign` (`id`),
  ADD KEY `porciones_idusuario_foreign` (`idusuario`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_nombre_unique` (`nombre`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`),
  ADD KEY `users_id_foreign` (`id`),
  ADD KEY `users_idrol_foreign` (`idrol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `creditos`
--
ALTER TABLE `creditos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `creditos_bitacora`
--
ALTER TABLE `creditos_bitacora`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT de la tabla `porciones`
--
ALTER TABLE `porciones`
  MODIFY `idporcion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_id_foreign` FOREIGN KEY (`id`) REFERENCES `personas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `creditos`
--
ALTER TABLE `creditos`
  ADD CONSTRAINT `creditos_idcliente_foreign` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `creditos_idusuario_foreign` FOREIGN KEY (`idusuario`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `creditos_bitacora`
--
ALTER TABLE `creditos_bitacora`
  ADD CONSTRAINT `creditos_bitacora_ibfk_1` FOREIGN KEY (`idcredito`) REFERENCES `creditos` (`id`);

--
-- Filtros para la tabla `cuotas`
--
ALTER TABLE `cuotas`
  ADD CONSTRAINT `cuotas_idcredito_foreign` FOREIGN KEY (`idcredito`) REFERENCES `creditos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cuotas_idusuario_foreign` FOREIGN KEY (`idusuario`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `porciones`
--
ALTER TABLE `porciones`
  ADD CONSTRAINT `porciones_id_foreign` FOREIGN KEY (`id`) REFERENCES `cuotas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `porciones_idusuario_foreign` FOREIGN KEY (`idusuario`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_id_foreign` FOREIGN KEY (`id`) REFERENCES `personas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_idrol_foreign` FOREIGN KEY (`idrol`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
