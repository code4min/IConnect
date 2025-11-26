<%-- 
    Document   : ReassignTicket2
    Created on : 28-Mar-2024, 6:08:23 am
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    // Get the ticket IDs and agent ID from the URL parameters
    String[] ticketIDs = request.getParameterValues("ticketIds");
    String agentId = request.getParameter("agentId");

    // Check if both ticket IDs and agent ID are provided
    if (ticketIDs != null && ticketIDs.length > 0 && agentId != null && !agentId.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");
            
            // Update ticket details for each ticket ID
            for (String ticketID : ticketIDs) {
                // Update ticket status to "reassigned" and set new agent ID
                pstmt = conn.prepareStatement("UPDATE TICKET SET TicketStatus = ?, Agent = ? WHERE tID = ?");
                pstmt.setString(1, "reassigned");
                pstmt.setString(2, agentId);
                pstmt.setString(3, ticketID);
                pstmt.executeUpdate();
            }

            // Redirect back to TicketManagement.jsp after reassigning the tickets
            response.sendRedirect("TicketManagement.jsp?ticket_reassigned=success");
        } catch (ClassNotFoundException e) {
            out.println("Class not found: " + e.getMessage());
        } catch (SQLException e) {
            out.println("SQL Exception: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                out.println("Error closing resources: " + ex.getMessage());
            }
        }
    } else {
        out.println("Ticket IDs and agent ID are required for reassignment.");
    }
%>
