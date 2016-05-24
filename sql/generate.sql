CREATE DATABASE IF NOT EXISTS `websequire` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `websequire`;

DROP TABLE IF EXISTS `attempt`;
CREATE TABLE IF NOT EXISTS `attempt` (
  `USER_EMAIL` varchar(45) NOT NULL,
  `SUCCESSFUL` bit(1) NOT NULL,
  `DATE` datetime NOT NULL,
  `IP` varchar(32) NOT NULL
);

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `ID` char(36) NOT NULL,
  `SENDER_USER_ID` char(36) NOT NULL,
  `RECIPIENT_USER_ID` char(36) NOT NULL,
  `DATE` datetime NOT NULL,
  `MSG_HEADER` varchar(45) DEFAULT NULL,
  `MSG_BODY` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ;

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `USER_ID` char(36) NOT NULL,
  `ROLE` varchar(32) NOT NULL,
  KEY `FK_USER_ID` (`USER_ID`)
);

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` char(36) NOT NULL,
  `EMAIL` varchar(45) NOT NULL,
  `PASSWORD` char(60) NOT NULL,
  `USERNAME` varchar(20) NOT NULL,
  `IMGPATH` char(41) NOT NULL,
  `ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  `BANNED` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `EMAIL_UNIQUE` (`EMAIL`)
) ;


ALTER TABLE `role`
  ADD CONSTRAINT `FK_USER_ID` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `message`
  ADD CONSTRAINT `sender_id` FOREIGN KEY (`SENDER_USER_ID`) REFERENCES `user` (`ID`);
ALTER TABLE `message`
  ADD CONSTRAINT `recipient_id` FOREIGN KEY (`RECIPIENT_USER_ID`) REFERENCES `user` (`ID`);