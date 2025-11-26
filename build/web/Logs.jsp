<%-- 
    Document   : Logs
    Created on : 27-Mar-2024, 6:07:06 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logs Page</title>
        <style>
            .title{
            background-color: #00BD62;
            color:white;
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            font-family: sans-serif;
            font-size: 26px;
            height: 50px;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
            }
        .back-button {
            display: inline-block;
            background: none;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-left: 5px;
            font-size: 20px;
        }
        .logs_title{
            margin: 0 auto;
        }
        body{
            background-color: white;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #00BD62;
            color:white;
        }
        td {
            background-color: #C9E1BF;
        }
        .task-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 99%;
            background-color: #f2f2f2; /* Match the background color of the table header */
            padding: 10px; /* Adjust padding as needed */
            border-bottom: 1px solid #ddd; /* Adjust as needed */
        }

        .task-bar button {
            background-color: black; /* Green background */
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 0; /* Remove margin */
            flex-grow: 1;
            cursor: pointer;
            transition-duration: 0.4s; /* Adjust as needed */
        }
        
        .task-bar button:hover {
            background-color: #cccccc;
            color: black;
        }
        .user_reg{
            display: none;
            padding-bottom: 20px;
        }
        .user_log{
            display: none;
            padding-bottom: 20px;
        }
        .agent_reg{
            display: none;
            padding-bottom: 20px;
        }
        .agent_log{
            display: none;
            padding-bottom: 20px;
        }
        </style>
    </head>
    <body>
        <div class="title">
            <a href="AdminPage.jsp" class="back-button">&#8592</a>
            <div class="logs_title">LOGS</div>
        </div>
        <div class="task-bar">
                <button onclick="user_reg_log()">USER REGISTRATION LOGS</button>
                <button onclick="agent_reg_log()">AGENT REGISTRATION LOGS</button>
                <button onclick="user_log_log()">USER LOGIN LOGS</button>
                <button onclick="agent_log_log()">AGENT LOGIN LOGS</button>
        </div>
        <div class="user_reg" id="user_reg">
            <table>
                <tr>
                    <th>User ID</th>
                    <th>User Name</th>
                    <th>Registration Date & Time</th>
                </tr>
<%
     String adminID = request.getParameter("adminID");
            if (adminID == null) {
                adminID = (String) session.getAttribute("adminID");
            }   
    Connection conn=null;
    PreparedStatement pstmt=null;
    PreparedStatement stmt=null;
    PreparedStatement qtmt=null;
    PreparedStatement mtmt=null;
    ResultSet rsq=null;
    ResultSet rs = null;
    ResultSet rsm = null;
    ResultSet rsa = null;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
        pstmt = conn.prepareStatement("SELECT * FROM USERS ");
        rs = pstmt.executeQuery();
        while (rs.next()) {
        
%>        
        <tr>
            <td><%= rs.getString("userID") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("Registration_DateTime") %></td>
        <tr>
            <%
                }
            %>
            </table>
        </div>
            <div class="agent_reg" id="agent_reg">
                <table>
                <tr>
                    <th>Agent ID</th>
                    <th>Agent Name</th>
                    <th>Registration Date & Time</th>
                </tr>
<%
        stmt = conn.prepareStatement("SELECT * FROM AGENTS ");
        rsa = stmt.executeQuery();
        while (rsa.next()) {
        
%>        
              <tr>
            <td><%= rsa.getString("agentID") %></td>
            <td><%= rsa.getString("username") %></td>
            <td><%= rsa.getString("Registration_DateTime") %></td>
        <tr>
            <%
                }
            %>
            </table>
            </div>
            <div class="user_log" id="user_log">
                <table>
                <tr>
                    <th>Log ID</th>
                    <th>User ID</th>
                    <th>Login Date & Time</th>
                </tr>
<%
        qtmt = conn.prepareStatement("SELECT * FROM LOGS where accountType='user' ORDER BY loginDateTime DESC ");
        rsq = qtmt.executeQuery();
        while (rsq.next()) {
        
%>       
        <tr>
            <td><%= rsq.getString("logID") %></td>
            <td><%= rsq.getString("accountID") %></td>
            <td><%= rsq.getString("loginDateTime") %></td>
        </tr>
        <%
                }
        %>
            </table>
            </div>
        <div class="agent_log" id="agent_log">
            <table>
                <tr>
                    <th>Log ID</th>
                    <th>Agent ID</th>
                    <th>Login Date & Time</th>
                </tr>
<%
        mtmt = conn.prepareStatement("SELECT * FROM LOGS where accountType='agent' ORDER BY loginDateTime DESC ");
        rsm = qtmt.executeQuery();
        while (rsm.next()) {
        
%>           
            
        <tr>
            <td><%= rsm.getString("logID") %></td>
            <td><%= rsm.getString("accountID") %></td>
            <td><%= rsm.getString("loginDateTime") %></td>
        </tr>
        <%
                }
        %>
            </table>
        </div>
    </body>
</html>
<% 
                
            } catch (Exception e) {
                out.println("Error:"+ e.getMessage());
            } finally {
                try {
                    if(rs != null) rs.close();
                    if(pstmt !=null) pstmt.close();
                    if(rsa != null) rsa.close();
                    if(stmt !=null) stmt.close();
                    if(rsq != null) rsq.close();
                    if(qtmt !=null) qtmt.close();
                    if(conn !=null) conn.close();
                } catch(Exception e) {
                    out.println("Error in closing resources: " + e.getMessage());
                }
            }
        %>
<script>
        function user_reg_log() {
            var userRegDiv = document.getElementById("user_reg");
            userRegDiv.style.display = "block"; 
            userRegDiv.scrollIntoView();           
        }
</script>
<script>
        function agent_reg_log() {
            var agentRegDiv = document.getElementById("agent_reg");
            agentRegDiv.style.display = "block"; 
            agentRegDiv.scrollIntoView();           
        }
</script>
<script>
        function user_log_log() {
            var userLogDiv = document.getElementById("user_log");
            userLogDiv.style.display = "block"; 
            userLogDiv.scrollIntoView();           
        }
</script>
<script>
        function agent_log_log() {
            var agentLogDiv = document.getElementById("agent_log");
            agentLogDiv.style.display = "block"; 
            agentLogDiv.scrollIntoView();           
        }
</script>