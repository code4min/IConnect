<%-- 
    Document   : registerAction
    Created on : 21-Feb-2024, 6:31:36 pm
    Author     : Sneha
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
<% 
    String username=request.getParameter("username");
    String password=request.getParameter("password");
    String email=request.getParameter("email");
    
    Connection conn=null;
    PreparedStatement pstmt=null;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
        pstmt=conn.prepareStatement("Insert into USERS (username, email, password,Registration_DateTime) values(?,?,?,CURRENT_TIMESTAMP)");
        pstmt.setString(1,username);
        pstmt.setString(2,email);
        pstmt.setString(3,password);
        int rowCount = pstmt.executeUpdate();
        response.sendRedirect("HomePage.jsp?registration=success");
        
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
