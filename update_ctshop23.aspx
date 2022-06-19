<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="update_ctshop23.aspx.vb" Inherits="update_ctshop23" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">

<form action="openprint_ctshop.aspx" method="post" name="formprint" style="display:none;">
	<input id="print_request_id" name="print_request_id" type="hidden">
	<input runat="server" id="btn_print_hidden" xd="btn_print_hidden" type="submit" value="print">
</form>

<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_uemail_create" xd="hide_uemail_create" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden">
	<input runat="server" id="hide_subject_id" xd="hide_subject_id" type="hidden">
	<input runat="server" id="hide_page_url" xd="hide_page_url" type="hidden">
	<input runat="server" id="hide_min_cost" xd="hide_min_cost" type="hidden">
	<input runat="server" id="hide_max_cost" xd="hide_max_cost" type="hidden">

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
						<button runat="server" id="btn_print" xd="btn_print" type="button" class="btn btn-sm btn-primary"><span class="glyphicon icon-printer"></span> เอกสารยืนยันการอนุมัติ</button>
					</div>
				</div>
				<div class="panel-body" runat="server" id="edit_form" xd="edit_form">
					<div class="form-horizontal">
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">เรื่อง</label>
							<div class="col-sm-10">
								<asp:DropDownList runat="server" id="sel_title" xd="sel_title" class="form-control input-sm width700"></asp:DropDownList>
								<input runat="server" id="txt_request_title" xd="txt_request_title" type="text" style="display:none;">
							</div>
						</div>
						<%-- <div class="form-group form-500 required">
							<label class="col-sm-2 control-label">รายละเอียดเพิ่มเติม</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txtar_request_remark" xd="txtar_request_remark" class="form-control width700" rows="4" placeholder="ถ้ามีรายละเอียดเพิ่มเติมกรอกที่ช่องนี้.."></textarea>
							</div>
						</div> --%>
						<div class="space-br"></div>
						<%-- <div class="form-group required">
							<label class="col-sm-2 control-label">รหัสสาขา</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" id="auto_shop_code" class="form-control input-sm box-search auto-sch" placeholder="ค้นหาอัตโนมัติโดย รหัสสาขา, ชื่อ หรือที่อยู่">
									<input runat="server" id="hide_shop_code" xd="hide_shop_code" type="hidden">
								</div>
							</div>
						</div> --%>
						<div class="form-group required">
							<label class="col-sm-2 control-label">จังหวัด</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" id="auto_province_short" class="form-control input-sm box-search auto-sch" placeholder="ค้นหาอัตโนมัติโดย ชื่อเขตพื้นที่, Cluster">
									<input runat="server" id="hide_province_short" xd="hide_province_short" type="hidden">
								</div>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">Cluster</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_cluster" xd="txt_cluster" class="form-control input-sm box-search" placeholder="RC1-CBI" readonly>
								</div>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">เขตพื้นที่ (RO)</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_area_ro" xd="txt_area_ro" class="form-control input-sm box-search" placeholder="01" readonly>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">ประเภทศูนย์บริการ</label>
							<div class="col-sm-10">
								<asp:DropDownList runat="server" id="sel_placetype" xd="sel_placetype" class="form-control input-sm"></asp:DropDownList>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">ตำแหน่งที่ตั้งปัจจุบัน</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txtar_location" xd="txtar_location" class="form-control width700" rows="4" placeholder="ถ้ามีรายละเอียดเพิ่มเติมกรอกที่ช่องนี้.."></textarea>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">ตำแหน่งที่ตั้งใหม่</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txtar_newlocation" xd="txtar_newlocation" class="form-control width700" rows="4" placeholder="ถ้ามีรายละเอียดเพิ่มเติมกรอกที่ช่องนี้.."></textarea>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ภาพสถานที่เช่าใหม่</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="request_file3" id="request_file3" type="file" style="display:none;">
									<input name="request_file4" id="request_file4" type="file" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file4"></span>
									<input name="request_file5" id="request_file5" type="file" style="display:none;">
								</div>
							</div>
						</div>

						<div class="space-br"></div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">ระยะสัญญา</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group col-md-6">
										<asp:DropDownList runat="server" id="sel_ctphase" xd="sel_ctphase" class="form-control input-sm box-search"></asp:DropDownList>
										<span class="txt-red">*หากเลือก อื่นๆ กรุณากรอกรายละเอียดระยะสัญญา ในช่องระบุระยะสัญญา</span>
									</div>
									<div id="div_ctphase_remark" class="input-group" style="display:none;padding-bottom: 17px;">
										<span class="input-group-addon txt-bold">ระบุระยะสัญญา</span>
										<input runat="server" type="text" class="form-control" maxlength="255" placeholder="1 เดือนครึ่ง" id="txt_ctphase_remark">
									</div>
								</div>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">อัตราการปรับค่าเช่า</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group">
										<!-- txt_uprent_rate = txt_ax04 -->
										<input runat="server" type="text" id="txt_uprent_rate" xd="txt_uprent_rate" class="form-control input-sm num-only input-addon-percent" placeholder="99.99">
										<div class="input-group-addon addon-w0">%</div>
									</div>
									<div class="input-group">
										<span class="input-group-addon">
											<input type="checkbox" id="chk_uprent_rate"> 
										</span>
										<span class="input-group-addon txt-blue">คงเดิม</span>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">ค่าเช่า</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_amount" xd="txt_amount" class="form-control input-sm input-addon-bath-nvat" placeholder="99999.99">
									<div class="input-group-addon addon-w0">บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">ค่าบริการ</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax05" xd="txt_ax05" class="form-control input-sm num-only input-addon-bath-nvat" placeholder="99999.99">
									<div class="input-group-addon addon-w0">บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ค่าบริการพื้นที่ส่วนกลาง</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax06" xd="txt_ax06" class="form-control input-sm num-only input-addon-bath-nvat" placeholder="99999.99">
									<div class="input-group-addon addon-w0">บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">ค่าเช่ารวมค่าบริการ</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax07" xd="txt_ax07" class="form-control input-sm num-only input-addon-bath-nvat" placeholder="99999.99" readonly>
									<div class="input-group-addon addon-w0">บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>

						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าบริการไอเย็น</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax08" xd="txt_ax08" class="form-control input-sm num-only input-addon-bath-nvat" placeholder="999.99">
									<div class="input-group-addon addon-w0">บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ภาษีโรงเรือน</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax09" xd="txt_ax09" class="form-control input-sm num-only input-addon-bath-nvat" placeholder="999.99">
									<div class="input-group-addon addon-w0">บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ภาษีโรงเรือนและที่ดิน</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax10" xd="txt_ax10" class="form-control input-sm num-only input-addon-bath-nvat" placeholder="999.99">
									<div class="input-group-addon addon-w0">บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าเบี้ยประกันวินาศภัย</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax11" xd="txt_ax11" class="form-control input-sm num-only input-addon-bath-ea" placeholder="999.99">
									<div class="input-group-addon addon-w0">บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าอากรแสตมป์</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax12" xd="txt_ax12" class="form-control input-sm num-only input-addon-bath-2" placeholder="99.99">
									<div class="input-group-addon addon-w0">บาท (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>

						<div class="space-br"></div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">ค่าไฟฟ้า</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group">
										<input runat="server" type="text" id="txt_ax13" xd="txt_ax13" class="form-control input-sm num-only input-addon-bath-ea" placeholder="99.99">
										<%-- <input runat="server" id="hide_elecharge_unit" xd="hide_elecharge_unit" type="hidden" value="บาท/เดือน"> --%>
										<div id="ea_ax13" class="input-group-addon addon-w0">บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
									</div>
									<div class="input-group">
										<span class="input-group-addon">
											<input type="checkbox" id="chk_ax13"> 
										</span>
										<span class="input-group-addon txt-blue">เหมาจ่าย</span>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าน้ำประปา</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax14" xd="txt_ax14" class="form-control input-sm num-only input-addon-bath-ea" placeholder="99.99">
									<div class="input-group-addon addon-w0">บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">งบประมาณทั้งหมดตลอดระยะสัญญา</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_gx01" xd="txt_gx01" class="form-control input-sm num-only input-addon-bath-2" placeholder="99.99" readonly>
									<div class="input-group-addon addon-w0">บาท (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">เอกสารใบแจ้งต่อสัญญา</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="request_file1" id="request_file1" type="file" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file1"></span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">สัญญาเช่าเดิม<br>(กรณีอาคารพาณิชย์)</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="request_file2" id="request_file2" type="file" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file2"></span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								ยอดชำระเงิน (Bill payment) และยอยขาย ย้อนหลัง 3 เดือนล่าสุด
							</div>
							<div class="space-br"></div>
							<div class="form-group required">
								<label class="col-sm-2 control-label">เดือนที่ 1</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<div class="input-group">
											<input runat="server" type="text" id="txt_ax01" xd="txt_ax01" class="form-control input-sm num-only input-addon-bath-2" placeholder="99.99">
											<div class="input-group-addon addon-w0">บาท</div>
										</div>
										<div class="input-group">
											<input runat="server" type="text" id="txt_nx01" xd="txt_nx01" class="form-control input-sm int-only input-addon-port" placeholder="99999">
											<div class="input-group-addon addon-w0">port</div>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label">เดือนที่ 2</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<div class="input-group">
											<input runat="server" type="text" id="txt_ax02" xd="txt_ax02" class="form-control input-sm num-only input-addon-bath-2" placeholder="99.99">
											<div class="input-group-addon addon-w0">บาท</div>
										</div>
										<div class="input-group">
											<input runat="server" type="text" id="txt_nx02" xd="txt_nx02" class="form-control input-sm int-only input-addon-port" placeholder="99999">
											<div class="input-group-addon addon-w0">port</div>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label">เดือนที่ 3</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<div class="input-group">
											<input runat="server" type="text" id="txt_ax03" xd="txt_ax03" class="form-control input-sm num-only input-addon-bath-2" placeholder="99.99">
											<div class="input-group-addon addon-w0">บาท</div>
										</div>
										<div class="input-group">
											<input runat="server" type="text" id="txt_nx03" xd="txt_nx03" class="form-control input-sm int-only input-addon-port" placeholder="99999">
											<div class="input-group-addon addon-w0">port</div>
										</div>
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
							<div class="space-br"></div>
							<div class="form-group form-500 required">
								<label class="col-sm-2 control-label">ผู้ตรวจสอบ 1</label>
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
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ผู้ตรวจสอบ 2</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<div class="input-group approve-readonly">
											<input runat="server" type="text" id="txt_uemail_verify2" xd="txt_uemail_verify2" class="form-control input-sm input-addon-email" disabled>
											<div class="input-group-addon">@jasmine.com</div>
										</div>
										<input type="text" id="auto_verify2" class="form-control input-sm box-search approve-edit" style="display:none;" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
										<input runat="server" id="hide_uemail_verify2" xd="hide_uemail_verify2" type="hidden">
										<span id="txt_desc_verify2" class="txt-desc-verify2 txt-blue" style="margin-left:10px;"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500 required">
								<label class="col-sm-2 control-label">ผู้อนุมัติ</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<div class="input-group approve-readonly">
											<input runat="server" type="text" id="txt_uemail_approve" xd="txt_uemail_approve" class="form-control input-sm input-addon-email" disabled>
											<div class="input-group-addon">@jasmine.com</div>
										</div>
										<input type="text" id="auto_approve" class="form-control input-sm box-search approve-edit" style="display:none;" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
										<input runat="server" id="hide_uemail_approve" xd="hide_uemail_approve" type="hidden">
										<span id="txt_desc_approve" class="txt-desc-approve txt-blue" style="margin-left:10px;"></span>
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
									<button type="button" class="btn btn-success btn-sm" id="btn_ctshop_submit">
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
						<%-- <div class="form-group">
							<label class="col-sm-2 control-label">หมายเหตุเพิ่มเติม:</label>
							<span runat="server" id="inn_request_remark" class="col-sm-10 control-label left-label"></span>
						</div> --%>
						<div class="space-br"></div>
						<%-- <div class="form-group">
							<label class="col-sm-2 control-label">รหัสสาขา:</label>
							<div class="col-sm-10 control-label left-label">
								<span id="inn_shop_code"></span> 
							</div>
						</div> --%>
						<div class="form-group">
							<label class="col-sm-2 control-label">จังหวัด:</label>
							<div class="col-sm-10 control-label left-label">
								<span id="inn_province_short"></span> 
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Cluster:</label>
							<span runat="server" id="inn_cluster" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">เขตพื้นที่ (RO):</label>
							<span runat="server" id="inn_area_ro" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ประเภทศูนย์บริการ:</label>
							<div class="col-sm-10 control-label left-label">
								<span id="inn_placetype"></span> 
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ตำแหน่งที่ตั้งปัจจุบัน:</label>
							<span runat="server" id="inn_tx01" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ตำแหน่งที่ตั้งใหม่:</label>
							<span runat="server" id="inn_tx02" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ภาพสถานที่เช่าใหม่:</label>
							<span runat="server" id="inn_request_file4" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ระยะสัญญา:</label>
							<div class="col-sm-10 control-label left-label">
								<span id="inn_ctphase"></span>
								<span id="inn_ctphase_remark"></span>  
							</div>
						</div>
						<div class="form-group txt-recommend">
							<label class="col-sm-2 control-label">อัตราการปรับค่าเช่า:</label>
							<span runat="server" id="inn_uprent_rate" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group txt-recommend">
							<label class="col-sm-2 control-label">ค่าเช่า:</label>
							<span runat="server" id="inn_amount" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าบริการ:</label>
							<span runat="server" id="inn_ax05" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าบริการพื้นที่ส่วนกลาง:</label>
							<span runat="server" id="inn_ax06" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าเช่ารวมค่าบริการ:</label>
							<span runat="server" id="inn_ax07" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าบริการไอเย็น:</label>
							<span runat="server" id="inn_ax08" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ภาษีโรงเรือน:</label>
							<span runat="server" id="inn_ax09" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ภาษีโรงเรือนและที่ดิน:</label>
							<span runat="server" id="inn_ax10" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าเบี้ยประกันวินาศภัย:</label>
							<span runat="server" id="inn_ax11" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าอากรแสตมป์:</label>
							<span runat="server" id="inn_ax12" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าไฟฟ้า:</label>
							<span runat="server" id="inn_ax13" class="col-sm-10 control-label left-label"></span> 
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่าน้ำประปา:</label>
							<span runat="server" id="inn_ax14" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">งบประมาณทั้งหมดตลอดระยะสัญญา:</label>
							<span runat="server" id="inn_gx01" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">เอกสารใบแจ้งต่อสัญญา:</label>
							<span runat="server" id="inn_request_file1" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">สัญญาเช่าเดิม<br>(กรณีอาคารพาณิชย์):</label>
							<span runat="server" id="inn_request_file2" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="panel panel-default">
							<div class="panel-heading panel-fonting">
								ยอดชำระเงิน (Bill payment) และยอยขาย ย้อนหลัง 3 เดือนล่าสุด
							</div>
							<div class="space-br"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">เดือนที่ 1:</label>
								<div class="col-sm-10 control-label left-label">
									<span runat="server" id="inn_ax01"></span>
									<span runat="server" id="inn_nx01" style="padding-left: 20px;"></span> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">เดือนที่ 2</label>
								<div class="col-sm-10 control-label left-label">
									<span runat="server" id="inn_ax02"></span>
									<span runat="server" id="inn_nx02" style="padding-left: 20px;"></span> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">เดือนที่ 3</label>
								<div class="col-sm-10 control-label left-label">
									<span runat="server" id="inn_ax03"></span>
									<span runat="server" id="inn_nx03" style="padding-left: 20px;"></span> 
								</div>
							</div>
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
							<label class="col-sm-2 control-label">ผู้ตรวจสอบ 1:</label>
							<div class="col-sm-10 control-label left-label">
								<span runat="server" id="inn_uemail_verify1" xd="inn_uemail_verify1"></span>
								<span class="txt-desc-verify1 txt-blue" style="margin-left:10px;"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ผู้ตรวจสอบ 2:</label>
							<div class="col-sm-10 control-label left-label">
								<span runat="server" id="inn_uemail_verify2" xd="inn_uemail_verify2"></span>
								<span class="txt-desc-verify2 txt-blue" style="margin-left:10px;"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ผู้อนุมัติ:</label>
							<div class="col-sm-10 control-label left-label">
								<span runat="server" id="inn_uemail_approve" xd="inn_uemail_approve"></span>
								<span class="txt-desc-approve txt-blue" style="margin-left:10px;"></span>
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
<script type="text/javascript" src="App_Inc/_js/request_update.js?v=39"></script>
<script type="text/javascript" src="App_Inc/_js/flow_submit.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_search_autoinput.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_operator.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_form.js?v=39"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_form_tam.js?v=38"></script>

<script type="text/javascript">
$(document).ready(function() { 
	setDatePicker();

	load_ctphase_remark();
	loadDescApprove();
	loadDescVerify1();
	loadDescVerify2();
	loadAutoBoxShopCode();
	loadAutoBoxProvShort();
	loadAutoBoxApprove();
	load3bbShop($('select[xd="sel_create_ro"]').val(), $('input[xd="hide_create_shop"]').val());

	//AutoElechargeUnit();

	$('#inn_placetype').html($("select[xd='sel_placetype'] option:selected").html());
	$('#inn_ctphase').html($("select[xd='sel_ctphase'] option:selected").html());

	$('[id*=inn_uprent_rate]').html(convertUprentPercent($('[id*=inn_uprent_rate]').html()));

	$('[id*=inn_amount]').html(convertAmount($('[id*=inn_amount]').html()) + " บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_ax05]').html(convertAmount($('[id*=inn_ax05]').html()) + " บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_ax06]').html(convertAmount($('[id*=inn_ax06]').html()) + " บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_ax07]').html(convertAmount($('[id*=inn_ax07]').html()) + " บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_ax08]').html(convertAmount($('[id*=inn_ax08]').html()) + " บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_ax09]').html(convertAmount($('[id*=inn_ax09]').html()) + " บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_ax10]').html(convertAmount($('[id*=inn_ax10]').html()) + " บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_ax11]').html(convertAmount($('[id*=inn_ax11]').html()) + " บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_ax12]').html(convertAmount($('[id*=inn_ax12]').html()) + " บาท (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_ax13]').html(convertAmount($('[id*=inn_ax13]').html()) + " บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_ax14]').html(convertAmount($('[id*=inn_ax14]').html()) + " บาท/เดือน (ยอดรวมภาษีมูลค่าเพิ่ม)");
	$('[id*=inn_gx01]').html(convertAmount($('[id*=inn_gx01]').html()) + " บาท (ยอดรวมภาษีมูลค่าเพิ่ม)");

	$('[id*=inn_ax01]').html(convertAmount($('[id*=inn_ax01]').html()) + " บาท");
	$('[id*=inn_ax02]').html(convertAmount($('[id*=inn_ax02]').html()) + " บาท");
	$('[id*=inn_ax03]').html(convertAmount($('[id*=inn_ax03]').html()) + " บาท");
	$('[id*=inn_nx01]').html(convertAnumber($('[id*=inn_nx01]').html()) + " port");
	$('[id*=inn_nx02]').html(convertAnumber($('[id*=inn_nx02]').html()) + " port");
	$('[id*=inn_nx03]').html(convertAnumber($('[id*=inn_nx03]').html()) + " port");

	$('#page_loading').fadeOut();

	function convertAnumber(amount) {
		var str_amount = amount;

		if($.isNumeric(amount) == true){
			amount = Number(amount);
			amount = amount.toLocaleString();
		}

		str_amount = "<span title='" + str_amount + "'>" +  amount  + "</span>";

		return str_amount;
	}
});
</script>

<style type="text/css">
.popover {
	max-width: 500px;
}
</style>
</asp:Content>
