<%-- 
    Document   : CloseTicketAdmin
    Created on : 02-Apr-2024, 9:33:45 pm
    Author     : Sneha
--%>

<%-- 
    Document   : CloseTicket2
    Created on : 06-Mar-2024, 3:42:19 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String ticketId = request.getParameter("ticketId");
    

    // Check if the ticket ID is provided
    if (ticketId != null && !ticketId.isEmpty()) {

    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement tstmt=null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");

        String timeQuery = "UPDATE TICKET SET Resolution_DateTime = ? WHERE tID = ?";
        tstmt = conn.prepareStatement(timeQuery);
        tstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
        tstmt.setString(2, ticketId);
        tstmt.executeUpdate();
        
        String updateQuery = "UPDATE TICKET SET TicketStatus = 'CLOSED' WHERE tID = ?";
        pstmt = conn.prepareStatement(updateQuery);
        pstmt.setString(1, ticketId);
        pstmt.executeUpdate();
        
        response.sendRedirect("TicketManagement.jsp?deletion=success");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (tstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    } else {
        // Ticket ID not provided
        out.println("Ticket ID is missing.");
    }
%>
