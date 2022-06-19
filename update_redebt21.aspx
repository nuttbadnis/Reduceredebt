<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="update_redebt21.aspx.vb" Inherits="update_redebt21" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">

<form action="openprint.aspx" method="post" name="formprint" style="display:none;">
	<input id="print_request_id" name="print_request_id" type="hidden">
	<input runat="server" id="btn_print_hidden" xd="btn_print_hidden" type="submit" value="print">
</form>

<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_uemail_create" xd="hide_uemail_create" type="hidden">
	<input runat="server" id="hide_redebt_cause" xd="hide_redebt_cause" type="hidden">
	<input runat="server" id="hide_redebt_number" xd="hide_redebt_number" type="hidden">
	<input runat="server" id="hide_hide_redebt_file" xd="hide_hide_redebt_file" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden">
	<input runat="server" id="hide_subject_id" xd="hide_subject_id" type="hidden">

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
						<button runat="server" id="btn_modal_after_end" xd="btn_modal_after_end" type="button" class="btn " title="สถานะหลังปิดคำขอ" style="padding: 7px 12px; color: #666;"><span class="glyphicon icon-asterisk"></span></button>
						<button runat="server" id="btn_modal_edit_refund" xd="btn_modal_edit_refund" type="button" class="btn btn-sm btn-danger" style="display:none;"><span class="glyphicon icon-warning"></span> แก้ไขรูปแบบการคืนเงิน</button>
						<button runat="server" id="btn_print" xd="btn_print" type="button" class="btn btn-sm btn-primary"><span class="glyphicon icon-printer"></span> เอกสารยืนยันการอนุมัติ</button>
					</div>
				</div>
				<div class="panel-body" runat="server" id="edit_form" xd="edit_form">
					<div class="form-horizontal">
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">เรื่อง</label>
							<div class="col-sm-10">
								<asp:DropDownList runat="server" id="sel_title" xd="sel_title" class="form-control input-sm width700"></asp:DropDownList>
							</div>
						</div>
						<div class="form-group form-500 required" style="display:none;">
							<div class="col-sm-offset-2 col-sm-10">
								<input runat="server" id="txt_request_title" xd="txt_request_title" type="text" class="form-control input-sm width700" placeholder="เรื่องที่แจ้ง..">
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">สาเหตุที่ต้องการลดหนี้</label>
							<div class="col-sm-10">
								<select runat="server" id="sel_cause" xd="sel_cause" class="form-control input-sm width700">
									<option value="">กรุณาเลือก หัวข้อเรื่องที่แจ้งก่อน</option>
								</select>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">หมายเหตุเพิ่มเติม</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txt_request_remark" xd="txt_request_remark" class="form-control width700" rows="4" placeholder="ถ้ามีหมายเหตุเพิ่มเติมกรอกที่ช่องนี้.."></textarea>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								<label class="radio-inline">ข้อมูลใบเสร็จ</label>
								<label class="radio-inline"><input type="radio" name="rad_search" id="rad_search3" checked>ค้นหาโดยเลขที่ใบเสร็จ BCS</label>
								<label class="radio-inline" style="display:none;"><input type="radio" name="rad_search" id="rad_search1" >ค้นหาโดย Account</label>
								<label class="radio-inline"><input type="radio" name="rad_search" id="rad_search2" >ค้นหาโดยเลขที่ใบเสร็จ POS</label>
							</div>
							<div class="space-br"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">คำค้น</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input type="text" id="txt_search" class="form-control input-sm box-search" placeholder="4-BS-BKKFA-201703-0000999">
										<button type="button" class="btn btn-sm btn-primary" id="btn_account_search" style="display:none;"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> โดย Account</button>
										<button type="button" class="btn btn-sm btn-primary" id="btn_doc_num_search" style="display:none;"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> โดยเลขที่ใบเสร็จ POS</button>
										<button type="button" class="btn btn-sm btn-primary" id="btn_bcs_num_search"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> โดยเลขที่ใบเสร็จ BCS</button>
										<button type="button" class="btn btn-sm btn-default" id="btn_handmade"><span class="glyphicon icon-keyboard" aria-hidden="true"></span> กรอกข้อมูลเอง</button>
										<label class="txt-red" style="display:none;" id="search0">"<span id="dis_search"></span>" ไม่พบผลลัพท์</label>
									</div>
								</div>
							</div>
							<div class="space-br"></div>
							<div class="form-group form-500 required">
								<label class="col-sm-2 control-label">Account</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input runat="server" type="text" id="txt_account_number" xd="txt_account_number" class="form-control input-sm auto-sch" placeholder="640555999" readonly>
										<button class="btn btn-sm count-acc-process" type="button" title="ประวัติการลดหนี้ นับเฉพาะที่ยังไม่ปิดคำขอ">ยังไม่ปิดคำขอ <b class="badge">-</b></button>
										<button class="btn btn-sm count-acc-close" type="button" title="ประวัติการลดหนี้ นับเฉพาะที่ปิดคำขอแล้ว">ปิดคำขอแล้ว <b class="badge">-</b></button>
									</div>
								</div>
							</div>
							<div class="form-group form-500 required">
								<label class="col-sm-2 control-label">ชื่อลูกค้า</label>
								<div class="col-sm-10">
									<input runat="server" type="text" id="txt_account_name" xd="txt_account_name" class="form-control input-sm auto-sch" placeholder="เจษฎา ผลดี" readonly>
								</div>
							</div>
							<div class="form-group form-500 required">
								<label class="col-sm-2 control-label">จำนวนที่ต้องการลดหนี้</label>
								<div class="col-sm-10">
									<div class="input-group">
										<input runat="server" type="text" id="txt_amount" xd="txt_amount" class="form-control input-sm input-addon-bath auto-sch" placeholder="99999.99" onkeypress="return validateFloatKeyPress(this,event);" readonly>
										<div class="input-group-addon addon-w0">บาท</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"></label>
								<input id="hide_max_amount" type="hidden">
								<div class="col-sm-10 txt-gray" id="span_amount" title="ลดหนี้เต็มยอดตามใบเสร็จ"></div>
							</div>
							<div class="form-group" id="div_oth" style="display:none;">
								<div class="col-sm-2"></div>
								<label class="col-sm-10 txt-blue">
									<span class="glyphicon glyphicon-check"></span> ใบเสร็จจากช่องทางอื่นๆ
								</label>
							</div>
							<div class="form-group" id="div_src" style="display:none;">
								<div class="col-sm-2"></div>
								<label class="col-sm-10 txt-blue">
									<span class="glyphicon glyphicon-check"></span> ใบเสร็จขายสด
								</label>
							</div>
							<div class="form-group form-500 required" id="div_pos">
								<label class="col-sm-2 control-label">เลขที่ใบเสร็จ POS</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input runat="server" type="text" id="txt_doc_number" xd="txt_doc_number" class="form-control input-sm auto-sch" placeholder="DOTCV05BKKFA/1703/0555" style="text-transform: uppercase" readonly>
									</div>
								</div>
							</div>
							<div class="form-group form-500 required" id="div_bcs">
								<label class="col-sm-2 control-label">เลขที่ใบเสร็จ BCS</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input runat="server" type="text" id="txt_bcs_number" xd="txt_bcs_number" class="form-control input-sm auto-sch" placeholder="4-BS-BKKFA-201703-0000999" style="text-transform: uppercase" readonly>
									</div>
								</div>
							</div>
							<div class="form-group form-500 required">
								<label class="col-sm-2 control-label">จังหวัดที่ออกใบเสร็จ</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input type="text" id="auto_province_short" class="form-control input-sm box-search auto-sch" placeholder="BKK" readonly>
										<input runat="server" id="hide_province_short" xd="hide_province_short" type="hidden">
										<input runat="server" id="hide_area_ro" xd="hide_area_ro" type="hidden">
										<span class="txt-blue" id="span_area_ro" title="RO ที่ออกใบเสร็จ" style="margin-left: 10px;"></span>
									</div>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500" style="display:none;">
							<label class="col-sm-2 control-label">คำนวณจาก</label>
							<div class="col-sm-10">
								<input runat="server" type="text" id="txt_mx01" xd="txt_mx01" class="form-control input-sm" maxlength="50" placeholder="รอบบิลที่ลูกค้าชำระเกินเข้ามา">
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">วันที่มีผลยกเลิกบริการ</label>
							<div class="col-sm-10">
								<input runat="server" type="text" id="txt_dx02" xd="txt_dx02" class="form-control input-sm datepicker" maxlength="10" placeholder="30/12/2016">
							</div>
						</div>
						<div class="space-br"></div>
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								<div class="form-inline required">
									<label class="radio-inline">รูปแบบการคืนเงิน</label>
									<select id="sel_pick_refund" class="form-control input-sm">
										<option value="">กำลังโหลด..</option>
									</select>
									<input runat="server" id="hide_pick_refund" xd="hide_pick_refund" type="hidden">
								</div>
							</div>
							<div class="space-br"></div>
							<div class="form-group required refund2" style="display:none;">
								<label class="col-sm-2 control-label label-pick-refund2">ที่ Account</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input runat="server" type="text" id="txt_account_number_to" xd="txt_account_number_to" class="form-control input-sm auto-sch_2 box-search">
										<button type="button" class="btn btn-sm btn-primary" id="btn_account_to_search"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> ตรวจสอบ Account</button>
										<label class="txt-red" style="display:none;" id="search0_2">"<span id="dis_search_2"></span>" ไม่พบผลลัพท์</label>
									</div>
								</div>
							</div>
							<div class="form-group form-500 required refund2" style="display:none;">
								<label class="col-sm-2 control-label">ชื่อ</label>
								<div class="col-sm-10">
									<input runat="server" type="text" id="txt_account_name_to" xd="txt_account_name_to" class="form-control input-sm auto-sch_2">
								</div>
							</div>
							<div class="form-group form-500 required refund1" style="display:none;">
								<label class="col-sm-2 control-label label-pick-refund1">ลูกค้าต้องการคืนเงินเป็น</label>
								<div class="col-sm-10">
									<textarea runat="server" type="text" id="txt_tx01" xd="txt_tx01" class="form-control" rows="5" placeholder="กรอกรายละเอียด..">null</textarea>
								</div>
							</div>
							<div class="form-group form-500 refund0">
								<label class="col-sm-2 control-label txt-blue">กรุณาเลือกวิธีการคืนเงิน</label>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">วันที่ลูกค้าขอลดหนี้</label>
							<div class="col-sm-10">
								<input runat="server" type="text" id="txt_dx03" xd="txt_dx03" class="form-control input-sm datepicker" maxlength="10" placeholder="30/12/2016">
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ไฟล์ข้อมูลลูกค้า</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="request_file1" id="request_file1" type="file" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file1"></span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ไฟล์อีเมล์อนุมัติ กรณีพิเศษ (ถ้ามี)</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="request_file2" id="request_file2" type="file" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file2"></span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ไฟล์อื่นๆ</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="request_file3" id="request_file3" type="file" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file3"></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<span class="txt-gray">**กรณีคืนเงินโดยการโยกยอด(ลูกค้าคนละชื่อ) รบกวนแนบเอกสารยินยอมการโยกยอดด้วย</span>
							</div>
						</div>
						<div class="space-br"></div>
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
				<div class="panel-body" runat="server" id="view_form">
					<div class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">เรื่อง:</label>
							<span runat="server" id="inn_request_title" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">สาเหตุที่ต้องการลดหนี้:</label>
							<span runat="server" id="inn_redebt_cause" xd="inn_redebt_cause" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">หมายเหตุเพิ่มเติม:</label>
							<span runat="server" id="inn_request_remark" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Account:</label>
							<span class="col-sm-10 control-label left-label label-padtop-inlinebtn">
								<span runat="server" id="inn_account_number"></span>
								<button class="btn btn-sm count-acc-process" type="button" title="ประวัติการลดหนี้ นับเฉพาะที่ยังไม่ปิดคำขอ">ยังไม่ปิดคำขอ <b class="badge">-</b></button>
								<button class="btn btn-sm count-acc-close" type="button" title="ประวัติการลดหนี้ นับเฉพาะที่ปิดคำขอแล้ว">ปิดคำขอแล้ว <b class="badge">-</b></button>
							</span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ชื่อลูกค้า:</label>
							<span runat="server" id="inn_account_name" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">จำนวนที่ต้องการลดหนี้:</label>
							<span runat="server" id="inn_amount" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">เลขที่ใบเสร็จ POS:</label>
							<span runat="server" id="inn_doc_number" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">เลขที่ใบเสร็จ BCS:</label>
							<span runat="server" id="inn_bcs_number" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">จังหวัดที่ออกใบเสร็จ:</label>
							<div class="col-sm-10 control-label left-label">
								<span id="inn_shop_code"></span> 
								<span id="inn_area_ro"></span>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group" style="display:none;">
							<label class="col-sm-2 control-label">คำนวณจาก:</label>
							<span runat="server" id="inn_mx01" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">วันที่มีผลยกเลิกบริการ:</label>
							<span runat="server" id="inn_dx02" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group txt-recommend">
							<label class="col-sm-2 control-label">รูปแบบการคืนเงิน:</label>
							<span runat="server" class="col-sm-10 control-label left-label label-pick-refund"></span>
						</div>
						<div class="form-group txt-recommend refund2">
							<label class="col-sm-2 control-label label-pick-refund2">ที่ Account:</label>
							<span runat="server" id="inn_account_number_to" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group txt-recommend refund2">
							<label class="col-sm-2 control-label">ชื่อ:</label>
							<span runat="server" id="inn_account_name_to" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group txt-recommend refund1">
							<label class="col-sm-2 control-label label-pick-refund1">รายละเอียด:</label>
							<span runat="server" id="inn_tx01" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">วันที่ลูกค้าขอลดหนี้:</label>
							<span runat="server" id="inn_dx03" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ไฟล์ข้อมูลลูกค้า:</label>
							<span runat="server" id="inn_request_file1" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ไฟล์อีเมล์อนุมัติ กรณีพิเศษ (ถ้ามี):</label>
							<span runat="server" id="inn_request_file2" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ไฟล์อื่นๆ:</label>
							<span runat="server" id="inn_request_file3" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
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
							<label class="col-sm-2 control-label">แก้ไขข้อมูลล่าสุด:</label>
							<div class="col-sm-10 control-label left-label">
								<span runat="server" id="inn_update" xd="inn_update"></span>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="panel panel-default panel-space" runat="server" id="redebt_form">
				<div class="panel-heading panel-fonting">ข้อมูลการลดหนี้</div>
				<div class="panel-body" runat="server" id="edit_redebt">
					<div class="form-horizontal">
						<div class="form-group form-500 required-cn">
							<label class="col-sm-2 control-label">เลขที่ใบลดหนี้</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" id="txt_redebt_number" class="form-control input-sm" placeholder="4-CA-201706-00000555" style="display:none; text-transform: uppercase">
									<select id="sel_redebt_number" class="form-control input-sm">
										<option value="">กรุณาเลือก ใบลดหนี้</option>
									</select>
									<button title="Reload" class="btn btn-primary btn-glyphicon-sm" type="button" id="btn_reload_redebtdoc"><span class="glyphicon glyphicon-refresh"></span></button>
									<span id="redebt_url" class="span-inline"></span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ไฟล์ใบลดหนี้</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="redebt_file" id="redebt_file" type="file" class="form-control input-sm file-10mb">
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="form-inline">
									<button type="button" class="btn btn-success btn-sm" id="btn_submit_redebt">
										<span class="glyphicon glyphicon-floppy-save" aria-hidden="true"></span> บันทึก
									</button>
									<input runat="server" id="btn_submit_redebt_hidden" xd="btn_submit_redebt_hidden" OnServerClick="Redebt_Submit" type="submit" style="display:none;">
									<span class="txt-gray">กรุณาตรวจสอบ และเลือกใบลดหนี้ให้ถูกต้อง ก่อนบันทึก</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-body" runat="server" id="view_redebt">
					<div class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">เลขที่ใบลดหนี้:</label>
							<span id="inn_redebt_number" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ใบลดหนี้:</label>
							<span id="inn_redebt_url" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">เลขที่ E-Pay:</label>
							<span id="inn_rp_no" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">วันที่สร้าง E-Pay:</label>
							<span id="inn_rp_date" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">วันที่อนุมัติ E-Pay:</label>
							<span id="inn_prove_date" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Paid Date E-Pay:</label>
							<span id="inn_pay_date" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Due Date E-Pay:</label>
							<span id="inn_due_date" class="col-sm-10 control-label left-label"></span>
						</div>

						<div class="form-group">
							<div class="col-sm-2"></div>
							<div class="col-sm-10">
								<button type="button" class="btn btn-sm btn-primary" onclick="modalPopLink('<span class=\'glyphicon glyphicon-info-sign\'></span> คำอธิบายวันที่ E-Payment', 'info_epay.aspx')"><span class="glyphicon glyphicon-info-sign"></span> คำอธิบายวันที่ E-Payment</button>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-body" runat="server" id="none_redebt">
					<div class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label txt-gray">รอปิดคำขอ</label>
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

					<b class="txt-red">**ทุกคำขอจะมี "ผู้ตรวจสอบ 1" เป็นหนึ่งใน "ผู้รับผิดชอบร่วม" เสมอ</b>
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
<script type="text/javascript" src="App_Inc/_js/redebt_search_autoinput.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_operator.js?v=38888"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_form.js?v=388"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_pick_refund.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_after_end.js?v=38"></script>

<script type="text/javascript">
$(document).ready(function() { 
	$('[data-toggle="popover"]').popover({html:true, trigger:"hover"}); 

	setDatePicker();
	loadPickRefund();
	loadCheckEditRefund();
	
	count_acc_RQprocess($('input[xd="txt_account_number"]').val());

	loadCause($('select[xd="sel_title"]').val(), $('input[xd="hide_redebt_cause"]').val());
	loadDescApprove();
	loadDescVerify1();
	loadDescVerify2();
	loadRedebtDoc();
	loadAutoBoxShopCode();
	// loadAutoBoxApprove();
	loadAutoBoxCC();
	checkRoDiff();
	checkReceiptOther();
	load3bbShop($('select[xd="sel_create_ro"]').val(), $('input[xd="hide_create_shop"]').val());

	$('[id*=inn_amount]').html( convertAmount( $('[id*=inn_amount]').html() ) + " บาท" );
	
	$('#page_loading').fadeOut();

	$('#btn_handmade').click(function() {
		$('input[xd="txt_doc_number"]').prop('readonly', false);
		$('input[xd="txt_bcs_number"]').prop('readonly', false);
		$('input[xd="txt_account_number"]').prop('readonly', false);
		$('input[xd="txt_account_name"]').prop('readonly', false);
		$('input[xd="txt_amount"]').prop('readonly', false);
		$('input[xd="txt_dx01"]').prop('readonly', false);
		$('#auto_province_short').prop('readonly', false);
	});
});
</script>
</asp:Content>
