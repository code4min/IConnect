<%-- 
    Document   : register
    Created on : 21-Feb-2024, 6:26:37 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Registration</title>
        <style>
            body{
                background-color: #FF4D62;
            }
            .register_title{
                background-color: black;
                color:white;
                font-weight: bold;
                font-size: 26px;
                text-align: center;
                padding: 10px;
            }
            .registerform-container{
                background-color: white;
                max-width: 500px;
                margin: 0 auto;
                display: flex;
                flex-direction: column;
                align-items: center; /* Center items horizontally */
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Center items horizontally */
            }
            .register form{
                display: inline-block;
                text-align: left; 
            }
            .register form label{
                display: inline-block; /* Make labels and input elements inline */
                width: 100px; /* Adjust width as needed */
                margin-bottom: 5px;
                font-size: 16px;
                font-weight: bold;
            }
            .register form input[type="text"],
            .register form input[type="email"],
            .register form input[type="password"]{
                display: inline-block;
                vertical-align: middle;
                margin-top: 10px;
                margin-bottom: 10px;
                padding: 10px;
                border: none;
                border-radius: 5px;
                width: 200px; /* Adjust width as needed */
                font-size: 16px;
                background-color: #FF8888; /* Set background color */
                color: white;
            }
            .register form input[type="text"]::placeholder,
            .register form input[type="email"]::placeholder,
            .register form input[type="password"]::placeholder {
                color: white; /* Set placeholder text color */
            }
            .register form .button-container {
                display: flex;
                justify-content: center;
            }
            .register form input[type="submit"] {
                margin-top: 10px;
                padding: 10px 20px;
                background-color: #FF4D62;
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-bottom: 10px; /* Add padding at the bottom */
            }
            .register form input[type="submit"]:hover {
                background-color: black;
            }
        </style>
    </head>
    <body>
        <div class="register" id="registerContent">
        <div class="register_title">REGISTER</div>
        <br><br><br>
             <div class="registerform-container">
        <form action='registerAction.jsp' method='post'>
            <label for='Username'>Username :</label>
            <input type='text' name='username' placeholder="Enter name" autocomplete="new-password"><br><br>
            <label for='Email'>Email :</label>
            <input type ='email' name='email' placeholder="Enter email" autocomplete="new-email"><br><br>
            <label for='Password'>Password :</label>
            <input type='password' name='password' placeholder="Enter password" autocomplete="new-password"><br><br>
            <div class="button-container">
            <input type='submit' value='Register'>
            </div>
        </form>
             </div></div>
    </body>
</html>
