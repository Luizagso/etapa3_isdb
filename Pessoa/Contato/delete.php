<?php
    include '../../config.php';

    $idContato = $_GET['idContato'];
    $idPessoa = $_GET['idPessoa'];

    $sql = "DELETE FROM Contatos WHERE idContato=$idContato";

    if ($conn->query($sql) === TRUE) {
        $message = "Contato deletado com sucesso!";
        $type = "success";  // Tipo de mensagem é sucesso
    } else {
        $message = "Não foi possível deletar o contato. Por favor, tente novamente.";
        $type = "error";  // Tipo de mensagem é erro
    }

    $conn->close();

    // Redireciona de volta para a página de detalhes da pessoa
    header("Location: ../visualizar.php?idPessoa=$idPessoa&message=". urlencode($message) . "&type=" . $type);
    exit();
?>
