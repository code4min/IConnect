<%-- 
    Document   : CloseTicket2
    Created on : 06-Mar-2024, 3:42:19 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String ticketIDsString = request.getParameter("ticketIDs");
    String[] ticketIDs = ticketIDsString.split(",");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");

        String updateQuery = "UPDATE TICKET SET TicketStatus = 'CLOSED' , Resolution_DateTime = CURRENT_TIMESTAMP WHERE tID = ?";
        pstmt = conn.prepareStatement(updateQuery);

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