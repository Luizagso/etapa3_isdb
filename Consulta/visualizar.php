<?php
include '../config.php';

$idConsulta = $_GET['idConsulta'];

// Consulta SQL para buscar os detalhes da consulta, animal, veterinário e tutor
$sql = "SELECT Consulta.*, Animal.nome AS animal_nome, Pessoa.nome AS veterinario_nome, Tutor.nome AS tutor_nome 
        FROM Consulta 
        JOIN Animal ON Consulta.idAnimal = Animal.idAnimal
        JOIN Pessoa ON Consulta.idPessoa = Pessoa.idPessoa
        JOIN Pessoa AS Tutor ON Animal.idPessoa = Tutor.idPessoa
        WHERE Consulta.idConsulta = $idConsulta";

$result = $conn->query($sql);
$consulta = $result->fetch_assoc();
$conn->close(); 
?>

<!DOCTYPE html>
<html>
<head>
    <title>Detalhes da Consulta</title>
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
    <div class="container">
        <h2>Detalhes da Consulta</h2>

        <?php if ($consulta): ?>
        <table border="1">
            <tr>
                <th>ID da Consulta</th>
                <td><?php echo $consulta['idConsulta']; ?></td>
            </tr>
            <tr>
                <th>Animal</th>
                <td><?php echo $consulta['animal_nome']; ?></td>
            </tr>
            <tr>
                <th>Tutor do Animal</th>
                <td><?php echo $consulta['tutor_nome']; ?></td>
            </tr>
            <tr>
                <th>Data da Consulta</th>
                <td><?php echo date('d/m/Y H:i', strtotime($consulta["dataConsulta"])); ?></td>
            </tr>
            <tr>
                <th>Veterinário</th>
                <td><?php echo $consulta['veterinario_nome']; ?></td>
            </tr>
            <tr>
                <th>Data Real de Retorno</th>
                <td><?php echo (!empty($consulta["dataRealRetorno"]) && $consulta["dataRealRetorno"] != '0000-00-00 00:00:00') ? date('d/m/Y H:i', strtotime($consulta["dataRealRetorno"])) : 'Não informado'; ?></td>
            </tr>
            <tr>
                <th>Data Limite de Retorno</th>
                <td><?php echo date('d/m/Y', strtotime($consulta["dataLimiteRetorno"])); ?></td>
            </tr>
        </table>

        <hr>

        <!-- Seção de Exames Solicitados -->
        <h3>Exames Solicitados</h3>
        <p>Em construção :O</p>
        <button onclick="openModal('exameModal')"><a href="#">Inserir Solicitação de Exame</a></button>

        <hr>
        <!-- Seção de Medicamentos Prescritos -->
        <h3>Medicamentos Prescritos</h3>
        <p>Em construção :O</p>
        <button onclick="openModal('medicamentoModal')"><a href="#">Inserir Prescrição de Medicamento</a></button>

        <?php else: ?>
        <p>Consulta não encontrada.</p>
        <?php endif; ?>
    </div>

    <!-- Modal para Exames -->
    <div id="exameModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('exameModal')">&times;</span>
            <p>Seção de Exames ainda em construção</p>
        </div>
    </div>

    <!-- Modal para Medicamentos -->
    <div id="medicamentoModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('medicamentoModal')">&times;</span>
            <p>Seção de Medicamentos ainda em construção</p>
        </div>
    </div>

    <script>
        // Função para abrir o modal
        function openModal(modalId) {
            document.getElementById(modalId).style.display = "block";
        }

        // Função para fechar o modal
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = "none";
        }

        // Fecha o modal se o usuário clicar fora dele
        window.onclick = function(event) {
            var exameModal = document.getElementById('exameModal');
            var medicamentoModal = document.getElementById('medicamentoModal');
            if (event.target == exameModal) {
                exameModal.style.display = "none";
            }
            if (event.target == medicamentoModal) {
                medicamentoModal.style.display = "none";
            }
        }
    </script>
</body>
</html>
