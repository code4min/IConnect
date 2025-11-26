<%-- 
    Document   : AddNotesAction
    Created on : 02-Apr-2024, 8:42:38 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // Retrieve parameters from the form
    String adminID = request.getParameter("adminID");
    String ticketId = request.getParameter("ticketId");
    String notes = request.getParameter("notes");

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/HDT";
    String username = "root";
    String password = "admin";

    // Database connection and query initialization
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // Insert comment into the Comment table
        String sql = "INSERT INTO NOTES (ticketID, noteText) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, ticketId);
        pstmt.setString(2, notes);
        pstmt.executeUpdate();

        // Redirect back to the page where the ticket was raised
        response.sendRedirect("TicketManagement.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        // Handle any errors
        e.printStackTrace();
        // You may want to handle errors differently, like displaying an error message on the page
        out.println("Error: " + e.getMessage());
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error in closing resources: " + e.getMessage());
        }
    }
%>
