<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!--Produces a monthly sales report of each transit line-->
<!DOCTYPE html>
<html>
    <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	    <link rel="stylesheet" href="styles/trainSchedule.css">
	    <title>Monthly Sales Reports</title>
   </head>
   <body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
      
		
		Statement reportStmt = con.createStatement();
		ResultSet reportSet = reportStmt.executeQuery("select year(depDate) 'Year', month(depDate) 'Month', transitLineName, "+
			"sum(total_fare) 'Revenue', sum(if(trip_type like 'R%', 2, 1)) 'Passengers' "+
	        "from reservation GROUP BY year(depDate), month(depDate), transitLineName " +
	        "ORDER BY Year, Month, transitLineName ASC");


		 
		%> 
         
   		<div class="container">
	   		<h1>Monthly Sales Report Per Line</h1>	   		
		   	<!--  Make an HTML table to show the results in: -->
			<table class="table table-striped table-bordered">
				<tr>    
					<th>Year</th>
					<th>Month</th>
					<th>Transit Line Name</th>
					<th>Total Revenue for the Month</th>
					<th>Total Passengers</th>
				</tr>
					<%
					//parse out the results
					while (reportSet.next()) { %>
						<tr>    
							<td><%= reportSet.getString("Year") %></td>
							<td><%= reportSet.getString("Month") %></td>
							<td><%= reportSet.getString("transitLineName") %></td>
							<td><%= reportSet.getString("Revenue") %></td>
							<td><%= reportSet.getString("Passengers") %></td>
						</tr>
					<% } %>
				</table>		
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>
