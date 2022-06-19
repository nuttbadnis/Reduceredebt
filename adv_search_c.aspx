<%@ Page Language="VB" AutoEventWireup="false" CodeFile="adv_search_c.aspx.vb" Inherits="adv_search_c" %>

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
	<link type="text/css"  rel="stylesheet" href="App_Inc/_css/advsearch.css?v=38" />

	<link type="text/css" rel="stylesheet" href="App_Inc/_css/gly-spin.css" />
	<link type="text/css" rel="stylesheet" href="App_Inc/icomoon-2018/font-icon.css" />

	<script type="text/javascript" src="App_Inc/_js/panu.js?v=38"></script>
	<script type="text/javascript" src="App_Inc/_js/load_modal.js?v=38"></script>
</head>
<body>
	<form id="form1" runat="server">
		<input runat="server" id="hide_today" type="hidden">
		<input runat="server" id="hide_token" type="hidden">
		<input runat="server" id="hide_uemail" type="hidden">
		<input runat="server" id="hide_udepart" type="hidden">
		<input runat="server" id="hide_group_email" type="hidden">
		<input runat="server" id="hide_num_search" type="hidden">

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
					<li class="active"><a href="advance_search.aspx">Advance Search</a></li>
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
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>

		<div class="container">
			<div class="alert-bar"></div>

			<ul class="nav nav-tabs" role="tablist">
				<!-- <li><a href="mode_data_all.aspx">ทุกระบบ</a></li> -->
				<li><a href="adv_search_a.aspx">A. ลดหนี้ / Epayment </a></li>
				<li class="active"><a href="adv_search_c.aspx">C. 3BB Shop CC</a></li>
			</ul>
		</div>
		
		<div style="height: 20px"></div>

		<div class="container">
			<div class="col-sm-8 col-sm-offset-2">
				<p class="txt-red" style="font-size:14px; float:right;">*Advance Search สำหรับระบบ <b>C. 3BB Shop CC</b> เท่านั้น</p>
			</div>
			
			<div class="col-sm-8 col-sm-offset-2">

				<div class="panel with-nav-tabs panel-default">
					<div class="panel-heading">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#tab2default" data-toggle="tab">Report Mode</a></li>
						</ul>
					</div>
					<div class="panel-body">
						<div class="tab-content">
							<div class="tab-pane fade in active" id="tab2default">
								<!-- <div class="space-br"></div>
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
								</div> -->
								<div class="space-br"></div>
								<div class="row">
									<div class="col-xs-6"> 
										<div class="form-group">
											<label class="txt-blue">RO ผู้สร้างคำขอ</label>
											<select id="sel_area_ro" class="form-control">
												<option value="">กำลังโหลด..</option>
											</select>
										</div>
									</div>
									<div class="col-xs-6"> 
										<div class="form-group">
											<label class="txt-blue">ค้นหาด้วยเลขที่คำขอ</label>
											<input id="txt_keyword" class="form-control" type="text" />
										</div>
									</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
									<div class="col-xs-12"> 
										<div class="form-group">
											<label class="txt-blue">รหัสสาขา</label>

											<input type="text" id="auto_shop_code" class="form-control auto-sch" placeholder="ค้นหาอัตโนมัติโดย รหัสสาขา, ชื่อ หรือที่อยู่">
											<input runat="server" id="hide_shop_code" xd="hide_shop_code" type="hidden">
										</div>
									</div>
									<!-- <div class="col-xs-6"> 
										<div class="form-group">
											<label class="txt-blue">จังหวัด</label>
											<div id="div_sel_rec_province">
												<select id="sel_rec_province" class="form-control multiselect" multiple="multiple" style="display:none;">
													<option value="" selected>ทุกจังหวัด</option>
												</select>
											</div>
										</div>
									</div> -->
									<!-- <div class="col-xs-6"> 
										<div class="form-group">
											<label class="txt-blue">รหัส shop</label>
											<div id="div_sel_rec_shopcode">
												<select id="sel_rec_shopcode" class="form-control multiselect" multiple="multiple" style="display:none;">
													<option value="" selected>ทุกรหัส shop</option>
												</select>
											</div>
										</div>
									</div> -->
								</div>

								<div class="row">
									<div class="col-xs-12" style="text-align: right;"> 
										<button id="btn_search2" class="btn btn-danger" type="button"><span class="glyphicon glyphicon-search"></span> Search</button>
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
	</form>
	
	<script type="text/javascript">

	$(document).ready(function() {
		loadRO();
		// selProvDisable();
		// selShopDisable();
		$('#page_loading').fadeOut();

	});
	$('#auto_shop_code').autocomplete({
		minLength: 2,
		focus: function(event, ui) {
			event.preventDefault();
			$("#auto_shop_code-search").val(ui.item.label);
		},
		source: function( request, response ) {
			var url = "json_ctshop.aspx?qrs=autoShopCode&kw=" + request.term;
			console.log(url)

			$.ajax({
				url: url,
				cache: false,
				dataType: "json",
				success: function( data ) {
					response( $.map( data, function( item ) {
						return {
							ro: item.ro,
							cluster: item.cluster,
							province_short: item.province_short,
							label: item.shop_code + " / " + item.shop_name + " / " + item.province_short + " / " + item.cluster + " / RO" + item.ro ,
							value: item.shop_code
						}
					}));
				},
				error: function() {
					console.log("autocomplete fail!!");
					$('#page_loading').fadeOut();
				}
			});
		}
	});
	$('#btn_search2').click(function() {
		searchResult();
	});

	function loadRO() {
		var $el1 = $('#sel_area_ro');
		$.getJSON('json_default.aspx?qrs=loadRO', function(data) {
			$el1.empty();
			$el1.append($("<option></option>")
				.attr("value", "").text("ทุกเขตพื้นที่"));
			$.each(data,function( i,item ) {
				$el1.append($("<option></option>")
					.attr("value", item.ro_value).text(item.ro_title));
			});

			$('#btn_search2').prop('disabled', false);
		});
	}

	function searchResult(){
		var main_url = "";
			// $('#txt_keyword').val($('#txt_keyword').val().trim());
			
			if($('#txt_keyword').val().trim().length != 0){
			 	main_url += "&kw=" + $('#txt_keyword').val();
			}
			if($('#auto_shop_code').val().trim().length != 0){
			 	main_url += "&shop_code=" + $('#auto_shop_code').val();
			}
			if($('#sel_area_ro').val() != null) {
				main_url += "&area_ro=" + $('#sel_area_ro').val();
			}
		var num_search = $('#hide_num_search').val();	
		if(num_search == 0){
			searchAllRequestCount(main_url);
		}else{
			var search_url = "json_ctshop.aspx?qrs=searchRequestShop" + main_url;
			console.log("url : "+search_url);
			$('#onthetable').DataTable().ajax.url(search_url).load();
		}
		
	}

	function searchAllRequestCount(main_url){
		$('#hide_num_search').val(1);
		//$('#display_table').empty();
		var txt_html = "" +
				"<table id='onthetable' class='table table-hover table-striped table-bordered dt-responsive nowrap' cellspacing='0' width='100%'>" +
				"<thead>" +
					"<tr class='txt-blue txt-bold'>" +
						"<th></th>" +
						"<th>เลขที่คำขอ</th>" +
						//"<th>จังหวัด</th>" +
						"<th>RO</th>" +
						"<th>Shop</th>" +
						"<th>ชื่อ Shop</th>" +
						"<th>ผู้สร้างคำขอ</th>" +
						"<th>วันที่เริ่มเปิดคำขอ</th>" +
						"<th>วันที่อัพเดทล่าสุด</th>" +
						"<th>สถานะล่าสุด</th>" +
						"<th>หน่วยงานที่รับผิดชอบ</th>" +
					"</tr>" +
				"</thead>" +
				"</table>";
		$('#display_table').replaceWith(txt_html);
		var search_url = "json_ctshop.aspx?qrs=searchRequestShop" + main_url;
		console.log("url : "+search_url);
		var table = $('#onthetable').DataTable({
            "ajax": {
                "url": "" +search_url+ "",
                "contentType": "application/json",
                "type": "POST",
                //"data": "-"
                "dataSrc": function (json) {
                    console.log(json);   
                    return json;
                }
            },
            "columns": [
                        {
                            "mData": null,
                            "bSortable": false,
                            "mRender": function (data, type, value) {
								if(value["request_type"] == "new"){
									var edit_url = "update_ctshop40.aspx?request_id=" + value["request_id"];
								}else{
									var edit_url = "http://posweb.triplet.co.th/requestshop/ShowRequest.aspx?";
									edit_url += "requesttype=10&id=" + value["request_id"];
								}
                                return "<a class='short-menu' title='ดูข้อมูล' target='_blank' href='"+edit_url+"'><span class='glyphicon glyphicon-edit'></span></a>";
                            }
                        },
                        { 'data': 'request_id' },
                        { 'data': 'create_ro' },
						{
                            "mData": null,
                            "bSortable": false,
                            "mRender": function (data, type, value) {
                                return itemNull(value["shopcode"]);
                            }
                        },
						{
                            "mData": null,
                            "bSortable": false,
                            "mRender": function (data, type, value) {
                                return itemNull(value["shopname"]);
                            }
                        },
                        { 'data': 'create_by' },
						{
                            "mData": null,
                            "bSortable": false,
                            "mRender": function (data, type, value) {
                                return itemNull(value["create_date"]);
                            }
                        },
						{
                            "mData": null,
                            "bSortable": false,
                            "mRender": function (data, type, value) {
                                return itemNull(value["last_update"]);
                            }
                        },
                        { 'data': 'status_name' },
                        { 'data': 'depart_name' },
            ],
            "oLanguage": {
                "sEmptyTable": "ไม่มีข้อมูลรายงานการนำส่ง"
            },
            ///search input
            "bFilter": false,
            "autoWidth": false,
            "bLengthChange": false,
        });
        table.columns.adjust().draw();
	}
    </script>
</body>
</html>
