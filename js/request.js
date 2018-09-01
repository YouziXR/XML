function check_input(s)
{
	var regu =/^[0-9]{11}$/;
	var re = new RegExp(regu);
	if (re.test(s)) 
	{
		return true;
	}
	else
	{
		return false;
	}
}
function show_img( ) 
{
	if ( window.XMLHttpRequest ) 
	{
		xmlhttp = new XMLHttpRequest( );
	} 
	else 
	{
		xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP" );
	}
	var main = document.getElementById("main");
	var img ;
	if ( img = document.getElementById("image")) 
	{
		main.removeChild(img);
	}
	var div = document.getElementById("tableList");
	xmlhttp.open( "GET", "/XML/XMLDoc.xml", false );
	xmlhttp.send( );
	xmlDoc = xmlhttp.responseXML;
	img = document.createElement("img");
	img.id = "image";
	img.src = xmlDoc.getElementsByTagName("img")[0].childNodes[0].nodeValue;
	main.insertBefore(img, div);
}

function create_xml( ) 
{
	// alert("in js") ;
	// str = "14030110034" ;
	var str1 = document.getElementById( "input" );
	var str = str1.value;
	// alert(str);
	var main = document.getElementById("main");
	var img ;
	if ( img = document.getElementById("image")) 
	{
		main.removeChild(img);
	}
	var bool_ = check_input(str);
	// alert(bool_);
	if ( !bool_) 
	{
		document.getElementById( "tableList" ).innerHTML = "输入不合法<br>请输入11位的学号";
		return;
	}
/*	if ( str == "" ) 
	{
		alert( "nothing" );
		document.getElementById( "tableList" ).innerHTML = "";
		return;
	}*/
	if ( window.XMLHttpRequest ) 
	{
		xmlhttp = new XMLHttpRequest( );
	} 
	else 
	{
		xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP" );
	}
	xmlhttp.onreadystatechange = function( ) 
	{
		if ( xmlhttp.readyState == 4 && xmlhttp.status == 200 ) 
		{
			document.getElementById( "tableList" ).innerHTML = xmlhttp.responseText;
			if (xmlhttp.responseText == "no such record") 
			{
				document.getElementById("tableList").innerHTML = "no such record";
				return ;
			}
			show_img();
		}
	}
	xmlhttp.open( "GET", "/XML/xml.asp?q=" + str, true );
	xmlhttp.send( );
}
