<?php
include_once("./version.php");
include_once("./mysqli_class.php");
include_once("./misc.php");

needsupdate($_SERVER, $TROLLVERSION);

$db = new MySQL();
if(!$db) err("havuz problemi var");

$ip = getip();
if(!$ip) err("nereden geldigin belli degil");

if($db->isabuserip($ip)) err("daha demin yaptik. iki uc dakika icinde tekrar deneyin.");

out("ok");

?>
