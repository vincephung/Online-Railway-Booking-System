<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      <link rel="stylesheet" href="styles/index.css">
      <title>Make a Reservation</title>
   </head>
   <body>
      <%@ include file="makeReservation.jsp" %>
      <div class="registerContainer">
         <h1>Registration Form</h1>
         <div class="container">
            <div class="row align-items-center">
               <div class="col-6 mx-auto">
                  <div class="card my-3">
                     <div class="card-body">
                        <h5 class="card-title text-center">Choose your details</h5>
                        <form class="form-signin" action="makeReservation.jsp" method="POST">
                           <div class="form-label-group">
                              <input type="text" class="form-control" placeholder="Train Origin ID" name="originStationID" required autofocus>
                           </div>
                           <div class="form-label-group">
                              <input type="text" class="form-control" placeholder="Train Destination ID" name="destinationStationID" required autofocus>
                           </div>
                           <div class="form-label-group">
                              <input type="text" class="form-control" placeholder="Transit" name="transitLineName" required autofocus>
                           </div>
                           <div class="form-label-group">
                              <input type="text" class="form-control" placeholder="Train ID" name="trainID" required autofocus>
                           </div>
                           <div class="form-label-group">
                              <input type="text" class="form-control" placeholder="Departure Date" name="depDate" required autofocus>
                           </div>
                           <div class="form-label-group">
                            <div class="form-check">
                               <input class="form-check-input" id="roundtripCheck" type="checkbox" value="true" name="roundtrip">									  
                               <label class="form-check-label" for="roundtrip">
                              Round-trip?
                               </label>
                            </div>
                            </div>
                            <div class="form-label-group">
                                <div class="form-check">
                                   <input class="form-check-input" id="childCheck" type="checkbox" value="true" name="discount">									  
                                   <label class="form-check-label" for="child">
                                   Child Ticket?
                                   </label>
                                </div>
                                </div>
                                <div class="form-label-group">
                                 <div class="form-check">
                                    <input class="form-check-input" id="seniorCheck" type="checkbox" value="true" name="discount">									  
                                    <label class="form-check-label" for="senior">
                                    Senior Ticket?
                                    </label>
                                 </div>
                                 </div>
                                 <div class="form-label-group">
                                    <div class="form-check">
                                       <input class="form-check-input" id="disabilityCheck" type="checkbox" value="true" name="discount">									  
                                       <label class="form-check-label" for="disability">
                                       Person with disability Ticket?
                                       </label>
                                    </div>
                                    </div>
                         </div>
                         <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Make Reservation</button>
                        </form>
                    </div>
                 </div>
              </div>
           </div>
        </div>
   </body>
</html>

