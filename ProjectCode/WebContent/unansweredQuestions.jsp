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
	    <title>FAQ</title>
   </head>
   <body>
    <%@ include file="header.jsp" %>   
      <%
      try{
        Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
				
		//User inputted "keyword" parameter
		String keyword = request.getParameter("keyword");
		ResultSet questionSet;
		
		//check if keyword is given or not
		if(keyword != null && !keyword.equals("")){
			String stmt = "Select * from questions q where q.question like '%" + keyword + "%' and q.answer = 'unanswered'";
			PreparedStatement ps = con.prepareStatement(stmt);
			questionSet = ps.executeQuery();
			
		}
		else{
			String stmt = "Select * from questions q where q.answer = 'unanswered'";
			PreparedStatement ps = con.prepareStatement(stmt);
			questionSet = ps.executeQuery();
		}
	%>
         
   		<div class="container">
	   		<h1>Unanswered Questions</h1>
	   		<a href="unansweredQuestions.jsp">View all Unanswered Questions </a>
	   		<div class="scheduleOptions">
	   			<form method="GET" action="unansweredQuestions.jsp">
	   				<input type="text" name="keyword" placeholder="Keyword Search" >
				    <button class="btn btn-primary" type="submit">Search</button>
	   			</form>	   			
	   		</div>	   		
		   	<!--  Make an HTML table to show the results in: -->
			<table class="table table-striped table-bordered">
				<tr>    
					<th>Question</th>
					<th>Send Answer</th>
				</tr>
					<%
					//parse out the results
					while (questionSet.next()) { %>
						<tr>    
							<td><%= questionSet.getString("question") %></td>
							<td>
								<form method="POST" action="answerQuestion.jsp?selectedQuestion=<%= questionSet.getString("question") %>">
									<input type="text" name="repAnswer" placeholder="Type Answer Here" required>
				    				<button class="btn btn-primary" type="submit">Submit</button>
								</form>
							</td>
						</tr>
					<% } %>
				</table>	
   		</div>
   		<% } catch(Exception e) {
      			out.println("error"+e); 
      		} %>
   		
   </body>
</html>