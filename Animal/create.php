<?php
    include '../config.php';

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $idPessoa = $_POST['idPessoa'];
        $registro = $_POST['registro'];
        $dataNasc = $_POST['dataNasc'];
        $nome = $_POST['nome'];
        $raca = $_POST['raca'];
        $especie = $_POST['especie'];
        $sexo = $_POST['sexo'];

        try {
            $sql = "INSERT INTO Animal (idPessoa, registro, dataNasc, nome, raca, especie, sexo)
                    VALUES ('$idPessoa', '$registro', '$dataNasc', '$nome', '$raca', '$especie', '$sexo')";

            if ($conn->query($sql) === TRUE) {
                echo "<div class='success-message'>Novo animal criado com sucesso!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível salvar o registro :(</div>";
            }

        } catch (mysqli_sql_exception $e) {
            if ($e->getCode() == 1062) {
                echo "<div class='error-message'>Erro: Registro do animal já cadastrado!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível salvar o registro :(</div>";
            }
        }
    }
?>

<!DOCTYPE html>
<html>
<head>
    <title>Adicionar Animal</title>
    <link rel="stylesheet" type="text/css" href="../styles.css">
</head>
<body>
    <div class="navbar">
        <a href="../Pessoa/index.php">Pessoa</a>
        <a href="index.php">Animal</a>
        <a href="../Exame/index.php">Exame</a>
        <a href="../Medicamento/index.php">Medicamento</a>
        <a href="../Consulta/index.php">Consulta</a>
    </div>
    <h2>Adicionar Animal</h2>

    <form method="post" action="">
        <label for="idPessoa">Tutor:</label>
        <select name="idPessoa" required>
            <option value="">Selecione o Tutor</option>
            <?php
                $sql = "SELECT idPessoa, nome FROM Pessoa";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        echo "<option value='" . $row['idPessoa'] . "'>" . $row['nome'] . "</option>";
                    }
                } else {
                    echo "<option value=''>Nenhum tutor disponível</option>";
                }
            ?>
        </select><br>

        <label for="registro">Registro:</label>
        <input type="text" name="registro" required><br>

        <label for="dataNasc">Data de Nascimento:</label>
        <input type="date" name="dataNasc" required><br>

        <label for="nome">Nome:</label>
        <input type="text" name="nome" required><br>

        <label for="raca">Raça:</label>
        <input type="text" name="raca" required><br>

        <label for="especie">Espécie:</label>
        <input type="text" name="especie" required><br>

        <label for="sexo">Sexo:</label>
        <select name="sexo" required>
            <option value="Macho">Macho</option>
            <option value="Fêmea">Fêmea</option>
        </select><br>

        <input type="submit" value="Adicionar Animal">
    </form>
</body>
</html>
