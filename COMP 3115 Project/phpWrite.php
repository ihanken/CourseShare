<?php

// Read request parameters
if (isset ($_POST["name"]) && isset ($_POST["year"]) && isset ($_POST["majors"]) && isset ($_POST["progression"])) {
    $name = $_POST["name"];
    $year = $_POST["year"];
    $majors = $_POST["majors"];
    $progression = $_POST["progression"];
} else {
$name = "Error";
$year = "Error";
$majors = "Error";
$progression = "Error";
}

// Insert value into DB
$conn = mysql_connect( 'localhost', 'root', 'mU$1c225') or die('Could not connect to server.');
mysql_select_db('mysql', $conn) or die('Could not select database.');
$sql = "INSERT INTO Students (name, year, majors, progression) VALUES ('$name', '$year', '$majors', '$progression');";
$res = mysql_query($sql,$conn) or die(mysql_error());

mysql_close($conn);

if($res) {
$response = array('status' => '1');
} else {
die("Query failed");
}

echo json_encode($response);
exit();
?>
