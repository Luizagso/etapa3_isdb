<?php
$servername = "localhost";
$username = "root";
$password = "123456";
$dbname = "ClinicaVeterinaria";

// Cria a conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica a conexão
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Busca os dados da tabela Pessoa
$sql = "SELECT * FROM Pessoa";
$result = $conn->query($sql);

$pessoas = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $pessoas[] = $row;
    }
}

echo json_encode($pessoas);

$conn->close();
?>
