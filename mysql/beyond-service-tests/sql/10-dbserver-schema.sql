-- MySQL dump 10.13  Distrib 5.6.41, for Linux (x86_64)
--
-- Host: dbserver.dakcs.com    Database: dakcs
-- ------------------------------------------------------
-- Server version	5.6.41-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `dakcs`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dakcs` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dakcs`;

--
-- Table structure for table `accurint_log`
--

DROP TABLE IF EXISTS `accurint_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accurint_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dsn` int(11) NOT NULL DEFAULT '0',
  `report` smallint(6) NOT NULL DEFAULT '0',
  `master` int(11) NOT NULL DEFAULT '-1',
  `requested` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_accurint_log_state` (`state`),
  KEY `FK_accurint_log_dsn` (`dsn`),
  CONSTRAINT `FK_accurint_log_dsn` FOREIGN KEY (`dsn`) REFERENCES `accurint_setup` (`dsn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_accurint_log_state` FOREIGN KEY (`state`) REFERENCES `accurint_state` (`state`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accurint_report`
--

DROP TABLE IF EXISTS `accurint_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accurint_report` (
  `reportid` int(10) unsigned NOT NULL,
  `report` mediumblob,
  `stingxml` blob,
  `searchxml` blob,
  `resultxml` mediumblob,
  `fcrasearchxml` mediumblob,
  `fcraresultxml` mediumblob,
  `reporttimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reportid`),
  CONSTRAINT `FK_accurint_report_id` FOREIGN KEY (`reportid`) REFERENCES `accurint_log` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accurint_setup`
--

DROP TABLE IF EXISTS `accurint_setup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accurint_setup` (
  `dsn` int(11) NOT NULL DEFAULT '0',
  `userid` varchar(16) NOT NULL DEFAULT '',
  `userpass` varbinary(64) NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `fcra` tinyint(1) NOT NULL DEFAULT '0',
  `debug` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dsn`),
  CONSTRAINT `FK_accurint_setup_dsn` FOREIGN KEY (`dsn`) REFERENCES `customer_dsn` (`dsn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accurint_state`
--

DROP TABLE IF EXISTS `accurint_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accurint_state` (
  `state` tinyint(4) NOT NULL,
  `description` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `achdatacenter`
--

DROP TABLE IF EXISTS `achdatacenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `achdatacenter` (
  `dsn` varchar(4) NOT NULL,
  `accountset` varchar(4) NOT NULL,
  `activation` varchar(10) DEFAULT NULL,
  `max_dollar_amt` decimal(11,2) DEFAULT NULL,
  `pdc4ucustid` varchar(8) DEFAULT NULL,
  `pdc4uecheckseckey` varchar(64) DEFAULT NULL,
  `rdfiseckey` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`dsn`,`accountset`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cbsconfig`
--

DROP TABLE IF EXISTS `cbsconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cbsconfig` (
  `tranrcd` int(11) NOT NULL AUTO_INCREMENT,
  `dsn` varchar(4) DEFAULT NULL,
  `pdcid` int(11) NOT NULL DEFAULT '0',
  `companyname` varchar(50) DEFAULT NULL,
  `companyemail` varchar(50) DEFAULT NULL,
  `vendor` char(2) DEFAULT NULL,
  `FTP_filename` varchar(50) DEFAULT NULL,
  `activation` varchar(20) DEFAULT NULL,
  `rate` decimal(11,2) NOT NULL DEFAULT '0.00',
  `comments` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`tranrcd`),
  UNIQUE KEY `dsn_vendor_idx` (`dsn`,`vendor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cbslog`
--

DROP TABLE IF EXISTS `cbslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cbslog` (
  `tranrcd` int(11) NOT NULL AUTO_INCREMENT,
  `dsn` varchar(4) DEFAULT NULL,
  `vendor` char(2) DEFAULT NULL,
  `reportnum` varchar(4) DEFAULT NULL,
  `rec_cnt_sent` int(11) DEFAULT NULL,
  `archiveFileName` varchar(50) DEFAULT NULL,
  `batchID` varchar(50) DEFAULT NULL,
  `emailAddress` varchar(50) DEFAULT NULL,
  `emailAddrNotify` datetime DEFAULT NULL,
  `date_received` datetime DEFAULT NULL,
  `date_sent_to_bureau` datetime DEFAULT NULL,
  `date_recv_from_bureau` datetime DEFAULT NULL,
  `date_client_pickup` datetime DEFAULT NULL,
  `date_processed` datetime DEFAULT NULL,
  `batchFileDescription` varchar(256) DEFAULT NULL,
  `date_billed` datetime DEFAULT NULL,
  PRIMARY KEY (`tranrcd`),
  KEY `cbslog_sent_index` (`date_sent_to_bureau`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cbsstatus`
--

DROP TABLE IF EXISTS `cbsstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cbsstatus` (
  `tranrcd` int(11) NOT NULL AUTO_INCREMENT,
  `dsn` varchar(4) DEFAULT NULL,
  `reportnum` varchar(4) DEFAULT NULL,
  `masternum` int(11) DEFAULT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `date_received` date DEFAULT NULL,
  `batchID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tranrcd`),
  KEY `date_ref` (`date_received`),
  KEY `batch_ref` (`batchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_billing`
--

DROP TABLE IF EXISTS `cs_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_billing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dsn` int(11) NOT NULL DEFAULT '0',
  `client` varchar(15) NOT NULL DEFAULT '',
  `login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_cs_billing_dsn` (`dsn`),
  KEY `login_index` (`login`),
  CONSTRAINT `FK_cs_billing_dsn` FOREIGN KEY (`dsn`) REFERENCES `cs_setup` (`dsn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_demolog`
--

DROP TABLE IF EXISTS `cs_demolog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_demolog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dsn` int(11) NOT NULL DEFAULT '0',
  `client` varchar(15) NOT NULL DEFAULT '',
  `clientnum` varchar(4) NOT NULL DEFAULT '',
  `login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_cs_demolog_dsn` (`dsn`),
  CONSTRAINT `FK_cs_demolog_dsn` FOREIGN KEY (`dsn`) REFERENCES `cs_setup` (`dsn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_filelog`
--

DROP TABLE IF EXISTS `cs_filelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_filelog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dsn` int(11) NOT NULL DEFAULT '0',
  `client` varchar(15) NOT NULL DEFAULT '',
  `size` int(10) NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `upload` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_cs_filelog_dsn` (`dsn`),
  CONSTRAINT `FK_cs_filelog_dsn` FOREIGN KEY (`dsn`) REFERENCES `cs_setup` (`dsn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_rate`
--

DROP TABLE IF EXISTS `cs_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_rate` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `rate` decimal(8,2) NOT NULL DEFAULT '0.00',
  `cap` int(10) NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rate_cap_idx` (`rate`,`cap`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_ratehistory`
--

DROP TABLE IF EXISTS `cs_ratehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_ratehistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rateid` int(11) DEFAULT NULL,
  `customerid` int(11) DEFAULT NULL,
  `effectivedate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ratehist_custid_idx` (`customerid`),
  KEY `FK_ratehist_rateid_idx` (`rateid`),
  KEY `effectivedate_idx` (`effectivedate`),
  CONSTRAINT `FK_ratehist_custid` FOREIGN KEY (`customerid`) REFERENCES `customer_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ratehist_rateid` FOREIGN KEY (`rateid`) REFERENCES `cs_rate` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cs_setup`
--

DROP TABLE IF EXISTS `cs_setup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cs_setup` (
  `accesscode` varchar(6) NOT NULL,
  `dsn` int(11) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `banner` mediumblob,
  `protocol` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dsn`),
  UNIQUE KEY `accesscode_UNIQUE` (`accesscode`),
  CONSTRAINT `FK_cs_setup_dsn` FOREIGN KEY (`dsn`) REFERENCES `customer_dsn` (`dsn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_dsn`
--

DROP TABLE IF EXISTS `customer_dsn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_dsn` (
  `dsn` int(11) NOT NULL,
  `customerid` int(11) NOT NULL,
  `lu` tinyint(4) NOT NULL DEFAULT '6',
  `companyname` varchar(45) NOT NULL DEFAULT '',
  `databasename` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`dsn`),
  UNIQUE KEY `dsn_UNIQUE` (`dsn`),
  KEY `FK_customer_dsn_idx` (`customerid`),
  CONSTRAINT `FK_customer_dsn` FOREIGN KEY (`customerid`) REFERENCES `customer_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_info`
--

DROP TABLE IF EXISTS `customer_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `address` varchar(45) NOT NULL DEFAULT '',
  `city` varchar(45) NOT NULL DEFAULT '',
  `state` varchar(2) NOT NULL DEFAULT '',
  `zip` varchar(10) NOT NULL DEFAULT '',
  `host` varchar(128) NOT NULL DEFAULT '',
  `dsxqiport` int(11) NOT NULL DEFAULT '5555',
  `dsxqissl` tinyint(1) NOT NULL,
  `certificate` blob,
  `primarydsn` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_customer_info_primarydsn_idx` (`primarydsn`),
  CONSTRAINT `FK_customer_info_primarydsn` FOREIGN KEY (`primarydsn`) REFERENCES `customer_dsn` (`dsn`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_support`
--

DROP TABLE IF EXISTS `customer_support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_support` (
  `customerid` int(11) NOT NULL,
  `issupported` tinyint(1) NOT NULL DEFAULT '0',
  `ishosted` tinyint(1) NOT NULL DEFAULT '0',
  `sshparams` varchar(256) NOT NULL DEFAULT '',
  `kcspassword` varbinary(128) DEFAULT NULL,
  `rootpassword` varbinary(128) DEFAULT NULL,
  `salt` binary(8) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`customerid`),
  UNIQUE KEY `FK_customer_support_idx` (`customerid`),
  CONSTRAINT `FK_customer_support` FOREIGN KEY (`customerid`) REFERENCES `customer_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `numbers`
--

DROP TABLE IF EXISTS `numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `numbers` (
  `number` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdc4uachlog`
--

DROP TABLE IF EXISTS `pdc4uachlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pdc4uachlog` (
  `tranrcd` int(11) NOT NULL AUTO_INCREMENT,
  `dsn` varchar(4) NOT NULL DEFAULT '',
  `accountset` decimal(2,0) DEFAULT NULL,
  `referencenumber` decimal(11,2) DEFAULT NULL,
  `paymentlink` decimal(11,2) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `checkamt` decimal(11,2) DEFAULT '0.00',
  `feeamt` decimal(11,2) DEFAULT '0.00',
  `checkdate` date NOT NULL DEFAULT '0000-00-00',
  `trxtype` char(1) NOT NULL DEFAULT 'D',
  `trancode` char(3) NOT NULL DEFAULT '',
  `batchdate` datetime DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sentdate` date DEFAULT NULL,
  `settleposdate` date DEFAULT NULL,
  `settlenegdate` date DEFAULT NULL,
  `returndate` date DEFAULT NULL,
  `interrdate` date DEFAULT NULL,
  `correctiondate` date DEFAULT NULL,
  `returncode` varchar(64) DEFAULT NULL,
  `interrcode` varchar(64) DEFAULT NULL,
  `correctioncode` varchar(64) DEFAULT NULL,
  `settlementidpos` varchar(32) DEFAULT NULL,
  `settlementidneg` varchar(32) DEFAULT NULL,
  `datebilled` date DEFAULT NULL,
  `pdc4uid` varchar(16) DEFAULT NULL,
  `linktype` char(1) DEFAULT NULL,
  PRIMARY KEY (`tranrcd`),
  KEY `accountset_key` (`dsn`,`accountset`),
  KEY `checkdate_key` (`checkdate`),
  KEY `frontendtrace_key` (`dsn`,`paymentlink`),
  KEY `frontendtracedate_key` (`dsn`,`paymentlink`,`checkdate`),
  KEY `trancode_key` (`trancode`),
  KEY `pdc4uid_key` (`pdc4uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdcweb_failedlogins`
--

DROP TABLE IF EXISTS `pdcweb_failedlogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pdcweb_failedlogins` (
  `failedon` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(39) NOT NULL,
  `accesscode` varchar(30) NOT NULL,
  `account` int(11) NOT NULL,
  KEY `INDX_failedon` (`failedon`),
  KEY `INDX_ip` (`ip`),
  KEY `INDX_accesscode` (`accesscode`,`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdcweb_page`
--

DROP TABLE IF EXISTS `pdcweb_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pdcweb_page` (
  `accesscode` varchar(30) NOT NULL,
  `setupid` int(11) NOT NULL,
  `title` varchar(200) NOT NULL DEFAULT '',
  `bannername` varchar(128) NOT NULL DEFAULT '',
  `graphics` mediumblob,
  `lu` int(11) NOT NULL,
  `visa` tinyint(1) NOT NULL DEFAULT '0',
  `mastercard` tinyint(1) NOT NULL DEFAULT '0',
  `amex` tinyint(1) NOT NULL DEFAULT '0',
  `discover` tinyint(1) NOT NULL DEFAULT '0',
  `ach` tinyint(1) NOT NULL DEFAULT '0',
  `showemail` tinyint(1) NOT NULL DEFAULT '0',
  `showmiranda` tinyint(1) NOT NULL DEFAULT '0',
  `showdetail` tinyint(1) NOT NULL DEFAULT '0',
  `allowprecollect` tinyint(1) NOT NULL DEFAULT '0',
  `minimiranda` mediumtext,
  `feemessage` mediumtext,
  `altfeemessage` mediumtext,
  `updatetext` mediumtext,
  `achauthmessage` mediumtext,
  `ccauthmessage` mediumtext,
  UNIQUE KEY `accesscode_UNIQUE` (`accesscode`),
  KEY `FK_pdcweb_page_setupid_idx` (`setupid`),
  CONSTRAINT `FK_pdcweb_page_setupid` FOREIGN KEY (`setupid`) REFERENCES `pdcweb_setup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdcweb_setup`
--

DROP TABLE IF EXISTS `pdcweb_setup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pdcweb_setup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dsn` int(4) NOT NULL,
  `password` varchar(32) NOT NULL,
  `allowschedules` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dsn_UNIQUE` (`dsn`),
  UNIQUE KEY `password_UNIQUE` (`password`),
  CONSTRAINT `FK_pdcweb_setup_dsn` FOREIGN KEY (`dsn`) REFERENCES `customer_dsn` (`dsn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DNRTSLog`
--

DROP TABLE IF EXISTS `DNRTSLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DNRTSLog` (
  `rcd` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(40) DEFAULT NULL,
  `dsn` int(11) DEFAULT NULL,
  `report_number` int(11) DEFAULT NULL,
  `master_number` int(11) DEFAULT NULL,
  `date_stamp` date DEFAULT NULL,
  `service_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`rcd`),
  KEY `date_index` (`date_stamp`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
