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
	    <title>Reservation Details</title>
   </head>
   <body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
				
		//passed schedule number parameter
		String scheduleNum = request.getParameter("scheduleNum");
		
		//query stations for that schedule
		Statement stationStmt = con.createStatement();
<<<<<<< HEAD
        ResultSet stationSet = stationStmt.executeQuery("select distinct sta.name from station sta, stops sto where sta.stationID = sto.stationID and sto.trainID = " + scheduleNum);   
=======
		ResultSet stationSet = stationStmt.executeQuery("select distinct sta.name from station sta, stops sto where sta.stationID = sto.stationID and sto.trainID = " + scheduleNum);	
>>>>>>> e83feafbdddf550b562ae19e88e540afd7f7b66a
		
	%>
         
   		<div class="container">
	   		<h1>Reservation Details</h1>
			<form method="POST" action="handleReservation.jsp">
			<div class="trainNumber">
			     <label for="scheduleNumber">Schedule Number:</label>
			     <input type="text" name="scheduleNumber" value=<%=scheduleNum %> disabled></input>
			 </div>
				<select name="originStationName" id="originStationName">
	   				<option  value="" disabled selected>Select Origin Station</option>
						<%while(stationSet.next()){ %>
						<option><%= stationSet.getString("name") %></option>
						<%} 
						stationSet.beforeFirst(); //reset stationSet for next loop
						%>
	   			</select>
	   			<select name="destinationStationName" id="desinationStationName">
	   				<option  value="" disabled selected>Select Destination Station</option>
						<%while(stationSet.next()){ %>
						<option><%= stationSet.getString("name") %></option>
						<%} 
						stationSet.beforeFirst(); //reset stationSet for next loop
						%>
	   			</select>
	   			<div>Please specify if the reservation is being made for a customer meeting one of the following criteria:</div>                
                 <div class="form-label-group">
                    <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="discount_type" id="child" value="child">
                                 <label class="form-check-label" for="child">Child</label>
                    </div>
                   <div class="form-check form-check-inline">
                           <input class="form-check-input" type="radio" name="discount_type" id="senior" value="senior">
                           <label class="form-check-label" for="senior">Senior</label>
                   </div>
                   <div class="form-check form-check-inline">
                          <input class="form-check-input" type="radio" name="discount_type" id="disabled" value="disabled">
                          <label class="form-check-label" for="disabled">Disabled</label>
                  </div>            
                </div>
              
                <div>Please specify the type of trip you are making this reservation for.</div>                
                <div class="form-label-group">
                    <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="trip_type" id="direct" value="direct" checked>
                                 <label class="form-check-label" for="direct">Direct Trip</label>
                    </div>
                   <div class="form-check form-check-inline">
                           <input class="form-check-input" type="radio" name="trip_type" id="round" value="round">
                           <label class="form-check-label" for="round">Round Trip</label>
                   </div>           
                </div>
                <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Submit</button>
			</form>	
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>