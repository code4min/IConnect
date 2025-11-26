<%-- 
    Document   : unresolved_tickets
    Created on : 02-Apr-2024, 9:52:02 pm
    Author     : Sneha
--%>

<%-- 
    Document   : resolved_tickets
    Created on : 02-Apr-2024, 8:57:49 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resolved Tickets Page</title>
        <style>
            .title{
            background-color: black;
            color:white;
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            font-size: 26px;
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
        .resolved{
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
        </style>
        <style>
  /* CSS for the priority information bar */
  .priority-bar {
    position: relative;
    background-color: white;
    color: black;
    padding: 10px;
    text-align: center;
    width:60%;
    margin-left: 250px;
  }

  .priority-box {
    display: inline-block;
    width: 100px;
    height: 20px;
    margin: 0 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
  }

  .high-priority {
    background-color: red;
  }

  .medium-priority {
    background-color: orange;
  }

  .low-priority {
    background-color: pink;
  }
</style>
    </head>
    <body>
        <div class="title">
        <a href="TicketManagement.jsp" class="back-button">&#8592</a>
        <div class="resolved">Unresolved Tickets</div>
    </div>
        <div class="priority-bar">
                    <div class="priority-box high-priority"></div>
                    <span>High Priority</span>
                    <div class="priority-box medium-priority"></div>
                    <span>Medium Priority</span>
                    <div class="priority-box low-priority"></div>
                    <span>Low Priority</span>
    </div>
        <div id="section">
            <table>
                <tr>
                    <th>Select</th>
                    <th>Ticket ID</th>
                    <th>Ticket Type</th>
                    <th>Ticket Status</th>
                    <th>Ticket Priority</th>
                    <th>Ticket Subject</th>
                    <th>Created by</th>
                    <th>Assigned to</th>
                </tr>
<%
     String adminID = request.getParameter("adminID");
            if (adminID == null) {
                adminID = (String) session.getAttribute("adminID");
            }   
    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs = null;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","root","admin");
        pstmt = conn.prepareStatement("SELECT t.tID,t.tType,t.TicketStatus,t.Priority, t.subject,u.username AS createdBy, a.username AS assignedTo FROM TICKET t JOIN USERS u ON t.uID = u.userID JOIN AGENTS a ON t.Agent = a.agentID WHERE t.TicketStatus <>'CLOSED' ORDER BY tID DESC ");
        rs = pstmt.executeQuery();
        while (rs.next()) {
        String priority = rs.getString("Priority");
                    String priorityClass = "";
                    if ("high".equals(priority)) {
                        priorityClass = "high-priority";
                    } else if ("medium".equals(priority)) {
                        priorityClass = "medium-priority";
                    } else if ("low".equals(priority)) {
                        priorityClass = "low-priority";
                    }
    
%>        
        <tr>
            <td><input type="checkbox" name="tCheckbox" ></td>
            <td><%= rs.getString("tID") %></td>
            <td><%= rs.getString("tType") %></td>
            <td><%= rs.getString("TicketStatus") %></td>
            <td class="<%= priorityClass %>"></td>
            <td><%= rs.getString("subject") %></td>
            <td><%= rs.getString("createdBy") %></td>
            <td><%= rs.getString("assignedTo") %></td>
        </tr>
<% 
                }
            } catch (Exception e) {
                out.println("Error:"+ e.getMessage());
            } finally {
                try {
                    if(rs != null) rs.close();
                    if(pstmt !=null) pstmt.close();
                    if(conn !=null) conn.close();
                } catch(Exception e) {
                    out.println("Error in closing resources: " + e.getMessage());
                }
            }
        %>
            </table>
            </div>
    </body>
</html>

