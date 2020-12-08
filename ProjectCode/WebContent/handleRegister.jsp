<%@ page import="java.sql.*"%>
<%
    /*Handles login information: Takes in user input and inserts a new user into the database. Will catch errors such as duplicate usernames*/
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
	
	    String firstname = request.getParameter("firstname");
	    String lastname = request.getParameter("lastname");
	    String email = request.getParameter("email");
	    int age = Integer.parseInt(request.getParameter("age"));
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    String type = request.getParameter("customerType");
	    String ssn = (!request.getParameter("ssn").isEmpty()) ? request.getParameter("ssn") : null; //if no ssn entered, initialize to null
	
	    //if checkbox is checked, set disability to 1 (true)
	    boolean checkDisability = request.getParameter("disabled") != null;
	    int disabled = checkDisability ? 1 : 0;
	
	    String stmt = "insert into users (firstname,lastname,email,age,username,password,type,disabled,ssn) values (?,?,?,?,?,?,?,?,?)";
	    PreparedStatement ps = con.prepareStatement(stmt);
	    ps.setString(1, firstname);
	    ps.setString(2, lastname);
	    ps.setString(3, email);
	    ps.setInt(4, age);
	    ps.setString(5, username);
	    ps.setString(6, password);
	    ps.setString(7, type);
	    ps.setInt(8, disabled);
	    ps.setString(9, ssn);
	    ps.executeUpdate();
	
	    session.setAttribute("user", username);
	    session.setAttribute("type", type);
	    response.sendRedirect("index.jsp");
	} catch (SQLIntegrityConstraintViolationException e) {
	    //duplicate username
	    session.invalidate();
	    out.println("Username is already taken <a href='registerForm.jsp'>try again</a>");
	} catch (SQLException e) {
	    // Other SQL Exception
	    session.invalidate();
	    out.println(e);
	    out.println("Error <a href='registerForm.jsp'>try again</a>");
	}
%>