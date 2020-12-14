<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!-- Page allows user to select either to view reservations by a specific Transit Line Name/Customer's Name -->
<!-- Duplicate names only appear once in the dropdown menu but viewReservations.jsp will distinguish them by their other attributes-->
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
		crossorigin="anonymous">
		<title>Options</title>
</head>
<body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
      
		//query database for transit line dropdown
		Statement lineStmt = con.createStatement();
		ResultSet lineSet = lineStmt.executeQuery("select distinct transitLineName from train_schedule order by transitLineName asc");
		
		//query database for customer name dropdown, ordered by lastname then firstname
		Statement nameStmt = con.createStatement();
		ResultSet nameSet = nameStmt.executeQuery("select distinct lastname, firstname from users where type ='customer' order by lastname, firstname ASC");
				

		%> 
   		<div class="container">
	   		<h3>Select An Option from One of the Drop Down Menus</h3>
	   		<br>
	   		<div class="resOptions">
	   			<form method="POST" action="viewReservations.jsp">
	   				<select name="transline" id="transline" required>
	   					<option value="" disabled selected>See Reservations By Transit Line</option>
						<%while(lineSet.next()){ %>
						      <option><%= lineSet.getString("transitLineName") %></option>
						<%} 
						
						%>
	   				</select>
				    <button class="btn btn-primary" type="submit">Search By Transit Line</button>
	   			</form>	 
   			</div>
	   			<br>
	   			<br>
   			<div class = "customerOptions">
	   			<form method="POST" action="viewReservations.jsp">
	   				<select name="customerName" id="customerName" required>
	   					<option value="" disabled selected>See Reservations By Customer's (Last, First) Name</option>
						<%while(nameSet.next()){ %>
						      <option><%= nameSet.getString("lastname") %>, <%= nameSet.getString("firstname") %></option>
						<%} 

						%>
	   				</select>
				    <button class="btn btn-primary" type="submit">Search by Customer Name</button>
	   			</form>	 
	   			<br>			
	   		</div>	   		
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>
