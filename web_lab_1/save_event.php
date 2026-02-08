<?php
// save_event.php
require 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title       = $_POST['title'] ?? '';
    $category    = $_POST['category'] ?? '';
    $event_date  = $_POST['event_date'] ?? '';
    $location    = $_POST['location'] ?? '';
    $description = $_POST['description'] ?? '';

    // Basic validation (optional, you can add more)
    if ($title && $category && $event_date && $location && $description) {
        $stmt = $conn->prepare("INSERT INTO events (title, category, event_date, location, description) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("sssss", $title, $category, $event_date, $location, $description);
        $stmt->execute();
        $stmt->close();

        // Redirect to login page with "registered" flag
        header("Location: login.php?registered=1");
        exit;
    } else {
        echo "Please fill in all fields.";
    }
} else {
    header("Location: register.php");
    exit;
}
