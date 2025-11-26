<%-- 
    Document   : UpdateTicketAction
    Created on : 01-Mar-2024, 12:05:55 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Establishing database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");

        // Retrieving parameters from the form
        String editUsername = request.getParameter("editUsername");
        String editEmail = request.getParameter("editEmail");
        String editPassword = request.getParameter("editPassword");
        String selectedUserID = request.getParameter("selectedUserID");

        String query = "UPDATE USERS SET username=?, Email=?, password=? WHERE userID=?";
            
        pstmt = conn.prepareStatement(query);
            pstmt.setString(1, editUsername);
            pstmt.setString(2, editEmail);
            pstmt.setString(3, editPassword);
            pstmt.setString(4, selectedUserID);
        
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // Redirecting with a success message
            response.sendRedirect("UserAccounts.jsp?edit=success");
        } 
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Closing database resources
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
