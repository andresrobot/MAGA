CREATE DATABASE `db_links` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE  db_links;
CREATE TABLE `paciente` (
  `IDPaciente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `edad` int(11) NOT NULL,
  `apellidoMaterno` varchar(150) NOT NULL,
  `apellidoPaterno` varchar(150) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`IDPaciente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `citas` (
  `IDCita` int(11) NOT NULL AUTO_INCREMENT,
  `IDPaciente` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`IDCita`),
  KEY `fk_citapaciente` (`IDPaciente`),
  CONSTRAINT `fk_citapaciente` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente` (`IDPaciente`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) unsigned NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL,
  `password` varchar(60) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `IDPaciente` int(11) DEFAULT NULL,
  `IDDoctor` int(11) DEFAULT NULL,
  `IDCirculo` int(11) DEFAULT NULL,
  `IDAseguradora`int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `medicamentos` (
  `IDMedicamento` int(11) NOT NULL AUTO_INCREMENT,
  `nombreMedicamento` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
   PRIMARY KEY (`IDMedicamento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `medicamentospacientes` (
  `IDMedPac` int(11) NOT NULL AUTO_INCREMENT,
  `IDPaciente` int(11) NOT NULL,
  `IDMedicamento` int(11) NOT NULL,
  `indicaciones` VARCHAR(500),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  KEY `fk_medMP` (`IDMedicamento`),
  KEY `fk_pacMP` (`IDPaciente`),
  CONSTRAINT `fk_medMP` FOREIGN KEY (`IDMedicamento`) REFERENCES `medicamentos` (`IDMedicamento`) ON DELETE CASCADE,
  CONSTRAINT `fk_pacMP` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente` (`IDPaciente`) ON DELETE CASCADE,
  PRIMARY KEY (`IDMedPac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `doctores` (
  `IDDoctor` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `edad` int(11) NOT NULL,
  `apellidoMaterno` varchar(150) NOT NULL,
  `apellidoPaterno` varchar(150) NOT NULL,
  `especialidad`varchar(150) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`IDDoctor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

 CREATE TABLE `especialidades` (
  `IDEspecialidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`IDEspecialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `especialidadesdoctores` (
  `IDEspDoctor` int(11) NOT NULL AUTO_INCREMENT,
  `IDDoctor` int(11) NOT NULL,
  `IDEspecialidad` int(11) NOT NULL,
  KEY `fk_espED` (`IDEspecialidad`),
  KEY `fk_drED` (`IDDoctor`),
  CONSTRAINT `fk_espED` FOREIGN KEY (`IDEspecialidad`) REFERENCES `especialidades` (`IDEspecialidad`) ON DELETE CASCADE,
  CONSTRAINT `fk_drED` FOREIGN KEY (`IDDoctor`) REFERENCES `doctores` (`IDDoctor`),
  PRIMARY KEY(`IDEspDoctor`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `citasdoctores` (
  `IDCitaDoctor` int(11) NOT NULL AUTO_INCREMENT,
  `IDCita` int(11) NOT NULL,
  `IDDoctor` int(11) NOT NULL,
  KEY `fk_citaCD` (`IDCita`),
  KEY `fk_drCD` (`IDDoctor`),
  PRIMARY KEY (`IDCitaDoctor`),
  CONSTRAINT `fk_citaCD` FOREIGN KEY (`IDCita`) REFERENCES `citas` (`IDCita`) ON DELETE CASCADE,
  CONSTRAINT `fk_drCD` FOREIGN KEY (`IDDoctor`) REFERENCES `doctores` (`IDDoctor`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

 CREATE TABLE `molecularTest` (
  `IDMolecularTest` int(11) NOT NULL AUTO_INCREMENT,
  `IDPaciente` int(11),
  `resultados` varchar(250) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  KEY `fk_molTestPac` (`IDPaciente`),
  CONSTRAINT `fk_molTestPac` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente`(`IDPaciente`),
  PRIMARY KEY (`IDMolecularTest`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

 CREATE TABLE `tratamiento` (
  `IDTratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `indicaciones` varchar(500) NOT NULL,
  `IDPaciente` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  KEY `fk_tratPac` (`IDPaciente`),
  CONSTRAINT `fk_tratPac` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente`(`IDPaciente`),
  PRIMARY KEY (`IDTratamiento`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
CREATE TABLE `tratamientodoctores` (
  `IDTratPac` int(11) NOT NULL AUTO_INCREMENT,
  `IDTratamiento` int(11) NOT NULL,
  `IDDoctor` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  KEY `fk_tratTD` (`IDTratamiento`),
  KEY `fk_drTD` (`IDDoctor`),
  CONSTRAINT `fk_tratTD` FOREIGN KEY (`IDTratamiento`) REFERENCES `tratamiento` (`IDTratamiento`) ON DELETE CASCADE,
  CONSTRAINT `fk_drTD` FOREIGN KEY (`IDDoctor`) REFERENCES `doctores` (`IDDoctor`),
  PRIMARY KEY (`IDTratPac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `aseguradora` (
  `IDAseguradora` int(11) NOT NULL AUTO_INCREMENT,
  `nombreAseguradora` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`IDAseguradora`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `aseguradorapaciente` (
  `IDAsPac` int(11) NOT NULL AUTO_INCREMENT,
  `IDAseguradora` int(11) NOT NULL,
  `IDPaciente` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  KEY `fk_asegAP` (`IDAseguradora`),
  KEY `fk_pacAP` (`IDPaciente`),
  CONSTRAINT `fk_asegAP` FOREIGN KEY (`IDAseguradora`) REFERENCES `aseguradora` (`IDAseguradora`) ON DELETE CASCADE,
  CONSTRAINT `fk_pacAP` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente` (`IDPaciente`),
  PRIMARY KEY (`IDAsPac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `url` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_user` (`user_id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;