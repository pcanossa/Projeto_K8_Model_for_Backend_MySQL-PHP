<?php
$servername = "mysql-connection";
$username = "cmtAdmin";
$password = "PassWdAdm1n*";
$database = "COMENTARIOS";

// Criar conexão


$link = new mysqli($servername, $username, $password, $database);

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

?>
