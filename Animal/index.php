<?php
    include '../config.php';
    $sql = "SELECT Animal.*, Pessoa.nome AS tutor_nome 
            FROM Animal 
            JOIN Pessoa ON Animal.idPessoa = Pessoa.idPessoa
            ORDER BY Animal.nome";
    $result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Lista de Animais</title>
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

    <?php
        $message = isset($_GET['message']) ? $_GET['message'] : '';
        $type = isset($_GET['type']) ? $_GET['type'] : '';

        if ($message) {
            $class = ($type === 'success') ? 'success-message' : 'error-message';
            echo "<div class='$class'>$message</div>";
        }
    ?>

    <h2>Lista de Animais</h2>
    <button><a href="create.php">Adicionar Novo Animal</a></button>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Registro</th>
            <th>Nome</th>
            <th>Nascimento</th>
            <th>Raça</th>
            <th>Espécie</th>
            <th>Sexo</th>
            <th>Tutor</th>
            <th>Ações</th>
        </tr>
        <?php
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {

                // Formata a data de nascimento
                $dataNasc = date('d/m/Y', strtotime($row["dataNasc"]));

                echo "<tr>";
                echo "<td>" . $row["idAnimal"]. "</td>";
                echo "<td>" . $row["registro"]. "</td>";
                echo "<td>" . $row["nome"]. "</td>";
                echo "<td>" . $dataNasc. "</td>";
                echo "<td>" . $row["raca"]. "</td>";
                echo "<td>" . $row["especie"]. "</td>";
                echo "<td>" . $row["sexo"]. "</td>";
                echo "<td>" . $row["tutor_nome"]. "</td>";
                echo "<td><a href='update.php?idAnimal=" . $row["idAnimal"] . "'>Editar</a> | ";
                echo "<a href='#' onclick='confirmDelete(" . $row["idAnimal"] . ")'>Deletar</a></td>";
                echo "</tr>";
            }
        } else {
            echo "<tr><td colspan='12'>Nenhum animal encontrado</td></tr>";
        }
        ?>
    </table>

    <!-- Modal de Confirmação -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <p>Tem certeza que deseja deletar este animal?</p>
            <a id="confirmDeleteButton" href="#" class="modal-button">Sim</a>
            <button class="cancel-button" onclick="closeModal()">Cancelar</button>
        </div>
    </div>

    <script>
        function confirmDelete(idAnimal) {
            var modal = document.getElementById("deleteModal");
            var confirmButton = document.getElementById("confirmDeleteButton");
            confirmButton.href = "delete.php?idAnimal=" + idAnimal;
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
