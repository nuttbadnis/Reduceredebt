<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="new_invdoc20.aspx.vb" Inherits="new_invdoc20" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">
<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_flow_id" xd="hide_flow_id" type="hidden">
	<input runat="server" id="hide_prefix_id" xd="hide_prefix_id" type="hidden">
	<input runat="server" id="hide_create_ro" xd="hide_create_ro" type="hidden">
	<input runat="server" id="hide_placetype" xd="hide_placetype" type="hidden">
	<input runat="server" id="hide_ctphase" xd="hide_ctphase" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden" value="1">
	<input runat="server" id="hide_can_edit_item" xd="hide_can_edit_item" type="hidden" value="1"> <!-- << invdoc_form by panu -->
	<input runat="server" id="hide_ref_number" xd="hide_ref_number" type="hidden">  <!-- << invdoc_form by panu -->
	<input runat="server" id="hide_combb" xd="hide_combb" type="hidden">  <!-- << invdoc_form by panu -->

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
								<input runat="server" id="txt_request_title" xd="txt_request_title" type="text" style="display:none;">
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
						<%-- <div class="form-group">
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<div class="form-inline">
									<label class="box-search">รายสินค้า</label>
									<label class="box-search">จำนวน/Quantity/ชิ้น</label>
									<label class="box-search">จำนวนเงิน/Amount(รวม Vat)/บาท</label>										
								</div>
							</div>
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" id="tb_listname" xd="tb_itemname" class="form-control input-sm box-search" placeholder="ขายเศษซาก">
									<input type="text" id="tb_quantity" xd="tb_quantity" class="form-control input-sm box-search" placeholder="4">
									<input type="text" id="tb_amount" xd="tb_amount" class="form-control input-sm box-search" placeholder="50,000.00">
									<button id="add_item" type="button" class="btn btn-success btn-sm"><span class="glyphicon glyphicon-plus-sign"></span> เพิ่มรายการ</button>
								</div>
							</div>
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
							</div>
						</div> --%>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">รายละเอียดการขาย<br/>(เพิ่มเติม)</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_request_remark" xd="txt_request_remark" class="form-control input-sm" placeholder="รายละเอียดการขาย(เพิ่มเติม)">
								</div>
							</div>
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<div class="input-group col-md-5">
									<input name="request_file1" id="request_file1" type="file" accept="image/*" onchange="preview_img_files(this);" class="form-control input-sm file-10mb">
									<span class="txt-red">*เฉพาะนามสกุลไฟล์ (jpeg,png,gif)</span>
								</div>
								<div class="input-group col-md-5">
									<img id="view_request_file1" src="#" style="display:none;" />
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
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">หลักฐาน<br/>การชำระเงิน</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_tx02" xd="txt_tx02" class="form-control input-sm" placeholder="โอนเงิน ธ.กรุงเทพ สาขาแจ้งวัฒนะ เลขที่บัญชี 2330481140 วันที่ 16/8/20">
								</div>
							</div>
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-10">
								<div class="input-group col-md-5">
									<input name="request_file2" id="request_file2" type="file" accept="image/*" onchange="preview_img_files(this);" class="form-control input-sm file-10mb">
									<span class="txt-red">*เฉพาะนามสกุลไฟล์ (jpeg,png,gif)</span>
								</div>
								<div class="input-group col-md-5">
									<img id="view_request_file2" src="#" style="display:none;" />
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
								<label class="col-sm-2 control-label">ใบเสนอราคา/<br/>ใบสั่งซื้อ (PO)/สัญญา</label>
								<div class="col-sm-10">
									<input name="request_file3" id="request_file3" type="file" class="form-control input-sm file-10mb">
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ใบรับสินค้า</label>
								<div class="col-sm-10">	
									<input name="request_file4" id="request_file4" type="file" class="form-control input-sm file-10mb">
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">MEMORANDUM พร้อมเมล์อนุมัติจากผู้มีอำนาจ (ถ้ามี)</label>
								<div class="col-sm-10">
									<input name="request_file5" id="request_file5" type="file" class="form-control input-sm file-10mb">
								</div>
							</div>
						</div>

						<!-- invdoc_form by panu { -->
						<div class="space-br"></div>
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								<div class="form-inline">
									<label class="radio-inline">รายการสินค้า</label>
								</div>
							</div>
							<div class="panel-body">
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
							</div>
							<!-- <div class="panel-body">
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
										<label class="col-sm-2 control-label">รายการ/ชื่อสินค้า</label>
										<div class="col-sm-10">
											<input type="text" id="txt_item_name" class="form-control input-sm" placeholder="Fiber Access">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">จำนวน/Quantity</label>
										<div class="col-sm-10">
											<div class="form-inline">
												<div class="input-group">
													<input type="text" id="txt_item_unit_qty" class="form-control input-sm num-only" placeholder="1">
													<div class="input-group-addon addon-w0">ชิ้น</div>
												</div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">ราคาต่อหน่วย/Unit Price (ก่อน Vat)</label>
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
										<label class="col-sm-2 control-label">จำนวนเงิน/Amount (ก่อน Vat)</label>
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
								<b class="txt-red">*ส่วนงาน [Account ตรวจสอบ ข้อมูลแจ้งหนี้] และ [Account ออกเอกสาร แจ้งหนี้] จะเป็นผู้กรอกข้อมูล รหัสบันทึกบัญชี/Account Code</b>
							</div> -->
						</div>
						<!--invdoc_form by panu } -->
						
						<div class="space-br"></div>
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								ผู้ดำเนินการคำขอ
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
<script type="text/javascript" src="App_Inc/_js/ctshop_request_new.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_form.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_form_tam.js?v=40"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_search_autoinput.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_operator.js?v=38"></script>

<!-- invdoc_form by panu { -->
<script type="text/javascript">
	var invdoc_form = "preVat"; //(ก่อน Vat)
</script>
<script type="text/javascript" src="App_Inc/_js/invdoc_form.js?v=39"></script>
<!-- invdoc_form by panu } -->

<script type="text/javascript">
$(document).ready(function() { 
	setDatePicker();
	getEmpDetail();
	
	$('#page_loading').fadeOut();
});
</script>

</asp:Content>
