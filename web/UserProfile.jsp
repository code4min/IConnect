<%-- 
    Document   : UserProfile
    Created on : 30-Mar-2024, 5:05:52 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet, java.sql.SQLException" %>
<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("HomePage.jsp");
    }
%>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Connect to the database
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");

        // Retrieve admin profile data from the database
        String sql = "SELECT username, password, Email FROM USERS WHERE userID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, (String) session.getAttribute("userID"));
        rs = pstmt.executeQuery();

        // Check if a row is found
        if (rs.next()) {
            // Retrieve data from the result set
            String username = rs.getString("username");
            String password = rs.getString("password");
            String email = rs.getString("Email");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
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
        .profile{
            margin: 0 auto;
        }
        body{
            background-color: #FF4D62;
        }
        .profile-container {
            max-width: 600px;
            margin: 20px auto;
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .profile-info {
            margin-bottom: 20px;
        }

        .profile-label {
            font-weight: bold;
        }

        .profile-value {
            margin-left: 10px;
        }
        .sign-out-button {
            background:none;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            margin-right: 5px;
            font-size: 20px;
            cursor: pointer;
            border: none;
        }

        .sign-out-button:hover {
            color: #FF4D62;
        }
        #EditProfile {
            background-color: #FF4D62; /* Green background color */
            color: white; /* White text color */
            border: none;
            width: 80px;
            font-size: 18px;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;/* Font size */
            transition: background-color 0.3s ease; /* Smooth transition */
        }

        /* Hover effect for EditProfile button */
        #EditProfile:hover {
            background-color: black; /* Darker green on hover */
        }
        </style>
        <style>
        /* Existing styles */

        /* Styling for editProfileForm */
        #editProfileForm {
            max-width: 600px; /* Limit width of the form */
            margin: 0 auto; /* Center align the form */
            padding: 20px; /* Add some padding */
            background-color: #f9f9f9; /* Light gray background color */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Shadow effect */
        }

        /* Styling for form labels */
        #editProfileForm label {
            display: block; /* Display labels as block elements */
            margin-bottom: 5px; /* Add some bottom margin */
            font-weight: bold; /* Bold text */
        }

        /* Styling for form inputs */
        #editProfileForm input[type="text"],
        #editProfileForm input[type="password"],
        #editProfileForm input[type="email"] {
            width: 100%; /* Full width input fields */
            padding: 10px; /* Padding */
            margin-bottom: 15px; /* Add some bottom margin */
            border: 1px solid #ccc; /* Border color */
            border-radius: 5px; /* Rounded corners */
            box-sizing: border-box; /* Include padding in width */
        }

        /* Styling for form submit button */
        #editProfileForm button[type="submit"] {
            background-color: #FF4D62; /* Green background color */
            color: white; /* White text color */
            padding: 10px 20px; /* Padding */
            border: none; /* No border */
            border-radius: 5px; /* Rounded corners */
            cursor: pointer; /* Cursor style */
            font-size: 18px; /* Font size */
            transition: background-color 0.3s ease; /* Smooth transition */
        }

        /* Hover effect for submit button */
        #editProfileForm button[type="submit"]:hover {
            background-color: black; /* Darker green on hover */
        }
    </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script>
    function signOut() {
        // Redirect the user to the logout page
        window.location.href = "Logout.jsp?accountID=<%= userID %>";
    }
    function showEditForm() {
            var editForm = document.getElementById("editForm");
            editForm.style.display = "block";
        }
</script>
    </head>
    <body>
        <div class="title">
            <a href="UserPage.jsp" class="back-button">&#8592</a>
            <div class="profile">User Profile</div>
            <button class="sign-out-button" onclick="signOut()"><i class="fas fa-power-off"></i></button>

        </div>
        <div class="profile-container">
    <div class="profile-info">
        <span class="profile-label">Name:</span>
        <span class="profile-value"><%= username %></span>
    </div>
    <div class="profile-info">
        <span class="profile-label">User ID:</span>
        <span class="profile-value"><%= userID %></span>
    </div>
    <div class="profile-info">
        <span class="profile-label">Password:</span>
        <span class="profile-value"><%= password %></span>
    </div>
    <div class="profile-info">
        <span class="profile-label">Email:</span>
        <span class="profile-value"><%= email %></span>
    </div>
<button id="EditProfile" onclick="showEditForm()"> Edit </button>
</div>
          <!-- Edit form initially hidden -->
        <div id="editForm" style="display: none;">
            <form id="editProfileForm" action="UpdateUserProfile.jsp" method="POST">
                <label for='newUsername'>Edit Username :</label>
                <input type="text" name="newUsername" placeholder="New Username"><br>
                <label for='newPassword'>Edit Password :</label>
                <input type="password" name="newPassword" placeholder="New Password"><br>
                <label for='newEmail'>Edit Email :</label>
                <input type="email" name="newEmail" placeholder="New Email"><br>
                <button type="submit">Save Changes</button>
            </form>
        </div>
<%
    } else {
            // Admin profile not found
            out.println("Admin profile not found.");
        }
    } catch (SQLException | ClassNotFoundException e) {
        // Handle exceptions
        e.printStackTrace();
        out.println("An error occurred while fetching admin profile.");
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
    </body>
</html>