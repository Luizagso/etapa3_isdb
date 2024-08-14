<?php
    include '../config.php';
    $sql = "SELECT * FROM Pessoa";
    $result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Lista de Pessoas</title>
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

    <?php
        $message = isset($_GET['message']) ? $_GET['message'] : '';
        $type = isset($_GET['type']) ? $_GET['type'] : '';

        if ($message) {
            $class = ($type === 'success') ? 'success-message' : 'error-message';
            echo "<div class='$class'>$message</div>";
        }
    ?>

    <h2>Lista de Pessoas</h2>
    <button><a href="create.php">Adicionar Nova Pessoa</a></button>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>CPF</th>
            <th>CRMV</th>
            <th>Bairro</th>
            <th>Número</th>
            <th>Cidade</th>
            <th>Estado</th>
            <th>Rua</th>
            <th>Complemento</th>
            <th>Tipo</th>
            <th>Ações</th>
        </tr>
        <?php
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                echo "<tr>";
                echo "<td>" . $row["idPessoa"]. "</td>";
                echo "<td>" . $row["nome"]. "</td>";
                echo "<td>" . $row["CPF"]. "</td>";
                echo "<td>" . $row["CRMV"]. "</td>";
                echo "<td>" . $row["bairro"]. "</td>";
                echo "<td>" . $row["numero"]. "</td>";
                echo "<td>" . $row["cidade"]. "</td>";
                echo "<td>" . $row["estado"]. "</td>";
                echo "<td>" . $row["rua"]. "</td>";
                echo "<td>" . $row["complemento"]. "</td>";
                echo "<td>" . $row["tipo"]. "</td>";
                echo "<td><a href='update.php?idPessoa=" . $row["idPessoa"] . "'>Editar</a> | ";
                echo "<a href='#' onclick='confirmDelete(" . $row["idPessoa"] . ")'>Deletar</a> | ";
                echo "<a href='visualizar.php?idPessoa= " . $row["idPessoa"] . " '>Visualizar</a> </td>";
                echo "</tr>";
            }
        } else {
            echo "<tr><td colspan='12'>Nenhuma pessoa encontrada</td></tr>";
        }
        ?>
    </table>

    <!-- Modal de Confirmação -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <p>Tem certeza que deseja deletar esta pessoa?</p>
            <a id="confirmDeleteButton" href="#" class="modal-button">Sim</a>
            <button class="cancel-button" onclick="closeModal()">Cancelar</button>
        </div>
    </div>

    <script>
        function confirmDelete(idPessoa) {
            var modal = document.getElementById("deleteModal");
            var confirmButton = document.getElementById("confirmDeleteButton");
            confirmButton.href = "delete.php?idPessoa=" + idPessoa;
            modal.style.display = "block";
        }

        function closeModal() {
            var modal = document.getElementById("deleteModal");
            modal.style.display = "none";
        }

        // Fecha o modal se o usuário clicar fora dele
        window.onclick = function(event) {
            var modal = document.getElementById("deleteModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>

<?php
    $conn->close();
?>
