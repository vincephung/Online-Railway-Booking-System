<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!-- Index/Home page for the website. Welcome message/functionalities will vary depending on account type (customer, customer_rep, admin) -->
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
		crossorigin="anonymous">
		<title>Online Railway Booking System</title>
</head>
<body>
	<%@ include file="header.jsp"%>

	<%
	//redirect user to login page if they are not logged in 
	if ((session.getAttribute("user") == null)) {
	    response.sendRedirect("login.jsp");
	} else {
	    String userType = (String) session.getAttribute("type");
	%>
	Welcome
	<%=session.getAttribute("user")%>
	! Your account type is a(n)
	<%=userType%>.

	<div class="userOptions">
		<form class="form-inline my-2" action="viewTrainSchedules.jsp">
			<button class="btn btn-primary" type="submit">View Train Schedules</button>
		</form>
	</div>

	<!-- Different functionalities based on account type -->
	<%
	    if (userType.equals("customer")) {
	%>
			<div class="userOptions">
				<form class="form-inline my-2" action="browseQuestions.jsp">
					<button class="btn btn-primary" type="submit">FAQ</button>
				</form>
			</div>

	<%
	    } else if (userType.equals("customer_rep")) {
	%>		
			<div class="userOptions">
				<form class="form-inline my-2" action="searchByStation.jsp">
					<button class="btn btn-primary" type="submit">Search By Station</button>
				</form>
			</div>
			<div class="userOptions">
				<form class="form-inline my-2" action="unansweredQuestions.jsp">
					<button class="btn btn-primary" type="submit">Unanswered Questions</button>
				</form>
			</div>
			<div class="userOptions">
				<form class="form-inline my-2" action="repReservations.jsp">
					<button class="btn btn-primary" type="submit">Reservations</button>
				</form>
			</div>
			<div class="userOptions">
				<form class="form-inline my-2" action="editViewTrainSchedules.jsp">
					<button class="btn btn-primary" type="submit">View/Edit Train Schedules</button>
				</form>	
			</div>


	<%
	    } else if (userType.equals("admin")) {
	%>



	<%
	    }
	}
	%>

</body>
</html>

