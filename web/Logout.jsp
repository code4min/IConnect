<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>

<%
    String accountID = request.getParameter("accountID");
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        session = request.getSession(false);
        // Store the current datetime using timestamp in the 'logoutDateTime' column of the LOGS table
        if (accountID != null) {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","root","admin");

            // Update the LOGS table with logout datetime
            String sql = "UPDATE LOGS SET logoutDateTime = ? WHERE accountID = ? AND loginDateTime = (SELECT MAX(loginDateTime) FROM LOGS WHERE accountID = ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            pstmt.setString(2, accountID);
            pstmt.setString(3, accountID);
            pstmt.executeUpdate();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Invalidate the session
    if (session != null) {
        session.invalidate();
    }

    // Redirect to HomePage.jsp
    response.sendRedirect("HomePage.jsp");
%>
