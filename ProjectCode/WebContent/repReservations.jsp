<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!--Search for train schedules, click on a schedule to see its route(all stops)-->
<!DOCTYPE html>
<html>
    <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	    <link rel="stylesheet" href="styles/trainSchedule.css">
	    <title>Reservations</title>
   </head>
   <body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
      
		//query database to get transit lines for dropdown
		Statement transitStmt = con.createStatement();
		ResultSet transitSet = transitStmt.executeQuery("select distinct t.transitLineName from train_schedule t");
				
		//User inputted "search" parameters
		ResultSet customerSet;
		String transitLine = request.getParameter("transitLine");
		String date = request.getParameter("date");
		String sort = request.getParameter("sort");
		
		//Handle querying the database using user inputted parameters, (transitLine, date, sort)
		//The query works by selecting ALL train schedules and filtering them based on the search parameters
		if(transitLine != null || date != null || sort != null){
			String transitString = (transitLine != null) ? "and r.transitLineName = " + "'" + transitLine + "'" : "";
			String dateString = (!date.equals("")) ? "and r.arrDate = " + "'" + date + "'": "";
			/*Only add query if parameter is not null. For example if origin = "Absecon" then query will be where t1.origin = "Absecon", 
			If user does not enter a destination, then there will be no destination query  */
			/*String originString = (station != null) ? "t1.originStation =" + "'"+ originStation + "'" : "";
			String destinationString = (destinationStation != null) ? "t1.destinationStation =" + "'"+ destinationStation + "'" : "";
			String dateString = (!date.equals("")) ? "("+"'"+ date + "'"+ " between t1.departureTime and t1.arrivalTime) " : "";*/
			String sortString = (sort != null) ? "order by " + sort : "";
			
			StringBuilder whereString = new StringBuilder("where u.username = r.username ");
			boolean whereStatement = false; //Checks is query needs a where statement. If user only selects sort, the query will not need a where statement
			if(!transitString.equals("")){
				whereString.append(transitString);
				whereStatement = true;
			}
			if(!dateString.equals("")){
				whereString.append(dateString);
				whereStatement = true;
			}
			
			if(!whereStatement){whereString.setLength(0);} //if only sort is given, set where to empty string. This is so query will be like select * from s order by x.			
			//selectString is a query to get ALL customers who have reservations along with their customer info.
			String selectString = "Select u.firstname, u.lastname, u.email, u.username, u.password, u.age, u.ssn from users u, reservation r ";
			String stmt = selectString + whereString + sortString;
			PreparedStatement ps = con.prepareStatement(stmt);
			customerSet = ps.executeQuery();
			
		//Initial page before user "searches" will show all customers with reservations. 
		 }else{
			 Statement customerStmt = con.createStatement();
			 customerSet = customerStmt.executeQuery("Select u.firstname, u.lastname, u.email, u.username, u.password, u.age, u.ssn from users u, reservation r where u.username = r.username");
		 }
		%> 
         
   		<div class="container">
	   		<h1>Customers</h1>
	   		<a href="repReservations.jsp">View All Customers With Reservations</a>
	   		<div class="scheduleOptions">
	   			<form method="GET" action="repReservations.jsp">
	   				<select name="transitLine" id="transitLine">
	   					<option value="" disabled selected>Select Transit Line</option>
						<%while(transitSet.next()){ %>
						      <option><%= transitSet.getString("transitLineName") %></option>
						<%} 
						transitSet.beforeFirst(); //reset transitSet for next loop
						%>
	   				</select>
	   				<input type="datetime-local" name="date" placeholder="yyyy/mm/dd hh:mm:ss.0"/>
	   				<select name="sort" id="sort">
	   					<option value="" disabled selected>Sort By</option>
	   					<option value="firstname">First Name</option>
	   					<option value="lastname">Last Name</option>
	   					<option value="email">Email</option>
	   					<option value="username">Username</option>
	   					<option value="password">Password</option>
	   					<option value="age">Age</option>
	   					<option value="ssn">SSN</option>
	   				</select>
				    <button class="btn btn-primary" type="submit">Search</button>
	   			</form>	   			
	   		</div>	   		
		   	<!--  Make an HTML table to show the results in: -->
			<table class="table table-striped table-bordered">
				<tr>    
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
					<th>Username</th>
					<th>Password</th>
					<th>Age</th>
					<th>SSN</th>
				</tr>
					<%
					//parse out the results
					while (customerSet.next()) { %>
						<tr>    
							<td><%= customerSet.getString("firstname") %></td>
							<td><%= customerSet.getString("lastname") %></td>
							<td><%= customerSet.getString("email") %></td>
							<td><%= customerSet.getString("username") %></td>
							<td><%= customerSet.getString("password") %></td>
							<td><%= customerSet.getString("age") %></td>
							<td><%= customerSet.getString("ssn") %></td>
						</tr>
					<% } %>
				</table>		
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>
