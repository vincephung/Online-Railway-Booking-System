<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!--Shows the route (all stops) for a single train schedule. -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="styles/trainSchedule.css">
<title>Train Schedule</title>
</head>
<body>
	<%@ include file="header.jsp"%>

	<%
	    try {
		    Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection(
		    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
		    String trainID = request.getParameter("trainID");
		    String stmt = "select * from stops st, station s where trainID = ? and st.stationID = s.stationID order by arrivalTime;";
		    PreparedStatement ps = con.prepareStatement(stmt);
		    ps.setString(1, trainID);
		    ResultSet stopSet = ps.executeQuery();
	%>

	<div class="container">
		<h1>Train Schedule #<%=trainID%></h1>
			<a href="viewTrainSchedules.jsp">View All Train Schedules</a>
		<table class="table table-striped table-bordered">
			<tr>
				<th>Stop #</th>
				<th>Station</th>
				<th>Transit Line Name</th>
				<th>Train ID</th>
				<th>Fare</th>
				<th>Arrival Time</th>
				<th>Departure Time</th>
			</tr>
			<%
			int stopCounter = 1;
			//parse out the results
			while (stopSet.next()) {
			%>
			<tr>
				<td><%=stopCounter%></td>
				<td><%=stopSet.getString("name")%></td>
				<td><%=stopSet.getString("transitLineName")%></td>
				<td><%=stopSet.getString("trainID")%></td>
				<td>$<%=stopSet.getString("fare")%></td>
				<td><%=stopSet.getString("arrivalTime")%></td>
				<td><%=stopSet.getString("departureTime")%></td>
			</tr>
			<%
			    stopCounter++;
			}
			%>
		</table>
	</div>

	<%
	    } catch (Exception e) {
	        out.println("error" + e);
	        }
	%>

</body>
</html>
