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
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");

        // Retrieving parameters from the form
        String ticketID = request.getParameter("ticketID");
        String tType = request.getParameter("tType");
        String ticketStatus = request.getParameter("ticketStatus");
        String priority = request.getParameter("priority");
        String subject = request.getParameter("subject");
        String tcontent = request.getParameter("tcontent");
        String duedate = request.getParameter("dueDate");
        String resolution_steps = request.getParameter("ResolutionSteps");

        // Checking if the "fromPage" parameter exists
        String fromPage = request.getParameter("fromPage");
        
        // Defining the query and redirectPage based on the value of "fromPage"
        String query = "";
        String redirectPage = "";
        if (fromPage != null && fromPage.equals("edit_ticket")) {
            // If coming from edit_ticket.jsp, execute adminquery
            query = "UPDATE TICKET SET tType=?, TicketStatus=?, Priority=?, due_date=?, subject=?, tcontent=?, resolution_steps=? WHERE tID=?";
            redirectPage = "TicketManagement.jsp";
        } else {
            // If coming from UpdateTicket.jsp or "fromPage" is null, execute normal query
            query = "UPDATE TICKET SET tType=?, TicketStatus=?, Priority=?, subject=?, tcontent=? WHERE tID=?";
            redirectPage = "UserPage.jsp";
        }
        pstmt = conn.prepareStatement(query);
        if (fromPage != null && fromPage.equals("edit_ticket")) {
            pstmt.setString(1, tType);
            pstmt.setString(2, ticketStatus);
            pstmt.setString(3, priority);
            pstmt.setString(4, duedate);
            pstmt.setString(5, subject);
            pstmt.setString(6, tcontent);
            pstmt.setString(7, resolution_steps);
            pstmt.setString(8, ticketID);
        } else {
            pstmt.setString(1, tType);
            pstmt.setString(2, ticketStatus);
            pstmt.setString(3, priority);
            pstmt.setString(4, subject);
            pstmt.setString(5, tcontent);
            pstmt.setString(6, ticketID);
        }
        
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // Redirecting with a success message
            response.sendRedirect(redirectPage + "?ticket_updated=success");
        } else {
            // Redirecting with a failure message
            response.sendRedirect(redirectPage + "?ticket_updated=failure");
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
