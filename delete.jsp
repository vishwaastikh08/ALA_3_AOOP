<!DOCTYPE html>
<html>
<head>
    <title>Delete Student</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Delete Student</h2>
    <div class="delete-confirmation">
        <p>Are you sure you want to delete this student?</p>
        <div class="student-info">
            <p><strong>Name:</strong> <span id="studentName"></span></p>
            <p><strong>Email:</strong> <span id="studentEmail"></span></p>
        </div>
        <div style="margin-top: 20px;">
            <form method="get" action="student" style="display: inline-block; margin: 10px; box-shadow: none; padding: 0; background: none;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="confirm" value="true">
                <input type="hidden" name="id" id="studentId">
                <input type="submit" value="Confirm Delete" style="background-color: var(--danger-color); width: auto; min-width: 150px;">
            </form>
            <form method="get" action="student" style="display: inline-block; margin: 10px; box-shadow: none; padding: 0; background: none;">
                <input type="submit" value="Cancel" style="background-color: var(--gray-color); width: auto; min-width: 150px;">
            </form>
        </div>
    </div>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const id = urlParams.get('id');
        const name = urlParams.get('name');
        const email = urlParams.get('email');
        
        document.getElementById('studentId').value = id;
        document.getElementById('studentName').textContent = name;
        document.getElementById('studentEmail').textContent = email;
    </script>
</body>
</html>