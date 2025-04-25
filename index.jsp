<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Management System</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h1>Student Management System</h1>
    
    <% if (request.getAttribute("error") != null) { %>
        <div class="error-message" style="max-width: 800px; margin: 20px auto;">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <div style="text-align: center;">
        <a href="add.jsp" class="add-button">Add New Student</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
            List<String[]> studentList = (List<String[]>) request.getAttribute("studentList");
            if (studentList != null && !studentList.isEmpty()) {
                for (String[] student : studentList) {
            %>
                <tr>
                    <td><%= student[0] %></td>
                    <td><%= student[1] %></td>
                    <td><%= student[2] %></td>
                    <td class="action-links">
                        <a href="student?action=edit&id=<%= student[0] %>" class="edit-link">Edit</a>
                        <a href="student?action=delete&id=<%= student[0] %>" class="delete-link">Delete</a>
                    </td>
                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="4" style="text-align: center; padding: 20px;">
                        No students found. Click "Add New Student" to add one.
                    </td>
                </tr>
            <%
            }
            %>
        </tbody>
    </table>
</body>
</html>
