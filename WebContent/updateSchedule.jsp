<%@ page import="java.sql.*"
%>
<%
    /*Handles login information: Takes in user input and inserts a new user into the database. Will catch errors such as duplicate usernames*/
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
		
	    String trainID = request.getParameter("trainID");
	    String transitLineName = request.getParameter("transitLineName");
	    String destinationStation = request.getParameter("destinationStation");
	    String originStation = request.getParameter("originStation");
	    String arrivalTime = request.getParameter("arrivalTime");
	    String departureTime = request.getParameter("departureTime");
	    String name = request.getParameter("name");
	    		
		String stationID = "select st.stationID from station st where st.name = '" + name + "'";
	    String originID = "select st.stationID from station st where st.name = '" + originStation + "'";
	    String destinationID = "select st.stationID from station st where st.name = '" + destinationStation + "'";
	    String stopUpdate;
	    if(!departureTime.equals("null")){
	    	stopUpdate = "update stops t set arrivalTime = '" + arrivalTime + "', departureTime = '" + departureTime + "' where t.trainID =" + trainID + " and t.transitLineName ='" + transitLineName + "' and t.originStationID = (" + originID + ") and t.destinationStationID = (" + destinationID + ") and t.stationID = (" + stationID + ")";
	    }
	    else{
	    	stopUpdate = "update stops t set arrivalTime = '" + arrivalTime + "', departureTime = " + departureTime + " where t.trainID =" + trainID + " and t.transitLineName ='" + transitLineName + "' and t.originStationID = (" + originID + ") and t.destinationStationID = (" + destinationID + ") and t.stationID = (" + stationID + ")";
	    }
	    PreparedStatement ps1 = con.prepareStatement(stopUpdate);
	    ps1.executeUpdate();
	    
	    /*String maxArrival = "select max(t.arrivalTime) from stops t where t.trainID =" + trainID + " and t.transitLineName ='" + transitLineName + "' and t.originStationID = (" + originID + ") and t.destinationStationID = (" + destinationID + ")";
	    String minDeparture = "select min(t.departureTime) from stops t where t.trainID =" + trainID + " and t.transitLineName ='" + transitLineName + "' and t.originStationID = (" + originID + ") and t.destinationStationID = (" + destinationID + ")";
	    String scheduleUpdate = "update train_schedule ts set ts.arrivalTime = (" + maxArrival + ") and ts.departureTime = (" + minDeparture + ") where ts.trainID =" + trainID + " and ts.transitLineName ='" + transitLineName + "' and ts.originStationID = (" + originID + ") and ts.destinationStationID = (" + destinationID + ")";
	    PreparedStatement ps2 = con.prepareStatement(scheduleUpdate);
	    ps2.executeUpdate();*/
	    
	    
	    response.sendRedirect("editSchedule.jsp?trainID="+ trainID +"&transitLineName="+ transitLineName +"&originStation="+ originStation + "&destinationStation=" + destinationStation);
	} catch (SQLException e) {
	    // Other SQL Exception
	    session.invalidate();
	    out.println(e);
	    out.println("Error <a href='editSchedule.jsp'>try again</a>");
	}
	%>