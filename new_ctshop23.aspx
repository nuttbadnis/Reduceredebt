<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="new_ctshop23.aspx.vb" Inherits="new_ctshop23" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">
<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_flow_id" xd="hide_flow_id" type="hidden">
	<input runat="server" id="hide_page_url" xd="hide_page_url" type="hidden">
	<input runat="server" id="hide_prefix_id" xd="hide_prefix_id" type="hidden">
	<input runat="server" id="hide_create_ro" xd="hide_create_ro" type="hidden">
	<input runat="server" id="hide_placetype" xd="hide_placetype" type="hidden">
	<input runat="server" id="hide_ctphase" xd="hide_ctphase" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden" value="1">
	<input runat="server" id="hide_min_cost" xd="hide_min_cost" type="hidden">
	<input runat="server" id="hide_max_cost" xd="hide_max_cost" type="hidden">

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
								<input name="request_file3" id="request_file3" type="file" style="display:none;">
								<input name="request_file4" id="request_file4" type="file" class="form-control input-sm file-10mb">
								<input name="request_file5" id="request_file5" type="file" style="display:none;">
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">อายุสัญญา</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group">
										<asp:DropDownList runat="server" id="sel_ctphase" xd="sel_ctphase" class="form-control input-sm"></asp:DropDownList>
										<span class="txt-red">*หากเลือก อื่นๆ กรุณากรอกรายละเอียดอายุสัญญา ในช่องระบุระยะสัญญา</span>
									</div>
									<div id="div_ctphase_remark" class="input-group" style="display:none;padding-bottom: 17px;">
										<span class="input-group-addon txt-bold">ระบุระยะสัญญา</span>
										<input runat="server" type="text" class="form-control" maxlength="255" placeholder="1 เดือนครึ่ง" id="txt_ctphase_remark" xd="txt_ctphase_remark" value="0">
										<span runat="server" id="ctphase_unit" xd="ctphase_unit" class="input-group-addon txt-bold">เดือน</span>
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
								<span id="view_ax07" class="txt-red"></span>
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
										<input runat="server" id="hide_elecharge_unit" xd="hide_elecharge_unit" type="hidden" value="บาท/หน่วย">
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
								<span id="view_gx01" class="txt-red"></span>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">เอกสารใบแจ้งต่อสัญญา</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group col-md-6">
										<input name="request_file1" id="request_file1" type="file" class="form-control input-sm file-10mb">
										<span class="txt-red">*ไม่จำเป็นต้องเป็นเอกสารที่ได้รับการลงลายมือชื่อหรือได้รับการอนุมัติ</span>
									</div>
								</div>							
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">สัญญาเช่าเดิม<br>(กรณีอาคารพาณิชย์)</label>
							<div class="col-sm-10">
								<input name="request_file2" id="request_file2" type="file" class="form-control input-sm file-10mb">
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
<script type="text/javascript" src="App_Inc/_js/ctshop_request_new.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_form.js?v=39"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_form_tam.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_search_autoinput.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_operator.js?v=38"></script>

<script type="text/javascript">
$(document).ready(function() { 
	setDatePicker();
	getEmpDetail();
	
	$('#page_loading').fadeOut();
});
</script>

</asp:Content>
