<%-- 
    Document   : UserAccounts
    Created on : 03-Apr-2024, 1:11:36 am
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Account Page</title>
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
        .user_account{
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
        .account{
                background-color: #DFDFDF;
                width: 100%;
                display: none;
                padding: 20px; 
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Add shadow for depth */
                color: black;
                text-align: center; /* Center align text */
                box-sizing: border-box; /* Include padding and border in the width */
            }
            
            .form-container{
                background-color: black;
                max-width: 500px;
                margin: 0 auto;
                border-radius: 10px;
            }
            .account form {
                display: inline-block;
                text-align: left; /* Align form elements to the left */
            }
            .account form label {
                display: inline-block; /* Make labels and input elements inline */
                width: 100px; /* Adjust width as needed */
                margin-bottom: 5px;
                font-size: 16px;
                font-weight: bold;
            }
            .account form input[type="text"],
            .account form input[type="email"],
            .account form input[type="password"] {
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
            .account form input[type="submit"] {
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
            .account form input[type="submit"]:hover {
                background-color: #00BD62;
            }
    </style>
    <script>
            // Check if the URL parameter indicates successful registration and display an alert
            if ('<%= request.getParameter("creation") %>' === 'success') {
                alert('ACCOUNT CREATED SUCCESSFULLY!');
            }
        </script>
        <script>
            // Check if the URL parameter indicates successful registration and display an alert
            if ('<%= request.getParameter("deleted") %>' === 'success') {
                alert('ACCOUNT DELETED SUCCESSFULLY!');
            }
        </script>
    </head>
    <body>
        <div class="title">
        <a href="Accounts.jsp" class="back-button">&#8592</a>
        <div class="user_account">USER ACCOUNT</div>
    </div>
        <div class="task-bar">
                <button onclick="addAccount()">Add Account</button>
                <button onclick="editAccount()">Edit Account</button>
                <button onclick="deleteAccount()">Delete Account</button>
        </div><br>
    <div class="account" id="createAccount">
            <br>
             <div class="account-container">
            <form action='AccountAction.jsp' method='post'>
                <label for='Username'>Username :</label>
            <input type='text' name='username' placeholder="Enter name" autocomplete="new-password"><br><br>
            <label for='Email'>Email :</label>
            <input type ='email' name='email' placeholder="Enter email" autocomplete="new-email"><br><br>
            <label for='Password'>Password :</label>
            <input type='password' name='password' placeholder="Enter password" autocomplete="new-password"><br><br>
            <input type='submit' value='Create'>
            </form>
        </div>
    </div>
    <div class="account" id="editAccount" style="display: none;">
<%
    String selectedUserID = request.getParameter("selectedUserID");
%>
    <div class="account-container">
        <form action='EditAccountAction.jsp' method='post'> <!-- Update the action attribute with the appropriate action -->
            <label for='EditUsername'>Edit Username :</label>
            <input type='text' name='editUsername' placeholder="Enter new username" autocomplete="off"><br><br>
            <label for='EditEmail'>Edit Email :</label>
            <input type ='email' name='editEmail' placeholder="Enter new email" autocomplete="off"><br><br>
            <label for='EditPassword'>Edit Password :</label>
            <input type='password' name='editPassword' placeholder="Enter new password" autocomplete="off"><br><br>
            <!-- Hidden input field to store selected user IDs -->
            <input type="hidden" id="selectedUserID" name="selectedUserID" value="">
            <input type='submit' value='Update'>
        </form>
    </div>
</div>
        <br>
        <div id="section">
            <table>
                <tr>
                    <th>Select</th>
                    <th>User ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Password</th>
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
        pstmt = conn.prepareStatement("SELECT * FROM USERS");
        rs = pstmt.executeQuery();
        while (rs.next()) {

%>
        <tr>
            <td><input type="checkbox" name="uCheckbox" ></td>
            <td><%= rs.getString("userID") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("Email") %></td>
            <td><%= rs.getString("password") %></td>
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
    function addAccount() {
        var accountDiv = document.getElementById("createAccount");
            accountDiv.style.display = "block"; // Display the about section
            accountDiv.scrollIntoView();              
    }
    function editAccount(){
        var checkboxes = document.getElementsByName("uCheckbox");
        var selectedUserID = null;
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                selectedUserID = checkboxes[i].parentNode.parentNode.cells[1].innerText; // Store the selected user ID
            }
        }
        if (selectedUserID) {
            // Set the selectedUserID in the hidden input field
            document.getElementById("selectedUserID").value = selectedUserID;
            // Show the editAccount form
            var editAccountForm = document.getElementById("editAccount");
            editAccountForm.style.display = "block";
            editAccountForm.scrollIntoView();
        } else {
            alert("Please select at least one account to edit.");
        }    }
    
     function deleteAccount() {
        var checkboxes = document.getElementsByName("uCheckbox");
        var selectedUserIDs = [];
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                selectedUserIDs.push(checkboxes[i].parentNode.parentNode.cells[1].innerText); // Store the selected user IDs
            }
        }
        if (selectedUserIDs.length > 0) {
            // Redirect to DeleteAccountAction.jsp with selected user IDs as parameters
            window.location.href = "DeleteAccountAction.jsp?selectedUserIDs=" + selectedUserIDs.join(",");
        } else {
            alert("Please select at least one account to delete.");
        }
    }
</script>

       