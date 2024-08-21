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
                //echo $e->getMessage();
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
        Nome: <input type="text" name="nome" required  maxlength="60"><br>
        CPF: <input type="text" id="cpf" name="cpf" required onkeyup="aplicarMascaraCPF(this)" maxlength="14"><br>
        Bairro: <input type="text" name="bairro" required maxlength="60"><br>
        Número: <input type="number" name="numero" required><br>
        Cidade: <input type="text" name="cidade" required maxlength="60"><br>
        Estado: <input type="text" name="estado" required maxlength="60"><br>
        Rua: <input type="text" name="rua" required maxlength="60"><br>
        Complemento: <input type="text" name="complemento" maxlength="60"><br>
        Tipo: 
        <select name="tipo" id="tipo" onchange="toggleCRMV()" required >
            <option value="">Selecione o tipo</option>
            <option value="Veterinario">Veterinário</option>
            <option value="Tutor">Tutor</option>
            <option value="Ambos">Ambos</option>
        </select><br>
        CRMV: <input type="text" name="crmv" id="crmv" disabled maxlength="20"><br>
        <input type="submit" value="Adicionar Pessoa">
    </form>

    <script>
        function aplicarMascaraCPF(campo) {
            var cpf = campo.value.replace(/\D/g, ""); // Remove qualquer caractere não numérico
            // Limita o CPF a 11 dígitos
            if (cpf.length > 11) {
                cpf = cpf.substring(0, 11);
            }
            // Aplica a máscara
            cpf = cpf.replace(/(\d{3})(\d)/, "$1.$2");
            cpf = cpf.replace(/(\d{3})(\d)/, "$1.$2");
            cpf = cpf.replace(/(\d{3})(\d{1,2})$/, "$1-$2");
            campo.value = cpf;
        }

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
