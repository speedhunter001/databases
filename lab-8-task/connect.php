<?php
	$server  = "localhost";
	$user = "root";
	$pass = "";
	$dbname = "nutec";

	$con = new MySQLi($server, $user, $pass, $dbname);

	if ($con->connect_error)
		echo "Error: ".$con->connect_error;
	else
		echo "Connect succesfully";
?>