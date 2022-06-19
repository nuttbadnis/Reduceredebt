<%@ Page Language="VB" AutoEventWireup="false" CodeFile="openfile_testget.aspx.vb" Inherits="openfile_testget" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Open file</title>

	<link rel="shortcut icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">
	<link rel="icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">

    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-147978262-1"></script>
    <script type="text/javascript" src="App_Inc/_js/gtag_frq.js?id=UA-147978262-1&vs=37"></script>
    
	<style type="text/css">
	body, html{
		margin: 0; padding: 0; height: 100%; overflow: hidden;
	}

	#content{
		position:absolute; left: 0; right: 0; bottom: 0; top: 0px; 
	}
	</style>
</head>
<body style="background-color: #ccc;">
	<form id="form1" runat="server">
        <div id="content">
            <iframe width="100%" height="100%" frameborder="0" runat="server" id="iframe_file"/>
        </div>
	</form>
</body>
</html>