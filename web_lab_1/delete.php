<?php

    include 'connection.php';

    $id = $_GET['id'];

    $sql = "DELETE FROM user WHERE id = '$id'";
    
    $run = mysqli_query($con, $sql);

    if(!$run){
        echo 'delete operation failed!';
    } else{
        header("location: display.php");
    }

?>