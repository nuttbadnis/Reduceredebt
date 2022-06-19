<%@ Page Language="VB" AutoEventWireup="false" CodeFile="testupload.aspx.vb" Inherits="testupload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>testupload</title>

</head>
<body>
	<form id="form1" runat="server" enctype="multipart/form-data">
		<br>
		<br>
		<input name="upload_file" id="upload_file" type="file">
		<input runat="server" id="btn_submit_hidden" xd="btn_submit_hidden" OnServerClick="Submit_ShopStock" type="submit">
		<br>
		<br>
		<span runat="server" id="inn_redebt_url"></span>
		<a href="file://10.11.153.105/pos%20system/posweb/LoadCredit/2016/06/CBI5118062016-454626XXXXXX4111_01.pdf" target="_blank">test</a>
	</form>
</body>
</html>
