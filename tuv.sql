-- phpMyAdmin SQL Dump
-- version 4.0.10deb1ubuntu0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 12, 2019 at 05:09 PM
-- Server version: 5.5.61-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tuv`
--

-- --------------------------------------------------------

--
-- Table structure for table `wae10_genre`
--

CREATE TABLE IF NOT EXISTS `wae10_genre` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(256) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `wae10_genre`
--

INSERT INTO `wae10_genre` (`ID`, `NAME`) VALUES
(1, 'Action'),
(2, 'Crime'),
(3, 'Family'),
(4, 'Horror'),
(5, 'Adventure'),
(6, 'Comedy'),
(7, 'Fantasy'),
(8, 'Drama'),
(9, 'Documentary');

-- --------------------------------------------------------

--
-- Table structure for table `wae10_movie`
--

CREATE TABLE IF NOT EXISTS `wae10_movie` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(256) NOT NULL,
  `DESCRIPTION` text,
  `GENRE_ID` int(11) NOT NULL,
  `TYPE` varchar(10) NOT NULL DEFAULT 'MOVIE',
  `RATING` decimal(10,0) DEFAULT NULL,
  `IMAGE` varchar(256) DEFAULT NULL,
  `YEAR` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `wae10_movie`
--

INSERT INTO `wae10_movie` (`ID`, `NAME`, `DESCRIPTION`, `GENRE_ID`, `TYPE`, `RATING`, `IMAGE`, `YEAR`) VALUES
(1, 'Avatar', 'Nice movie with blue characters', 1, 'MOVIE', 5, 'm1.jpg', '2009'),
(2, 'Mein Filmx ac', 'bitte hier den Text eingeben.\r\n', 3, 'MOVIE', NULL, NULL, '2019'),
(3, 'Mein Film 3', 'Bitte hier den Text eingeben.', 4, 'MOVIE', NULL, NULL, '2019');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
