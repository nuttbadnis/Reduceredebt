<%@ Page Language="VB" AutoEventWireup="false" CodeFile="link_bcs2.aspx.vb" Inherits="link_bcs2" %>

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

	<link rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap.css" />

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/main.css" />

	<style type="text/css">
	.container {
    	font-family: 'Kanit', sans-serif;
	}

	#span1 {
		color: #245a79;
		font-weight: bold;
	}

	.panel-heading {
		font-size: 	20px;
		position: relative;
	}

	.btn-link {    
		position: absolute;
		right: 0px;
		top: 7px;
	}

	.btn-link:hover {
		text-decoration: none;
	}
	</style>
</head>
<body>
	<form id="form1" runat="server" enctype="multipart/form-data"></form>

	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">
				ดำเนินการบันทึกคำขอ <b>ลดหนี้ค่าประกันอุปกรณ์ ADSL เนื่องจากลูกค้าไม่มีอุปกรณ์มาคืน</b> ตามขั้นตอนดังนี้
				<a href="link_bcs.aspx" class="btn btn-link">
					< ย้อนกลับ
				</a>
			</div>
			<div class="panel-body">
				<blockquote>
					<div class="form-inline">
						<span>1. กดปุ่ม <button class="btn btn-primary btn-lg" onclick="copyToClipboard('span1')">copy link</button> เพื่อ copy link:</span> 
						<span id="span1">https://posbcs.triplet.co.th/FollowRequest/new_redebt228.aspx?subject_id=702001</span>
						<!-- <span id="span1">https://posbcs.triplet.co.th/FollowRequest/new_redebt26.aspx?subject_id=1002601</span> -->
					</div>
				</blockquote>
				<blockquote>
					<p>2. เปิดด้วยโปรแกรมเปิดเว็บ 
						<img height="32" width="32" src="App_Inc/_img/chrome.png"> Google Chrome 
						หรือ 
						<img height="32" width="32" src="App_Inc/_img/firefox.jpg"> Firefox เท่านั้น
					</p>
				</blockquote>
				<blockquote>
					<p>3. คลิกขวา paste link บน addressbar เพื่อเปิด</p>
					<img src="App_Inc/_img/linkbcs2.png">
				</blockquote>
			</div>
		</div>
	</div>

</body>
</html>

<script type="text/javascript">
function copyToClipboard(elementId) {
  var aux = document.createElement("input");
  aux.setAttribute("value", document.getElementById(elementId).innerHTML);
  document.body.appendChild(aux);
  aux.select();
  document.execCommand("copy");

  document.body.removeChild(aux);

  // document.getElementById(elementId).style.backgroundColor = "#ffc066";

  var ofs = 0;
  var el = document.getElementById(elementId);

  window.setInterval(function(){
  	el.style.background = 'rgba(255,173,77,'+Math.abs(Math.sin(ofs))+')';
  	ofs += 0.1;
  }, 10);

  alert("copy link แล้ว");
}
</script>