<%@ Page Language="VB" AutoEventWireup="false" CodeFile="mode_data_old.aspx.vb" Inherits="mode_data_old" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<!--[if IE ]> <body class="ie"> <![endif]-->
	<title>Follow Request ระบบติดตามคำขอ</title>

	<link rel="shortcut icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">
	<link rel="icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">

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

	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/main.css?v=32" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/default.css?v=32" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/pagedata.css?v=32" />

    <link type="text/css" rel="stylesheet" href="App_Inc/_css/gly-spin.css" />
	<link type="text/css" rel="stylesheet" href="App_Inc/icomoon/font-icon.css" />

    <script type="text/javascript" src="App_Inc/_js/panu.js?v=32"></script>
    <script type="text/javascript" src="App_Inc/_js/load_modal.js?v=32"></script>

    <style type="text/css">
    a.a-gray {
    	color: #999;
    }
    a.a-gray:hover {
    	color: #666;
    }
    a.a-red {
    	color: #FF5722;
    }
    a.a-red:hover {
    	color: red;
    }
    #btn_sorting_create_desc, #btn_sorting_create_asc, #btn_sorting_update_desc, #btn_sorting_update_asc {
    	float: right;
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
	.sel-fake {
		width: 125px !important; 
		text-align-last: 
		center;
	}
	#div_sel_subject {
		padding: 0;
		border: 0;
	}
    </style>
	<script type="text/javascript">
		var startTime,loadTime;

		function settingModeApprove(){
			$('#modal_setting').modal("show");
		}
	</script>
</head>
<body>
	<form id="form1" runat="server">
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
					<li class="active"><a href="default.aspx">หน้าหลัก</a></li>
					<li><a href="report_subject.aspx">รายงาน/สถิติ</a></li>
					<li><a href="advance_search.aspx">Advance Search</a></li>
				</ul>

				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown use_loged">
						<a href="#" id="user_logon" runat="server" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"></a>
						<ul class="dropdown-menu">
							<li><a onclick="modalCustom()" style="cursor: pointer;"><span class="glyphicon glyphicon-cog"></span> ปรับแต่งตาราง</a></li> 
							<li role="separator" class="divider"></li> 
							<li><a href="mode_approve.aspx"><span class="glyphicon glyphicon-folder-close"></span> Mode Approve</a></li> 
							<li role="separator" class="divider"></li> 
							<!-- <li><a runat="server" id="webtest" href=""><span class="glyphicon glyphicon-question-sign"></span> WebTest v.170918</a></li>  -->
							<li><a href="xmanual_user.aspx" target="_blank"><span class="glyphicon glyphicon-question-sign"></span> Manual คู่มือการใช้งาน</a></li> 
							<li><a href="xpatch_update.aspx"><span class="glyphicon glyphicon-export"></span> Patch ข้อมูลอัพเดท</a></li> 
							<li><a href="logoutOauth.aspx"><span class='glyphicon glyphicon-off user_logon'></span> Logout</a></li> 
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- <div style="height: 20px"></div> -->

	<div class="container">

		<div class="alert-bar">
		</div>

		<div class="filter-bar form-inline text-right">
			<a id="btn_new_request" class="btn btn-default btn-primary" target="_blank" href="intro.aspx"><span class="glyphicon glyphicon-plus"></span> สร้างคำขอใหม่</a>
			<div class="input-group chk-group">
				<span class="input-group-addon">
					<input type="checkbox" id="chk_current">
				</span>
				<span class="input-group-addon txt-bold txt-blue-light">แสดงทั้งหมด</span>
			</div>

			<!-- <select class="form-control" id="sel_project_search" style="width: 125px; display:none;">
				<option value="">ทุกระบบ</option>
			</select> -->

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

			<input type="text" class="form-control" placeholder="กรอกคำค้น.." title="กรอกคำค้น.." id="txt_search" style="width: 165px;">
			<button title="ค้นหา" class="btn btn-default btn-danger" type="button" id="btn_filter_search"><span class="glyphicon glyphicon-search"></span></button>
			<a class="btn btn-success" href="advance_search.aspx" id="btn_go_advance_search"><span class="glyphicon icon-search"></span> Adv Search</a>
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
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title"><span class='glyphicon glyphicon-cog'></span> ปรับแต่งตาราง</h4>
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

	<div id="modal_setting" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">คุณต้องการใช้ Mode Data เป็นหน้าหลักเสมอ</h4>
				</div>
				<div class="modal-footer">
					<input runat="server" class="btn btn-primary" OnServerClick="Save_Setting" type="submit" value="ใช่">
					<button type="button" class="btn" data-dismiss="modal">ไม่</button>
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
	var temp_url;
	var page_size = 50;

	var firstload = 1;
	var firstsubject = "";
	var thistimeout;
	var ck_ordercolumn;
	var ck_nonedis;
	var li_ordercolumn = [
	"<li id='0' style='display:none;'><input type='checkbox' class='disorplay' id='chk_0' value='0' checked></li>"
	,"<li id='1'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_1' value='1' checked> เลขที่คำขอ</li>"
	,"<li id='2'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_2' value='2' checked> ระบบ</li>"
	,"<li id='3'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_3' value='3' checked> หัวข้อ</li>"
	,"<li id='4'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_4' value='4' checked> เรื่อง</li>"
	,"<li id='5'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_5' value='5' checked> จำนวนเงิน</li>"
	,"<li id='6'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_6' value='6' checked> ผู้สร้างคำขอ</li>"
	,"<li id='7'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_7' value='7' checked> วันที่เริ่มเปิดคำขอ</li>"
	,"<li id='8'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_8' value='8' checked> วันที่อัพเดทล่าสุด</li>"
	,"<li id='9'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_9' value='9' checked> สถานะล่าสุด</li>"
	,"<li id='10'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_10' value='10' checked> หน่วยงานที่รับผิดชอบ</li>"
	,"<li id='11'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_11' value='11' checked> Account</li>"
	,"<li id='12'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_12' value='12' checked> ชื่อลูกค้า</li>"
	,"<li id='13'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_13' value='13' checked> เลขที่ใบลดหนี้</li>"
	,"<li id='14'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_14' value='14' checked> เลขที่ E-Pay</li>"
	,"<li id='15'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_15' value='15' checked> วันที่สร้าง E-Pay</li>"
	,"<li id='16'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_16' value='16' checked> วันที่อนุมัติ E-Pay</li>"
	,"<li id='17'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_17' value='17' checked> วันที่ Paid E-Pay</li>"
	,"<li id='18'><span class='glyphicon glyphicon-sort'></span><input type='checkbox' class='disorplay' id='chk_18' value='18' checked> RO ที่ออกใบเสร็จ</li>"
	];

	var ck_uemail = $('#hide_uemail').val();

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

    	if(_GET('all') == 1){
    		$('#chk_current').prop('checked', true);
    	}
		startTime = new Date().getTime();

		paginateScroll();
		loadProject();
		loadSubject('');

		setTimeout(function() {
			nextCurrentPatch();
			loadNotReadPatch();
		}, 1000);
	});

	$('#btn_advance_search').click(function() {
		$('#btn_advance_search').hide();
		$('#btn_go_advance_search').show();
	});

	$('#btn_filter_search').click(function() {
		loadAllRequest();
	});

	// $('#sel_project_search').change(function() {
	// 	if($('#sel_project_search').val() != "") {
	// 		loadSubject($('#sel_project_search').val());
	// 	}
	// });

    function loadProject() {
        var $el = $('#sel_project_search');

        $.getJSON('json_default.aspx?qrs=loadProject', function(data) {
        	$el.empty();

        	$.each(data,function( i,item ) {
        		$($el).append($("<option></option>")
        			.attr('selected', true).attr("value", item.project_id).text(item.project_prefix + ". " + item.project_name));
        	});

        	$el.multiselect({
            	nonSelectedText: 'เลือกระบบ'
            	, allSelectedText: 'ทุกระบบ'
            	, includeSelectAllOption: true
            	, selectAllText: 'ทุกระบบ'
            	, buttonWidth: '125px'
            	, onDropdownHide: function(event) {
            		if($('#sel_project_search').val() != "") {
            			loadSubject($('#sel_project_search').val());
            		}
            	}
            });

        	$('#sel_project_fake').hide();
        	$el.show();
		});
    }

    function loadSubject(project_id) {
    	var div_sel_subject = "<div id='div_sel_subject' class='form-control'><select id='sel_subject_fake' class='form-control'><option value=''>กำลังโหลด..</option></select><select id='sel_subject_search' class='form-control multiselect' multiple='multiple' style='display:none;'></select></div>";
    	$('#div_sel_subject').replaceWith(div_sel_subject);

        var $el = $('#sel_subject_search');

        $el.empty();
        $el.append($("<option></option>")
            .attr("value", "").text("กำลังโหลด"));

		var url = 'json_default.aspx?qrs=loadSubject&project_id=' + project_id;
		console.log(url);

        $.getJSON(url, function(data) {
        	$el.empty();

        	$.each(data,function( i,item ) {
        		$($el).append($("<option></option>")
        			.attr('selected', true).attr("value", item.subject_id).text(item.project_prefix + " " + item.subject_prefix + ". " + item.subject_name));

        		firstsubject += item.subject_id + ",";
        	});

        	$el.multiselect({
            	nonSelectedText: 'เลือกหัวข้อ'
            	, allSelectedText: 'ทุกหัวข้อ'
            	, includeSelectAllOption: true
            	, selectAllText: 'ทุกหัวข้อ'
            	, buttonWidth: '125px'
            });

        	$('#sel_subject_fake').hide();
        	$el.show();

        	if(firstload == 1){
        		if(firstsubject.length > 0){
        			firstsubject = firstsubject.slice(0, -1);
        		}

        		firstCookie();
				ck_ordercolumn = $.parseJSON($.cookie('cookie_ordercolumn_180720v3' + ck_uemail)); // parse จาก json (ข้อความ) เป็น array
				ck_nonedis = $.parseJSON($.cookie('cookie_nonedis_180720v3' + ck_uemail)); // parse จาก json (ข้อความ) เป็น array
				loadCustomTable();

				loadStatus();
			}
		});
    }

    function loadStatus() {
        var $el = $('#sel_status_search');

        // $el.empty();
        // $el.append($("<option></option>")
        //     .attr("value", "").text("กำลังโหลด"));

        $.getJSON('json_default.aspx?qrs=loadStatus', function(data) {
            $el.empty();

            $.each(data,function( i,item ) {
            	if(item.status_id != 100){
            		$el.append($("<option></option>")
            			.attr('selected', true).attr("value", item.status_id).text(item.status_name));
            	}
            	else {
                $el.append($("<option></option>")
                    .attr("value", item.status_id).text(item.status_name));
            }
            });

            $el.multiselect({
            	// buttonText: function(options, select) {
            	// 	return 'เลือกสถานะ';
            	// }
            	nonSelectedText: 'เลือกสถานะ'
            	, allSelectedText: 'ทุกสถานะ'
            	, includeSelectAllOption: true
            	, selectAllText: 'ทุกสถานะ'
            	, buttonWidth: '125px'
            });

            $('#sel_status_fake').hide();
            $el.show();
            
			// loadAllRequest();
			loadRO();
        });
    }

    function loadRO() {
        var $el = $('#sel_area_ro_search');

        $.getJSON('json_default.aspx?qrs=loadRO', function(data) {
            $el.empty();

            $.each(data,function( i,item ) {
                $el.append($("<option></option>")
                    .attr('selected', true).attr("value", item.ro_value).text(item.ro_title));
            });

            $el.multiselect({
            	nonSelectedText: 'เลือกพื้นที่'
            	, allSelectedText: 'ทุกพื้นที่'
            	, includeSelectAllOption: true
            	, selectAllText: 'ทุกพื้นที่'
            	, buttonWidth: '125px'
            });

            $('#sel_area_ro_fake').hide();
            $el.show();
            
			loadAllRequest();
        });
    }

    function loadAllRequest(){
    	var chk_current = 1

    	if($('#chk_current').prop("checked") == true) {
    		chk_current = ""
    	}

    	var main_url = "&uemail=" + $('#hide_uemail').val();
    	main_url += "&udepart=" + $('#hide_udepart').val();
    	main_url += "&groupemail=" + $('#hide_group_email').val();
    	main_url += "&current=" + chk_current;
    	main_url += "&tabsys=old";

    	if(firstload == 1){
    		main_url += "&subject_id=" + $.cookie('cookie_subject_180720v3' + ck_uemail);
    		main_url += "&status_id=" + $.cookie('cookie_status_180720v3' + ck_uemail);
    		main_url += "&area_ro=" + $.cookie('cookie_area_ro_180720v3' + ck_uemail);

    		var val_split = $.cookie('cookie_subject_180720v3' + ck_uemail);
    		var arr_split = val_split.split(",");
    		$("#sel_subject_search").val(arr_split);
    		$("#sel_subject_search").multiselect("refresh");

    		var val_split2 = $.cookie('cookie_status_180720v3' + ck_uemail);
    		var arr_split2 = val_split2.split(",");
    		$("#sel_status_search").val(arr_split2);
    		$("#sel_status_search").multiselect("refresh");

    		var val_split3 = $.cookie('cookie_area_ro_180720v3' + ck_uemail);
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

    		main_url += "&project_id=" + $('#sel_project_search').val();
    		main_url += "&subject_id=" + $('#sel_subject_search').val();
    		main_url += "&status_id=" + $('#sel_status_search').val();
    		main_url += "&area_ro=" + $('#sel_area_ro_search').val();

			$('#txt_search').val($('#txt_search').val().trim());
    		main_url += "&kw=" + $('#txt_search').val();
    	}

    	modeDataAllRequestCount(main_url);
    }

	function modeDataAllRequestCount(main_url){
		var count_url = "json_default.aspx?qrs=modeDataCountAllRequest" + main_url;
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
							modeDataAllRequest(temp_url, page);
						},
						first: 'หน้าแรก',
						last: 'สุดท้าย',
						prev: 'ก่อนหน้า',
						next: 'ถัดไป'
					});
				}
				else {
					modeDataAllRequest(main_url, 1);
				}

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

	function modeDataAllRequest(main_url, page_num){

    	var btn_sorting_create = ""
    	var btn_sorting_update = ""

    	if($.cookie('cookie_sorting_180720v3' + ck_uemail) == "create_date asc"){
    		btn_sorting_create = "<a class='hover-pointer' title='sorting create' id='btn_sorting_create_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer a-gray' title='sorting update' id='btn_sorting_update_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    	}
    	else if($.cookie('cookie_sorting_180720v3' + ck_uemail) == "create_date desc"){
    		btn_sorting_create = "<a class='hover-pointer' title='sorting create' id='btn_sorting_create_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer a-gray' title='sorting update' id='btn_sorting_update_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    	}
    	
    	if($.cookie('cookie_sorting_180720v3' + ck_uemail) == "last_update asc"){
    		btn_sorting_create = "<a class='hover-pointer a-gray' title='sorting create' id='btn_sorting_create_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer' title='sorting update' id='btn_sorting_update_asc'><span class='glyphicon glyphicon-chevron-down'></span></a>";
    	}
    	else if($.cookie('cookie_sorting_180720v3' + ck_uemail) == "last_update desc"){
    		btn_sorting_create = "<a class='hover-pointer a-gray' title='sorting create' id='btn_sorting_create_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    		btn_sorting_update = "<a class='hover-pointer' title='sorting update' id='btn_sorting_update_desc'><span class='glyphicon glyphicon-chevron-up'></span></a>";
    	}

    	main_url += "&sorting=" + $.cookie('cookie_sorting_180720v3' + ck_uemail);

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
								"<th>จำนวนเงิน</th>" +
								"<th>ผู้สร้างคำขอ</th>" +
								"<th class='width155'>วันที่เริ่มเปิดคำขอ " + btn_sorting_create + "</th>" +
								"<th>วันที่อัพเดทล่าสุด " + btn_sorting_update + "</th>" +
								"<th>สถานะล่าสุด</th>" +
								"<th>หน่วยงานที่รับผิดชอบ</th>" +
								"<th>Account</th>" +
								"<th>ชื่อลูกค้า</th>" +
								"<th>เลขที่ใบลดหนี้</th>" +
								"<th>เลขที่ E-Pay</th>" +
								"<th>วันที่สร้าง E-Pay</th>" +
								"<th>วันที่อนุมัติ E-Pay</th>" +
								"<th>วันที่ Paid E-Pay</th>" +
								"<th>RO ที่ออกใบเสร็จ</th>" +
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
					txt_html += "<td>" + item.project_name + "</td>"
					txt_html += "<td>" + limitStr(item.subject_prefix + "." + item.subject_name,25) + "</td>"
					txt_html += "<td>" + limitStr(item.request_title,45) + "</td>"
					txt_html += "<td class='td-amount'>" + convertAmount(item.amount) + "</td>"
					txt_html += "<td>" + item.create_by + "</td>"
					txt_html += "<td>" + itemNull(item.create_date) + "</td>"
					txt_html += "<td>" + itemNull(item.last_update) + "</td>"
					txt_html += "<td>" + item.status_name + "</td>"
					txt_html += "<td>" + item.next_depart_name + "</td>"
					txt_html += "<td>" + item.account_number + "</td>"
					txt_html += "<td>" + item.account_name + "</td>"
					txt_html += "<td>" + itemNull(item.redebt_number) + "</td>"
					txt_html += "<td>" + itemNull(item.rp_no) + "</td>"
					txt_html += "<td>" + itemNull(item.rp_date) + "</td>"
					txt_html += "<td>" + itemNull(item.prove_date) + "</td>"
					txt_html += "<td>" + itemNull(item.pay_date) + "</td>"
					txt_html += "<td>" + itemNull(item.area_ro) + "</td>"
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
								"<th>จำนวนเงิน</th>" +
								"<th>ผู้สร้างคำขอ</th>" +
								"<th>วันที่เริ่มเปิดคำขอ</th>" +
								"<th>วันที่อัพเดทล่าสุด</th>" +
								"<th>สถานะล่าสุด</th>" +
								"<th>หน่วยงานที่รับผิดชอบ</th>" +
								"<th>Account</th>" +
								"<th>ชื่อลูกค้า</th>" +
								"<th>เลขที่ใบลดหนี้</th>" +
								"<th>เลขที่ E-Pay</th>" +
								"<th>วันที่สร้าง E-Pay</th>" +
								"<th>วันที่อนุมัติ E-Pay</th>" +
								"<th>วันที่ Paid E-Pay</th>" +
								"<th>RO ที่ออกใบเสร็จ</th>" +
							"</tr>" +
						"</tfoot>";
				}

				txt_html += "</table>" +
				"</div>";

				$('#display_table').replaceWith(txt_html);
				callDataTable();

				saveCookie();

				$('#btn_sorting_create_desc').click(function() {
					$.cookie('cookie_sorting_180720v3' + ck_uemail, 'create_date asc', { expires : 30 });
					loadAllRequest();
				});

				$('#btn_sorting_create_asc').click(function() {
					$.cookie('cookie_sorting_180720v3' + ck_uemail, 'create_date desc', { expires : 30 });
					loadAllRequest();
				});

				$('#btn_sorting_update_desc').click(function() {
					$.cookie('cookie_sorting_180720v3' + ck_uemail, 'last_update asc', { expires : 30 });
					loadAllRequest();
				});

				$('#btn_sorting_update_asc').click(function() {
					$.cookie('cookie_sorting_180720v3' + ck_uemail, 'last_update desc', { expires : 30 });
					loadAllRequest();
				});

				firstload = 0;

				loadTime = (new Date().getTime() - startTime)/1000;
				console.log("loadTime = " + loadTime);
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

    function paginateScroll() {
        $('html, body').animate({
           scrollTop: $("body").offset().top
        }, 100);

        $(".paginate_button").unbind('click', paginateScroll);
        $(".paginate_button").bind('click', paginateScroll);
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

	function loadCustomTable(){
		// console.log(li_ordercolumn);
		$.each(ck_ordercolumn, function( i, value ) {
			// console.log(li_ordercolumn[value]);
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
    	$('#page_loading').fadeIn();
    	$('#modal_custom').modal('hide');

    	ck_ordercolumn = $("#ordercolumn").sortable("toArray");

    	ck_nonedis = [];
    	$('.disorplay:checkbox').each(function(i){
    		if($(this).prop('checked') == false){
    			ck_nonedis.push(parseInt(i));
    		}
        });

		loadAllRequest();
	});

    $('#btn_default_custom').click(function() {
		$.removeCookie('cookie_ordercolumn_180720v3' + ck_uemail);
		$.removeCookie('cookie_nonedis_180720v3' + ck_uemail);
		$.removeCookie('cookie_sorting_180720v3' + ck_uemail);

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
		$.cookie('cookie_ordercolumn_180720v3' + ck_uemail, JSON.stringify(ck_ordercolumn), { expires : 30 });
		$.cookie('cookie_nonedis_180720v3' + ck_uemail, JSON.stringify(ck_nonedis), { expires : 30 });
		$.cookie('cookie_subject_180720v3' + ck_uemail, $('#sel_subject_search').val(), { expires : 7 });
		$.cookie('cookie_status_180720v3' + ck_uemail, $('#sel_status_search').val(), { expires : 7 });
		$.cookie('cookie_area_ro_180720v3' + ck_uemail, $('#sel_area_ro_search').val(), { expires : 7 });
		// console.log('save_cookie_subject_180720v3 = ' + $('#sel_subject_search').val());
		// console.log('save_cookie_status_180720v3 = ' + $('#sel_status_search').val());
		// console.log('cookie_subject_180720v3 = ' + $.cookie('cookie_subject_180720v3' + ck_uemail));
		// console.log('cookie_status_180720v3 = ' + $.cookie('cookie_status_180720v3' + ck_uemail));
	}

	function firstCookie(){
		// $.removeCookie('cookie_ordercolumn_180720v3' + ck_uemail);
		// $.removeCookie('cookie_nonedis_180720v3' + ck_uemail);
		// $.removeCookie('cookie_sorting_180720v3' + ck_uemail);
		// $.removeCookie('cookie_subject_180720v3' + ck_uemail);
		// $.removeCookie('cookie_status_180720v3' + ck_uemail);

		var first_ordercolumn = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 ];
		var first_nonedis = [ 2 ];

		if(typeof $.cookie('cookie_ordercolumn_180720v3' + ck_uemail) === 'undefined'){
			$.cookie('cookie_ordercolumn_180720v3' + ck_uemail, JSON.stringify(first_ordercolumn)); // JSON.stringify บันทึก array เป็น text json
		}
		else{
			$.cookie('cookie_ordercolumn_180720v3' + ck_uemail, $.cookie('cookie_ordercolumn_180720v3' + ck_uemail), { expires : 30 });
		}

		if(typeof $.cookie('cookie_nonedis_180720v3' + ck_uemail) === 'undefined'){
			$.cookie('cookie_nonedis_180720v3' + ck_uemail, JSON.stringify(first_nonedis));
		}
		else{
			$.cookie('cookie_nonedis_180720v3' + ck_uemail, $.cookie('cookie_nonedis_180720v3' + ck_uemail), { expires : 30 });
		}

		if(typeof $.cookie('cookie_sorting_180720v3' + ck_uemail) === 'undefined'){
			$.cookie('cookie_sorting_180720v3' + ck_uemail, "create_date desc");
		}
		else{
			$.cookie('cookie_sorting_180720v3' + ck_uemail, $.cookie('cookie_sorting_180720v3' + ck_uemail), { expires : 30 });
		}

		if(typeof $.cookie('cookie_subject_180720v3' + ck_uemail) === 'undefined'){
			$.cookie('cookie_subject_180720v3' + ck_uemail, firstsubject);
		}
		else{
			$.cookie('cookie_subject_180720v3' + ck_uemail, $.cookie('cookie_subject_180720v3' + ck_uemail), { expires : 7 });
		}

		if(typeof $.cookie('cookie_status_180720v3' + ck_uemail) === 'undefined'){
			$.cookie('cookie_status_180720v3' + ck_uemail, "0,110,10,20,50,60,105");
		}
		else{
			$.cookie('cookie_status_180720v3' + ck_uemail, $.cookie('cookie_status_180720v3' + ck_uemail), { expires : 7 });
		}

		if(typeof $.cookie('cookie_area_ro_180720v3' + ck_uemail) === 'undefined'){
			$.cookie('cookie_area_ro_180720v3' + ck_uemail, "01,02,03,04,05,06,07,08,09,10");
		}
		else{
			$.cookie('cookie_area_ro_180720v3' + ck_uemail, $.cookie('cookie_area_ro_180720v3' + ck_uemail), { expires : 7 });
		}
	}
	</script>

	<link type="text/css" rel="stylesheet" href="App_Inc/lightbox2/css/lightbox-panu-custom.css" />
	<script src="App_Inc/lightbox2/js/lightbox-panu-custom.js"></script>

	<script type="text/javascript">
	var temp_patch_number = "";
	var temp_read_patch_number = "";

	lightbox.option({
		'positionFromTop' : 30,
		'fitImagesInViewport' : false,
		'alwaysShowNavOnTouchDevices' : false
	});

	function nextCurrentPatch() {
		var url = "json_default.aspx?qrs=loadCurrentPatchModeData";

		console.log(url);

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				if(data.length > 0){
					temp_patch_number = data[0].patch_number;

					var html = '<a href="' + data[0].patch_img + '" data-lightbox="updatePatch" id="alert_update"></a>';

					$('#update_patch').html(html);
					$('#alert_update').click();
				}
			},
			error: function(x, t, m) {
				console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);
			}
		});
	}

	function loadNotReadPatch() {
		var url = "json_default.aspx?qrs=loadNotReadPatchModeData";

		console.log(url);

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				if(data.length > 0){
					$.each(data,function( i,item ) {

						var html = '<div class="alert alert-patch info-warning alert-dismissible" role="alert" id="' + item.patch_number + '">' +
										'<a href="' + item.patch_img + '" data-lightbox="' + item.patch_number + '" class="close" onclick="readPatch(\'' + item.patch_number + '\')"><span class="glyphicon glyphicon glyphicon-export"></span> คลิกอ่าน</a>' +
										'<p><span>แจ้งอัพเดท (' + item.patch_date + '): ' + item.patch_title + '</span></p>' +
									'</div>';

						$('.alert-bar').append(html);
					});
				}
			},
			error: function(x, t, m) {
				console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);
			}
		});
	}

	$('.lb-close').click(function() { 
		if(temp_patch_number != ""){
			var url = "json_default.aspx?qrs=acknowPatch";

			console.log(url + " patch_number=" + temp_patch_number + " uemail=" + $('#hide_uemail').val());

			$.ajax({
				url: url,
				cache: false,
				type: "post",
				timeout: 60000,
				data: {  
					patch_number: temp_patch_number,
					uemail: $('#hide_uemail').val()
				},
				success: function( res ) {
					if(res == 1) {
						nextCurrentPatch();
					}
				},
				error: function(x, t, m) {
				}
			});
		}

		if(temp_read_patch_number != ""){
			$('#' + temp_read_patch_number).fadeOut();

			var url = "json_default.aspx?qrs=readingPatch";

			console.log(url + " patch_number=" + temp_read_patch_number + " uemail=" + $('#hide_uemail').val());

			$.ajax({
				url: url,
				cache: false,
				type: "post",
				timeout: 60000,
				data: {  
					patch_number: temp_read_patch_number,
					uemail: $('#hide_uemail').val()
				},
				success: function( res ) {
					if(res == 1) {
						console.log("read patch_number " + temp_read_patch_number + " success!!")
					}
				},
				error: function(x, t, m) {
				}
			});
		}
	});

	function readPatch(patch_number){ 
		temp_patch_number = "";
		temp_read_patch_number = patch_number;
	}
	</script>
</body>
</html>
