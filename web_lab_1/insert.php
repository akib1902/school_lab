<?php

    include 'connection.php';

    $un = $_POST['uname'];
    $posts = $_POST['posts'];
    $id = $_POST['id'];

    $sql = "UPDATE user SET uname = '$un', posts='$posts' 
                WHERE id='$id'";

    $run = mysqli_query($con, $sql);

    if(!$run){
        echo "submission failed!";
    } else{
        header("location: display.php");
    }

?>