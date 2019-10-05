-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-09-2019 a las 01:46:26
-- Versión del servidor: 10.1.21-MariaDB
-- Versión de PHP: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cersa_aptsanmarcos`
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
(14, '1', '1'),
(15, '1', '1'),
(16, '1', '1'),
(17, '1', '1'),
(18, '1', '1'),
(37, '1', '1'),
(40, '1', '1'),
(41, '1', '1'),
(43, '1', '1'),
(44, '1', '1'),
(45, '1', '0'),
(46, '0', '1'),
(48, '0', '0'),
(49, '0', '0'),
(51, '0', '0');

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

INSERT INTO `creditos` (`id`, `idcliente`, `idusuario`, `numeroprestamo`, `idkiva`, `montodesembolsado`, `fechadesembolso`, `numerocuotas`, `tipocambio`, `tasa`, `estado`, `periodo`, `created_at`, `updated_at`) VALUES
(49, 14, 13, 'SM20150001', '847553', '1800.00', '2015-05-25', 12, '3.150000', '13.00', '1', '1', '2019-09-02 06:48:36', '2019-09-14 02:51:41'),
(50, 15, 13, 'SM20150002', '847562', '1700.00', '2015-05-25', 12, '3.150000', '11.00', '1', '1', '2019-09-03 08:37:40', '2019-09-14 01:17:03'),
(51, 16, 13, 'SM20150003', '847598', '17800.00', '2015-05-25', 12, '3.150000', '11.00', '1', '1', '2019-09-03 08:47:33', '2019-09-14 03:00:53'),
(52, 37, 13, '4553', '4553', '1152.00', '2019-09-14', 52, '3.150000', '13.00', '1', '1', '2019-09-09 21:53:03', '2019-09-14 03:01:30'),
(53, 18, 13, 'SM00005854', '1245325', '1800.00', '2019-09-11', 4, '3.150000', '11.00', '1', '1', '2019-09-11 22:24:20', '2019-09-13 22:22:29'),
(54, 17, 13, 'SM005854', '1232654', '1700.00', '2019-09-11', 12, '3.250000', '11.00', '1', '1', '2019-09-12 02:49:14', '2019-09-14 01:56:50'),
(55, 41, 13, 'aaaasdas45', 'asdasd4564', '1700.00', '2019-09-11', 12, '3.150000', '11.00', '1', '1', '2019-09-12 03:21:15', '2019-09-13 22:21:59'),
(56, 43, 13, 'asdasd45', 'asdasd', '15200.00', '2019-09-11', 4, '3.150000', '11.00', '1', '3', '2019-09-12 04:53:40', '2019-09-14 02:51:31'),
(57, 44, 13, 'pescado', 'ki00045f', '12200.00', '2019-09-12', 4, '3.150000', '11.00', '1', '1', '2019-09-13 01:31:17', '2019-09-14 03:32:10');

--
-- Disparadores `creditos`
--
DELIMITER $$
CREATE TRIGGER `actualizarcredito` AFTER UPDATE ON `creditos` FOR EACH ROW INSERT INTO creditos_bitacora(idcredito,idcliente_n,idusuario_n,numeroprestamo_n,idkiva_n,montodesembolsado_n,fechadesembolso_n,numerocuotas_n,tipocambio_n,tasa_n,estado_n,periodo_n,idcliente_v,idusuario_v,numeroprestamo_v,idkiva_v,montodesembolsado_v,fechadesembolso_v,numerocuotas_v,tipocambio_v,tasa_v,estado_v,periodo_v,condicion)
VALUES(old.id,NEW.idcliente,NEW.idusuario,NEW.numeroprestamo,NEW.idkiva,NEW.montodesembolsado,NEW.fechadesembolso,NEW.numerocuotas,NEW.tipocambio,NEW.tasa,NEW.estado,NEW.periodo,old.idcliente,old.idusuario,old.numeroprestamo,old.idkiva,old.montodesembolsado,old.fechadesembolso,old.numerocuotas,old.tipocambio,old.tasa,old.estado,old.periodo,'CREDITO ACTUALIZADO')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertarcredito` AFTER INSERT ON `creditos` FOR EACH ROW INSERT INTO creditos_bitacora(idcredito,idcliente_n,idusuario_n,numeroprestamo_n,idkiva_n,montodesembolsado_n,fechadesembolso_n,numerocuotas_n,tipocambio_n,tasa_n,estado_n,periodo_n,condicion)
VALUES(NEW.id,NEW.idcliente,NEW.idusuario,NEW.numeroprestamo,NEW.idkiva,NEW.montodesembolsado,NEW.fechadesembolso,NEW.numerocuotas,NEW.tipocambio,NEW.tasa,NEW.estado,NEW.periodo,'NUEVO CREDITO')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `creditos_bitacora`
--

CREATE TABLE `creditos_bitacora` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcredito` int(10) NOT NULL,
  `idcliente_n` int(10) NOT NULL,
  `idcliente_v` int(10) NOT NULL,
  `idusuario_n` int(10) NOT NULL,
  `idusuario_v` int(10) NOT NULL,
  `numeroprestamo_n` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idkiva_n` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montodesembolsado_n` decimal(10,2) NOT NULL,
  `fechadesembolso_n` date NOT NULL,
  `numerocuotas_n` int(11) NOT NULL,
  `tipocambio_n` decimal(7,6) NOT NULL,
  `tasa_n` decimal(4,2) NOT NULL,
  `estado_n` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0 credito desactivado/ 1credito activado/2 credito cancelado',
  `periodo_n` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1 mesnual/2 bimensula/3 trimestral/6 semestral /12 anual',
  `numeroprestamo_v` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idkiva_v` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montodesembolsado_v` decimal(10,2) NOT NULL,
  `fechadesembolso_v` date NOT NULL,
  `numerocuotas_v` int(11) NOT NULL,
  `tipocambio_v` decimal(7,6) NOT NULL,
  `tasa_v` decimal(4,2) NOT NULL,
  `estado_v` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0 credito desactivado/ 1credito activado/2 credito cancelado',
  `periodo_v` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '1 mesnual/2 bimensula/3 trimestral/6 semestral /12 anual',
  `condicion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechacambio` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `creditos_bitacora`
--

INSERT INTO `creditos_bitacora` (`id`, `idcredito`, `idcliente_n`, `idcliente_v`, `idusuario_n`, `idusuario_v`, `numeroprestamo_n`, `idkiva_n`, `montodesembolsado_n`, `fechadesembolso_n`, `numerocuotas_n`, `tipocambio_n`, `tasa_n`, `estado_n`, `periodo_n`, `numeroprestamo_v`, `idkiva_v`, `montodesembolsado_v`, `fechadesembolso_v`, `numerocuotas_v`, `tipocambio_v`, `tasa_v`, `estado_v`, `periodo_v`, `condicion`, `fechacambio`) VALUES
(1, 57, 44, 44, 13, 13, 'sm0000d', 'ki00045', '1200.00', '2019-09-12', 4, '3.150000', '11.00', '1', '1', 'sm0000', 'ki00045', '1200.00', '2019-09-12', 4, '3.150000', '11.00', '1', '1', 'CREDITO ACTUALIZADO', '2019-09-13 21:23:24'),
(2, 57, 44, 44, 13, 13, 'sm0000d', 'ki00045f', '1200.00', '2019-09-12', 4, '3.150000', '11.00', '1', '1', 'sm0000d', 'ki00045', '1200.00', '2019-09-12', 4, '3.150000', '11.00', '1', '1', 'CREDITO ACTUALIZADO', '2019-09-13 21:23:28'),
(3, 57, 44, 44, 13, 13, 'sm0000d', 'ki00045f', '12200.00', '2019-09-12', 4, '3.150000', '11.00', '1', '1', 'sm0000d', 'ki00045f', '1200.00', '2019-09-12', 4, '3.150000', '11.00', '1', '1', 'CREDITO ACTUALIZADO', '2019-09-13 21:50:50'),
(4, 56, 43, 43, 13, 13, 'asdasd45', 'asdasd', '15200.00', '2019-09-11', 4, '3.150000', '11.00', '1', '3', 'asdasd45', 'asdasd', '1200.00', '2019-09-11', 4, '3.150000', '11.00', '1', '3', 'CREDITO ACTUALIZADO', '2019-09-13 21:51:31'),
(5, 49, 14, 14, 13, 13, 'SM20150001', '847553', '1800.00', '2015-05-25', 12, '3.150000', '13.00', '1', '1', 'SM20150001', '847553', '1700.00', '2015-05-25', 12, '3.150000', '13.00', '1', '1', 'CREDITO ACTUALIZADO', '2019-09-13 21:51:41'),
(7, 51, 16, 16, 13, 13, 'SM20150003', '847598', '17800.00', '2015-05-25', 12, '3.150000', '11.00', '1', '1', 'SM20150003', '847598', '1700.00', '2015-05-25', 12, '3.150000', '11.00', '1', '1', 'CREDITO ACTUALIZADO', '2019-09-13 22:00:53'),
(8, 52, 37, 37, 13, 13, '4553', '4553', '1152.00', '2019-09-14', 52, '3.150000', '13.00', '1', '1', '4553', '4553', '1252.00', '2019-09-14', 52, '3.150000', '13.00', '1', '1', 'CREDITO ACTUALIZADO', '2019-09-13 22:01:30'),
(9, 57, 44, 44, 13, 13, 'pescado', 'ki00045f', '12200.00', '2019-09-12', 4, '3.150000', '11.00', '1', '1', 'sm0000d', 'ki00045f', '12200.00', '2019-09-12', 4, '3.150000', '11.00', '1', '1', 'CREDITO ACTUALIZADO', '2019-09-13 22:32:10');

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
  `saldopendiente` decimal(12,2) NOT NULL,
  `monto` decimal(7,2) NOT NULL,
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
(147, 13, 49, 0, '2015-06-25', '2019-09-01 00:00:00', '1553.33', '158.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(148, 13, 49, 0, '2015-07-25', '2019-09-01 00:00:00', '1416.66', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(149, 13, 49, 0, '2015-08-25', '2019-09-01 00:00:00', '1274.99', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(150, 13, 49, 0, '2015-09-25', '2019-09-01 00:00:00', '1133.32', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(151, 13, 49, 0, '2015-10-25', '2019-09-01 00:00:00', '991.65', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(152, 13, 49, 0, '2015-11-25', '2019-09-01 00:00:00', '849.98', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(153, 13, 49, 0, '2015-12-25', '2019-09-01 00:00:00', '708.31', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(154, 13, 49, 0, '2016-01-25', '2019-09-01 00:00:00', '566.64', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(155, 13, 49, 0, '2016-02-25', '2019-09-01 00:00:00', '424.97', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(156, 13, 49, 0, '2016-03-25', '2019-09-01 00:00:00', '283.30', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(157, 13, 49, 0, '2016-04-25', '2019-09-01 00:00:00', '141.63', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(158, 13, 49, 0, '2016-05-25', '2019-09-01 00:00:00', '0.00', '157.25', '0.00', NULL, '0', '2019-09-02 06:48:36', '2019-09-02 06:48:36'),
(159, 13, 50, 0, '2015-06-25', '2019-09-02 00:00:00', '1558.33', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(160, 13, 50, 0, '2015-07-25', '2019-09-02 00:00:00', '1416.66', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(161, 13, 50, 0, '2015-08-25', '2019-09-02 00:00:00', '1274.99', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(162, 13, 50, 0, '2015-09-25', '2019-09-02 00:00:00', '1133.32', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(163, 13, 50, 0, '2015-10-25', '2019-09-02 00:00:00', '991.65', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(164, 13, 50, 0, '2015-11-25', '2019-09-02 00:00:00', '849.98', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(165, 13, 50, 0, '2015-12-25', '2019-09-02 00:00:00', '708.31', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(166, 13, 50, 0, '2016-01-25', '2019-09-02 00:00:00', '566.64', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(167, 13, 50, 0, '2016-02-25', '2019-09-02 00:00:00', '424.97', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(168, 13, 50, 0, '2016-03-25', '2019-09-02 00:00:00', '283.30', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(169, 13, 50, 0, '2016-04-25', '2019-09-02 00:00:00', '141.63', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(170, 13, 50, 0, '2016-05-25', '2019-09-02 00:00:00', '0.00', '157.25', '0.00', NULL, '1', '2019-09-03 08:37:40', '2019-09-03 08:37:40'),
(171, 13, 51, 0, '2015-06-25', '2019-09-02 00:00:00', '1558.33', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(172, 13, 51, 0, '2015-07-25', '2019-09-02 00:00:00', '1416.66', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(173, 13, 51, 0, '2015-08-25', '2019-09-02 00:00:00', '1274.99', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(174, 13, 51, 0, '2015-09-25', '2019-09-02 00:00:00', '1133.32', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(175, 13, 51, 0, '2015-10-25', '2019-09-02 00:00:00', '991.65', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(176, 13, 51, 0, '2015-11-25', '2019-09-02 00:00:00', '849.98', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(177, 13, 51, 0, '2015-12-25', '2019-09-02 00:00:00', '708.31', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(178, 13, 51, 0, '2016-01-25', '2019-09-02 00:00:00', '566.64', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(179, 13, 51, 0, '2016-02-25', '2019-09-02 00:00:00', '424.97', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(180, 13, 51, 0, '2016-03-25', '2019-09-02 00:00:00', '283.30', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(181, 13, 51, 0, '2016-04-25', '2019-09-02 00:00:00', '141.63', '157.25', '0.00', NULL, '0', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(182, 13, 51, 0, '2016-05-25', '2019-09-02 00:00:00', '0.00', '157.25', '0.00', NULL, '1', '2019-09-03 08:47:33', '2019-09-03 08:47:33'),
(183, 13, 52, 1, '2019-10-14', '2019-09-09 00:00:00', '900.00', '339.00', '0.00', NULL, '0', '2019-09-09 21:53:03', '2019-09-09 21:53:03'),
(184, 13, 52, 2, '2019-11-14', '2019-09-09 00:00:00', '600.00', '339.00', '0.00', NULL, '0', '2019-09-09 21:53:03', '2019-09-09 21:53:03'),
(185, 13, 52, 3, '2019-12-14', '2019-09-09 00:00:00', '300.00', '339.00', '0.00', NULL, '0', '2019-09-09 21:53:03', '2019-09-09 21:53:03'),
(186, 13, 52, 4, '2020-01-14', '2019-09-09 00:00:00', '0.00', '339.00', '0.00', NULL, '0', '2019-09-09 21:53:03', '2019-09-09 21:53:03'),
(187, 13, 53, 1, '2019-10-11', '2019-09-11 00:00:00', '1350.00', '499.50', '0.00', NULL, '0', '2019-09-11 22:24:20', '2019-09-11 22:24:20'),
(188, 13, 53, 2, '2019-11-11', '2019-09-11 00:00:00', '900.00', '499.50', '0.00', NULL, '0', '2019-09-11 22:24:20', '2019-09-11 22:24:20'),
(189, 13, 53, 3, '2019-12-11', '2019-09-11 00:00:00', '450.00', '499.50', '0.00', NULL, '0', '2019-09-11 22:24:20', '2019-09-11 22:24:20'),
(190, 13, 53, 4, '2020-01-11', '2019-09-11 00:00:00', '0.00', '499.50', '0.00', NULL, '0', '2019-09-11 22:24:20', '2019-09-11 22:24:20'),
(191, 13, 54, 1, '2019-10-11', '2019-09-11 00:00:00', '1558.33', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(192, 13, 54, 2, '2019-11-11', '2019-09-11 00:00:00', '1416.66', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(193, 13, 54, 3, '2019-12-11', '2019-09-11 00:00:00', '1274.99', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(194, 13, 54, 4, '2020-01-11', '2019-09-11 00:00:00', '1133.32', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(195, 13, 54, 5, '2020-02-11', '2019-09-11 00:00:00', '991.65', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(196, 13, 54, 6, '2020-03-11', '2019-09-11 00:00:00', '849.98', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(197, 13, 54, 7, '2020-04-11', '2019-09-11 00:00:00', '708.31', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(198, 13, 54, 8, '2020-05-11', '2019-09-11 00:00:00', '566.64', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(199, 13, 54, 9, '2020-06-11', '2019-09-11 00:00:00', '424.97', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(200, 13, 54, 10, '2020-07-11', '2019-09-11 00:00:00', '283.30', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(201, 13, 54, 11, '2020-08-11', '2019-09-11 00:00:00', '141.63', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(202, 13, 54, 12, '2020-09-11', '2019-09-11 00:00:00', '0.00', '157.25', '0.00', NULL, '0', '2019-09-12 02:49:14', '2019-09-12 02:49:14'),
(203, 13, 55, 1, '2019-10-11', '2019-09-11 00:00:00', '1558.33', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(204, 13, 55, 2, '2019-11-11', '2019-09-11 00:00:00', '1416.66', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(205, 13, 55, 3, '2019-12-11', '2019-09-11 00:00:00', '1274.99', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(206, 13, 55, 4, '2020-01-11', '2019-09-11 00:00:00', '1133.32', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(207, 13, 55, 5, '2020-02-11', '2019-09-11 00:00:00', '991.65', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(208, 13, 55, 6, '2020-03-11', '2019-09-11 00:00:00', '849.98', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(209, 13, 55, 7, '2020-04-11', '2019-09-11 00:00:00', '708.31', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(210, 13, 55, 8, '2020-05-11', '2019-09-11 00:00:00', '566.64', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(211, 13, 55, 9, '2020-06-11', '2019-09-11 00:00:00', '424.97', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(212, 13, 55, 10, '2020-07-11', '2019-09-11 00:00:00', '283.30', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(213, 13, 55, 11, '2020-08-11', '2019-09-11 00:00:00', '141.63', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(214, 13, 55, 12, '2020-09-11', '2019-09-11 00:00:00', '0.00', '157.25', '0.00', NULL, '0', '2019-09-12 03:21:15', '2019-09-12 03:21:15'),
(215, 13, 56, 1, '2019-12-11', '2019-09-11 00:00:00', '900.00', '333.00', '0.00', NULL, '0', '2019-09-12 04:53:40', '2019-09-12 04:53:40'),
(216, 13, 56, 2, '2020-03-11', '2019-09-11 00:00:00', '600.00', '333.00', '0.00', NULL, '0', '2019-09-12 04:53:40', '2019-09-12 04:53:40'),
(217, 13, 56, 3, '2020-06-11', '2019-09-11 00:00:00', '300.00', '333.00', '0.00', NULL, '0', '2019-09-12 04:53:40', '2019-09-12 04:53:40'),
(218, 13, 56, 4, '2020-09-11', '2019-09-11 00:00:00', '0.00', '333.00', '0.00', NULL, '0', '2019-09-12 04:53:40', '2019-09-12 04:53:40'),
(219, 13, 57, 1, '2019-10-12', '2019-09-12 00:00:00', '900.00', '333.00', '0.00', NULL, '0', '2019-09-13 01:31:17', '2019-09-13 01:31:17'),
(220, 13, 57, 2, '2019-11-12', '2019-09-12 00:00:00', '600.00', '333.00', '0.00', NULL, '0', '2019-09-13 01:31:17', '2019-09-13 01:31:17'),
(221, 13, 57, 3, '2019-12-12', '2019-09-12 00:00:00', '300.00', '333.00', '0.00', NULL, '0', '2019-09-13 01:31:17', '2019-09-13 01:31:17'),
(222, 13, 57, 4, '2020-01-12', '2019-09-12 00:00:00', '0.00', '333.00', '0.00', NULL, '0', '2019-09-13 01:31:17', '2019-09-13 01:31:17');

--
-- Disparadores `cuotas`
--
DELIMITER $$
CREATE TRIGGER `actualizarcuota` AFTER UPDATE ON `cuotas` FOR EACH ROW INSERT INTO
cuotas_bitacora(idcuota,idusuario,idusuario_n,idcredito,numerocuota,numerocuota_n,fechapago,fechapago_n,saldopendiente,saldopendiente_n,monto,monto_n,otroscostos,otroscostos_n,descripcion,descripcion_n,estado,estado_n)
VALUES(old.id,old.idusuario,NEW.idusuario,old.idcredito,old.numerocuota,NEW.numerocuota,old.fechapago,NEW.fechapago,old.saldopendiente,NEW.saldopendiente,old.monto,NEW.monto,old.otroscostos,NEW.otroscostos,old.descripcion,NEW.descripcion,old.estado,NEW.estado)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuotas_bitacora`
--

CREATE TABLE `cuotas_bitacora` (
  `id` int(10) UNSIGNED NOT NULL,
  `idcuota` int(10) NOT NULL,
  `idusuario` int(10) NOT NULL,
  `idcredito` int(10) NOT NULL,
  `numerocuota` int(2) NOT NULL,
  `fechapago` date NOT NULL,
  `saldopendiente` decimal(12,2) NOT NULL,
  `monto` decimal(7,2) NOT NULL,
  `otroscostos` decimal(7,2) DEFAULT NULL,
  `descripcion` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0 sin pagar / 1 pagada',
  `idusuario_n` int(10) NOT NULL,
  `numerocuota_n` int(2) NOT NULL,
  `fechapago_n` date NOT NULL,
  `saldopendiente_n` decimal(12,2) NOT NULL,
  `monto_n` decimal(7,2) NOT NULL,
  `otroscostos_n` decimal(7,2) DEFAULT NULL,
  `descripcion_n` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_n` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0 sin pagar / 1 pagada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuotas_bitacora`
--

INSERT INTO `cuotas_bitacora` (`id`, `idcuota`, `idusuario`, `idcredito`, `numerocuota`, `fechapago`, `saldopendiente`, `monto`, `otroscostos`, `descripcion`, `estado`, `idusuario_n`, `numerocuota_n`, `fechapago_n`, `saldopendiente_n`, `monto_n`, `otroscostos_n`, `descripcion_n`, `estado_n`) VALUES
(1, 147, 13, 49, 0, '2015-06-25', '1558.33', '158.25', '0.00', NULL, '0', 13, 0, '2015-06-25', '1553.33', '158.25', '0.00', NULL, '0');

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
(12, '12341234', 'SAMY', 'BRAVO', 'SANCHEZ', NULL, NULL, NULL, NULL, '1', '2019-09-02 06:29:29', '2019-09-02 06:29:29'),
(13, '70212063', 'JOSE LUIS f', 'RAMIREZ', 'QUIROZ', '1993-03-01', 'Baños del Inca', '964923450', 'joseramirezq.info@gmail.com', '1', '2019-09-02 06:34:56', '2019-09-12 04:52:04'),
(14, '27904107', 'JUAN JOSE', 'CALDERON', 'BURGOS', NULL, 'Caserío Rancho Grande', NULL, NULL, '1', '2019-09-02 06:36:52', '2019-09-02 06:40:02'),
(15, '27902918', 'ESTANISLAO', 'CALDERON', 'CALDERON', NULL, NULL, NULL, NULL, '1', NULL, NULL),
(16, '27915813', 'JORGE ALBERTO', 'PAREDES', 'HONORIO', NULL, NULL, NULL, NULL, '1', NULL, NULL),
(17, '27930080', 'JOSE SANTOS', 'VEGA', 'IZQUIERDO', NULL, NULL, NULL, NULL, '1', NULL, NULL),
(18, '7021545', 'John', 'Urteaga', 'Arias', NULL, 'Jr. Leoncio Prado', '946863579', 'john@correo.com', '1', '2019-09-03 18:05:20', '2019-09-03 18:05:20'),
(37, '70121gh', 'asd', 'asd', 'asd', '2019-09-07', 'asd', 'asd', 'asd', '1', '2019-09-09 21:45:38', '2019-09-09 21:47:09'),
(40, '8888', 'kkkkkk', 'kkkkkkkkkkkkkkkkkkkk', 'kkkkkkk', NULL, NULL, NULL, NULL, '1', '2019-09-12 03:01:18', '2019-09-12 03:01:18'),
(41, '99999vvv', 'asd', 'asd', 'asd', NULL, NULL, NULL, NULL, '1', '2019-09-12 03:04:07', '2019-09-12 04:51:50'),
(42, '7878888', 'asdasd', 'sdfsd', 'asfsdf', '1993-03-01', 'asdfds', '1', 'sdfsdf@gmail.com', '1', '2019-09-12 04:52:42', '2019-09-13 22:27:04'),
(43, '78', 'sxfsd', 'sdfsd', 'sdfsd', NULL, NULL, NULL, NULL, '1', '2019-09-12 04:53:10', '2019-09-12 04:53:10'),
(44, '222', 'GHJ', 'GHJ', 'GHJ', NULL, NULL, NULL, NULL, '1', '2019-09-13 01:30:40', '2019-09-13 01:30:40'),
(45, '56', '65', '565', 'SAD', NULL, NULL, NULL, NULL, '1', '2019-09-13 01:51:49', '2019-09-13 01:51:49'),
(46, '55555', 'sad', 'asd', 'asd', NULL, NULL, NULL, NULL, '1', '2019-09-13 04:22:30', '2019-09-13 04:22:30'),
(48, '785656jjj', '45', 'hjk', 'hjk', NULL, NULL, NULL, NULL, '1', '2019-09-13 20:38:42', '2019-09-13 20:39:16'),
(49, '822228', 'PEPE', 'DIAZ', 'CHIL', '2019-09-13', 'JR. Alfonso Ugarte', '70212065', 'asl@gmail.com', '1', '2019-09-13 20:41:01', '2019-09-13 21:32:54'),
(51, '702120633P', 'JOSE LUIS', 'RAMIREZ', 'QUIROZS', NULL, '45821', '7620', 'GMAILCOM', '1', '2019-09-13 21:28:46', '2019-09-13 21:31:39'),
(55, '111111', 'asdasdasd', 'asdasdasdasd', 'asdasdasd', '1993-03-01', NULL, NULL, NULL, '1', '2019-09-13 22:27:32', '2019-09-13 22:27:32');

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
(42, 'a', '$2y$10$Qn5HqFFASOpEtOt8NkUxDePH9Gwng7SUNnYxasced0YrRjaS/XpVm', 1, 1, NULL),
(13, 'admin', '$2y$10$FtoFi6GjL37k4qEvEGsFC.JsSG/cYfDMuQ8SinE/Sb6A/YwQE5hHe', 1, 1, NULL),
(12, 'BRAVO45', '$2y$10$ehN6JcxNYcYI1uuv/DkYEObpenjLAun64qG3Lj5GnPReMH8HlOZfG', 1, 1, NULL),
(11, 'COTRINA37', '$2y$10$uB5zvGMgT.GUPiXk5VA94uBlXxFZ.89Y/wjsFCHtSV0nJx75ugoNm', 1, 1, NULL),
(10, 'SONIA45', '$2y$10$tfTcJ1mLAy0mkDPgawSzDO.s4WwP9mXtKaOG.0jQrqxbODTG3XwAS', 1, 1, NULL),
(55, 'yuyu', '$2y$10$Udq3uTKf5sapD/ixL0n/CufD1Xfi45Ad3TOsXGPk4jkyAVh/SMtKK', 1, 3, NULL);

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
  ADD KEY `creditos_idcliente_foreign` (`idcliente`),
  ADD KEY `creditos_idusuario_foreign` (`idusuario`);

--
-- Indices de la tabla `creditos_bitacora`
--
ALTER TABLE `creditos_bitacora`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cuotas_idusuario_foreign` (`idusuario`),
  ADD KEY `cuotas_idcredito_foreign` (`idcredito`);

--
-- Indices de la tabla `cuotas_bitacora`
--
ALTER TABLE `cuotas_bitacora`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `creditos_bitacora`
--
ALTER TABLE `creditos_bitacora`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=223;

--
-- AUTO_INCREMENT de la tabla `cuotas_bitacora`
--
ALTER TABLE `cuotas_bitacora`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

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
