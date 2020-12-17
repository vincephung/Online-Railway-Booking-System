<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!--(Admin Function) Produces a list of the 5 most active (determined by most reservations) transit lines-->
<!DOCTYPE html>
<html>
    <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	    <link rel="stylesheet" href="styles/trainSchedule.css">
	    <title>5 Most Active Lines</title>
   </head>
   <body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
      
		
		Statement mostActiveStmt = con.createStatement();
		ResultSet mostActiveSet = mostActiveStmt.executeQuery("select t.transitLineName, t1.numReservations reservationCount "+
			"from train_schedule t, "+
			"(select sum(if(trip_type like 'R%', 2,1)) numReservations, "+
			"transitLineName from reservation "+
			"group by transitLineName) t1 "+
			"where t1.transitLineName = t.transitLineName "+
			"group by t1.transitLineName "+
			"order by reservationCount DESC "+
			"LIMIT 5");

		 
		%> 
         
   		<div class="container">
	   		<h1>5 Most Active Train Lines</h1>	   		
		   	<!--  Make an HTML table to show the results in: -->
			<table class="table table-striped table-bordered">
				<tr>    
					<th>Transit Line Name</th>
					<th>Number of Reservations</th>
				</tr>
					<%
					//parse out the results
					while (mostActiveSet.next()) { %>
						<tr>    
							<td><%= mostActiveSet.getString("transitLineName") %></td>
							<td><%= mostActiveSet.getString("reservationCount") %></td>
						</tr>
					<% } %>
				</table>		
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>
