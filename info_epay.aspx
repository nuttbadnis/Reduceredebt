<%@ Page Language="VB" AutoEventWireup="false" CodeFile="info_epay.aspx.vb" Inherits="info_epay" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<!--[if IE ]> <body class="ie"> <![endif]-->
	<title>คำอธิบายวันที่ E-Payment</title>

	<link rel="shortcut icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">
	<link rel="icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">

    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-147978262-1"></script>
    <script type="text/javascript" src="App_Inc/_js/gtag_frq.js?id=UA-147978262-1&vs=37"></script>

	<!-- ***หน้านี้เป็น modal pop link ถ้าใส่ css style มันจะทับหน้าหลัก ที่เรียก pop link นี้****

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/reset.css" />

	<link rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap.css" />

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/main.css" /> -->

	<style type="text/css">
	@import url('https://fonts.googleapis.com/css?family=Kanit:400,600');
	
	.container-info {
    	font-family: 'Kanit', sans-serif;
	}

	.container-info .txt-blue-light {
		color: #0088f5;
	}
	.container-info .txt-red {
		color: #BD0000;
	}

	.container-info .panel-heading {
		font-size: 	20px;
	}

	@media (min-width: 768px) {
		.container-info {
			width: auto;
		}
	}
	</style>
</head>
<body>
	<form id="form1" runat="server" enctype="multipart/form-data"></form>

	<div class="container container-info">
		<!-- <div class="panel panel-default"> -->
			<!-- <div class="panel-heading panel-fonting"><span class="glyphicon glyphicon-info-sign"></span> ความหมายวันที่ E-Payment</div> -->
			<!-- <div class="panel-body" style="font-size: 16px;"> -->
				<div class="form-horizontal" style="font-size: 16px;">
					<p class="txt-blue-light" style="padding-bottom: 10px;"><b>Paid Date E-Pay</b> หมายถึง วันที่ทำรายการจ่ายเงิน</p>
					<p class="txt-red"><b>Due Date E-Pay</b> หมายถึง วันที่ลูกค้าได้รับเงิน (วันที่กำหนดจ่ายเงิน) โดยแบ่งพิจารณาเป็น</p>
					<p style="padding-left: 15px;">• <u>กรณีจ่ายเป็นเช็ค</u></p>
					<p style="padding-left: 45px;">> เงินจะถึงมือลูกค้า ขึ้นอยู่กับ Admin ไปนำส่งให้ลูกค้า หรือ Payin ให้ลูกค้า <b class="txt-red">[Due Date = วันที่บนเช็ค]</b></p>
					<p style="padding-left: 15px;">• <u>กรณีโอนเงิน แบ่งเป็น</u></p>
					<p style="padding-left: 45px;">> Direct โอนเข้าบัญชีธนาคารลูกค้า BBL <b class="txt-red">[เงินจะโอนเข้าวันเดียวกับ Due Date]</b></p>
					<p style="padding-left: 45px;">> Smart โอนเข้าบัญชีธนาคารลูกค้า ธนาคารอื่นที่ไม่ใช่ BBL <b class="txt-red">[เงินจะเข้าหลังจาก Due Date 2 วันทำการ]</b></p>
				</div>
			<!-- </div> -->
		<!-- </div> -->
	</div>

</body>
</html>