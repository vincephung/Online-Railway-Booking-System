<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!--Handles Updating/Deleting Customer Representative's Information In Database. Catches trying to change username to one already taken.-->
<!DOCTYPE html>
<html>
    <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	    <link rel="stylesheet" href="styles/trainSchedule.css">
	    <title>Executing Rep. Changes</title>
   </head>
   <body>
    <%@ include file="header.jsp" %>   
      <%
      try{
      
		String repUserName;
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");

		//Completely delete Customber Rep
		if((repUserName = request.getParameter("deleteRep"))!=null){
			String delStmt = "Delete from users where username = ?";
			PreparedStatement ps = con.prepareStatement(delStmt);
			ps.setString(1,repUserName);
			ps.executeUpdate();
			session.setAttribute("user", "admin");
		    session.setAttribute("type", "admin");
		    out.println("Deletion completed! Please click <a href='index.jsp'>here</a> to return to the admin action page");
		}
		//edit/delete certain customer rep attributes
		else{
			repUserName = request.getParameter("repUserName"); //This is the current username of rep. For the case of changing the username.
			String firstname = (!request.getParameter("firstname").isEmpty()) ? request.getParameter("firstname") : null;
		    String lastname = (!request.getParameter("lastname").isEmpty()) ? request.getParameter("lastname") : null;
		    String email = (!request.getParameter("email").isEmpty()) ? request.getParameter("email") : null;
		    String age = (!request.getParameter("age").isEmpty()) ? request.getParameter("age") : null;
		    String username = request.getParameter("username");
		    String password = request.getParameter("password");
		    String type = request.getParameter("customerType");
		    String stmt = "update users set firstname =?,lastname =?,email =?,age =?,username =?,password = ?,type =? where username =?";
		    PreparedStatement ps = con.prepareStatement(stmt);
		    ps.setString(1, firstname);
		    ps.setString(2, lastname);
		    ps.setString(3, email);
		    //If no value given for age, treat it as object, null
		    if(age == null){
		    	ps.setString(4, age);
		    }
		    else{
		    	ps.setInt(4, Integer.parseInt(age));
		    }
		    ps.setString(5, username);
		    ps.setString(6, password);
		    ps.setString(7, type);
		    ps.setString(8, repUserName);
		    ps.executeUpdate();

		    session.setAttribute("user", "admin");
		    session.setAttribute("type", "admin");
		    out.println("Update completed! Please click <a href='index.jsp'>here</a> to return to the admin action page");
		}
  	} catch (SQLIntegrityConstraintViolationException e) {
	    //duplicate username
	    session.invalidate();
	    out.println("Username is already taken <a href='selectCustomerRep.jsp'>try again</a>");
	} catch (SQLException e) {
	    // Other SQL Exception
	    session.invalidate();
	    out.println(e);
	    out.println("Error <a href='selectCustomerRep.jsp'>try again</a>");
	}
   	%>	
   </body>
</html>
