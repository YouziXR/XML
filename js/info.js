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
			show_img();
		}
	}
	xmlhttp.open( "GET", "/XML/info.asp", true );
	xmlhttp.send( );
}
