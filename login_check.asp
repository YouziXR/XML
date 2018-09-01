<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
<%  
dim badword 
	badword="'|and|select|update|chr|delete|%20from|;|insert|mid|master.|set|chr(37)|=" 
if request.form<>"" then 
	chk=split(badword,"|") 
	for each query_name in request.form 
		for i=0 to ubound(chk) 
			if instr(lcase(request.form(query_name)),chk(i))<>0 then 
			response.write "<script language=javascript>alert('传参错误！参数 "&query_name&" 的值中包含非法字符串！\n\n');location='"&request.ServerVariables ("HTTP_REFERER")&"'</Script>" 
			response.end 
			end if 
		next 
	next 
end if 
%>
<%
Session.TimeOut=30
	user=trim(request.form("user"))
	pwd=trim(request.form("pwd"))
	set conn=server.createobject("adodb.connection")
	conn.open "driver={microsoft access driver (*.mdb)};dbq=" & server.mappath("user.mdb")
	if err then
		response.write "access failed<br>"
		response.end()
	'else
		'response.write "access success<br />"
	end if
	str = "ID or password wrong"
	sql = "select * from user where id='"& user & "'" & "and password='" & pwd & "'" 
	set rs = server.createobject("adodb.recordset") 
	rs.Open sql,conn
	if not rs.eof then 
		if user<>"admin" then
			Session("user") = user
			response.redirect("info.html")
		else
			Session("user") = user
			response.redirect("query.html")
		end if
	%>
	<%
	else
	%>
	<script type="text/javascript">
		alert("ID or password wrong");
		window.location.href = "login.asp";
	</script>
	<%
	end if
%> 
</body>
</html>