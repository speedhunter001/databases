<?php
	include "connect.php";

	//echo "You are here, you have a quiz?";

	$roll = $_POST["txtRollNo"];
	$name = $_POST["txtName"];
	$email = $_POST["txtEmail"];
	$semester = $_POST["txtSemester"];
	$department = $_POST["sDepartment"];
	$event = $_POST["sEvent"];

	$qry = "INSERT INTO reg_record VALUES('".$roll."','".$name."', '".$email."', '".$semester."', '".$department."', '".$event."')";

	//echo $qry;
	if ($con->query($qry)) {
		$msg = "Student Registered";
	}
	else
		$msg = "Error!";

	header("Location:event_reg.php?Message=$msg")
?>