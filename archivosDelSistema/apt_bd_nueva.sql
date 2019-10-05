-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-09-2019 a las 04:49:01
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `apt_bd`
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
(63, '1', '1'),
(64, '1', '1'),
(65, '1', '1'),
(66, '1', '1'),
(67, '1', '1');

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
  `periodo` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1 mesnual/2 bimensula/3 trimestral/6 semestral /12 anual',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `creditos`
--

INSERT INTO `creditos` (`id`, `idcliente`, `idusuario`, `numeroprestamo`, `idkiva`, `montodesembolsado`, `fechadesembolso`, `fechakiva`, `numerocuotas`, `tipocambio`, `tasa`, `estado`, `periodo`, `created_at`, `updated_at`) VALUES
(59, 64, 62, 'SM20150008', '867401', '1700.00', '2016-04-18', '0000-00-00', 4, '3.150000', '11.00', '2', '1', '2019-09-14 10:13:10', '2019-09-14 10:15:38'),
(61, 63, 62, 'SM20190002', '902132', '1800.00', '2019-07-04', '0000-00-00', 12, '3.150000', '13.00', '1', '1', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(62, 64, 62, 'SM20190003', '902134', '2000.00', '2019-01-14', '0000-00-00', 12, '3.150000', '11.00', '1', '1', '2019-09-14 10:35:06', '2019-09-14 10:35:06'),
(63, 67, 62, 'SM20180008', '123265', '1700.00', '2018-08-04', '0000-00-00', 4, '3.150000', '13.00', '1', '3', '2019-09-14 10:45:54', '2019-09-14 10:45:54'),
(66, 66, 62, 'SM236528', '785213', '1700.00', '2019-09-14', '2019-09-12', 12, '3.150000', '13.00', '1', '1', '2019-09-15 08:50:34', '2019-09-15 08:55:46'),
(67, 65, 62, 'dvfgfd', 'fgfghf', '1700.00', '2019-09-15', '2019-09-15', 12, '3.150000', '13.00', '1', '1', '2019-09-16 04:46:46', '2019-09-16 04:46:46');

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
  `fechacambio` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `creditos_bitacora`
--

INSERT INTO `creditos_bitacora` (`id`, `idcredito`, `idcliente_n`, `idcliente_v`, `idusuario_n`, `idusuario_v`, `numeroprestamo_n`, `numeroprestamo_v`, `idkiva_n`, `idkiva_v`, `fechakiva_n`, `fechakiva_v`, `estado_n`, `estado_v`, `condicion`, `fechacambio`) VALUES
(1, 59, 64, 0, 62, 0, 'SM20150009', '', '867400', '', '0000-00-00', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-09-14 05:13:10'),
(2, 59, 64, 64, 62, 62, 'SM20150008', 'SM20150009', '867401', '867400', '0000-00-00', '0000-00-00', '1', '1', 'CREDITO ACTUALIZADO', '2019-09-14 05:15:38'),
(3, 59, 64, 64, 62, 62, 'SM20150008', 'SM20150008', '867401', '867401', '0000-00-00', '0000-00-00', '2', '1', 'CREDITO ACTUALIZADO', '2019-09-14 05:16:29'),
(5, 61, 63, 0, 62, 0, 'SM20190002', '', '902132', '', '0000-00-00', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-09-14 05:31:03'),
(6, 62, 64, 0, 62, 0, 'SM20190003', '', '902134', '', '0000-00-00', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-09-14 05:35:06'),
(7, 63, 67, 0, 62, 0, 'SM20180008', '', '123265', '', '0000-00-00', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-09-14 05:45:54'),
(10, 66, 66, 0, 62, 0, 'SM236521', '', '785210', '', '2019-09-12', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-09-15 03:50:34'),
(11, 66, 66, 66, 62, 62, 'SM236521', 'SM236521', '785213', '785210', '2019-09-12', '2019-09-12', '1', '1', 'CREDITO ACTUALIZADO', '2019-09-15 03:52:28'),
(12, 66, 66, 66, 62, 62, 'SM236528', 'SM236521', '785213', '785213', '2019-09-12', '2019-09-12', '1', '1', 'CREDITO ACTUALIZADO', '2019-09-15 03:55:46'),
(13, 67, 65, 0, 62, 0, 'dvfgfd', '', 'fgfghf', '', '2019-09-15', '0000-00-00', '1', '1', 'NUEVO CREDITO', '2019-09-15 23:46:46');

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
(235, 62, 59, 1, '2016-05-18', '2016-05-14 15:16:18', '1275.00', '471.75', '0.00', NULL, '1', '2019-09-14 10:13:10', '2019-09-14 10:13:10'),
(236, 62, 59, 2, '2016-06-18', '2016-06-14 03:18:18', '850.00', '471.75', '0.00', NULL, '1', '2019-09-14 10:13:10', '2019-09-14 10:13:10'),
(237, 62, 59, 3, '2016-07-18', '2016-07-14 10:21:14', '425.00', '471.75', '0.00', NULL, '1', '2019-09-14 10:13:10', '2019-09-14 10:13:10'),
(238, 62, 59, 4, '2016-08-18', '2016-08-14 08:25:18', '0.00', '471.75', '0.00', NULL, '1', '2019-09-14 10:13:10', '2019-09-14 10:13:10'),
(241, 62, 61, 1, '2019-08-04', '2019-08-14 04:12:11', '1650.00', '169.50', '0.00', NULL, '1', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(242, 62, 61, 2, '2019-09-04', '2019-09-14 01:09:40', '1500.00', '169.50', '0.00', 'Cuota pagada', '1', '2019-09-14 10:31:03', '2019-09-14 11:09:40'),
(243, 62, 61, 3, '2019-10-04', '2019-09-14 00:00:00', '1350.00', '169.50', '0.00', NULL, '0', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(244, 62, 61, 4, '2019-11-04', '2019-09-14 00:00:00', '1200.00', '169.50', '0.00', NULL, '0', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(245, 62, 61, 5, '2019-12-04', '2019-09-14 00:00:00', '1050.00', '169.50', '0.00', NULL, '0', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(246, 62, 61, 6, '2020-01-04', '2019-09-14 00:00:00', '900.00', '169.50', '0.00', NULL, '0', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(247, 62, 61, 7, '2020-02-04', '2019-09-14 00:00:00', '750.00', '169.50', '0.00', NULL, '0', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(248, 62, 61, 8, '2020-03-04', '2019-09-14 00:00:00', '600.00', '169.50', '0.00', NULL, '0', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(249, 62, 61, 9, '2020-04-04', '2019-09-14 00:00:00', '450.00', '169.50', '0.00', NULL, '0', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(250, 62, 61, 10, '2020-05-04', '2019-09-14 00:00:00', '300.00', '169.50', '0.00', NULL, '0', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(251, 62, 61, 11, '2020-06-04', '2019-09-14 00:00:00', '150.00', '169.50', '0.00', NULL, '0', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(252, 62, 61, 12, '2020-07-04', '2019-09-14 00:00:00', '0.00', '169.50', '0.00', NULL, '0', '2019-09-14 10:31:03', '2019-09-14 10:31:03'),
(253, 62, 62, 1, '2019-02-14', '2019-02-14 05:12:13', '1833.33', '185.00', '0.00', NULL, '1', '2019-09-14 10:35:06', '2019-09-14 10:35:06'),
(254, 62, 62, 2, '2019-03-14', '2019-03-14 06:14:00', '1666.66', '185.00', '0.00', NULL, '1', '2019-09-14 10:35:06', '2019-09-14 10:35:06'),
(255, 62, 62, 3, '2019-04-14', '2019-04-14 04:12:11', '1499.99', '185.00', '0.00', NULL, '1', '2019-09-14 10:35:07', '2019-09-14 10:35:07'),
(256, 62, 62, 4, '2019-05-14', '2019-05-14 04:13:11', '1333.32', '185.00', '0.00', NULL, '1', '2019-09-14 10:35:07', '2019-09-14 10:35:07'),
(257, 62, 62, 5, '2019-06-14', '2019-06-14 05:18:21', '1166.65', '185.00', '0.00', NULL, '1', '2019-09-14 10:35:07', '2019-09-14 10:35:07'),
(258, 62, 62, 6, '2019-07-14', '2019-07-14 04:13:19', '999.98', '185.00', '0.00', NULL, '1', '2019-09-14 10:35:07', '2019-09-14 10:35:07'),
(259, 62, 62, 7, '2019-08-14', '2019-09-14 00:00:00', '833.31', '185.00', '0.00', NULL, '1', '2019-09-14 10:35:07', '2019-09-14 10:35:07'),
(260, 62, 62, 8, '2019-09-14', '2019-09-14 22:58:47', '666.64', '185.00', '0.00', 'Cuota pagada', '1', '2019-09-14 10:35:07', '2019-09-15 08:58:47'),
(261, 62, 62, 9, '2019-10-14', '2019-09-14 00:00:00', '499.97', '185.00', '0.00', NULL, '0', '2019-09-14 10:35:07', '2019-09-14 10:35:07'),
(262, 62, 62, 10, '2019-11-14', '2019-09-14 00:00:00', '333.30', '185.00', '0.00', NULL, '0', '2019-09-14 10:35:07', '2019-09-14 10:35:07'),
(263, 62, 62, 11, '2019-12-14', '2019-09-14 00:00:00', '166.63', '185.00', '0.00', NULL, '0', '2019-09-14 10:35:07', '2019-09-14 10:35:07'),
(264, 62, 62, 12, '2020-01-14', '2019-09-14 00:00:00', '0.00', '185.00', '0.00', NULL, '0', '2019-09-14 10:35:07', '2019-09-14 10:35:07'),
(265, 62, 63, 1, '2018-11-04', '2019-09-14 00:00:00', '1275.00', '480.25', '0.00', NULL, '0', '2019-09-14 10:45:54', '2019-09-14 10:45:54'),
(266, 62, 63, 2, '2019-02-04', '2019-09-14 00:00:00', '850.00', '480.25', '0.00', NULL, '0', '2019-09-14 10:45:54', '2019-09-14 10:45:54'),
(267, 62, 63, 3, '2019-05-04', '2019-09-14 00:00:00', '425.00', '480.25', '0.00', NULL, '0', '2019-09-14 10:45:54', '2019-09-14 10:45:54'),
(268, 62, 63, 4, '2019-08-04', '2019-09-14 00:00:00', '0.00', '480.25', '0.00', NULL, '0', '2019-09-14 10:45:54', '2019-09-14 10:45:54'),
(269, 62, 66, 1, '2019-10-14', '2019-09-14 00:00:00', '1558.33', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:34', '2019-09-15 08:50:34'),
(270, 62, 66, 2, '2019-11-14', '2019-09-14 00:00:00', '1416.66', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:34', '2019-09-15 08:50:34'),
(271, 62, 66, 3, '2019-12-14', '2019-09-14 00:00:00', '1274.99', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:34', '2019-09-15 08:50:34'),
(272, 62, 66, 4, '2020-01-14', '2019-09-14 00:00:00', '1133.32', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:34', '2019-09-15 08:50:34'),
(273, 62, 66, 5, '2020-02-14', '2019-09-14 00:00:00', '991.65', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:34', '2019-09-15 08:50:34'),
(274, 62, 66, 6, '2020-03-14', '2019-09-14 00:00:00', '849.98', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:34', '2019-09-15 08:50:34'),
(275, 62, 66, 7, '2020-04-14', '2019-09-14 00:00:00', '708.31', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:35', '2019-09-15 08:50:35'),
(276, 62, 66, 8, '2020-05-14', '2019-09-14 00:00:00', '566.64', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:35', '2019-09-15 08:50:35'),
(277, 62, 66, 9, '2020-06-14', '2019-09-14 00:00:00', '424.97', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:35', '2019-09-15 08:50:35'),
(278, 62, 66, 10, '2020-07-14', '2019-09-14 00:00:00', '283.30', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:35', '2019-09-15 08:50:35'),
(279, 62, 66, 11, '2020-08-14', '2019-09-14 00:00:00', '141.63', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:35', '2019-09-15 08:50:35'),
(280, 62, 66, 12, '2020-09-14', '2019-09-14 00:00:00', '0.00', '160.08', '0.00', NULL, '0', '2019-09-15 08:50:35', '2019-09-15 08:50:35'),
(281, 62, 67, 1, '2019-10-15', '2019-09-15 00:00:00', '1558.33', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(282, 62, 67, 2, '2019-11-15', '2019-09-15 00:00:00', '1416.66', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(283, 62, 67, 3, '2019-12-15', '2019-09-15 00:00:00', '1274.99', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(284, 62, 67, 4, '2020-01-15', '2019-09-15 00:00:00', '1133.32', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(285, 62, 67, 5, '2020-02-15', '2019-09-15 00:00:00', '991.65', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(286, 62, 67, 6, '2020-03-15', '2019-09-15 00:00:00', '849.98', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(287, 62, 67, 7, '2020-04-15', '2019-09-15 00:00:00', '708.31', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(288, 62, 67, 8, '2020-05-15', '2019-09-15 00:00:00', '566.64', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(289, 62, 67, 9, '2020-06-15', '2019-09-15 00:00:00', '424.97', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(290, 62, 67, 10, '2020-07-15', '2019-09-15 00:00:00', '283.30', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(291, 62, 67, 11, '2020-08-15', '2019-09-15 00:00:00', '141.63', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46'),
(292, 62, 67, 12, '2020-09-15', '2019-09-15 00:00:00', '0.00', '141.67', '0.00', NULL, '0', '2019-09-16 04:46:46', '2019-09-16 04:46:46');

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
(11, '2019_08_28_014751_create_porciones_table', 5);

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
(10, '46845049', 'SONIA MARLENI', 'JARA', 'FERNANDEZ', '1991-12-22', 'jr.tupac amaru 069', '973360168', 'JFERNANDEZSONIA53@GMAIL.COM', '1', '2019-09-02 06:23:49', '2019-09-02 06:23:49'),
(11, '26622238', 'JOSE ESTANISLAO', 'COTRINA', 'OLANO', '1953-06-27', 'Av. Primavera Nº 100', '976384362', 'JOSCOTRI.APT@GMAIL.COM', '1', '2019-09-02 06:28:11', '2019-09-02 06:28:11'),
(12, '12341234', 'SAMY', 'BRAVO', 'SANCHEZ', '2008-02-01', 'SAN MARCOS SN', '965821236', 'SAMY@GMAIL.COM', '1', '2019-09-02 06:29:29', '2019-09-14 10:02:38'),
(62, '70212063', 'JOSE LUIS', 'RAMIREZ', 'QUIROZ', '1993-03-01', 'JR. AHATUALPA 500', '964923450', 'JOSE@GMAIL.COM', '1', '2019-09-14 10:01:51', '2019-09-14 10:01:51'),
(63, '27901911', 'MARIA', 'SANCHEZ', 'TORRES', NULL, 'SAN MARCOS SN', '964253258', 'MARIA@GMAIL.COM', '1', '2019-09-14 10:08:02', '2019-09-14 10:08:02'),
(64, '80456618', 'HILDA', 'ALARCON', 'VILCHEZ', NULL, 'SAN MARCOS 548', '954123550', 'HILDA@GMAIL.COM', '1', '2019-09-14 10:09:20', '2019-09-14 10:09:20'),
(65, '45997675', 'GILBERTO AGAPITO', 'AGAPITO', 'HONORIO', NULL, 'SAN MARCOS 421', '912632541', 'GILBERTO@GMAIL.COM', '1', '2019-09-14 10:10:48', '2019-09-14 10:10:48'),
(66, '8033330', 'LEONIDAS', 'ESTACIO', 'DIAZ', NULL, 'JR. LA LIBERTAS', '9696969', 'LEONIDAS@GMAIL.COM', '1', '2019-09-14 10:41:42', '2019-09-14 10:41:42'),
(67, '72542136', 'MARA JUDITH MARIA', 'QUILICHE', 'HUARIPATA', NULL, 'SAN MARCOS SN', '958326542', 'MAR@GMAIL.COM', '1', '2019-09-14 10:43:12', '2019-09-15 22:41:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `porciones`
--

CREATE TABLE `porciones` (
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
  `condicion` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 activo / 0inactivo'
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
  `condicion` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 activo / 0inactivo',
  `idrol` int(10) UNSIGNED NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `condicion`, `idrol`, `remember_token`) VALUES
(62, 'admin', '$2y$10$ayJbs222qHgeB4Jyhih5BeZzR/46oRpMLQXeD0Io3By5938rCyOkq', 1, 1, NULL),
(12, 'BRAVO45', '$2y$10$ZdLgynyEWDM2t4NISbwavOaqmpZXpZauIa.GrBjxqWr7JTjwaM1mO', 1, 1, NULL),
(11, 'COTRINA37', '$2y$10$uB5zvGMgT.GUPiXk5VA94uBlXxFZ.89Y/wjsFCHtSV0nJx75ugoNm', 1, 1, NULL),
(10, 'SONIA45', '$2y$10$tfTcJ1mLAy0mkDPgawSzDO.s4WwP9mXtKaOG.0jQrqxbODTG3XwAS', 1, 1, NULL);

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
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT de la tabla `creditos_bitacora`
--
ALTER TABLE `creditos_bitacora`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=293;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

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
