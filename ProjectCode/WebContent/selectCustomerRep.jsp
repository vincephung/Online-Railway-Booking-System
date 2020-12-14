<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!-- Page to select which Customer Representive's information will be edited/deleted -->
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
		crossorigin="anonymous">
		<title>Actions</title>
</head>
<body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
      
		//query database for customer rep dropdown
		Statement repStmt = con.createStatement();
		ResultSet repSet = repStmt.executeQuery("select username from users where type = 'customer_rep'");
				
		String custrep = request.getParameter("custrep");   
		

		%> 
   		<div class="container">
	   		<h1>Select Customer Representative To Edit</h1>
	   		<br>
	   		<div class="repOptions">
	   			<form method="POST" action="editRepInfo.jsp">
	   				<select name="custrep" id="custrep" required>
	   					<option value="" disabled selected>Select Customer Rep. Username</option>
						<%while(repSet.next()){ %>
						      <option><%= repSet.getString("username") %></option>
						<%} 
						repSet.beforeFirst(); //reset stationSet for next loop
						%>
	   				</select>
				    <button class="btn btn-primary" type="submit">Submit</button>
	   			</form>	 
	   			<br>
               <a href='registerForm.jsp'>Click here to register a customer representative</a>  			
	   		</div>	   		
		   	<!--  Make an HTML table to show the results in: -->
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>
