<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="new_redebt22.aspx.vb" Inherits="new_redebt22" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">
<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_flow_id" xd="hide_flow_id" type="hidden">
	<input runat="server" id="hide_prefix_id" xd="hide_prefix_id" type="hidden">
	<input runat="server" id="hide_redebt_cause" xd="hide_redebt_cause" type="hidden">
	<input runat="server" id="hide_create_ro" xd="hide_create_ro" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden" value="1">
	<input runat="server" id="hide_subject_id" xd="hide_subject_id" type="hidden">

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
									<input runat="server" type="text" id="txt_doc_number" xd="txt_doc_number" class="form-control input-sm auto-sch" placeholder="DOTCV05BKKFA/1703/0555" style="text-transform: uppercase" readonly>
								</div>
							</div>
							<div class="form-group form-500 required" id="div_bcs">
								<label class="col-sm-2 control-label">เลขที่ใบเสร็จ BCS</label>
								<div class="col-sm-10">
									<input runat="server" type="text" id="txt_bcs_number" xd="txt_bcs_number" class="form-control input-sm auto-sch" placeholder="4-BS-BKKFA-201703-0000999" style="text-transform: uppercase" readonly>
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
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">วันที่ลูกค้าขอลดหนี้</label>
							<div class="col-sm-10">
								<input runat="server" type="text" id="txt_dx03" xd="txt_dx03" class="form-control input-sm datepicker" maxlength="10" placeholder="30/12/2016">
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
										<input runat="server" type="text" id="txt_account_number_to" xd="txt_account_number_to" class="form-control input-sm auto-sch_2 box-search" placeholder="640555999">
										<button type="button" class="btn btn-sm btn-primary" id="btn_account_to_search"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> ตรวจสอบ Account</button>
										<label class="txt-red" style="display:none;" id="search0_2">"<span id="dis_search_2"></span>" ไม่พบผลลัพท์</label>
									</div>
								</div>
							</div>
							<div class="form-group form-500 required refund2" style="display:none;">
								<label class="col-sm-2 control-label">ชื่อลูกค้า</label>
								<div class="col-sm-10">
									<input runat="server" type="text" id="txt_account_name_to" xd="txt_account_name_to" class="form-control input-sm auto-sch_2" placeholder="เจษฎา ผลดี">
								</div>
							</div>
							<div class="form-group form-500 required refund1" style="display:none;">
								<label class="col-sm-2 control-label label-pick-refund1">ลูกค้าต้องการคืนเงินเป็น</label>
								<div class="col-sm-10">
									<textarea runat="server" type="text" id="txt_tx01" xd="txt_tx01" class="form-control" rows="2" placeholder="กรอกรายละเอียด..">null</textarea>
								</div>
							</div>
							<div class="form-group form-500 refund3" style="display:none;">
								<label class="col-sm-2 control-label">ธนาคาร</label>
								<div class="col-sm-10">
									<select id="sel_bank_code" class="form-control input-sm">
										<option value="0">เลือกธนาคาร</option>
									</select>
									<input runat="server" id="hide_bank_code" xd="hide_bank_code" type="hidden" value="0">
								</div>
							</div>
							<div class="form-group form-500 refund3" style="display:none;">
								<label class="col-sm-2 control-label">รหัสสาขาธนาคาร</label>
								<div class="col-sm-10">
									<input runat="server" type="text" id="txt_fx01" xd="txt_fx01" class="form-control input-sm" maxlength="10" placeholder="0123" onkeypress="return isNumberAndDash(event);" onpaste="return false;">
								</div>
							</div>
							<div class="form-group form-500 refund3" style="display:none;">
								<label class="col-sm-2 control-label">เลขที่บัญชี</label>
								<div class="col-sm-10">
									<input runat="server" type="text" id="txt_fx02" xd="txt_fx02" class="form-control input-sm" maxlength="20" placeholder="689-01234-5" onkeypress="return isNumberAndDash(event);" onpaste="return false;">
								</div>
							</div>
							<div class="form-group form-500 refund3" style="display:none;">
								<label class="col-sm-2 control-label">ชื่อบัญชี</label>
								<div class="col-sm-10">
									<input runat="server" type="text" id="txt_mx03" xd="txt_mx03" class="form-control input-sm" maxlength="255" placeholder="คุณ ลูกค้า สกุลดี">
								</div>
							</div>
							<div class="form-group refund3" style="display:none;">
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-10">
									<span class="txt-gray">**กรุณาตรวจสอบข้อมูลบัญชีธนาคารให้ถูกต้อง รหัสสาขาธนาคาร และเลขที่บัญชี ต้องเป็นตัวเลขและขีดเท่านั้น</span>
								</div>
							</div>
							<div class="form-group form-500 refund0">
								<label class="col-sm-2 control-label txt-blue">กรุณาเลือกวิธีการคืนเงิน</label>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								<label class="radio-inline">ข้อมูลใบรับคืนอุปกรณ์และ ใบรับคืน Adapter</label>
							</div>
							<div class="space-br"></div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ประเภทใบรับคืน</label>
								<div class="col-sm-10">
									<label class="radio-inline"><input type="radio" name="rad_redoc" id="rad_redoc0">รับอุปกรณ์และ Adapter จาก Account เดียวกัน</label>
									<label class="radio-inline"><input type="radio" name="rad_redoc" id="rad_redoc1">รับอุปกรณ์และ Adapter ต่าง Account</label>
									<input runat="server" id="hide_redoc_type" xd="hide_redoc_type" type="hidden">
								</div>
							</div>
							<div class="space-br"></div>
							<div id="div_redoc_account_to" style="display: none;">
								<div class="form-group">
									<label class="col-sm-2 control-label">ขอใบรับคืนต่าง Account</label>
									<div class="col-sm-10">
										<div class="form-inline">
											<input runat="server" type="text" id="txt_redoc_account_number_to" xd="txt_redoc_account_number_to" class="form-control input-sm auto-redoc_2 box-search" placeholder="640555999">
											<button type="button" class="btn btn-sm btn-primary" id="btn_account_redoc_search"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> ตรวจสอบ Account</button>
											<label class="txt-red" style="display:none;" id="search0_redoc">"<span id="dis_search_redoc"></span>" ไม่พบผลลัพท์</label>
										</div>
									</div>
								</div>
								<div class="form-group form-500">
									<label class="col-sm-2 control-label">ชื่อลูกค้า</label>
									<div class="col-sm-10">
										<input runat="server" type="text" id="txt_redoc_account_name_to" xd="txt_redoc_account_name_to" class="form-control input-sm auto-redoc" placeholder="เจษฎา ผลดี" readonly>
									</div>
								</div>
								<div class="form-group form-500">
									<label class="col-sm-2 control-label">สาเหตุใบรับคืนต่าง Account</label>
									<div class="col-sm-10">
										<textarea runat="server" type="text" id="txt_redoc_remark" xd="txt_redoc_remark" class="form-control" rows="2" maxlength="500" placeholder="ระบุสาเหตุใบรับคืนต่าง Account.."></textarea>
									</div>
								</div>
								<div class="space-br"></div>
							</div>
							<div class="form-group form-500 required">
								<label class="col-sm-2 control-label">เลขที่ใบรับคืนอุปกรณ์</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<select id="sel_redoc_no_item" class="form-control input-sm">
											<option value="">กรุณาเลือก ประเภทใบรับคืน และระบุ Account ก่อน</option>
										</select>
										<input runat="server" id="hide_redoc_no_item" xd="hide_redoc_no_item" type="hidden">

										<button class="btn btn-sm count-redoc-item-process" type="button" title="ประวัติใบรับคืน นับเฉพาะที่ยังไม่ปิดคำขอ">ยังไม่ปิดคำขอ <b class="badge">-</b></button>
										<button class="btn btn-sm count-redoc-item-close" type="button" title="ประวัติใบรับคืน นับเฉพาะที่ปิดคำขอแล้ว">ปิดคำขอแล้ว <b class="badge">-</b></button>
									</div>
								</div>
							</div>
							<div class="form-group form-500 required" id="div_sel_adapter">
								<label class="col-sm-2 control-label">เลขที่ใบรับคืน Adapter</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<select id="sel_redoc_no_adapter" class="form-control input-sm">
											<option value="">กรุณาเลือก ประเภทใบรับคืน และระบุ Account ก่อน</option>
										</select>
										<input runat="server" id="hide_redoc_no_adapter" xd="hide_redoc_no_adapter" type="hidden">

										<button class="btn btn-sm count-redoc-adap-process" type="button" title="ประวัติใบรับคืน นับเฉพาะที่ยังไม่ปิดคำขอ">ยังไม่ปิดคำขอ <b class="badge">-</b></button>
										<button class="btn btn-sm count-redoc-adap-close" type="button" title="ประวัติใบรับคืน นับเฉพาะที่ปิดคำขอแล้ว">ปิดคำขอแล้ว <b class="badge">-</b></button>
									</div>
								</div>
							</div>
							<div class="form-group form-500" style="display: none;">
								<label class="col-sm-2 control-label">ไฟล์ใบรับคืนอุปกรณ์</label>
								<div class="col-sm-10">
									<input name="request_file4" id="request_file4" type="file" class="form-control input-sm file-10mb">
								</div>
							</div>
							<div class="form-group form-500" id="div_file_adapter" style="display: none;">
								<!-- <label class="col-sm-2 control-label">ไฟล์ใบรับคืน Adapter / ใบเสร็จค่าปรับ</label> -->
								<label class="col-sm-2 control-label">ไฟล์ใบเสร็จค่าปรับ</label>
								<div class="col-sm-10">
									<input name="request_file5" id="request_file5" type="file" class="form-control input-sm file-10mb">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-10">
									<span class="txt-gray">**หากมีการแก้ไขข้อมูลใบเสร็จ (Account) จะต้องกรอกข้อมูลใบรับคืนอุปกรณ์ใหม่เสมอ</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ไฟล์ข้อมูลลูกค้า</label>
							<div class="col-sm-10">
								<input name="request_file1" id="request_file1" type="file" class="form-control input-sm file-10mb">
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ไฟล์อีเมล์อนุมัติ กรณีพิเศษ (ถ้ามี)</label>
							<div class="col-sm-10">
								<input name="request_file2" id="request_file2" type="file" class="form-control input-sm file-10mb">
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ไฟล์อื่นๆ</label>
							<div class="col-sm-10">
								<input name="request_file3" id="request_file3" type="file" class="form-control input-sm file-10mb">
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
								<label class="col-sm-2 control-label">ผู้ตรวจสอบ 1</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input type="text" id="auto_verify1" class="form-control input-sm box-search" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
										<input runat="server" id="hide_uemail_verify1" xd="hide_uemail_verify1" type="hidden">
										<span id="txt_desc_verify1" class="txt-blue" style="margin-left:10px;"></span>
									</div>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label">ผู้ตรวจสอบ 2</label>
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
								<label class="col-sm-2 control-label">ผู้อนุมัติ</label>
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
<script type="text/javascript" src="App_Inc/_js/request_new.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_search_autoinput.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_operator.js?v=38888"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_pick_refund.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_search_redoc.js?v=38"></script>

<script type="text/javascript">
$(document).ready(function() { 
	setDatePicker();
	getEmpDetail();
	loadPickRefund();

	$('#page_loading').fadeOut();
});
</script>

</asp:Content>
