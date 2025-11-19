<?php

    include 'connection.php';

    $sql = "SELECT "FROM feed:;
    $run = mysqli_query($con, $sql);

    if(mysqli_num_rows($run)>0){

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <div class="boxcontainer">
            <table>
                <tr>
                    <th>Username</th>
                    <th>Posts</th>
                </tr>
                <?php while($row  mysqli_fetch_assoc($run)){ ?>
                    <tr>
                        <td><?php echo $row['username'] ?></td>
                        <td><?= $row['posts'] ?></td>
                    </tr>
                <?php} ?>
            </table>
            <?php} ?>
        </div>
    </div>
</body>
</html>