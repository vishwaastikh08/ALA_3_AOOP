<!DOCTYPE html>
<html>
<head>
    <title>Edit Student</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <h2>Edit Student</h2>
    <form method="post" action="student" novalidate>
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" id="studentId">
        <div class="form-group">
            <label for="studentName" class="required">Name</label>
            <input type="text" name="name" id="studentName" 
                required pattern="[A-Za-z ]{2,50}"
                title="Name must be between 2 and 50 characters and contain only letters and spaces">
        </div>
        <div class="form-group">
            <label for="studentEmail" class="required">Email</label>
            <input type="email" name="email" id="studentEmail" 
                required
                title="Please enter a valid email address">
        </div>
        <div class="form-group">
            <input type="submit" value="Update Student">
        </div>
        <div style="text-align: center; margin-top: 15px;">
            <a href="student" class="add-button" style="background-color: var(--gray-color);">Back to List</a>
        </div>
    </form>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const id = urlParams.get('id');
        const name = urlParams.get('name');
        const email = urlParams.get('email');
        const error = urlParams.get('error');
        
        if (error) {
            const errorDiv = document.createElement('div');
            errorDiv.className = 'error-message';
            errorDiv.textContent = decodeURIComponent(error);
            document.querySelector('h2').insertAdjacentElement('afterend', errorDiv);
        }
        
        document.getElementById('studentId').value = id;
        document.getElementById('studentName').value = name;
        document.getElementById('studentEmail').value = email;

        // Form validation
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