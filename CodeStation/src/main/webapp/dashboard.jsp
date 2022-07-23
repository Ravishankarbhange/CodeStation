<%@ page import="org.jsoup.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="org.jsoup.nodes.*" %>
<%@ page import="org.jsoup.select.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Connection" %>

<%@ page import="java.time.*" %>
<%@ page import="java.time.temporal.TemporalAdjusters" %>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
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
</style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <a class="navbar-brand" href="">CodeStation <i class="fa fa-cubes"></i></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link active" href="Home.jsp">DashBoard <span class="sr-only">(current)</span></a>
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
	
	
	//-----------------------------------------------------CODECHEF------------------------------------------------------------
	
	String ccid="NA";
	int dccrating=0,dccfsp=0,dccpsp=0,dccgr=0,dcccr=0;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
		Statement st = con.createStatement();
		
		ResultSet rs = st.executeQuery("SELECT CODECHEFID, RATING, FULL_SOV, PAR_SOV, GLO_RANK, COU_RANK FROM CODECHEF WHERE UMAIL='"+umail+"' ");
		
		while(rs.next()){
			ccid = rs.getString("CODECHEFID");
			dccrating = Integer.parseInt(rs.getString("RATING"));
			dccfsp = Integer.parseInt(rs.getString("FULL_SOV"));
			dccpsp = Integer.parseInt(rs.getString("PAR_SOV"));
			dccgr = Integer.parseInt(rs.getString("GLO_RANK"));
			dcccr = Integer.parseInt(rs.getString("COU_RANK"));
		}
		
		
		
	}catch (ClassNotFoundException e) {
		e.printStackTrace();
	}catch (SQLException e) {
		e.printStackTrace();
	}
	System.out.println(umail+"=->"+ccid);
    String ccs = "https://www.codechef.com/users/"+ccid+"";
    System.out.println(ccs);
	Document doc = Jsoup.connect(ccs).get();

	int ccrating,ccfsp=0,ccpsp=0,ccgr=0,cccr=0;

	Elements e = doc.select("div.rating-number");
	ccrating = Integer.valueOf(e.html());
	
	
	Elements ee = doc.select("section.rating-data-section.problems-solved div.content h5");
	int j=0;
	for(Element a: ee) {
		if(j++==0) {
			String str = String.valueOf(a.html());
			ccfsp = Integer.valueOf(str.substring(14,str.length()-1));
		}
		else {
			String str = String.valueOf(a.html());
			ccpsp = Integer.valueOf(str.substring(18,str.length()-1));
		}
	}
	
	Elements eee = doc.select("div.rating-ranks ul li a strong");
	int i=0;
	for(Element a: eee) {
		if(i++==0) {
			String str = String.valueOf(a.html());
			if(!str.equals("Inactive"))
				ccgr = Integer.valueOf(a.html());
		}
		else {
			String str = String.valueOf(a.html());
			if(!str.equals("Inactive"))
				cccr = Integer.valueOf(a.html());
		}
	}
	
	
	
	
	//---------------------------------------------------CODEFORCES------------------------------------------------------------
	
	
	
	int dcur_rat=0,dhig_rat=0,dsovprob=0;
	
	String cfid="NA";
		try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT CODEFORCES, CUR_RATING, HIG_RATING, SOV_PROB FROM CODEFORCES WHERE UMAIL='"+umail+"' ");
		
		while(rs.next()){
			cfid = rs.getString("CODEFORCES");
			dcur_rat = Integer.parseInt(rs.getString("CUR_RATING"));
			dhig_rat = Integer.parseInt(rs.getString("HIG_RATING"));
			dsovprob = Integer.parseInt(rs.getString("SOV_PROB"));
		}
		
		
		
	}catch (ClassNotFoundException cfe) {
		cfe.printStackTrace();
	}catch (SQLException cfe) {
		cfe.printStackTrace();
	}
  	String cfurl ="https://codeforces.com/profile/"+cfid;
  	System.out.println(cfid);
  	Document cfdoc = Jsoup.connect(cfurl).get();
	//Elements a = cfdoc.select("h1.long_handle a");
	Elements b = cfdoc.select("div._UserActivityFrame_counterValue");
	Elements c = cfdoc.select("span.user-gray");
	
	int sovprob=0,cur_rat=0,hig_rat=0;
	
	i=0;
	for(Element cfe: b) {
		if(i==0) {
		    String str = String.valueOf(cfe.html());
		    System.out.println(str);
			sovprob = Integer.valueOf(str.substring(0,str.length()-9));
			System.out.println("Sov prob");
		}
		else if(i==7) {
			cur_rat = Integer.valueOf(cfe.html());
		}else if(i==9) {
			hig_rat = Integer.valueOf(cfe.html());
		}
		i++;
	}
	System.out.println("Ratings");
	i=0;
	for(Element cfe: c) {
		if(i==1) {
			cur_rat = Integer.valueOf(cfe.html());
		}else if(i==3) {
			hig_rat = Integer.valueOf(cfe.html());
		}
		i++;
	}
  
	
    //----------------------------------------------------GEEKSFORGEEKS-----------------------------------------------------
       
    
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
	j=0;
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
		if(j++==0) {
			String str = String.valueOf(gfge.html());
			gfgms = Integer.valueOf(str);
			System.out.println("Montly Streak: "+gfgms);
		}
	}
	
	
	//----------------------------------------------------INTERVIEWBIT---------------------------------------------------------
	
	
    
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
	i=0;
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
  	
	
	//-------------------------------------------------------CODESTATION-------------------------------------------------------------------
	
	
	String csid="",csint="";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT UID,INSTITUTE FROM USER WHERE UMAIL='"+umail+"' ");
		
		while(rs.next()){
			csid = rs.getString("UID");
			csint = rs.getString("INSTITUTE");
		}
	}catch(ClassNotFoundException cfe){
		cfe.printStackTrace();
	}catch(SQLException cfe) {
		cfe.printStackTrace();
	}
	int temp=cur_rat;
	int temp2=ccrating;
	if(ccrating<1300){
		temp2=1300;
	}
	if(cur_rat<1200){
		temp=1200;
	}
    int csps = ccfsp + sovprob + gfgps + ibscore/300;
    int ccscore=(ccfsp * 10) +( (temp2-1300)*(temp2-1300)/30  );
    int cfscore=(sovprob * 10) +( (temp-1200)*(temp-1200)/30);
    int interviewbitscore = ibscore/3;
    int gfgsc = gfgps *10;
    int csos = ((ccscore)+( cfscore  ) + interviewbitscore + (gfgsc) ) ;
    
    System.out.println(ccscore +" || "+cfscore + " || "+interviewbitscore+" || "+gfgsc);
    
    
    
  %>









<div class="w3-container">

  
  <div class="w3-panel w3-card">
  <div style="float:left;">
    <h2>CodeStation</h2><br>
    <h4>User Id : <%=csid %></h4>
    <h4>Institute Name : <%=csint %></h4>
  	<h4>Total Solved Problems : <%=csps %></h4>
  	<h4>OverAll Score : <%=csos %></h4>
  	<br>
  	<p>NOTE : OVERALL SCORE =  (CCPS*10 +(CCR-1300)^2/30) +(CFPS*10 + (CFR-1200)^2/30) + (IBS/3) +(GFG*10)</p>
  	<br>
  	</div>
  	
  	<div style="float:right;">
  	
	</div>
  	<br>
  </div><br>
 
  
  <div class="w3-panel w3-card" style="width:49%; float:left;">
    <img src="ccimg.png" style="width:40px;height: 35px;float:left;margin-top:12px;">
  	<h1 style="float:left;">CodeChef</h1><br><br><br><br>
  	<h4>User Id          : <%=ccid %> </h4>
  	<h4>Contest Rating   : <%=ccrating %> </h4>
  	<h4>Solved Problems  : <% out.println(ccfsp); %> </h4>
  	<h4>Partially Solved : <%=ccpsp %></h4>
  
  <br>
  </div>
  
  <div class="w3-panel w3-card" style="width:49%; float:right;">
  	<img src="cfimg.png" style="width:40px;height: 35px;float:left;margin-top:12px;">
  	<h1 style="float:left;"> CodeForces</h1><br><br><br><br>

  	<h4>User Id : <%=cfid %></h4>
  	<h4>Current Rating : <%=cur_rat %></h4>
  	<h4>Hightest Rating : <%=hig_rat %></h4>
  	<h4>Solved Problems : <%=sovprob %></h4>
  	
  <br>
  </div>
  
  
  <div class="w3-panel w3-card" style="width:49%; float:left;">
  <img src="ibimg.png" style="width:40px;height: 35px;float:left;margin-top:19px;">
  	<h1 style="float:left;">InterviewBit</h1><br><br><br><br>  	
  	<h4>User Name : <%=ibid %></h4>
  	<h4>Score : <%=ibscore %></h4>
  	<h4>Rank  : <%=ibrank %></h4>
  	<h4>Streak : <%=ibstreak %></h4>
  <br>
  </div>
  
  <div class="w3-panel w3-card" style="width:49%; float:right;">
  	<img src="gfgimg.png" style="width:40px;height: 35px;float:left;margin-top:19px;">
  	<h1 style="float:left;">GeeksforGeeks</h1><br><br><br><br>
 
  	<h4>User Name : <%=gfgid %></h4>
  	<h4>Solved Problems : <%=gfgps %></h4>
  	<h4>Coding Score : <%=gfgcs %></h4>
  	<h4>Monthly Streak : <%=gfgms %></h4>
  
  <br>
  </div>
  
  
</div>

<br>

<%
LocalDate today = LocalDate.now();
String dd = today.toString();
try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/codestation","root","meghana12");  
	Statement st = con.createStatement();
	
	//-----------------------------------------------CODECHEF UPDATION------------------------------------------------------------------
	
	/*if(dccrating!=ccrating || dccfsp!=ccfsp || dccpsp!=ccpsp || dccgr!=ccgr || dcccr!=cccr){
		int ccrs = st.executeUpdate("UPDATE CODECHEF SET RATING='"+ccrating+"', FULL_SOV='"+ccfsp+"', PAR_SOV='"+ccpsp+"', GLO_RANK='"+ccgr+"', COU_RANK='"+cccr+"' WHERE UMAIL='"+umail+"' ");	
		int ccd = st.executeUpdate("UPDATE ACTIVITY SET CC='"+dd+"'");	
		if(ccrs>0){
			System.out.println("Codechef details updated successfully");
		}
	}*/
	
	//----------------------------------------------GEEKSFORGEEKS UPDATION------------------------------------------------------------------
	
	/*int rsgfg = st.executeUpdate("UPDATE GFG SET SOLVED_PROB='"+gfgps+"', CODING_SCOR='"+gfgcs+"', MON_STREAK='"+gfgms+"' WHERE UMAIL='"+umail+"' ");
	if(rsgfg>0){
		System.out.println("GFG details updated successfully");
	}*/
	
	//-----------------------------------------------CODEFORCES UPDATION------------------------------------------------------------------
	
	
	/*if(dcur_rat!=cur_rat || dhig_rat!=hig_rat || dsovprob!=sovprob){
		int cfrs = st.executeUpdate("UPDATE CODEFORCES SET CUR_RATING='"+cur_rat+"', HIG_RATING='"+hig_rat+"', SOV_PROB='"+sovprob+"' WHERE UMAIL='"+umail+"' ");
		int cfd = st.executeUpdate("UPDATE ACTIVITY SET CF='"+dd+"'");	
		if(cfrs>0){
			System.out.println("Codeforces details updated successfully");
		}
	}*/
	
	//-----------------------------------------------INTERVIEWBIT UPDATION------------------------------------------------------------------
	
	/*int ibrs = st.executeUpdate("UPDATE INTERVIEWBIT SET STREAK='"+ibstreak+"', SCORE='"+ibscore+"', URANK='"+ibrank+"' WHERE UMAIL='"+umail+"' ");
	if(ibrs>0){
		System.out.println("INTEVIEWBIT details updated successfully");
	}*/
	
	//-----------------------------------------------CODESTATION UPDATION------------------------------------------------------------------
	
	int csrs = st.executeUpdate("UPDATE CODESTATION SET SOL_PROB='"+csps+"', OVERALL_SCORE='"+csos+"' WHERE UMAIL='"+umail+"' ");
	if(csrs>0){
		System.out.println("CODESTATION details updated successfully");
	}

}catch (ClassNotFoundException exp) {
	exp.printStackTrace();
}catch (SQLException exp) {
	exp.printStackTrace();
}
%>



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