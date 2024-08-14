<?php
    include '../config.php';

    $idAnimal = $_GET['idAnimal'];

    try {
        // Tentativa de exclusão do animal
        $sql = "DELETE FROM Animal WHERE idAnimal=$idAnimal";

        if ($conn->query($sql) === TRUE) {
            $message = "Animal deletado com sucesso!";
            $type = "success";  // Tipo de mensagem é sucesso
        } else {
            $message = "Não foi possível deletar o animal. Por favor, tente novamente.";
            $type = "error";  // Tipo de mensagem é erro
        }

    } catch (Exception $e) {
        // Mensagem genérica para exibição ao usuário
        $message = "Erro ao tentar deletar o animal. Por favor, verifique se o animal pode ser deletado.";
        $type = "error";  // Tipo de mensagem é erro
    }

    $conn->close();

    // Redireciona para a página de lista com a mensagem e tipo de mensagem
    header("Location: index.php?message=" . urlencode($message) . "&type=" . $type);
    exit();
?>
