<?php
    include 'nav.html';
    include 'connection.php';

    $key = $_GET["search"];

    $sql = "SELECT * FROM user WHERE uname LIKE '%$key%' OR posts LIKE '%$key%'";
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
        <table>
            <tr>
                <th>username</th>
                <th>posts</th>
                <th>Action</th>
            </tr>
            <?php while($row = mysqli_fetch_assoc($run)){ ?>
            <tr>
                <td><?= $row['uname'] ?></td>
                <td><?= $row['posts'] ?></td>
                <td>
                    <a style="color:blue" href="update.php?id=<?= $row['id'] ?>">Update</a>
                    <a style="color:blue" href="delete.php?id=<?= $row['id'] ?>">Delete</a>
                </td>
            </tr>
            <?php } ?>
        </table>
        <?php } ?>
    </div>
</body>
</html>