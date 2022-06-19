<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<!--[if IE ]> <body class="ie"> <![endif]-->
	<title>Follow Request ระบบติดตามคำขอ</title>

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/reset.css" />

	<script src="App_Inc/jquery-1.11.3.min.js"></script>

	<link rel="stylesheet" type="text/css" href="App_Inc/jquery-ui-1.11.4/jquery-ui.css"/>
	<script type="text/javascript" src="App_Inc/jquery-ui-1.11.4/jquery-ui.js"></script>

	<link rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap.css" />
	<script src="App_Inc/bootstrap/js/bootstrap.js"></script>

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/gly-spin.css" />
	<link type="text/css" rel="stylesheet" href="App_Inc/_css/main.css?v=14" />
	<link type="text/css" rel="stylesheet" href="App_Inc/_css/pagedata.css?v=14" />

    <script type="text/javascript" src="App_Inc/_js/panu.js?v=14"></script>
    <script type="text/javascript" src="App_Inc/_js/load_modal.js?v=14"></script>

    <style type="text/css">
    .nav > li > a {
    	font-weight: bold;
    	color: #555;
    }
    .nav-tabs > li.active > a, .nav-tabs > li.active > a:hover, .nav-tabs > li.active > a:focus {
    	/*color: #005080;*/
    	color: #FF9800;
    }
    .panel-title {
    	font-size: 14px;
    	/*color: #555;*/
    	color: #005080;
    }
    .panel-group {
    	font-size: 13px;
    }
    .panel-title .glyphicon {
    	font-size: 80%;
    }
    a:hover, a:focus {
    	text-decoration: none;
    }
    .panel-default > .panel-heading + .panel-collapse > .panel-body > p {
    	color: #ff4900;
    }
    .panel-body {
    	font-size: 14px;
    }

    li.li-title {
    	display: block;
    	color: #0064b5;
    	margin-left: 17px;
    }
    li.li-title:before {
    	/*Using a Bootstrap glyphicon as the bullet point*/
    	content: "\2212";
    	font-family: 'Glyphicons Halflings';
    	font-size: 9px;
    	float: left;
    	margin-top: 4px;
    	margin-left: -17px;
    }
    </style>
</head>
<body>
	<form id="form1" runat="server" enctype="multipart/form-data">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="text-center">Welcome</h1>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<input type="text" class="form-control input-lg" placeholder="Username"/>
					</div>

					<div class="form-group">
						<input type="password" class="form-control input-lg" placeholder="Password"/>
					</div>

					<div class="form-group">
						<input type="submit" class="btn btn-block btn-lg btn-primary" value="Login"/>
						<span class="pull-right"><a href="#">Register</a></span><span><a href="#">Forgot Password</a></span>
					</div>
				</div>
			</div>
		</div>
	</form>

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

	<div id="modal_alert" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">แจ้งเตือน</h4>
				</div>
				<div class="modal-body">
					<p id="txt_alert">ข้อความ</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">ปิด</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>

<script type="text/javascript">
$(document).ready(function() {
	$('#page_loading').fadeOut();
});
</script>