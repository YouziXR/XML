<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
	<% 
	session("user")="" 
	%> 
	<script language=javascript> 
		alert('退出登陆成功!');
		window.location.href = "login.asp";
	</script>
</body>
</html>