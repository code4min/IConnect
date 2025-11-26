<%-- 
    Document   : UserPage
    Created on : 21-Feb-2024, 6:24:48 pm
    Author     : Sneha
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%
     String userID = request.getParameter("userID");
            if (userID == null) {
                userID = (String) session.getAttribute("userID");
            }
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String password = (String) session.getAttribute("password");
    if (userID == null) {
        response.sendRedirect("HomePage.jsp");
    }
%>
<% 
     int[] ticketCounts = new int[12];
    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    int resolvedCount = 0;
    int totalCount = 0;
    int hardwareCount = 0;
    int applicationCount = 0;
    int osCount = 0;
    int networkCount = 0;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
        
        String monthquery = "SELECT MONTH(Creation_Date) AS month, COUNT(*) AS count " +
                            "FROM TICKET " +
                            "WHERE uID = ? " +
                            "GROUP BY MONTH(Creation_Date)";
            pstmt = conn.prepareStatement(monthquery);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();

            // Iterate through the result set to populate ticketCounts array
            while (rs.next()) {
                int month = rs.getInt("month");
                int count = rs.getInt("count");
                // Month index starts from 0
                ticketCounts[month - 1] = count;
            }
            
        String totalCountQuery = "SELECT COUNT(*) AS total FROM TICKET WHERE uID = ?";
        pstmt = conn.prepareStatement(totalCountQuery);
        pstmt.setString(1, userID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            totalCount = rs.getInt("total");
        }

        // Query to get count of resolved tickets raised by the user
        String resolvedCountQuery = "SELECT COUNT(*) AS resolved FROM TICKET WHERE uID = ? AND TicketStatus = 'CLOSED'";
        pstmt = conn.prepareStatement(resolvedCountQuery);
        pstmt.setString(1, userID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            resolvedCount = rs.getInt("resolved");
        }
        
        String typequery = "SELECT COUNT(*) AS count, tType FROM TICKET GROUP BY tType";
        pstmt = conn.prepareStatement(typequery);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            int count = rs.getInt("count");
            int tType = rs.getInt("tType");
            switch (tType) {
                case 1:
                    hardwareCount = count;
                    break;
                case 2:
                    applicationCount = count;
                    break;
                case 3:
                    osCount = count;
                    break;
                case 4:
                    networkCount = count;
                    break;
                // Add more cases if there are additional departments
            }
        }
        
        String query = "SELECT * FROM TICKET WHERE uID = ?";
        pstmt=conn.prepareStatement(query);
        pstmt.setString(1, userID);
        rs = pstmt.executeQuery();
        
        
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
        <link rel="stylesheet" type="text/css" href="userpage.css">
        <script>
        function viewTicket(ticketID) {
        window.location.href = 'ViewTicket.jsp?ticketID=' + ticketID;
        }
        </script>
        <script>
            function toggleSlideMenu() {
            var SlideMenu = document.getElementById("User_slideMenu");
            var graphContent = document.getElementById("user_graphContent");
  
  
            if (SlideMenu.style.left === "0px") {
            SlideMenu.style.left = "-250px";
            graphContent.style.marginLeft = "0";
            } else {
            SlideMenu.style.left = "0px";
            graphContent.style.marginLeft = "250px";
            }
        }
         
         function updateTicket() {
            var ticketID = prompt("Enter the ID of the ticket to be updated:");
            if (ticketID) {
                window.location.href = "UpdateTicket.jsp?ticketID=" + ticketID;
            }
        }
        function toggleTaskBar() {
            var checkboxes = document.getElementsByName("TicketCheckbox");
            var taskbar = document.getElementById("taskbar");

            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    taskbar.style.display = "flex";
                    return;
                }
            }
            taskbar.style.display = "none";
        }
        function view() {
            var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
            var ticketIDs = [];
            checkedCheckboxes.forEach(function(checkbox) {
                ticketIDs.push(checkbox.parentNode.nextElementSibling.textContent); // Assuming Ticket ID is in the next cell
            });
            var userID = '<%= session.getAttribute("userID") %>';

            if (ticketIDs.length > 0) {
                window.location.href = 'ViewTicket.jsp?userID=' + userID + '&ticketIDs=' + ticketIDs.join(',');
            } else {
                alert('Please select at least one ticket to open.');
            }
        }
        
         function addComment() {
            var checkboxes = document.getElementsByName("TicketCheckbox");
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
                window.location.href = "AddComments_User.jsp?ticketId=" + selectedTicketId;
            } else {
                alert("Please select a ticket to edit.");
            }
        }
        
        
        function deleteTicket() {
            var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
            var ticketIDs = [];
            checkedCheckboxes.forEach(function(checkbox) {
                ticketIDs.push(checkbox.parentNode.nextElementSibling.textContent.trim()); // Assuming Ticket ID is in the next cell
            });

            if (ticketIDs.length > 0) {
                window.location.href = 'DeleteTicketByUser.jsp?ticketIDs=' + ticketIDs.join(',');
            } else {
                alert('Please select at least one ticket to delete.');
            }
        }
        </script>
        <script>
            // Check if the URL parameter indicates successful registration and display an alert
            if ('<%= request.getParameter("submitted") %>' === 'success') {
                alert('TICKET SUBMITTED SUCCESSFULLY!');
            }
        </script>
        <style>
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
                background-color:#4CAF50;
                color: white;
            }
            td{
                background-color:#C9E1BF;
            }
            .subtitle1, .subtitle2{
                background-color: black;
                color:white;
                border-radius: 10px;
                text-align: center;
                margin-bottom: 20px;
                padding: 10px;
                font-size: 20px;
                font-weight: bold;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .subtitle2{
                margin-top: 20px;
                margin-bottom: 20px;
            }
            .taskbar {
                display: none;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            background-color: #f2f2f2; /* Match the background color of the table header */
            padding: 10px; /* Adjust padding as needed */
            border-bottom: 1px solid #ddd;
            }
            .taskbar button {
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
            transition-duration: 0.4s;
        }

        .taskbar button:hover {
            background-color: #FF455B;
        }
        .pieContainer1{
            margin-right: 50px;
            margin-left: 120px;
        }

        .pieContainer1,.pieContainer2{
            display: inline-block; 
            vertical-align: top;
            background-color: #D7EAF1;
            padding: 30px;
            max-width: 500px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .pieContainer1 h2, .pieContainer2 h2, .graphContainer h2{
            text-align: center;
        }
        .graphContainer{
             background-color: #FFD3DC;
            margin-top: 20px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        </style>
        <style>
        .high-priority { background-color: red; }
        .medium-priority { background-color: orange; }
        .low-priority { background-color: pink; }
        .task-bar { display: none; }
    </style>
    <style>
  /* CSS for the priority information bar */
  .priority-bar {
    position: relative;
    background-color: white;
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
    </head>
    <body>

    <div class="title">
            <button class="menu-btn" onclick="toggleSlideMenu()">&#9776;</button>
            Overview
    </div>
        <br>
    <div class="slide-menu-container" id="User_slideMenu">
        <div class="slide-menu">
            <a href="UserPage.jsp?userID=<%= session.getAttribute("userID") %>">Overview</a>
            <a href="RaiseTicket.jsp?userID=<%= session.getAttribute("userID") %>">Raise Ticket</a>
            <a href="#" onclick="updateTicket()">Update Ticket</a>
            <a href="UContact.jsp?userID=<%= session.getAttribute("userID") %>">Contact</a>
            <a href="ResolvedTickets.jsp?userID=<%= session.getAttribute("userID") %>">Resolved  Tickets</a>
            <a href="Feedback.jsp?userID=<%= session.getAttribute("userID") %>">Feedback</a>
            <a href="UserProfile.jsp?userID=<%= session.getAttribute("userID") %>">User Profile</a>

         </div>
        </div>
        <div class="graph-content" id="user_graphContent">
            <div class="section1">
                <div class="subtitle1">Ticket History</div>
                <div class="taskbar" id="taskbar">
                    <button onclick="view()">View</button>
                    <button onclick="addComment()">Comment</button>
                    <button onclick="deleteTicket()">Delete</button>
                </div>
                
                <form id="commentForm" method="post" style="display: none;">
                    <input type="hidden" name="TicketIDs" id="TicketIDs">
                </form>
                
                <div class="priority-bar">
                    <div class="priority-box high-priority"></div>
                    <span>High Priority</span>
                    <div class="priority-box medium-priority"></div>
                    <span>Medium Priority</span>
                    <div class="priority-box low-priority"></div>
                    <span>Low Priority</span>
                </div> 
                <table>
                <thead>
            <tr>
                <th>Select</th>
                <th>Ticket ID</th>
                <th>Ticket Type</th>
                <th>Ticket Priority</th>
                <th>Ticket Status</th>
                <th>Creation Date & Time</th>
                <th>Ticket Subject</th>
            </tr>
        </thead>
        <tbody>
<%
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
                <td><input type="checkbox" name="TicketCheckbox" onchange="toggleTaskBar()"></td>
                <td><%= rs.getString("tID") %></td>
                <td><%= rs.getString("tType") %></td>
                <td class="<%= priorityClass %>"></td>
                <td><%= rs.getString("TicketStatus") %></td>
                <td><%= rs.getString("Creation_Date") %></td>
                <td><%= rs.getString("subject") %></td>
              
            </tr>
<%
        }
%>
    </tbody>
    </table>
            </div>
            
        <div class="section2">
            <div class="subtitle2">Analysis</div>
            <div class="pieContainer1">
                <h2>Tickets Resolved</h2>
                <canvas id="ticketChart" width="400" height="400"></canvas>
            </div>
            
            <div class="pieContainer2">
                <h2>Types of ticket created</h2>
                <canvas id="ticketChart2" width="450" height="400"></canvas>
            </div>
            <div class="graphContainer">
               <h2>Tickets Raised per Month</h2>
                <canvas id="ticketChart3" width="800" height="250"></canvas> 
            </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Calculate the number of resolved tickets and total tickets raised
    var resolvedCount = <%= resolvedCount %>;
    var totalCount = <%= totalCount %>;

    // Get the canvas element
    var ctx = document.getElementById('ticketChart').getContext('2d');

    // Create the pie chart
    var ticketChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Resolved', 'Pending'],
            datasets: [{
                data: [resolvedCount, totalCount - resolvedCount],
                backgroundColor: [
                    'green', // Color for resolved tickets
                    'white' // Color for pending tickets
                ]
            }]
        },
        options: {
            title: {
                display: true,
                text: 'Ticket Resolution Status'
            },
            responsive: false, // Disable responsiveness
            maintainAspectRatio: false, // Don't maintain aspect ratio
            height: 200, // Set the height
            width: 200
        }
    });
</script>
<script>
        // Get the canvas element
        var ctx = document.getElementById('ticketChart2').getContext('2d');

        // Create the pie chart
        var ticketChart2 = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: ['Hardware', 'Application', 'Operating System', 'Network'],
                datasets: [{
                    data: [<%= hardwareCount %>, <%= applicationCount %>, <%= osCount %>, <%= networkCount %>],
                    backgroundColor: [
                        'pink', // Color for Hardware
                        'green', // Color for Application
                        'orange', // Color for Operating System
                        'red' // Color for Network
                    ]
                }]
            },
            options: {
                title: {
                    display: true,
                    text: 'Ticket Department Distribution'
                },
            
                responsive: false, // Disable responsiveness
                maintainAspectRatio: false, // Don't maintain aspect ratio
                height: 200, // Set the height
                width: 300
            }
        });
    </script>
    <script>
        // Get the canvas element
        var ctx = document.getElementById('ticketChart3').getContext('2d');

        // Create the bar graph
        var ticketChart3 = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Tickets Raised',
                    data: [<%= ticketCounts[0] %>, <%= ticketCounts[1] %>, <%= ticketCounts[2] %>, <%= ticketCounts[3] %>,
                           <%= ticketCounts[4] %>, <%= ticketCounts[5] %>, <%= ticketCounts[6] %>, <%= ticketCounts[7] %>,
                           <%= ticketCounts[8] %>, <%= ticketCounts[9] %>, <%= ticketCounts[10] %>, <%= ticketCounts[11] %>],
                    backgroundColor: '#FD3B64',
                    borderColor: '#FD3B64',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });
    </script>
    </div>
    </body>
</html>
 <%
    } catch (Exception e) {
        out.println("error :"+e.getMessage());
    } finally {
        // Close database connection
        if (conn != null) {
            try {
                conn.close();
            } finally{
            out.println(" ");
    }

        }
    }
%>               
        
                