<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="styles/index.css">
<title>Register Form</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="registerContainer">
		<h1>Registration Form</h1>
		<div class="container">
			<div class="row align-items-center">
				<div class="col-6 mx-auto">
					<div class="card my-3">
						<div class="card-body">
							<h5 class="card-title text-center">Create a new account</h5>
							<form class="form-signin" action="handleRegister.jsp"
								method="POST">
								<div class="form-label-group">
									<input type="text" class="form-control"
										placeholder="First Name" name="firstname" required autofocus>
								</div>
								<div class="form-label-group">
									<input type="text" class="form-control" placeholder="Last Name"
										name="lastname" required autofocus>
								</div>
								<div class="form-label-group">
									<input type="text" class="form-control" placeholder="Email"
										name="email" required autofocus>
								</div>
								<div class="form-label-group">
									<input type="number" class="form-control" placeholder="Age"
										name="age" required autofocus>
								</div>
								<div class="form-label-group">
									<input type="text" class="form-control" placeholder="Username"
										name="username" required autofocus>
								</div>
								<div class="form-label-group">
									<input type="password" class="form-control"
										placeholder="Password" name="password" required>
								</div>
								<div class="form-label-group">
									<div class="form-check">
										<input class="form-check-input" id="disabledCheck"
											type="checkbox" value="true" name="disabled"> <label
											class="form-check-label" for="disabled"> Do you have
											a disability? </label>
									</div>
								</div>
								<div class="form-label-group">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio"
											name="customerType" id="customer" value="customer" checked>
										<label class="form-check-label" for="customer">Customer</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio"
											name="customerType" id="customer_rep" value="customer_rep">
										<label class="form-check-label" for="customer_rep">Customer
											Representative</label>
									</div>
								</div>
								<div class="form-label-group rep-ssn">
									<input type="text" class="form-control"
										placeholder="Enter SSN if you are a customer representative"
										maxlength="9" name="ssn">
								</div>
								<button class="btn btn-lg btn-primary btn-block text-uppercase"
									type="submit">Register</button>
								<a href='login.jsp'>Click here to log in instead.</a>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

