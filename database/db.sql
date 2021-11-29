SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_links`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aseguradora`
--

CREATE TABLE `aseguradora` (
  `IDAseguradora` int(11) NOT NULL,
  `nombreAseguradora` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aseguradorapaciente`
--

CREATE TABLE `aseguradorapaciente` (
  `IDAsPac` int(11) NOT NULL,
  `IDAseguradora` int(11) NOT NULL,
  `IDPaciente` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `circulo`
--

CREATE TABLE `circulo` (
  `IDCirculo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `edad` int(11) NOT NULL,
  `apellidoMaterno` varchar(50) NOT NULL,
  `apellidoPaterno` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `circulo`
--

INSERT INTO `circulo` (`IDCirculo`, `nombre`, `edad`, `apellidoMaterno`, `apellidoPaterno`) VALUES
(4, 'Pedro', 50, 'Gallardo', 'Gonzalez'),
(5, 'Pedro', 50, 'Gallardo', 'Gonzalez'),
(6, 'Alejandro', 23, 'Romay', 'Gonzalez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `circulopaciente`
--

CREATE TABLE `circulopaciente` (
  `IDCircPac` int(11) NOT NULL,
  `IDCirculo` int(11) NOT NULL,
  `IDPaciente` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `circulopaciente`
--

INSERT INTO `circulopaciente` (`IDCircPac`, `IDCirculo`, `IDPaciente`, `created_at`) VALUES
(1, 6, 3, '2021-11-29 16:53:52'),
(3, 4, 3, '2021-11-29 16:54:13'),
(5, 5, 3, '2021-11-29 16:55:02'),
(6, 5, 3, '2021-11-29 16:55:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `IDCita` int(11) NOT NULL,
  `IDPaciente` int(11) NOT NULL,
  `fecha` varchar(50) NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`IDCita`, `IDPaciente`, `fecha`, `hora`, `created_at`) VALUES
(15, 3, '2022-03-07', '17:24:00', '2021-11-25 16:19:30'),
(16, 3, '2021-12-11', '03:24:00', '2021-11-25 19:16:56'),
(17, 3, '2021-11-06', '03:24:00', '2021-11-25 21:11:33'),
(18, 3, '2021-11-06', '03:24:00', '2021-11-25 21:12:39'),
(19, 3, '2021-11-06', '03:24:00', '2021-11-25 21:13:40'),
(20, 3, '2021-12-10', '15:25:00', '2021-11-25 21:16:30'),
(21, 3, '2021-11-06', '15:27:00', '2021-11-25 21:21:07'),
(22, 3, '2021-11-06', '03:24:00', '2021-11-25 21:22:11'),
(23, 3, '2021-11-06', '03:24:00', '2021-11-25 21:22:24'),
(24, 3, '2021-11-06', '03:24:00', '2021-11-25 21:22:58'),
(25, 3, '2021-11-06', '03:24:00', '2021-11-25 21:23:27'),
(26, 3, '2021-11-06', '03:24:00', '2021-11-25 21:28:36'),
(27, 3, '2021-11-25', '14:07:00', '2021-11-26 20:05:14'),
(28, 3, '2022-01-29', '13:11:00', '2021-11-28 18:05:18'),
(32, 3, '2021-12-22', '22:40:00', '2021-11-29 12:38:05'),
(33, 3, '2021-12-09', '09:27:00', '2021-11-29 15:26:09'),
(34, 3, '2021-12-10', '21:30:00', '2021-11-29 15:28:11'),
(35, 3, '2021-12-10', '21:30:00', '2021-11-29 15:28:34'),
(36, 3, '2021-11-30', '12:56:00', '2021-11-29 17:59:06'),
(37, 3, '2021-11-02', '02:47:00', '2021-11-29 20:45:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citasdoctores`
--

CREATE TABLE `citasdoctores` (
  `IDCitaDoctor` int(11) NOT NULL,
  `IDCita` int(11) NOT NULL,
  `IDDoctor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `citasdoctores`
--

INSERT INTO `citasdoctores` (`IDCitaDoctor`, `IDCita`, `IDDoctor`) VALUES
(3, 32, 5),
(4, 33, 4),
(5, 35, 4),
(6, 36, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citasservicios`
--

CREATE TABLE `citasservicios` (
  `IDCitSer` int(11) NOT NULL,
  `IDCita` int(11) NOT NULL,
  `IDServicio` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `citasservicios`
--

INSERT INTO `citasservicios` (`IDCitSer`, `IDCita`, `IDServicio`, `created_at`) VALUES
(4, 37, 4, '2021-11-29 20:45:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctores`
--

CREATE TABLE `doctores` (
  `IDDoctor` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `edad` int(11) NOT NULL,
  `apellidoMaterno` varchar(50) NOT NULL,
  `apellidoPaterno` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `doctores`
--

INSERT INTO `doctores` (`IDDoctor`, `nombre`, `edad`, `apellidoMaterno`, `apellidoPaterno`, `created_at`) VALUES
(4, 'ANDRES', 25, 'ARCE', 'ROBLES', '2021-11-29 10:24:48'),
(5, 'MANUEL', 21, 'CEBALLOS', 'KANAHUATI', '2021-11-29 10:24:48'),
(6, 'ANDREA', 22, 'HINOJOSA', 'ALBORNOZ', '2021-11-29 13:11:46'),
(8, 'EDUARDO', 38, 'LOPEZ', 'LOPEZ', '2021-11-29 17:48:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `IDEspecialidad` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`IDEspecialidad`, `nombre`, `created_at`) VALUES
(4, 'PSICOLOGÍA', '2021-11-29 11:26:31'),
(6, 'NUTRICIÓN', '2021-11-29 11:27:10'),
(8, 'PRUEBA GENÓMICA', '2021-11-29 13:12:46'),
(10, 'ALTA ESPECIALIDAD', '2021-11-29 13:13:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidadesdoctores`
--

CREATE TABLE `especialidadesdoctores` (
  `IDEspDoctor` int(11) NOT NULL,
  `IDDoctor` int(11) NOT NULL,
  `IDEspecialidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `especialidadesdoctores`
--

INSERT INTO `especialidadesdoctores` (`IDEspDoctor`, `IDDoctor`, `IDEspecialidad`) VALUES
(1, 4, 4),
(3, 5, 6),
(5, 6, 10),
(7, 8, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentos`
--

CREATE TABLE `medicamentos` (
  `IDMedicamento` int(11) NOT NULL,
  `nombreMedicamento` varchar(100) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `medicamentos`
--

INSERT INTO `medicamentos` (`IDMedicamento`, `nombreMedicamento`, `fecha`, `created_at`) VALUES
(3, 'PARACETAMOL', NULL, '2021-11-24 02:58:23'),
(4, 'RANITIDINA', NULL, '2021-11-24 03:19:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentospacientes`
--

CREATE TABLE `medicamentospacientes` (
  `IDMedPac` int(11) NOT NULL,
  `IDPaciente` int(11) NOT NULL,
  `IDMedicamento` int(11) NOT NULL,
  `indicaciones` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `medicamentospacientes`
--

INSERT INTO `medicamentospacientes` (`IDMedPac`, `IDPaciente`, `IDMedicamento`, `indicaciones`, `created_at`) VALUES
(1, 3, 4, '1 cada 8 horas', '2021-11-29 11:58:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentostratamiento`
--

CREATE TABLE `medicamentostratamiento` (
  `IDMedTrat` int(11) NOT NULL,
  `IDTratamiento` int(11) NOT NULL,
  `IDMedicamento` int(11) NOT NULL,
  `indicaciones` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `medicamentostratamiento`
--

INSERT INTO `medicamentostratamiento` (`IDMedTrat`, `IDTratamiento`, `IDMedicamento`, `indicaciones`, `created_at`) VALUES
(1, 4, 3, '2 DE 500MG AL DÍA', '2021-11-29 13:15:39'),
(2, 4, 4, '2 DE 200MG AL DÍA', '2021-11-29 13:15:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moleculartest`
--

CREATE TABLE `moleculartest` (
  `IDMolecularTest` int(11) NOT NULL,
  `IDPaciente` int(11) DEFAULT NULL,
  `resultados` varchar(250) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `IDPaciente` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `edad` int(11) NOT NULL,
  `apellidoMaterno` varchar(50) NOT NULL,
  `apellidoPaterno` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`IDPaciente`, `nombre`, `edad`, `apellidoMaterno`, `apellidoPaterno`) VALUES
(3, 'Andres', 27, 'Arce', 'Robles'),
(4, 'José', 30, 'Guerrero', 'Aguilar'),
(8, 'Alejandro', 75, 'Romay', 'Arce'),
(9, 'Pedro', 50, 'Gallardo', 'Gonzalez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `IDServicio` int(11) NOT NULL,
  `nombre_servicio` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`IDServicio`, `nombre_servicio`, `created_at`) VALUES
(4, 'ENFERMERÍA', '2021-11-29 19:18:53'),
(5, 'TRATAMIENTO DOLOR CRÓNICO', '2021-11-29 19:19:17'),
(6, 'TRATAMIENTO PALEATIVO', '2021-11-29 19:19:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('nEapI1XOltbofaxJO11p7NmmMamSEoAn', 1638305841, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{},\"passport\":{\"user\":3}}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamiento`
--

CREATE TABLE `tratamiento` (
  `IDTratamiento` int(11) NOT NULL,
  `indicaciones` varchar(500) NOT NULL,
  `IDPaciente` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tratamiento`
--

INSERT INTO `tratamiento` (`IDTratamiento`, `indicaciones`, `IDPaciente`, `created_at`) VALUES
(4, 'NUEVO TRATAMIENTO', 3, '2021-11-29 13:10:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamientodoctores`
--

CREATE TABLE `tratamientodoctores` (
  `IDTratDr` int(11) NOT NULL,
  `IDTratamiento` int(11) NOT NULL,
  `IDDoctor` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tratamientodoctores`
--

INSERT INTO `tratamientodoctores` (`IDTratDr`, `IDTratamiento`, `IDDoctor`, `created_at`) VALUES
(1, 4, 6, '2021-11-29 13:14:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(16) NOT NULL,
  `password` varchar(60) NOT NULL,
  `IDPaciente` int(11) DEFAULT NULL,
  `IDDoctor` int(11) DEFAULT NULL,
  `IDCirculo` int(11) DEFAULT NULL,
  `IDAseguradora` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `IDPaciente`, `IDDoctor`, `IDCirculo`, `IDAseguradora`) VALUES
(3, 'andyrobot', '$2a$10$PI2i4fZvKEhHneqiHzlAI.OIoQLVEHBPOA1oplIzESwK7pQCI6NXS', 3, NULL, NULL, NULL),
(10, 'jaguilar', '$2a$10$M5txS02xswXl3BP.8ionf.15eeNFCEcaQ3B/ks1trDuOBUumor8lG', NULL, 4, NULL, NULL),
(11, 'aromay', '$2a$10$g.jxfVlzsat29QOPm3OkHOC9BAIurfRmvU5tPHXlwUAyrcJ661i8G', 8, NULL, NULL, NULL),
(12, 'pgonzalez', '$2a$10$HhFT8qZh00WGtRpKip/lzO8ZVU0FsKOsiWG.H90VPnedgzfCNUfjC', NULL, NULL, 4, NULL),
(15, 'john', '$2a$10$nCpRSnM5xTNG7yRBw9z2RO767NVYmOHDuhPL8p4SP42DiKAb.dxqO', NULL, NULL, 6, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aseguradora`
--
ALTER TABLE `aseguradora`
  ADD PRIMARY KEY (`IDAseguradora`);

--
-- Indices de la tabla `aseguradorapaciente`
--
ALTER TABLE `aseguradorapaciente`
  ADD PRIMARY KEY (`IDAsPac`),
  ADD KEY `fk_asegAP` (`IDAseguradora`),
  ADD KEY `fk_pacAP` (`IDPaciente`);

--
-- Indices de la tabla `circulo`
--
ALTER TABLE `circulo`
  ADD PRIMARY KEY (`IDCirculo`);

--
-- Indices de la tabla `circulopaciente`
--
ALTER TABLE `circulopaciente`
  ADD PRIMARY KEY (`IDCircPac`),
  ADD KEY `fk_circCP` (`IDCirculo`),
  ADD KEY `fk_pacCP` (`IDPaciente`);

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`IDCita`),
  ADD KEY `fk_citapaciente` (`IDPaciente`);

--
-- Indices de la tabla `citasdoctores`
--
ALTER TABLE `citasdoctores`
  ADD PRIMARY KEY (`IDCitaDoctor`),
  ADD KEY `fk_citaCD` (`IDCita`),
  ADD KEY `fk_drCD` (`IDDoctor`);

--
-- Indices de la tabla `citasservicios`
--
ALTER TABLE `citasservicios`
  ADD PRIMARY KEY (`IDCitSer`),
  ADD KEY `fk_citCS` (`IDCita`),
  ADD KEY `fk_serCS` (`IDServicio`);

--
-- Indices de la tabla `doctores`
--
ALTER TABLE `doctores`
  ADD PRIMARY KEY (`IDDoctor`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`IDEspecialidad`);

--
-- Indices de la tabla `especialidadesdoctores`
--
ALTER TABLE `especialidadesdoctores`
  ADD PRIMARY KEY (`IDEspDoctor`),
  ADD KEY `fk_espED` (`IDEspecialidad`),
  ADD KEY `fk_drED` (`IDDoctor`);

--
-- Indices de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD PRIMARY KEY (`IDMedicamento`);

--
-- Indices de la tabla `medicamentospacientes`
--
ALTER TABLE `medicamentospacientes`
  ADD PRIMARY KEY (`IDMedPac`),
  ADD KEY `fk_medMP` (`IDMedicamento`),
  ADD KEY `fk_pacMP` (`IDPaciente`);

--
-- Indices de la tabla `medicamentostratamiento`
--
ALTER TABLE `medicamentostratamiento`
  ADD PRIMARY KEY (`IDMedTrat`),
  ADD KEY `fk_medMT` (`IDMedicamento`),
  ADD KEY `fk_tratMT` (`IDTratamiento`);

--
-- Indices de la tabla `moleculartest`
--
ALTER TABLE `moleculartest`
  ADD PRIMARY KEY (`IDMolecularTest`),
  ADD KEY `fk_molTestPac` (`IDPaciente`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`IDPaciente`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`IDServicio`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indices de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD PRIMARY KEY (`IDTratamiento`),
  ADD KEY `fk_tratPac` (`IDPaciente`);

--
-- Indices de la tabla `tratamientodoctores`
--
ALTER TABLE `tratamientodoctores`
  ADD PRIMARY KEY (`IDTratDr`),
  ADD KEY `fk_tratTD` (`IDTratamiento`),
  ADD KEY `fk_drTD` (`IDDoctor`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aseguradora`
--
ALTER TABLE `aseguradora`
  MODIFY `IDAseguradora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `aseguradorapaciente`
--
ALTER TABLE `aseguradorapaciente`
  MODIFY `IDAsPac` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `circulo`
--
ALTER TABLE `circulo`
  MODIFY `IDCirculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `circulopaciente`
--
ALTER TABLE `circulopaciente`
  MODIFY `IDCircPac` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `citas`
--
ALTER TABLE `citas`
  MODIFY `IDCita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `citasdoctores`
--
ALTER TABLE `citasdoctores`
  MODIFY `IDCitaDoctor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `citasservicios`
--
ALTER TABLE `citasservicios`
  MODIFY `IDCitSer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `doctores`
--
ALTER TABLE `doctores`
  MODIFY `IDDoctor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `IDEspecialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `especialidadesdoctores`
--
ALTER TABLE `especialidadesdoctores`
  MODIFY `IDEspDoctor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  MODIFY `IDMedicamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `medicamentospacientes`
--
ALTER TABLE `medicamentospacientes`
  MODIFY `IDMedPac` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `medicamentostratamiento`
--
ALTER TABLE `medicamentostratamiento`
  MODIFY `IDMedTrat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `moleculartest`
--
ALTER TABLE `moleculartest`
  MODIFY `IDMolecularTest` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `IDPaciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `IDServicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  MODIFY `IDTratamiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tratamientodoctores`
--
ALTER TABLE `tratamientodoctores`
  MODIFY `IDTratDr` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aseguradorapaciente`
--
ALTER TABLE `aseguradorapaciente`
  ADD CONSTRAINT `fk_asegAP` FOREIGN KEY (`IDAseguradora`) REFERENCES `aseguradora` (`IDAseguradora`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pacAP` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente` (`IDPaciente`);

--
-- Filtros para la tabla `circulopaciente`
--
ALTER TABLE `circulopaciente`
  ADD CONSTRAINT `fk_circCP` FOREIGN KEY (`IDCirculo`) REFERENCES `circulo` (`IDCirculo`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pacCP` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente` (`IDPaciente`);

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `fk_citapaciente` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente` (`IDPaciente`);

--
-- Filtros para la tabla `citasdoctores`
--
ALTER TABLE `citasdoctores`
  ADD CONSTRAINT `fk_citaCD` FOREIGN KEY (`IDCita`) REFERENCES `citas` (`IDCita`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_drCD` FOREIGN KEY (`IDDoctor`) REFERENCES `doctores` (`IDDoctor`) ON DELETE CASCADE;

--
-- Filtros para la tabla `citasservicios`
--
ALTER TABLE `citasservicios`
  ADD CONSTRAINT `fk_citCS` FOREIGN KEY (`IDCita`) REFERENCES `citas` (`IDCita`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_serCS` FOREIGN KEY (`IDServicio`) REFERENCES `servicios` (`IDServicio`);

--
-- Filtros para la tabla `especialidadesdoctores`
--
ALTER TABLE `especialidadesdoctores`
  ADD CONSTRAINT `fk_drED` FOREIGN KEY (`IDDoctor`) REFERENCES `doctores` (`IDDoctor`),
  ADD CONSTRAINT `fk_espED` FOREIGN KEY (`IDEspecialidad`) REFERENCES `especialidades` (`IDEspecialidad`) ON DELETE CASCADE;

--
-- Filtros para la tabla `medicamentospacientes`
--
ALTER TABLE `medicamentospacientes`
  ADD CONSTRAINT `fk_medMP` FOREIGN KEY (`IDMedicamento`) REFERENCES `medicamentos` (`IDMedicamento`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pacMP` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente` (`IDPaciente`) ON DELETE CASCADE;

--
-- Filtros para la tabla `medicamentostratamiento`
--
ALTER TABLE `medicamentostratamiento`
  ADD CONSTRAINT `fk_medMT` FOREIGN KEY (`IDMedicamento`) REFERENCES `medicamentos` (`IDMedicamento`),
  ADD CONSTRAINT `fk_tratMT` FOREIGN KEY (`IDTratamiento`) REFERENCES `tratamiento` (`IDTratamiento`);

--
-- Filtros para la tabla `moleculartest`
--
ALTER TABLE `moleculartest`
  ADD CONSTRAINT `fk_molTestPac` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente` (`IDPaciente`);

--
-- Filtros para la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD CONSTRAINT `fk_tratPac` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente` (`IDPaciente`);

--
-- Filtros para la tabla `tratamientodoctores`
--
ALTER TABLE `tratamientodoctores`
  ADD CONSTRAINT `fk_drTD` FOREIGN KEY (`IDDoctor`) REFERENCES `doctores` (`IDDoctor`),
  ADD CONSTRAINT `fk_tratTD` FOREIGN KEY (`IDTratamiento`) REFERENCES `tratamiento` (`IDTratamiento`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
