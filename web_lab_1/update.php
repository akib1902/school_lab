<?php

    include 'connection.php';

    $id = $_GET["id"];
    
    $sql = "SELECT * FROM user WHERE id='$id'";

    $run =  mysqli_query($con, $sql);
    $row = mysqli_fetch_assoc($run);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <?php include 'nav.html' ?>
    <div class="container">
        <form action="insert.php" method="post" id="form">
            <input type="text" name="uname" id="uname" value="<?= $row['uname'] ?>" size="30">
            <br><br>
            <textarea name="posts" id="posts" rows="5" cols="36"><?= $row['posts'] ?></textarea>
            <br><br>
            <input type="hidden" value="<?= $row['id'] ?>" name="id">
            <input type="submit" value="UPDATE">
        </form>
    </div>
</body>
</html>