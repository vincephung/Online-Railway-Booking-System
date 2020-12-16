<%@ page import="java.sql.*"%>
<%
    /*Handles login information: Takes in user input and inserts a new user into the database. Will catch errors such as duplicate usernames*/
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
		
	    String selectedQuestion = request.getParameter("selectedQuestion");
	    String repAnswer = request.getParameter("repAnswer");
	
	    String stmt = "update questions set answer = '" + repAnswer + "' where question = '" + selectedQuestion + "'";
	    PreparedStatement ps = con.prepareStatement(stmt);
	    ps.executeUpdate();
	    response.sendRedirect("unansweredQuestions.jsp");
	} catch (SQLException e) {
	    // Other SQL Exception
	    session.invalidate();
	    out.println(e);
	    out.println("Error <a href='unansweredQuestions.jsp'>try again</a>");
	}
%>