<%@ page import="java.sql.*"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%
    /*Handles reserving a train ticket */
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(
        "jdbc:mysql://cs336db.ckzts11k48yi.us-east-2.rds.amazonaws.com:3306/Project", "admin", "336Project");
    
        String trainID = request.getParameter("scheduleNumber"); 
        System.out.println(trainID);
        String discount_type = request.getParameter("discount_type");
        String trip_type = request.getParameter("trip_type");
        String username = (String)session.getAttribute("user");
        String transitLineName = null;
        int reservationNumber = 0;
        int originStationID = 0;
        int destinationStationID = 0;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String reserveDate = sdf.format(new Date());
        int total_fare = 0;
        String depDate = null;
        String arrDate = null;
        
        //gets total amount of reservations and adds 1 to make a new one
        Statement reservationStmt = con.createStatement();
        ResultSet reservationCount = reservationStmt.executeQuery("select count(*) as count from reservation");
        while(reservationCount.next()){
            reservationNumber = reservationCount.getInt("count") + 1;
        }
       
        //query information about this schedule id
        Statement scheduleStmt = con.createStatement();
        ResultSet scheduleInfo = scheduleStmt.executeQuery("select * from train_schedule where trainID = " + "'" + trainID + "'");
        while(scheduleInfo.next()){
            transitLineName = scheduleInfo.getString("transitLineName");
            originStationID = scheduleInfo.getInt("originStationID");
            destinationStationID = scheduleInfo.getInt("destinationStationID");
            total_fare = scheduleInfo.getInt("fixedfare");
            depDate = scheduleInfo.getString("departureTime");
            arrDate = scheduleInfo.getString("arrivalTime");

        }
        
        if(trip_type.equals("round")){
            total_fare *= 2;
        }
        
        //change fare depending on discount type
        if(discount_type != null){
	        if(discount_type.equals("child")){
	            total_fare *= .75;
	        }else if(discount_type.equals("senior")){
	            total_fare *= .65;
	        }else if(discount_type.equals("disabled")){
	            total_fare *= .5;
	        }
        }

        String stmt = "insert into reservation (trip_type,reserveDate,total_fare,reservation_number,username,originStationID,destinationStationID,trainID,transitLineName,depDate,arrDate) values (?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(stmt);
        ps.setString(1, trip_type);
        ps.setString(2, reserveDate);
        ps.setInt(3, total_fare);
        ps.setInt(4, reservationNumber);
        ps.setString(5,username);
        ps.setInt(6, originStationID);
        ps.setInt(7, destinationStationID);
        ps.setString(8, trainID);
        ps.setString(9, transitLineName);
        ps.setString(10, depDate);
        ps.setString(11, arrDate);

        ps.executeUpdate();

        response.sendRedirect("index.jsp");
    } catch (SQLException e) {
        //SQL Exception
        session.invalidate();
        out.println(e);
    }
%>