<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>


<!--Search for train schedules, click on a schedule to see its route(all stops)-->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="styles/trainSchedule.css">
<title>Reservations</title>
</head>
<body>

	<%@ include file="header.jsp"%>
	
	
	<div class="container">
		<h1>My Current Reservations
			</h1>
		<table class="table table-striped table-bordered">
					<tr>
					<th>Reservation Number (Click to Delete)</th>
				<th>Type #</th>
				<th>transitLineName</th>
				<th>trainID</th>
				<th>originStationID</th>
				<th>destinationStationID</th>
				<th>Departure Time</th>
				<th>Total Fare</th>
			</tr>
	<%
	
	/*Loops through the reservation table and find the dates less than current time and returns those tuples so the user can see their current/future reservations.*/
	
      try{
    	 
          Class.forName("com.mysql.jdbc.Driver");
  		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
  		  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  		  String date = sdf.format(new Date());
  		String username = (String) session.getAttribute("user");
  		 String stmt = "select * from reservation where username= ? and depDate >= ?";
  		   PreparedStatement ps = con.prepareStatement(stmt);
  		    ps.setString(1, username);
  		    ps.setString(2, date);
  		    ResultSet rs = ps.executeQuery();
  		    
		    while(rs.next())
		    {
				%>
				<tr>
				<td><a
				href="deleteReservation.jsp?reservID=<%=rs.getString("reservation_number")%>"><%= rs.getString("reservation_number") %></a></td>
					<td><%=rs.getString("trip_type")%></td>
					<td><%=rs.getString("transitLineName")%></td>
					<td><%=rs.getString("trainID")%></td>
					<td><%=rs.getString("originStationID")%></td>
					<td><%=rs.getString("destinationStationID")%></td>
					<td><%=rs.getString("depDate")%></td>
					<td><%=rs.getString("total_fare")%></td>
				</tr>
				</table>
				</div>>
				<%
		    }

	 } catch(Exception e) {
      			out.println("error"+e); 
      		} %>

</body>
</html>
