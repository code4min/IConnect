<%-- 
    Document   : DepAction
    Created on : 01-May-2024, 10:48:11 pm
    Author     : Sneha
--%>
<%-- 
    Document   : AccountAction
    Created on : 03-Apr-2024, 2:55:51 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
<% 
    String deptname=request.getParameter("deptname");
    
    Connection conn=null;
    PreparedStatement pstmt=null;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
        pstmt=conn.prepareStatement("Insert into DEPARTMENTS (deptname) values(?)");
        pstmt.setString(1,deptname);
        int rowCount = pstmt.executeUpdate();
        response.sendRedirect("Departments.jsp?creation=success");
        
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

