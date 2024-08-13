<?php
$servername = "localhost";
$username = "root";
$password = "123456";
$dbname = "ClinicaVeterinaria";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (isset($_POST['idPessoa'])) {
    $idPessoa = $_POST['idPessoa'];

    $sql = "DELETE FROM Pessoa WHERE idPessoa=$idPessoa";

    if ($conn->query($sql) === TRUE) {
        echo "Registro de Tutor ou Veterinário excluído com sucesso!";
    } else {
        echo "Erro ao excluir registro: " . $conn->error;
    }
}

if (isset($_POST['idAnimal'])) {
    $idAnimal = $_POST['idAnimal'];

    $sql = "DELETE FROM Animal WHERE idAnimal=$idAnimal";

    if ($conn->query($sql) === TRUE) {
        echo "Registro de Animal excluído com sucesso!";
    } else {
        echo "Erro ao excluir registro: " . $conn->error;
    }
}

if (isset($_POST['idConsulta'])) {
    $idConsulta = $_POST['idConsulta'];

    $sql = "DELETE FROM Consulta WHERE idConsulta=$idConsulta";

    if ($conn->query($sql) === TRUE) {
        echo "Registro de Consulta excluído com sucesso!";
    } else {
        echo "Erro ao excluir registro: " . $conn->error;
    }
}

$conn->close();
?>
