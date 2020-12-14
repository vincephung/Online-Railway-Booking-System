<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<<<<<<< HEAD
=======
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>

>>>>>>> a606a897a6300aeee390919dbc12ba903d641f81

<!--Search for train schedules, click on a schedule to see its route(all stops)-->
<!DOCTYPE html>
<html>
<<<<<<< HEAD
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
			resSet = resStmt.executeQuery("select transitLineName, trip_type, depDate, total_fare, reservation_number, username, "+
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
=======
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
>>>>>>> a606a897a6300aeee390919dbc12ba903d641f81
</html>
