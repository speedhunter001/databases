<?php
	include "connect.php";
?>

<!DOCTYPE html>
<html>
<head>
	<title>Student's Record</title>
</head>
<body>
	<form action="" method="post">
		<table align="center">
			<th colspan="2">Search Student</th>
			<tr>
				<td>
					Roll No
				</td>
				<td>
					<input type="text" name="txtRNo" required>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="Search">
				</td>
			</tr>
		</table>
	</form>
	<?php
		if (isset($_POST["txtRNo"])) {
			$roll = $_POST["txtRNo"];
			$qry = "SELECT * FROM student WHERE roll_no = '".$roll."'";
			$res = $con->query($qry);
			$result = "";

			if ($res->num_rows>0) {
				$result .= "<table align='center'>";
				$result .= "<th>Roll No</th><th>Name</th><th>Father's Name</th><th>Gender</th><th>Contact No</th><th>Address</th>";
				while ($row = $res->fetch_assoc()) 
				{
					//one row
					$result .= "<tr>
									<td>
										".$row['roll_no']."
									</td>
									<td>
										".$row['st_name']."
									</td>
									<td>
										".$row['f_name']."
									</td>
									<td>
										".$row['gender']."
									</td>
									<td>
										".$row['contact']."
									</td>
									<td>
										".$row['address']."
									</td>
								</tr>";
				}
				$result .= "</table>";
			}
			echo $result;
		}
	?>
</body>
</html>