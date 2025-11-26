<%-- 
    Document   : Feedback
    Created on : 31-Mar-2024, 6:55:05 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback Page</title>
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
        .feedback{
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
        th {
            background-color: #f4f4f4;
        }
        td {
            background-color: white;
        }
       
            .taskbar {
                display: none;
                background-color: #f4f4f4;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 10px;
                margin-bottom: 10px;
                justify-content: center;
            }
            .taskbar button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 0 5px;
            font-size: 16px;
        }

        .taskbar button:hover {
            background-color: #45a049;
        }
        body{
            background-color: #FF4D62;
        }
    </style>
    <script>
        if ('<%= request.getParameter("success") %>' === 'true') {
                alert('FEEDBACK SUBMITTED SUCCESSFULLY!');
            }
        </script>
        <script>
        function toggleTaskBar() {
            var checkboxes = document.getElementsByName("feedbackCheckbox");
            var taskbar = document.getElementById("taskbar");

            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    taskbar.style.display = "flex";
                    return;
                }
            }
            taskbar.style.display = "none";
        }
        function viewFeedback(){
            var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
        
        
            var feedbackIDs = [];
            checkedCheckboxes.forEach(function(checkbox) {
                feedbackIDs.push(checkbox.parentNode.nextElementSibling.textContent); // Assuming Ticket ID is in the next cell
            });
            var userID = '<%= session.getAttribute("userID") %>';
        
            if (feedbackIDs.length > 0) {
                window.location.href = 'viewFeedback.jsp?userID=' + userID + '&feedbackIDs=' + feedbackIDs.join(',');
            } else {
                alert('Please select at least one ticket to open.');
            }
        }
        function deleteFeedback() {
            var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
        
        
            var feedbackIDs = [];
            checkedCheckboxes.forEach(function(checkbox) {
                feedbackIDs.push(checkbox.parentNode.nextElementSibling.textContent); // Assuming Ticket ID is in the next cell
            });

        
            if (feedbackIDs.length > 0) {
                window.location.href = 'DeleteFeedback.jsp?feedbackIDs=' + feedbackIDs.join(',');
            } else {
                alert('Please select at least one feedback to delete');
            }
        }
    </script>
    </head>
    <body>
<div class="title">
    <a href="UserPage.jsp" class="back-button">&#8592</a>
    <div class="feedback">Feedback</div>
</div>
<div class="container">
    <div class="section1">
        <div class="taskbar" id="taskbar">
            <button onclick="viewFeedback()">View</button>
            <button onclick="deleteFeedback()">Delete</button>
        </div>
        <table>
            <tr>
                <th>Select</th>
                <th>FeedBack ID</th>
                <th>Ticket ID</th>
                <th>Feedback</th>
                <th>Date/Time</th>
            </tr>            
<%
    String userID = request.getParameter("userID");
            if (userID == null) {
                userID = (String) session.getAttribute("userID");
            }
    Connection conn=null;
            PreparedStatement pstmt=null;
            ResultSet rs = null;
            try{
                Class.forName("com.mysql.jdbc.Driver");
                conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","root","admin");
                String query = "Select * from FEEDBACK where userID=?";
                pstmt=conn.prepareStatement(query);
                pstmt.setString(1, userID);
                rs = pstmt.executeQuery();
                while(rs.next()) {
%>            
            <tr>
                <td><input type="checkbox" name="feedbackCheckbox" onchange="toggleTaskBar()"></td>
                <td><%= rs.getString("feedbackID") %></td>
                <td><%= rs.getString("ticketID") %></td>
                <td><%= rs.getString("feedback") %></td>
                <td><%= rs.getString("created_at") %></td>
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
