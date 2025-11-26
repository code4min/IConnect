<%-- 
    Document   : DeleteReportByAdmin
    Created on : 04-Apr-2024, 4:46:03 am
    Author     : Sneha
--%>

<%-- 
    Document   : DeleteFeedbackByAdmin
    Created on : 04-Apr-2024, 3:56:18 am
    Author     : Sneha
--%>

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
        
        String deleteQuery = "DELETE FROM REPORT WHERE TicketID = ?";
        pstmt = conn.prepareStatement(deleteQuery);
        
        String insertDeletedQuery = "INSERT INTO DELETED_REPORTS (DeletedID) VALUES (?)";
        PreparedStatement insertPstmt = conn.prepareStatement(insertDeletedQuery);
        
            pstmt.setString(1, ticketID);
            pstmt.executeUpdate();
            
            insertPstmt.setString(1, ticketID);
            insertPstmt.executeUpdate();
        response.sendRedirect("Reports_Analysis.jsp?deleteReport=success");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>


