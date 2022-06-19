<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="update_invdoc25.aspx.vb" Inherits="update_invdoc25" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">

<form action="openprint_invdoc.aspx?pdf=1" method="post" id="formprint1" name="formprint1" target="_blank" style="display:none;">
	<input id="print_pdf1_request_id" name="print_pdf1_request_id" type="hidden">
	<input runat="server" id="btn_print_pdf1_hidden" xd="btn_print_pdf1_hidden" type="submit" value="print">
</form>

<form action="openprint_invdoc.aspx?pdf=2" method="post" id="formprint2" name="formprint2" target="_blank" style="display:none;">
	<input id="print_pdf2_request_id" name="print_pdf2_request_id" type="hidden">
	<input runat="server" id="btn_print_pdf2_hidden" xd="btn_print_pdf2_hidden" type="submit" value="print">
</form>

<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_uemail_create" xd="hide_uemail_create" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden">
	<input runat="server" id="hide_subject_id" xd="hide_subject_id" type="hidden">
	<input runat="server" id="hide_can_edit_item" xd="hide_can_edit_item" type="hidden"> <!-- << invdoc_form by panu -->
	<input runat="server" id="hide_ref_number" xd="hide_ref_number" type="hidden"> <!-- << invdoc_form by panu -->

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
						<button runat="server" id="btn_print_pdf1" xd="btn_print_pdf1" type="button" class="btn btn-sm btn-primary"><span class="glyphicon icon-printer"></span> พิมพ์ใบแจ้งหนี้</button>
						<button runat="server" id="btn_print_pdf2" xd="btn_print_pdf2" type="button" class="btn btn-sm btn-primary"><span class="glyphicon icon-printer"></span> พิมพ์ใบเสร็จ</button>
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
						<div class="form-group required">
							<label class="col-sm-2 control-label">ชื่อลูกค้า/Customer Name</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_customer_name" xd="txt_customer_name" class="form-control input-sm box-search" placeholder="บริษัท เอ็นซีพี 156 จำกัด">
								</div>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">ที่อยู่/Address</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txtar_customer_address" xd="txtar_customer_address" class="form-control width700" rows="4" placeholder="เลขที่ 100 หมู่ 2 ถนนสุรนารายณ์ ตำบลบ้านเกาะ อำเภอเมือง จังหวัดนครราชสีมา 30000"></textarea>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">เลขประจำตัวผู้เสียภาษีอากร/เลขที่บัตรประจำตัวประชาชน</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_customer_idcard" xd="txt_customer_idcard" class="form-control input-sm box-search" maxlength="13" placeholder="305557000434">
								</div>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">สำนักงานใหญ่/สาขา</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_branch" xd="txt_branch" class="form-control input-sm box-search" placeholder="สำนักงานใหญ่">
								</div>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">วันที่ออกใบแจ้งหนี้</label>
							<div class="col-sm-10">
								<input runat="server" type="text" id="txt_invdate" xd="txt_invdate" class="form-control input-sm datepicker" maxlength="10" placeholder="11/11/2020">
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">ครบกำหนดชำระ<br/>(มาตรฐาน 30 วัน)</label>
							<div class="col-sm-10">
								<input runat="server" type="text" id="txt_dx02" xd="txt_dx02" class="form-control input-sm datepicker" maxlength="10" placeholder="30/12/2016">
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">อ้างอิง</label>
							<div class="col-sm-10">
								<div class="input-group col-md-5">
									<input runat="server" type="text" id="txt_tx03" xd="txt_tx03" class="form-control input-sm box-search" placeholder="การอนุมัติขายทรัพย์สินและเศษซาก ประจำภาคกลาง RO.3 ปี 2564">
									 <span class="txt-gray">ใบสั่งซื้อ/สั่งจ้าง,ใบอนุมัติการขายเศษซาก ฯลฯ</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">รายละเอียดการขาย<br/>(เพิ่มเติม)</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_request_remark" xd="txt_request_remark" class="form-control input-sm" placeholder="รายละเอียดการขาย(เพิ่มเติม)">
								</div>
							</div>
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<div class="form-inline">	
									<input name="request_file1" id="request_file1" type="file" accept="image/*" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file1"></span>
								</div>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">รูปแบบการชำระ</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<asp:DropDownList runat="server" id="sel_payment" xd="sel_payment" class="form-control input-sm"></asp:DropDownList>
								</div>
							</div>
						</div>
						<div id="div_bank_title" style="display:none;">
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ธนาคาร</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<asp:DropDownList runat="server" id="sel_bank_title" xd="sel_bank_title" class="form-control input-sm"></asp:DropDownList>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">สาขา</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input runat="server" type="text" id="txt_bank_branch" xd="txt_bank_branch" class="form-control input-sm box-search" placeholder="สาขา">
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">เลขที่เช็ค</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input runat="server" type="text" id="txt_bank_cheque" xd="txt_bank_cheque" class="form-control input-sm box-search" placeholder="00120140430000001">
									</div>
								</div>
							</div>
						</div>
						<div id="div_txt_dx04" class="form-group form-500" style="display:none;">
							<label class="col-sm-2 control-label">ลงวันที่ชำระเงิน</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_dx04" xd="txt_dx04" class="form-control input-sm datepicker" maxlength="10" placeholder="30/12/2016">
								</div>
							</div>
						</div>
						<div class="form-group form-500" style="display: none;">
							<label class="col-sm-2 control-label">หลักฐาน<br/>การชำระเงิน</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_tx02" xd="txt_tx02" class="form-control input-sm" placeholder="โอนเงิน ธ.กรุงเทพ สาขาแจ้งวัฒนะ เลขที่บัญชี 2330481140 วันที่ 16/8/20">
								</div>
							</div>
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<div class="form-inline">	
									<input name="request_file2" id="request_file2" type="file" accept="image/*" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file2"></span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								เอกสารแนบ
							</div>
							<div class="space-br"></div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ใบเสนอราคา/ใบสั่งซื้อ (PO)/สัญญา</label>
								<div class="col-sm-10">
									<div class="form-inline">	
										<input name="request_file3" id="request_file3" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file3"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ใบรับสินค้า</label>
								<div class="col-sm-10">
									<div class="form-inline">		
										<input name="request_file4" id="request_file4" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file4"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">MEMORANDUM พร้อมเมล์อนุมัติจากผู้มีอำนาจ (ถ้ามี)</label>
								<div class="col-sm-10">
									<div class="form-inline">	
										<input name="request_file5" id="request_file5" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file5"></span>
									</div>
								</div>
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
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ชื่อลูกค้า/Customer Name</label>
							<span runat="server" id="inn_customer_name" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ที่อยู่/Address</label>
							<span runat="server" id="inn_customer_address" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">เลขประจำตัวผู้เสียภาษีอากร/เลขที่บัตรประจำตัวประชาชน</label>
							<span runat="server" id="inn_customer_idcard" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">สำนักงานใหญ่/สาขา</label>
							<span runat="server" id="inn_branch" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">วันที่ออกใบแจ้งหนี้</label>
							<span runat="server" id="inn_invdate" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ครบกำหนดชำระ<br/>(มาตรฐาน 30 วัน)</label>
							<span runat="server" id="inn_dx02" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">อ้างอิง ใบสั่งซื้อ/สั่งจ้าง,ใบอนุมัติการขายเศษซาก ฯลฯ</label>
							<span runat="server" id="inn_tx03" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">รายละเอียดการขาย<br/>(เพิ่มเติม)</label>
							<span runat="server" id="inn_request_remark" class="col-sm-5 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ประเภทการชำระเงิน</label>
							<span runat="server" id="inn_payment" class="col-sm-5 control-label left-label"></span>
						</div>
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								เอกสารแนบ
							</div>
						<div class="space-br"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">ใบเสนอราคา/ใบสั่งซื้อ (PO)/สัญญา</label>
								<span runat="server" id="inn_request_file3" class="col-sm-10 control-label left-label"></span>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">ใบรับสินค้า</label>
								<span runat="server" id="inn_request_file4" class="col-sm-10 control-label left-label"></span>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">MEMORANDUM พร้อมเมล์อนุมัติจากผู้มีอำนาจ (ถ้ามี)</label>
								<span runat="server" id="inn_request_file5" class="col-sm-10 control-label left-label"></span>
							</div>
						</div>
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
								<a runat="server" id="a_href_3bbshop" class="btn btn-default btn-sm left-10" role="button" target="_blank" title="ติดต่อสำนักงาน"><span class="glyphicon glyphicon-earphone"></span> <span runat="server" id="inn_create_shop"></span></a>
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

			<!-- invdoc_form preVat by panu { -->
			<div class="panel panel-default panel-space">
				<div class="panel-heading panel-fonting">รายการสินค้า</div>
				<div class="panel-body form-horizontal" runat="server" id="edit_item" xd="edit_item">
					<div id="table_item">กำลังโหลด..<br><br></div>
					<div class="form-group" id="click_add_item" style="display: none;">
						<div class="col-sm-12">
							<button type="button" class="btn btn-warning btn-sm" onclick="showItemInvdoc();">
								<span class="glyphicon icon-plus3" aria-hidden="true"></span> เพิ่มรายการ
							</button>
						</div>
					</div>
					<div id="box_add_item" style="display: none;">
						<hr>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">รายการ/ชื่อสินค้า<b class="txt-red">*</b></label>
							<div class="col-sm-10">
								<input type="text" id="txt_item_name" class="form-control input-sm" placeholder="Fiber Access">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">จำนวน/Quantity<b class="txt-red">*</b></label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group">
										<input type="text" id="txt_item_unit_qty" class="form-control input-sm num-only" placeholder="1">
										<!-- <div class="input-group-addon addon-w0">ชิ้น</div> -->
										<select id="sel_item_unit" class="form-control input-sm">
											<option value="">ชิ้น</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ราคาต่อหน่วย/Unit Price (ก่อน Vat)<b class="txt-red">*</b></label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group">
										<input type="text" id="txt_item_unit_price" class="form-control input-sm num-only" placeholder="9999.99">
										<div class="input-group-addon addon-w0">บาท</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group" style="display: none;">
							<label class="col-sm-2 control-label">จำนวนเงิน/Amount (ก่อน Vat)<b class="txt-red">*</b></label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group">
										<input type="text" id="txt_item_amount" class="form-control input-sm num-only" placeholder="9999.99">
										<div class="input-group-addon addon-w0">บาท</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group" id="div_account_code">
							<label class="col-sm-2 control-label">รหัสบันทึกบัญชี/Account Code</label>
							<div class="col-sm-10">
								<input type="text" id="txt_account_code" class="form-control input-sm box-search" placeholder="654321">
							</div>
						</div>
						<div class="form-group form-500">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="form-inline">
									<input type="hidden" id="hide_item_id">
									<button type="button" class="btn btn-warning btn-sm" onclick="insertItemInvdoc();" id="btn_add_item">
										<span class="glyphicon icon-plus3" aria-hidden="true"></span> เพิ่มรายการ
									</button>
									<button type="button" class="btn btn-success btn-sm" onclick="insertItemInvdoc();" id="btn_update_item">
										<span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span> แก้ไขรายการ
									</button>
									<button type="button" class="btn btn-default btn-sm" onclick="resetBoxAddIem();">
										ยกเลิก
									</button>
								</div>
							</div>
						</div>
					</div>
					<div id="box_edit_total" style="display: none;">
						<hr>
						<div class="form-group">
							<label class="col-sm-2 control-label">ยอดรวม (ก่อน Vat)<b class="txt-red">*</b></label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group">
										<input type="text" id="txt_item_amount_sum" class="form-control input-sm num-only" placeholder="9999.99">
										<div class="input-group-addon addon-w0">บาท</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Vat 7%<b class="txt-red">*</b></label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group">
										<input type="text" id="txt_item_amount_vat" class="form-control input-sm num-only" placeholder="9999.99">
										<div class="input-group-addon addon-w0">บาท</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="form-inline">
									<button type="button" class="btn btn-success btn-sm" onclick="updateItemTotalAmount();" id="btn_edit_total">
										<span class="glyphicon glyphicon-floppy-save" aria-hidden="true"></span> บันทึก
									</button>
									<button type="button" class="btn btn-default btn-sm" onclick="resetBoxEditTotalAmount();">
										ยกเลิก
									</button>
								</div>
							</div>
						</div>
					</div>

					<b class="txt-red">*ส่วนงาน [Account ตรวจสอบ ข้อมูลแจ้งหนี้] และ [Account ออกเอกสาร แจ้งหนี้] เท่านั้น ที่สามารถปรับปรุงรายการสินค้าได้</b>
				</div>
			</div>
			<!--invdoc_form preVat by panu } -->

			<!-- invref_form by panu { -->
			<div class="panel panel-default panel-space" runat="server" id="form_invref">
				<div class="panel-heading panel-fonting">
					<div class="panel-heading-bar form-inline text-right">
						<span class="req-detail">ฟอร์มออกเอกสารแจ้งหนี้</span>
						<button runat="server" id="btn_preview_pdf1" xd="btn_preview_pdf1" type="button" class="btn btn-sm btn-primary"><span class="glyphicon icon-eye3"></span> ตัวอย่างใบแจ้งหนี้</button>
						<button runat="server" id="btn_preview_pdf2" xd="btn_preview_pdf2" type="button" class="btn btn-sm btn-primary"><span class="glyphicon icon-eye3"></span> ตัวอย่างใบเสร็จ</button>
					</div>
				</div>
				<div class="panel-body" runat="server" id="edit_invref">
					<div class="form-horizontal">
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">วันที่รับเงิน</label>
							<div class="col-sm-10">
								<input runat="server" type="text" id="txt_dx03" xd="txt_dx03" class="form-control input-sm datepicker" maxlength="10" placeholder="11/11/2020">
							</div>
						</div>
						<div class="form-group form-500" style="display: none;">
							<label class="col-sm-2 control-label">Ref. Number</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_invref_no" xd="txt_invref_no" class="form-control input-sm box-search" placeholder="Ref. Number">
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="form-inline">
									<button type="button" class="btn btn-success btn-sm" id="btn_submit_invref">
										<span class="glyphicon glyphicon-floppy-save" aria-hidden="true"></span> บันทึก
									</button>
									<input runat="server" id="btn_submit_invref_hidden" xd="btn_submit_invref_hidden" OnServerClick="Invref_Submit" type="submit" style="display:none;">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-body" runat="server" id="view_invref">
					<div class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">วันที่รับเงิน</label>
							<span runat="server" id="inn_dx03" class="col-sm-5 control-label left-label">-</span>
						</div>
					</div>
				</div>
			</div>
			<!-- invref_form by panu } -->

			<!--invfile_form by panu { -->
			<div class="panel panel-default panel-space" runat="server" id="invfile_form">
				<div class="panel-heading panel-fonting">แนบหลักฐานการชำระเงิน</div>
				<div class="panel-body" runat="server" id="edit_invfile" xd="edit_invfile">
					<div class="form-horizontal">
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">หลักฐาน<br/>การชำระเงิน</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_invfile" xd="txt_invfile" class="form-control input-sm" placeholder="โอนเงิน ธ.กรุงเทพ สาขาแจ้งวัฒนะ เลขที่บัญชี 2330481140 วันที่ 16/8/20">
								</div>
							</div>
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<div class="form-inline">	
									<input name="invfile_file" id="invfile_file" type="file" accept="image/*" class="form-control input-sm file-10mb">
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="form-inline">
									<button type="button" class="btn btn-success btn-sm" id="btn_submit_invfile">
										<span class="glyphicon glyphicon-floppy-save" aria-hidden="true"></span> บันทึก
									</button>
									<button type="button" class="btn btn-danger btn-sm" id="btn_invfile_cancle">
										<span class="glyphicon glyphicon-remove" aria-hidden="true"></span> ยกเลิกคำขอ
									</button>
									<input runat="server" id="btn_submit_invfile_hidden" xd="btn_submit_invfile_hidden" OnServerClick="Invfile_Submit" type="submit" style="display:none;">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-body" runat="server" id="view_invfile">
					<div class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">หลักฐาน<br/>การชำระเงิน</label>
							<span runat="server" id="inn_tx02" class="col-sm-5 control-label left-label">-</span>
						</div>
					</div>
				</div>
				<div class="panel-body" runat="server" id="none_invfile">
					<div class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label txt-gray">รอปิดคำขอ</label>
						</div>
					</div>
				</div>
			</div>
			<!--invfile_form by panu } -->

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
<script type="text/javascript" src="App_Inc/_js/redebt_operator.js?v=388"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_form.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_pick_refund.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/redebt_after_end.js?v=38"></script>

<!-- invdoc_form by panu { -->
<script type="text/javascript">
	var invdoc_form = "preVat"; //(ก่อน Vat)
</script>
<script type="text/javascript" src="App_Inc/_js/invdoc_form.js?v=39"></script>
<!-- invdoc_form by panu } -->

<script type="text/javascript">
$(document).ready(function() { 
	$('[rel="pop_kaysod"]').popover({html:true}); 

	setDatePicker();
	loadPickRefund();
	loadCheckEditRefund();
	loadpayment();	
	//count_acc_RQprocess($('input[xd="txt_account_number"]').val());

	//loadCause($('select[xd="sel_title"]').val(), $('input[xd="hide_redebt_cause"]').val());
	loadDescApprove();
	loadDescVerify1();
	loadDescVerify2();
	//loadAutoBoxShopCode();
	//loadAutoBoxApprove();
	//checkRoDiff();
	checkReceiptOther();
	load3bbShop($('select[xd="sel_create_ro"]').val(), $('input[xd="hide_create_shop"]').val());

	checkOnloadForm20();

	$('[id*=inn_amount]').html( convertAmount( $('[id*=inn_amount]').html() ) + " บาท" );

	$('#page_loading').fadeOut();
});

$('#redebt_file').click(function(){
    $('.popover').hide();
});



</script>

<style type="text/css">
.popover {
	max-width: 500px;
}
</style>
</asp:Content>
