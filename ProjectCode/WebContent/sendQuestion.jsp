<%@ page import="java.sql.*"%>
<%
    /*Handles login information: Takes in user input and inserts a new user into the database. Will catch errors such as duplicate usernames*/
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
		
	    String customerQuestion = request.getParameter("customerQuestion");
	
	    String stmt = "insert into questions values ('" + customerQuestion + "', 'unanswered')";
	    PreparedStatement ps = con.prepareStatement(stmt);
	    ps.executeUpdate();
	    response.sendRedirect("browseQuestions.jsp");
	} catch (SQLIntegrityConstraintViolationException e) {
	    //duplicate username
	    session.invalidate();
	    out.println("Question already exists and is either answered or in the process of being answered. <a href='browseQuestions.jsp'>try again</a>");
	} catch (SQLException e) {
	    // Other SQL Exception
	    session.invalidate();
	    out.println(e);
	    out.println("Error <a href='browseQuestions.jsp'>try again</a>");
	}
%>