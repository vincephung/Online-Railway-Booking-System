<%@ page import="java.sql.*"%>
<%
    /*Adds a reservation for a user using the train ID number clicked on by the user in viewReservations.jsp*/
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
		String trainID = request.getParameter("trainID");
		String revID = request.getParameter("reservID");
		PreparedStatement ps = con.prepareStatement(revID);
	    ps.setString(1, revID);
	    ps.executeUpdate();
		boolean checkDisability = request.getParameter("disabled") != null;
		if (checkDisability){
			String fare = request.getParameter("total_fare");
			PreparedStatement ps = con.prepareStatement(fare);
			ps.setString(1, fare);
			ps.executeUpdate();
		}
		boolean checkRound = request.getParameter("roundtrip") != null;
		if (checkRound){
			String fare = request.getParameter("total_fare");
			PreparedStatement ps = con.prepareStatement(fare);
			ps.setString(1, fare);
			ps.executeUpdate();
		}

	    response.sendRedirect("viewReservations.jsp");
	} catch (Exception e) {
	    out.println("error" + e);
	}
%>