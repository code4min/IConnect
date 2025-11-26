<%-- 
    Document   : LoginAction
    Created on : 21-Feb-2024, 3:07:45 pm
    Author     : Sneha
--%>

<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String loginType=request.getParameter("loginType");
    String username=request.getParameter("username");
    String password=request.getParameter("password");
    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
        String query="";
        String accountType = ""; // Variable to store the account type
    String accountID = "";
        switch (loginType){
            case "user":
                query="SELECT * FROM USERS WHERE username=? AND password=?";
                accountType = "user";
                break;
            case "agent":
                query="Select * FROM AGENTS WHERE username=? AND password=?";
                accountType = "agent";
                break;
            case "db_pass":
                query="Select * FROM ADMIN WHERE username=? AND password=?";
                accountType = "db_pass";
                break;
            default:
                out.println("Invalid login Type");
                return;
        }
        pstmt=conn.prepareStatement(query);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        rs=pstmt.executeQuery();
        
        
        if (rs.next()){
            accountID = rs.getString(1); // Assuming userID, agentID, or adminID is the first column
        String email = rs.getString("email");

        // Store login details in Logs table
        pstmt = conn.prepareStatement("INSERT INTO LOGS (accountID, loginDateTime, accountType) VALUES (?, CURRENT_TIMESTAMP, ?)");
        pstmt.setString(1, accountID);
        pstmt.setString(2, accountType);
        pstmt.executeUpdate();


            session.setAttribute("email", email);
            session.setAttribute("username", username);
            session.setAttribute("password", password);
            
            switch (loginType){
            case "user":
                session.setAttribute("userID", accountID);
                response.sendRedirect("UserPage.jsp");
                break;
            case "agent":
                session.setAttribute("agentID", accountID);
                response.sendRedirect("AgentPage.jsp");
                break;
            case "db_pass":
                session.setAttribute("adminID", accountID);
                response.sendRedirect("AdminPage.jsp");
                break;
            default:
                out.println("error");
                return;
            }
        }else{
            out.println("Invalid username or password");
        }
    } catch (Exception e) {
    out.println("Error :" + e.getMessage());
} finally {
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (Exception ex) {
        out.println("Error in closing resources: " + ex.getMessage());
    }
}
  %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Invalid Login Attmept!!</h1>
        <h3>Please recheck your account credentials</h3>
    </body>
</html>
