<?php
// login.php
session_start();
require 'db.php';

$login_error = "";

// Hard-coded demo user (you can change or move to DB if you like)
$valid_username = "admin";
$valid_password = "admin123";

// Handle login
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['username'], $_POST['password'])) {
    $username  = $_POST['username'];
    $password  = $_POST['password'];
    $registered_flag = isset($_POST['registered']) ? (int) $_POST['registered'] : 0;

    if ($username === $valid_username && $password === $valid_password) {
        $_SESSION['user'] = $username;
        // redirect to avoid resubmitting form
        header("Location: login.php?registered=" . $registered_flag);
        exit;
    } else {
        $login_error = "Invalid username or password.";
    }
}

// Check if logged in
$is_logged_in = isset($_SESSION['user']);

// Get registered flag
$registered = isset($_GET['registered']) ? (int) $_GET['registered'] : 0;

// Handle search (only if logged in)
$search = "";
$events = [];

if ($is_logged_in) {
    $search = isset($_GET['search']) ? trim($_GET['search']) : "";

    if ($search !== "") {
        $stmt = $conn->prepare("SELECT * FROM events 
                                WHERE title LIKE ? 
                                   OR category LIKE ? 
                                   OR location LIKE ?
                                ORDER BY created_at DESC");
        $like = "%" . $search . "%";
        $stmt->bind_param("sss", $like, $like, $like);
    } else {
        $stmt = $conn->prepare("SELECT * FROM events ORDER BY created_at DESC");
    }

    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        $events[] = $row;
    }
    $stmt->close();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login & Events</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<nav class="navbar">
    <div class="nav-brand">My Events</div>

    <?php if ($is_logged_in): ?>
        <!-- Search in navbar (PHP-based) -->
        <form class="nav-search" method="GET" action="login.php">
            <!-- Keep registered flag so message doesn't disappear on search -->
            <input type="hidden" name="registered" value="<?php echo $registered; ?>">
            <input type="text" name="search" placeholder="Search events..." value="<?php echo htmlspecialchars($search); ?>">
            <button type="submit">Search</button>
        </form>
        <div class="nav-links">
            <a href="register.php">Register New</a>
            <a href="logout.php">Logout</a>
        </div>
    <?php else: ?>
        <div class="nav-links">
            <a href="register.php">Register</a>
        </div>
    <?php endif; ?>
</nav>

<div class="container">
    <h1>Login</h1>

    <?php if ($login_error): ?>
        <div class="alert alert-error"><?php echo $login_error; ?></div>
    <?php endif; ?>

    <?php if (!$is_logged_in): ?>
        <form method="POST" class="form-card">
            <input type="hidden" name="registered" value="<?php echo $registered; ?>">

            <label for="username">Username</label>
            <input type="text" name="username" id="username" required value="admin">

            <label for="password">Password</label>
            <input type="password" name="password" id="password" required value="admin123">

            <button type="submit" class="btn">Login</button>
        </form>
        <p class="hint">Demo user: <b>admin</b> / <b>admin123</b></p>
    <?php else: ?>
        <?php if ($registered === 1): ?>
            <div class="alert alert-success">
                Registered ✅ – Your event has been saved!
            </div>
        <?php endif; ?>

        <h2>All Events</h2>

        <?php if (empty($events)): ?>
            <p>No events found.</p>
        <?php else: ?>
            <table class="events-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Date</th>
                        <th>Location</th>
                        <th>Description</th>
                        <th>Created At</th>
                    </tr>
                </thead>
                <tbody>
                <?php foreach ($events as $event): ?>
                    <tr>
                        <td><?php echo $event['id']; ?></td>
                        <td><?php echo htmlspecialchars($event['title']); ?></td>
                        <td><?php echo htmlspecialchars($event['category']); ?></td>
                        <td><?php echo htmlspecialchars($event['event_date']); ?></td>
                        <td><?php echo htmlspecialchars($event['location']); ?></td>
                        <td><?php echo nl2br(htmlspecialchars($event['description'])); ?></td>
                        <td><?php echo $event['created_at']; ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        <?php endif; ?>
    <?php endif; ?>
</div>
</body>
</html>
