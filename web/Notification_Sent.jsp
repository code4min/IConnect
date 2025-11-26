<%-- 
    Document   : UpdateTicketAction
    Created on : 01-Mar-2024, 12:05:55 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
        String selectedAgentID = request.getParameter("selectedAgentID");
        String selectedTicketID = request.getParameter("selectedTicketID");
        String message = request.getParameter("message");
    
    Connection conn = null;
    PreparedStatement pstmt = null;

    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
        pstmt=conn.prepareStatement("Insert into NOTIFICATIONS (agentID, ticketID, message) values(?,?,?)");
        pstmt.setString(1,selectedAgentID);
        pstmt.setString(2,selectedTicketID);
        pstmt.setString(3,message);
        int rowCount = pstmt.executeUpdate();
        response.sendRedirect("overdue_tickets.jsp?creation=success");
        
    }catch (Exception e){
        out.println("Error:"+ e.getMessage());
    }finally{
        if(pstmt !=null) pstmt.close();
        if(conn !=null) conn.close();
    }

%>
