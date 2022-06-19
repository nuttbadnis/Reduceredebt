<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="new_backof10.aspx.vb" Inherits="new_backof10" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">

<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_flow_id" xd="hide_flow_id" type="hidden">
	<input runat="server" id="hide_prefix_id" xd="hide_prefix_id" type="hidden">
	<input runat="server" id="hide_redebt_cause" xd="hide_redebt_cause" type="hidden">
	<input runat="server" id="hide_create_ro" xd="hide_create_ro" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden" value="1">

	<ol class="breadcrumb">
		<li><a href="intro.aspx"><span class="glyphicon glyphicon-plus"></span> สร้างคำขอใหม่</a></li>
		<li id="project_name" runat="server"></li>
		<li id="subject_name" runat="server" class="active"></li>
	</ol>

	<div class="container">
		<div class="tab-content">

			<div class="alert info-warning alert-dismissible" role="alert" style="line-height:24px;">
				<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<p>
					<b>คำอธิบายหัวข้อ:</b> 
					<span id="subject_desc" runat="server"></span>
				</p>
			</div>

			<div class="panel panel-default panel-space">
				<div class="panel-heading panel-fonting">รายละเอียดคำขอ</div>
				<div class="panel-body">
					<div class="form-horizontal">
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">เรื่อง</label>
							<div class="col-sm-10">
								<asp:DropDownList runat="server" id="sel_title" xd="sel_title" class="form-control input-sm width700"></asp:DropDownList>
							</div>
						</div>
						<div class="form-group form-500 required" style="display:none;">
							<div class="col-sm-offset-2 col-sm-10">
								<input runat="server" id="txt_request_title" xd="txt_request_title" type="text" class="form-control input-sm width700" placeholder="เรื่อง..">
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">สาขาที่แจ้งปิด</label>
							<div class="col-sm-10">
								<select id="sel_select_shop" class="form-control input-sm">
									<option value="">กรุณาเลือกสาขา</option>
								</select>
								<input runat="server" id="hide_select_shop" xd="hide_select_shop" type="hidden">
								<input runat="server" id="hide_province_short" xd="hide_province_short" type="hidden">
								<input runat="server" id="hide_area_ro" xd="hide_area_ro" type="hidden">
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">เริ่มแสดงผลวันที่</label>
							<div class="col-sm-10">
								<input type="text" id="txt_start_display" class="form-control input-sm datepicker" maxlength="10" placeholder="30/12/2018" readonly>
								<input runat="server" id="hide_dx01" xd="hide_dx01" type="hidden">
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">แสดงผลถึงวันที่</label>
							<div class="col-sm-10">
								<input type="text" id="txt_end_display" class="form-control input-sm datepicker" maxlength="10" placeholder="30/12/2018" readonly>
								<input runat="server" id="hide_dx02" xd="hide_dx02" type="hidden">
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">หมายเหตุ</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txt_request_remark" xd="txt_request_remark" class="form-control width700" rows="4" placeholder="ปิดทำการ ในวันจันทร์ที่ 1 มกราคม 2561 (เนื่องในวันขึ้นปีใหม่) ขออภัยในความไม่สะดวกค่ะ"></textarea>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">เริ่มปิดวันที่</label>
							<div class="col-sm-10">
								<input type="text" id="txt_start_close" class="form-control input-sm datepicker" maxlength="10" placeholder="30/12/2018" readonly>
								<input runat="server" id="hide_dx03" xd="hide_dx03" type="hidden">
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">ปิดถึงวันที่</label>
							<div class="col-sm-10">
								<input type="text" id="txt_end_close" class="form-control input-sm datepicker" maxlength="10" placeholder="30/12/2018" readonly>
								<input runat="server" id="hide_dx04" xd="hide_dx04" type="hidden">
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ไฟล์ประกอบการพิจารณา (ถ้ามี)</label>
							<div class="col-sm-10">
								<input name="request_file1" id="request_file1" type="file" style="display:none;">
								<input name="request_file2" id="request_file2" type="file" style="display:none;">
								<input name="request_file3" id="request_file3" type="file" class="form-control input-sm file-10mb">
							</div>
						</div>
						<div class="space-br"></div>
						<!-- <div class="form-group">
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<span class="txt-gray">**กรณีคืนเงินโดยการโยกยอด(ลูกค้าคนละชื่อ) รบกวนแนบเอกสารยินยอมการโยกยอดด้วย</span>
							</div>
						</div>
						<div class="space-br"></div> -->
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								<label class="radio-inline">ผู้ดำเนินการคำขอ</label>
							</div>
							<div class="space-br"></div>
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
							<div class="form-group form-cc1" style="display:none;">
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
							<div class="form-group form-cc2" style="display:none;">
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
							<div class="form-group required">
								<label class="col-sm-2 control-label">ผู้ตรวจสอบ 1 <br><a href="https://posbcs.triplet.co.th/3bbShop/ro_province.aspx" target="_blank">(ผู้จัดการจังหวัด)</a></label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input type="text" id="auto_verify1" class="form-control input-sm box-search" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
										<input runat="server" id="hide_uemail_verify1" xd="hide_uemail_verify1" type="hidden">
										<span id="txt_desc_verify1" class="txt-blue" style="margin-left:10px;"></span>
									</div>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label">ผู้ตรวจสอบ 2 <br><a href="https://posbcs.triplet.co.th/3bbShop/ro_cluster.aspx" target="_blank">(ผู้จัดการ Cluster)</a></label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input type="text" id="auto_verify2" class="form-control input-sm box-search" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
										<input runat="server" id="hide_uemail_verify2" xd="hide_uemail_verify2" type="hidden">
										<span id="txt_desc_verify2" class="txt-blue" style="margin-left:10px;"></span>
									</div>
								</div>
							</div>
							<div class="form-group" style="display:none;">
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-10">
									<a id="copy_same" class="btn-addon"><span class="glyphicon glyphicon-unchecked"></span> ผู้อนุมัติเป็นคนเดียวกับผู้ตรวจสอบ</a>
									<a id="uncopy_same" class="btn-addon" style="display:none;"><span class="glyphicon glyphicon-check"></span> ผู้อนุมัติเป็นคนเดียวกับผู้ตรวจสอบ</a>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label">ผู้อนุมัติ <br><a href="https://posbcs.triplet.co.th/3bbShop/ro_director.aspx" target="_blank">(ผู้อำนวยการภาค)</a></label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input type="text" id="auto_approve" class="form-control input-sm box-search" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
										<input runat="server" id="hide_uemail_approve" xd="hide_uemail_approve" type="hidden">
										<span id="txt_desc_approve" class="txt-blue" style="margin-left:10px;"></span>
									</div>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="form-inline">
									<button type="button" class="btn btn-success btn-sm" id="btn_submit">
										<span class="glyphicon glyphicon-floppy-save" aria-hidden="true"></span> บันทึก
									</button>
									<input runat="server" id="btn_submit_hidden" xd="btn_submit_hidden" OnServerClick="Submit_ShopStock" type="submit" style="display:none;">
									<span class="txt-gray">กรุณากรอกข้อมูลช่องที่มีเครื่องหมาย <b class="txt-red">*</b> ให้ครบถ้วน</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">

<script type="text/javascript" src="App_Inc/_js/check_required.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/backof_request_new.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/backof_operator.js?v=38"></script>

<script type="text/javascript">
$.datepicker.regional['th'] ={
	dateFormat: 'dd/mm/yy',  
	dayNamesMin: ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส'],   
	monthNames: ['มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม','มิถุนายน','กรกฎาคม','สิงหาคม','กันยายน','ตุลาคม','พฤศจิกายน','ธันวาคม'],
	beforeShow: function() {
		setTimeout(function(){
			$('.ui-datepicker').css('z-index', 999);
		}, 0);
	}
};

$.datepicker.setDefaults($.datepicker.regional['th']);

$(document).ready(function() { 
	setDatePicker();
	getEmpDetail();
	loadSelectShop(_GET('shop_code'));

	$('#page_loading').fadeOut();
});

function setDatePicker() {
	$( "#txt_start_display" ).datepicker( $.datepicker.regional["th"] );
	$( "#txt_end_display" ).datepicker( $.datepicker.regional["th"] );
	$( "#txt_start_close" ).datepicker( $.datepicker.regional["th"] );
	$( "#txt_end_close" ).datepicker( $.datepicker.regional["th"] );

	$('#txt_start_display').datepicker( "option", "minDate", calCuDate(0));
	$('#txt_end_display').datepicker( "option", "minDate", calCuDate(0));

	// $('#txt_start_close').datepicker( "option", "minDate", calCuDate(5));
	// $('#txt_end_close').datepicker( "option", "minDate", calCuDate(5));
	$('#txt_start_close').datepicker( "option", "minDate", calCuDate(0));
	$('#txt_end_close').datepicker( "option", "minDate", calCuDate(0));
}

$('#txt_start_display').datepicker({
	onClose: function(selectedDate, inst) {
		$('input[xd="hide_dx01"]').val(selectedDate);

		if(selectedDate == "")
			$("#txt_end_display").datepicker( "option", "minDate", calCuDate(0));
		else
			$("#txt_end_display").datepicker( "option", "minDate", selectedDate);
	}
});

$('#txt_end_display').datepicker({
	onClose: function(selectedDate, inst) {
		$('input[xd="hide_dx02"]').val(selectedDate);

		$("#txt_start_display").datepicker( "option", "maxDate", selectedDate);
	}
});

$('#txt_start_close').datepicker({
	onClose: function(selectedDate, inst) {
		$('input[xd="hide_dx03"]').val(selectedDate);

		if(selectedDate == "")
			// $("#txt_end_close").datepicker( "option", "minDate", calCuDate(5));
			$("#txt_end_close").datepicker( "option", "minDate", calCuDate(0));
		else
			$("#txt_end_close").datepicker( "option", "minDate", selectedDate);
	}
});

$('#txt_end_close').datepicker({
	onClose: function(selectedDate, inst) {
		$('input[xd="hide_dx04"]').val(selectedDate);

		$("#txt_start_close").datepicker( "option", "maxDate", selectedDate);
	}
});
</script>

</asp:Content>
