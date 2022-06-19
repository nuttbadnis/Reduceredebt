<%@ Page Language="VB" AutoEventWireup="false" CodeFile="admin_tool.aspx.vb" Inherits="admin_tool" %>

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

	<link rel="stylesheet" type="text/css" href="App_Inc/DataTables/dataTables.colReorder.min.css"/>
	<script type="text/javascript" src="App_Inc/DataTables/dataTables.colReorder.min.js"></script>

	<script src="App_Inc/bootstrap-multiselect/bootstrap-multiselect.js"></script>
	<link rel="stylesheet" type="text/css" href="App_Inc/bootstrap-multiselect/bootstrap-multiselect.css" />

	<script src="App_Inc/twbs-pagination/jquery.twbsPagination.js"></script>

	<script src="App_Inc/scrollbooster-1.0.4/dist/scrollbooster.min.js"></script>

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/pretty-checkbox.min.css">
	<link type="text/css" rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap-panels-nav-tabs.css" />

	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/main.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/default.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/pagedata.css?v=38" />

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/gly-spin.css" />
	<link type="text/css" rel="stylesheet" href="App_Inc/icomoon-2018/font-icon.css" />

	<script type="text/javascript" src="App_Inc/_js/panu.js?v=38"></script>
	<script type="text/javascript" src="App_Inc/_js/load_modal.js?v=38"></script>

	<style type="text/css">
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
		font-size: 18px;
		font-family: 'Kanit', sans-serif;
	}
	.with-nav-tabs.panel-default .nav-tabs > li.active > a,
	.with-nav-tabs.panel-default .nav-tabs > li.active > a:hover,
	.with-nav-tabs.panel-default .nav-tabs > li.active > a:focus {
		color: #0064e4;
	}
	.ui-datepicker .ui-datepicker-title select {
		height: 22px;
	}
	.pagination {
	    padding-top: 6px;
	}
    #display_table{
    	overflow: auto;
    	cursor: move;
    	cursor: ew-resize;
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

	#click_advance_filter label{
		cursor: pointer;
	}


	select.form-control {
		font-size: 13px;
		color: #333 !important;
	}
	span.multiselect-native-select .btn-group .btn {
		font-size: 13px;
	}
	.multiselect-container {
		font-size: 13px;
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
					<li><a href="intro.aspx">สร้างคำขอใหม่</a></li>
					<li><a href="verify_approval.aspx">รายชื่อผู้อนุมัติ</a></li>
					<li><a href="advance_search.aspx">Advance Search</a></li>
				</ul>

					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown use_loged">
							<a href="#" id="user_logon" runat="server" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"></a>
							<ul class="dropdown-menu">
								<li><a onclick="modalCustom()" style="cursor: pointer;"><span class="glyphicon glyphicon-cog"></span> ปรับแต่งตาราง</a></li> 
								<li role="separator" class="divider"></li> 
								<li><a runat="server" id="webtest" href=""><span class="glyphicon glyphicon-question-sign"></span> WebTest (FR Test)</a></li> 
								<li><a href="xmanual_user.aspx" target="_blank"><span class="glyphicon glyphicon-question-sign"></span> Manual คู่มือการใช้งาน</a></li> 
								<li><a href="xpatch_update.aspx"><span class="glyphicon glyphicon-export"></span> Patch ข้อมูลอัพเดท</a></li> 
								<li><a href="logoutOauth.aspx"><span class='glyphicon glyphicon-off user_logon'></span> Logout</a></li>
								<li><a href="admin_tool.aspx"><span class='glyphicon glyphicon-off user_logon'></span> Logout</a></li>    
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>

		<!-- <ol class="breadcrumb">
			<li class="active">Advance Search</li>
		</ol> -->

		<div style="height: 20px"></div>

		<div class="container">
			<div class="col-sm-8 col-sm-offset-2">
				<p class="txt-red" style="font-size:14px; float:right;">*Advance Search สำหรับ "ระบบลดหนี้" เท่านั้น</p>
			</div>
			
			<div class="col-sm-8 col-sm-offset-2">

				<div class="panel with-nav-tabs panel-default">
					<div class="panel-heading">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#tab1default" data-toggle="tab">Keyword Search</a></li>
							<li><a href="#tab2default" data-toggle="tab">Report Mode</a></li>
						</ul>
						<div style="position: absolute; right: 30px; top: 15px;">
							<button type="button" class="btn btn-sm btn-default" title="ปรับแต่งตาราง" onclick="modalCustom()"><span class="glyphicon glyphicon-cog"></span></button>
						</div>
					</div>
					<div class="panel-body">
						<div class="tab-content">
							<div class="tab-pane fade in active" id="tab1default">
								<div class="row">
									<div class="col-xs-12"> 
										<div class="form-group">
											<label class="txt-blue">คำค้น</label>
											<input type="text" id="txt_keyword"  class="form-control" placeholder="ค้นหาได้โดย Account, เลขที่คำขอ, เลขที่ใบเสร็จ, เลขที่ใบลดหนี้, เลขที่ E-Pay">
										</div>
									</div>
								</div>
								<div class="space-br"></div>
								<div class="row">
									<div class="col-xs-12" style="text-align: right;"> 
										<button id="btn_search1" class="btn btn-danger" type="button"><span class="glyphicon glyphicon-search"></span> Search</button>
									</div>
								</div>
							</div>

							<div class="tab-pane fade" id="tab2default">
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
											<label class="txt-blue">สถานะคำขอ</label>
											<select id="sel_status_fake" class="form-control">
												<option value="">กำลังโหลด..</option>
											</select>
											<select id="sel_status_search" class="form-control multiselect" multiple="multiple" style="display:none;">
												<option value="">กรุณาเลือกสถานะ</option>
											</select>
										</div>
									</div>
									<div class="col-xs-6"> 
										<div class="form-group">
											<label class="txt-blue">สถานะ E-Pay</label>
											<select id="sel_status_epay" class="form-control">
												<option value="">ทุกสถานะ</option>
												<option value="redebt_number = ''">ยังไม่มีใบลดหนี้</option>
												<option disabled="disabled" style="color:#ccc;">---------------------</option>
												<option value="rp_no is null and epayment = 1">ยังไม่สร้าง E-Pay</option>
												<option value="rp_date is not null">สร้าง E-Pay แล้ว</option>
												<option disabled="disabled" style="color:#ccc;">---------------------</option>
												<option value="rp_date is not null and pay_date is null">ยังไม่ Paid E-Pay</option>
												<option value="pay_date is not null">Paid E-Pay แล้ว</option>
												<option disabled="disabled" style="color:#ccc;">---------------------</option>
												<option value="rp_date is not null and due_date is null">ยังไม่มี Dua Date E-Pay</option>
												<option value="due_date is not null">มี Dua Date แล้ว</option>
											</select>
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

								<div class="space-br"></div>
								<div class="row">
									<div class="col-xs-6"> 
										<div class="form-group">
											<label class="txt-blue">จังหวัดที่ออกใบเสร็จ</label>
											<div id="div_sel_rec_province">
												<select id="sel_rec_province" class="form-control multiselect" multiple="multiple" style="display:none;">
													<option value="" selected>ทุกจังหวัด</option>
												</select>
											</div>
										</div>
									</div>
									<div class="col-xs-6"> 
										<div class="form-group">
											<label class="txt-blue">รูปแบบการคืนเงิน</label>
											<div id="div_sel_pick_refund">
												<select id="sel_pick_refund" class="form-control multiselect" multiple="multiple" style="display:none;">
													<option value="" selected>ทุกรูปแบบ</option>
												</select>
											</div>
										</div>
									</div>
								</div>
								<hr class="end-row">

								<div class="row">
									<div class="col-xs-12"> 
										<div class="form-inline" style="margin: 0px 0px 20px 5px;">
											<div class="pretty p-default p-round">
												<input type="radio" name="rad_date" id="create_date" value="วันที่สร้างคำขอ" fd="request.create_date" checked>
												<div class="state p-success">
													<label>วันที่สร้างคำขอ</label>
												</div>
											</div>
											<div class="pretty p-default p-round">
												<input type="radio" name="rad_date" id="last_update" value="วันที่อัพเดทล่าสุด" fd="request.last_update">
												<div class="state p-success">
													<label>วันที่อัพเดทล่าสุด</label>
												</div>
											</div>
											<div class="pretty p-default p-round">
												<input type="radio" name="rad_date" id="rp_date" value="วันที่สร้าง E-pay" fd="rp_date">
												<div class="state p-success">
													<label>วันที่สร้าง E-pay</label>
												</div>
											</div>
											<div class="pretty p-default p-round">
												<input type="radio" name="rad_date" id="pay_date" value="วันที่ Paid E-pay" fd="pay_date">
												<div class="state p-success">
													<label>วันที่ Paid E-pay</label>
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

								<hr class="end-row">
								<div class="row">
									<div class="col-xs-12"> 
										<a id="click_advance_filter" style="color:#0064e4"><label><span class="glyphicon icon-circle-down"></span> เพิ่มเติม</label></a>
									</div>
								</div>
								<div class="space-br"></div>

								<div id="advance_filter" style="display:none;">
									<div class="row">
										<div class="col-xs-12"> 
											<div class="form-group">
												<label class="txt-blue">หน่วยงานที่รับผิดชอบ</label>
												<span class="txt-red" style="font-size:12px;">(ส่วนงาน Flow Step ล่าสุดในคำขอ)</span>
												<select id="sel_depart_search" class="form-control">
													<option value="">กำลังโหลด..</option>
												</select>
											</div>
										</div>
									</div>
									<div class="space-br"></div>
									<div class="row">
										<div class="col-xs-12"> 
											<div class="form-group">
												<label class="txt-blue">สถานะหลังปิดคำขอ</label>
												<span class="txt-red" style="font-size:12px;">(สำหรับบันทึกสถานะการทำงานหลังปิดคำขอ *ถ้ามี)</span>
												<select id="sel_after_status" class="form-control">
													<option value="">กำลังโหลด..</option>
												</select>
											</div>
										</div>
									</div>
									<div class="space-br"></div>

									<div class="row">
										<div class="col-xs-12"> 
											<div class="form-group">
												<label class="txt-blue">เพิ่มคอลัมน์ Export Excel</label>
												<span class="txt-red" style="font-size:12px;">(ถ้าจำนวนผลลัพธ์มากเกินไป อาจจะ Export ไม่สำเร็จ)</span>
												<div class="form-inline" style="margin: 0px 0px 20px 5px;">
													<div class="pretty p-icon p-curve">
														<input type="checkbox" type="checkbox" id="add_col_cause"> 
														<div class="state p-success">
															<i class="icon glyphicon icon-plus2"></i>
															<label>สาเหตุที่ต้องการลดหนี้</label>
														</div>
													</div>
													<div class="pretty p-icon p-curve">
														<input type="checkbox" type="checkbox" id="add_col_remark"> 
														<div class="state p-success">
															<i class="icon glyphicon icon-plus2"></i>
															<label>หมายเหตุเพิ่มเติม</label>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-xs-12" style="text-align: right;"> 
										<button id="btn_search2" class="btn btn-danger" type="button" disabled><span class="glyphicon glyphicon-search"></span> Search</button>
									</div>
								</div>
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

		<div id="modal_custom" class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-nm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">
							<span class="glyphicon glyphicon-cog"></span> ปรับแต่งตาราง
							<span class="mode-custom">Advance Search</span>
						</h4>
					</div>
					<div class="modal-body">
						<p class="txt-red" style="font-size:12px;">*การปรับแต่งตาราง เพื่อผลลัพท์บนหน้า Advance Search เท่านั้น ไม่มีผลกับคอลัมน์ใน Export Excel</p>
						<ul id="ordercolumn" class="custom-list sortable"></ul>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-success" id="btn_save_custom">บันทึก</button>
						<button type="button" class="btn btn-warning" id="btn_default_custom">ค่าเริ่มต้น</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">ยกเลิก</button>
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
	});
	</script>

	<script type="text/javascript">
	var all_subject = "0";
	var temp_url = "";
	var page_size = 10;

	var first_ordercolumn = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ,17 ,18, 19, 20, 21, 22, 23, 24, 25 ];
	var first_nonedis = [];

	var ck_version = "ADV_181225";
	var ck_uemail = $('#hide_uemail').val();
	var ck_ordercolumn;
	var ck_nonedis;

	var all_province_len = 0;
	var xport_url = "";

	var li_ordercolumn = [
	"<li id='0' style='display:none;'><input type='checkbox' class='disorplay' id='chk_0' value='0' checked></li>"
	,"<li id='1'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_1' value='1' checked> เลขที่คำขอ</li>"
	,"<li id='2'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_2' value='2' checked> หัวข้อ</li>"
	,"<li id='3'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_3' value='3' checked> เรื่อง</li>"
	,"<li id='4'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_4' value='4' checked> จำนวนเงิน</li>"
	,"<li id='5'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_5' value='5' checked> จังหวัดที่ออกใบเสร็จ</li>"
	,"<li id='6'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_6' value='6' checked> RO ที่ออกใบเสร็จ</li>"
	,"<li id='7'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_7' value='7' checked> RO ผู้สร้างคำขอ</li>"
	,"<li id='8'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_8' value='8' checked> Shop ผู้สร้างคำขอ</li>"
	,"<li id='9'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_9' value='9' checked> ผู้สร้างคำขอ</li>"
	,"<li id='10'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_10' value='10' checked> ผู้อนุมัติ</li>"
	,"<li id='11'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_11' value='11' checked> วันที่เริ่มเปิดคำขอ</li>"
	,"<li id='12'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_12' value='12' checked> วันที่อัพเดทล่าสุด</li>"
	,"<li id='13'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_13' value='13' checked> สถานะล่าสุด</li>"
	,"<li id='14'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_14' value='14' checked> หน่วยงานที่รับผิดชอบ</li>"
	,"<li id='15'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_15' value='15' checked> Account</li>"
	,"<li id='16'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_16' value='16' checked> ชื่อลูกค้า</li>"
	,"<li id='17'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_17' value='17' checked> เลขที่ใบเสร็จ BCS</li>"
	,"<li id='18'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_18' value='18' checked> เลขที่ใบเสร็จ POS</li>"
	,"<li id='19'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_19' value='19' checked> เลขที่ใบลดหนี้</li>"
	,"<li id='20'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_20' value='20' checked> เลขที่ E-Pay</li>"
	,"<li id='21'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_21' value='21' checked> วันที่สร้าง E-Pay</li>"
	,"<li id='22'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_22' value='22' checked> วันที่อนุมัติ E-Pay</li>"
	,"<li id='23'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_23' value='23' checked> Paid Date E-Pay</li>"
	,"<li id='24'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_24' value='24' checked> Due Date E-Pay</li>"
	,"<li id='25'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_25' value='25' checked> สถานะหลังปิดคำขอ</li>"
	];

	$(document).ready(function() {
		setDatePicker();
		loadSubject(1);

		selTitleDisable();
		selProvDisable();

		$('#txt_keyword').focus();

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

	$('#click_advance_filter').click(function() {
		$("#click_advance_filter").animate({
          color: "#acacac"
        }, 1000 );

		$('#advance_filter').slideDown( 300, function() {});

		loadAfterStatusSearch();
		loadDepartmentSearch();
	});

	$('#btn_search1').click(function() {
		searchResult(1);
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
						loadDepartmentSearch();
						loadPickRefundIn($el.val());
					}
				}
			});

			$('#sel_subject_fake').hide();
			$el.show();

			loadStatus();
			startPageGetKeyword();
			loadPickRefundIn($el.val());
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

	function loadStatus() {
		var $el = $('#sel_status_search');

		$.getJSON('json_default.aspx?qrs=loadStatus', function(data) {
			$el.empty();

			$.each(data,function( i,item ) {
				$el.append($("<option></option>")
					.attr('selected', true).attr("value", item.status_id).text(item.status_name));
			});

			$el.multiselect({
				nonSelectedText: 'เลือกสถานะ'
				, allSelectedText: 'ทุกสถานะ'
				, includeSelectAllOption: true
				, selectAllText: 'ทุกสถานะ'
				, buttonWidth: '100%'
				, onDropdownHide: function(event) {
					if($el.val() === null){
						modalAlert("กรุณาเลือกสถานะ");
					} 
				}
			});

			$('#sel_status_fake').hide();
			$el.show();
		});

		loadRO();
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

			firstCookie();
			ck_ordercolumn = $.parseJSON($.cookie('ck_adv_ordercolumn_' + ck_version + ck_uemail)); // parse จาก json (ข้อความ) เป็น array
			ck_nonedis = $.parseJSON($.cookie('ck_adv_nonedis_' + ck_version + ck_uemail)); // parse จาก json (ข้อความ) เป็น array
			loadCustomTable();
		});
	}

	function loadDepartmentSearch() {
		var $el = $('#sel_depart_search');

		$el.empty();
		$el.append($("<option></option>").attr("value", "").text("กำลังโหลด.."));

		var url = 'json_redebt.aspx?qrs=loadDepartmentSearch&subject_id=' + $('#sel_subject_search').val();
		console.log(url);

		$.getJSON(url, function(data) {
			$el.empty();
			$el.append($("<option></option>")
				.attr('selected', true).attr("value", "").text("ไม่เลือก"));

			$.each(data,function( i,item ) {
				$el.append($("<option></option>")
					.attr("value", item.depart_id).text(item.depart_name));
			});
		});
	}

	function loadAfterStatusSearch() {
		var $el = $('#sel_after_status');

		$.getJSON('json_redebt.aspx?qrs=loadAfterStatusSearch', function(data) {
			$el.empty();
			$el.append($("<option></option>")
				.attr('selected', true).attr("value", "").text("ทุกสถานะ"));

			$.each(data,function( i,item ) {
				$el.append($("<option></option>")
					.attr("value", item.after_end_status_id).text(item.after_end_status_name));
			});
		});
	}

	function searchResult(tab){
		var main_url = "";

		if(tab == 1){
			$('#txt_keyword').val($('#txt_keyword').val().trim());
			
			if($('#txt_keyword').val().trim().length == 0){
				modalAlert("กรุณากรอกคำค้น");
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					$('#txt_keyword').focus();
				})
				return;
			}

			main_url += "&kw=" + $('#txt_keyword').val();
			main_url += "&subject_id=" + all_subject;
		}
		else{
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

			if($('#sel_status_search').val() == null){
				modalAlert("กรุณาเลือกสถานะคำขอ");
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					$('#sel_status_search').focus();
				})
				return;
			}

			if($('#sel_rec_province').val() != null) {
				if($('#sel_rec_province').val().length < all_province_len){
					main_url += "&rec_province=" + $('#sel_rec_province').val();
				} 
			} 

			if($('#sel_pick_refund').val() != null){
				main_url += "&pick_refund=" + $('#sel_pick_refund').val();
			} 

			if($('#sel_title_search').val() != null){
				main_url += "&request_title_id=" + $('#sel_title_search').val();
			} 

			main_url += "&subject_id=" + $('#sel_subject_search').val();
			main_url += "&status_id=" + $('#sel_status_search').val();
			main_url += "&status_epay=" + $('#sel_status_epay').val();
			main_url += "&area_ro=" + $('#sel_area_ro').val();
			main_url += "&create_ro=" + $('#sel_create_ro').val();
			main_url += "&start_date=" + $('#txt_start_date').val();
			main_url += "&end_date=" + $('#txt_end_date').val();
			main_url += "&rad_date=" + $('input[name=rad_date]:checked').attr('fd');

			main_url += "&depart_id=" + $('#sel_depart_search').val();
			main_url += "&after_end_status_id=" + $('#sel_after_status').val();
		}

		searchAllRequestCount(main_url);
	}

	function searchAllRequestCount(main_url){
		var count_url = "json_default.aspx?qrs=searchAllRequestCount" + main_url;
		// console.log(count_url);
		// console.log("main_url=" + main_url);

		$.ajax({
			url: count_url,
			cache: false,
			timeout: 120000,
			success: function( count_data ) { 
				temp_url = main_url;

				$('#count_data').html("จำนวนข้อมูล  " + numberWithCommas(count_data) + " ผลลัพธ์");
				$('#twbs_pagination').replaceWith("<ul id='twbs_pagination' class='pagination-sm'></ul>");

				if(count_data > 0) {
					$('#twbs_pagination').twbsPagination({
						totalPages: ((count_data-1)/page_size) + 1,
						visiblePages: 5,
						onPageClick: function (event, page) {
							$('#page-content').text('Page ' + page);
							searchAllRequest(temp_url, page);
						},
						first: 'หน้าแรก',
						last: 'สุดท้าย',
						prev: 'ก่อนหน้า',
						next: 'ถัดไป'
					});

					// var save_name = $('#hide_today').val().replace(/\//g, "");
					// $('#btn_xport_excel').replaceWith("<a id='btn_xport_excel' class='btn btn-primary' href=\"xportExcel_redebt.aspx?file_name=" + save_name + main_url + "&export=1\" target='_blank'><span class='glyphicon icon-file-text2'></span> Export Excel</a>");
					xport_url = main_url;
					$('#btn_xport_excel').replaceWith("<div id='btn_xport_excel'><button class='btn btn-primary' type='button' onclick='goExcel();'><span class='glyphicon glyphicon-floppy-save'></span> Export Excel</button></div>");
				}
				else {
					xport_url = "";
					$('#btn_xport_excel').replaceWith("<div id='btn_xport_excel'></div>");
				}

				searchAllRequest(main_url, 1);

			},
			error: function(x, t, m) {
				console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);

				modalAlert("ไม่สำเร็จ กรุณาลองอีกครั้ง หรือติดต่อ support_pos@jasmine.com");
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				})
			}
		});
	}

	function searchAllRequest(main_url, page_num){
		// sorting
		var btn_sorting_create = ""
		var btn_sorting_update = ""

    	if($.cookie('ck_adv_sorting_' + ck_version + ck_uemail) == "request.create_date asc"){
    		btn_sorting_create = "<a class='hover-pointer' title='sorting create' id='btn_sorting_create_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer a-gray' title='sorting update' id='btn_sorting_update_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    	}
    	else if($.cookie('ck_adv_sorting_' + ck_version + ck_uemail) == "request.create_date desc"){
    		btn_sorting_create = "<a class='hover-pointer' title='sorting create' id='btn_sorting_create_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer a-gray' title='sorting update' id='btn_sorting_update_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    	}
    	
    	if($.cookie('ck_adv_sorting_' + ck_version + ck_uemail) == "last_update asc"){
    		btn_sorting_create = "<a class='hover-pointer a-gray' title='sorting create' id='btn_sorting_create_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer' title='sorting update' id='btn_sorting_update_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    	}
    	else if($.cookie('ck_adv_sorting_' + ck_version + ck_uemail) == "last_update desc"){
    		btn_sorting_create = "<a class='hover-pointer a-gray' title='sorting create' id='btn_sorting_create_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer' title='sorting update' id='btn_sorting_update_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    	}

    	main_url += "&sorting=" + $.cookie('ck_adv_sorting_' + ck_version + ck_uemail);
		// sorting

		var page_data = "";
		page_data += "&page_size=" + page_size;
		page_data += "&page_num=" + page_num;

		var search_url = "json_default.aspx?qrs=searchAllRequest" + main_url;
		console.log(search_url + page_data);

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
						"<th>จำนวนเงิน</th>" +
						"<th>จังหวัดที่ออกใบเสร็จ</th>" +
						"<th>RO ที่ออกใบเสร็จ</th>" +
						"<th>RO ผู้สร้างคำขอ</th>" +
						"<th>Shop ผู้สร้างคำขอ</th>" +
						"<th>ผู้สร้างคำขอ</th>" +
						"<th>ผู้อนุมัติ</th>" +
						"<th>วันที่เริ่มเปิดคำขอ " + btn_sorting_create + "</th>" +
						"<th>วันที่อัพเดทล่าสุด " + btn_sorting_update + "</th>" +
						"<th>สถานะล่าสุด</th>" +
						"<th>หน่วยงานที่รับผิดชอบ</th>" +
						"<th>Account</th>" +
						"<th>ชื่อลูกค้า</th>" +
						"<th>เลขที่ใบเสร็จ BCS</th>" +
						"<th>เลขที่ใบเสร็จ POS</th>" +
						"<th>เลขที่ใบลดหนี้</th>" +
						"<th>เลขที่ E-Pay</th>" +
						"<th>วันที่สร้าง E-Pay</th>" +
						"<th>วันที่อนุมัติ E-Pay</th>" +
						"<th>Paid Date E-Pay</th>" +
						"<th>Due Date E-Pay</th>" +
						"<th>สถานะหลังปิดคำขอ</th>" +
					"</tr>" +
				"</thead>" +
				"<tbody>";

				$.each(data,function( i,item ) {
					txt_html += "<tr>"
					txt_html += "<td><a class='short-menu' title='ดูข้อมูล' target='_blank' href='update_" + item.subject_url + ".aspx?request_id=" + item.request_id + "'><span class='glyphicon glyphicon-edit'></span></a></td>"
					txt_html += "<td>" + item.request_id + "</td>"
					txt_html += "<td>" + limitStr(item.subject_prefix + "." + item.subject_name,30) + "</td>"
					txt_html += "<td>" + limitStr(item.request_title,30) + "</td>"
					txt_html += "<td class='td-amount'>" + convertAmount(item.amount) + "</td>"
					txt_html += "<td>" + itemNull(item.shop_code) + "</td>"
					txt_html += "<td>" + item.area_ro + "</td>"
					txt_html += "<td>" + item.create_ro + "</td>"
					txt_html += "<td>" + itemNull(item.create_shop) + "</td>"
					txt_html += "<td>" + item.create_by + "</td>"
					txt_html += "<td>" + item.uemail_approve + "</td>"
					txt_html += "<td>" + itemNull(item.create_date) + "</td>"
					txt_html += "<td>" + itemNull(item.last_update) + "</td>"
					txt_html += "<td>" + item.status_name + "</td>"
					txt_html += "<td>" + item.next_depart_name + "</td>"
					txt_html += "<td>" + item.account_number + "</td>"
					txt_html += "<td>" + item.account_name + "</td>"
					txt_html += "<td>" + itemNull(item.bcs_number) + "</td>"
					txt_html += "<td>" + itemNull(item.doc_number) + "</td>"
					txt_html += "<td>" + itemNull(item.redebt_number) + "</td>"
					txt_html += "<td>" + itemNull(item.rp_no) + "</td>"
					txt_html += "<td>" + itemNull(item.rp_date) + "</td>"
					txt_html += "<td>" + itemNull(item.prove_date) + "</td>"
					txt_html += "<td>" + itemNull(item.pay_date) + "</td>"
					txt_html += "<td>" + itemNull(item.due_date) + "</td>"
					txt_html += "<td>" + itemNull(item.after_end_status_name) + "</td>"
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
						"<th>วันที่อนุมัติ E-Pay</th>" +
						"<th>Paid Date E-Pay</th>" +
						"<th>Due Date E-Pay</th>" +
						"<th>สถานะหลังปิดคำขอ</th>" +
					"</tr>" +
					"</tfoot>";
				}

				txt_html += "</table>" +
				"</div>";

				$('#display_table').replaceWith(txt_html);
				callDataTable();

				$('#btn_sorting_create_desc').click(function() {
					$.cookie('ck_adv_sorting_' + ck_version + ck_uemail, 'request.create_date asc', { expires : 30 });
					searchAllRequest(temp_url, 1);
				});

				$('#btn_sorting_create_asc').click(function() {
					$.cookie('ck_adv_sorting_' + ck_version + ck_uemail, 'request.create_date desc', { expires : 30 });
					searchAllRequest(temp_url, 1);
				});

				$('#btn_sorting_update_desc').click(function() {
					$.cookie('ck_adv_sorting_' + ck_version + ck_uemail, 'last_update asc', { expires : 30 });
					searchAllRequest(temp_url, 1);
				});

				$('#btn_sorting_update_asc').click(function() {
					$.cookie('ck_adv_sorting_' + ck_version + ck_uemail, 'last_update desc', { expires : 30 });
					searchAllRequest(temp_url, 1);
				});
			},
			error: function(x, t, m) {
				console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);

				modalAlert("ไม่สำเร็จ กรุณาลองอีกครั้ง หรือติดต่อ support_pos@jasmine.com");
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				})
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

	function callDataTable() {
    	// console.log('ck_ordercolumn = ' + ck_ordercolumn);
    	// console.log('ck_nonedis = ' + ck_nonedis);

		var onthetable = $('#onthetable').DataTable({
			bFilter: false
			,paging: false
			,"aaSorting": []
			,"ordering": false
			,"iDisplayLength": -1
			,"bLengthChange": false
			,"responsive": false
			,"bInfo" : false
			,colReorder: {
				order: ck_ordercolumn
			}

		});

		onthetable.columns( ck_nonedis ).visible( false, false );
		// doubleScroll(document.getElementById('display_table'));

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

	function loadCustomTable(){
		console.log('load custom order: ' + ck_ordercolumn);
		console.log('load custom hide: ' + ck_nonedis);
		$.each(ck_ordercolumn, function( i, value ) {
			$('#ordercolumn').append(li_ordercolumn[value]);
		});

		$.each(ck_nonedis, function( i, value ) {
			$('.disorplay:checkbox:eq(' + value + ')').prop('checked', false);
			$('#ordercolumn li:eq(' + value + ')').addClass('txt-red');
		});

		$('.disorplay').click(function() {
			if($('#chk_' + $(this).val()).prop('checked') == false){
				$('#' + $(this).val()).addClass('txt-red');
			}
			else {
				$('#' + $(this).val()).removeClass('txt-red');
			}
		});
	}

    $('#btn_save_custom').click(function() {
    	// $('#page_loading').fadeIn();
    	$('#modal_custom').modal('hide');

    	ck_ordercolumn = $("#ordercolumn").sortable("toArray");

    	ck_nonedis = [];
    	$('.disorplay:checkbox').each(function(i){
    		if($(this).prop('checked') == false){
    			ck_nonedis.push(parseInt(i));
    		}
        });

		saveCookie();

		if(temp_url != "") {
			searchAllRequest(temp_url, 1);
		}
		else {
			modalAlert("<b>บันทึกการปรับแต่งตารางแล้ว</b> <br>สามารถทดสอบค้นหาข้อมูล เพื่อตรวจสอบการเปลี่ยนแปลงของการแสดงผล")
		}
	});

    $('#btn_default_custom').click(function() {
		$.removeCookie('ck_adv_ordercolumn_' + ck_version + ck_uemail);
		$.removeCookie('ck_adv_nonedis_' + ck_version + ck_uemail);
		$.removeCookie('ck_adv_sorting_' + ck_version + ck_uemail);

		location.reload();
	});

    function modalCustom(){
		$( "#ordercolumn" ).sortable({
			placeholder: "placeholder"
		});
		$( "#ordercolumn" ).disableSelection();

    	$('#modal_custom').modal("show");
    }

	function saveCookie(){
		console.log('save custom order: ' + ck_ordercolumn);
		console.log('save custom hide: ' + ck_nonedis);

		$.cookie('ck_adv_ordercolumn_' + ck_version + ck_uemail, JSON.stringify(ck_ordercolumn), { expires : 30 });
		$.cookie('ck_adv_nonedis_' + ck_version + ck_uemail, JSON.stringify(ck_nonedis), { expires : 30 });
	}

	function firstCookie(){
		// $.removeCookie('ck_adv_ordercolumn_' + ck_version + ck_uemail);
		// $.removeCookie('ck_adv_nonedis_' + ck_version + ck_uemail);
		// $.removeCookie('ck_adv_sorting_' + ck_version + ck_uemail);

		if(typeof $.cookie('ck_adv_ordercolumn_' + ck_version + ck_uemail) === 'undefined'){
			$.cookie('ck_adv_ordercolumn_' + ck_version + ck_uemail, JSON.stringify(first_ordercolumn)); // JSON.stringify บันทึก array เป็น text json
		}
		else{
			$.cookie('ck_adv_ordercolumn_' + ck_version + ck_uemail, $.cookie('ck_adv_ordercolumn_' + ck_version + ck_uemail), { expires : 30 });
		}

		if(typeof $.cookie('ck_adv_nonedis_' + ck_version + ck_uemail) === 'undefined'){
			$.cookie('ck_adv_nonedis_' + ck_version + ck_uemail, JSON.stringify(first_nonedis));
		}
		else{
			$.cookie('ck_adv_nonedis_' + ck_version + ck_uemail, $.cookie('ck_adv_nonedis_' + ck_version + ck_uemail), { expires : 30 });
		}

		if(typeof $.cookie('ck_adv_sorting_' + ck_version + ck_uemail) === 'undefined'){
			$.cookie('ck_adv_sorting_' + ck_version + ck_uemail, "request.create_date desc");
		}
		else{
			$.cookie('ck_adv_sorting_' + ck_version + ck_uemail, $.cookie('ck_adv_sorting_' + ck_version + ck_uemail), { expires : 30 });
		}
	}

	function startPageGetKeyword() {
		var kw = _GET('kw');
		// console.log("kw = " + kw);

		if(checkNotEmpty(kw)) {
			$('#txt_keyword').val(kw);
			searchResult(1);
		}
		else {
			$('#page_loading').fadeOut();
		}

		// clean kw
		var uri = window.location.toString();
		if (uri.indexOf("?kw") > 0) {
			var clean_uri = uri.substring(0, uri.indexOf("?kw"));
			window.history.replaceState({}, document.title, clean_uri);
		}
		// clean kw
	}

	function goExcel() {
		var file_name = $('#hide_today').val().replace(/\//g, "");
		var url = "xportExcel_redebt.aspx?export=1&file_name=" + file_name + xport_url;

		if($('#add_col_cause').prop("checked") == true) {
			url += "&col_cause=1";
		}

		if($('#add_col_remark').prop("checked") == true) {
			url += "&col_remark=1";
		}

        window.open(url);
	};

	$('#sel_area_ro').change(function() {
		var ro = $('#sel_area_ro').val();

		if(ro == ""){
			selProvDisable();
		}
		else {
			loadProvince(ro);
		}
	});

	function selProvDisable(){
		var div_sel_rec_province = "<div id='div_sel_rec_province'><select id='sel_rec_province' class='form-control multiselect' multiple='multiple'></select></div>";
		$('#div_sel_rec_province').replaceWith(div_sel_rec_province);

		var $el = $('#sel_rec_province');

		$el.multiselect({
			nonSelectedText: 'ทุกจังหวัด'
			, buttonWidth: '100%'
		});

		$el.multiselect('disable');
	}

	function loadProvince(ro) {
		var div_sel_rec_province = "<div id='div_sel_rec_province'><select id='sel_rec_province_fake' class='form-control'><option value=''>กำลังโหลด..</option></select><select id='sel_rec_province' class='form-control multiselect' multiple='multiple' style='display:none;'></select></div>";
		$('#div_sel_rec_province').replaceWith(div_sel_rec_province);

		var url = 'json_default.aspx?qrs=loadProvince&ro=' + ro;
		console.log(url);

		$.getJSON(url, function(data) {
			$.each(data,function( i,item ) {
				$('#sel_rec_province').append($("<option></option>")
					.attr('selected', true).attr("value", "'" + item.province_short + "'").text(item.cluster_province_name));
			});

			$('#sel_rec_province').multiselect({
				nonSelectedText: 'เลือกจังหวัด'
				, allSelectedText: 'ทุกจังหวัด'
				, includeSelectAllOption: true
				, selectAllText: 'ทุกจังหวัด'
				, buttonWidth: '100%'
				, onDropdownHide: function(event) {
					if($('#sel_rec_province').val() === null){
						modalAlert("กรุณาเลือกจังหวัด");
					}
				}
				, onSelectAll: function() {
					all_province_len = $('#sel_rec_province').val().length;
				}
				, onInitialized: function(select, container) {
					all_province_len = $('#sel_rec_province').val().length;
                }
			});

			$('#sel_rec_province').multiselect('enable');
			$('#sel_rec_province_fake').hide();
			$('#sel_rec_province').show();
		});
	}

	function loadPickRefundIn(subject_id) {
		var div_sel_pick_refund = "<div id='div_sel_pick_refund'><select id='sel_pick_refund_fake' class='form-control'><option value=''>กำลังโหลด..</option></select><select id='sel_pick_refund' class='form-control multiselect' multiple='multiple' style='display:none;'></select></div>";
		$('#div_sel_pick_refund').replaceWith(div_sel_pick_refund);

		var url = 'json_redebt.aspx?qrs=loadPickRefundIn&subject_id=' + subject_id;
		console.log(url);

		$.getJSON(url, function(data) {
			console.log(data);
			$.each(data,function( i,item ) {
				$('#sel_pick_refund').append($("<option></option>")
					.attr('selected', true).attr("value", item.pick_refund_id).text(item.pick_refund_title));
			});

			$('#sel_pick_refund').multiselect({
				nonSelectedText: 'เลือกรูปแบบการคืนเงิน'
				, allSelectedText: 'ทุกรูปแบบ'
				, includeSelectAllOption: true
				, selectAllText: 'ทุกรูปแบบ'
				, buttonWidth: '100%'
				, onDropdownHide: function(event) {
					if($('#sel_pick_refund').val() === null){
						modalAlert("กรุณาเลือกรูปแบบการคืนเงิน");
					} 
				}
			});

			$('#sel_pick_refund').multiselect('enable');
			$('#sel_pick_refund_fake').hide();
			$('#sel_pick_refund').show();
		});
	}
    </script>
</body>
</html>
