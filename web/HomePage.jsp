<%-- 
    Document   : HomePage
    Created on : 19-Feb-2024, 3:01:48 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Help Desk Application</title>
        <style>
            .Title{
                background-color: black;
                color:white;
                font-weight: bold;
                font-size: 26px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 20px;
            }
            .Title button {
                background-color: transparent;
                border: none;
                color: white;
                font-size: 20px;
                font-weight: bold;
                cursor: pointer;
            }
            #video-container {
                background-color: #FF4D62;
                text-align: center;
                margin-top: 20px;
                margin-bottom: 20px;
            }
            video {
                display: inline-block;
                vertical-align: middle;
            }
            body{
                background-color: white;
                margin: 0;
                padding: 0;
            }
            .container1{
                background-color: #FF4D62; 
            }
            .container2{
                background-color: white;
                max-width: 1500px; /* Set max width */
                margin: 0 auto; 
            }
            .about, .contact, .login {
                width: 100%;
                display: none;
                padding: 20px; /* Add padding for spacing */
                border-radius: 0px; /* Add border radius for rounded corners */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Add shadow for depth */
                color: white;
                text-align: center; /* Center align text */
                box-sizing: border-box; /* Include padding and border in the width */
            }
            .about{
            opacity: 0;
            transition: opacity 0.5s ease;
            transform: translateY(20px);
            transition: transform 0.5s ease, opacity 0.5s ease;
            color:black;
            text-align: left;
            }
            .contact{
                background-color: white;
            }
            .login{
                background-color: #FF4D62;
                height: 800px;
            }
            .form-container{
                background-color: black;
                max-width: 500px;
                margin: 0 auto;
                border-radius: 10px;
            }
            .login form {
                display: inline-block;
                text-align: left;
                padding: 20px;
                padding-left: 20px;/* Align form elements to the left */
            }
            .login form label {
                display: inline-block; /* Make labels and input elements inline */
                width: 100px; /* Adjust width as needed */
                margin-bottom: 5px;
                font-size: 16px;
                font-weight: bold;
            }
            .login form select,
            .login form input[type="text"],
            .login form input[type="password"] {
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
            .login form input[type="submit"],
            .login form input[type="submit"] {
                margin-top: 10px;
                padding: 10px 20px;
                background-color: #FF3A51;
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-bottom: 10px;
                padding-right: 10px;/* Add padding at the bottom */
            }
            .login form input[type="submit"]:hover {
                background-color: #FF1C37;
            }
    /*        .about_title{
               background-color: #FF4D62;
                color: white;
                padding: 10px;
                border-radius: 5px;
                font-family: sans-serif;
                font-size: 24px;
                font-weight: bold;
            }
        */    .login_title{
                background-color: white;
                color: black;
                font-size: 24px;
                font-weight: bold;
                padding: 20px;
                border-radius: 5px;
                margin-bottom: 50px;
            }
            .about.loaded {
            opacity: 1;
            transform: translateY(0);
        }

        .about_title {
            margin-top: 20px;
            background-color: black;
            color: white;
            padding: 10px;
            border-radius: 5px;
            font-family: sans-serif;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .feature-container {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .feature {
            background-color: #99ccff;
            color: black;
            padding: 20px;
            border-radius: 10px;
            width: 30%;
            transition: transform 0.5s ease, opacity 0.5s ease;
            text-align: center;
        }

        .feature:hover {
            transform: scale(1.1);
            background-color: #0097B2;
            color: white;
        }

        .feature h3 {
            margin-bottom: 10px;
            font-size: 20px;
        }

        .feature ul {
            padding-left: 20px;
            text-align: left;
        }

        .feature li {
            margin-bottom: 10px;
        }
        .text{
            width:820px;
            height: 370px;
            background-color: #f2f2f2;
            display: inline-block; 
            vertical-align: top;
        }
        .text p{
            font-family: sans-serif;
            font-size: 20px;
            padding: 15px;
            justify-content: left;
        }
        .about p{
            font-family: sans-serif;
            font-size: 20px;
            padding: 10px;
            justify-content: left;
        }
        .text h3{
            font-family: sans-serif;
            font-size: 20px;
            padding: 15px;
            text-align: left;
        }
        .image{
           display: inline-block; 
            vertical-align: top; 
            width: 600px;
            height: 370px;
        }
        .signup-button {
            padding: 15px 30px;
            background-color: black;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: block;
            margin: 0 auto; /* Center align the button */
        }

        .signup-button:hover {
            background-color: #FF4D62;
        }

        </style>
        <script>
            // Check if the URL parameter indicates successful registration and display an alert
            if ('<%= request.getParameter("registration") %>' === 'success') {
                alert('Registration successful!');
            }
        </script>
    </head>
    <body>
        <div class="container1">
            <br>
        <div class="Title">
            IConnect
           <div>
            <button onclick="scrollToAbout()">About</button>
            <button onclick="scrollToLogin()">Login</button>
        </div> 
        </div>
        <div id="video-container">
        <video width="auto" height="560" controls autoplay muted>
            <source src="videos/ICONNECT.mp4" type="video/mp4">            
        </video>
        </div>
            <br>
        </div>
        <br>
<div class="container2">
    <div class="about" id="aboutContent">
        <div class="about_title">ABOUT US</div>
        <div class="text">
        <h3><strong>Welcome to IConnect - our latest IT support Help Desk Application designed to make customer service management easier, faster and
                more efficient than ever before!!</strong></h3>
        
        <p>IConnect is a ticketing tool software used to process , manage and track customer issues right from their submission to their resolution. It 
            serves as  a hub for responses, streamlining communication between agents and customers. It allows to help analyze the team performance metrics
            such as resolution time, response time. It can also be used to track the frequency of the customer issues to figure out eminent issues. It allows tracking and recording of the 
            customer issues and interactions making it easier for customer service teams to manage their assigned cases.</p></div>
        <img class="image" src="images/hd_display.png">
        <p><strong>Why use IConnect as opposed to our competitors?</strong></p>
        <div class="feature-container">
        <div class="feature">
            <h3>Key Features as a User Client</h3>
            <ul>
                <li> Effective registration of issues as a Ticket</li>
                <li> Aesthetic user-friendly UI for easy navigation displaying the tickets created</li>
                <li>Mail Integration for effective communication with the agents incharge of the tickets</li>
                <li> Feedback mechanism for relaying your experience with us</li>
            </ul>
        </div> 
        <div class="feature">
            <h3>Key Features as an Agent Client</h3>
            <ul>
                <li> Automatic as well as manual assignment of the tickets</li>
                <li> Aesthetic user-friendly UI for easy navigation displaying the tickets assigned</li>
                <li>Mail Integration for effective communication with both the admin and the user</li>
                <li>A notification mechanism which keeps agent in check with the overdue tickets</li>
                <li>Automatic report generation of closed tickets</li>
                <li>Notes and Comments mechanism for the tickets</li>
            </ul>
        </div> 
        <div class="feature">
            <h3>Key Features as an Admin Client</h3>
            <ul>
                <li>Ticket management services like viewing , storage and tracking of the tickets</li>
                <li> Account management features like creation, deletion and editing of user/agent accounts</li>
                <li>Report Analysis from the agents and Feedback Analysis from users</li>
                <li>Mail integration for efficient communication with the user and the clients.</li>
                <li>Maintains log of all the activities</li>
            </ul>
        </div> 
    </div>
        <h2> Sign up our services for your organization below </h2>
         <button id="Signup" class="signup-button">Sign up</button>
         <br>
    </div>
    <div class="login" id="loginContent">
        <div class="login_title">LOGIN</div>
            <br>
             <div class="form-container">
            <form action='LoginAction.jsp' method='post'>
                <label for='login'>Login Type :</label>
                <select name='loginType' id='login'>
                    <option value='user'>USER LOGIN</option>
                    <option value='agent'>AGENT LOGIN</option>
                    <option value='admin'>ADMIN LOGIN</option>
                </select>
                <br><br>
                <label for='name'>Name :</label>
                <input type="text" name='username'><br><br>
                <label for='password'>Password :</label>
                <input type='password' name='password'><br><br>
                <input type='submit' value='Login'>
            </form>
        <form action='register.jsp' method='post'>
            <input type='submit' value="Register">
        </form>
        </div>
    </div>
</div>
        
        
        <script>
            function scrollToAbout() {
            var aboutDiv = document.getElementById("aboutContent");
            aboutDiv.style.display = "block"; // Display the about section
            aboutDiv.scrollIntoView();
        }
        function openGoogleForm() {
            var googleFormUrl = "https://forms.gle/RXwqwzQMraPua7YAA"; // Replace with your Google Form URL

            // Create an iframe element
            var iframe = document.createElement('iframe');
            iframe.src = googleFormUrl;
            iframe.width = "100%";
            iframe.height = "900px"; // Adjust height as needed

            // Append the iframe to the about div
            var aboutDiv = document.getElementById("aboutContent");
            aboutDiv.appendChild(iframe);
        }

        document.getElementById("Signup").addEventListener("click", openGoogleForm);
        
        function scrollToLogin() {
            var loginDiv = document.getElementById("loginContent");
            loginDiv.style.display = "block"; // Display the about section
            loginDiv.scrollIntoView();        }
        </script>
        <script>
        // Function to fade in the about section and apply animations
        function fadeInAbout() {
            var aboutContent = document.getElementById('aboutContent');
            aboutContent.classList.add('loaded');
        }

        // Trigger the animation when the page has fully loaded
        window.addEventListener('load', fadeInAbout);
    </script>
    </body>
</html>
