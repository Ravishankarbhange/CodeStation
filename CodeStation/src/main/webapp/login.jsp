<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>CodeStation Login</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">

.card {
	border-radius:12px;
	background-color:#33302d;
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.5);
    width: 22%;
}

.container {
  padding: 2px 16px;
}	

body{
	background-color: #909692;
}
.button {
  background: -webkit-linear-gradient(right, #a6f77b, #2dbd6e);
  border: none;
  border-radius: 18px;
  box-shadow: 0px 1px 8px #24c64f;
  cursor: pointer;
  color: white;
  font-family: "Raleway SemiBold", sans-serif;
  height: 42.3px;
  width: 150px;
}
#signup {
  color: #2dbd6e;
  font-family: "Raleway", sans-serif;
  font-size: 10pt;
  margin-top: 16px;
  text-align: center;
}
input{
	width:240px;
	height:20px;
}
label{font-weight: bold;}
</style>
</head>
<body>
<center><br>

<form method="post" action="<%= request.getContextPath() %>/UserLoginServlet">
	<h1 style="letter-spacing: 5px;font-size: 50px;color: black;font-family:Garamond, serif;padding-left: 17px;">CODESTATION <i class="fa fa-cubes"></i></h1><br>
	<div class="card">
	  <div class="container">
	  	<h1 >LOGIN</h1><br>
	  	<table style="padding-bottom: 5px;">
	  		<tr><td><label>Email </label></td></tr>
	  		<tr><td><input type="text" name="email"></td></tr>
	  	</table>
	  	<table>
	  		<tr><td><label>Password </label></td></tr>
	  		<tr><td><input type="text" name="pass"></td></tr>
	  	</table>
	  	<br><br>
	  	<input type="submit" class="button" name="login" value="LOGIN" style="margin-bottom: 10px;"><br>
	  	<a href="Register.jsp" id="signup">Don't have account yet?</a>
	  </div><br><br>
	</div>
</form>
</center>
</body>
</html>