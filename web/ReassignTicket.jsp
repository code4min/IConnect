<%-- 
    Document   : ReassignTicket
    Created on : 02-Mar-2024, 2:03:14 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String ticketIDsString = request.getParameter("ticketIDs");
    String newAgentID = request.getParameter("newAgentID");

    String[] ticketIDs = ticketIDsString.split(",");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");

        String updateQuery = "UPDATE TICKET SET Agent = ? WHERE tID = ?";
        pstmt = conn.prepareStatement(updateQuery);

        for (String ticketID : ticketIDs) {
            pstmt.setString(1, newAgentID.trim());
            pstmt.setString(2, ticketID.trim());
            pstmt.executeUpdate();
        }
        
        String updateStatusQuery = "UPDATE TICKET SET TicketStatus = 'RE-ASSIGNED' WHERE tID = ?";
        pstmt = conn.prepareStatement(updateStatusQuery);

        for (String ticketID : ticketIDs) {
            pstmt.setString(1, ticketID.trim());
            pstmt.executeUpdate();
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>