<?php
    include '../config.php';

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $idAnimal = $_POST['idAnimal'];
        $dataConsulta = $_POST['dataConsulta'];
        $idPessoa = $_POST['idPessoa'];
        $dataRealRetorno = !empty($_POST['dataRealRetorno']) ? "'".$_POST['dataRealRetorno']."'" : "NULL"; // Verifica se o campo está vazio
        $dataLimiteRetorno = $_POST['dataLimiteRetorno'];

        try {
            // Monta a consulta SQL
            $sql = "INSERT INTO Consulta (idAnimal, dataConsulta, idPessoa, dataRealRetorno, dataLimiteRetorno)
                    VALUES ('$idAnimal', '$dataConsulta', '$idPessoa', $dataRealRetorno, '$dataLimiteRetorno')";

            if ($conn->query($sql) === TRUE) {
                echo "<div class='success-message'>Nova consulta criada com sucesso!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível salvar o registro :(</div>";
            }

        } catch (mysqli_sql_exception $e) {
            echo $e->getMessage();
            echo "<div class='error-message'>Não foi possível salvar o registro. Verifique se essa consulta pode ser cadastrada ou se os campos estão preenchidos corretamente.</div>";
        }
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
        <input type="datetime-local" name="dataConsulta" id="dataConsulta" required oninput="calcularDataLimite()"><br>

        <label for="idPessoa">Veterinário:</label>
        <select name="idPessoa" required>
            <option value="">Selecione o Veterinário</option>
            <?php
                $sql = "SELECT idPessoa, nome FROM Pessoa WHERE tipo = 'Veterinario' OR tipo = 'Ambos'";
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
        <input type="date" name="dataLimiteRetorno" id="dataLimiteRetorno" readonly required><br>
        <small class="info-text">Esse valor corresponde a 30 dias após a data da consulta.</small><br>

        <input type="submit" value="Adicionar Consulta">
    </form>

    <script>
        function calcularDataLimite() {
            // Obtém a data da consulta
            var dataConsulta = document.getElementById('dataConsulta').value;

            // Verifica se a data da consulta foi inserida
            if (dataConsulta) {
                // Cria um objeto Date a partir da data da consulta
                var data = new Date(dataConsulta);

                // Adiciona 30 dias
                data.setDate(data.getDate() + 30);

                // Formata a data para o formato 'YYYY-MM-DD'
                var dataFormatada = data.toISOString().split('T')[0];

                // Define a data no campo de data limite
                document.getElementById('dataLimiteRetorno').value = dataFormatada;
            }
        }
    </script>

</body>
</html>
