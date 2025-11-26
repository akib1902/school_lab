<?php
    include 'nav.html';
    include 'connection.php';

    $sql = "SELECT * FROM user";
    $run = mysqli_query($con, $sql);

    if(mysqli_num_rows($run) > 0){

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
    <div class="container">
        <?php while($row = mysqli_fetch_assoc($run)){ ?>
            <div class="card">
                <h4><?= $row['uname'] ?></h4>
                <p><?= $row['posts'] ?></p> <br>
                <a style="color:blue" href="update.php?id=<?= $row['id'] ?>">Update</a> |
                    <a style="color:blue" href="delete.php?id=<?= $row['id'] ?>">Delete</a>
            </div>
        <?php } } ?>
    </div>
</body>
</html>