<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!--Search for train schedules, click on a schedule to see its route(all stops)-->
<!DOCTYPE html>
<html>
    <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	    <link rel="stylesheet" href="styles/trainSchedule.css">
	    <title>Train Schedules</title>
   </head>
   <body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
      	
		//query database to get origin and destinations for dropdown
		Statement stationStmt = con.createStatement();
		ResultSet stationSet = stationStmt.executeQuery("select distinct s.name from station s order by s.name");
		
		//query for schedule numbers
		Statement nameStmt = con.createStatement();
		ResultSet nameSet = nameStmt.executeQuery("select t.trainID from train_schedule t");
		//User inputted "search" parameters
		ResultSet scheduleSet;
		
		Statement scheduleStmt = con.createStatement();
		scheduleSet = scheduleStmt.executeQuery("select * from train_schedule ts, (select s.stationID, s.name as originStation from station s)s1, (select s.stationID, s.name as destinationStation from station s)s2 where ts.originStationID = s1.stationID and ts.destinationStationID = s2.stationID");
		 
		%> 
         
   		<div class="container">
	   		<h1>Reserve A Train Ticket</h1>   		
		   	<!--  Make an HTML table to show the results in: -->
			<table class="table table-striped table-bordered">
				<tr>    
				    <th>Train ID</th>
					<th>Transit Line Name</th>
					<th>Origin Station</th>
					<th>Destination Station</th>
					<th>Fare</th>
					<th>Travel Time</th>
					<th>Departure Time</th>
					<th>Arrival Time</th>
				</tr>
					<%
					//parse out the results
					while (scheduleSet.next()) { %>
						<tr>    
							<td><a href="scheduleStops.jsp?trainID=<%=scheduleSet.getString("trainID")%>"><%= scheduleSet.getString("trainID") %></a></td>
							<td><%= scheduleSet.getString("transitLineName") %></td>
							<td><%= scheduleSet.getString("originStation") %></td>
							<td><%= scheduleSet.getString("destinationStation") %></td>
							<td>$<%= scheduleSet.getString("fixedFare") %></td>
							<td><%= scheduleSet.getString("travelTime") %></td>
							<td><%= scheduleSet.getString("departureTime") %></td>
							<td><%= scheduleSet.getString("arrivalTime") %></td>
						</tr>
					<% } %>
				</table>
				<div>To make a reservation, please fill out the form below.</div>
				<div>
					<form method="post" action="secondReservationForm.jsp">
						<select name="scheduleNum" id="scheduleNum">
	   						<option disabled selected>Select Schedule Number</option>
							<%while(nameSet.next()){ %>
						      <option><%= nameSet.getString("trainID") %></option>
							<%} 
							nameSet.beforeFirst(); //reset stationSet for next loop
							%>
	   					</select>
	   					<button class="btn btn-primary" type="submit">Reserve</button>
					</form>
				</div>		
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>