<%@ Page Language="VB" AutoEventWireup="false" CodeFile="mode_approve_a.aspx.vb" Inherits="mode_approve_a" %>

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

	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/main.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/default.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/pagedata.css?v=38" />
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/modeapprove.css?v=38" />
	<link type="text/css" rel="stylesheet" href="App_Inc/_css/redebt.css?v=38" />

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/gly-spin.css" />
	<link type="text/css" rel="stylesheet" href="App_Inc/icomoon-2018/font-icon.css" />

	<script type="text/javascript" src="App_Inc/_js/panu.js?v=38"></script>
	<script type="text/javascript" src="App_Inc/_js/redebt_search_autoinput.js?v=38"></script>
</head>
<body>
	<form id="form1" runat="server">
		<input runat="server" id="hide_token" type="hidden">
		<input runat="server" id="hide_uemail" type="hidden">
		<input runat="server" id="hide_udepart" type="hidden">
		<input runat="server" id="hide_group_email" type="hidden">
		<input runat="server" id="hide_depart_approve" type="hidden">
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
								<li><a href="mode_data.aspx"><span class="glyphicon icon-window-restore"></span> Mode Data</a></li> 
								<li role="separator" class="divider"></li> 
								<li><a href="xmanual_user.aspx" target="_blank"><span class="glyphicon glyphicon-question-sign"></span> Manual คู่มือการใช้งาน</a></li> 
								<li><a href="xmanual_approval.aspx" target="_blank"><span class="glyphicon glyphicon-question-sign" style="color: #008fff;"></span> Manual คู่มือโหมดอนุมัติ</a></li> 
								<li><a href="xpatch_update.aspx"><span class="glyphicon glyphicon-export"></span> Patch ข้อมูลอัพเดท</a></li> 
								<li><a href="logoutOauth.aspx"><span class='glyphicon glyphicon-off user_logon'></span> Logout</a></li> 
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>


		<div id="stick_top">
			<div class="container" style="margin-top: 20px;">
				<div class="alert-bar" style="display:none;"></div>

				<ul class="nav nav-tabs" role="tablist" id="ul_tab">
					<li class="float-right" id="li_pin"><a class="btn btn-default" id="btn_pin" onclick="modalPushpin()" tabindex="0" data-toggle="popover" data-container="body" data-placement="left" data-content='คลิกเพื่อ "ปักหมุด" เป็นแท็บเริ่มต้น'><span class="glyphicon icon-pin"></span></a></li>
				</ul>

				<div id="display_table"></div>
			</div>
		</div>

		<div id="stick_foot">
			<div id="sample_manual" class="container">
				<div class="row">
					<div class="col-xs-12">
						<label class="txt-blue">แนะนำการใช้งาน:</label>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<ul style="list-style-type: disc;">
							<li>สามารถคลิกที่แถว ส่วนใดก็ได้ของแถวนั้นๆ เพื่อแสดงรายละเอียดคำขอเบื้องต้น</li>
							<li>หากมีประวัติลดหนี้ จะแสดงจำนวนที่ปุ่ม <button type='button' class='btn btn-primary btn-sm' title='ประวัติการลดหนี้'>2</button> สามารถคลิกปุ่ม เพื่อแสดงรายละเอียดประวัติการลดหนี้</li>
							<li>สามารถคลิกที่ <b style="color: #FF5722;">เลขที่คำขอ</b> เพื่อเปิดหน้ารายละเอียดคำขอทั้งหมด</li>
						</ul>
					</div>
				</div>
			</div>

			<div id="sample_load" class="container" style="display:none;">
				<div class="row">
					<div class="col-xs-12">
						<strong class="txt-gray blink-text">
							<span class="glyphicon glyphicon-refresh gly-spin"></span><span id="txt_loading"> กรุณารอสักครู่...</span>
						</strong>
					</div>
				</div>
			</div>

			<div id="sample_redebt" class="container sample-detail" style="display:none;">
				<div class="row">
					<div class="col-xs-6">
						<label class="txt-blue">เรื่องที่แจ้ง:</label>
						<span id="a_request_title"></span>
					</div>
					<div class="col-xs-6">
						<label class="txt-blue">จำนวนเงิน:</label>
						<span id="a_amount"></span>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<label class="txt-blue">สาเหตุ:</label>
						<span id="a_redebt_cause_title"></span>
					</div>
					<div class="col-xs-6">
						<label class="txt-blue">วิธีการคืนเงิน:</label>
						<span id="a_pick_refund"></span>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<label class="txt-blue">หมายเหตุ:</label>
						<span id="a_request_remark"></span>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<label class="txt-blue">วันที่ลูกค้าขอลดหนี้:</label>
						<span id="a_dx03"></span>
					</div>
					<div class="col-xs-6">
						<label class="txt-blue">วันที่เริ่มเปิดคำขอ:</label>
						<span id="a_create_date"></span>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<label class="txt-blue">จังหวัดที่ออกใบเสร็จ:</label>
						<span id="a_province_name"></span>
					</div>
					<div class="col-xs-6">
						<label class="txt-blue">ผู้สร้างคำขอ:</label>
						<span id="a_create_by"></span>
					</div>
				</div>
			</div>
		</div>

		<div id="update_patch" style="display:none;"></div>
	
		<div id="page_loading" class="modal-backdrop">
			<div class="in-loading not-nm">
				<span class="glyphicon glyphicon-refresh gly-spin"></span><span id="txt_loading"> กรุณารอสักครู่...</span>
			</div>
			<div class="in-loading not-ie">
				<h3><strong>ระบบไม่รองรับการใช้งานด้วยโปรแกรม Internet Explorer กรุณาใช้ Chrome หรือ Firefox</strong></h3>
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
						<p class="modal-title">คุณต้องการใช้ "ทุกระบบ" เป็นแท็บเริ่มต้น</p>
					</div>
					<div class="modal-footer">
						<input runat="server" class="btn btn-primary" OnServerClick="Save_Pushpin" type="submit" value="ยืนยัน">
						<button type="button" class="btn" data-dismiss="modal">ปิด</button>
					</div>
				</div>
			</div>
		</div>

		<div id="modal_confirm" class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-nm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="modal_approve_title">ยืนยันผลการอนุมัติ <span id="request_id_confirm" style='color:#008fff;'></span></h4>
					</div>
					<div class="modal-body" id="body_remark" style="display:none;">
						<div class="row">
							<div class="col-xs-12">
								<textarea type="text" id="txt_flow_remark" class="form-control input-sm" rows="2" placeholder="กรุณากรอกหมายเหตุที่ต้องการ ข้อข้อมูลเพิ่ม\ไม่อนุมัติ"></textarea>
							</div>
						</div>
						<div class="row" id="remark_error" style="margin-top:15px; display:none;">
							<div class="col-xs-12">
								<p class="txt-red txt-bold">**กรุณากรอกหมายเหตุ</p>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<input id="hide_request_id_confirm" type="hidden">
						<input id="hide_request_num_last_update" type="hidden">
						<button type="button" class="btn btn-warning" id="btn_reply">ขอข้อมูลเพิ่ม</button>
						<button type="button" class="btn btn-danger" id="btn_not_approve">ไม่อนุมัติ</button>
						<button type="button" class="btn btn-warning" id="btn_reply_confirm" style="display:none;">ยืนยัน ขอข้อมูลเพิ่ม</button>
						<button type="button" class="btn btn-danger" id="btn_not_approve_confirm" style="display:none;">ยืนยัน ไม่อนุมัติ</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">ปิด</button>
					</div>
				</div>
			</div>
		</div>

		<div id="modal_redebt_history" class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">ประวัติการลดหนี้ของ <span id="acc_num"></span></h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-6">
								<div class="row">
									<div class="col-xs-12">
										<h5 class="count-acc-in-process" title="ยังไม่ปิดคำขอ">เฉพาะที่ยังไม่ปิดคำขอ (<b>-</b>)</h5>
									</div>
								</div>
								<div id="acc_in_process"></div>
							</div>
							<div class="col-xs-6">
								<div class="row">
									<div class="col-xs-12">
										<h5 class="count-acc-in-close" title="ปิดคำขอแล้ว">เฉพาะที่ปิดคำขอแล้ว (<b>-</b>)</h5>
									</div>
								</div>
								<div id="acc_in_close"></div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="row">
							<div class="col-xs-12">
								<h5 class="txt-red">*รายการประวัติการลดหนี้ จะแสดงเฉพาะคำขอที่ยังไม่ปิดคำขอ และที่ปิดคำขอแล้วเท่านั้น ไม่นับรวมคำขอที่สถานะล่าสุดเป็น "ยกเลิกคำขอ"</h5>
							</div>
						</div>
					</div>
					<div id="prove_btn" class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">ปิด</button>
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

	<script type="text/javascript" src="App_Inc/_js/start_mode_approve.js?v=38"></script>

	<script type="text/javascript">

	$(document).ready(function() { 
		if($('#hide_depart_approve').val() > 0){
			startTime();
			modeApproveAllRequest();
		}
		else {
			modalAlert("Mode Approve เฉพาะผู้ตรวจสอบ หรืออนุมัติเท่านั้น!!");
			$('#modal_alert').on('hidden.bs.modal', function (e) {
				window.location = 'default.aspx';
			})
		}
	});

	function modeApproveAllRequest(){
		var url = "json_default.aspx?qrs=modeApproveAllRequest";
    	url += "&tabsys=" + $('#hide_tabsys').val();
		url += "&uemail=" + $('#hide_uemail').val();
		url += "&udepart=" + $('#hide_udepart').val();
		url += "&groupemail=" + $('#hide_group_email').val();
		url += "&current=1";
		url += "&status_id=0,10,20,50,60";

		console.log(url);

		not_page_loading = 0;
		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				count_req = data.length;

				var txt_html = "<div id='display_table'>" +
				"<table id='onthetable' class='table table-striped table-bordered dt-responsive nowrap table-hover' cellspacing='0' width='100%'>" +
				"<thead>" +
				"<tr class='txt-blue txt-bold'>" +
				"<th class='th-nowrap'>เลขที่คำขอ</th>" +
				"<th>หัวข้อ</th>" +
				"<th class='th-nowrap'>จำนวนเงิน</th>" +
				"<th class='th-nowrap'>จังหวัดที่ออกใบเสร็จ</th>" +
				"<th class='th-nowrap'>ผู้สร้างคำขอ</th>" +
				"<th class='th-nowrap'>วันที่ลูกค้าขอลดหนี้</th>" +
				"<th class='th-nowrap'>วันที่เริ่มเปิดคำขอ</th>" +
				"<th class='th-nowrap'>วันที่อัพเดทล่าสุด</th>" +
				"<th class='th-nowrap'>ประวัติลดหนี้</th>" +
				"<th class='th-nowrap' id='th_count_req'>ข้อมูลทั้งหมด <span id='count_req'>0</span> คำขอ</th>" +
				"</tr>" +
				"</thead>" +
				"<tbody>";

				$.each(data,function( i,item ) {
                    var txt_btn = "";
                    var txt_history = "";

                    if (item.dash_step == 1) {
                        txt_btn += "<a class='btn btn-default btn-sm btn-approve' role='button' title='ดูข้อมูล' href='update_" + item.subject_url + ".aspx?request_id=" + item.request_id + "'>รับทราบ</a> "
                    }
                    else {
                        txt_btn += "<button type='button' class='btn btn-success btn-sm btn-approve btn-1' title='อนุมัติ' id='btn_app_" + item.request_id + "' onclick='reqAprrove(\"" + item.request_id + "\")'>อนุมัติ</span></button> "
                        txt_btn += "<button type='button' class='btn btn-primary btn-sm btn-approve btn-2' title='ยืนยันการอนุมัติ' id='btn_notapp_" + item.request_id + "' onclick='confirmAprrove(\"" + item.request_id + "\", \"" + item.num_last_update + "\")'>ยืนยัน</span></button> "
                        txt_btn += "<button type='button' class='btn btn-danger btn-sm btn-approve' title='ไม่อนุมัติ' onclick='reqNotApprove(\"" + item.request_id + "\", \"" + item.num_last_update + "\")'>ไม่อนุมัติ</span></button> "
                    }

					if(item.count_acc > 1){
						txt_history = "<button type='button' class='btn btn-primary btn-sm btn-history' title='ประวัติการลดหนี้' onclick='popHistory(\"" + item.account_number + "\",\"" + item.request_id + "\")'>" + (item.count_acc-1) + "</button>"
					}
					else {
						txt_history = "<button type='button' class='btn btn-sm' disabled>0</button>"
					}

					txt_html += "<tr id='tr_" + item.request_id + "' onclick='sampleDetail(\"" + item.request_id + "\",\"" + item.project_prefix + "\")'>"
					txt_html += "<td><a class='short-menu txt-bold a-red' title='ดูข้อมูล' href='update_" + item.subject_url + ".aspx?request_id=" + item.request_id + "'>" + item.request_id + "</a></td>"
					txt_html += "<td>" + limitStr(item.subject_prefix + "." + item.subject_name,35) + "</td>"
					txt_html += "<td class='td-amount'>" + convertAmount(item.amount) + "</td>"
					txt_html += "<td class='td-center'>" + itemNull(item.shop_code) + "</td>"
					txt_html += "<td class='td-center'>" + itemNull(item.create_by) + "</td>"
					txt_html += "<td class='td-center'>" + itemNull(item.dx03) + "</td>"
					txt_html += "<td class='td-center'>" + itemNull(item.create_date) + "</td>"
					txt_html += "<td class='td-center'>" + itemNull(item.last_update) + "</td>"
					txt_html += "<td class='td-center'>" + txt_history + "</td>"
					txt_html += "<td>" + txt_btn + "</td>"
                    txt_html += "</tr>";
				});

				txt_html += "</tbody></table></div>";

				$('#display_table').replaceWith(txt_html);
				$('#count_req').html(count_req);
				callDataTable();
			},
			error: function(x, t, m) {
				console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);

				modalAlert("ไม่สำเร็จ กรุณาลองอีกครั้ง หรือติดต่อ support_pos@jasmine.com");
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				})
			}
		}).done(function() {
			$('#page_loading').fadeOut();

			if(firstload == 1) {
				firstload = 0;
				finishTime();
				loadPage("modeApprove");
			}
		});
	}
	</script>

	<link type="text/css" rel="stylesheet" href="App_Inc/lightbox2/css/lightbox-panu-custom.css" />
	<script src="App_Inc/lightbox2/js/lightbox-panu-custom.js"></script>

	<script type="text/javascript" src="App_Inc/_js/page_default.js?v=388"></script>
	<script type="text/javascript" src="App_Inc/_js/mode_approve.js?v=38"></script>
</body>
</html>
