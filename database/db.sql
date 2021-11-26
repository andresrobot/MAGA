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
  `isPaciente` bool NOT NULL,
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
  `IDPaciente` int(11) NOT NULL,
  `IDMedicamento` int(11) NOT NULL,
  `indicaciones` VARCHAR(500),
  KEY `fk_medMP` (`IDMedicamento`),
  KEY `fk_pacMP` (`IDPaciente`),
  CONSTRAINT `fk_medMP` FOREIGN KEY (`IDMedicamento`) REFERENCES `medicamentos` (`IDMedicamento`),
  CONSTRAINT `fk_pacMP` FOREIGN KEY (`IDPaciente`) REFERENCES `paciente` (`IDPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `doctores` (
  `IDDoctor` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `edad` int(11) NOT NULL,
  `apellidoMaterno` varchar(150) NOT NULL,
  `apellidoPaterno` varchar(150) NOT NULL,
  `especialidad`varchar(150) NOT NULL
  PRIMARY KEY (`IDDoctor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `citasdoctores` (
  `IDCita` int(11) NOT NULL,
  `IDDoctor` int(11) NOT NULL,
  KEY `fk_citaCD` (`IDCita`),
  KEY `fk_drCD` (`IDDoctor`),
  CONSTRAINT `fk_citaCD` FOREIGN KEY (`IDCita`) REFERENCES `citas` (`IDCita`),
  CONSTRAINT `fk_drCD` FOREIGN KEY (`IDDoctor`) REFERENCES `doctores` (`IDDoctor`)
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