<%-- 
    Document   : TicketAction
    Created on : 22-Feb-2024, 10:59:09 pm
    Author     : Sneha
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.Timestamp" %>
<% 
    String ticketPriority=request.getParameter("ticketPriority");
    String ticketType=request.getParameter("ticketType");
    String tcontent=request.getParameter("tkt_content");
    String userID = request.getParameter("userID");
    String subject= request.getParameter("subject");
    Connection conn=null;
    PreparedStatement pstmt=null;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","root","admin");
        String agentDepartment = "";
        String selectAgentQuery = "SELECT agentID FROM AGENTS WHERE deptID = ? ORDER BY RAND() LIMIT 1";
        PreparedStatement selectAgentStmt = conn.prepareStatement(selectAgentQuery);
        selectAgentStmt.setString(1, ticketType);
        ResultSet agentResult = selectAgentStmt.executeQuery();
        String agentID = "";
        if (agentResult.next()) {
            agentID = agentResult.getString("agentID");
        } else {
        response.sendRedirect("UserPage.jsp?error=NoAgentAvailable");
            return;
        }
        pstmt=conn.prepareStatement("Insert into TICKET (tcontent, tType, uID, Agent, Priority, Creation_Date,TicketStatus, subject) values(?,?,?,?,?,?,?,?)");
        pstmt.setString(1,tcontent);
        pstmt.setString(2,ticketType);
        pstmt.setString(3,userID);
        pstmt.setString(4, agentID);
        pstmt.setString(5, ticketPriority);
        
        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
        pstmt.setTimestamp(6, currentTimestamp);
        pstmt.setString(7, "created");
        
        pstmt.setString(8, subject);
        
        int rowCount = pstmt.executeUpdate();
        out.println("<h2>Ticket submitted successfully!</h2>");
        response.sendRedirect("UserPage.jsp?submitted=success");
        
    }catch (Exception e){
        out.println("Error:"+ e.getMessage());
    }finally{
        if(pstmt !=null) pstmt.close();
        if(conn !=null) conn.close();
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
