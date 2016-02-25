-- MySQL dump 10.13  Distrib 5.6.27, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: trollspray
-- ------------------------------------------------------
-- Server version	5.6.27-0ubuntu1

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
-- Table structure for table `badis`
--

DROP TABLE IF EXISTS `badis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badis` (
  `who` int(11) NOT NULL,
  `badi` int(11) NOT NULL,
  UNIQUE KEY `whobadi` (`who`,`badi`),
  KEY `badi` (`badi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `get_troll_cnt`
--

DROP TABLE IF EXISTS `get_troll_cnt`;
/*!50001 DROP VIEW IF EXISTS `get_troll_cnt`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `get_troll_cnt` AS SELECT 
 1 AS `tcnt`,
 1 AS `nick`,
 1 AS `troll`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ips`
--

DROP TABLE IF EXISTS `ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ips` (
  `ip` varchar(16) NOT NULL,
  `nick` varchar(40) NOT NULL,
  `lastpush` datetime NOT NULL,
  UNIQUE KEY `ip` (`ip`),
  KEY `lastpush` (`lastpush`),
  KEY `nick` (`nick`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trollcnt`
--

DROP TABLE IF EXISTS `trollcnt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trollcnt` (
  `troll` int(11) NOT NULL,
  `nick` varchar(40) NOT NULL,
  `cnt` int(11) NOT NULL,
  UNIQUE KEY `troll` (`troll`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trollcnt_lastupdate`
--

DROP TABLE IF EXISTS `trollcnt_lastupdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trollcnt_lastupdate` (
  `lastupdate` datetime NOT NULL,
  `lastpush` datetime NOT NULL,
  KEY `lastupdate` (`lastupdate`),
  KEY `lastpush` (`lastpush`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trolls`
--

DROP TABLE IF EXISTS `trolls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trolls` (
  `who` int(11) NOT NULL,
  `troll` int(11) NOT NULL,
  UNIQUE KEY `whotroll` (`who`,`troll`),
  KEY `troll` (`troll`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `trolls_badi_constant`
--

DROP TABLE IF EXISTS `trolls_badi_constant`;
/*!50001 DROP VIEW IF EXISTS `trolls_badi_constant`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `trolls_badi_constant` AS SELECT 
 1 AS `troll`,
 1 AS `badi_constant(param())`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `trolls_of_badis`
--

DROP TABLE IF EXISTS `trolls_of_badis`;
/*!50001 DROP VIEW IF EXISTS `trolls_of_badis`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `trolls_of_badis` AS SELECT 
 1 AS `troll`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `trolls_of_self`
--

DROP TABLE IF EXISTS `trolls_of_self`;
/*!50001 DROP VIEW IF EXISTS `trolls_of_self`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `trolls_of_self` AS SELECT 
 1 AS `troll`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `nick` varchar(40) NOT NULL,
  `cnt` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `lastpush` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nick` (`nick`),
  KEY `status` (`status`),
  KEY `cnt` (`cnt`)
) ENGINE=InnoDB AUTO_INCREMENT=21586 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'trollspray'
--
/*!50003 DROP FUNCTION IF EXISTS `badi_constant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`trollspray`@`localhost` FUNCTION `badi_constant`(self integer) RETURNS decimal(10,2)
begin      
    declare val decimal(10,2);
    select count(0) into val from badis where who=self;
    if (val < 1) then return 0; end if;
    if (val > 250) then set val := 250; end if;
    set val := truncate(val*(-1/249) + 499/249, 2);
    return val;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `param` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`trollspray`@`localhost` FUNCTION `param`() RETURNS int(11)
    NO SQL
    DETERMINISTIC
return @param ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `update_trollcnt_func` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`trollspray`@`localhost` FUNCTION `update_trollcnt_func`() RETURNS int(11)
    MODIFIES SQL DATA
begin
declare val1 int;
declare val2 int;
declare rc int default false;
declare err int default false;
declare continue handler for sqlexception set err := true;

select now()-lastupdate, now()-lastpush into val1, val2 from trollcnt_lastupdate;
if (val1 > 300 and val1 > val2) then
    delete from trollcnt; 
    insert into trollcnt (troll, nick, cnt) select troll, nick, tcnt from get_troll_cnt order by tcnt desc limit 1000;
    update trollcnt_lastupdate set lastupdate = now();
end if;
if err = false then
  set rc := true;
end if;
return rc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_trollcnt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`trollspray`@`localhost` PROCEDURE `update_trollcnt`()
    MODIFIES SQL DATA
begin
declare rc int default false;
start transaction;
savepoint bfr;
set rc := update_trollcnt_func();
if rc = true then
  commit;
else
  rollback to bfr;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `get_troll_cnt`
--

/*!50001 DROP VIEW IF EXISTS `get_troll_cnt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`trollspray`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `get_troll_cnt` AS select count(0) AS `tcnt`,`u`.`nick` AS `nick`,`u`.`userid` AS `troll` from (`trolls` `t` join `users` `u` on((`u`.`id` = `t`.`troll`))) group by `u`.`userid` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `trolls_badi_constant`
--

/*!50001 DROP VIEW IF EXISTS `trolls_badi_constant`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `trolls_badi_constant` AS select `t`.`troll` AS `troll`,`badi_constant`(`param`()) AS `badi_constant(param())` from (`trolls` `t` join `badis` `b` on(((`b`.`who` = `param`()) and (`t`.`who` = `b`.`badi`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `trolls_of_badis`
--

/*!50001 DROP VIEW IF EXISTS `trolls_of_badis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`trollspray`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `trolls_of_badis` AS select `u`.`userid` AS `troll` from ((`trolls` `t` join `users` `u` on((`u`.`id` = `t`.`troll`))) join `badis` `b` on(((`b`.`who` = `param`()) and (`t`.`who` = `b`.`badi`) and (`b`.`badi` <> `param`())))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `trolls_of_self`
--

/*!50001 DROP VIEW IF EXISTS `trolls_of_self`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`trollspray`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `trolls_of_self` AS select `u`.`userid` AS `troll` from (`trolls` `t` join `users` `u` on((`u`.`id` = `t`.`troll`))) where (`t`.`who` = `param`()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-25 13:25:35
