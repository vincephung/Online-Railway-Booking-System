<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
   		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
   		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      	<link rel="stylesheet" href="styles/trainSchedule.css">
      	<title>OnlineRailwayBookingSystem</title>
   </head>
   <body>
         <%@ include file="header.jsp" %>
         
   		<div class="container">
	   		<h1>Train Schedules</h1>
	   		<div class="scheduleOptions">
	   			<form>
	   				<select name="origin" id="origin">
	   					<option value="none" disabled selected>Select Train Origin</option>
	   					<option value="test">test</option>
	   					<option value="test">4</option>
	   					<option value="test">2</option>
	   					<option value="test"></option>
	   				</select>
	   				<select name="destination" id="destination">
	   					<option value="none" disabled selected>Select Train Destination</option>
	   					<option value="test">test</option>
	   					<option value="test">4</option>
	   					<option value="test">2</option>
	   					<option value="test"></option>
	   				</select>
	   				<select name="sort" id="sort">
	   					<option value="none" disabled selected>Sort By</option>
	   					<option value="test">Arrival Time</option>
	   					<option value="test">Departure Time</option>
	   					<option value="test">Fare</option>
	   				</select>
	   				<input type="date" name="date"/>
				    <button class="btn btn-primary" type="submit">Search</button>
	   			</form>
	   		</div>
   		</div>
   </body>
</html>
