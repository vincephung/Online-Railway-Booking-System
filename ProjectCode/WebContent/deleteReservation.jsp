<%@ page import="java.sql.*"%>
<%
    /*Deletes a reservation for a user using the reservation number clicked on by the user in viewReservations.jsp*/
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
	    String revID = request.getParameter("reservID");
	    String stmt = "delete from reservation where reservation_number= ?";
	    PreparedStatement ps = con.prepareStatement(stmt);
	    ps.setString(1, revID);
	    ps.executeUpdate();
	    response.sendRedirect("viewReservations.jsp");
	} catch (Exception e) {
	    out.println("error" + e);
	}
%>