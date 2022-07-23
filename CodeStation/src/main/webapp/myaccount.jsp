<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="org.jsoup.nodes.*" %>
<%@ page import="org.jsoup.select.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html>
<head>
<title>MyAccount | CodeStation</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

<style type="text/css">
.avatar {
  vertical-align: middle;
  width: 40px;
  height: 40px;
  border-radius: 50%;
}
.column {
  float: right;
  width: 5.33%;
  padding: 0px;
  padding-left: 30px;
  padding-right: 0px;
  border-right: 0px;
  overflow-x: visible;
}
body {
  background-color:#e8e8e8;
  height: 70%;
  margin:0;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}	
h1{
	text-align: center;
	color:black;
}
h1.small {
  font-variant: small-caps;
  font-size: 50px;
}
address{
    font-size:80%;
    margin:0px;
    color:white;
}
.row-content {
    margin:0px auto;
    padding: 50px 0px 50px 0px;
    border-bottom: 1px ridge;
    min-height:400px;
    color: white;
}

.row-footer{
    background-color: #363636;
    margin:0px auto;
    padding: 20px 0px 20px 0px;
}
h5, li{
	color:white;
}
span {
  font-size:24px;
  content: "\2708";
}
a{
	color:white;
  padding-left: 15px;
}

* {
  box-sizing: border-box;
}
.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  padding: 16px;
  text-align: center;
  background-color: #f1f1f1;
}
.container{padding: 2px 16px;}

.button {
  width:100%;
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 6px 32px;
  text-align: center;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}	
label{font-weight: bold; float:left;padding-left: 18px;}
input{float:right;}
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <a class="navbar-brand" href="Coolflights.jsp">CodeStation <i class="fa fa-cubes"></i></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="dashboard.jsp">DashBoard</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="contest.jsp">Contests</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="leaderboard.jsp">LeaderBoard</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="activity.jsp">Activity</a>
      </li>
    </ul>
    <a href="myaccount.jsp">
      <div class="row">

      <div class="column" style="width:10%;margin-top:8px;">
        <i style="font-size:25px;color:white;" class="fa">&#xf2bd;</i>
      </div>

      <div class="column">
      
        <h6 style="color:white;">MyAccount </h6>
      </div>
      
    </div>
  </a>
  </div>
</nav>	
<br><br><br>




<div class="row" style="margin:25px;">

  <div class="column" style="float: left;width: 25%;padding: 0 10px; ">
    <div class="card container" style="height: 550px;"><br>
      <center><img src="myacc.png" style="width:120px;height: 120px;"></center><br>
      <div class="block">
      	<label>USERID</label>
      	<%
      	
      	Cookie[] cookies = null;
    	cookies = request.getCookies();
    	String umail="";
    	for(Cookie c: cookies){
     		if(c.getName().equals("umail")){
     			umail = c.getValue();
     			System.out.println("MAIL: "+cookies[0].getValue());
     		}
    	}
    	String uname="NA";
    	try {
    		Class.forName("com.mysql.jdbc.Driver");
    		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
    		Statement st = con.createStatement();
    		ResultSet rs = st.executeQuery("SELECT UNAME FROM USER WHERE UMAIL='"+umail+"' ");
    		
    		while(rs.next()){
    			uname = rs.getString("UNAME");
    		}
    		
    		
    		
    	}catch (ClassNotFoundException e) {
    		e.printStackTrace();
    	}catch (SQLException e) {
    		e.printStackTrace();
    	}
      	
      	%>
      	<input type="text" name="" value="<%=uname %> ">
      </div><br>
      <div class="block">
      	<label>EMAIL </label>
      	<input type="text" name="" value="<%=umail%>">
      </div>
      
    </div>
  </div>

  <div class="column" style="float: left;width: 75%;padding: 0 10px;">
    <div class="card" style="height: 550px;"><br><br><br>
		<form method="post" action="<%= request.getContextPath() %>/PlatformServlet">
    	<div class="block">
    		<img src="ccimg.png" style="width:33px;height: 30px;float:left;">
      		<label style="font-size: 20px;">CodeChef</label>
      		<input type="text" name="cc" value="" style="width:77%;height:30px;" required>
        </div><br><br><br>
        <div class="block">
    		<img src="gfgimg.png" style="width:30px;height: 26px;float:left;">
      		<label style="font-size: 20px;">GeeksforGeeks</label>
      		<input type="text" name="gfg" value="" style="width:77%;height:30px;" required>
        </div><br><br><br>
        <div class="block">
    		<img src="cfimg.png" style="width:30px;height: 30px;float:left;">
      		<label style="font-size: 20px;">CodeForces</label>
      		<input type="text" name="cf" value="" style="width:77%;height:30px;" required>
        </div><br><br><br>
        <div class="block">
    		<img src="ibimg.png" style="width:30px;height: 30px;float:left;">
      		<label style="font-size: 20px;">InterviewBit</label>
      		<input type="text" name="ib" value="" style="width:77%;height:30px;" required>
        </div><br><br><br><br><br>

        <button type="submit" class="button button3" style="background-color: #5c9e6a;">Update</button>
        </form>
        
        
    </div>
  </div>

</div>





<br>
<div class="footer">
<footer class="row-footer">
  <br>
        <div class="container">
            <div class="row">             
                <div class="col-xs-5 col-xs-offset-1 col-sm-2 col-sm-offset-1">
                    <ul class="list-unstyled"><br>
                        <li><a href="#">Home</a></li>
                        <li><a href="#">About</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>
                <div class="col-xs-6 col-sm-5" >
                    <h5>Our Service</h5>
                    <address>
                       <i class="fa fa-phone" id="phonenumber"></i>:6303504956<br>
                       <i class="fa fa-envelope"></i>:<a style="left:0;" href="bhangeravishankar2302@gmail.com">bhangeravishankar@gmail.com</a>
                    </address>
                </div>
                <div class="col-xs-12 col-sm-4">
                    <div class="nav navbar-nav" style="padding: 40px 10px;"><ul>
                        <a class="btn-social-icon btn-google-plus" href="http://google.com/+"><i class="fa fa-google-plus"></i></a>
                        <a class="btn-social-icon btn-facebook" href="http://www.facebook.com/profile.php?id="><i class="fa fa-facebook"></i></a>
                        <a class="btn-social-icon btn-linkedin" href="http://www.linkedin.com/in/"><i class="fa fa-linkedin"></i></a>
                        <a class="btn-social-icon btn-twitter" href="http://twitter.com/"><i class="fa fa-twitter"></i></a>
                        <a class="btn-social-icon btn-youtube" href="http://youtube.com/"><i class="fa fa-youtube"></i></a>
                        <a class="btn-social-icon" href="mailto:"><i class="fa fa-envelope-o"></i></a>
                        </ul>
                    </div>
                </div>
                <div class="col-xs-12">
                    <p style="padding:0px; border:0px;"></p>
                    <p style="text-align: center;padding-left: 450px; color:white;">© Copyright 2022 RavishankarBhange</p>
                </div>
            </div>
        </div>
    </footer>
</div>

</body>
</html>