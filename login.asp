<html>
<head>
	<meta http-equiv="Content-Type" content="text/html" charset="utf-8"> 
	<title>login</title>
	<link rel="stylesheet" type="text/css" href="style/green.css">
	<!-- <script type="text/javascript" src="login.js"></script> -->
	<style type="text/css">
		span 
		{
			font-size: 16px;
		}
	</style>
</head>
<body>
	<div class="smart-green">
		<h1>登录</h1>
		<%
			if Session("user")="" then
		%> 
			<form action="login_check.asp" method="post" >
				<span>ID:</span><br>
				<input type="text" name="user" id="user" placeholder="ID" required="required"><br>
				<span>Password:</span><br>
				<input type="password" name="pwd" id="pwd" placeholder="Password" required="required"><br>
				<input type="submit" value="Log in" class="submit">
			</form>
		<% 
			else  
		%> 
			<p>
			<% =Session("user") %>您已登录。
			</p>
			<a href="logout.asp">注销登陆</a> 
			<!-- <input type="text" id="clock" value="5" /> -->
			<p id="clock">5</p>
			<script type="text/javascript">
			var second = 5;
			var int = self.setInterval("clock()",1000);
			function clock()
			{
				if (second == 0) 
				{
					int = self.clearInterval(int);
					<%
					if Session("user")="admin" then
					%>
						window.location.href = "query.html";
					<%
					else
					%>
						window.location.href = "info.html"
					<%
					end if
					%>
				}
				document.getElementById("clock").innerHTML = second;
				second--;
			}
			</script>
		<%
			end if
		%>
	</div>
</body>
</html>