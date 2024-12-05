-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-12-2024 a las 02:17:37
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `medical`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eps`
--

CREATE TABLE `eps` (
  `id_eps` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `eps`
--

INSERT INTO `eps` (`id_eps`, `nombre`) VALUES
(1, 'Compensar'),
(2, 'Sura'),
(3, 'Sanitas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_inventario` int(11) NOT NULL,
  `id_sede` int(11) DEFAULT NULL,
  `id_medicamentos` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_inventario`, `id_sede`, `id_medicamentos`, `cantidad`) VALUES
(1, 1, 1, 100),
(2, 1, 2, 50),
(3, 2, 1, 30),
(4, 3, 3, 20),
(5, 2, 2, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ips`
--

CREATE TABLE `ips` (
  `id_ips` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `id_eps` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ips`
--

INSERT INTO `ips` (`id_ips`, `nombre`, `id_eps`) VALUES
(1, 'Audifarma', 1),
(2, 'Evedisa', 1),
(3, 'Cruz Verde', 1),
(4, 'Audifarma', 2),
(5, 'Evedisa', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentos`
--

CREATE TABLE `medicamentos` (
  `id_medicamentos` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medicamentos`
--

INSERT INTO `medicamentos` (`id_medicamentos`, `nombre`) VALUES
(1, 'Vimpat'),
(2, 'Klaricid'),
(3, 'Depakene'),
(4, 'Nexium');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedes`
--

CREATE TABLE `sedes` (
  `id_sede` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `id_ips` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sedes`
--

INSERT INTO `sedes` (`id_sede`, `nombre`, `id_ips`) VALUES
(1, 'Sede Dirección 1', 1),
(2, 'Sede Dirección 2', 1),
(3, 'Sede Dirección 3', 2),
(4, 'Sede Dirección 4', 2),
(5, 'Sede Dirección 5', 3),
(6, 'Sede Dirección 6', 3),
(7, 'Sede Dirección 7', 4),
(8, 'Sede Dirección 8', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuarios` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `contrasena` varchar(15) DEFAULT NULL,
  `id_eps` int(11) DEFAULT NULL,
  `id_ips` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuarios`, `nombre`, `apellido`, `telefono`, `contrasena`, `id_eps`, `id_ips`) VALUES
(1, 'Juan', 'Pérez', '457', '123', 1, 1),
(2, 'Maria', 'Bejarano', '987654321', '234', 2, 3),
(3, 'Carlos', 'Andrade', '9876', 'pass345', 2, 1),
(4, 'Pedro', 'Jimenez', '34567', 'pass456', 2, 2),
(5, 'Leidy', 'Salinas', '5678', 'pass567', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usu_medicamentos`
--

CREATE TABLE `usu_medicamentos` (
  `id_usu_medicamento` int(11) NOT NULL,
  `id_usuarios` int(11) DEFAULT NULL,
  `id_medicamentos` int(11) DEFAULT NULL,
  `dosificacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usu_medicamentos`
--

INSERT INTO `usu_medicamentos` (`id_usu_medicamento`, `id_usuarios`, `id_medicamentos`, `dosificacion`) VALUES
(1, 1, 1, 30),
(2, 1, 2, 20),
(3, 2, 3, 16),
(4, 2, 4, 15),
(5, 3, 2, 27),
(6, 4, 1, 40),
(7, 4, 2, 0),
(8, 4, 3, 0),
(9, 4, 4, 0),
(10, 5, NULL, 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `eps`
--
ALTER TABLE `eps`
  ADD PRIMARY KEY (`id_eps`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_inventario`),
  ADD KEY `id_sede` (`id_sede`),
  ADD KEY `id_medicamentos` (`id_medicamentos`);

--
-- Indices de la tabla `ips`
--
ALTER TABLE `ips`
  ADD PRIMARY KEY (`id_ips`),
  ADD KEY `id_eps` (`id_eps`);

--
-- Indices de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD PRIMARY KEY (`id_medicamentos`);

--
-- Indices de la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD PRIMARY KEY (`id_sede`),
  ADD KEY `id_ips` (`id_ips`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuarios`),
  ADD KEY `id_eps` (`id_eps`),
  ADD KEY `id_ips` (`id_ips`);

--
-- Indices de la tabla `usu_medicamentos`
--
ALTER TABLE `usu_medicamentos`
  ADD PRIMARY KEY (`id_usu_medicamento`),
  ADD KEY `id_usuarios` (`id_usuarios`),
  ADD KEY `id_medicamentos` (`id_medicamentos`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `eps`
--
ALTER TABLE `eps`
  MODIFY `id_eps` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ips`
--
ALTER TABLE `ips`
  MODIFY `id_ips` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  MODIFY `id_medicamentos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `sedes`
--
ALTER TABLE `sedes`
  MODIFY `id_sede` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuarios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usu_medicamentos`
--
ALTER TABLE `usu_medicamentos`
  MODIFY `id_usu_medicamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id_sede`),
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`id_medicamentos`) REFERENCES `medicamentos` (`id_medicamentos`);

--
-- Filtros para la tabla `ips`
--
ALTER TABLE `ips`
  ADD CONSTRAINT `ips_ibfk_1` FOREIGN KEY (`id_eps`) REFERENCES `eps` (`id_eps`);

--
-- Filtros para la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD CONSTRAINT `sedes_ibfk_1` FOREIGN KEY (`id_ips`) REFERENCES `ips` (`id_ips`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_eps`) REFERENCES `eps` (`id_eps`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_ips`) REFERENCES `ips` (`id_ips`);

--
-- Filtros para la tabla `usu_medicamentos`
--
ALTER TABLE `usu_medicamentos`
  ADD CONSTRAINT `usu_medicamentos_ibfk_1` FOREIGN KEY (`id_usuarios`) REFERENCES `usuarios` (`id_usuarios`),
  ADD CONSTRAINT `usu_medicamentos_ibfk_2` FOREIGN KEY (`id_medicamentos`) REFERENCES `medicamentos` (`id_medicamentos`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
