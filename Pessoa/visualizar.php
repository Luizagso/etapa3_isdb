<?php
    include '../config.php';

    $idPessoa = $_GET['idPessoa'];

    // Consulta SQL para buscar os detalhes da pessoa
    $sql = "SELECT p.*, COUNT(a.idAnimal) AS quantidade_animais FROM Pessoa p LEFT JOIN Animal a ON 
                p.idPessoa = a.idPessoa WHERE p.idPessoa = $idPessoa";
    $result = $conn->query($sql);
    $pessoa = $result->fetch_assoc();

    // Consulta SQL para buscar os contatos da pessoa
    $sql_contatos = "SELECT * FROM Contatos WHERE idPessoa = $idPessoa";
    $result_contatos = $conn->query($sql_contatos);

    $conn->close(); 
?>

<!DOCTYPE html>
<html>
<head>
    <title>Detalhes da Pessoa</title>
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
    <div class="container">

        <?php
            $message = isset($_GET['message']) ? $_GET['message'] : '';
            $type = isset($_GET['type']) ? $_GET['type'] : '';

            if ($message) {
                $class = ($type === 'success') ? 'success-message' : 'error-message';
                echo "<div class='$class'>$message</div>";
            }
        ?>

        <h2>Detalhes da Pessoa</h2>

        <?php if ($pessoa): ?>
        <table border="1">
            <tr hidden>
                <th>ID da Pessoa</th>
                <td><?php echo $pessoa['idPessoa']; ?></td>
            </tr>
            <tr>
                <th>Nome</th>
                <td><?php echo $pessoa['nome']; ?></td>
            </tr>
            <tr>
                <th>CPF</th>
                <td><?php echo $pessoa['CPF']; ?></td>
            </tr>
            <?php
                if($pessoa['tipo'] != 'Tutor'){
            ?>
                <tr>
                    <th>CRMV</th>
                    <td><?php echo $pessoa['CRMV']; ?></td>
                </tr>
            <?php
                }
            ?>
            <tr>
                <th>Bairro</th>
                <td><?php echo $pessoa['bairro']; ?></td>
            </tr>
            <tr>
                <th>Número</th>
                <td><?php echo $pessoa['numero']; ?></td>
            </tr>
            <tr>
                <th>Cidade</th>
                <td><?php echo $pessoa['cidade']; ?></td>
            </tr>
            <tr>
                <th>Estado</th>
                <td><?php echo $pessoa['estado']; ?></td>
            </tr>
            <tr>
                <th>Rua</th>
                <td><?php echo $pessoa['rua']; ?></td>
            </tr>
            <tr>
                <th>Complemento</th>
                <td><?php echo $pessoa['complemento']; ?></td>
            </tr>
            <tr>
                <th>Tipo</th>
                <td><?php echo $pessoa['tipo']; ?></td>
            </tr>
            <?php if ($pessoa['quantidade_animais'] != 0) { ?>
                <tr>
                    <th>Quantidade de Animais</th>
                    <td><?php echo $pessoa['quantidade_animais']; ?></td>
                </tr>
            <?php } ?>
        </table>

        <hr>

        <!-- Seção de Contatos -->
        <h3>Contatos</h3>
        <?php if ($result_contatos->num_rows > 0): ?>
            <table border="1">
                <tr>
                    <th>Telefone</th>
                    <th>Email</th>
                    <th>Ações</th>
                </tr>
                <?php while($contato = $result_contatos->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $contato['telefone']; ?></td>
                    <td><?php echo $contato['email']; ?></td>
                    <td><a href='#' onclick='confirmDelete(<?php echo $contato["idContato"]; ?>, <?php echo $contato["idPessoa"]; ?>)'>Deletar</a></td>
                </tr>
                <?php endwhile; ?>
            </table>
        <?php else: ?>
            <p>Nenhum contato encontrado.</p>
        <?php endif; ?>

        <button onclick="openModal('contatoModal')"><a href="#">Adicionar Contato</a></button>

        <?php else: ?>
        <p>Pessoa não encontrada.</p>
        <?php endif; ?>
    </div>

    <!-- Modal para Adicionar Contato -->
    <div id="contatoModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('contatoModal')">&times;</span>
            <p>Seção de Contatos ainda em construção</p>
        </div>
    </div>

    <!-- Modal de Confirmação -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('deleteModal')">&times;</span>
            <p>Tem certeza que deseja deletar este contato?</p>
            <a id="confirmDeleteButton" href="#" class="modal-button" onclick='confirmDelete(<?php echo $contato["idContato"]; ?>, <?php echo $contato["idPessoa"]; ?>)'>Sim</a>
            <button class="cancel-button" onclick="closeModal('deleteModal')">Cancelar</button>
        </div>
    </div>

    <script>
        // Função para abrir o modal
        function openModal(modalId) {
            document.getElementById(modalId).style.display = "block";
        }

        function closeModal(modalId) {
            document.getElementById(modalId).style.display = "none";
        }

        // Fecha o modal se o usuário clicar fora dele
        window.onclick = function(event) {
            // Obtém todos os modais na página
            var modals = document.getElementsByClassName('modal');
            // Verifica cada modal para ver se o clique foi fora dele
            for (var i = 0; i < modals.length; i++) {
                if (event.target == modals[i]) {
                    modals[i].style.display = "none";
                }
            }
        }

        function confirmDelete(idContato, idPessoa) {
            var modal = document.getElementById("deleteModal");
            var confirmButton = document.getElementById("confirmDeleteButton");
            confirmButton.href = "Contato/delete.php?idContato=" + idContato + "&idPessoa=" + idPessoa;;
            modal.style.display = "block";
        }
    </script>
</body>
</html>
