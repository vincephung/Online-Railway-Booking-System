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
	<%=session.getAttribute("user")%>! 
	Your account type is a(n)
	<%=userType%>.

	<div class="userOptions">
		<form class="form-inline my-2" action="viewTrainSchedules.jsp">
			<button class="btn btn-primary" type="submit">View Train
				Schedules</button>
		</form>
		<form class="form-inline my-2" action="viewReservations.jsp">
			<button class="btn btn-primary" type="submit">View Current Reservation
				Schedules</button>
		</form>
		<form class="form-inline my-2" action="viewPastReservations.jsp">
			<button class="btn btn-primary" type="submit">View Past Reservation
				Schedules</button>
		</form>
		<form class="form-inline my-2" action="schedulesReservations.jsp">
			<button class="btn btn-primary" type="submit">Make a Reservation</button>
		</form>
		      <form class="form-inline my-2" action="schedulesReservations.jsp">
            <button class="btn btn-primary" type="submit">Schedule Reservations</button>
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
	<br>
	<div class="adminOptions">
   		Please select your action:
			<div class="list-group">
			  <a href="selectCustomerRep.jsp" class="list-group-item list-group-item-action">Add/Edit/Delete Customer Representative</a>
			  <a href="salesReport.jsp" class="list-group-item list-group-item-action">Obtain Monthly Sales Reports</a>
			  <a href="listReservationsOptions.jsp" class="list-group-item list-group-item-action">Get List of Reservations by Transit Line/Customer Name</a>
			  <a href="revPerLine.jsp" class="list-group-item list-group-item-action">List of Revenue Per Transit Line</a>
			  <a href="revPerCustomer.jsp" class="list-group-item list-group-item-action">List of Revenue Per Customer Name</a>
			  <a href="bestCustomer.jsp" class="list-group-item list-group-item-action">See Best Customer</a>
			  <a href="mostActiveLines.jsp" class="list-group-item list-group-item-action">See 5 Most Active Transit Lines</a>
			</div>
	</div>
	
	<%
	    }
	}
	%>

</body>
</html>

