<%@ Page Language="VB" AutoEventWireup="false" CodeFile="xpatch_update.aspx.vb" Inherits="xpatch_update" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<!--[if IE ]> <body class="ie"> <![endif]-->
	<title>Follow Request ระบบติดตามคำขอ</title>

	<link rel="shortcut icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">
	<link rel="icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">

    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-147978262-1"></script>
    <script type="text/javascript" src="App_Inc/_js/gtag_frq.js?id=UA-147978262-1&vs=37"></script>

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/reset.css" />

	<script src="App_Inc/jquery-1.11.3.min.js"></script>

	<link type="text/css" rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap.css" />
	<script src="App_Inc/bootstrap/js/bootstrap.js"></script>

	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/main.css?v=38" />

    <link type="text/css" rel="stylesheet" href="App_Inc/_css/gly-spin.css" />
	<link type="text/css" rel="stylesheet" href="App_Inc/icomoon/font-icon.css" />

    <script type="text/javascript" src="App_Inc/_js/panu.js?v=38"></script>

	<style type="text/css">
	.panel-heading {
		font-size: 	20px;
	}

	blockquote {
		margin: 0 0 10px;
		font-size: 14px;
	}
	</style>
</head>
<body>
	<form id="form1" runat="server" enctype="multipart/form-data">
		<input runat="server" id="hide_uemail" type="hidden">

		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="default.aspx">Follow Request</a>
				</div>

				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li><a href="default.aspx">หน้าหลัก</a></li>
						<li><a href="intro.aspx">สร้างคำขอใหม่</a></li>
						<li><a href="verify_approval.aspx">รายชื่อผู้อนุมัติ</a></li>
						<li><a href="advance_search.aspx">Advance Search</a></li>
					</ul>

					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown use_loged">
							<a href="#" id="user_logon" runat="server" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"></a>
							<ul class="dropdown-menu">
								<li><a href="xmanual_user.aspx" target="_blank"><span class="glyphicon glyphicon-question-sign"></span> Manual คู่มือการใช้งาน</a></li> 
								<li><a href="xpatch_update.aspx"><span class="glyphicon glyphicon-export"></span> Patch ข้อมูลอัพเดท</a></li> 
								<li><a href="logoutOauth.aspx"><span class='glyphicon glyphicon-off user_logon'></span> Logout</a></li> 
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>

		<ol class="breadcrumb">
			<li class="active">Patch Update</li>
		</ol>

		<div class="container" style="max-width: 800px;">
			<div class="tab-content" id="div_content" runat="server"></div>
		</div>

		<footer class="footer">
			<div class="container">
				<div class="pull-left">
					<p>Copyright &copy; 2017 by <a href="mailto:support_pos@jasmine.com">support_pos@jasmine.com</a></p>
					<p>เพื่อการใช้งานเต็มประสิทธิภาพ กรุณาใช้บราวเซอร์ Google Chrome หรือ Firefox</p>
				</div>

				<div class="pull-right">
					<span id="top-link-block">
						<a class='btn btn-default' onclick="$('html,body').animate({scrollTop:0},'slow');return false;">
							<i class="glyphicon glyphicon-chevron-up"></i>
						</a>
					</span>
				</div>
			</div>
		</footer>

		<div id="page_loading" class="modal-backdrop">
			<div class="in-loading not-nm">
				<span class="glyphicon glyphicon-refresh gly-spin"></span><span id="txt_loading"> กรุณารอสักครู่...</span>
			</div>
			<div class="in-loading not-ie">
				<h3><strong>ระบบไม่รองรับการใช้งานด้วยโปรแกรม Internet Explorer กรุณาใช้ Chrome หรือ Firefox</strong></h3>
			</div>
		</div>
	</form>
	
	<script type="text/javascript">
	$(document).ready(function() { 
		var isIE11 = !!navigator.userAgent.match(/Trident.*rv\:11\./);

		if(navigator.userAgent.indexOf('MSIE')>0){  
			$('#page_loading').show();
			return;
		}
		else if(isIE11 == true || /Edge/.test(navigator.userAgent)) {
			var not_nm = document.getElementsByClassName("not-nm"); 
			for(var i = 0; i < not_nm.length; i++){ 
				not_nm[i].style.display = "none"; 
			}

			var not_ie = document.getElementsByClassName("not-ie"); 
			for(var i = 0; i < not_ie.length; i++){ 
				not_ie[i].style.display = "table"; 
			}

			forerror();
		}
	});
	</script>

	<link type="text/css" rel="stylesheet" href="App_Inc/lightbox2/css/lightbox-panu-custom.css" />
	<script src="App_Inc/lightbox2/js/lightbox-panu-custom.js"></script>

	<script type="text/javascript">
	$(document).ready(function() { 
		$('#page_loading').fadeOut();
	});

	lightbox.option({
		'positionFromTop' : 30,
		// 'albumLabel': "Patch Update",
		'fitImagesInViewport' : false,
		'alwaysShowNavOnTouchDevices' : false
	});
	</script>
</body>
</html>