<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="new_ctshop50.aspx.vb" Inherits="new_ctshop50" %>

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
						<%-- <div class="form-group form-500">
							<label class="col-sm-2 control-label">รายละเอียดเพิ่มเติม</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txtar_request_remark" xd="txtar_request_remark" class="form-control width700" rows="4" placeholder="ถ้ามีรายละเอียดเพิ่มเติมกรอกที่ช่องนี้.."></textarea>
							</div>
						</div> --%>
						<div class="space-br"></div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">รหัสศูนย์บริการ</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" id="auto_shop_code" class="form-control input-sm box-search auto-sch" placeholder="ค้นหาอัตโนมัติโดย รหัสสาขา, ชื่อ หรือที่อยู่">
									<input runat="server" id="hide_shop_code" xd="hide_shop_code" type="hidden">
								</div>
							</div>
						</div>
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
							<input name="request_file1" id="request_file1" type="file" style="display:none;">
							<input name="request_file2" id="request_file2" type="file" style="display:none;">
							<input name="request_file4" id="request_file4" type="file" style="display:none;">
							<input name="request_file5" id="request_file5" type="file" style="display:none;">
							<input name="request_file6" id="request_file6" type="file" style="display:none;">
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">รูปหน้างานจริง</label>
							<div class="col-sm-10">
								<input name="request_file3" id="request_file3" type="file" class="form-control input-sm file-10mb">
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">แบบงานสร้างที่ห้างฯอนุมัติ</label>
							<div class="col-sm-10">	
								<input name="request_file7" id="request_file7" type="file" class="form-control input-sm file-10mb">
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">แบบงานระบบที่ห้างฯอนุมัติ</label>
							<div class="col-sm-10">
								<input name="request_file8" id="request_file8" type="file" class="form-control input-sm file-10mb">
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">แบบ LayOut พื้นที่</label>
							<div class="col-sm-10">
								<input name="request_file9" id="request_file9" type="file" class="form-control input-sm file-10mb">
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">ขนาดพื้นที่</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax19" xd="txt_ax19" class="form-control input-sm num-only input-addon-bath-2" placeholder="99.99">
									<div class="input-group-addon addon-w0">ตร.ม.</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">งบประมาณการตกแต่ง</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<div class="input-group">
										<input runat="server" type="text" id="txt_decoration_fee" xd="txt_decoration_fee" class="form-control input-sm num-only input-addon-bath-2" placeholder="99.99">
										<div class="input-group-addon addon-w0">บาท (ยอดรวมภาษีมูลค่าเพิ่ม)</div>
									</div>
									<input name="request_file12" id="request_file12" type="file" style="display:none;">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">เงินประกันการตกแต่ง</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax18" xd="txt_ax18" class="form-control input-sm num-only input-addon-bath-2" placeholder="99.99">
									<div class="input-group-addon addon-w0">บาท</div>
								</div>
							</div>
						</div> 
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่ารปภ.</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax20" xd="txt_ax20" class="form-control input-sm num-only input-addon-bath-2" placeholder="99.99">
									<div class="input-group-addon addon-w0">บาท</div>
								</div>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">รวมงบประมาณการตกแต่ง</label>
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
							<label class="col-sm-2 control-label">เอกสารใบเสนอราคา 1</label>
							<div class="col-sm-10">
								<input name="request_file10" id="request_file10" type="file" class="form-control input-sm file-10mb">
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">เอกสารใบเสนอราคา 2</label>
							<div class="col-sm-10">
								<input name="request_file11" id="request_file11" type="file" class="form-control input-sm file-10mb">
								<input name="request_file13" id="request_file13" type="file" style="display:none;">
								<input name="request_file14" id="request_file14" type="file" style="display:none;">
								<input name="request_file15" id="request_file15" type="file" style="display:none;">
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
<script type="text/javascript" src="App_Inc/_js/ctshop_form.js?v=44"></script>
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
