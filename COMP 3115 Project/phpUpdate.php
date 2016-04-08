<?php

// Read request parameters
if (isset ($_POST["student_id"]) && isset ($_POST["progression"])) {
    $id = $_POST["student_id"];
    $progression = $_POST["progression"];
} else {
    $id = "Error";
    $progression = "Error";
}

// Insert value into DB
$conn = mysql_connect( 'localhost', 'root', 'mU$1c225') or die('Could not connect to server.');
mysql_select_db('mysql', $conn) or die('Could not select database.');
$sql = "UPDATE students SET progression = '$progression' WHERE student_id=$id;";
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
