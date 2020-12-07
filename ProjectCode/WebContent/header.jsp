<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!-- Nav bar for all pages, allows users to return to the home page or logout. -->
<!DOCTYPE html>
<html>
   <head>
   		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">      
   </head>
   <body>
		<nav class="navbar navbar-expand-lg navbar-light bg-light d-flex justify-content-between">
  			<a class="navbar-brand" href="index.jsp">Home</a>
  			<%
    		if ((session.getAttribute("user") != null)) { // logout btn only appears if user is logged in
			%>
		    <form class="form-inline my-2" action="logout.jsp">
		      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Log Out</button>
		    </form>  
		    <%
		    }
		    %>
		</nav>
   </body>
</html>

