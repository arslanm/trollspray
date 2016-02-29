<?php

include_once("./simple_html_dom.php");

class TrollSpray {
  protected $people;

  protected $author;	// ek$i db userid
  protected $nick;	// ek$i db nick

  protected $html;	// html code of badi-troll page

  function TrollSpray($html) {
    $this->people = array();
    $this->author = 0;
    $this->nick   = '';

    $this->html   = @str_get_html(stripslashes($html));
  }

  function findNick() {
    if(!$this->html) return false;
    foreach($this->html->find("a") as $a) {
      if(trim(strip_tags($a->innertext)) == "ben") {
        $this->nick = substr($a->title, 0, 40);
        break;
      }
    }
    if(!$this->nick) return false;
    return true;
  }

  function nick() {
    return $this->nick;
  }

  function inPeople() {
    if(!$this->html) return false;
    foreach($this->html->find('a[data-nick]') as $e) {
      if(preg_match("/r=blocked/", $e->href)) {
        $this->people[] = array('troll', $e->attr['data-nick'], $e->attr['data-userid']);
      } else if(preg_match("/r=buddy/", $e->href)) {
        $this->people[] = array('badi', $e->attr['data-nick'], $e->attr['data-userid']);
      }
    }
    return $this->people;
  }
}
?>
