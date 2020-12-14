<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!--(Admin Function) Produces a list of revenues per transit lines-->
<!DOCTYPE html>
<html>
    <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	    <link rel="stylesheet" href="styles/trainSchedule.css">
	    <title>Revenue Per Line</title>
   </head>
   <body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
      
		
		Statement revStmt = con.createStatement();
		ResultSet revSet = revStmt.executeQuery("Select r.transitLineName, sum(total_fare) revenue From reservation r Group by r.transitLineName order by r.transitLineName asc");
		 
		%> 
         
   		<div class="container">
	   		<h1>Revenue per Transit Line</h1>	   		
		   	<!--  Make an HTML table to show the results in: -->
			<table class="table table-striped table-bordered">
				<tr>    
					<th>Transit Line Name</th>
					<th>Revenue</th>
				</tr>
					<%
					//parse out the results
					while (revSet.next()) { %>
						<tr>    
							<td><%= revSet.getString("transitLineName") %></td>
							<td>$<%= revSet.getString("revenue") %></td>
						</tr>
					<% } %>
				</table>		
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>
