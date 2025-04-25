package com.student.controller;

import com.student.dao.StudentDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class StudentServlet extends HttpServlet {
    private StudentDAO dao;

    public void init() {
        dao = new StudentDAO();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String action = req.getParameter("action");
        try {
            if (action == null) {
                // Default action - show student list on home page
                req.setAttribute("studentList", dao.getAllStudents());
                req.getRequestDispatcher("index.jsp").forward(req, res);
                return;
            }
            
            switch(action) {
                case "edit":
                    int editId = Integer.parseInt(req.getParameter("id"));
                    String[] student = dao.getStudentById(editId);
                    if (student != null) {
                        res.sendRedirect("edit.jsp?id=" + editId + "&name=" + student[1] + "&email=" + student[2]);
                    } else {
                        req.setAttribute("error", "Student not found");
                        req.setAttribute("studentList", dao.getAllStudents());
                        req.getRequestDispatcher("index.jsp").forward(req, res);
                    }
                    break;
                    
                case "delete":
                    int deleteId = Integer.parseInt(req.getParameter("id"));
                    if (req.getParameter("confirm") != null) {
                        // Actually delete the student when confirmed
                        dao.deleteStudent(deleteId);
                        res.sendRedirect("student");
                    } else {
                        // Show confirmation page
                        String[] studentToDelete = dao.getStudentById(deleteId);
                        if (studentToDelete != null) {
                            res.sendRedirect("delete.jsp?id=" + deleteId + "&name=" + studentToDelete[1] + "&email=" + studentToDelete[2]);
                        } else {
                            req.setAttribute("error", "Student not found");
                            req.setAttribute("studentList", dao.getAllStudents());
                            req.getRequestDispatcher("index.jsp").forward(req, res);
                        }
                    }
                    break;
                    
                default:
                    req.setAttribute("studentList", dao.getAllStudents());
                    req.getRequestDispatcher("index.jsp").forward(req, res);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            try {
                req.setAttribute("studentList", dao.getAllStudents());
            } catch (Exception ex) {
                // If we can't get the student list, just show the error
                ex.printStackTrace();
            }
            req.getRequestDispatcher("index.jsp").forward(req, res);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String action = req.getParameter("action");
        String name = req.getParameter("name");
        String email = req.getParameter("email");

        try {
            if (action != null && action.equals("update")) {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.updateStudent(id, name, email);
            } else {
                dao.addStudent(name, email);
            }
            // After successful operation, redirect to home page
            res.sendRedirect("student");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("name", name);
            req.setAttribute("email", email);
            if (action != null && action.equals("update")) {
                String id = req.getParameter("id");
                res.sendRedirect("edit.jsp?id=" + id + "&name=" + name + "&email=" + email + "&error=" + e.getMessage());
            } else {
                req.getRequestDispatcher("add.jsp").forward(req, res);
            }
        }
    }
}
