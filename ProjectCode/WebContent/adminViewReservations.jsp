<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!--Search for reservations by transit line name/customer name-->
<!DOCTYPE html>
<html>
    <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	    <link rel="stylesheet" href="styles/trainSchedule.css">
	    <title>Reservations</title>
   </head>
   <body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
      
		String searchBy;
		Statement resStmt = con.createStatement();
		ResultSet resSet;
		
		if((searchBy = request.getParameter("transline")) != null){
			resSet = resStmt.executeQuery("select transitLineName, trip_type, depDate, arrDate, reserveDate, total_fare, reservation_number, username, "+
					"originStationID, destinationStationID, trainID "+
					"from reservation where transitLineName = '"+ searchBy + "' ORDER BY depDate ASC");
		%>
		<div class="container">
	   		<h1>Reservations for Transit Line: <%=searchBy%></h1>
	   			
		   	<!--  Make an HTML table to show the results in: -->
			<table class="table table-striped table-bordered">
				<tr>    
					<th>Transit Line Name</th>
					<th>Trip Type</th>
					<th>Total Fare</th>
					<th>Departure Date & Time (YYYY-MM-DD hh:mm:ss)</th>
					<th>Arrival Date & Time (YYYY-MM-DD hh:mm:ss)</th>
					<th>Reservation Made At (YYYY-MM-DD hh:mm:ss)</th>
					<th>Reservation Number</th>
					<th>Train ID</th>
					<th>Origin Station ID</th>
					<th>Destination Station ID</th>
					<th>Username Reservation is Under</th>
				</tr>
					<%
					//parse out the results
					while (resSet.next()) { %>
						<tr>    
							<td><%= resSet.getString("transitLineName") %></td>
							<td><%= resSet.getString("trip_type") %></td>
							<td><%= resSet.getString("total_fare") %></td>
							<td><%= resSet.getString("depDate") %></td>
							<td><%= resSet.getString("arrDate") %></td>
							<td><%= resSet.getString("reserveDate") %></td>
							<td><%= resSet.getString("reservation_number") %></td>
							<td><%= resSet.getString("trainID") %></td>
							<td><%= resSet.getString("originStationID") %></td>
							<td><%= resSet.getString("destinationStationID") %></td>
							<td><%= resSet.getString("username") %></td>
						</tr>
						<% }%>
				</table>		
   		</div>
		<%}%>
		<%
		if((searchBy = request.getParameter("customerName"))!=null){
			//Format of customerName we are getting is Last, First name. The following lines are to split the string into last name and first name. 
			int commaIndex =0;
			for(; commaIndex < searchBy.length(); commaIndex++){
				if(searchBy.charAt(commaIndex) == ',') break;
			}
			String lastname = searchBy.substring(0,commaIndex++);
			String firstname = searchBy.substring(++commaIndex);

			resSet = resStmt.executeQuery("Select t1.lastname 'lastname', t1.firstname 'firstname', r.* "+
				"From reservation r, "+
			    "(Select u.firstname, u.lastname, u.username From users u) t1 " +
				"Where t1.lastname = '" + lastname +"' && t1.firstname = '"+ firstname + "' && r.username = t1.username "+
				"ORDER BY t1.lastname ASC, t1.firstname ASC, r.username ASC");

			%>
			<div class="container">
		   		<h1>Reservations for Customer Named: <%=searchBy%></h1>
		   			
			   	<!--  Make an HTML table to show the results in: -->
				<table class="table table-striped table-bordered">
					<tr>    
						<th>Last Name</th>
						<th>First Name</th>
						<th>Account Username</th>
						<th>Trip Type</th>
						<th>Total Fare</th>
						<th>Transit Line Name</th>
						<th>Departure Date & Time (YYYY-MM-DD hh:mm:ss)</th>
						<th>Arrival Date & Time (YYYY-MM-DD hh:mm:ss)</th>
						<th>Reservation Made At (YYYY-MM-DD hh:mm:ss)</th>
						<th>Reservation Number</th>
						<th>Train ID</th>
						<th>Origin Station ID</th>
						<th>Destination Station ID</th>
					</tr>
						<%
						//parse out the results
						while (resSet.next()) { %>
							<tr>    
								<td><%= resSet.getString("lastname") %></td>
								<td><%= resSet.getString("firstname") %></td>
								<td><%= resSet.getString("username") %></td>
								<td><%= resSet.getString("trip_type") %></td>
								<td><%= resSet.getString("total_fare") %></td>
								<td><%= resSet.getString("transitLineName") %></td>
								<td><%= resSet.getString("depDate") %></td>
								<td><%= resSet.getString("arrDate") %></td>
								<td><%= resSet.getString("reserveDate") %></td>
								<td><%= resSet.getString("reservation_number") %></td>
								<td><%= resSet.getString("trainID") %></td>
								<td><%= resSet.getString("originStationID") %></td>
								<td><%= resSet.getString("destinationStationID") %></td>
							</tr>
							<% }%>
					</table>		
	   		</div>
		<%}

		
		} catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>
