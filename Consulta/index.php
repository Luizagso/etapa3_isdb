<?php
    include '../config.php';

    $sql = "SELECT Consulta.*, Animal.nome AS animal_nome, Pessoa.nome AS veterinario_nome, Tutor.nome AS tutor_nome 
        FROM Consulta 
        JOIN Animal ON Consulta.idAnimal = Animal.idAnimal
        JOIN Pessoa ON Consulta.idPessoa = Pessoa.idPessoa
        JOIN Pessoa AS Tutor ON Animal.idPessoa = Tutor.idPessoa";
    $result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Lista de Consultas</title>
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

    <?php
        $message = isset($_GET['message']) ? $_GET['message'] : '';
        $type = isset($_GET['type']) ? $_GET['type'] : '';

        if ($message) {
            $class = ($type === 'success') ? 'success-message' : 'error-message';
            echo "<div class='$class'>$message</div>";
        }
    ?>

    <h2>Lista de Consultas</h2>
    <button><a href="create.php">Adicionar Nova Consulta</a></button>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Animal</th>
            <th>Tutor</th>
            <th>Data da Consulta</th>
            <th>Veterinário</th>
            <th>Data Real de Retorno</th>
            <th>Data Limite de Retorno</th>
            <th>Ações</th>
        </tr>
        <?php
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {

                    // Verifica se a data real de retorno é nula e substitui por 'Não informado'
                    $dataRealRetorno = (!empty($row["dataRealRetorno"]) || !$row["dataRealRetorno"] == '' ) ? $row["dataRealRetorno"] : 'Não informado';

                    echo "<tr>";
                    echo "<td>" . $row["idConsulta"] . "</td>";
                    echo "<td>" . $row["animal_nome"] . "</td>";
                    echo "<td>" . $row["tutor_nome"] . "</td>";
                    echo "<td>" . $row["dataConsulta"] . "</td>";
                    echo "<td>" . $row["veterinario_nome"] . "</td>";
                    echo "<td>" . $dataRealRetorno . "</td>";
                    echo "<td>" . $row["dataLimiteRetorno"] . "</td>";
                    echo "<td><a href='update.php?idConsulta=" . $row["idConsulta"] . "'>Editar</a> | ";
                    echo "<a href='#' onclick='confirmDelete(" . $row["idConsulta"] . ")'>Deletar</a> | ";
                    echo "<a href='visualizar.php?idConsulta= " . $row["idConsulta"] . " '>Visualizar</a> </td>";
                    echo "</tr>";
                }
            } else {
                echo "<tr><td colspan='7'>Nenhuma consulta encontrada</td></tr>";
            }
            $conn->close();
        ?>
    </table>

    <!-- Modal de Confirmação -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <p>Tem certeza que deseja deletar esta consulta?</p>
            <a id="confirmDeleteButton" href="#" class="modal-button">Sim</a>
            <button class="cancel-button" onclick="closeModal()">Cancelar</button>
        </div>
    </div>

    <script>
        function confirmDelete(idConsulta) {
            var modal = document.getElementById("deleteModal");
            var confirmButton = document.getElementById("confirmDeleteButton");
            confirmButton.href = "delete.php?idConsulta=" + idConsulta;
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
