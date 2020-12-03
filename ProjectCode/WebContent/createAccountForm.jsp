<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
   		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Create Account Form</title>
   </head>
   <body>
   <h1>Create an account</h1>
     <form action="createAccountDB.jsp" method="POST">
       First Name: <input type="text" name="firstname"/> <br/>
       Last Name: <input type="text" name="lastname"/> <br/>
       Email: <input type="text" name="email"/> <br/>
       Username: <input type="text" name="username"/> <br/>
       Password:<input type="password" name="password"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
     <a href='login.jsp'>Click here to login instead</a>
     
   </body>
</html>