<?php
function getip() {
  $client  = @$_SERVER['HTTP_CLIENT_IP'];
  $forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
  $remote  = @$_SERVER['REMOTE_ADDR'];

  if(filter_var($client, FILTER_VALIDATE_IP)) {
    $ip = $client;
  } elseif(filter_var($forward, FILTER_VALIDATE_IP)) {
    $ip = $forward;
  } else {
    $ip = $remote;
  }
  $arr = preg_split("/[\s,]+/", $ip);
  return $arr[0];
}

function closedb() {
  global $db;
  if($db) $db->close();
}

function err($s) {
  closedb();
  $data = array("status" => "error", "data" => $s);
  die(json_encode($data));
}  

function out($s) {
  closedb();
  $data = array("status" => "success", "data" => $s);
  die(json_encode($data));
}

function needsupdate($s, $tv) {
  if(!isset($s["QUERY_STRING"]) || version_compare($s["QUERY_STRING"], $tv) != 0) err("guncellemeniz lazim. son surum: $tv");
}
?>
