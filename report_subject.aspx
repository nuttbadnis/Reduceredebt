<%@ Page Language="VB" AutoEventWireup="false" CodeFile="report_subject.aspx.vb" Inherits="report_subject" %>

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

	<script type="text/javascript" src="App_Inc/jquery-cookie/jquery.cookie.js"></script>

	<link rel="stylesheet" type="text/css" href="App_Inc/jquery-ui-1.11.4/jquery-ui.css"/>
	<script type="text/javascript" src="App_Inc/jquery-ui-1.11.4/jquery-ui.js"></script>

	<link rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap.css" />
	<script src="App_Inc/bootstrap/js/bootstrap.js"></script>

	<link rel="stylesheet" type="text/css" href="App_Inc/DataTables/datatables.css"/>
	<script type="text/javascript" src="App_Inc/DataTables/datatables.js"></script>
	<script type="text/javascript" src="App_Inc/DataTables/date-uk.js"></script>

	<link rel="stylesheet" type="text/css" href="App_Inc/DataTables/dataTables.fixedHeader.min.css"/>
	<script type="text/javascript" src="App_Inc/DataTables/dataTables.fixedHeader.min.js"></script>

	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/colreorder/1.3.2/css/colReorder.dataTables.min.css"/>
	<script type="text/javascript" src="https://cdn.datatables.net/colreorder/1.3.2/js/dataTables.colReorder.min.js"></script>

	<script src="App_Inc/bootstrap-multiselect/bootstrap-multiselect.js"></script>
	<link rel="stylesheet" type="text/css" href="App_Inc/bootstrap-multiselect/bootstrap-multiselect.css" />

	<script src="App_Inc/twbs-pagination/jquery.twbsPagination.js"></script>

	<script src="App_Inc/scrollbooster-1.0.4/dist/scrollbooster.min.js"></script>

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/pretty-checkbox.min.css">

	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/main.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/default.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/pagedata.css?v=38" />

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/gly-spin.css" />
	<link type="text/css" rel="stylesheet" href="App_Inc/icomoon/font-icon.css" />
	<link type="text/css" rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap-panels-nav-tabs.css" />

	<script type="text/javascript" src="App_Inc/_js/panu.js?v=38"></script>
	<script type="text/javascript" src="App_Inc/_js/load_modal.js?v=38"></script>

	<style type="text/css">
	.navbar-second {
		box-shadow: none;
		background-color: #e7e7e7;
		min-height: 40px;
	}
	.navbar-second .navbar-nav > li > a {
		padding-top: 10px;
		padding-bottom: 10px;
	}
	.navbar-second .navbar-nav > .active > a, .navbar-default .navbar-nav > .active > a:hover, .navbar-default .navbar-nav > .active > a:focus {
		border-radius: unset;
		margin: 0px;
		padding: 10px 15px 10px 15px;
		background-color: #ffffff;
		color: #555555;
	}

    a.a-gray {
    	color: #999;
    }
    a.a-gray:hover {
    	color: #666;
    }
	#btn_sorting_create_desc, #btn_sorting_create_asc, #btn_sorting_update_desc, #btn_sorting_update_asc {
		float: right;
	}
	span.multiselect-native-select .btn-group .btn {
		text-align: left;
	}
	.space-br {
		height: 5px;
	}
	hr.end-row {
		margin-top: 5px;
		margin-bottom: 10px;
	}
	.with-nav-tabs .nav-tabs{
		font-size: 20px;
		font-family: 'Kanit', sans-serif;
	}
	.with-nav-tabs.panel-default .nav-tabs > li > a, .with-nav-tabs.panel-default .nav-tabs > li > a:hover, .with-nav-tabs.panel-default .nav-tabs > li > a:focus {
		color: #0064e4;
	}
	.ui-datepicker .ui-datepicker-title select {
		height: 22px;
	}
	.pagination {
	    padding-top: 6px;
	}
    #display_table{
    	/*overflow: auto;*/
    	overflow-x: hidden;
    	cursor: move;
    	margin-top: 10px;
    	border-width: 0px 1px 0px 1px;
    	border-style: solid;
    	border-color: #d7ebfb;
    	border-radius: 4px;
    }
    table.dataTable {
    	margin-top: 0px !important;
    	margin-bottom: 0px !important;
    }
	.table-hover > tbody > tr:hover {
		background-color: #eaeaea;
	}
	</style>
</head>
<body>
	<form id="form1" runat="server">
		<input runat="server" id="hide_today" type="hidden">
		<input runat="server" id="hide_token" type="hidden">
		<input runat="server" id="hide_uemail" type="hidden">
		<input runat="server" id="hide_udepart" type="hidden">
		<input runat="server" id="hide_group_email" type="hidden">

		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="default.aspx">Follow Request</a>
				</div>

				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
					<li><a href="default.aspx">หน้าหลัก</a></li>
					<li class="active"><a href="report_subject.aspx">รายงาน/สถิติ</a></li>
					<li><a href="advance_search.aspx">Advance Search</a></li>
					</ul>

					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown use_loged">
							<a href="#" id="user_logon" runat="server" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"></a>
							<ul class="dropdown-menu">
								<!-- <li><a onclick="modalCustom()" style="cursor: pointer;"><span class="glyphicon glyphicon-cog"></span> ปรับแต่งตาราง</a></li> 
								<li role="separator" class="divider"></li> 
								<li><a href="mode_approve.aspx"><span class="glyphicon glyphicon-folder-close"></span> Mode Approve</a></li> 
								<li role="separator" class="divider"></li> 
								<li><a runat="server" id="webtest" href=""><span class="glyphicon glyphicon-question-sign"></span> WebTest v.170918</a></li> 
								 --><li><a href="xmanual_user.aspx" target="_blank"><span class="glyphicon glyphicon-question-sign"></span> Manual คู่มือการใช้งาน</a></li> 
								<li><a href="xpatch_update.aspx"><span class="glyphicon glyphicon-export"></span> Patch ข้อมูลอัพเดท</a></li> 
								<li><a href="logoutOauth.aspx"><span class='glyphicon glyphicon-off user_logon'></span> Logout</a></li> 
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>

	<nav class="navbar navbar-default navbar-second">
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a data-toggle="tab" href="#tab_default">รายงานสรุปเวลาดำเนินการ</a></li>
				<li><a data-toggle="tab" href="#tab_main2">สถิติ</a></li>
			</ul>
		</div>
	</nav>

	<!-- <div style="height: 20px"></div> -->

	<div class="container">
		<div class="panel panel-danger">
			<div class="panel-heading panel-fonting">Coming Soon.. ยังไม่พร้อมใช้งาน</div>
			<div class="panel-body" style="height: 100px">
			</div>
		</div>
	</div>

	 <div class="container">
		<div class="col-sm-8 col-sm-offset-2">
			
			<div class="panel panel-default">
				<div class="panel-heading txt-bold">ตัวเลือก</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-xs-6"> 
							<div class="form-group">
								<label class="txt-blue">หัวข้อ</label>
								<select id="sel_subject_fake" class="form-control">
									<option value="">กำลังโหลด..</option>
								</select>
								<select id="sel_subject_search" class="form-control multiselect" multiple="multiple" style="display:none;">
									<option value="" selected>ทุกหัวข้อ</option>
								</select>
							</div>
						</div>
						<div class="col-xs-6"> 
							<div class="form-group">
								<label class="txt-blue">เรื่อง</label>
								<div id="div_sel_title">
									<select id="sel_title_fake" class="form-control">
										<option value="">กำลังโหลด..</option>
									</select>
									<select id="sel_title_search" class="form-control multiselect" multiple="multiple" style="display:none;">
										<option value="" selected>ทุกเรื่อง</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="space-br"></div>
					<div class="row">
						<div class="col-xs-6"> 
							<div class="form-group">
								<label class="txt-blue">RO ที่ออกใบเสร็จ</label>
								<select id="sel_area_ro" class="form-control">
									<option value="">กำลังโหลด..</option>
								</select>
							</div>
						</div>
						<div class="col-xs-6"> 
							<div class="form-group">
								<label class="txt-blue">RO ผู้สร้างคำขอ</label>
								<select id="sel_create_ro" class="form-control">
									<option value="">กำลังโหลด..</option>
								</select>
							</div>
						</div>
					</div>
					<hr class="end-row">
					<div class="row">
						<div class="col-xs-6"> 
							<div class="form-inline" style="margin: 0px 0px 20px 5px;">
								<div class="pretty p-default p-round">
									<input type="radio" name="rad_date" id="create_date" value="วันที่สร้างคำขอ" checked>
									<div class="state p-success">
										<label class="txt-blue" style="font-weight: bold;">วันที่สร้างคำขอ</label>
									</div>
								</div>
								<div class="pretty p-default p-round">
									<input type="radio" name="rad_date" id="last_update" value="วันที่ปิดคำขอ">
									<div class="state p-success">
										<label class="txt-blue" style="font-weight: bold;">วันที่ปิดคำขอ</label>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xs-6"> 
							<div class="form-inline" style="margin: 0px 0px 20px 5px;">
								<div class="pretty p-svg p-curve">
									<input type="checkbox" id="chk_reply">
									<div class="state p-warning">
										<svg class="svg svg-icon" viewBox="0 0 20 20">
											<path d="M7.629,14.566c0.125,0.125,0.291,0.188,0.456,0.188c0.164,0,0.329-0.062,0.456-0.188l8.219-8.221c0.252-0.252,0.252-0.659,0-0.911c-0.252-0.252-0.659-0.252-0.911,0l-7.764,7.763L4.152,9.267c-0.252-0.251-0.66-0.251-0.911,0c-0.252,0.252-0.252,0.66,0,0.911L7.629,14.566z" style="stroke: white;fill:white;"></path>
										</svg>
										<label class="txt-blue" style="font-weight: bold;">เฉพาะคำขอที่มีขอข้อมูลเพิ่ม</label>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-6"> 
							<div class="form-group">
								<label class="txt-blue">ช่วงวันที่ (<span class="span-date">วันที่สร้างคำขอ</span>)</label>
								<input type="text" id="txt_start_date" class="form-control datepicker" maxlength="10" placeholder="30/12/2016">
							</div>
						</div>
						<div class="col-xs-6"> 
							<div class="form-group">
								<label class="txt-blue">ถึงวันที่ (<span class="span-date">วันที่สร้างคำขอ</span>)</label>
								<input type="text" id="txt_end_date" class="form-control datepicker" maxlength="10" placeholder="30/12/2016">
							</div>
						</div>
					</div>
					<div class="space-br"></div>
					<div class="row">
						<div class="col-xs-12" style="text-align: right;"> 
							<button id="btn_search2" class="btn btn-danger" type="button" disabled><span class="glyphicon glyphicon-search"></span> Search</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div id="btn_xport_excel"></div>

		<div id="display_table"></div>

		<div class="dataTables_wrapper form-inline dt-bootstrap">
			<div class="row">
				<div class="col-sm-5"> 
					<div class="dataTables_info" role="status" aria-live="polite">
						<span id="count_data"></span>
					</div>
				</div>
				<div class="col-sm-7"> 
					<div class="dataTables_paginate paging_simple_numbers">
						<ul id="twbs_pagination" class="pagination-sm"></ul>
					</div>
				</div>
			</div>
		</div>
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

	$('#page_loading').fadeOut();
});
</script>

<script type="text/javascript">
	var all_subject = "0";
	var temp_url = "";
	var page_size = 10;

	var ck_uemail = $('#hide_uemail').val();
	var ck_ordercolumn;
	var ck_nonedis;

	$(document).ready(function() {
		setDatePicker();
		loadSubject(1);

		$('#page_loading').fadeOut();

		$('#txt_start_date').val($('#hide_today').val());
		$('#txt_end_date').val($('#hide_today').val());
	});

	$('#txt_start_date').datepicker({
		dateFormat: 'dd/mm/yy'
		,minDate: new Date(2016, 3 - 1, 1)
		,maxDate: '0'
		,dayNamesMin: ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส']
		,monthNamesShort: ['มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม','มิถุนายน','กรกฎาคม','สิงหาคม','กันยายน','ตุลาคม','พฤศจิกายน','ธันวาคม']
		,changeMonth: true
		,changeYear: true
		,onSelect: function(dateText, inst){
			checkCompareDate($('#txt_start_date').val(), $('#txt_end_date').val());
		}
		,onClose: function(selectedDate, inst) {
			$("#txt_end_date").datepicker( "option", "minDate", selectedDate);
		}
	});

	$('#txt_end_date').datepicker({
		dateFormat: 'dd/mm/yy'
		,minDate: '0'
		,maxDate: '0'
		,dayNamesMin: ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส']
		,monthNamesShort: ['มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม','มิถุนายน','กรกฎาคม','สิงหาคม','กันยายน','ตุลาคม','พฤศจิกายน','ธันวาคม']
		,changeMonth: true
		,changeYear: true
		,onSelect: function(dateText, inst){
			checkCompareDate($('#txt_start_date').val(), $('#txt_end_date').val());
		}
		,onClose: function(selectedDate, inst) {       
			$("#txt_start_date").datepicker( "option", "maxDate", selectedDate);
		}
	});

	$('#btn_search2').click(function() {
		searchResult(2);
	});

	$('input[name=rad_date]').click(function() {
		$('.span-date').html($('input[name=rad_date]:checked').val());
	});

	function loadSubject(project_id) {
		var $el = $('#sel_subject_search');

		$.getJSON('json_default.aspx?qrs=loadSubject&project_id=' + project_id, function(data) {
			$el.empty();

			$.each(data,function( i,item ) {
				$el.append($("<option></option>")
					.attr('selected', true).attr("value", item.subject_id).text(item.subject_prefix + ". " + item.subject_name));

				all_subject += "," + item.subject_id;
			});

			$el.multiselect({
				nonSelectedText: 'เลือกหัวข้อ'
				, allSelectedText: 'ทุกหัวข้อ'
				, includeSelectAllOption: true
				, selectAllText: 'ทุกหัวข้อ'
				, buttonWidth: '100%'
				, onDropdownHide: function(event) {
					if($el.val() === null){
						modalAlert("กรุณาเลือกหัวข้อ");
						selTitleDisable();
					} 
					else if("0," + $el.val() == all_subject) {
						selTitleDisable();
					}
					else {
						loadTitle($el.val());
					}
				}
			});

			$('#sel_subject_fake').hide();
			$el.show();

			selTitleDisable();
			loadRO();
		});
	}

	function loadTitle(subject_id) {
		var div_sel_title = "<div id='div_sel_title'><select id='sel_title_fake' class='form-control'><option value=''>กำลังโหลด..</option></select><select id='sel_title_search' class='form-control multiselect' multiple='multiple' style='display:none;'></select></div>";
		$('#div_sel_title').replaceWith(div_sel_title);

		var url = 'json_default.aspx?qrs=loadTitle&subject_id=' + subject_id;
		console.log(url);

		$.getJSON(url, function(data) {
			$.each(data,function( i,item ) {
				$('#sel_title_search').append($("<option></option>")
					.attr('selected', true).attr("value", item.request_title_id).text("[" + item.subject_prefix + ".] " + item.disable + " " + item.request_title ));
			});

			$('#sel_title_search').multiselect({
				nonSelectedText: 'เลือกเรื่อง'
				, allSelectedText: 'ทุกเรื่อง'
				, includeSelectAllOption: true
				, selectAllText: 'ทุกเรื่อง'
				, buttonWidth: '100%'
				, onDropdownHide: function(event) {
					if($('#sel_title_search').val() === null){
						modalAlert("กรุณาเลือกเรื่อง");
					} 
				}
			});

			$('#sel_title_search').multiselect('enable');
			$('#sel_title_fake').hide();
			$('#sel_title_search').show();
		});
	}

	function selTitleDisable(){
		var div_sel_title = "<div id='div_sel_title'><select id='sel_title_search' class='form-control multiselect' multiple='multiple'></select></div>";
		$('#div_sel_title').replaceWith(div_sel_title);

		var $el = $('#sel_title_search');

		$el.multiselect({
			nonSelectedText: 'ทุกเรื่อง'
			, buttonWidth: '100%'
		});

		$el.multiselect('disable');
	}

	function loadRO() {
		var $el1 = $('#sel_area_ro');
		var $el2 = $('#sel_create_ro');

		$.getJSON('json_default.aspx?qrs=loadRO', function(data) {
			$el1.empty();
			$el2.empty();

			$el1.append($("<option></option>")
				.attr("value", "").text("ทุกเขตพื้นที่"));

			$el2.append($("<option></option>")
				.attr("value", "").text("ทุกเขตพื้นที่"));

			$.each(data,function( i,item ) {
				$el1.append($("<option></option>")
					.attr("value", item.ro_value).text(item.ro_title));

				$el2.append($("<option></option>")
					.attr("value", item.ro_value).text(item.ro_title));
			});

			$('#btn_search2').prop('disabled', false);

			// firstCookie();
			// ck_ordercolumn = $.parseJSON($.cookie('ck_adv_ordercolumn_180618' + ck_uemail)); // parse จาก json (ข้อความ) เป็น array
			// ck_nonedis = $.parseJSON($.cookie('ck_adv_nonedis_180618' + ck_uemail)); // parse จาก json (ข้อความ) เป็น array
			// loadCustomTable();
		});
	}

	function searchResult(tab){
		var main_url = "";

		if($('#sel_subject_search').val() == null){
			modalAlert("กรุณาเลือกหัวข้อ");
			$('#modal_alert').on('hidden.bs.modal', function (e) {
				$('#sel_subject_search').focus();
			})
			return;
		}

		if($('#sel_title_search').val() == null && "0," + $('#sel_subject_search').val() != all_subject){
			modalAlert("กรุณาเลือกเรื่อง");
			$('#modal_alert').on('hidden.bs.modal', function (e) {
				$('#sel_title_search').focus();
			})
			return;
		}

		if($('#sel_title_search').val() != null){
			main_url += "&request_title_id=" + $('#sel_title_search').val();
		} 

		main_url += "&subject_id=" + $('#sel_subject_search').val();
		main_url += "&area_ro=" + $('#sel_area_ro').val();
		main_url += "&create_ro=" + $('#sel_create_ro').val();
		main_url += "&start_date=" + $('#txt_start_date').val();
		main_url += "&end_date=" + $('#txt_end_date').val();
		//main_url += "&rad_date=" + $('input[name=rad_date]:checked').attr('id');

		searchAllReportCount(main_url);
	}

	function searchAllReportCount(main_url){
		var count_url = "json_default.aspx?qrs=searchAllRequestCount" + main_url;
		//var name_url = ;
		console.log(window.location.hostname +'/follow/'+count_url);

		$.ajax({
			url: count_url,
			cache: false,
			timeout: 120000,
			success: function( count_data ) { 
				temp_url = main_url;

				$('#count_data').html("จำนวนข้อมูล  " + numberWithCommas(count_data) + " ผลลัพธ์");
				$('#twbs_pagination').replaceWith("<ul id='twbs_pagination' class='pagination-sm'></ul>");

				if(count_data >= 0) {
					$('#twbs_pagination').twbsPagination({
						totalPages: ((count_data-1)/page_size) + 1,
						visiblePages: 5,
						onPageClick: function (event, page) {
							$('#page-content').text('Page ' + page);
							searchAllReport(temp_url, page);
						},
						first: 'หน้าแรก',
						last: 'สุดท้าย',
						prev: 'ก่อนหน้า',
						next: 'ถัดไป'
					});

					// var save_name = $('#hide_today').val().replace(/\//g, "");
					// $('#btn_xport_excel').replaceWith("<a id='btn_xport_excel' class='btn btn-primary' href='xportExcel_redebt.aspx?file_name=" + save_name + main_url + "&export=1' target='_blank'><span class='glyphicon icon-file-text2'></span> Export Excel</a>");
				}
				else {
					$('#btn_xport_excel').replaceWith("<div id='btn_xport_excel'></div>");
				}

				searchAllReport(main_url, 1);

			},
			error: function(x, t, m) {
				console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);

				modalAlert("ไม่สำเร็จ กรุณาลองอีกครั้ง หรือติดต่อ support_pos@jasmine.com");
				<%-- $('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				}) --%>
			}
		});
	}

	function searchAllReport(main_url, page_num){
		var page_data = "";
		page_data += "&page_size=" + page_size;
		page_data += "&page_num=" + page_num;

		var search_url = "json_default.aspx?qrs=searchAllRequest" + main_url;
		console.log(window.location.hostname +'/follow/'+search_url + page_data);

		var tmp_row_num = 0;

		$.ajax({
			url: search_url + page_data,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				var txt_html = "<div id='display_table'>" +
				"<table id='onthetable' class='table table-hover table-striped table-bordered dt-responsive nowrap' cellspacing='0' width='100%'>" +
				"<thead>" +
					"<tr class='txt-blue txt-bold'>" +
						"<th></th>" +
						"<th>เลขที่คำขอ</th>" +
						"<th>หัวข้อ</th>" +
						"<th>เรื่อง</th>" +
						"<th>RO ที่ออกใบเสร็จ</th>" +
						"<th>RO ผู้สร้างคำขอ</th>" +
						"<th>วันที่เริ่มเปิดคำขอ</th>" +
						"<th>วันที่ปิดคำขอ</th>" +
						"<th>Paid Date E-Pay</th>" +
						"<th>รวมเวลาสร้าง<br>ถึง ปิดคำขอ</th>" +
						"<th>รวมเวลาปิดคำขอ<br>ถึง Piad E-Pay</th>" +
						"<th>รวมเวลา<br>ทั้งหมด</th>" +
						"<th>Flow Step</th>" +
						"<th>ส่วนงาน</th>" +
						"<th>วันที่ดำเนินการ</th>" +
						"<th>ระยะเวลา<br>ดำเนินการ</th>" +
					"</tr>" +
				"</thead>" +
				"<tbody>";

				$.each(data,function( i,item ) {
					txt_html += "<tr>"

					if(tmp_row_num != item.row_no) {
						tmp_row_num = item.row_no;

						txt_html += "<td rowspan='" + item.row_count + "'><a class='short-menu' title='ดูข้อมูล' target='_blank' href='update_" + item.subject_url + ".aspx?request_id=" + item.request_id + "'><span class='glyphicon glyphicon-new-window'></span></a></td>"
						// txt_html += "<td rowspan='" + item.row_count + "'>" + item.row_no + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + item.request_id + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + limitStr(item.subject_prefix + "." + item.subject_name,30) + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + limitStr(item.request_title,30) + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + item.doc_ro + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + item.create_ro + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + itemNull(item.create_date) + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + itemNull(item.end_date) + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + itemNull(item.pay_date) + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + itemNull(item.follow_days) + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + itemNull(item.epay_days) + "</td>"
						txt_html += "<td rowspan='" + item.row_count + "'>" + itemNull(item.all_process_days) + "</td>"
					}
					else {
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
						txt_html += "<td style='display:none;'></td>"
					}

					txt_html += "<td>" + item.step + "</td>"
					txt_html += "<td>" + item.depart_name + "</td>"
					txt_html += "<td>" + item.step_date + "</td>"
					txt_html += "<td>" + item.step_days + "</td>"
					txt_html += "</tr>";
				});
				txt_html += "</tbody>";

				if(data.length > 25) {
					txt_html += "<tfoot>" +
					"<tr class='txt-blue txt-bold'>" +
						"<th></th>" +
						"<th>เลขที่คำขอ</th>" +
						"<th>หัวข้อ</th>" +
						"<th>เรื่อง</th>" +
						"<th>RO ที่ออกใบเสร็จ</th>" +
						"<th>RO ผู้สร้างคำขอ</th>" +
						"<th>วันที่เริ่มเปิดคำขอ</th>" +
						"<th>วันที่ปิดคำขอ</th>" +
						"<th>Paid Date E-Pay</th>" +
						"<th>รวมเวลาสร้าง<br>ถึง ปิดคำขอ</th>" +
						"<th>รวมเวลาปิดคำขอ<br>ถึง Piad E-Pay</th>" +
						"<th>รวมเวลา<br>ทั้งหมด</th>" +
						"<th>Flow Step</th>" +
						"<th>ส่วนงาน</th>" +
						"<th>วันที่ดำเนินการ</th>" +
						"<th>ระยะเวลา<br>ดำเนินการ</th>" +
					"</tr>" +
					"</tfoot>";
				}

				txt_html += "</table>" +
				"</div>";

				$('#display_table').replaceWith(txt_html);
				callDataTable();
			},
			error: function(x, t, m) {
				console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);

				modalAlert("ไม่สำเร็จ กรุณาลองอีกครั้ง หรือติดต่อ support_pos@jasmine.com");
				<%-- $('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				}) --%>
			}
		});
	}

	function setDatePicker() {
		$('.datepicker').datepicker({
			dateFormat: 'dd/mm/yy',  
			dayNamesMin: ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส'],   
			monthNames: ['มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม','มิถุนายน','กรกฎาคม','สิงหาคม','กันยายน','ตุลาคม','พฤศจิกายน','ธันวาคม'],
			beforeShow: function() {
				setTimeout(function(){
					$('.ui-datepicker').css('z-index', 999);
				}, 0);
			}
		});
	}

	function checkCompareDate(d1, d2){
		console.log('checkCompareDate');

		if( d1.length == 10 && d2.length == 10){
			if(compareDate(d1 ,d2) == false) {
				modalAlert("ตวรจสอบช่วงวันที่");
			}
		}

		function compareDate(d1, d2){
			var arr_d1 = d1.split("/");
			var pare_d1 = parseInt(yyyy(arr_d1[2]) + mm(arr_d1[1]) + dd(arr_d1[0]));

			var arr_d2 = d2.split("/");
			var pare_d2 = parseInt(yyyy(arr_d2[2]) + mm(arr_d2[1]) + dd(arr_d2[0]));

			return true;

			function dd(dd) {
				if(dd<10) {
					dd='0'+dd
				} 
				return dd;
			}
			function mm(mm) {
				if(mm<10) {
					mm='0'+mm
				} 
				return mm;
			}
			function yyyy(yyyy) {
				return yyyy;
			}
		}
	}

	function callDataTable() {
		var onthetable = $('#onthetable').DataTable({
			bFilter: false
			,paging: false
			,"aaSorting": []
			,"ordering": false
			,"iDisplayLength": -1
			,"bLengthChange": false
			,"responsive": false
			,"bInfo" : false
			// ,colReorder: {
			// 	order: ck_ordercolumn
			// }

		});

		// onthetable.columns( ck_nonedis ).visible( false, false );

    	let viewport = document.querySelector('#display_table')
    	let content = viewport.querySelector('#onthetable_wrapper')

    	let sb = new ScrollBooster({
    		viewport,
    		content,
    		mode: 'x',
    		textSelection: true,
    		onUpdate: (data)=> {
    			viewport.scrollLeft = data.position.x
    		}
    	})

		// $('html, body').animate({scrollTop:$('#top_scroll').position().top-50}, 'slow');
		$('html, body').animate({scrollTop:$('#btn_xport_excel').position().top-65}, 'slow');
	}
</script>
</body>
</html>
