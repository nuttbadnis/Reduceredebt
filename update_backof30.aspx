<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="update_backof30.aspx.vb" Inherits="update_backof30" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">

<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_uemail_create" xd="hide_uemail_create" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden">
	<input runat="server" id="hide_subject_id" xd="hide_subject_id" type="hidden">
	<input runat="server" id="hide_request_title_id" xd="hide_request_title_id" type="hidden">

	<ol class="breadcrumb">
		<li>อัพเดทคำขอ</li>
		<li id="project_name" runat="server"></li>
		<li id="subject_name" runat="server" class="active"></li>
	</ol>

	<div class="container">
		<div class="tab-content">
			<div class="panel panel-bar">
				<div class="panel-heading panel-fonting">
					คำขอเลขที่: <span id="inn_request_id" xd="inn_request_id" runat="server">XX00000000</span>
					<span style="float:right">สถานะล่าสุด: <span id="inn_status_name" xd="inn_status_name" runat="server">xxxx</span></span>
				</div>
			</div>

			<div class="panel panel-default panel-space" runat="server" id="detail_form" xd="detail_form">
				<div class="panel-heading panel-fonting">
					<div class="panel-heading-bar form-inline text-right">
						<span class="req-detail">รายละเอียดคำขอ</span>
						<div runat="server" id="cancle_form">
							<button type="button" class="btn btn-danger btn-sm" id="btn_x_cancle">
								<span class="glyphicon glyphicon-remove" aria-hidden="true"></span> ยกเลิกคำขอ
							</button>
						</div>
					</div>
				</div>
				<div class="panel-body">
					<div class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">เรื่อง:</label>
							<span runat="server" id="inn_request_title" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">สาขาที่แจ้ง:</label>
							<span id="inn_select_shop" class="col-sm-10 control-label left-label">กำลังโหลด..</span>
							<input runat="server" id="hide_select_shop" xd="hide_select_shop" type="hidden">
							<input runat="server" id="hide_province_short" xd="hide_province_short" type="hidden">
							<input runat="server" id="hide_area_ro" xd="hide_area_ro" type="hidden">
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">เขตพื้นที่:</label>
							<div class="col-sm-10 control-label left-label">
								<span id="inn_shop_code">กำลังโหลด..</span> 
								<span id="inn_area_ro"></span>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group txt-recommend">
							<label class="col-sm-2 control-label">ข้อมูลสำนักงานที่แก้ไข:</label>
							<span runat="server" id="inn_tx01" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ข้อมูลสำนักงานเดิม:</label>
							<span runat="server" id="inn_tx02" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group" style="display:none;">
							<label class="col-sm-2 control-label">ไฟล์ประกอบการพิจารณา:</label>
							<span runat="server" id="inn_request_file3" class="col-sm-10 control-label left-label"></span>
							<input name="request_file1" id="request_file1" type="file" style="display:none;">
							<input name="request_file2" id="request_file2" type="file" style="display:none;">
							<input name="request_file3" id="request_file3" type="file" style="display:none;">
						</div>
						<!-- <div class="space-br"></div> -->

						<div runat="server" id="view_form">
							<div class="form-group">
								<label class="col-sm-2 control-label">วันที่สร้างคำขอ:</label>
								<div class="col-sm-10 control-label left-label">
									<span runat="server" id="inn_create_date"></span> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">ผู้สร้างคำขอ:</label>
								<div class="col-sm-10 control-label left-label label-padtop-inlinebtn">
									<span runat="server" id="inn_create_by"></span> 
									<span runat="server" id="inn_create_ro"></span>
									<a runat="server" id="a_href_3bbshop" class="btn btn-default btn-sm left-10" role="button" target="_blank"><span class="glyphicon glyphicon-earphone"></span> <span runat="server" id="inn_create_shop"></span></a>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">ผู้รับผิดชอบร่วม (CC):</label>
								<div class="col-sm-10 control-label left-label">
									<span runat="server" id="inn_uemail_cc"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">ผู้ตรวจสอบ 1 <br><a href="https://posbcs.triplet.co.th/3bbShop/ro_province.aspx" target="_blank">(ผู้จัดการจังหวัด)</a>:</label>
								<div class="col-sm-10 control-label left-label">
									<span runat="server" id="inn_uemail_verify1" xd="inn_uemail_verify1"></span>
									<span class="txt-desc-verify1 txt-blue" style="margin-left:10px;"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">แก้ไขข้อมูลล่าสุด:</label>
								<div class="col-sm-10 control-label left-label">
									<span runat="server" id="inn_update" xd="inn_update"></span>
								</div>
							</div>
						</div>

						<div runat="server" id="edit_form" xd="edit_form">
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								<label class="radio-inline">ผู้ดำเนินการคำขอ</label>
							</div>
							<div class="space-br"></div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">วันที่สร้างคำขอ</label>
								<div class="col-sm-10">
									<input runat="server" type="text" id="txt_create_date" xd="txt_create_date" class="form-control input-sm" disabled>
								</div>
							</div>
							<div class="form-group form-500 required">
								<label class="col-sm-2 control-label">RO ผู้สร้างคำขอ</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<asp:DropDownList runat="server" id="sel_create_ro" xd="sel_create_ro" class="form-control input-sm"></asp:DropDownList>
										<button title="info" class="btn btn-info btn-glyphicon-sm" type="button" data-toggle="modal" data-target="#modal_ro10" id="btn_info_ro_10" style="display:none;"><span class="glyphicon glyphicon-info-sign"></span></button>
									</div>
								</div>
							</div>
							<div class="form-group form-500 required">
								<label class="col-sm-2 control-label">Shop ผู้สร้างคำขอ</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<select id="sel_create_shop" class="form-control input-sm">
											<option value="">กรุณาเลือก RO ผู้สร้างคำขอก่อน</option>
										</select>
										<input runat="server" id="hide_create_shop" xd="hide_create_shop" type="hidden">
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ผู้สร้างคำขอ</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<div class="input-group">
											<input runat="server" type="text" id="txt_create_by" xd="txt_create_by" class="form-control input-sm input-addon-email" disabled>
											<div class="input-group-addon">@jasmine.com</div>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-10">
									<a id="add_cc" class="btn-addon"><span class="glyphicon glyphicon-plus-sign"></span> เพิ่มผู้รับผิดชอบร่วม (CC)</a>
								</div>
							</div>
							<div runat="server" id="form_cc1" class="form-group form-cc1" style="display:none;">
								<label class="col-sm-2 control-label">ผู้รับผิดชอบร่วม (CC) 1</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input type="text" id="auto_cc1" class="form-control input-sm box-search" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
										<div class="input-group" style="display:none;">
											<input runat="server" type="text" id="txt_uemail_cc1" xd="txt_uemail_cc1" class="form-control input-sm input-addon-email">
											<div class="input-group-addon">@jasmine.com</div>
										</div>
										<a id="remove_cc1" class="btn-addon txt-red"><span class="glyphicon glyphicon-remove"></span></a>
									</div>
								</div>
							</div>
							<div runat="server" id="form_cc2" class="form-group form-cc2" style="display:none;">
								<label class="col-sm-2 control-label">ผู้รับผิดชอบร่วม (CC) 2</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input type="text" id="auto_cc2" class="form-control input-sm box-search" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
										<div class="input-group" style="display:none;">
											<input runat="server" type="text" id="txt_uemail_cc2" xd="txt_uemail_cc2" class="form-control input-sm input-addon-email">
											<div class="input-group-addon">@jasmine.com</div>
										</div>
										<a id="remove_cc2" class="btn-addon txt-red"><span class="glyphicon glyphicon-remove"></span></a>
									</div>
								</div>
							</div>
							<div class="space-br"></div>
							<div class="form-group form-500 required">
								<label class="col-sm-2 control-label">ผู้ตรวจสอบ 1 <br><a href="https://posbcs.triplet.co.th/3bbShop/ro_province.aspx" target="_blank">(ผู้จัดการจังหวัด)</a></label>
								<div class="col-sm-10">
									<div class="form-inline">
										<div class="input-group approve-readonly">
											<input runat="server" type="text" id="txt_uemail_verify1" xd="txt_uemail_verify1" class="form-control input-sm input-addon-email" disabled>
											<div class="input-group-addon">@jasmine.com</div>
										</div>
										<input type="text" id="auto_verify1" class="form-control input-sm box-search approve-edit" style="display:none;" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
										<input runat="server" id="hide_uemail_verify1" xd="hide_uemail_verify1" type="hidden">
										<span id="txt_desc_verify1" class="txt-desc-verify1 txt-blue" style="margin-left:10px;"></span>
									</div>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<span class="txt-gray">กรุณากรอกข้อมูลช่องที่มีเครื่องหมาย <b class="txt-red">*</b> ให้ครบถ้วน</span>
							</div>
						</div>
						<div class="form-group form-500">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="form-inline">
									<button type="button" class="btn btn-success btn-sm" id="btn_submit">
										<span class="glyphicon glyphicon-floppy-save" aria-hidden="true"></span> บันทึก
									</button>
									<button type="button" class="btn btn-danger btn-sm" id="btn_cancle">
										<span class="glyphicon glyphicon-remove" aria-hidden="true"></span> ยกเลิกคำขอ
									</button>
									<input runat="server" id="btn_submit_hidden" xd="btn_submit_hidden" OnServerClick="Update_Submit" type="submit" style="display:none;">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="panel panel-default panel-gray">
				<div class="panel-heading panel-fonting">Flow Step</div>
				<div class="panel-body">
					<table id="table_flow" class="table table-striped">
						<thead class='txt-blue txt-bold'>
							<tr>
								<th>#</th>
								<th>Step</th>
								<th>Next</th>
								<th>ส่วนงาน</th>
								<th>อีเมล์</th>
								<th>สถานะ</th>
								<th>อัพเดทล่าสุด</th>
								<th>โดย</th>
								<th>หมายเหตุ</th>
								<th>เอกสารประกอบ</th>
							</tr>
						</thead>
						<tbody runat="server" id="inn_flow"></tbody>
					</table>
					<input runat="server" id="hide_flow_no" xd="hide_flow_no" type="hidden">
					<input runat="server" id="hide_flow_sub" xd="hide_flow_sub" type="hidden">
					<input runat="server" id="hide_next_step" xd="hide_next_step" type="hidden">
					<input runat="server" id="hide_back_step" xd="hide_back_step" type="hidden">
					<input runat="server" id="hide_department" xd="hide_department" type="hidden">
					<input runat="server" id="hide_flow_status" xd="hide_flow_status" type="hidden">
					<input runat="server" id="hide_flow_remark" xd="hide_flow_remark" type="hidden">
					<input runat="server" id="btn_add_next_hidden" xd="btn_add_next_hidden" OnServerClick="Add_Next" type="submit" style="display:none;">
					<input runat="server" id="hide_depart_id" xd="hide_depart_id" type="hidden">
					<input runat="server" id="btn_flow_hidden" xd="btn_flow_hidden" OnServerClick="Flow_Submit" type="submit" style="display:none;">

					<b class="txt-red">**เมื่อปิดคำขอ ระบบจะอัพเดท "ข้อมูลสำนักงาน" ที่ระบบ <a href="https://posbcs.triplet.co.th/3bbShop/admin_approval.aspx" target="_blank">3BB Shop Back Office</a> ให้อัตโนมัติ เพื่อให้ Back Office Admin อนุมัติข้อมูลขึ้นหน้าเว็บ 3BB Shop ต่อไป</b>
				</div>
			</div>
		</div>
	</div>

	<div id="modal_confirm_cancle" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">คุณต้องการยกเลิกคำขอนี้?</h4>
				</div>
				<div class="modal-footer">
					<input runat="server" class="btn btn-danger" OnServerClick="Cancle_Request" type="submit" value="ยืนยัน">
					<button type="button" data-dismiss="modal" class="btn">ยกเลิก</button>
				</div>
			</div>
		</div>
	</div>
</form>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">

<script type="text/javascript" src="App_Inc/_js/check_required.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/request_update.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/flow_submit.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/backof_operator.js?v=38"></script>

<script type="text/javascript">
$(document).ready(function() {
	loadDescApprove();
	loadDescVerify1();
	loadDescVerify2();
	loadAutoBoxApprove();
	load3bbShop($('select[xd="sel_create_ro"]').val(), $('input[xd="hide_create_shop"]').val());

	loadSelectShop($('input[xd="hide_select_shop"]').val(), 1);
	
	$('#page_loading').fadeOut();

	$('#btn_x_cancle').click(function() {
		$('#modal_confirm_cancle').modal("show");
	});
});

</script>
</asp:Content>
