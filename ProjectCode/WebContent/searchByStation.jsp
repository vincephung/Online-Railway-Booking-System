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
      
		//query database to get stations for dropdown
		Statement stationStmt = con.createStatement();
		ResultSet stationSet = stationStmt.executeQuery("select distinct s.name from station s");
				
		//User inputted "search" parameters
		ResultSet scheduleSet;
		String station = request.getParameter("station");
		/*String originStation = request.getParameter("origin");   
		String destinationStation = request.getParameter("destination");
		String date = request.getParameter("date");*/
		String sort = request.getParameter("sort");
		
		//Handle querying the database using user inputted parameters, (station)
		//The query works by selecting ALL train schedules and filtering them based on the search parameters
		if(station != null || sort != null){
			/*Only add query if parameter is not null. For example if origin = "Absecon" then query will be where t1.origin = "Absecon", 
			If user does not enter a destination, then there will be no destination query  */
			/*String originString = (station != null) ? "t1.originStation =" + "'"+ originStation + "'" : "";
			String destinationString = (destinationStation != null) ? "t1.destinationStation =" + "'"+ destinationStation + "'" : "";
			String dateString = (!date.equals("")) ? "("+"'"+ date + "'"+ " between t1.departureTime and t1.arrivalTime) " : "";*/
			String sortString = (sort != null) ? "order by " + sort : "";
			
			//StringBuilder whereString = new StringBuilder("where ");
			String whereString;
			//boolean whereStatement = false; //Checks is query needs a where statement. If user only selects sort, the query will not need a where statement
			//boolean andStatement = false; //After a "where" statement, there needs to be and. For example: where x = 2 and y =3. you need an and after where x=2
			if(station != null){
				whereString = "where t1.originStation = " + "'" + station + "' or t1.destinationStation = " + "'" + station + "'";
			}
			else{
				whereString = "";
			}
			/*if(!originString.equals("")){
				whereString.append(originString);
				whereStatement = true;
				andStatement = true;
			}
			if(!destinationString.equals("")){
				whereStatement = true;
				if(andStatement){
					whereString.append("and " + destinationString);
				}else{
					andStatement = true;
					whereString.append(destinationString);
				}
			}
			if(!dateString.equals("")){
				whereStatement = true;
				if(andStatement){
					whereString.append("and " + dateString );
				}else{
					whereString.append(dateString);
				}
			}*/
			
			//if(!whereStatement){whereString.setLength(0);} //if only sort is given, set where to empty string. This is so query will be like select * from s order by x.			
			//selectString is a query to get ALL train schedules along with the names of their origin/destination stations.
			String selectString = "select * from (select * from train_schedule ts, (select s.stationID as oStationID, s.name as originStation from station s)s1, (select s.stationID as destStationID, s.name as destinationStation from station s)s2 where ts.originStationID = s1.oStationID and ts.destinationStationID = s2.destStationID)t1 ";
			String stmt = selectString + whereString + sortString;
			PreparedStatement ps = con.prepareStatement(stmt);
			scheduleSet = ps.executeQuery();
			
		//Initial page before user "searches" will show ALL schedules. 
		 }else{
			 Statement scheduleStmt = con.createStatement();
			 scheduleSet = scheduleStmt.executeQuery("select * from train_schedule ts, (select s.stationID, s.name as originStation from station s)s1, (select s.stationID, s.name as destinationStation from station s)s2 where ts.originStationID = s1.stationID and ts.destinationStationID = s2.stationID");
		 }
		%> 
         
   		<div class="container">
	   		<h1>Train Schedules</h1>
	   		<a href="searchByStation.jsp">View All Train Schedules</a>
	   		<div class="scheduleOptions">
	   			<form method="GET" action="searchByStation.jsp">
	   				<select name="station" id="station">
	   					<option value="" disabled selected>Select Train Station</option>
						<%while(stationSet.next()){ %>
						      <option><%= stationSet.getString("name") %></option>
						<%} 
						stationSet.beforeFirst(); //reset stationSet for next loop
						%>
	   				</select>
	   				<select name="sort" id="sort">
	   					<option value="" disabled selected>Sort By</option>
	   					<option value="arrivalTime">Arrival Time</option>
	   					<option value="departureTime">Departure Time</option>
	   					<option value="fixedFare">Fare</option>
	   					<option value="trainID">Train ID</option>
	   					<option value="travelTime">Travel Time</option>
	   				</select>
				    <button class="btn btn-primary" type="submit">Search</button>
	   			</form>	   			
	   		</div>	   		
		   	<!--  Make an HTML table to show the results in: -->
			<table class="table table-striped table-bordered">
				<tr>    
					<th>Transit Line Name</th>
					<th>Origin Station</th>
					<th>Destination Station</th>
					<th>Train ID</th>
					<th>Fare</th>
					<th>Travel Time</th>
					<th>Departure Time</th>
					<th>Arrival Time</th>
				</tr>
					<%
					//parse out the results
					while (scheduleSet.next()) { %>
						<tr>    
							<td><a href="scheduleStops.jsp?trainID=<%=scheduleSet.getString("trainID")%>"><%= scheduleSet.getString("transitLineName") %></a></td>
							<td><%= scheduleSet.getString("originStation") %></td>
							<td><%= scheduleSet.getString("destinationStation") %></td>
							<td><%= scheduleSet.getString("trainID") %></td>
							<td>$<%= scheduleSet.getString("fixedFare") %></td>
							<td><%= scheduleSet.getString("travelTime") %></td>
							<td><%= scheduleSet.getString("departureTime") %></td>
							<td><%= scheduleSet.getString("arrivalTime") %></td>
						</tr>
					<% } %>
				</table>		
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>