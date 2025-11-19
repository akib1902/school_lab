<?php
// code.php
ini_set('display_errors', 1);
error_reporting(E_ALL);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $uname = $_POST['uname'] ?? '';
    $posts = $_POST['posts'] ?? '';

    echo "Name: " . htmlspecialchars($uname) . "<br>";
    echo "Post:<br>" . nl2br(htmlspecialchars($posts));
} else {
    echo "Invalid request method.";
}
?>