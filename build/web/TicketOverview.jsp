<%-- 
    Document   : TicketOverview
    Created on : 25-Feb-2024, 5:48:22 pm
    Author     : Sneha
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Ticket Overview</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        .high-priority { background-color: red; }
        .medium-priority { background-color: orange; }
        .low-priority { background-color: pink; }
        .task-bar { display: none; }
    </style>
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
        .overview{
            margin: 0 auto;
        }
        body{
            background-color: #C9E9EF;
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
            background-color: #f2f2f2;
        }
        .task-bar {
                display: none;
                background:none;
                border: none;
                border-radius: 5px;
                padding: 10px;
                justify-content: center;
            }
            .task-bar button {
                background-color: black;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin: 0 5px;
                font-size: 16px;
                margin-right: 10px;
            }

        .task-bar button:hover {
            background-color: white;
            color:black;
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
        function toggleTaskBar() {
            var checkBoxes = document.querySelectorAll('input[type="checkbox"]');
            var taskBar = document.getElementById('task-bar');
            
            var anyChecked = false;
            checkBoxes.forEach(function(checkbox) {
                if (checkbox.checked) {
                    anyChecked = true;
                }
            });

            if (anyChecked) {
                taskBar.style.display = 'block';
            } else {
                taskBar.style.display = 'none';
            }
        }
    </script>
</head>
<body>

    <div class="title">
        <a href="AgentPage.jsp" class="back-button">&#8592</a>
        <div class="overview">Ticket Overview</div>
    </div>
     <div id="task-bar" class="task-bar">
        <button onclick="openTicket()">Open</button>
        <button onclick="closeTicket()">Close</button>
        <button onclick="deleteTicket()">Delete</button>
        <button onclick="reassignTicket()">Re-assign</button>
    </div>
    <div class="priority-bar">
                    <div class="priority-box high-priority"></div>
                    <span>High Priority</span>
                    <div class="priority-box medium-priority"></div>
                    <span>Medium Priority</span>
                    <div class="priority-box low-priority"></div>
                    <span>Low Priority</span>
    </div> <br>
    <table style="background-color: white">
        <tr>
            <th>Select</th>
            <th>Ticket ID</th>
            <th>Requester</th>
            <th>Subject</th>
            <th>Priority</th>
            <th>Status</th>
            <th>Creation Date</th>
        </tr>
<% 
            String agentID = (String) session.getAttribute("agentID");
            Connection conn=null;
            PreparedStatement pstmt=null;
            ResultSet rs = null;
            try{
                Class.forName("com.mysql.jdbc.Driver");
                conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","admin");
                String query = "SELECT tID, username, subject, Priority, TicketStatus, Creation_Date FROM TICKET t INNER JOIN USERS u ON t.uID = u.userID where Agent=?";
                pstmt=conn.prepareStatement(query);
                pstmt.setString(1, agentID);
                rs = pstmt.executeQuery();
                while(rs.next()) {
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
            <td><input type="checkbox" name="ticketCheckbox" onchange="toggleTaskBar()"></td>
            <td><%= rs.getString("tID") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("subject") %></td>
            <td class="<%= priorityClass %>"></td>
            <td><%= rs.getString("TicketStatus") %></td>
            <td><%= rs.getTimestamp("Creation_Date") %></td>
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
     <script>
        function openTicket() {
            var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
        
        
            var ticketIDs = [];
            checkedCheckboxes.forEach(function(checkbox) {
                ticketIDs.push(checkbox.parentNode.nextElementSibling.textContent); // Assuming Ticket ID is in the next cell
            });
            var agentID = '<%= session.getAttribute("agentID") %>';
        
            if (ticketIDs.length > 0) {
                window.location.href = 'OpenTicket.jsp?agentID=' + agentID + '&ticketIDs=' + ticketIDs.join(',');
            } else {
                alert('Please select at least one ticket to open.');
            }
        }

        function closeTicket() {
           var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
            var ticketIDs = [];

            checkedCheckboxes.forEach(function(checkbox) {
                ticketIDs.push(checkbox.parentNode.nextElementSibling.textContent.trim());
            });

            if (ticketIDs.length > 0) {
                console.log(ticketIDs); // Debugging: Check if the correct ticket IDs are being sent

                $.ajax({
                    type: 'POST',
                    url: 'CloseTicket2.jsp',
                    data: { ticketIDs: ticketIDs.join(',') },
                    success: function(response) {
                        alert('Ticket(s) closed successfully');
                        window.location.reload(); // Reload the page after closing the tickets
                    },
                    error: function(xhr, status, error) {
                        console.error(xhr.responseText); // Log the error message
                        alert('Error closing ticket(s)');
                    }
                });
            } else {
                alert('Please select at least one ticket to close.');
            }
        }
        

        function deleteTicket() {
            var redirect="agent";
            var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
        
        
            var ticketIDs = [];
            checkedCheckboxes.forEach(function(checkbox) {
                ticketIDs.push(checkbox.parentNode.nextElementSibling.textContent); // Assuming Ticket ID is in the next cell
            });

        
            if (ticketIDs.length > 0) {
                window.location.href = 'DeleteTicket.jsp?ticketIDs=' + ticketIDs.join(',')+ '&redirect='+ redirect;
            } else {
                alert('Please select at least one ticket to open.');
            }
        }

        function reassignTicket() {
            var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
            var ticketIDs = [];

            checkedCheckboxes.forEach(function(checkbox) {
                ticketIDs.push(checkbox.parentNode.nextElementSibling.textContent.trim());
            });

            if (ticketIDs.length > 0) {
                var newAgentID = prompt('Enter the new agent ID:');
                if (newAgentID) {
                    $.ajax({
                        type: 'POST',
                        url: 'ReassignTicket.jsp',
                        data: { ticketIDs: ticketIDs.join(','), newAgentID: newAgentID },
                        success: function(response) {
                            alert('Ticket(s) reassigned successfully');
                            window.location.reload(); // Reload the page after re-assignment
                        },
                        error: function(xhr, status, error) {
                            console.error(xhr.responseText);
                            alert('Error reassigning ticket(s)');
                        }
                    });
                }
            } else {
                alert('Please select at least one ticket to reassign.');
            }
        }
        
    </script>
</body>
</html>
