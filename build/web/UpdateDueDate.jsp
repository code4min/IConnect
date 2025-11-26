<%-- 
    Document   : UpdateDueDate
    Created on : 05-Mar-2024, 2:19:20 pm
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
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");

        // Retrieving parameters from the request
        String ticketID = request.getParameter("ticketID");
        String dueDate = request.getParameter("dueDate");

        // Updating the due date in the TICKET table
        String query = "UPDATE TICKET SET due_date = ? WHERE tID = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, dueDate);
        pstmt.setString(2, ticketID);
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // Sending a success response
            response.getWriter().write("Due date updated successfully");
        } else {
            // Sending a failure response
            response.getWriter().write("Failed to update due date");
        }
    } catch (Exception e) {
        // Sending an error response
        response.getWriter().write("Error: " + e.getMessage());
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