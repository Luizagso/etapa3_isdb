<?php
    include '../config.php';

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $nome = $_POST['nome'];
        $cpf = $_POST['cpf'];
        $crmv = $_POST['crmv'];
        $bairro = $_POST['bairro'];
        $numero = $_POST['numero'];
        $cidade = $_POST['cidade'];
        $estado = $_POST['estado'];
        $rua = $_POST['rua'];
        $complemento = $_POST['complemento'];
        $tipo = $_POST['tipo'];

        // Envolvendo em um bloco try-catch para capturar exceções
        try {
            $sql = "INSERT INTO Pessoa (nome, CPF, CRMV, bairro, numero, cidade, estado, rua, complemento, tipo)
                    VALUES ('$nome', '$cpf', '$crmv', '$bairro', '$numero', '$cidade', '$estado', '$rua', '$complemento', '$tipo')";

            if ($conn->query($sql) === TRUE) {
                echo "<div class='success-message'>Nova pessoa criada com sucesso!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível salvar o registro :(</div>";
            }

        } catch (mysqli_sql_exception $e) {
            // Mensagem de erro para duplicação de chave única (CPF/CRMV)
            if ($e->getCode() == 1062) {
                echo "<div class='error-message'>Erro: CPF ou CRMV já cadastrado!</div>";
            } else {
                // Mensagem genérica para outros erros
                //$e->getMessege()
                echo "<div class='error-message'>Não foi possível salvar o registro :(</div>";
            }
        }

        $conn->close();
    }
?>

<!DOCTYPE html>
<html>
<head>
    <title>Adicionar Pessoa</title>
    <link rel="stylesheet" type="text/css" href="../styles.css">
</head>
<body>
    <div class="navbar">
        <a href="index.php">Pessoa</a>
        <a href="../Animal/index.php">Animal</a>
        <a href="../Exame/index.php">Exame</a>
        <a href="../Medicamento/index.php">Medicamento</a>
        <a href="../Consulta/index.php">Consulta</a>
    </div>

    <h2>Adicionar Pessoa</h2>
    <form method="post" action="">
        Nome: <input type="text" name="nome" required><br>
        CPF: <input type="text" name="cpf" required><br>
        CRMV: <input type="text" name="crmv"><br>
        Bairro: <input type="text" name="bairro" required><br>
        Número: <input type="text" name="numero" required><br>
        Cidade: <input type="text" name="cidade" required><br>
        Estado: <input type="text" name="estado" required><br>
        Rua: <input type="text" name="rua" required><br>
        Complemento: <input type="text" name="complemento"><br>
        Tipo: 
        <select name="tipo">
            <option value="Veterinario">Veterinário</option>
            <option value="Tutor">Tutor</option>
        </select><br>
        <input type="submit" value="Adicionar Pessoa">
    </form>
</body>
</html>
