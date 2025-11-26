<%-- 
    Document   : DeleteTicket
    Created on : 02-Mar-2024, 2:02:49 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String[] ticketIDs = request.getParameterValues("ticketIDs");
    String redirect = request.getParameter("redirect");
    
    if (ticketIDs != null && ticketIDs.length > 0) {
        Connection conn = null;
        PreparedStatement pstmtComments = null;
        PreparedStatement pstmtNotes = null;
        PreparedStatement pstmtTicket = null;
        
        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");
            
            // Delete associated comments for each ticket
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

            // Redirect back to the appropriate page
            if (redirect != null && redirect.equals("agent")) {
                response.sendRedirect("TicketOverview.jsp");
            } else {
                response.sendRedirect("TicketOverview.jsp");
            }
        } catch (ClassNotFoundException e) {
            out.println("Class not found: " + e.getMessage());
        } catch (SQLException e) {
            out.println("SQL Exception: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (pstmtComments != null) pstmtComments.close();
                if (pstmtNotes != null) pstmtNotes.close();
                if (pstmtTicket != null) pstmtTicket.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                out.println("Error closing resources: " + ex.getMessage());
            }
        }
    } else {
        out.println("No ticket IDs provided for deletion.");
    }
%>




