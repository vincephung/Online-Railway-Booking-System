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
		    String transitLineName = request.getParameter("transitLineName");
		    String trainID = request.getParameter("trainID");
		    String originStation = request.getParameter("originStation");
		    String destinationStation = request.getParameter("destinationStation");
		    String stmt = "select * from stops st, station s where trainID = ? and st.stationID = s.stationID order by arrivalTime;";
		    PreparedStatement ps = con.prepareStatement(stmt);
		    ps.setString(1, trainID);
		    ResultSet stopSet = ps.executeQuery();
	%>

	<div class="container">
		<h1>Train Schedule #<%=trainID%></h1>
			<a href="editViewTrainSchedules.jsp">View All Train Schedules</a>
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
			 <%
			 
              //converts sql date time to java date-time format
                String getArrTime = stopSet.getString("arrivalTime");
                String arrTime = getArrTime.replace(" ","T");
                System.out.println(stopSet.getString("departureTime"));
                String getDepTime = stopSet.getString("departureTime");
                String depTime = null;
                if(getDepTime != null){
                    depTime = getDepTime.replace(" ","T");
                }
               
                %>
			
			<tr>
				<td><%=stopCounter%></td>
				<td><%=stopSet.getString("name")%></td>
				<td><%=stopSet.getString("transitLineName")%></td>
				<td><%=stopSet.getString("trainID")%></td>
				<td>$<%=stopSet.getString("fare")%></td>
				<td>
					<form method="POST" action="updateSchedule.jsp?trainID=<%=trainID%>&transitLineName=<%=transitLineName%>&destinationStation=<%=destinationStation%>&originStation=<%=originStation%>&departureTime=<%=stopSet.getString("departureTime")%>&name=<%=stopSet.getString("name")%>">
						<input type="datetime-local" name="arrivalTime" value="<%=arrTime%>" required>
						<button class="btn btn-primary" type="submit">Update</button>
					</form>
				</td>
				<td>
					<form method="POST" action="updateSchedule.jsp?trainID=<%=trainID%>&transitLineName=<%=transitLineName%>&destinationStation=<%=destinationStation%>&originStation=<%=originStation%>&arrivalTime=<%=stopSet.getString("arrivalTime")%>&name=<%=stopSet.getString("name")%>">
						<input type="datetime-local" name="departureTime" value="<%=depTime%>" required>
						<button class="btn btn-primary" type="submit">Update</button>
					</form>
				</td>
			</tr>
			<%
			    stopCounter++;
			}
			%>
		</table>
		<form method="POST" action="deleteSchedule.jsp?trainID=<%=trainID%>&transitLineName=<%=transitLineName%>&destinationStation=<%=destinationStation%>&originStation=<%=originStation%>">
			<button class="btn btn-primary" type="submit">Delete Schedule</button>
		</form>		
	</div>

	<%
	    } catch (Exception e) {
	        out.println("error" + e);
	        }
	%>

</body>
</html>