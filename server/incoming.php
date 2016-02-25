<?php

include_once("./version.php");
include_once("./mysqli_class.php");
include_once("./trollspray_class.php");
include_once("./misc.php");

needsupdate($_SERVER, $TROLLVERSION);

$db = new MySQL();
if(!$db) err("havuz problemi var");

$ip = getip();
if(!$ip) err("nereden geldigin belli degil");

if($db->isabuserip($ip)) err("daha demin yaptik. iki uc dakika icinde tekrar deneyin.");

$in = file_get_contents("php://input");

$compressed = base64_decode($in);

$html = @gzinflate($compressed);
if(!$html) err("liste tam ulasmadi");

$ts = new TrollSpray($html);

if(!$ts->findNick()) err("liste tam gonderilemedi");

$nick = $db->escape($ts->nick());
if(!$nick) err("havuzda problem var, daha sonra tekrar deneyin");

if($db->isabusernick($nick)) err("daha demin yaptik. iki uc dakika sonra tekrar deneyin.");

$rc = $db->submitter($nick);
if(!$rc) err("havuzda problem var, baska bir zaman calisabilir");

$people = $ts->inPeople();

$trollcnt = $db->addPeople($people);

$db->updateip($ip);

$cnd = $db->getCandidates($trollcnt);
out(array("candidates" => $cnd));

?>
