<%-- 
    Document   : Departments
    Created on : 01-May-2024, 10:25:25 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Departments Page</title>
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
        .department{
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
            background-color: #DFDFDF; 
            padding: 10px; 
            border-bottom: 1px solid #ddd;
        }

        .task-bar button {
            background-color: #C6C1C1; 
            color: black;
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
        .dep{
                background-color: #DFDFDF;
                width: 100%;
                display: none;
                padding: 10px; 
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Add shadow for depth */
                color: black;
                text-align: center; /* Center align text */
                box-sizing: border-box; /* Include padding and border in the width */
            }
            
            .dep-container{
                background-color: white;
                max-width: 500px;
                margin: 0 auto;
                border-radius: 10px;
            }
            .dep form {
                display: inline-block;
                text-align: left; /* Align form elements to the left */
            }
            .dep form label {
                display: inline-block; /* Make labels and input elements inline */
                width: 200px; /* Adjust width as needed */
                margin-bottom: 5px;
                margin-top: 10px;
                font-size: 20px;
                font-weight: bold;
            }
            .dep form input[type="text"] {
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
            .dep form input[type="submit"] {
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
            .dep form input[type="submit"]:hover {
                background-color: #00BD62;
            }
        </style>
    </head>
    <body>
    <div class="title">
        <a href="Accounts.jsp" class="back-button">&#8592</a>
        <div class="department">Departments</div>
    </div>
         <div class="task-bar">
                <button onclick="addDepartment()">Add Department</button>
                <button onclick="deleteDepartment()">Delete Department</button>
        </div><br>
            <div class="dep" id="createDep">
            <br>
             <div class="dep-container">
            <form action='DepAction.jsp' method='post'>
            <label for='DepartmentName'>Department Name :</label>
            <input type='text' name='DepartmentName' placeholder="Enter name"><br><br>
            <input type='submit' value='Create'>
            </form>
        </div>
    </div>
        <br>
        <div id="section">
            <table>
                <tr>
                    <th>Select</th>
                    <th>Department ID</th>
                    <th>Department Name</th>
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
        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
        pstmt = conn.prepareStatement("SELECT * FROM DEPARTMENTS");
        rs = pstmt.executeQuery();
        while (rs.next()) {

%>
        <tr>
            <td><input type="checkbox" name="uCheckbox" ></td>
            <td><%= rs.getString("deptID") %></td>
            <td><%= rs.getString("deptname") %></td>
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
    function addDepartment() {
        var accountDiv = document.getElementById("createDep");
            accountDiv.style.display = "block"; // Display the about section
            accountDiv.scrollIntoView();              
    }
    function deleteDepartment(){
        var checkboxes = document.getElementsByName("uCheckbox");
        var selectedDepIDs = [];
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                selectedDepIDs.push(checkboxes[i].parentNode.parentNode.cells[1].innerText); // Store the selected user IDs
            }
        }
        if (selectedDepIDs.length > 0) {
            // Redirect to DeleteAccountAction.jsp with selected user IDs as parameters
            window.location.href = "DeleteDepartment.jsp?selectedDepIDs=" + selectedDepIDs.join(",");
        } else {
            alert("Please select at least one account to delete.");
        }
    }
</script>
