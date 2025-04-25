package com.student.dao;

import java.sql.*;
import java.util.*;

public class StudentDAO {
    private final String URL = "jdbc:mysql://localhost:3306/studentdb";
    private final String USER = "root";
    private final String PASS = "";

    public void addStudent(String name, String email) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = null;
        try {
            con = DriverManager.getConnection(URL, USER, PASS);
            con.setAutoCommit(false);  // Start transaction
            
            // First check if email exists
            try (PreparedStatement checkPs = con.prepareStatement("SELECT COUNT(*) FROM students WHERE email = ?")) {
                checkPs.setString(1, email);
                ResultSet rs = checkPs.executeQuery();
                rs.next();
                if (rs.getInt(1) > 0) {
                    throw new Exception("Email address already exists: " + email);
                }
            }
            
            // If email doesn't exist, proceed with insert
            try (PreparedStatement ps = con.prepareStatement("INSERT INTO students (name, email) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, name);
                ps.setString(2, email);
                ps.executeUpdate();
            }
            
            con.commit();  // Commit transaction
        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback();  // Rollback on error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public List<String[]> getAllStudents() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        List<String[]> list = new ArrayList<>();
        try (Connection con = DriverManager.getConnection(URL, USER, PASS);
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM students ORDER BY id ASC")) {
            while (rs.next()) {
                list.add(new String[] {
                        String.valueOf(rs.getInt("id")),
                        rs.getString("name"),
                        rs.getString("email")
                });
            }
        }
        return list;
    }

    public void updateStudent(int id, String name, String email) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection(URL, USER, PASS)) {
            // First check if email exists for another student
            try (PreparedStatement checkPs = con.prepareStatement("SELECT id FROM students WHERE email=? AND id!=?")) {
                checkPs.setString(1, email);
                checkPs.setInt(2, id);
                ResultSet rs = checkPs.executeQuery();
                if (rs.next()) {
                    throw new Exception("Email address already exists: " + email);
                }
            }
            
            // If email is unique, proceed with update
            try (PreparedStatement ps = con.prepareStatement("UPDATE students SET name=?, email=? WHERE id=?")) {
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setInt(3, id);
                ps.executeUpdate();
            }
        }
    }

    public void deleteStudent(int id) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection(URL, USER, PASS);
                PreparedStatement ps = con.prepareStatement("DELETE FROM students WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public String[] getStudentById(int id) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection(URL, USER, PASS);
                PreparedStatement ps = con.prepareStatement("SELECT * FROM students WHERE id=?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new String[] {
                        String.valueOf(rs.getInt("id")),
                        rs.getString("name"),
                        rs.getString("email")
                };
            }
        }
        return null;
    }

}
