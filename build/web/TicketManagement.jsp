<%-- 
    Document   : TicketManagement
    Created on : 27-Mar-2024, 6:05:49 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ticket Management</title>
        <link rel="stylesheet" type="text/css" href="Admin_Page.css">
        <script>
            // Check if the URL parameter indicates successful registration and display an alert
            if ('<%= request.getParameter("ticket_updated") %>' === 'success') {
                alert('TICKET UPDATED SUCCESSFULLY!');
            }
        </script>

        
        <script>
            
        function toggleSlideMenu() {
            var SlideMenu = document.getElementById("SlideMenu");
            var ticketContent = document.getElementById("ticketContent");
  
  
            if (SlideMenu.style.left === "0px") {
            SlideMenu.style.left = "-250px";
            ticketContent.style.marginLeft = "0";
            } else {
            SlideMenu.style.left = "0px";
            ticketContent.style.marginLeft = "250px";
            }
        }
        

    function editTickets() {
         var checkboxes = document.getElementsByName("tCheckbox");
            var selectedTicketId = null;

            // Find the selected ticket
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    selectedTicketId = checkboxes[i].parentNode.parentNode.cells[1].innerText;
                    break;
                }
            }

            if (selectedTicketId) {
                // Redirect to edit page with ticket ID
                window.location.href = "edit_ticket.jsp?ticketId=" + selectedTicketId;
            } else {
                alert("Please select a ticket to edit.");
            }
       
    }

    function deleteTickets() {
        var checkboxes = document.getElementsByName("tCheckbox");
        var selectedTicketIds = [];

        // Find the selected tickets and store their IDs
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                var ticketId = checkboxes[i].parentNode.parentNode.cells[1].innerText;
                selectedTicketIds.push(ticketId);
            }
        }

        if (selectedTicketIds.length > 0) {
            // Redirect to delete page with ticket IDs
            window.location.href = "DeleteTicketByAdmin.jsp?ticketIds=" + selectedTicketIds.join(",");
        } else {
            alert("Please select at least one ticket to delete.");
        }
    }



  
        function assignTickets() {
            var checkboxes = document.getElementsByName("tCheckbox");
            var selectedTicketIds = [];

            // Find the selected tickets and store their IDs
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    var ticketId = checkboxes[i].parentNode.parentNode.cells[1].innerText;
                    selectedTicketIds.push(ticketId);
                }
            }

            if (selectedTicketIds.length > 0) {
                // Prompt for agent ID
                var agentId = prompt("Enter Agent ID:");

                // If agent ID is provided and not null
                if (agentId !== null && agentId.trim() !== "") {
                    // Redirect to reassign page with ticket IDs and agent ID
                    window.location.href = "ReassignTicket2.jsp?ticketIds=" + selectedTicketIds.join(",") + "&agentId=" + agentId;
                } else {
                    alert("Agent ID is required.");
                }
            } else {
                alert("Please select at least one ticket to assign.");
            }
        }
</script>
<style>
        .high-priority { background-color: red; }
        .medium-priority { background-color: orange; }
        .low-priority { background-color: pink; }
        .task-bar { display: none; } 
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
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
        .back-arrow {
            position: absolute;
            right: 10px;
            background: none;
            color: white;
            font-size: 35px;
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
    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has("deletion") && urlParams.get("deletion") === "success") {
        // Display an alert box with the message "Mail sent successfully"
        alert("Ticket Closed successfully!");
    }
</script>
    </head>
    <body>       
        <div class="title">
            <button class="menu-btn" onclick="toggleSlideMenu()">&#9776;</button>
            TICKET MANAGEMENT
            <a href="AdminPage.jsp"><span class="back-arrow">&#128072;</span></a>
        </div>
        <div class="slide-menu-container" id="SlideMenu">
        <div class="slide-menu">
            <br>
            <a href="resolved_tickets.jsp?adminID=<%= session.getAttribute("adminID") %>">Resolved Tickets</a>
            <a href="unresolved_tickets.jsp?adminID=<%= session.getAttribute("adminID") %>">Unresolved Tickets</a>
            <a href="reassigned_tickets.jsp?adminID=<%= session.getAttribute("adminID") %>">Reassigned Tickets</a>
            <a href="overdue_tickets.jsp?adminID=<%= session.getAttribute("adminID") %>">Overdue Tickets</a>
         </div>
        </div>
        <div class="priority-bar">
                    <div class="priority-box high-priority"></div>
                    <span>High Priority</span>
                    <div class="priority-box medium-priority"></div>
                    <span>Medium Priority</span>
                    <div class="priority-box low-priority"></div>
                    <span>Low Priority</span>
    </div>
        <div class="ticket-content" id="ticketContent">
            <div class="task-bar">
                <button onclick="view()">View</button>
                <button onclick="editTickets()">Edit</button>
                <button onclick="deleteTickets()">Delete</button>
                <button onclick="assignTickets()">Assign</button>
                <button onclick="addComments()">Add Comments</button>
                <button onclick="addNotes()">Add Notes</button>
                <button onclick="closeTicket()">Close Ticket</button>
            </div>
            <br>
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
        pstmt = conn.prepareStatement("SELECT t.tID,t.tType,t.TicketStatus,t.Priority, t.subject,u.username AS createdBy, a.username AS assignedTo FROM TICKET t JOIN USERS u ON t.uID = u.userID JOIN AGENTS a ON t.Agent = a.agentID ORDER BY tID DESC ");
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
        </div>
    </body>
</html>
<script>
    function view() {
            var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
            var ticketIDs = [];
            checkedCheckboxes.forEach(function(checkbox) {
                ticketIDs.push(checkbox.parentNode.nextElementSibling.textContent); // Assuming Ticket ID is in the next cell
            });
            var adminID = '<%= session.getAttribute("adminID") %>';

            if (ticketIDs.length > 0) {
                window.location.href = 'ViewTicketAdmin.jsp?adminID=' + adminID + '&ticketIDs=' + ticketIDs.join(',');
            } else {
                alert('Please select at least one ticket to open.');
            }
        }

</script>
<script>
    function addComments() {
            var checkboxes = document.getElementsByName("tCheckbox");
            var selectedTicketId = null;

            // Find the selected ticket
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    selectedTicketId = checkboxes[i].parentNode.parentNode.cells[1].innerText;
                    break;
                }
            }

            if (selectedTicketId) {
                // Redirect to edit page with ticket ID
                window.location.href = "AddComments_Admin.jsp?ticketId=" + selectedTicketId;
            } else {
                alert("Please select a ticket to edit.");
            }
        }

</script>
<script>
    function addNotes() {
            var checkboxes = document.getElementsByName("tCheckbox");
            var selectedTicketId = null;

            // Find the selected ticket
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    selectedTicketId = checkboxes[i].parentNode.parentNode.cells[1].innerText;
                    break;
                }
            }

            if (selectedTicketId) {
                // Redirect to edit page with ticket ID
                window.location.href = "AddNotes_Admin.jsp?ticketId=" + selectedTicketId;
            } else {
                alert("Please select a ticket to edit.");
            }
        }

</script>
<script>
    function closeTicket() {
            var checkboxes = document.getElementsByName("tCheckbox");
            var selectedTicketId = null;

            // Find the selected ticket
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    selectedTicketId = checkboxes[i].parentNode.parentNode.cells[1].innerText;
                    break;
                }
            }

            if (selectedTicketId) {
                // Redirect to edit page with ticket ID
                window.location.href = "CloseTicketAdmin.jsp?ticketId=" + selectedTicketId;
            } else {
                alert("Please select a ticket to edit.");
            }
        }

</script>