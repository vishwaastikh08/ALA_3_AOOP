<!DOCTYPE html>
<html>
<head>
    <title>Add Student</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h2>Add Student</h2>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error-message"><%= request.getAttribute("error") %></div>
    <% } %>
    <form method="post" action="student" novalidate>
        <div class="form-group">
            <label for="name" class="required">Name</label>
            <input type="text" id="name" name="name" 
                value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>" 
                required pattern="[A-Za-z ]{2,50}"
                title="Name must be between 2 and 50 characters and contain only letters and spaces">
        </div>
        <div class="form-group">
            <label for="email" class="required">Email</label>
            <input type="email" id="email" name="email" 
                value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" 
                required
                title="Please enter a valid email address">
        </div>
        <div class="form-group">
            <input type="submit" value="Add Student">
        </div>
        <div style="text-align: center; margin-top: 15px;">
            <a href="student" class="add-button" style="background-color: var(--gray-color);">Back to List</a>
        </div>
    </form>
    <script>
        const form = document.querySelector('form');
        const inputs = form.querySelectorAll('input[required]');
        
        inputs.forEach(input => {
            input.addEventListener('invalid', function(e) {
                e.preventDefault();
                this.classList.add('invalid');
            });
            
            input.addEventListener('input', function() {
                if (this.validity.valid) {
                    this.classList.remove('invalid');
                }
            });
        });
        
        form.addEventListener('submit', function(e) {
            if (!form.checkValidity()) {
                e.preventDefault();
                const firstInvalid = form.querySelector(':invalid');
                if (firstInvalid) {
                    firstInvalid.focus();
                }
            }
        });
    </script>
</body>
</html>
