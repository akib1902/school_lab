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
        <form action="code.php" method="post" id="form">
            <input type="text" name="uname" id="uname" placeholder="enter your username" size="30">
            <br><br>
            <textarea name="posts" id="posts" rows="5" cols="36" placeholder="what's on your mind?"></textarea>
            <br><br>
            <input type="submit" value="POST">
        </form>
    </div>
</body>
</html>