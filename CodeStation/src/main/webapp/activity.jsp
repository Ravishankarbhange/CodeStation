<%@ page import="org.jsoup.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="org.jsoup.nodes.*" %>
<%@ page import="org.jsoup.select.*" %>

<%@ page import="java.time.*" %>
<%@ page import="java.time.temporal.TemporalAdjusters" %>

<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Connection" %>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<style type="">
.avatar {
  vertical-align: middle;
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.btn{
  width: 290px;
  background: -webkit-linear-gradient(right, #a6f77b,#2dbd6e);
  border: none;
  border-radius: 21px;
  box-shadow: 0px 1px 8px #24c64f;
  cursor: pointer;
  color: white;
  font-family: "Raleway SemiBold", sans-serif;
  height: 42.3px;
  margin: 0 auto;
  margin-top: 10px;
  transition: 0.25s;
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

#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}
#customers tr:nth-child(odd){background-color: white;}
#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #454647;
  color: white;
}
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
        <a class="nav-link" href="dashboard.jsp">DashBoard <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="contest.jsp">Contests</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="leaderboard.jsp">LeaderBoard</a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="Activity.jsp">Activity</a>
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

<br><br><br><br><br>

<center>
  <table id="customers" style="width: 700px;">
  <tr>
    <th>Website</th>
    <th>Activity Status</th>
  </tr>
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
    String ibid="NA";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT INTERVIEWBITID FROM INTERVIEWBIT WHERE UMAIL='"+umail+"' ");
		
		while(rs.next()){
			ibid = rs.getString("INTERVIEWBITID");
		}
	}catch (ClassNotFoundException cfe) {
		cfe.printStackTrace();
	}catch (SQLException cfe) {
		cfe.printStackTrace();
	}
	String iburl = "https://www.interviewbit.com/profile/"+ibid;
	Document ibcontest = Jsoup.connect(iburl).get();
	Elements iba = ibcontest.select("div.stat.pull-left div.txt");
	
	int ibrank=0,ibscore=0,ibstreak=0;
	int i=0;
	for(Element ibe: iba) {
		if(i==0) {
			ibrank = Integer.valueOf(ibe.html());
		}
		else if(i==1) {
			ibscore = Integer.valueOf(ibe.html());
		}else if(i==2) {
			String str = String.valueOf(ibe.html());
			ibstreak = Integer.valueOf(str.substring(0,1));
		}
		System.out.println("Interviewbit "+ibe.html());
		i++;
	}
	
	
	String gfgid="NA";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT GFGID FROM GFG WHERE UMAIL='"+umail+"' ");
		while(rs.next()){
			gfgid = rs.getString("GFGID");
		}
	}catch (ClassNotFoundException cfe) {
		cfe.printStackTrace();
	}catch (SQLException cfe) {
		cfe.printStackTrace();
	}
	String gfgs = "https://auth.geeksforgeeks.org/user/"+gfgid+"/practice/";

	System.out.println(gfgid);
  	Document contest = Jsoup.connect(gfgs).get();
	Elements gfga = contest.select("div.mdl-grid div.mdl-cell.mdl-cell--6-col.mdl-cell--12-col-phone.textBold");
	Elements gfgb = contest.select("div.mdl-cell.mdl-cell--6-col.mdl-cell--12-col-phone a");
	Elements gfgc = contest.select("div.mdl-cell.mdl-cell--4-col.mdl-cell--12-col-phone.textBold span");
	int j=0;
	int gfgcs=15,gfgps=0,gfgms=0;
	//System.out.println(a.html());
	for(Element gfge: gfga) {
		if(j==0) {
			String str = String.valueOf(gfge.html());
			gfgcs = Integer.valueOf(str.substring(34,str.length()));
			System.out.println("Coding score : "+gfgcs);
		}
		j++;
	}
	if(gfgcs!=0) {
		String gfgss = String.valueOf(gfgb.html());
		System.out.println(gfgb.html());
		gfgps = Integer.valueOf(gfgss.substring(22,gfgss.length()));
		System.out.println("Problems solved: "+gfgps);
	}
	j=0;
	for(Element gfge: gfgc) {
		if(j++==1) {
			String str = String.valueOf(gfge.html());
			gfgms = Integer.valueOf(str);
			System.out.println("Weekly Streak: "+j+","+gfgms);
		}
	}

%>


<%

	LocalDate today = LocalDate.now(); 
	LocalDate lastw = today.plusDays(-7);
	System.out.println("Last date is "+lastw);
	LocalDate ccd = null;
	LocalDate cfd = null;
	LocalDate hed = null;
	System.out.println("Here is the maill "+umail);
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT CC,CF FROM ACTIVITY WHERE UMAIL='"+umail+"' ");
		
		while(rs.next()){
			ccd = LocalDate.parse((rs.getString("CC")));
			System.out.println("Last date is "+lastw+"---"+ccd);
			cfd = LocalDate.parse((rs.getString("CF")));
			System.out.println("Last date is "+lastw+"---"+cfd);
			
		}
	}catch (ClassNotFoundException cfe) {
		cfe.printStackTrace();
	}catch (SQLException cfe) {
		cfe.printStackTrace();
	}
	//String dd = lastw.toString();


%>
  
  <tr>
    <td>CodeChef</td>
	<%
    	if( (lastw.compareTo(ccd))<=0){
    %>
    		<td style="color:green;font-weight: bold;">Active</td>
    <%
    	}else{
    %>
    		<td style="color:Red">Inactive</td>
    <%
    	}
    %>
  </tr>

  <tr>
    <td>CodeForces</td>
	<%
		
    	if( (lastw.compareTo(cfd))<=0){
    %>
    		<td style="color:green;font-weight: bold;">Active</td>
    <%
    	}else{
    %>
    		<td style="color:Red">Inactive</td>
    <%
    	}
    %>
  </tr>
  
  <tr>
    <td>InterviewBit</td>
	<%
    	if(ibstreak>0){
    		%>
    		<td style="color:green;font-weight: bold;">Active</td>
    		<%
    	}else{
    		%>
    		<td style="color:Red">Inactive</td>
    		<%
    	}
    %>
  </tr>
  
  <tr>
    <td>GeeksforGeeks</td>
	<%
    	if(gfgms>0){
    		%>
    		<td style="color:green;font-weight: bold;">Active</td>
    		<%
    	}else{
    		%>
    		<td style="color:Red">Inactive</td>
    		<%
    	}
    %>
  </tr>

	 
</table>
<br><br><br><br>
<%

int ccsun=0,ccmon=0,cctus=0,ccwed=0,ccthu=0,ccfri=0,ccsat=0;
int cfsun=0,cfmon=0,cftus=0,cfwed=0,cfthu=0,cffri=0,cfsat=0;
int gfgsun=0,gfgmon=0,gfgtus=0,gfgwed=0,gfgthu=0,gfgfri=0,gfgsat=0;
int ibsun=0,ibmon=0,ibtus=0,ibwed=0,ibthu=0,ibfri=0,ibsat=0;
try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
	Statement st = con.createStatement();
	String sql = ("SELECT SUN, MON, TUS, WED, THU, FRI, SAT FROM ACC WHERE UMAIL='"+umail+"' ;");
	ResultSet rs = st.executeQuery(sql);
	while(rs.next()) { 
		 ccsun = Integer.parseInt(rs.getString("SUN")); 
		 ccmon = Integer.parseInt(rs.getString("MON")); 
		 cctus = Integer.parseInt(rs.getString("TUS")); 
		 ccwed = Integer.parseInt(rs.getString("WED")); 
		 ccthu = Integer.parseInt(rs.getString("THU")); 
		 ccfri = Integer.parseInt(rs.getString("FRI")); 
		 ccsat = Integer.parseInt(rs.getString("SAT")); 
		 
	}
	
	
	sql = ("SELECT SUN, MON, TUS, WED, THU, FRI, SAT FROM ACF WHERE UMAIL='"+umail+"' ;");
	rs = st.executeQuery(sql);
	while(rs.next()) { 
		 cfsun = Integer.parseInt(rs.getString("SUN")); 
		 cfmon = Integer.parseInt(rs.getString("MON")); 
		 cftus = Integer.parseInt(rs.getString("TUS")); 
		 cfwed = Integer.parseInt(rs.getString("WED")); 
		 cfthu = Integer.parseInt(rs.getString("THU")); 
		 cffri = Integer.parseInt(rs.getString("FRI")); 
		 cfsat = Integer.parseInt(rs.getString("SAT")); 
		 
	}

	
	sql = ("SELECT SUN, MON, TUS, WED, THU, FRI, SAT FROM AGFG WHERE UMAIL='"+umail+"' ;");
	rs = st.executeQuery(sql);
	while(rs.next()) { 
		 gfgsun = Integer.parseInt(rs.getString("SUN")); 
		 gfgmon = Integer.parseInt(rs.getString("MON")); 
		 gfgtus = Integer.parseInt(rs.getString("TUS")); 
		 gfgwed = Integer.parseInt(rs.getString("WED")); 
		 gfgthu = Integer.parseInt(rs.getString("THU")); 
		 gfgfri = Integer.parseInt(rs.getString("FRI")); 
		 gfgsat = Integer.parseInt(rs.getString("SAT")); 
		 
	}
	

	
	sql = ("SELECT SUN, MON, TUS, WED, THU, FRI, SAT FROM AIB WHERE UMAIL='"+umail+"' ;");
	rs = st.executeQuery(sql);
	while(rs.next()) { 
		 ibsun = Integer.parseInt(rs.getString("SUN")); 
		 ibmon = Integer.parseInt(rs.getString("MON")); 
		 ibtus = Integer.parseInt(rs.getString("TUS")); 
		 ibwed = Integer.parseInt(rs.getString("WED")); 
		 ibthu = Integer.parseInt(rs.getString("THU")); 
		 ibfri = Integer.parseInt(rs.getString("FRI")); 
		 ibsat = Integer.parseInt(rs.getString("SAT")); 
		 
	}
	
} catch (ClassNotFoundException e) {
	e.printStackTrace();
} catch (SQLException e) {
	e.printStackTrace();
}


%>



<canvas id="myChart" style="width:100%;max-width:600px"></canvas><br>
<p>Codechef - BROWN | CodeForces - RED | GeeksforGeeks - GREEN | INTERVIEWBIT - BLUE</p>
<script>
var xValues = ['Day1','Day2','Day3','Day4','Day5','Day6','Day7'];

new Chart("myChart", {
  type: "line",
  data: {
    labels: xValues,
    datasets: [{ 
      data: [<%=ccsun%>,<%=ccmon%>,<%=cctus%>,<%=ccwed%>,<%=ccthu%>,<%=ccfri%>,<%=ccsat%>],
      borderColor: "brown",
      fill: false
    }, { 
      data: [<%=cfsun%>,<%=cfmon%>,<%=cftus%>,<%=cfwed%>,<%=cfthu%>,<%=cffri%>,<%=cfsat%>],
      borderColor: "red",
      fill: false
    }, { 
      data: [<%=gfgsun%>,<%=gfgmon%>,<%=gfgtus%>,<%=gfgwed%>,<%=gfgthu%>,<%=gfgfri%>,<%=gfgsat%>],
      borderColor: "green",
      fill: false
    },{ 
      data: [<%=ibsun%>,<%=ibmon%>,<%=ibtus%>,<%=ibwed%>,<%=ibthu%>,<%=ibfri%>,<%=ibsat%>],
      borderColor: "blue",
      fill: false
    }]
  },
  options: {
    legend: {display: false}
  }
});
</script>

</center>
<br><br><br><br><br><br>
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