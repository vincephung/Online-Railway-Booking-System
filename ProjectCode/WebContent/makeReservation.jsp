<%@ page import="java.sql.*"%>
<%
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
		boolean discountCheck = request.getParameter("discount") != null;
	    int rtrip = roundtripCheck ? 1 : 0;
		int dcheck= discountCheck ? 1:0;
	    
	} catch (SQLException e) {
	    // Other SQL Exception
	    session.invalidate();
	    out.println(e);
	    out.println("Error <a href='reservationForm.jsp'>try again</a>");
	}
%>