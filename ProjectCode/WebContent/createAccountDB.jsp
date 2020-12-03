<%@ page import ="java.sql.*" %>
<%
	String firstname= request.getParameter("firstname");   
	String lastname= request.getParameter("lastname");   
	String email= request.getParameter("email");   
    String username = request.getParameter("username");   
    String password = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
    Statement st = con.createStatement();
    st.executeUpdate("insert into customer (lastname,firstname,email,username,password) values (" + "'" + lastname + "'" + ',' + "'" + firstname + "'" + ',' + "'" + email + "'" + ',' + "'" + username + "'" + ',' + "'" + password + "'" + ')');
        out.println("Successfully created account!" );
        out.println("<a href='login.jsp'>Log in</a>");
       // response.sendRedirect("success.jsp");
%>