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
	    String travelTime = request.getParameter("travelTime");
	    		
	    String originID = "select st.stationID from station st where st.name = '" + originStation + "'";
	    String destinationID = "select st.stationID from station st where st.name = '" + destinationStation + "'";
	    String scheduleUpdate = "update train_schedule t set arrivalTime = '" + arrivalTime + "', departureTime = '" + departureTime + "', travelTime = '" + travelTime + "' where t.trainID =" + trainID + " and t.transitLineName ='" + transitLineName + "' and t.originStationID = (" + originID + ") and t.destinationStationID = (" + destinationID + ")";

	    PreparedStatement ps1 = con.prepareStatement(scheduleUpdate);
	    ps1.executeUpdate();
	    
	    
	    response.sendRedirect("editViewTrainSchedules.jsp");
	} catch (SQLException e) {
	    // Other SQL Exception
	    session.invalidate();
	    out.println(e);
	    out.println("Error <a href='editViewTrainSchedules.jsp'>try again</a>");
	}
	%>