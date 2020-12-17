<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!--(Admin Function) Identifies the best customer(Who spent the most money?).-->
<!--For the case where more than 1 customer has the max spent, only 1 selected as the instructions want 1 customer-->
<!DOCTYPE html>
<html>
    <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	    <link rel="stylesheet" href="styles/trainSchedule.css">
	    <title>Best Customer</title>
   </head>
   <body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
      
		
		Statement bestStmt = con.createStatement();
		ResultSet bestSet = bestStmt.executeQuery("select u.firstname, u.lastname, u.username, t1.total revenue "+
				"from users u, "+
				"(select username, sum(total_fare) total "+
				"from reservation "+
				"group by username order by total desc limit 1) t1 "+
				"where t1.username = u.username");
		 
		%> 
         
   		<div class="container">
	   		<h1>Who is our Company's Best Customer?</h1>	   		
		   	<!--  The result, in string format -->
		   	<br>
	   		<%bestSet.next();%>
			<h3>Congratulations to <%=bestSet.getString("firstname")%> <%=bestSet.getString("lastname")%>, username: <%=bestSet.getString("username")%> !
			This customer spent $<%=bestSet.getString("revenue")%>.</h3>    
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>
