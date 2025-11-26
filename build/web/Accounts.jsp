<%-- 
    Document   : Accounts
    Created on : 27-Mar-2024, 6:06:09 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
  

    int[] userCounts = new int[12];
    int[] agentCounts = new int[12];
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int hardwareCount = 0;
    int applicationsCount = 0;
    int operatingSystemCount = 0;
    int networkingCount = 0;
     List<Long> responseTimes = new ArrayList<>();
    long totalResponseTime = 0;
    double averageResponseTime = 0;



    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
        
        String responseTimeQuery = "SELECT TIMESTAMPDIFF(MINUTE, Creation_Date, Resolution_DateTime) AS response_time FROM TICKET WHERE Resolution_DateTime IS NOT NULL";
        pstmt = conn.prepareStatement(responseTimeQuery);
        rs = pstmt.executeQuery();

        // Calculate response time for each ticket
        while (rs.next()) {
            long responseTime = rs.getLong("response_time");
            responseTimes.add(responseTime);
            totalResponseTime += responseTime;
        }
        if (!responseTimes.isEmpty()) {
            averageResponseTime = (double) totalResponseTime / responseTimes.size();
        }
        
        // Query to get count of users registered per month
        String userCountQuery = "SELECT MONTH(Registration_DateTime) AS month, COUNT(*) AS count FROM USERS GROUP BY MONTH(Registration_DateTime)";
        pstmt = conn.prepareStatement(userCountQuery);
        rs = pstmt.executeQuery();

        // Iterate through the result set to populate userCounts array
        while (rs.next()) {
            int month = rs.getInt("month");
            int count = rs.getInt("count");
            // Month index starts from 0
            userCounts[month - 1] = count;
        }

        // Query to get count of agents registered per month
        String agentCountQuery = "SELECT MONTH(Registration_DateTime) AS month, COUNT(*) AS count FROM AGENTS GROUP BY MONTH(Registration_DateTime)";
        pstmt = conn.prepareStatement(agentCountQuery);
        rs = pstmt.executeQuery();

        // Iterate through the result set to populate agentCounts array
        while (rs.next()) {
            int month = rs.getInt("month");
            int count = rs.getInt("count");
            // Month index starts from 0
            agentCounts[month - 1] = count;
        }
        
        
        String agentDepartmentCountQuery = "SELECT deptID, COUNT(*) AS count FROM AGENTS GROUP BY deptID";
        pstmt = conn.prepareStatement(agentDepartmentCountQuery);
        rs = pstmt.executeQuery();

        // Iterate through the result set to populate counts for each department
        while (rs.next()) {
            int deptID = rs.getInt("deptID");
            int count = rs.getInt("count");
            switch (deptID) {
                case 1:
                    hardwareCount = count;
                    break;
                case 2:
                    applicationsCount = count;
                    break;
                case 3:
                    operatingSystemCount = count;
                    break;
                case 4:
                    networkingCount = count;
                    break;
                default:
                    break;
            }
        }
  

      
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Close database connection
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                out.println("Error closing connection: " + e.getMessage());
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Management</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .title{
                background-color: #00BD62; 
                color: white;
                font-family: sans-serif;
                font-size: 26px;
                font-weight: bold;
                height: 70px;
                text-align: center; /* horizontally center */
                line-height: 70px;
                position: relative; 
            }
        
            .slide-menu-container {
                position: fixed;
                top: 0;
                left: -250px;
                width: 250px;
                height: 100%;
                background-color: black;
                transition: left 0.3s ease;
                overflow-x: hidden;
                padding-top: 60px;
            }
            .slide-menu a {
              padding: 10px 20px;
              display: block;
              color: white;
              text-decoration: none;
              transition: background-color 0.3s;
            }
            .slide-menu a:hover {
                background-color: #cccccc;
                color:black;
            }
            .main-content {
              transition: margin-left 0.3s;
              padding: 16px;
              margin-left: 0;
            }
            .section1, .section2{
                margin-left: 50px;
            }
            .ticket-content {
              transition: margin-left 0.3s;
              padding: 16px;
              margin-left: 0;
            }
            .menu-btn {
                position: absolute;  
                left: 10px; 
                top: 50%; 
                transform: translateY(-50%);
                cursor: pointer;
                z-index: 999;
                background: none;
                border: none;
                color: white;
                font-size: 26px;
            }
            .back-btn{
                position: absolute;
                right: 10px;
                background: none;
                border: none;
                color: white;
                font-size: 35px;
                margin-top: 5px;
                cursor: pointer;
            }
            .pieContainer2 {
            margin-top: 20px;
            max-width: 600px;
            display: inline-block; 
            vertical-align: top;
            background-color: #97CB82;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .pieContainer1{
            margin-right: 40px;
            margin-top: 20px;
            max-width: 600px;
            display: inline-block; 
            vertical-align: top;
            background-color: #97CB82;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .graphContainer1{
            margin-top: 20px;
            margin-right: 20px;
            height: 450px;
            width: 700px;
            display: inline-block; 
            vertical-align: top;
            background-color: #FFD7BF;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            
        }
        .graphContainer2{
            margin-top: 20px;
            margin-right: 20px;
            width: 700px;
            height: 450px;
            display: inline-block; 
            vertical-align: top;
            background-color: #FFD7BF;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
           
        }
    
       
        .graphContainer1 h2, .graphContainer2 h2, .pieContainer1 h2, .pieContainer2 h2{
            text-align: center;
        }
        </style>
        <script>
            
        function toggleSlideMenu() {
            var SlideMenu = document.getElementById("SlideMenu");
            var mainContent = document.getElementById("mainContent");
  
  
            if (SlideMenu.style.left === "0px") {
            SlideMenu.style.left = "-250px";
            mainContent.style.marginLeft = "0";
            } else {
            SlideMenu.style.left = "0px";
            mainContent.style.marginLeft = "250px";
            }
        }
        
</script>
    </head>
    <body>
        <div class="title">
            <button class="menu-btn" onclick="toggleSlideMenu()">&#9776;</button>
            ACCOUNT MANAGEMENT
            <a href="AdminPage.jsp"><button class="back-btn">&#128072;</button></a>
        </div>
        <br>
        <div class="slide-menu-container" id="SlideMenu">
        <div class="slide-menu">
            <a href="UserAccounts.jsp?adminID=<%= session.getAttribute("adminID") %>">User Accounts</a>
            <a href="AgentAccounts.jsp?adminID=<%= session.getAttribute("adminID") %>">Agent Accounts</a>
            <a href="Departments.jsp?adminID=<%= session.getAttribute("adminID") %>">Departments</a>
         </div>
        </div>
         <div class="main-content" id="mainContent">
             <div class="section1">
                  <div class="pieContainer1">
            <h2>Agent Accounts by Department</h2>
            <canvas id="agentAccountsByDepartmentChart" width="400" height="400"></canvas>
                  </div>
                 <div class="graphContainer1">
                <h2>User Registrations per Month</h2>
                <canvas id="userRegistrationsChart" style="max-width: 800px; max-height: 300px; width: 700px; height: 400px"></canvas>
            </div>
            </div><br><br>
             <div class="section2">
             
            <div class="graphContainer2">
                <h2>Agent Registrations per Month</h2>
                <canvas id="agentRegistrationsChart" style="max-width: 800px; max-height: 300px; width: 700px; height: 400px"></canvas>
            </div>
                 <div class="pieContainer2">
            <h2>Average Response Time</h2>
            <canvas id="averageResponseTimeChart" width="400" height="400"></canvas>
            </div>
             </div>
        
        </div>        
    </body>
</html>
<script>
    var userCounts = [<% for (int count : userCounts) { %> '<%= count %>', <% } %>];
    var agentCounts = [<% for (int count : agentCounts) { %> '<%= count %>', <% } %>];

    var userRegistrationsCtx = document.getElementById('userRegistrationsChart').getContext('2d');
    var userRegistrationsChart = new Chart(userRegistrationsCtx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'User Registrations',
                data: userCounts,
                backgroundColor: '#FF495F',
                borderColor: '#FF495F',
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

    var agentRegistrationsCtx = document.getElementById('agentRegistrationsChart').getContext('2d');
    var agentRegistrationsChart = new Chart(agentRegistrationsCtx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Agent Registrations',
                data: agentCounts,
                backgroundColor: '#FF495F',
                borderColor: '#FF495F',
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
     var agentAccountsByDepartmentCtx = document.getElementById('agentAccountsByDepartmentChart').getContext('2d');
    var agentAccountsByDepartmentChart = new Chart(agentAccountsByDepartmentCtx, {
        type: 'pie',
        data: {
            labels: ['Hardware', 'Applications', 'Operating System', 'Networking'],
            datasets: [{
                data: [<%= hardwareCount %>, <%= applicationsCount %>, <%= operatingSystemCount %>, <%= networkingCount %>],
                backgroundColor: [
                    'red',
                    'orange',
                    'lightblue',
                    'green'
                ],
                borderColor: [
                    'red',
                    'orange',
                    'lightblue',
                    'green'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: false,
            maintainAspectRatio: false
        }
    });
</script>
<script>
    var averageResponseTime = <%= averageResponseTime %>;

    var averageResponseTimeChartCtx = document.getElementById('averageResponseTimeChart').getContext('2d');
    var averageResponseTimeChart = new Chart(averageResponseTimeChartCtx, {
        type: 'pie',
        data: {
            labels: ['Average Response Time', 'Remaining Time'],
            datasets: [{
                data: [averageResponseTime, 24*60 - averageResponseTime], // Assuming a day is 24 hours
                backgroundColor: [
                    '#3D8035',
                    'lightgrey'
                ],
                borderColor: [
                    '#3D8035',
                    'grey'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: false,
            maintainAspectRatio: false
        }
    });
</script>

   