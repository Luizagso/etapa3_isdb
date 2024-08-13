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

// Inserção na tabela Pessoa
if (isset($_POST['nome']) && isset($_POST['cpf']) && isset($_POST['tipo'])) {
    $nome = $_POST['nome'];
    $cpf = $_POST['cpf'];
    $tipo = $_POST['tipo'];

    $sql = "INSERT INTO Pessoa (CPF, nome, tipo) VALUES ('$cpf', '$nome', '$tipo')";
    if ($conn->query($sql) === TRUE) {
        echo "Novo registro criado com sucesso na tabela Pessoa";
    } else {
        echo "Erro: " . $sql . "<br>" . $conn->error;
    }
}

// Inserção na tabela Animal
if (isset($_POST['registro']) && isset($_POST['nome']) && isset($_POST['idPessoa'])) {
    $nome = $_POST['nome'];
    $registro = $_POST['registro'];
    $idPessoa = $_POST['idPessoa'];
    $dataNasc = $_POST['dataNasc'];
    $raca = $_POST['raca'];
    $especie = $_POST['especie'];
    $sexo = $_POST['sexo'];

    $sql = "INSERT INTO Animal (registro, idPessoa, nome, dataNasc, raca, especie, sexo) VALUES ('$registro', '$idPessoa', '$nome', '$dataNasc', '$raca', '$especie', '$sexo')";
    if ($conn->query($sql) === TRUE) {
        echo "Novo registro criado com sucesso na tabela Animal";
    } else {
        echo "Erro: " . $sql . "<br>" . $conn->error;
    }
}

// Inserção na tabela Consulta
if (isset($_POST['dataConsulta']) && isset($_POST['idAnimal']) && isset($_POST['idPessoa'])) {
    $dataConsulta = $_POST['dataConsulta'];
    $idAnimal = $_POST['idAnimal'];
    $idPessoa = $_POST['idPessoa'];
    $dataLimiteRetorno = $_POST['dataLimiteRetorno'];

    $sql = "INSERT INTO Consulta (dataConsulta, idAnimal, idPessoa, dataLimiteRetorno) VALUES ('$dataConsulta', '$idAnimal', '$idPessoa', '$dataLimiteRetorno')";
    if ($conn->query($sql) === TRUE) {
        echo "Novo registro criado com sucesso na tabela Consulta";
    } else {
        echo "Erro: " . $sql . "<br>" . $conn->error;
    }
}

$conn->close();
?>
