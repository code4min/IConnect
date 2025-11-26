<%-- 
    Document   : AdminPage
    Created on : 21-Feb-2024, 6:25:19 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%
     String adminID = request.getParameter("adminID");
            if (adminID == null) {
                adminID = (String) session.getAttribute("adminID");
            }
%> 
<%
    int[] ticketCounts = new int[12];
    int openedCount = 0;
    int totalCount = 0;
    int resolvedCount = 0;
    int overdueCount=0;
    
    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
        
        String totalCountQuery = "SELECT COUNT(*) AS total FROM TICKET";
        pstmt = conn.prepareStatement(totalCountQuery);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            totalCount = rs.getInt("total");
        }

        // Query to get count of resolved tickets
        String openedCountQuery = "SELECT COUNT(*) AS opened FROM TICKET WHERE TicketStatus = 'OPEN'";
        pstmt = conn.prepareStatement(openedCountQuery);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            openedCount = rs.getInt("opened");
        }
        
        String resolvedCountQuery = "SELECT COUNT(*) AS resolved FROM TICKET WHERE TicketStatus = 'CLOSED'";
        pstmt = conn.prepareStatement(resolvedCountQuery);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            resolvedCount = rs.getInt("resolved");
        }
        
        String overdueCountQuery = "SELECT COUNT(*) AS overdue FROM TICKET WHERE TicketStatus <> 'CLOSED' AND due_date < CURDATE()";
        pstmt = conn.prepareStatement(overdueCountQuery);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            overdueCount = rs.getInt("overdue");
        }

        
        String monthquery = "SELECT MONTH(Creation_Date) AS month, COUNT(*) AS count " +
                            "FROM TICKET " +
                            "GROUP BY MONTH(Creation_Date)";
        pstmt = conn.prepareStatement(monthquery);
        rs = pstmt.executeQuery();

        // Iterate through the result set to populate ticketCounts array
        while (rs.next()) {
            int month = rs.getInt("month");
            int count = rs.getInt("count");
            // Month index starts from 0
            ticketCounts[month - 1] = count;
        }
    } catch (Exception e) {
        out.println("error :"+e.getMessage());
    } finally {
        // Close database connection
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
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
            background-color: #C9E1BF;
            padding: 30px;
            max-width: 450px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .pieContainer1 h2, .pieContainer2 h2, .pieContainer3 h2, .graphContainer h2{
            text-align: center;
        }
        .graphContainer{
             background-color: #C9E1BF;
            margin-top: 20px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        </style>
        <link rel="stylesheet" type="text/css" href="Admin_Page.css">
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Function to create pie chart for opened tickets
        function createOpenedTicketsPieChart() {
            var openedCount = <%= openedCount %>;
            var totalCount = <%= totalCount %>;
            var ctx = document.getElementById('ticketChart1').getContext('2d');

            var ticketChart1 = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Opened', 'Total'],
                    datasets: [{
                        data: [openedCount, totalCount - openedCount],
                        backgroundColor: ['#5CE1E6', 'white']
                    }]
                },
                options: {
                    title: {
                        display: true,
                        text: 'Opened vs Total Tickets'
                    },
                    responsive: false,
                    maintainAspectRatio: false
                }
            });
        }

        // Function to create pie chart for resolved tickets
        function createResolvedTicketsPieChart() {
            var resolvedCount = <%= resolvedCount %>;
            var totalCount = <%= totalCount %>;
            var ctx = document.getElementById('ticketChart2').getContext('2d');

            var ticketChart2 = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Resolved', 'Pending'],
                    datasets: [{
                        data: [resolvedCount, totalCount - resolvedCount],
                        backgroundColor: ['green', 'white']
                    }]
                },
                options: {
                    title: {
                        display: true,
                        text: 'Resolved vs Pending Tickets'
                    },
                    responsive: false,
                    maintainAspectRatio: false
                }
            });
        }

        // Function to create pie chart for overdue tickets
        function createOverdueTicketsPieChart() {
            var overdueCount = <%= overdueCount %>;
            var totalCount = <%= totalCount %>;
            var ctx = document.getElementById('ticketChart3').getContext('2d');

            var ticketChart3 = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Overdue', 'Total'],
                    datasets: [{
                        data: [overdueCount, totalCount - overdueCount],
                        backgroundColor: ['red', 'white']
                    }]
                },
                options: {
                    title: {
                        display: true,
                        text: 'Overdue vs Total Tickets'
                    },
                    responsive: false,
                    maintainAspectRatio: false
                }
            });
        }

        // Function to create bar graph for tickets assigned per month
        function createTicketsAssignedBarGraph() {
            var ticketCounts = [<%= ticketCounts[0] %>, <%= ticketCounts[1] %>, <%= ticketCounts[2] %>, <%= ticketCounts[3] %>,
                                <%= ticketCounts[4] %>, <%= ticketCounts[5] %>, <%= ticketCounts[6] %>, <%= ticketCounts[7] %>,
                                <%= ticketCounts[8] %>, <%= ticketCounts[9] %>, <%= ticketCounts[10] %>, <%= ticketCounts[11] %>];
            var ctx = document.getElementById('ticketChart4').getContext('2d');

            var ticketChart4 = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Tickets Assigned',
                        data: ticketCounts,
                        backgroundColor: '#2EA445',
                        borderColor: '#2EA445',
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
        }

        // Function to toggle slide menu
        function toggleSlideMenu() {
            var SlideMenu = document.getElementById("SlideMenu");
            var graphContent = document.getElementById("graphContent");

            if (SlideMenu.style.left === "0px") {
                SlideMenu.style.left = "-250px";
                graphContent.style.marginLeft = "0";
            } else {
                SlideMenu.style.left = "0px";
                graphContent.style.marginLeft = "250px";
            }
        }
    </script>
<script>
            
        function toggleSlideMenu() {
            var SlideMenu = document.getElementById("SlideMenu");
            var graphContent = document.getElementById("graphContent");
  
  
            if (SlideMenu.style.left === "0px") {
            SlideMenu.style.left = "-250px";
            graphContent.style.marginLeft = "0";
            } else {
            SlideMenu.style.left = "0px";
            graphContent.style.marginLeft = "250px";
            }
        }
        
</script>
</head>
    <body onload="createOpenedTicketsPieChart(); createResolvedTicketsPieChart(); createOverdueTicketsPieChart(); createTicketsAssignedBarGraph();">
        <div class="title">
            <button class="menu-btn" onclick="toggleSlideMenu()">&#9776;</button>
            Overview
        </div>
        <div class="slide-menu-container" id="SlideMenu">
        <div class="slide-menu">
            <a href="AdminPage.jsp?adminID=<%= session.getAttribute("adminID") %>">Overview</a>
            <a href="TicketManagement.jsp?adminID=<%= session.getAttribute("adminID") %>">Ticket Management</a>
            <a href="Accounts.jsp?adminID=<%= session.getAttribute("adminID") %>">Account Management</a>
            <a href="Contact3.jsp?adminID=<%= session.getAttribute("adminID") %>">Contact</a>
            <a href="Reports_Analysis.jsp?adminID=<%= session.getAttribute("adminID") %>">Reports & Analysis</a>
            <a href="Logs.jsp?adminID=<%= session.getAttribute("adminID") %>">Logs</a>
            <a href="AdminProfile.jsp?adminID=<%= session.getAttribute("adminID") %>">Admin Profile</a>
         </div>
        </div>
        <div class="graph-content" id="graphContent">
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

