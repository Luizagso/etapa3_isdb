<?php
$servername = "localhost";
$username = "root";
$password = "123456";
$dbname = "ClinicaVeterinaria";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM Animal";
$result = $conn->query($sql);

$animais = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $animais[] = $row;
    }
}

echo json_encode($animais);

$conn->close();
?>
