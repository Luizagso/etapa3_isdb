<?php
    include '../config.php';

    $idPessoa = $_GET['idPessoa'];
        
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
        $sql = "UPDATE Pessoa SET 
                    nome='$nome', 
                    CPF='$cpf', 
                    bairro='$bairro', 
                    numero='$numero', 
                    cidade='$cidade', 
                    estado='$estado', 
                    rua='$rua', 
                    complemento='$complemento', 
                    tipo='$tipo'";

        // Se o CRMV for preenchido, inclui-o na consulta
        if (isset($_POST['crmv']) && !empty($_POST['crmv'])) {
            $crmv = $_POST['crmv'];
            $sql .= ", CRMV='$crmv'";
        } else {
            // Caso contrário, define CRMV como NULL
            $sql .= ", CRMV=NULL";
        }

        $sql .= " WHERE idPessoa=$idPessoa";

        try {
            if ($conn->query($sql) === TRUE) {
                echo "<div class='success-message'>Pessoa atualizada com sucesso!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível atualizar o registro :(</div>";
            }

        } catch (mysqli_sql_exception $e) {
            if ($e->getCode() == 1062) {
                echo "<div class='error-message'>Erro: CPF ou CRMV já cadastrado!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível atualizar o registro :(</div>";
            }
        }
    }

    $sql = "SELECT * FROM Pessoa WHERE idPessoa=$idPessoa";
    $result = $conn->query($sql);
    $row = $result->fetch_assoc();

    $conn->close(); 
?>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Pessoa</title>
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

    <h2>Editar Pessoa</h2>
    <form method="post" action="">
        Nome: <input type="text" name="nome" value="<?php echo $row['nome']; ?>" required><br>
        CPF: <input type="text" name="cpf" value="<?php echo $row['CPF']; ?>" required><br>
        Bairro: <input type="text" name="bairro" value="<?php echo $row['bairro']; ?>" required><br>
        Número: <input type="text" name="numero" value="<?php echo $row['numero']; ?>" required><br>
        Cidade: <input type="text" name="cidade" value="<?php echo $row['cidade']; ?>" required><br>
        Estado: <input type="text" name="estado" value="<?php echo $row['estado']; ?>" required><br>
        Rua: <input type="text" name="rua" value="<?php echo $row['rua']; ?>" required><br>
        Complemento: <input type="text" name="complemento" value="<?php echo $row['complemento']; ?>"><br>
        Tipo: 
        <select name="tipo" id="tipo" onchange="toggleCRMV()">
            <option value="Veterinario" <?php if ($row['tipo'] == 'Veterinario') echo 'selected'; ?>>Veterinário</option>
            <option value="Tutor" <?php if ($row['tipo'] == 'Tutor') echo 'selected'; ?>>Tutor</option>
            <option value="Ambos" <?php if ($row['tipo'] == 'Ambos') echo 'selected'; ?>>Ambos</option>
        </select><br>
        CRMV: <input type="text" id="crmv" name="crmv" value="<?php echo $row['CRMV']; ?>"><br>
        <input type="submit" value="Atualizar Pessoa">
    </form>

    <script>
        function toggleCRMV() {
            var tipo = document.getElementById('tipo').value;
            var crmvField = document.getElementById('crmv');
            if (tipo === 'Veterinario' || tipo === 'Ambos') {
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
