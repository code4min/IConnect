<%-- 
    Document   : UpdateAgentProfile
    Created on : 01-May-2024, 9:23:33 pm
    Author     : Sneha
--%>

<%-- 
    Document   : UpdateAdminProfile
    Created on : 01-May-2024, 8:53:58 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.SQLException" %>
<%
    // Retrieve form data
    String newUsername = request.getParameter("newUsername");
    String newPassword = request.getParameter("newPassword");
    String newEmail = request.getParameter("newEmail");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Connect to the database
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");

        // Update the admin profile
        String sql = "UPDATE AGENTS SET username=?, password=?, Email=? WHERE agentID=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, newUsername);
        pstmt.setString(2, newPassword);
        pstmt.setString(3, newEmail);
        pstmt.setString(4, (String) session.getAttribute("agentID"));
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // Profile updated successfully
            response.sendRedirect("AgentProfile.jsp"); // Redirect to profile page
        } else {
            // Profile update failed
            out.println("Failed to update profile. Please try again.");
        }
    } catch (SQLException | ClassNotFoundException e) {
        // Handle exceptions
        e.printStackTrace();
        out.println("An error occurred while updating profile.");
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

