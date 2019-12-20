-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-12-2019 a las 02:01:49
-- Versión del servidor: 10.1.32-MariaDB
-- Versión de PHP: 5.6.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `usaid`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_actualizaralumno` (IN `pa_id_alumno` INT, IN `pa_nombres` VARCHAR(150), IN `pa_apellidos` VARCHAR(150), IN `pa_id_sexo` INT, IN `pa_id_curso` INT)  BEGIN
UPDATE alumno SET id_alumno = pa_id_alumno,
		    nombres = pa_nombres,
	            apellidos = pa_apellidos,
	            id_sexo = pa_id_sexo,
		    id_curso = pa_id_curso
WHERE
id_alumno = pa_id_alumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_consultaralumno` ()  BEGIN
SELECT * FROM alumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_consultaralumno2` ()  BEGIN
SELECT a.id_alumno, a.nombres, a.apellidos, b.nombre_sexo, c.nombre_curso FROM alumno a INNER JOIN sexo b INNER JOIN curso c 
ON
b.id_sexo = a.id_sexo AND
c.id_curso = a.id_curso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_consultaralumnoporid` (IN `pa_id_alumno` INT)  BEGIN
SELECT * FROM alumno 
WHERE
id_alumno = pa_id_alumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_eliminaralumno` (IN `pa_id_alumno` INT)  BEGIN
DELETE FROM alumno 
WHERE
id_alumno = pa_id_alumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaralumno` (IN `pa_nombres` VARCHAR(150), IN `pa_apellidos` VARCHAR(150), IN `pa_id_sexo` INT, IN `pa_id_curso` INT)  BEGIN
INSERT INTO alumno (nombres,apellidos,id_sexo,id_curso) VALUES (pa_nombres,pa_apellidos,pa_id_sexo,pa_id_curso);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `id_alumno` int(11) NOT NULL,
  `nombres` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_sexo` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`id_alumno`, `nombres`, `apellidos`, `id_sexo`, `id_curso`) VALUES
(1, 'Javier', 'Henriquez', 1, 1),
(2, 'Christian', 'Cruz', 1, 2),
(3, 'Elba', 'Lazo', 2, 4),
(18, 'El', 'Kevin', 1, 3),
(30, 'El', 'Bryan', 1, 3),
(32, 'Juan Pablo', 'Baires', 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL,
  `nombre_curso` varchar(25) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`id_curso`, `nombre_curso`) VALUES
(1, 'Programador PHP'),
(2, 'Programador JAVA'),
(3, 'Programador de alarmas'),
(4, 'Corte y confección');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sexo`
--

CREATE TABLE `sexo` (
  `id_sexo` int(11) NOT NULL,
  `nombre_sexo` varchar(15) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `sexo`
--

INSERT INTO `sexo` (`id_sexo`, `nombre_sexo`) VALUES
(1, 'Masculino'),
(2, 'Femenino');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`id_alumno`),
  ADD KEY `alumno_sexo` (`id_sexo`),
  ADD KEY `alumno_curso` (`id_curso`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id_curso`);

--
-- Indices de la tabla `sexo`
--
ALTER TABLE `sexo`
  ADD PRIMARY KEY (`id_sexo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `id_alumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `sexo`
--
ALTER TABLE `sexo`
  MODIFY `id_sexo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `alumno_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`),
  ADD CONSTRAINT `alumno_sexo` FOREIGN KEY (`id_sexo`) REFERENCES `sexo` (`id_sexo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
