<?php
    include '../config.php';

    $idAnimal = $_GET['idAnimal'];

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $idPessoa = $_POST['idPessoa']; // ID do tutor selecionado
        $registro = $_POST['registro'];
        $dataNasc = $_POST['dataNasc'];
        $nome = $_POST['nome'];
        $raca = $_POST['raca'];
        $especie = $_POST['especie'];
        $sexo = $_POST['sexo'];

        try {
            $sql = "UPDATE Animal SET 
                        idPessoa='$idPessoa', 
                        registro='$registro', 
                        dataNasc='$dataNasc', 
                        nome='$nome', 
                        raca='$raca', 
                        especie='$especie', 
                        sexo='$sexo'
                    WHERE idAnimal=$idAnimal";
        
            if ($conn->query($sql) === TRUE) {
                echo "<div class='success-message'>Animal atualizado com sucesso!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível atualizar o registro :(</div>";
            }
        
        } catch (mysqli_sql_exception $e) {
            if ($e->getCode() == 1062) {
                echo "<div class='error-message'>Erro: Registro do animal já cadastrado!</div>";
            } else {
                echo "<div class='error-message'>Não foi possível atualizar o registro :(</div>";
            }
        }
    }

    $sql = "SELECT * FROM Animal WHERE idAnimal=$idAnimal";
    $result = $conn->query($sql);
    $row = $result->fetch_assoc();

    $conn->close(); 
?>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Animal</title>
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

    <h2>Editar Animal</h2>
    <form method="post" action="">
        <label for="idPessoa">Tutor:</label>
        <select name="idPessoa" required>
            <?php
                include '../config.php';
                $sql = "SELECT idPessoa, nome FROM Pessoa";
                $resultTutors = $conn->query($sql);

                if ($resultTutors->num_rows > 0) {
                    while($tutor = $resultTutors->fetch_assoc()) {
                        $selected = $tutor['idPessoa'] == $row['idPessoa'] ? 'selected' : '';
                        echo "<option value='" . $tutor['idPessoa'] . "' $selected>" . $tutor['nome'] . "</option>";
                    }
                } else {
                    echo "<option value=''>Nenhum tutor disponível</option>";
                }
            ?>
        </select><br>

        <label for="registro">Registro:</label>
        <input type="text" name="registro" value="<?php echo $row['registro']; ?>" required><br>

        <label for="dataNasc">Data de Nascimento:</label>
        <input type="date" name="dataNasc" value="<?php echo $row['dataNasc']; ?>" required><br>

        <label for="nome">Nome:</label>
        <input type="text" name="nome" value="<?php echo $row['nome']; ?>" required><br>

        <label for="raca">Raça:</label>
        <input type="text" name="raca" value="<?php echo $row['raca']; ?>" required><br>

        <label for="especie">Espécie:</label>
        <input type="text" name="especie" value="<?php echo $row['especie']; ?>" required><br>

        <label for="sexo">Sexo:</label>
        <select name="sexo" required>
            <option value="Macho" <?php if ($row['sexo'] == 'Macho') echo 'selected'; ?>>Macho</option>
            <option value="Fêmea" <?php if ($row['sexo'] == 'Fêmea') echo 'selected'; ?>>Fêmea</option>
        </select><br>

        <input type="submit" value="Atualizar Animal">
    </form>
</body>
</html>
