<%@ page import ="java.sql.*" %>
<%

/*Handles login information: checks if user input matches any username/password combination in the database */
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project","admin", "336Project");
	
		String username = request.getParameter("username");   
	    String pwd = request.getParameter("password");
	    
		String stmt = "select * from users where username= ? and password=?";
	    PreparedStatement ps = con.prepareStatement(stmt);
	    ps.setString(1,username);
	    ps.setString(2,pwd);
	    
	    ResultSet rs = ps.executeQuery();
	    if (rs.next()) {
	        session.setAttribute("user", username);
	        session.setAttribute("type",rs.getString("type"));
	        response.sendRedirect("index.jsp");
	    } else {
	        out.println("Invalid username or password <a href='index.jsp'>try again</a>");
	    }
	}catch(Exception e){
		out.println("error" + e);
	}
%>