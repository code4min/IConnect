<%-- 
    Document   : overdue_tickets
    Created on : 03-Apr-2024, 11:16:44 pm
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
        <title>Overdue Tickets Page</title>
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
        .overdue{
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
            background-color: #6CA47B; 
            padding: 10px; 
            border-bottom: 1px solid #ddd;
        }

        .task-bar button {
            background-color: #39744A; 
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
            background-color: black;
            color: white;
        }
        .notification{
                background-color: #DFDFDF;
                width: 100%;
                display: none;
                padding: 20px; 
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Add shadow for depth */
                color: black;
                text-align: center; /* Center align text */
                box-sizing: border-box; /* Include padding and border in the width */
            }
            
            .notification-container{
                background-color: white;
                max-width: 500px;
                margin: 0 auto;
                border-radius: 10px;
                padding: 20px;
            }
            .notification form {
                display: inline-block;
                text-align: left; 
                margin-left: 20px;/* Align form elements to the left */
            }
            .notification form label {
                display: inline-block; /* Make labels and input elements inline */
                width: 100px; /* Adjust width as needed */
                margin-bottom: 5px;
                font-size: 16px;
                font-weight: bold;
            }
            .notification input[type="text"] {
                display: inline-block;
                vertical-align: middle;
                margin-top: 10px;
                margin-bottom: 10px;
                padding: 10px;
                border: none;
                border-radius: 5px;
                width: 200px; /* Adjust width as needed */
                font-size: 16px;
            }
            .notification form input[type="submit"] {
                margin-top: 10px;
                padding: 10px;
                background-color: black;
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-bottom: 10px;
                padding-right: 10px;
                margin-left: 185px;
            }
            .notification form input[type="submit"]:hover {
                background-color: #00BD62;
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
<script>
            // Check if the URL parameter indicates successful registration and display an alert
            if ('<%= request.getParameter("creation") %>' === 'success') {
                alert('NOTIFICATION SENT SUCCESSFULLY!');
            }
        </script>
    </head>
    <body>
        <div class="title">
        <a href="TicketManagement.jsp" class="back-button">&#8592</a>
        <div class="overdue">Overdue Tickets</div>
    </div>
        <div class="priority-bar">
                    <div class="priority-box high-priority"></div>
                    <span>High Priority</span>
                    <div class="priority-box medium-priority"></div>
                    <span>Medium Priority</span>
                    <div class="priority-box low-priority"></div>
                    <span>Low Priority</span>
    </div>
        <div class="task-bar">
                <button onclick="createNotification()">Send Notification</button>
        </div><br>
        <div class="notification" id="createNotification">
            <br>
<%
    String selectedTicketID = request.getParameter("selectedTicketID");
    String selectedAgentID = request.getParameter("selectedAgentID");
%>
             <div class="notification-container">
            <form action='Notification_Sent.jsp' method='post'>
            <label for='Agent'>To Agent:</label>
            <input type="text" name="selectedAgentID" id="selectedAgentID" readonly><br><br>
            <label for='TicketID'>For Ticket :</label>
            <input type="text" name="selectedTicketID" id="selectedTicketID" readonly><br><br>
            <label for='Message'>Notification :</label>
            <input type="text" name="message" id="message" readonly>
            <input type='submit' value='Notify'>
            </form>
        </div>
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
                    <th>Agent ID</th>
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
        pstmt = conn.prepareStatement("SELECT t.tID,t.tType,t.TicketStatus,t.Priority, t.Agent, t.subject,u.username AS createdBy, a.username AS assignedTo FROM TICKET t JOIN USERS u ON t.uID = u.userID JOIN AGENTS a ON t.Agent = a.agentID WHERE t.due_date < CURDATE() ORDER BY tID DESC ");
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
            <td><%= rs.getString("Agent") %></td>
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
<script>
function createNotification(){
       var checkboxes = document.getElementsByName("tCheckbox");
    var selectedTicketID = null;
    var selectedAgentID = null;
    for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                selectedTicketID = checkboxes[i].parentNode.parentNode.cells[1].innerText;
                selectedAgentID =checkboxes[i].parentNode.parentNode.cells[8].innerText;// Store the selected user ID
            }
        }
    if (selectedTicketID !==null && selectedAgentID!==null) {
            // Set the selectedUserID in the hidden input field
            document.getElementById("selectedTicketID").value = selectedTicketID;
            document.getElementById("selectedAgentID").value = selectedAgentID;
            
            var messageField = document.getElementById("message");
        messageField.value = "Ticket with ID " + selectedTicketID + " is overdue";
        
            var notifyForm = document.getElementById("createNotification");
            notifyForm.style.display = "block";
            notifyForm.scrollIntoView();
        } else {
            alert("Please select at least one ticket.");
        }    }
    </script>