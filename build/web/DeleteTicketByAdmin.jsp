<%-- 
    Document   : DeleteTicketByAdmin
    Created on : 28-Mar-2024, 11:59:06 pm
    Author     : Sneha
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Retrieve ticket IDs from the request parameter
    String[] ticketIds = request.getParameter("ticketIds").split(",");

    // Connection variables
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");

        // Delete associated comments for each ticket
        for (String ticketId : ticketIds) {
            pstmt = conn.prepareStatement("DELETE FROM comments WHERE tID = ?");
            pstmt.setString(1, ticketId);
            pstmt.executeUpdate();
        }

        // Delete tickets from the database
        pstmt = conn.prepareStatement("DELETE FROM TICKET WHERE tID = ?");
        for (String ticketId : ticketIds) {
            pstmt.setString(1, ticketId);
            pstmt.executeUpdate();
        }

        // Redirect back to TicketManagement.jsp after successful deletion
        response.sendRedirect("TicketManagement.jsp");
    } catch (SQLException e) {
        // Handle SQL exceptions
        out.println("SQL Exception: " + e.getMessage());
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        // Handle class not found exception
        out.println("ClassNotFoundException: " + e.getMessage());
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            // Handle SQLException in closing resources
            out.println("Error in closing resources: " + e.getMessage());
            e.printStackTrace();
        }
    }
%>


