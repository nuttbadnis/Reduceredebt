<%@ Page Language="VB" AutoEventWireup="false" CodeFile="xcc_search.aspx.vb" Inherits="xcc_search" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Follow Request ระบบติดตามคำขอ</title>

	<link rel="shortcut icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">
	<link rel="icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">

    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-147978262-1"></script>
    <script type="text/javascript" src="App_Inc/_js/gtag_frq.js?id=UA-147978262-1&vs=37"></script>

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/reset.css" />

	<script src="App_Inc/jquery-1.11.3.min.js"></script>

	<link rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap.css" />
	<script src="App_Inc/bootstrap/js/bootstrap.js"></script>

	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/main.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/default.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/pagedata.css?v=38" />

    <script type="text/javascript" src="App_Inc/_js/panu.js?v=38"></script>
	<style type="text/css">
		body .container {
			width: 98%;
		}
		#display_table{
			overflow: auto;
		}
		#onthetable th, #onthetable td {
			width: 1px;
			white-space: nowrap;
		}
		.table-hover > tbody > tr:hover {
			background-color: #eaeaea;
		}
	</style>
</head>
<body>
	<form id="form1" runat="server">
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand">Follow Request <span>ระบบติดตามคำขอ</span></a>
			</div>
		</nav>

		<!-- <ol class="breadcrumb">
			<li class="active">Easy View</li>
		</ol> -->

		<div style="height: 15px"></div>

		<div class="container">
			<button type="button" class="btn btn-sm btn-primary" onclick="modalPopLink()" style="float: right;">คำอธิบายวันที่ E-Payment</button>
		</div>
		<div class="container">
			<div id="display_table">
				<h4 style="text-align: center;">กำลังโหลด..</h4>
			</div>
		</div>
	</form>

	<script type="text/javascript">
	var all_subject = "0";

	$(document).ready(function() {
		loadSubject(1);
	});

	function loadSubject(project_id) {
		$.getJSON('json_default.aspx?qrs=loadSubject&project_id=' + project_id, function(data) {
			$.each(data,function( i,item ) {
				all_subject += "," + item.subject_id;
			});

			xccAllRequest(_GET('acc'));
		});
	}

	function xccAllRequest(acc){

		var search_url = "json_default.aspx?qrs=xccAllRequest&acc=" + acc + "&subject_id=" + all_subject;
		console.log(search_url);

		$.ajax({
			url: search_url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				var txt_html = "<div id='display_table'>" +
				"<table id='onthetable' class='table table-hover table-striped table-bordered dt-responsive nowrap' cellspacing='0' width='100%'>" +
				"<thead>" +
					"<tr class='txt-blue txt-bold'>" +
						"<th>เลขที่คำขอ</th>" +
						// "<th>หัวข้อ</th>" +
						"<th>เรื่อง</th>" +
						"<th>จำนวนเงิน</th>" +
						"<th>จังหวัดที่ออกใบเสร็จ</th>" +
						// "<th>RO ที่ออกใบเสร็จ</th>" +
						// "<th>RO ผู้สร้างคำขอ</th>" +
						"<th>ผู้สร้างคำขอ</th>" +
						// "<th>ผู้อนุมัติ</th>" +
						"<th>วันที่เริ่มเปิดคำขอ</th>" +
						"<th>วันที่อัพเดทล่าสุด</th>" +
						"<th>สถานะล่าสุด</th>" +
						// "<th>หน่วยงานที่รับผิดชอบ</th>" +
						// "<th>Account</th>" +
						// "<th>ชื่อลูกค้า</th>" +
						// "<th>เลขที่ใบเสร็จ BCS</th>" +
						// "<th>เลขที่ใบเสร็จ POS</th>" +
						// "<th>เลขที่ใบลดหนี้</th>" +
						"<th>เลขที่ E-Pay</th>" +
						"<th>วันที่สร้าง E-Pay</th>" +
						"<th>วันที่ทำรายการจ่ายเงิน</th>" +
						"<th>วันที่ลูกค้าได้รับเงิน</th>" +
						"<th>รูปแบบการคืนเงิน</th>" +
						"<th>ชื่อธนาคาร</th>" +
						"<th>เลขที่บัญชี</th>" +
						"<th>รายละเอียดการคืนเงิน</th>" +
					"</tr>" +
				"</thead>" +
				"<tbody>";

				$.each(data,function( i,item ) {
					txt_html += "<tr>"
					txt_html += "<td><a class='txt-bold' title='ดูข้อมูล' target='_blank' href='xcc_view.aspx?request_id=" + item.request_id + "'>" + item.request_id + "</a></td>"
					// txt_html += "<td>" + limitStr(item.subject_prefix + "." + item.subject_name,30) + "</td>"
					txt_html += "<td>" + limitStr(item.request_title,45) + "</td>"
					txt_html += "<td class='td-amount'>" + convertAmount(item.amount) + "</td>"
					txt_html += "<td>" + itemNull(item.shop_code) + "</td>"
					// txt_html += "<td>" + item.area_ro + "</td>"
					// txt_html += "<td>" + item.create_ro + "</td>"
					txt_html += "<td>" + item.create_by + "</td>"
					// txt_html += "<td>" + item.uemail_approve + "</td>"
					txt_html += "<td>" + itemNull(item.create_date) + "</td>"
					txt_html += "<td>" + itemNull(item.last_update) + "</td>"
					txt_html += "<td>" + item.status_name + "</td>"
					// txt_html += "<td>" + item.next_depart_name + "</td>"
					// txt_html += "<td>" + item.account_number + "</td>"
					// txt_html += "<td>" + item.account_name + "</td>"
					// txt_html += "<td>" + itemNull(item.bcs_number) + "</td>"
					// txt_html += "<td>" + itemNull(item.doc_number) + "</td>"
					// txt_html += "<td>" + itemNull(item.redebt_number) + "</td>"
					txt_html += "<td>" + itemNull(item.rp_no) + "</td>"
					txt_html += "<td>" + itemNull(item.rp_date) + "</td>"
					txt_html += "<td>" + itemNull(item.pay_date) + "</td>"
					txt_html += "<td>" + itemNull(item.due_date) + item.txt_due_date + "</td>"
					txt_html += "<td>" + itemNull(item.pick_refund_title) + "</td>"
					txt_html += "<td>" + itemNull(item.bank_title) + "</td>"
					txt_html += "<td>" + itemNull(item.fx02) + "</td>"
					txt_html += "<td>" + itemNull(item.tx01) + "</td>"
					txt_html += "</tr>";
				});

				if(data.length == 0) {
					txt_html += "<tr><td colspan='22' align='center' class='txt-bold txt-red'>ไม่พบข้อมูล [" + acc + "]</td></tr>";
				}

				txt_html += "</tbody>";

				if(data.length > 25) {
					txt_html += "<tfoot>" +
					"<tr class='txt-blue txt-bold'>" +
						"<th>เลขที่คำขอ</th>" +
						"<th>หัวข้อ</th>" +
						"<th>เรื่อง</th>" +
						"<th>จำนวนเงิน</th>" +
						"<th>จังหวัดที่ออกใบเสร็จ</th>" +
						"<th>RO ที่ออกใบเสร็จ</th>" +
						"<th>RO ผู้สร้างคำขอ</th>" +
						"<th>ผู้สร้างคำขอ</th>" +
						"<th>ผู้อนุมัติ</th>" +
						"<th>วันที่เริ่มเปิดคำขอ " + "</th>" +
						"<th>วันที่อัพเดทล่าสุด " + "</th>" +
						"<th>สถานะล่าสุด</th>" +
						"<th>หน่วยงานที่รับผิดชอบ</th>" +
						"<th>Account</th>" +
						"<th>ชื่อลูกค้า</th>" +
						"<th>เลขที่ใบเสร็จ BCS</th>" +
						"<th>เลขที่ใบเสร็จ POS</th>" +
						"<th>เลขที่ใบลดหนี้</th>" +
						"<th>เลขที่ E-Pay</th>" +
						"<th>วันที่สร้าง E-Pay</th>" +
						"<th>Paid Date E-Pay</th>" +
						"<th>Due Date E-Pay</th>" +
					"</tr>" +
					"</tfoot>";
				}

				txt_html += "</table>" +
				"</div>";

				$('#display_table').replaceWith(txt_html);
				doubleScroll(document.getElementById('display_table'));
			},
			error: function(x, t, m) {
				console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);
			}
		});
	}

	function doubleScroll(element) {
		var top_scroll = document.getElementById('top_scroll');
		if (top_scroll) top_scroll.parentNode.removeChild(top_scroll);

		var scrollbar= document.createElement('div');
		scrollbar.setAttribute("id", "top_scroll");
		scrollbar.appendChild(document.createElement('div'));
		scrollbar.style.overflow= 'auto';
		scrollbar.style.overflowY= 'hidden';
		scrollbar.firstChild.style.width= element.scrollWidth+'px';
		scrollbar.firstChild.style.paddingTop= '1px';
		scrollbar.firstChild.appendChild(document.createTextNode('\xA0'));
		scrollbar.onscroll= function() {
			element.scrollLeft= scrollbar.scrollLeft;
		};
		element.onscroll= function() {
			scrollbar.scrollLeft= element.scrollLeft;
		};
		element.parentNode.insertBefore(scrollbar, element);
	}
	
	function modalPopLink() {
		var w = 850;
		var h = 350;
		var top = 100;
		var left = (screen.width/2)-(w/2);
		window.open("info_epay.aspx", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, width=" + w + ", height=" + h + ", top=" + top + ", left=" + left );
	}
    </script>
</body>
</html>
