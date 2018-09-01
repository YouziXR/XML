<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 

dim fs
Set fs=Server.CreateObject("Scripting.FileSystemObject") 
'fs.CreateTextFile("\test.txt",True)
if fs.FileExists(server.mappath("XMLDoc.xml")) then
'	response.write "find file<br />" 
fs.DeleteFile(server.mappath("XMLDoc.xml"))
'Else
    'response.Write "can not find file<br />"
end if

set fs=nothing

user = Session("user")
if user<>"" then
    if user<>"admin" then
        Response.End()
    end if
else 
Response.End()
end if

'response.write("in asp <br />") 
On Error Resume Next
set conn=server.createobject("adodb.connection")
conn.open "driver={microsoft access driver (*.mdb)};dbq=" & server.mappath("stu_info.mdb")
If Err Then
	Response.Write "access failed<br>"
	Response.End()
'Else
'Response.Write "access success<br />"
End If
Dim re
Set re = New RegExp
re.Pattern = "[0-9]{11}"
If re.Test(request.querystring("q")) Then

Else
Response.Write("输入不合法<br>请输入11位的学号")
response.End()
End If
set rs = nothing
'set querystring = request.querystring("q")
'Response.Write(querystring)
'sql = "select * from basic_info join mark on basic_info.学号=mark.学号 where mark.学号="
sql = "SELECT * FROM basic_info inner join mark on basic_info.学号=mark.学号 WHERE basic_info.学号="
sql = sql & "'" & request.querystring("q") & "'"
set rs = server.createobject("adodb.recordset")
rs.Open sql,conn
If rs.Eof Then 
    Response.Write "no such record" '如果没有记录 
Else 
	'Response.Write "find something<br />"
	Response.Write("<table>")
	response.Write("<tr><th>name</th><th>value</th></tr>")
	Dim objXMLDOM, objRootNode, objNode ,objPNode
    Set objXMLDOM = Server.CreateObject("MSXML2.DOMDocument") '创建XML文档对象 
    Set objRootNode = objXMLDOM.createElement("xml") 
    '创建根节点 
    objXMLDOM.documentElement = objRootNode 
    set objPNode = objXMLDOM.createElement("student") '创建父节点 
    do until rs.EOF     '循环出所有记录 
    for each x in rs.Fields
    	set objNode = objXMLDOM.createElement(x.name)
    	objNode.text = x.value
    	objPNode.appendChild(objNode)
    	If x.name <> "img" Then
    		Response.Write("<tr><td>" & x.name & "</td>")
    		Response.Write("<td>" & x.value & "</td></tr>")
    	End If
    next
    rs.MoveNext
loop
objRootNode.appendChild(objPNode)
objXMLDOM.Save(server.mappath("XMLDoc.xml"))
'	Response.Write "<script>alert('success');</script>" 
    Set objNode = Nothing      '销毁对象 
    Set objPNode = Nothing  '销毁对象 
    Set objRootNode = Nothing '销毁对象 
End If
Response.Write("</table>")
rs.close 
Set rs = Nothing 
Call CloseConn() '关闭数据库连接 
%>