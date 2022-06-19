<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Login</title>

	<link rel="shortcut icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">
	<link rel="icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">

    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-147978262-1"></script>
    <script type="text/javascript" src="App_Inc/_js/gtag_frq.js?id=UA-147978262-1&vs=37"></script>

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/reset.css" />
	<script src="App_Inc/jquery-1.11.3.min.js"></script>

	<link rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap.css" />
	<script src="App_Inc/bootstrap/js/bootstrap.js"></script>
	
	<style type="text/css">
	@import url('https://fonts.googleapis.com/css?family=Kanit:400,600');

	html, 
	body {
		font-family: 'kanit', sans-serif;
	}

	.vertical-offset-100{
		padding-top:50px;
	}
	.login .user-row{
		text-align: center;
		font-size: 30px;
	}

	.login .img-responsive {
		display: block;
		max-width: 100%;
		height: auto;
		margin: auto;
	}

	.login.panel {
		margin-bottom: 20px;
		background-color: rgba(255, 255, 255, 0.55);
		border: 1px solid #ddd;
		border-radius: 4px;
		-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
		box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
	}
	.login label{
		display: block;
		width: 100%;
		color: #449d44;
		text-shadow:#4cae4c;
		text-align: center;
	}
	.login hr{
		margin: 5px;
	}
	.panel-body {
		padding: 30px;
	}

    img.center {
    	display: block;
    	margin: 0 auto;
    }
    .txt-center {
    	text-align: center;
    }

    #token_ex {
    	width: 1010px;
    	border: 2px solid #F44336;
    	border-radius: 3px;
    	margin-top: 15px;
    	padding: 10px;
    }
	</style>
</head>
<body>
	<form id="form1" runat="server" enctype="multipart/form-data">
		<div class="container" id="token_ex" runat="server">
			<h4 class="txt-center"><b style="color:red;">Token หมดอายุไม่สามารถใช้ WebTest ได้</b> กรุณากลับไปคลิกเมนู WebTest จากเว็บ <a href="https://posbcs.triplet.co.th/FollowRequest" style="color:blue;">Follow Request</a></h4>
			<h3 class="txt-center"><a href="https://posbcs.triplet.co.th/FollowRequest">https://posbcs.triplet.co.th/FollowRequest</a></h3>
			<img class="center" src="App_Inc/_img/gototest.png">
		</div>
	</form>

	<div class="container">
		<div class="row vertical-offset-100">
			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default login">
					<div class="panel-heading">   
						<h3 class="panel-title user-row" style="color: #555;">FR Test v.181009</h3> 
					</div>
					<div class="panel-body">
						<fieldset>
							<div class="form-group">
								<div class="input-group">
									<input type="text" id="txt_uemail" class="form-control input-sm input-addon-email">
									<div class="input-group-addon">@jasmine.com</div>
								</div>
							</div>
							<button class="btn btn-primary btn-block" id="btn_login">เข้าสู่ระบบ</button>
						</fieldset> 
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	$(document).ready(function() { 
		$('#txt_uemail').focus();
	});

	$('#btn_login').click(function() {
		var uemail = $('#txt_uemail').val().trim();

		if(uemail.length > 1){
			window.location = 'login.aspx?Uemail=' + uemail;
		}
		else {
			alert("กรุณากรอกอีเมล์");
			$('#txt_uemail').focus();
		}
	});
	</script>
</body>
</html>
