<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
   		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      
      <title>OnlineRailwayBookingSystem</title>
   </head>
   <body>
      <%@ include file="header.jsp" %>
      
	  	<% if ((session.getAttribute("user") == null)) { %>
		You are not logged in<br/>
		<a href="index.jsp">Please Login</a>
		<% } 
	 	else { %>
	 	<%String userType = (String)session.getAttribute("type"); %>
	 	
		Welcome <%=session.getAttribute("user")%> ! Your account type is a(n) <%=userType%>.
		
		<div class="userOptions">
			<form class="form-inline my-2" action="viewTrainSchedules.jsp">
				<button class="btn btn-primary" type="submit">View Train Schedules</button>
		    </form> 
		</div>
		<%if (userType.equals("customer")) { %>
			
		<%}
		else if (userType.equals("customer_rep")){%>
					
		
		<%} 
		else if(userType.equals("admin")){%>
					
		
		
		<%}
		    }%>
     
   </body>
</html>

