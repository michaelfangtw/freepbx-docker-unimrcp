-- create databases
CREATE DATABASE IF NOT EXISTS `asterisk`;
CREATE DATABASE IF NOT EXISTS `asteriskcdrdb`;

-- create root user and grant rights
GRANT ALL ON asterisk.* TO 'asterisk'@'127.0.0.1' IDENTIFIED BY 'asterisk';
GRANT ALL ON asterisk.* TO 'asterisk'@'%' IDENTIFIED BY 'asterisk';
GRANT ALL ON asteriskcdrdb.* TO 'asterisk'@'127.0.0.1' IDENTIFIED BY 'asterisk';
GRANT ALL ON asteriskcdrdb.* TO 'asterisk'@'%' IDENTIFIED BY 'asterisk';
