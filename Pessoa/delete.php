<?php
    include '../config.php';

    $idPessoa = $_GET['idPessoa'];

    try {
        // Tentativa de exclusão da pessoa
        $sql = "DELETE FROM Pessoa WHERE idPessoa=$idPessoa";

        if ($conn->query($sql) === TRUE) {
            $message = "Pessoa deletada com sucesso!";
            $type = "success";  // Tipo de mensagem é sucesso
        } else {
            $message = "Não foi possível deletar a pessoa. Por favor, tente novamente.";
            $type = "error";  // Tipo de mensagem é erro
        }

    } catch (Exception $e) {
        // Mensagem genérica para exibição ao usuário
        $message = "Erro ao tentar deletar a pessoa. Por favor, verifique se a pessoa pode ser deletada.";
        $type = "error";  // Tipo de mensagem é erro
    }

    $conn->close();

    // Redireciona para a página de lista com a mensagem e tipo de mensagem
    header("Location: index.php?message=" . urlencode($message) . "&type=" . $type);
    exit();
?>
