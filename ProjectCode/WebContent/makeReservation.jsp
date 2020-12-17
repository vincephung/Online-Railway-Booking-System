<%@ page import="java.sql.*"%>
<%@ page import = "java.util.Random" %>
    /*Makes reservation from user input in reservation form*/
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
	
	    int originStationID = request.getParameter("originStationID");
	    int destinationStationID = request.getParameter("destinationStationID");
	    String transitLineName = request.getParameter("transitLineName");
	    String trainID = request.getParameter("trainID");
	    String depDate = request.getParameter("depDate");
		boolean roundtripCheck = request.getParameter("roundtrip") != null;
		boolean childCheck = request.getParameter("child") != null;
		boolean seniorCheck = request.getParameter("senior") != null;
		boolean disabledCheck = request.getParameter("disabled") != null;
		

		PreparedStatement ps = con.prepareStatement(setter);
		ResultSet stopSet=  ps.executeQuery("select * from train_schedule where trainID = " + "'" + trainID + "'");
		while (stopSet.next()) {
			int fare= stopSet.getInt("fixedfare");
		}
		int price = fare;

		if (roundtripCheck){
			String trip_type= "roundtrip";
			price= price*2;
		}
		else{
			String trip_type= "normal";
		}
		if (childcheck){
			price=price*.90;
		}
		if(seniorCheck){
			price=price*.85;
		}
		if(disabledCheck){
			price=price*.8;
		}

		int i = rand.nextInt(100000); 
		int reservation_number=i;
		
		String stmt = "insert into reservation (originStationID,destinationStationID,transitLineName,trainID,depDate,trip_type,total_fare,reservation_number) values (?,?,?,?,?,?,?,?)";
		PreparedStatement pos = con.prepareStatement(stmt);
		pos.setInt(1, originStationID);
	    pos.setInt(2, destinationStationID);
	    pos.setString(3, transitLineName);
	    pos.setString(4, trainID);
	    pos.setString(5, depDate);
		pos.setString(6, trip_type);
		pos.setInt(7, total_fare);
		pos.setInt(8, reservation_number);
		pos.executeUpdate();
		out.println("Congrats!, your reservation number is: "+ reservation_number +"!");
		out.println("Click <a href='index.jsp'>here</a> to return to main page");")
		response.sendRedirect("index.jsp");
	    
	} catch (SQLException e) {
	    // Other SQL Exception
	    session.invalidate();
	    out.println(e);
	    out.println("Error <a href='reservationForm.jsp'>try again</a>");
	}
%>