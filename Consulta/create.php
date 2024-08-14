<?php
    include '../config.php';

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $idAnimal = $_POST['idAnimal'];
        $dataConsulta = $_POST['dataConsulta'];
        $idPessoa = $_POST['idPessoa'];
        $dataRealRetorno = $_POST['dataRealRetorno'];
        $dataLimiteRetorno = $_POST['dataLimiteRetorno'];

        try {
            $sql = "INSERT INTO Consulta (idAnimal, dataConsulta, idPessoa, dataRealRetorno, dataLimiteRetorno)
                    VALUES ('$idAnimal', '$dataConsulta', '$idPessoa', '$dataRealRetorno', '$dataLimiteRetorno')";

            if ($conn->query($sql) === TRUE) {
                echo "<div class='success-message'>Nova consulta criada com sucesso!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível salvar o registro :(</div>";
            }

        } catch (mysqli_sql_exception $e) {
            echo "<div class='error-message'>Erro ao tentar criar a consulta: " . $e->getMessage() . "</div>";
        }

        $conn->close();
    }
?>

<!DOCTYPE html>
<html>
<head>
    <title>Adicionar Consulta</title>
    <link rel="stylesheet" type="text/css" href="../styles.css">
</head>
<body>
    <div class="navbar">
        <a href="../Pessoa/index.php">Pessoa</a>
        <a href="../Animal/index.php">Animal</a>
        <a href="../Exame/index.php">Exame</a>
        <a href="../Medicamento/index.php">Medicamento</a>
        <a href="index.php">Consulta</a>
    </div>
    <h2>Adicionar Consulta</h2>
    <form method="post" action="">
        <label for="idAnimal">Animal:</label>
        <select name="idAnimal" required>
            <option value="">Selecione o Animal</option>
            <?php
                $sql = "SELECT idAnimal, nome FROM Animal";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        echo "<option value='" . $row['idAnimal'] . "'>" . $row['nome'] . "</option>";
                    }
                } else {
                    echo "<option value=''>Nenhum animal disponível</option>";
                }
            ?>
        </select><br>

        <label for="dataConsulta">Data da Consulta:</label>
        <input type="datetime-local" name="dataConsulta" required><br>

        <label for="idPessoa">Veterinário:</label>
        <select name="idPessoa" required>
            <option value="">Selecione o Veterinário</option>
            <?php
                $sql = "SELECT idPessoa, nome FROM Pessoa WHERE tipo = 'Veterinario'";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        echo "<option value='" . $row['idPessoa'] . "'>" . $row['nome'] . "</option>";
                    }
                } else {
                    echo "<option value=''>Nenhum veterinário disponível</option>";
                }
            ?>
        </select><br>

        <label for="dataRealRetorno">Data Real de Retorno:</label>
        <input type="datetime-local" name="dataRealRetorno"><br>

        <label for="dataLimiteRetorno">Data Limite de Retorno:</label>
        <input type="datetime-local" name="dataLimiteRetorno" required><br>

        <input type="submit" value="Adicionar Consulta">
    </form>
</body>
</html>
