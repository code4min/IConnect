<%-- 
    Document   : ResolvedTickets
    Created on : 31-Mar-2024, 10:09:06 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resolved Tickets Page</title>
    </head>
    <script>
        function sendFeedback(ticketID) {
        window.location.href = 'FeedbackForm.jsp?ticketID=' + ticketID;
        }
        </script>
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
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        td {
            background-color: #fff;
        }
        
        th {
            background-color: #F4f4f4;
        }
        body{
            background-color: #FF4D62;
        }
        .btnFeedback{
            margin-top: 5px;
                padding: 10px 20px;
                background-color: black;
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-bottom: 5px; /* Add padding at the bottom */
        }
        .btnFeedback:hover{
            background-color: #FF4D62;
        }
    </style>
    <body>
<div class="title">
    <a href="UserPage.jsp" class="back-button">&#8592</a>
    <div class="resolved">Resolved Tickets</div>
</div>
        <br>
<div class="container">
    <div class="section1">
        <table>
            <tr>
                <th>Ticket ID</th>
                <th>Subject</th>
                <th>Agent</th>
                <th>Resolved Date & Time</th>
                <th>Feedback</th>
            </tr>            
<%
    String userID = request.getParameter("userID");
    Connection conn=null;
            PreparedStatement pstmt=null;
            ResultSet rs = null;
            try{
                Class.forName("com.mysql.jdbc.Driver");
                conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","root","admin");
                String query = "Select t.tID, t.subject,t.Resolution_DateTime, a.username AS assignedTo from TICKET t INNER JOIN AGENTS a ON t.Agent = a.agentID where TicketStatus='CLOSED' AND  uID=?";
                pstmt=conn.prepareStatement(query);
                pstmt.setString(1, userID);
                rs = pstmt.executeQuery();
                while(rs.next()) {
%>            
            <tr>
                <td><%= rs.getString("tID") %></td>
                <td><%= rs.getString("subject") %></td>
                <td><%= rs.getString("assignedTo") %></td>
                <td><%= rs.getString("Resolution_DateTime") %></td>
                <td><button class="btnFeedback" onclick="sendFeedback('<%= rs.getString("tID") %>')">Feedback</button></td>
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

