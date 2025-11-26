<%-- 
    Document   : DeleteTicketByUser
    Created on : 01-Apr-2024, 6:09:12 am
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%
    String[] ticketIDs = request.getParameter("ticketIDs").split(",");

    // Database connection and deletion logic
    Connection conn = null;
        PreparedStatement pstmtComments = null;
        PreparedStatement pstmtNotes = null;
        PreparedStatement pstmtTicket = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");

        for (String ticketID : ticketIDs) {
                pstmtComments = conn.prepareStatement("DELETE FROM comments WHERE tID = ?");
                pstmtComments.setString(1, ticketID);
                pstmtComments.executeUpdate();
            }

            // Delete associated notes for each ticket
            for (String ticketID : ticketIDs) {
                pstmtNotes = conn.prepareStatement("DELETE FROM notes WHERE ticketID = ?");
                pstmtNotes.setString(1, ticketID);
                pstmtNotes.executeUpdate();
            }

            // Delete tickets from the database
            for (String ticketID : ticketIDs) {
                pstmtTicket = conn.prepareStatement("DELETE FROM TICKET WHERE tID = ?");
                pstmtTicket.setString(1, ticketID);
                pstmtTicket.executeUpdate();
            }

    } catch (Exception e) {
        e.printStackTrace();
        // Handle exceptions
    } finally {
        // Close resources
        try {
            if (pstmtComments != null) pstmtComments.close();
                if (pstmtNotes != null) pstmtNotes.close();
                if (pstmtTicket != null) pstmtTicket.close();
                if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Redirect back to UserPage.jsp after deletion
    response.sendRedirect("UserPage.jsp");
%>
