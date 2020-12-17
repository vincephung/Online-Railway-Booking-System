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
		ResultSet stationSet = stationStmt.executeQuery("select distinct sta.name from station sta, stops sto where sta.stationID = sto.stationID and sto.trainID = " + scheduleNum);	
		
	%>
         
   		<div class="container">
	   		<h1>Reservation Details</h1>
			<form method="POST" action="handleReservation.jsp">
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
                	<div class="form-check">
                		<input class="form-check-input" id="disabledCheck" type="checkbox" name="disabled">									  
                        <label class="form-check-label" for="disabled">Disabled</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" id="childCheck" type="checkbox" name="child">									  
                        <label class="form-check-label" for="disabled">Child</label>
                    </div>
                    <div class="form-check">
                                            <input class="form-check-input" id="disabledCheck" type="checkbox" name="senior">									  
                        <label class="form-check-label" for="disabled">Senior</label>
                    </div>
                </div>
                <div>Please specify the type of trip you are making this reservation for.</div>
                <div class="form-label-group">
                	<div class="form-check">
                		<input class="form-check-input" id="directCheck" type="checkbox" name="direct">									  
                        <label class="form-check-label" for="disabled">Direct Trip</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" id="roundCheck" type="checkbox" name="round">									  
                        <label class="form-check-label" for="disabled">Round Trip</label>
                    </div>
                </div>
			</form>	
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>