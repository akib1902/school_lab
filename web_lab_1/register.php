<?php
// register.php
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Event Registration</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js" defer></script>
</head>
<body>
<nav class="navbar">
    <div class="nav-brand">My Events</div>
    <div class="nav-links">
        <a href="login.php">Login</a>
    </div>
</nav>

<div class="container">
    <h1>Register Event</h1>

    <form action="save_event.php" method="POST" id="eventForm" class="form-card">
        <label for="title">Title</label>
        <input type="text" name="title" id="title" required>

        <label for="category">Category</label>
        <select name="category" id="category" required>
            <option value="">-- Select Category --</option>
            <option value="Conference">Conference</option>
            <option value="Workshop">Workshop</option>
            <option value="Meetup">Meetup</option>
            <option value="Webinar">Webinar</option>
            <option value="Other">Other</option>
        </select>

        <label for="event_date">Date</label>
        <input type="date" name="event_date" id="event_date" required>

        <label for="location">Location</label>
        <input type="text" name="location" id="location" required>

        <label for="description">Description</label>
        <textarea name="description" id="description" rows="4" required></textarea>

        <button type="submit" class="btn">Register</button>
    </form>
</div>
</body>
</html>
