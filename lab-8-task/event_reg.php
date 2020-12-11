
<?php
	include "connect.php";
?>

<!DOCTYPE html>
<html>
<head>
	<title>Nutec'20 Event Registeration Form</title>
</head>
<body>
	<h2>Nutec'20 Event Registeration For Fastians</h2>
	<br>
	<br>
	<form action="event_reg_try.php" method="post">
		<table align="left">
			<tr>
				<td>
					Roll No
				</td>
				<td>
					<input type="text" name="txtRollNo" required>
				</td>
			</tr>
			<tr>
				<td>
					Name
				</td>
				<td>
					<input type="text" name="txtName" required>
				</td>
			</tr>
			<tr>
				<td>
					email
				</td>
				<td>
					<input type="email" name="txtEmail" required>
				</td>
			</tr>
				<td>
					semester
				</td>
				<td>
					<input type="text" name="txtSemester" required>
				</td>
			</tr>			
			<tr>
				<td>
					department
				</td>
				<td>
					<select name="sDepartment" required>
						<option value="Computer Science">Computer Science</option>
						<option value="Electrical Engineering">Electrical Engineering</option>
					</select>
				</td>
			</tr>
			<tr>
			<tr>
				<td>
					Choose Event
				</td>
				<td>
					<select name="sEvent" required>
						<option value="Speed Programming">Speed Programming</option>
						<option value="Speed Wiring">Speed Wiring</option>
						<option value="Music">Music</option>
					</select>
				</td>
			</tr>			
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="Sumbit">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<?php
						if (isset($_GET["Message"])) {
							echo $_GET["Message"];
						}
					?>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>