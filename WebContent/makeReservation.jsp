<%@ page import="java.sql.*"%>
<%@ page import = "java.util.Random" %>
    /*Makes reservation from user input in reservation form*/
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
	
	    String originStationID = request.getParameter("originStationID");
	    String destinationStationID = request.getParameter("destinationStationID");
	    String transitLineName = request.getParameter("transitLineName");
	    String trainID = request.getParameter("trainID");
	    String depDate = request.getParameter("depDate");
		boolean roundtripCheck = request.getParameter("roundtrip") != null;
		boolean childCheck = request.getParameter("child") != null;
		boolean seniorCheck = request.getParameter("senior") != null;
		boolean disabledCheck = request.getParameter("disabled") != null;

		PreparedStatement ps = con.prepareStatement(stmt);
		ps.setString(1, trainID);
		ResultSet stopSet = ps.executeQuery();
		while (stopSet.next()) {
			String fare= stopSet.getString("fare");
		}
		int price = Integer.parseInt(fare);

		if (roundtripCheck){
			String trip_type= "roundtrip";
			price= price*2;
		}
		else{
			String trip_type= "normal";
		}
		if (childcheck){
			price=price-2;
		}
		if(seniorCheck){
			price=price-3;
		}
		if(disabledCheck){
			price=price-4;
		}
		String total_fare= Integer.toString(fare);

		int i = rand.nextInt(100000); 
		String reservation_number=Integer.toString(i);
		
		String stmt = "insert into reservation (originStationID,destinationStationID,transitLineName,trainID,depDate,trip_type,total_fare,reservation_number) values (?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(stmt);
		ps.setString(1, originStationID);
	    ps.setString(2, destinationStationID);
	    ps.setString(3, transitLineName);
	    ps.setString(4, trainID);
	    ps.setString(5, depDate);
		ps.setString(6, trip_type);
		ps.setString(7, total_fare);
		ps.setString(8, reservation_number);
		ps.executeUpdate();
		out.println("Congrats!, your reservation number is: "+ reservation_number);
		response.sendRedirect("index.jsp");
	    
	} catch (SQLException e) {
	    // Other SQL Exception
	    session.invalidate();
	    out.println(e);
	    out.println("Error <a href='reservationForm.jsp'>try again</a>");
	}
%>