<?php

include_once("./dbconfig.php");

class MySQL extends DBConfig {
  public $dblink;

  protected $host;
  protected $user;
  protected $pass;
  protected $db;

  protected $id;	// submitter's id on local users table
  protected $author;	// submitter's userid on eksi db
  protected $nick;	// submitter's nick on local users table

  function MySQL() {
    $this->dblink = NULL;

    $dbparam = new DBConfig();
    $this->host = $dbparam->host;
    $this->user = $dbparam->user;
    $this->pass = $dbparam->pass;
    $this->db   = $dbparam->db;
    unset($dbparam);
    $this->id = 0;
    $this->connect();
  }

  function checkUser($nick, $author = 0) {
    $id = 0;
    $res = $this->query("select * from users where nick='$nick' limit 1");
    if(!$res) return false;
    $row = $this->getrow($res);
    if($row) {
      $id = $row[0];
      $author = $author ? $author : ($row[1] ? $row[1] : 0);
      $this->update("update users set userid='$author' where id='$id'");
    } else {
      if($author)
        $rc = $this->insert("insert into users (userid, nick) values ('$author', '$nick')");
      else
        $rc = $this->insert("insert into users (nick) values ('$nick')");
      if(!$rc) return false;
      $id = $this->lastid();
    }
    @mysqli_free_result($res);
    if(!$id) return false;
    return array($id, $author);
  }

  function submitter($nick) {
    $ret = $this->checkUser($nick);
    if(!$ret) return false;
    $this->id = $ret[0];
    if(!$ret[1]) $this->author = $ret[1];
    $this->nick = $nick;
    return true;
  }

  function addPeople($people) {
    if(!$this->dblink) return 0;

    $this->flushPeople();

    $tc = 0;
    foreach($people as $person) {
      $table = 'badis';
      if($person[0] == 'troll') {
        $table = 'trolls';
        $tc++;
      }
      $personnick = $person[1];
      $personauthor = $person[2];
      $ret = $this->checkUser($personnick, $personauthor);
      $personid = $ret[0];
      $this->insert("insert into $table values ('" . $this->id . "', '$personid')");
    }
    return $tc;
  }

  private function flushPeople() {
    if(!$this->dblink) return false;
    if(!$this->id) return false;

    $this->delete("delete from trolls where who='" . $this->id . "'");
    $this->delete("delete from badis where who='" . $this->id . "'");
    return true;
  }

  function isabuserip($ip) {
    if(!$this->dblink) return false;
    $res = $this->query("select * from ips where now()-lastpush<60 limit 1");
    if(!$res) return true;
    if(@mysqli_num_rows($res)) return true;
    return false;
  }

  function isabusernick($nick) {
    if(!$this->dblink) return false;
    $q = "select * from users where nick='$nick' and now()-lastpush<60 limit 1";
    $res = $this->query($q);
    if(@mysqli_num_rows($res)) return true;
    return false;
  }

  function updateip($ip) {
    if(!$this->dblink) return false;
    $this->update("update users set lastpush=now() where id='" . $this->id . "'");
    $this->update("update trollcnt_lastupdate set lastpush=now()");
    $res = $this->query("select ip from ips where nick='" . $this->nick . "' limit 1");
    if($res) {
      $row = $this->getrow($res);
      if($row) {
        $this->update("update ips set lastpush=now(),ip='$ip' where nick='" . $this->nick . "'");
      } else {
        $this->insert("insert into ips values ('$ip', '" . $this->nick . "', now())");
      }
    } else {
      $this->insert("insert into ips values ('$ip', '" . $this->nick . "', now())");
    }
  }

  function getCandidates($tc) {
    if(!$this->dblink) return false;

    $max = 5000;
    $limit = $max - $tc;
    if(!$limit || $limit < 1) return array();
    if($limit > 20) $limit = 20;

    $this->query("set @param=" . $this->id);
    $this->query("set @constant = badi_constant(param())");

    $res = $this->query("select distinct t.troll, t.id from (select distinct t.nick as troll, truncate(t.tcnt, 2) as rating, t.troll as id from (select t.troll, t.nick, t.cnt*@constant as tcnt from trollcnt t where t.troll in (select troll from trolls_of_badis t) union select t.troll, t.nick, t.cnt as tcnt from trollcnt t) t where t.troll not in (select troll from trolls_of_self t) order by tcnt desc limit $max) t limit $limit");
    if(!$res) return false;
    $rows = array();
    while($r = $this->get_assoc_row($res)) {
      $rows[] = $r;
    }
    @mysqli_free_result($res);
    return $rows;
  }

  private function connect() {
    $this->checkDbConn();

    $this->dblink = mysqli_connect($this->host, $this->user, $this->pass);

    if(!$this->dblink) return false;
    if(!$this->useDb()) return false;
    return true;
  }

  private function useDb() {
    if(!mysqli_select_db($this->dblink, $this->db)) return false;
    return true;
  }

  function escape($str) {
    if(!$this->dblink) return '';
    return mysqli_real_escape_string($this->dblink, $str);
  }


  private function checkDbConn() {
    if($this->dblink) mysqli_close($this->dblink);
  }

  protected function query($query) {
    if(!$this->dblink) return false;
    return mysqli_query($this->dblink, $query);
  }

  protected function getrow($res) {
    if(!$this->dblink) return false;
    return mysqli_fetch_row($res);
  }

  protected function get_assoc_row($res) {
    if(!$this->dblink) return false;
    return mysqli_fetch_assoc($res);
  }

  protected function update($query) {
    if(!$this->dblink) return false;
    return mysqli_query($this->dblink, $query);
  }

  protected function insert($query) {
    if(!$this->dblink) return false;
    if(!mysqli_query($this->dblink, $query)) return false;
    return true;
  }

  protected function delete($query) {
    if(!$this->dblink) return false;
    if(!mysqli_query($this->dblink, $query)) return false;
    return true;
  }

  protected function lastid() {
    if(!$this->dblink) return false;
    return mysqli_insert_id($this->dblink);
  }

  function close() {
    if($this->dblink) mysqli_close($this->dblink);
  }
}
?>
