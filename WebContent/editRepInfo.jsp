<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!--Shows the current information for specified rep. in the system and allows For changes/deletions-->
<!--The following attributes are not allowed to be left blank: Username, Password. SSN cannot be changed @Piazzapost 382. -->
<!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      <link rel="stylesheet" href="styles/index.css">
      <title>Edit Rep.</title>
   </head>
   <body>
      <%@ include file="header.jsp" %>
      <%try {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
	
	    String repUserName = request.getParameter("custrep");
	    
	    Statement repStmt = con.createStatement();
		ResultSet repSet = repStmt.executeQuery("select * from users where username = " + "'"+ repUserName +"'");
	    repSet.next();
	    //Manually initalizing strings to read the null value as the empty string
	    String firstname = (repSet.getString("firstname") != null) ? repSet.getString("firstname") : "";
	    String lastname = (repSet.getString("lastname") != null) ? repSet.getString("lastname") : "";
	    String email = (repSet.getString("email") != null) ? repSet.getString("email") : "";

	   %> 
	    <div class="registerContainer">
	    <br>
         <p>Fields are auto-filled with current information.<br>
         A blank field means there is no information stored.<br>
         To delete a field, simply leave it blank. Username and Password must be filled.<br>
         Please edit the ones you would like to change and click submit.</p>
         <div class="container">
            <div class="row align-items-center">
               <div class="col-6 mx-auto">
                  <div class="card my-3">
                     <div class="card-body">
                        <h5 class="card-title text-center">Edit Info of Username: <%=repUserName%></h5>
                        <form class="form-signin" action="handleRepEdits.jsp" method="POST">
                        	<div>                        
                        		<input type="hidden" name="repUserName" value="<%=repUserName%>">  
                       		</div>
                           <div class="form-label-group">
                           	  <label for="firstname">Firstname</label>
                              <input type="text" class="form-control" value ="<%=firstname%>" placeholder="First Name" name="firstname" autofocus>
                           </div>
                           <div class="form-label-group">
                              <label for="lastname">Lastname</label>
                              <input type="text" class="form-control" value ="<%=lastname%>" placeholder="Last Name" name="lastname">
                           </div>
                           <div class="form-label-group">
                           	  <label for="email">Email</label>
                              <input type="text" class="form-control" value ="<%=email%>" placeholder="Email" name="email">
                           </div>
                           <div class="form-label-group">
                              <label for="age">Age</label>
                              <input type="number" class="form-control" value ="<%=repSet.getString("age")%>" placeholder="Age" name="age">
                           </div>
                           <div class="form-label-group">
                              <label for="username">Username</label>
                              <input type="text" class="form-control" value ="<%=repSet.getString("username")%>" placeholder="Username" name="username" required>
                           </div>
                           <div class="form-label-group">
                              <label for="password">Password</label>
                              <input type="password" class="form-control" value ="<%=repSet.getString("password")%>" placeholder="Password" name="password" required>
                           </div>
                           <div class="form-label-group">
                              <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="customerType" id="customer" value="customer">
                                 <label class="form-check-label" for="customer">Customer</label>
                              </div>
                              <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="customerType" id="customer_rep" value="customer_rep" checked>
                                 <label class="form-check-label" for="customer_rep">Customer Representative</label>
                              </div>
                           </div>
                           <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Submit</button>
                           <br>
                        </form>
                        <h6>OR</h6>
                        <form action="handleRepEdits.jsp" method="POST">
                        	<input type="hidden" name="deleteRep" value="<%=repUserName%>">  
                        	<button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Remove all info</button>
						</form>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
	   <% } catch(Exception e) {
      	out.println("error"+e); 
      	} %>
     
   </body>
</html>

