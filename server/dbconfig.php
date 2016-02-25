<?php

class DBConfig {
	protected $host;
	protected $user;
	protected $pass;
	protected $db;

	function DBConfig() {
		$this->host = 'localhost';
		$this->user = 'trollspray';
		$this->pass = 'fucktrolls';
		$this->db   = 'trollspray';
	}
}
?>
