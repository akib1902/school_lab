<?php

    include 'connection.php';

    $un = $_POST['uname'];
    $posts = $_POST['posts'];

    $sql = "INSERT INTO user(uname, posts) VALUES('$un', '$posts')";

    $run = mysqli_query($con, $sql);

    if(!$run){
        echo "submission failed!";
    } else{
        header("location: display.php");
    }

?>