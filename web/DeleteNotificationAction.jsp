<%-- 
    Document   : DeleteNotificationAction
    Created on : 04-Apr-2024, 2:59:29 am
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String ticketID = request.getParameter("ticketID");
    
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");
        pstmt = conn.prepareStatement("DELETE FROM NOTIFICATIONS WHERE ticketID = ?");
        pstmt.setString(1, ticketID);
        int rowCount = pstmt.executeUpdate();
        response.sendRedirect("Notifications.jsp");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

