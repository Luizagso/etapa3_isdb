<?php
    include '../config.php';

    $idConsulta = $_GET['idConsulta'];

    try {
        $sql = "DELETE FROM Consulta WHERE idConsulta=$idConsulta";

        if ($conn->query($sql) === TRUE) {
            $message = "Consulta deletada com sucesso!";
            $type = "success";
        } else {
            $message = "Não foi possível deletar a consulta. Por favor, tente novamente.";
            $type = "error";
        }

    } catch (Exception $e) {
        $message = "Erro ao tentar deletar a consulta. Por favor, verifique se a consulta pode ser deletada.";
        $type = "error";
    }

    $conn->close();
    header("Location: index.php?message=" . urlencode($message) . "&type=" . $type);
    exit();
?>
