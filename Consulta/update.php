<?php
    include '../config.php';

    $idConsulta = $_GET['idConsulta'];

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $idAnimal = $_POST['idAnimal'];
        $dataConsulta = $_POST['dataConsulta'];
        $idPessoa = $_POST['idPessoa'];
        $dataRealRetorno = $_POST['dataRealRetorno'];
        $dataLimiteRetorno = $_POST['dataLimiteRetorno'];

        try {
            $sql = "UPDATE Consulta SET 
                        idAnimal='$idAnimal', 
                        dataConsulta='$dataConsulta', 
                        idPessoa='$idPessoa', 
                        dataRealRetorno='$dataRealRetorno', 
                        dataLimiteRetorno='$dataLimiteRetorno'
                    WHERE idConsulta=$idConsulta";
    
            if ($conn->query($sql) === TRUE) {
                echo "<div class='success-message'>Consulta atualizada com sucesso!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível atualizar o registro :(</div>";
            }
        
        } catch (mysqli_sql_exception $e) {
            echo "<div class='error-message'>Erro ao tentar atualizar a consulta: " . $e->getMessage() . "</div>";
        }
    }

    // Buscar os dados da consulta atual
    $sql = "SELECT * FROM Consulta WHERE idConsulta=$idConsulta";
    $result = $conn->query($sql);
    $row = $result->fetch_assoc();
    $conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Consulta</title>
    <link rel="stylesheet" type="text/css" href="../styles.css">
</head>
<body>
    <div class="navbar">
        <a href="../Pessoa/index.php">Pessoa</a>
        <a href="../Animal/index.php">Animal</a>
        <a href="../Exame/index.php">Exame</a>
        <a href="../Medicamento/index.php">Medicamento</a>
        <a href="index.php">Consulta</a>lta</a>
    </div>

    <h2>Editar Consulta</h2>
    <form method="post" action="">
        <label for="idAnimal">Animal:</label>
        <select name="idAnimal" required>
            <?php
            include '../config.php';
            $sql = "SELECT idAnimal, nome FROM Animal";
            $resultAnimals = $conn->query($sql);

            if ($resultAnimals->num_rows > 0) {
                while($animal = $resultAnimals->fetch_assoc()) {
                    $selected = $animal['idAnimal'] == $row['idAnimal'] ? 'selected' : '';
                    echo "<option value='" . $animal['idAnimal'] . "' $selected>" . $animal['nome'] . "</option>";
                }
            } else {
                echo "<option value=''>Nenhum animal disponível</option>";
            }
            $conn->close();
            ?>
        </select><br>

        <label for="dataConsulta">Data da Consulta:</label>
        <input type="datetime-local" name="dataConsulta" value="<?php echo date('Y-m-d\TH:i', strtotime($row['dataConsulta'])); ?>" required><br>

        <label for="idPessoa">Veterinário:</label>
        <select name="idPessoa" required>
            <?php
            include '../config.php';
            $sql = "SELECT idPessoa, nome FROM Pessoa WHERE tipo = 'Veterinario'";
            $resultVets = $conn->query($sql);

            if ($resultVets->num_rows > 0) {
                while($vet = $resultVets->fetch_assoc()) {
                    $selected = $vet['idPessoa'] == $row['idPessoa'] ? 'selected' : '';
                    echo "<option value='" . $vet['idPessoa'] . "' $selected>" . $vet['nome'] . "</option>";
                }
            } else {
                echo "<option value=''>Nenhum veterinário disponível</option>";
            }
            $conn->close();
            ?>
        </select><br>

        <label for="dataRealRetorno">Data Real de Retorno:</label>
        <input type="datetime-local" name="dataRealRetorno" value="<?php echo !empty($row['dataRealRetorno']) ? date('Y-m-d\TH:i', strtotime($row['dataRealRetorno'])) : ''; ?>"><br>

        <label for="dataLimiteRetorno">Data Limite de Retorno:</label>
        <input type="datetime-local" name="dataLimiteRetorno" value="<?php echo date('Y-m-d\TH:i', strtotime($row['dataLimiteRetorno'])); ?>" required><br>

        <input type="submit" value="Atualizar Consulta">
    </form>
</body>
</html>
