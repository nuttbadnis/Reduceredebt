<%@ Page Language="VB" AutoEventWireup="false" CodeFile="mode_data_all.aspx.vb" Inherits="mode_data_all" %>

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

    <link type="text/css" rel="stylesheet" href="App_Inc/_css/gly-spin.css" />
	<link type="text/css" rel="stylesheet" href="App_Inc/icomoon-2018/font-icon.css" />

	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/main.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/default.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/pagedata.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/modedata.css?v=38" />

    <script type="text/javascript" src="App_Inc/_js/panu.js?v=38"></script>
</head>
<body>
	<form id="form1" runat="server">
	<input runat="server" id="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" type="hidden">
	<input runat="server" id="hide_udepart" type="hidden">
	<input runat="server" id="hide_group_email" type="hidden">
	<input runat="server" id="hide_pushpin" type="hidden">
	<input runat="server" id="hide_tabsys" type="hidden">

	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="default.aspx">Follow Request</a>
			</div>

			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li class="active"><a href="default.aspx">หน้าหลัก</a></li>
					<li><a href="intro.aspx">สร้างคำขอใหม่</a></li>
					<li><a href="verify_approval.aspx">รายชื่อผู้อนุมัติ</a></li>
					<li><a href="advance_search.aspx">Advance Search</a></li>
				</ul>

				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown use_loged">
						<a href="#" id="user_logon" runat="server" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"></a>
						<ul class="dropdown-menu">
							<li><a href="mode_approve.aspx"><span class="glyphicon icon-window-restore"></span> Mode Approve</a></li> 
							<li role="separator" class="divider"></li> 
							<li><a runat="server" id="webtest" href=""><span class="glyphicon glyphicon-question-sign"></span> WebTest (FR Test)</a></li> 
							<li><a href="xmanual_user.aspx" target="_blank"><span class="glyphicon glyphicon-question-sign"></span> Manual คู่มือการใช้งาน</a></li> 
							<li><a href="xpatch_update.aspx"><span class="glyphicon glyphicon-export"></span> Patch ข้อมูลอัพเดท</a></li> 
							<li><a href="logoutOauth.aspx"><span class='glyphicon glyphicon-off user_logon'></span> Logout</a></li> 
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container" style="margin-top: 20px;">
		<div class="alert-bar" style="display:none;"></div>

		<ul class="nav nav-tabs" role="tablist" id="ul_tab">
			<li class="float-right"><a class="btn btn-default" id="btn_newreq" target="_blank" href="intro.aspx" tabindex="0" data-toggle="popover" data-container="body" data-placement="bottom" data-content='คลิกเพื่อ "สร้างคำขอใหม่"'><span class="glyphicon glyphicon-plus"></span> สร้างคำขอใหม่</a></li>
			<li class="float-right"><a class="btn btn-default" id="btn_search" onclick="explainFilter()"tabindex="0" data-toggle="popover" data-container="body" data-placement="bottom" data-content='คลิกเพื่อ เปิดเมนู "ค้นหา"'><span class="glyphicon glyphicon-search"></span></a></li>
			<li class="float-right"><a class="btn btn-default" id="btn_search_x" onclick="unplainFilter()" style="display:none;" ><span class="glyphicon glyphicon-remove"></span></a></li>
			<li class="float-right"><a class="btn btn-default" id="btn_setting" onclick="modalCustom()" tabindex="0" data-toggle="popover" data-container="body" data-placement="bottom" data-content='คลิกเพื่อ เปิดเมนู "ปรับแต่งตาราง"'><span class="glyphicon glyphicon-cog"></span></a></li>
			<li class="float-right" id="li_pin"><a class="btn btn-default" id="btn_pin" onclick="modalPushpin()" tabindex="0" data-toggle="popover" data-container="body" data-placement="bottom" data-content='คลิกเพื่อ "ปักหมุด" เป็นแท็บเริ่มต้น'><span class="glyphicon icon-pin"></span></a></li>
		</ul>

		<div id="filter_bar" class="filter-bar form-inline text-right" style="padding-top:20px; display:none;">
			<div class="input-group chk-group">
				<span class="input-group-addon">
					<input type="checkbox" id="chk_current">
				</span>
				<span class="input-group-addon txt-bold txt-blue-light">แสดงทั้งหมด</span>
			</div>

			<select class="form-control sel-fake" id="sel_project_fake">
				<option value="">กำลังโหลด..</option>
			</select>
			<select id="sel_project_search" class="multiselect" style="display:none;" multiple="multiple">
				<option value="" selected>ทุกระบบ</option>
			</select>

			<div id="div_sel_subject" class="form-control">
				<select class="form-control sel-fake" id="sel_subject_fake">
					<option value="">กำลังโหลด..</option>
				</select>
				<select id="sel_subject_search" class="multiselect" style="display:none;" multiple="multiple">
					<option value="" selected>ทุกหัวข้อ</option>
				</select>
			</div>

			<select class="form-control sel-fake" id="sel_area_ro_fake">
				<option value="">กำลังโหลด..</option>
			</select>
			<select id="sel_area_ro_search" class="multiselect" style="display:none;" multiple="multiple">
				<option value="">กรุณาเลือก RO ที่ออกใบเสร็จ</option>
			</select>

			<select class="form-control sel-fake" id="sel_status_fake">
				<option value="">กำลังโหลด..</option>
			</select>
			<select id="sel_status_search" class="multiselect" style="display:none;" multiple="multiple">
				<option value="">กรุณาเลือกสถานะ</option>
			</select>

			<input type="text" class="form-control" placeholder="กรอกคำค้น.." title="กรอกคำค้น.." id="txt_search">
			<button title="ค้นหา" class="btn btn-default btn-danger" type="button" id="btn_filter_search"><span class="glyphicon glyphicon-search"></span></button>
			<a class="txt-gray" href="advance_search.aspx" style="padding: 5px;">Advanced</a>
		</div>

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

	<div id="update_patch" style="display:none;"></div>

	<div id="page_loading" class="modal-backdrop">
		<div class="in-loading not-nm">
			<span class="glyphicon glyphicon-refresh gly-spin"></span>
			<span id="txt_loading"> กรุณารอสักครู่</span><br>
			<p id="txt_quote"></p>
			<span id="count_loading"></span>
		</div>
		<div class="in-loading not-ie">
			<h3><strong>ระบบไม่รองรับการใช้งานด้วยโปรแกรม Internet Explorer กรุณาใช้ Chrome หรือ Firefox</strong></h3>
		</div>
	</div>

	<div id="modal_custom" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-nm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">
						<span class="glyphicon glyphicon-cog"></span> ปรับแต่งตาราง (<span class="tab_name"></span>)
						<span class="mode-custom">Mode Data</span>
					</h4>
				</div>
				<div class="modal-body">
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

	<div id="modal_pushpin" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title"><span class='glyphicon icon-pin'></span> ปักหมุด</h4>
				</div>
				<div class="modal-body">
					<p class="modal-title">คุณต้องการใช้ "<span class="tab_name"></span>" เป็นแท็บเริ่มต้น</p>
				</div>
				<div class="modal-footer">
					<input runat="server" class="btn btn-primary" OnServerClick="Save_Pushpin" type="submit" value="ยืนยัน">
					<button type="button" class="btn" data-dismiss="modal">ปิด</button>
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

    <script type="text/javascript" src="App_Inc/_js/start_mode_data.js?v=38"></script>

	<script type="text/javascript">
	var ck_version = "All_210208";

	var first_ordercolumn = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
	var first_nonedis = [];

	var li_ordercolumn = [
	"<li id='0' style='display:none;'><input type='checkbox' class='disorplay' id='chk_0' value='0' checked></li>"
	,"<li id='1'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_1' value='1' checked> เลขที่คำขอ</li>"
	,"<li id='2'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_2' value='2' checked> ระบบ</li>"
	,"<li id='3'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_3' value='3' checked> หัวข้อ</li>"
	,"<li id='4'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_4' value='4' checked> เรื่อง</li>"
	,"<li id='5'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_5' value='5' checked> ผู้สร้างคำขอ</li>"
	,"<li id='6'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_6' value='6' checked> วันที่เริ่มเปิดคำขอ</li>"
	,"<li id='7'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_7' value='7' checked> วันที่อัพเดทล่าสุด</li>"
	,"<li id='8'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_8' value='8' checked> สถานะล่าสุด</li>"
	,"<li id='9'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_9' value='9' checked> หน่วยงานที่รับผิดชอบ</li>"
	];

	$(document).ready(function() { 
		startTime();
    	loadProject();
    	loadSubject("");
	});

    function loadAllRequest(){
		startLoader();
    	// $('#page_loading').fadeIn();

    	var chk_current = 1

    	if($('#chk_current').prop("checked") == true) {
    		chk_current = ""
    	}

    	var main_url = "&tabsys=" + $('#hide_tabsys').val();
    	main_url += "&uemail=" + $('#hide_uemail').val();
    	main_url += "&udepart=" + $('#hide_udepart').val();
    	main_url += "&groupemail=" + $('#hide_group_email').val();
    	main_url += "&current=" + chk_current;

    	if(firstload == 1){
    		main_url += "&subject_id=" + $.cookie('cookie_subject_' + ck_version + ck_uemail);
    		main_url += "&status_id=" + $.cookie('cookie_status_' + ck_version + ck_uemail);
    		main_url += "&area_ro=" + $.cookie('cookie_area_ro_' + ck_version + ck_uemail);

    		var val_split = $.cookie('cookie_subject_' + ck_version + ck_uemail);
    		var arr_split = val_split.split(",");
    		$("#sel_subject_search").val(arr_split);
    		$("#sel_subject_search").multiselect("refresh");

    		var val_split2 = $.cookie('cookie_status_' + ck_version + ck_uemail);
    		var arr_split2 = val_split2.split(",");
    		$("#sel_status_search").val(arr_split2);
    		$("#sel_status_search").multiselect("refresh");

    		var val_split3 = $.cookie('cookie_area_ro_' + ck_version + ck_uemail);
    		var arr_split3 = val_split3.split(",");
    		$("#sel_area_ro_search").val(arr_split3);
    		$("#sel_area_ro_search").multiselect("refresh");
    	}
    	else{
    		if($('#sel_subject_search').val() == null){
    			modalAlert("กรุณาเลือกหัวข้อ");
    			$('#modal_alert').on('hidden.bs.modal', function (e) {
    				$('#sel_subject_search').focus();
    			})
    			return;
    		}

    		if($('#sel_status_search').val() == null){
    			modalAlert("กรุณาเลือกสถานะ");
    			$('#modal_alert').on('hidden.bs.modal', function (e) {
    				$('#sel_status_search').focus();
    			})
    			return;
    		}

    		main_url += "&subject_id=" + $('#sel_subject_search').val();
    		main_url += "&status_id=" + $('#sel_status_search').val();
    		main_url += "&area_ro=" + $('#sel_area_ro_search').val();

			$('#txt_search').val($('#txt_search').val().trim());
    		main_url += "&kw=" + $('#txt_search').val();
    	}

    	modeDataCountAllRequest(main_url);
    }

	function modeDataAllRequest(main_url, page_num){

    	var btn_sorting_create = ""
    	var btn_sorting_update = ""

    	if($.cookie('cookie_sorting_' + ck_version + ck_uemail) == "create_date asc"){
    		btn_sorting_create = "<a class='hover-pointer' title='sorting create' id='btn_sorting_create_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer a-gray' title='sorting update' id='btn_sorting_update_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    	}
    	else if($.cookie('cookie_sorting_' + ck_version + ck_uemail) == "create_date desc"){
    		btn_sorting_create = "<a class='hover-pointer' title='sorting create' id='btn_sorting_create_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer a-gray' title='sorting update' id='btn_sorting_update_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    	}
    	
    	if($.cookie('cookie_sorting_' + ck_version + ck_uemail) == "last_update asc"){
    		btn_sorting_create = "<a class='hover-pointer a-gray' title='sorting create' id='btn_sorting_create_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer' title='sorting update' id='btn_sorting_update_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    	}
    	else if($.cookie('cookie_sorting_' + ck_version + ck_uemail) == "last_update desc"){
    		btn_sorting_create = "<a class='hover-pointer a-gray' title='sorting create' id='btn_sorting_create_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer' title='sorting update' id='btn_sorting_update_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    	}

    	main_url += "&sorting=" + $.cookie('cookie_sorting_' + ck_version + ck_uemail);

		var page_data = "";
		page_data += "&page_size=" + page_size;
		page_data += "&page_num=" + page_num;

		var search_url = "json_default.aspx?qrs=modeDataAllRequest" + main_url;
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
								"<th>ระบบ</th>" +
								"<th>หัวข้อ</th>" +
								"<th>เรื่อง</th>" +
								"<th>ผู้สร้างคำขอ</th>" +
								"<th class='width155'>วันที่เริ่มเปิดคำขอ " + btn_sorting_create + "</th>" +
								"<th>วันที่อัพเดทล่าสุด " + btn_sorting_update + "</th>" +
								"<th>สถานะล่าสุด</th>" +
								"<th>หน่วยงานที่รับผิดชอบ</th>" +
							"</tr>" +
						"</thead>" +
						"<tbody>";

				$.each(data,function( i,item ) {
					var aclass = ""
					if(item.havepermis == 0) aclass = "a-gray"
					if(item.current_step == 1) aclass = "a-red"

					txt_html += "<tr>"
					txt_html += "<td><a class='short-menu " + aclass + "' title='ดูข้อมูล' href='update_" + item.subject_url + ".aspx?request_id=" + item.request_id + "'><span class='glyphicon glyphicon-edit'></span></a></td>"
					txt_html += "<td>" + item.request_id + "</td>"
					txt_html += "<td>" + limitStr(item.project_prefix + ". " + item.project_name,25) + "</td>"
					txt_html += "<td>" + limitStr(item.subject_prefix + ". " + item.subject_name,40) + "</td>"
					txt_html += "<td>" + limitStr(item.request_title,45) + "</td>"
					txt_html += "<td>" + item.create_by + "</td>"
					txt_html += "<td>" + itemNull(item.create_date) + "</td>"
					txt_html += "<td>" + itemNull(item.last_update) + "</td>"
					txt_html += "<td>" + item.status_name + "</td>"
					txt_html += "<td>" + item.next_depart_name + "</td>"
					txt_html += "</tr>";
				});
					txt_html += "</tbody>";

				if(data.length > 25) {
					txt_html += "<tfoot>" +
							"<tr class='txt-blue txt-bold'>" +
								"<th></th>" +
								"<th>เลขที่คำขอ</th>" +
								"<th>ระบบ</th>" +
								"<th>หัวข้อ</th>" +
								"<th>เรื่อง</th>" +
								"<th>ผู้สร้างคำขอ</th>" +
								"<th>วันที่เริ่มเปิดคำขอ</th>" +
								"<th>วันที่อัพเดทล่าสุด</th>" +
								"<th>สถานะล่าสุด</th>" +
								"<th>หน่วยงานที่รับผิดชอบ</th>" +
							"</tr>" +
						"</tfoot>";
				}

				txt_html += "</table>" +
				"</div>";

				$('#display_table').replaceWith(txt_html);
				callDataTable();

				saveCookie();

				$('#btn_sorting_create_desc').click(function() {
					$.cookie('cookie_sorting_' + ck_version + ck_uemail, 'create_date asc', { expires : 30 });
					loadAllRequest();
				});

				$('#btn_sorting_create_asc').click(function() {
					$.cookie('cookie_sorting_' + ck_version + ck_uemail, 'create_date desc', { expires : 30 });
					loadAllRequest();
				});

				$('#btn_sorting_update_desc').click(function() {
					$.cookie('cookie_sorting_' + ck_version + ck_uemail, 'last_update asc', { expires : 30 });
					loadAllRequest();
				});

				$('#btn_sorting_update_asc').click(function() {
					$.cookie('cookie_sorting_' + ck_version + ck_uemail, 'last_update desc', { expires : 30 });
					loadAllRequest();
				});
			},
			error: function(x, t, m) {
				console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);

				modalAlert("ไม่สำเร็จ กรุณาลองอีกครั้ง หรือติดต่อ support_pos@jasmine.com");
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				})
			}
		}).done(function() {
			endLoader();
			// $('#page_loading').fadeOut();

			if(firstload == 1) {
				firstload = 0;
				finishTime();
				cookieFilter();
				loadPage("modeData");
			}
		});
	}
	</script>

	<link type="text/css" rel="stylesheet" href="App_Inc/lightbox2/css/lightbox-panu-custom.css" />
	<script src="App_Inc/lightbox2/js/lightbox-panu-custom.js"></script>

    <script type="text/javascript" src="App_Inc/_js/page_default.js?v=388"></script>
    <script type="text/javascript" src="App_Inc/_js/mode_data.js?v=38"></script>
</body>
</html>
