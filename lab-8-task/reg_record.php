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
			<h2 align="center">Nutec'20 Event Record</h2>
			<tr>
				<td>
					Search By
				</td>
				<td>
					<select name="column" required>
						<option value=roll_no>Roll No</option>
						<option value=event_name>Event</option>
						<option value=department>Department</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					Enter Data
				</td>
				<td>
					<input type="text" name="column_value">
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
		if (isset($_POST["column_value"])) {
			$column = $_POST["column"];
			$column_value = $_POST["column_value"];
			$qry = "SELECT * FROM reg_record WHERE ".$column." = '".$column_value."'";
			$res = $con->query($qry);
			$result = "";

			if ($res->num_rows>0) {
				$result .= "<table align='center'>";
				$result .= "<th>Roll No</th><th>Name</th><th>Email</th><th>Semester</th><th>Department</th><th>Event Name</th>";
				while ($row = $res->fetch_assoc()) 
				{
					//one row
					$result .= "<tr>
									<td>
										".$row['roll_no']."
									</td>
									<td>
										".$row['name']."
									</td>
									<td>
										".$row['email']."
									</td>
									<td>
										".$row['semester']."
									</td>
									<td>
										".$row['department']."
									</td>
									<td>
										".$row['event_name']."
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