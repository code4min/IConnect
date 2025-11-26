<%-- 
    Document   : AgentPage
    Created on : 21-Feb-2024, 6:25:04 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%
     String agentID = request.getParameter("agentID");
            if (agentID == null) {
                agentID = (String) session.getAttribute("agentID");
            }
%> 
<%
    int[] ticketCounts = new int[12];
    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    int openedCount = 0;
    int totalCount = 0;
    int resolvedCount = 0;
    int overdueCount=0;
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","root","admin");
        
        String totalCountQuery = "SELECT COUNT(*) AS total FROM TICKET WHERE Agent = ?";
        pstmt = conn.prepareStatement(totalCountQuery);
        pstmt.setString(1, agentID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            totalCount = rs.getInt("total");
        }

        // Query to get count of resolved tickets raised by the user
        String openedCountQuery = "SELECT COUNT(*) AS opened FROM TICKET WHERE Agent = ? AND TicketStatus = 'OPEN'";
        pstmt = conn.prepareStatement(openedCountQuery);
        pstmt.setString(1, agentID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            openedCount = rs.getInt("opened");
        }
        
        String resolvedCountQuery = "SELECT COUNT(*) AS resolved FROM TICKET WHERE Agent = ? AND TicketStatus = 'CLOSED'";
        pstmt = conn.prepareStatement(resolvedCountQuery);
        pstmt.setString(1, agentID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            resolvedCount = rs.getInt("resolved");
        }
        
        
        String overdueCountQuery = "SELECT COUNT(*) AS overdue FROM TICKET WHERE Agent = ? AND TicketStatus <> 'CLOSED' AND due_date < CURDATE()";
        pstmt = conn.prepareStatement(overdueCountQuery);
        pstmt.setString(1, agentID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            overdueCount = rs.getInt("overdue");
        }

        
        String monthquery = "SELECT MONTH(Creation_Date) AS month, COUNT(*) AS count " +
                            "FROM TICKET " +
                            "WHERE Agent = ? " +
                            "GROUP BY MONTH(Creation_Date)";
            pstmt = conn.prepareStatement(monthquery);
            pstmt.setString(1, agentID);
            rs = pstmt.executeQuery();

            // Iterate through the result set to populate ticketCounts array
            while (rs.next()) {
                int month = rs.getInt("month");
                int count = rs.getInt("count");
                // Month index starts from 0
                ticketCounts[month - 1] = count;
            }
            
            
        String query = "SELECT * FROM TICKET WHERE Agent = ?";
        pstmt=conn.prepareStatement(query);
        pstmt.setString(1, agentID);
        rs = pstmt.executeQuery();
        
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agent Page</title>
        <link rel="stylesheet" type="text/css" href="AgentPage.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            function toggleSlideMenu() {
            var SlideMenu = document.getElementById("Agent_slideMenu");
            var mainContent= document.getElementById("mainContent");
  
  
            if (SlideMenu.style.left === "0px") {
            SlideMenu.style.left = "-250px";
            mainContent.style.marginLeft = "0";
            } else {
            SlideMenu.style.left = "0px";
            mainContent.style.marginLeft = "250px";
            }
        }
        </script>
        <style>
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
            .pieContainer1, .pieContainer2{
            margin-right: 25px;
        }

        .pieContainer1,.pieContainer2, .pieContainer3{
            display: inline-block; 
            vertical-align: top;
            background-color: #C1E4CC;
            padding: 30px;
            max-width: 450px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .pieContainer1 h2, .pieContainer2 h2, .pieContainer3 h2, .graphContainer h2{
            text-align: center;
        }
        .graphContainer{
             background-color: #C1E4CC;
            margin-top: 20px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        </style>
    </head>
    <body>
        <div class="title" style="background-color:  #71CBBB">
            <button class="menu-btn" onclick="toggleSlideMenu()">&#9776;</button>
            Overview
        </div>
        <div class="slide-menu-container" id="Agent_slideMenu">
        <div class="slide-menu">
            <a href="AgentPage.jsp?agentID=<%= session.getAttribute("agentID") %>">Overview</a>
            <a href="TicketOverview.jsp?agentID=<%= session.getAttribute("agentID") %>">Ticket Overview</a>
            <a href="Analysis.jsp?agentID=<%= session.getAttribute("agentID") %>">Reports & Analysis</a>
            <a href="Notifications.jsp?agentID=<%= session.getAttribute("agentID") %>">Notifications</a>
            <a href="AContact.jsp?agentID=<%= session.getAttribute("agentID") %>">Contact</a>
            <a href="AgentProfile.jsp?agentID=<%= session.getAttribute("agentID") %>">Agent Profile</a>
            
         </div>
        </div>
        
        <div class="main-content" id="mainContent">
            <div class="subtitle2">Analysis</div>
            <div class="pieContainer1">
                <h2>Tickets Opened</h2>
                <canvas id="ticketChart1" width="380" height="400"></canvas>
            </div>
            
            <div class="pieContainer2">
                <h2>Tickets Resolved</h2>
                <canvas id="ticketChart2" width="380" height="400"></canvas>
            </div>
            
            <div class="pieContainer3">
                <h2>Tickets Overdue</h2>
                <canvas id="ticketChart3" width="380" height="400"></canvas>
            </div>
            
            <div class="graphContainer">
               <h2>Tickets Assigned per Month</h2>
                <canvas id="ticketChart4" width="800" height="250"></canvas> 
            </div>
        </div>
    </body>
</html>
<script>
    // Calculate the number of resolved tickets and total tickets raised
    var openedCount = <%= openedCount %>;
    var totalCount = <%= totalCount %>;

    // Get the canvas element
    var ctx = document.getElementById('ticketChart1').getContext('2d');

    // Create the pie chart
    var ticketChart1 = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Opened', 'Total'],
            datasets: [{
                data: [openedCount, totalCount - openedCount],
                backgroundColor: [
                    '#408986', // Color for resolved tickets
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
    // Calculate the number of resolved tickets and total tickets raised
    var resolvedCount = <%= resolvedCount %>;
    var totalCount = <%= totalCount %>;

    // Get the canvas element
    var ctx = document.getElementById('ticketChart2').getContext('2d');

    // Create the pie chart
    var ticketChart2 = new Chart(ctx, {
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
    // Calculate the number of resolved tickets and total tickets raised
    var overdueCount = <%= overdueCount %>;
    var totalCount = <%= totalCount %>;

    // Get the canvas element
    var ctx = document.getElementById('ticketChart3').getContext('2d');

    // Create the pie chart
    var ticketChart3 = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Overdue', 'Total'],
            datasets: [{
                data: [overdueCount, totalCount - overdueCount],
                backgroundColor: [
                    'red', 
                    'white' 
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
        var ctx = document.getElementById('ticketChart4').getContext('2d');

        // Create the bar graph
        var ticketChart4 = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Tickets Assigned',
                    data: [<%= ticketCounts[0] %>, <%= ticketCounts[1] %>, <%= ticketCounts[2] %>, <%= ticketCounts[3] %>,
                           <%= ticketCounts[4] %>, <%= ticketCounts[5] %>, <%= ticketCounts[6] %>, <%= ticketCounts[7] %>,
                           <%= ticketCounts[8] %>, <%= ticketCounts[9] %>, <%= ticketCounts[10] %>, <%= ticketCounts[11] %>],
                    backgroundColor: '#71CBBB',
                    borderColor: '#71CBBB',
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
