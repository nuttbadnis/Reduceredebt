<%@ Page Language="VB" AutoEventWireup="false" CodeFile="verify_approval.aspx.vb" Inherits="verify_approval" %>

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

	<link rel="stylesheet" type="text/css" href="App_Inc/jquery-ui-1.11.4/jquery-ui.css"/>
	<script type="text/javascript" src="App_Inc/jquery-ui-1.11.4/jquery-ui.js"></script>

	<link rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap.css" />
	<script src="App_Inc/bootstrap/js/bootstrap.js"></script>

    <link rel="stylesheet" type="text/css" href="App_Inc/DataTables/datatables.css"/>
    <script type="text/javascript" src="App_Inc/DataTables/datatables.js"></script>

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/gly-spin.css" />
	<link type="text/css" rel="stylesheet" href="App_Inc/_css/main.css?v=38" />
	<link type="text/css" rel="stylesheet" href="App_Inc/_css/pagedata.css?v=38" />
	<link type="text/css" rel="stylesheet" href="App_Inc/_css/pageintro.css?v=38" />

    <script type="text/javascript" src="App_Inc/_js/panu.js?v=38"></script>
    <script type="text/javascript" src="App_Inc/_js/load_modal.js?v=38"></script>

    <style type="text/css">
    .ui-autocomplete {
    	z-index: 99999; 
    }
    #modal_alert {
    	z-index: 99999; 
    }
    </style>
</head>
<body>
	<form id="form1" runat="server" enctype="multipart/form-data">
		<input runat="server" id="hide_uemail" type="hidden">
		<input runat="server" id="hide_permiss" type="hidden">
		<input runat="server" id="hide_token" type="hidden">

		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="default.aspx">Follow Request</a>
				</div>

				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
					<li><a href="default.aspx">หน้าหลัก</a></li>
					<li><a href="intro.aspx">สร้างคำขอใหม่</a></li>
					<li class="active"><a href="verify_approval.aspx">รายชื่อผู้อนุมัติ</a></li>
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
			<li class="active"><span class='glyphicon glyphicon-check'></span> รายชื่อผู้อนุมัติ</li>
			<span class="txt-red" style="font-size:12px; margin-left: 10px;">*แสดงรายชื่อผู้ตรวจสอบ1-2 และผู้อนุมัติ "ระบบลดหนี้" เท่านั้น</span>
		</ol>

		<div class="container">
			<ul class="nav nav-tabs" id="nav_tab_project" runat="server"></ul>
			<div class="tab-content" id="content_subject" runat="server"></div>


				<!-- <ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">RO01</a></li>
					<li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">RO02</a></li>
					<li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">RO03</a></li>
					<li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">RO04</a></li>
					<li role="presentation"><a href="#ro" aria-controls="ro" role="tab" data-toggle="tab">RO05</a></li>
					<li role="presentation"><a href="#ro" aria-controls="ro" role="tab" data-toggle="tab">RO06</a></li>
					<li role="presentation"><a href="#ro" aria-controls="ro" role="tab" data-toggle="tab">RO07</a></li>
					<li role="presentation"><a href="#ro" aria-controls="ro" role="tab" data-toggle="tab">RO08</a></li>
					<li role="presentation"><a href="#ro" aria-controls="ro" role="tab" data-toggle="tab">RO09</a></li>
					<li role="presentation"><a href="#ro" aria-controls="ro" role="tab" data-toggle="tab">RO010</a></li>
				</ul> -->

				<!-- <div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="home">
						<br>
						<table class="table table-striped table-condensed"> 
							<thead> 
								<tr> 
									<th><b>ผู้ตรวจสอบ 1</b></th> 
								</tr> 
							</thead> 
							<tbody> 
								<tr> 
									<td>prasert.k@jasmine.com / นพพล แซ่ลิ้ม / รักษาการผู้จัดการจังหวัด / ภาคกลาง (RO9)</td> 
								</tr> 
								<tr> 
									<td>prasert.k@jasmine.com / นพพล แซ่ลิ้ม / รักษาการผู้จัดการจังหวัด / ภาคกลาง (RO9)</td> 
								</tr> 
								<tr> 
									<td>prasert.k@jasmine.com / นพพล แซ่ลิ้ม / รักษาการผู้จัดการจังหวัด / ภาคกลาง (RO9)</td> 
								</tr> 
								<tr> 
									<td>prasert.k@jasmine.com / นพพล แซ่ลิ้ม / รักษาการผู้จัดการจังหวัด / ภาคกลาง (RO9)</td> 
								</tr> 
								<tr> 
									<td>prasert.k@jasmine.com / นพพล แซ่ลิ้ม / รักษาการผู้จัดการจังหวัด / ภาคกลาง (RO9)</td> 
								</tr> 
							</tbody> 
						</table> 

						<table class="table table-striped table-condensed"> 
							<thead> 
								<tr> 
									<th><b>ผู้ตรวจสอบ 2</b></th> 
								</tr> 
							</thead> 
							<tbody> 
								<tr> 
									<td>prasert.k@jasmine.com / นพพล แซ่ลิ้ม / รักษาการผู้จัดการจังหวัด / ภาคกลาง (RO9)</td> 
								</tr> 
								<tr> 
									<td>prasert.k@jasmine.com / นพพล แซ่ลิ้ม / รักษาการผู้จัดการจังหวัด / ภาคกลาง (RO9)</td> 
								</tr> 
							</tbody> 
						</table> 

						<table class="table table-striped table-condensed"> 
							<thead> 
								<tr> 
									<th><b>ผู้อนุมัติ</b></th> 
								</tr> 
							</thead> 
							<tbody> 
								<tr> 
									<td>prasert.k@jasmine.com / นพพล แซ่ลิ้ม / รักษาการผู้จัดการจังหวัด / ภาคกลาง (RO9)</td> 
								</tr> 
							</tbody> 
						</table> 

					</div>
					<div role="tabpanel" class="tab-pane" id="profile">...</div>
					<div role="tabpanel" class="tab-pane" id="messages">...</div>
					<div role="tabpanel" class="tab-pane" id="settings">...</div>
				</div> -->
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

	<div id="modal_edit" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-nm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="modal_title">แก้ไขข้อมูล User</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-xs-12">
							<div class="input-group">
								<span class="input-group-addon txt-bold ">UEMAIL</span>
								<input id="auto_uemail" type="text" class="form-control" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
								<input id="hide_new_uemail" type="hidden">
								<input id="hide_id" type="hidden">
								<input id="hide_new_id" type="hidden">
								<input id="hide_transfer_id" type="hidden">
							</div>
							<span class="txt-transfer txt-red" style="display:none;">*ระบุ User ใหม่</span>
						</div>
					</div>
					<hr class="end-row">
					<div class="row">
						<div class="col-xs-12">
							<div class="input-group">
								<span class="input-group-addon txt-bold ">RO</span>
								<select id="sel_ro" class="form-control">
									<option value="ALL">ALL</option>
								</select>
							</div>
						</div>
					</div>
					<hr class="end-row">
					<div class="row">
						<div class="col-xs-12">
							<div class="input-group">
								<span class="input-group-addon txt-bold ">CLUSTER</span>
								<select id="sel_cluster" class="form-control" disabled>
									<option value="ALL">ALL</option>
								</select>
							</div>
						</div>
					</div>
					<hr class="end-row">
					<div class="row">
						<div class="col-xs-12">
							<div class="input-group">
								<span class="input-group-addon txt-bold ">PROVINCE</span>
								<select id="sel_province" class="form-control" disabled>
									<option value="ALL">ALL</option>
								</select>
							</div>
						</div>
					</div>
					<hr class="end-row">
					<div class="row">
						<div class="col-xs-12">
							<div class="input-group">
								<span class="input-group-addon txt-bold ">DEPARTMENT</span>
								<select id="sel_department" class="form-control">
									<option value="">เลือก</option>
									<option value="1002">ผู้ตรวจสอบ 1</option>
									<option value="1003">ผู้ตรวจสอบ 2</option>
									<option value="1001">ผู้อนุมัติ</option>
									<option value="1008">ผู้ลดหนี้ตามเขตพื้นที่</option>
								</select>
							</div>
						</div>
					</div>
					<hr class="end-row">
					<div class="row">
						<div class="col-xs-12">
							<div class="input-group">
								<span class="input-group-addon txt-bold ">TEXT</span>
								<input id="txt_user_desc" type="text" class="form-control" placeholder="ตัวอย่าง: ลำปาง, C-HYI กรณีชำระผิดต้องการโยกยอด, วงเงินไม่เกิน 20,000">
							</div>
						</div>
					</div>
					<hr class="end-row">
					<div class="row">
						<div class="col-xs-6">
							<div class="input-group">
								<span class="input-group-addon txt-bold ">START</span>
								<input id="txt_start_date" type="text" class="form-control datepicker" placeholder="31/12/2019" readonly>
							</div>
							<span class="txt-transfer txt-red" style="display:none;">*วันที่ START ของ User ใหม่ <br>**และจะเป็น EXPIRE ของ User เก่า</span>
						</div>
						<div class="col-xs-6">
							<div class="input-group">
								<span class="input-group-addon txt-bold ">EXPIRE</span>
								<input id="txt_expired_date" type="text" class="form-control datepicker" placeholder="31/12/2019" readonly>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button id="btn_save_load" type="button" class="btn btn-default" style="display:none;" disabled>
						<span class="glyphicon glyphicon-refresh gly-spin"></span> กรุณารอสักครู่...
					</button>
					<button id="btn_save_transfer" type="button" class="btn btn-success" onclick="saveTransferDuid()" style="display:none;">
						<span class="glyphicon glyphicon-floppy-save" aria-hidden="true"></span> แทนที่สิทธิ์ด้วย User ใหม่
					</button>
					<button id="btn_save_edit" type="button" class="btn btn-success" onclick="saveEditDuid()" style="display:none;">
						<span class="glyphicon glyphicon-floppy-save" aria-hidden="true"></span> บันทึกการแก้ไข
					</button>
					<button id="btn_save_new" type="button" class="btn btn-success" onclick="saveNewDuid()" style="display:none;">
						<span class="glyphicon glyphicon-floppy-save" aria-hidden="true"></span> บันทึก
					</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">ปิด</button>
				</div>
			</div>
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

<script src="App_Inc/_js/verify_approval.js?v=38"></script>
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

	setDatePicker();
	useNclean();

	$('.panel-collapse').collapse({
		toggle: false
	})

    $('#nav_tab_project li').click(function() {
		$('.panel-collapse').collapse('hide');
	})

	$('#page_loading').fadeOut();

	var tabappend = "<li class='js-r'><a href='#' onclick='modalSearch()'><span class='glyphicon glyphicon-search'></span> ค้นหา</a></li>";
	
	if($('#hide_permiss').val() == 999) {
		tabappend += "<li class='js-r'><a href='#' onclick='newUser()'><span class='glyphicon glyphicon-plus'></span> เพิ่มสิทธิ์</a></li>";
		loadRO('#sel_ro');
	}

	$('#nav_tab_project').append(tabappend)
});

function modalSearch() {
	modalAlert('Coming Soon..')
}

function useNclean() {
	if(checkIsEmpty(_GET('ro')) == false){
		$('#nav_tab_project li#li_' + _GET('ro')).addClass("active");
		$('#content_subject div#tab_' + _GET('ro')).addClass("active");
	}
	else {
		$('#nav_tab_project li:first').addClass("active");
		$('#content_subject div:first').addClass("active");
	}

	if(checkIsEmpty(_GET('duid')) == false){
		$('#duid_' + _GET('duid')).addClass("tr-focus");
		setTimeout(function(){
			$('html, body').animate({scrollTop:  $('#duid_' + _GET('duid')).offset().top -290 }, 500);

			var clean_uri = location.protocol + "//" + location.host + location.pathname;
			window.history.replaceState({}, document.title, clean_uri);
		}, 500);
	}
}

function setDatePicker() {
	$('.datepicker').datepicker({
		dateFormat: 'dd/mm/yy' 
		,minDate: '0'
		,dayNamesMin: ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส']
		,monthNames: ['มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม','มิถุนายน','กรกฎาคม','สิงหาคม','กันยายน','ตุลาคม','พฤศจิกายน','ธันวาคม']
		,beforeShow: function() {
			setTimeout(function(){
				$('.ui-datepicker').css('z-index', 9999);
			}, 0);
		}
	});
}

// $('#txt_start_date').datepicker({
// 	dateFormat: 'dd/mm/yy'
// 	,minDate: '0'
// 	,dayNamesMin: ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส']
// 	,monthNames: ['มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม','มิถุนายน','กรกฎาคม','สิงหาคม','กันยายน','ตุลาคม','พฤศจิกายน','ธันวาคม']
// 	,changeMonth: true
// 	,changeYear: true
// 	,beforeShow: function() {
// 		setTimeout(function(){
// 			$('.ui-datepicker').css('z-index', 9999);
// 		}, 0);
// 	}
// 	,onClose: function(selectedDate, inst) {
// 		$("#txt_expired_date").datepicker( "option", "minDate", selectedDate);
// 	}
// });

// $('#txt_expired_date').datepicker({
// 	dateFormat: 'dd/mm/yy'
// 	,minDate: '0'
// 	,dayNamesMin: ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส']
// 	,monthNames: ['มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม','มิถุนายน','กรกฎาคม','สิงหาคม','กันยายน','ตุลาคม','พฤศจิกายน','ธันวาคม']
// 	,changeMonth: true
// 	,changeYear: true
// 	,beforeShow: function() {
// 		setTimeout(function(){
// 			$('.ui-datepicker').css('z-index', 9999);
// 		}, 0);
// 	}
// 	,onClose: function(selectedDate, inst) {
// 		$("#txt_start_date").datepicker( "option", "maxDate", selectedDate);
// 	}
// });
</script>