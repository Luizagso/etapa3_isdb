<?php
    include '../config.php';

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $nome = $_POST['nome'];
        $cpf = $_POST['cpf'];
        $bairro = $_POST['bairro'];
        $numero = $_POST['numero'];
        $cidade = $_POST['cidade'];
        $estado = $_POST['estado'];
        $rua = $_POST['rua'];
        $complemento = $_POST['complemento'];
        $tipo = $_POST['tipo'];

        // Inicializando a consulta SQL
        $sql = "INSERT INTO Pessoa (nome, CPF, bairro, numero, cidade, estado, rua, complemento, tipo";

         // Se o CRMV for preenchido, inclui-o na consulta
        if (isset($_POST['crmv']) && !empty($_POST['crmv'])) {
            $crmv = $_POST['crmv'];
            $sql .= ", CRMV) VALUES ('$nome', '$cpf', '$bairro', '$numero', '$cidade', '$estado', '$rua', '$complemento', '$tipo', '$crmv')";
        } else {
            // Caso contrário, não o inclui na consulta
            $sql .= ") VALUES ('$nome', '$cpf', '$bairro', '$numero', '$cidade', '$estado', '$rua', '$complemento', '$tipo')";
        }

        try {
            if ($conn->query($sql) === TRUE) {
                echo "<div class='success-message'>Nova pessoa criada com sucesso!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível salvar o registro :(</div>";
            }
        } catch (mysqli_sql_exception $e) {
            if ($e->getCode() == 1062) {
                echo "<div class='error-message'>Erro: CPF ou CRMV já cadastrado!</div>";
            } else {
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
        Bairro: <input type="text" name="bairro" required><br>
        Número: <input type="text" name="numero" required><br>
        Cidade: <input type="text" name="cidade" required><br>
        Estado: <input type="text" name="estado" required><br>
        Rua: <input type="text" name="rua" required><br>
        Complemento: <input type="text" name="complemento"><br>
        Tipo: 
        <select name="tipo" id="tipo" onchange="toggleCRMV()" required >
            <option value="">Selecione o tipo</option>
            <option value="Veterinario">Veterinário</option>
            <option value="Tutor">Tutor</option>
            <option value="Ambos">Ambos</option>
        </select><br>
        CRMV: <input type="text" name="crmv" id="crmv" disabled><br>
        <input type="submit" value="Adicionar Pessoa">
    </form>

    <script>
        function toggleCRMV() {
            var tipo = document.getElementById('tipo').value;
            var crmvField = document.getElementById('crmv');
            if (tipo == 'Veterinario' || tipo == 'Ambos') {
                crmvField.disabled = false;
                crmvField.required = true;
            } else {
                crmvField.disabled = true;
                crmvField.value = ''; // Limpa o campo quando não é necessário
                crmvField.required = false;
            }
        }
    </script>
</body>
</html>
