<%-- 
    Document   : CloseTicket
    Created on : 02-Mar-2024, 2:02:32 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String ticketID = request.getParameter("ticketID");

    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement tstmt=null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");
        
        String timeQuery = "UPDATE TICKET SET Resolution_DateTime = ? WHERE tID = ?";
        tstmt = conn.prepareStatement(timeQuery);
        tstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
        tstmt.setString(2, ticketID);
        tstmt.executeUpdate();
        
        String updateQuery = "UPDATE TICKET SET TicketStatus = 'CLOSED' WHERE tID = ?";
        pstmt = conn.prepareStatement(updateQuery);
        pstmt.setString(1, ticketID);
        pstmt.executeUpdate();
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
%>