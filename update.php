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
    $nome = $_POST['nome'];
    $cpf = $_POST['cpf'];
    $tipo = $_POST['tipo'];

    $sql = "UPDATE Pessoa SET ";
    if ($nome) $sql .= "nome='$nome', ";
    if ($cpf) $sql .= "CPF='$cpf', ";
    if ($tipo) $sql .= "tipo='$tipo', ";
    $sql = rtrim($sql, ', ');
    $sql .= " WHERE idPessoa=$idPessoa";

    if ($conn->query($sql) === TRUE) {
        echo "Registro de Tutor ou Veterinário atualizado com sucesso!";
    } else {
        echo "Erro ao atualizar registro: " . $conn->error;
    }
}

if (isset($_POST['idAnimal'])) {
    $idAnimal = $_POST['idAnimal'];
    $nome = $_POST['nome'];
    $registro = $_POST['registro'];
    $idPessoa = $_POST['idPessoa'];
    $dataNasc = $_POST['dataNasc'];
    $raca = $_POST['raca'];
    $especie = $_POST['especie'];
    $sexo = $_POST['sexo'];

    $sql = "UPDATE Animal SET ";
    if ($nome) $sql .= "nome='$nome', ";
    if ($registro) $sql .= "registro='$registro', ";
    if ($idPessoa) $sql .= "idPessoa='$idPessoa', ";
    if ($dataNasc) $sql .= "dataNasc='$dataNasc', ";
    if ($raca) $sql .= "raca='$raca', ";
    if ($especie) $sql .= "especie='$especie', ";
    if ($sexo) $sql .= "sexo='$sexo', ";
    $sql = rtrim($sql, ', ');
    $sql .= " WHERE idAnimal=$idAnimal";

    if ($conn->query($sql) === TRUE) {
        echo "Registro de Animal atualizado com sucesso!";
    } else {
        echo "Erro ao atualizar registro: " . $conn->error;
    }
}

if (isset($_POST['idConsulta'])) {
    $idConsulta = $_POST['idConsulta'];
    $dataConsulta = $_POST['dataConsulta'];
    $idAnimal = $_POST['idAnimal'];
    $idPessoa = $_POST['idPessoa'];
    $dataLimiteRetorno = $_POST['dataLimiteRetorno'];

    $sql = "UPDATE Consulta SET ";
    if ($dataConsulta) $sql .= "dataConsulta='$dataConsulta', ";
    if ($idAnimal) $sql .= "idAnimal='$idAnimal', ";
    if ($idPessoa) $sql .= "idPessoa='$idPessoa', ";
    if ($dataLimiteRetorno) $sql .= "dataLimiteRetorno='$dataLimiteRetorno', ";
    $sql = rtrim($sql, ', ');
    $sql .= " WHERE idConsulta=$idConsulta";

    if ($conn->query($sql) === TRUE) {
        echo "Registro de Consulta atualizado com sucesso!";
    } else {
        echo "Erro ao atualizar registro: " . $conn->error;
    }
}

$conn->close();
?>
