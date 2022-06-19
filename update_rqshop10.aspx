<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="update_rqshop10.aspx.vb" Inherits="update_rqshop10" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">

<form action="openprint.aspx" method="post" name="formprint" style="display:none;">
	<input id="print_request_id" name="print_request_id" type="hidden">
	<input runat="server" id="btn_print_hidden" xd="btn_print_hidden" type="submit" value="print">
</form>

<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_uemail_create" xd="hide_uemail_create" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden">
	<input runat="server" id="hide_subject_id" xd="hide_subject_id" type="hidden">
	<input runat="server" id="hide_depart_group" xd="hide_depart_group" type="hidden">
	<input runat="server" id="hide_mkt_form" xd="hide_mkt_form" type="hidden" value= "0">
	<input runat="server" id="hide_law_form" xd="hide_law_form" type="hidden" value= "0">
	<input runat="server" id="hide_sel_title" xd="hide_sel_title" type="hidden">
	<input runat="server" id="hide_sel_type_shop" xd="hide_sel_type_shop" type="hidden">
	<input runat="server" id="hide_sel_payback_status" xd="hide_sel_payback_status" type="hidden">
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
							<label class="col-sm-2 control-label">รหัสศูนย์บริการ:</label>
							<div class="col-sm-10 control-label left-label">
								<span runat="server" id="inn_newshop_code"></span> 
							</div>
						</div> 
						<div class="form-group">
							<label class="col-sm-2 control-label">จังหวัด:</label>
							<div class="col-sm-10 control-label left-label">
								<span runat="server" id="inn_province_short"></span> 
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
						<div class="form-group">
							<label class="col-sm-2 control-label">ชื่อศูนย์บริการ:</label>
							<span runat="server" id="inn_newshop_name" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">รหัสศูนย์บริการเดิม(ถ้ามี):</label>
							<span runat="server" id="inn_oldshop_code" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ประเภทศูนย์บริการ:</label>
							<span runat="server" id="inn_type_shop" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">สถานะการรับเงิน:</label>
							<span runat="server" id="inn_payback_status" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ชื่อ-สถานที่ตั้ง:</label>
							<span runat="server" id="inn_location" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">วันที่คาดว่าจะเปิดบริการ:</label>
							<span runat="server" id="inn_dx01" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">จำนวนเครื่อง POS:</label>
							<span runat="server" id="inn_nx01" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ขนาดพื้นที่:</label>
							<span runat="server" id="inn_ax19" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">รายละเอียดการให้บริการ:</label>
							<span runat="server" id="inn_request_remark" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">เหตุผล/สาเหตุ<br>การขอเพิ่มศูนย์บริการ:</label>
							<span runat="server" id="inn_tx02" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">แบบงานสร้าง:</label>
							<span runat="server" id="inn_request_file1" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">แบบงานระบบ:</label>
							<span runat="server" id="inn_request_file2" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">รูปหน้างานจริง:</label>
							<span runat="server" id="inn_request_file3" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">แบบ LayOut พื้นที่:</label>
							<span runat="server" id="inn_request_file4" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">แบบงานสร้างห้างอนุมัติฯ:</label>
							<span runat="server" id="inn_request_file5" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">แบบงานระบบห้างอนุมัติ:</label>
							<span runat="server" id="inn_request_file6" class="col-sm-10 control-label left-label"></span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">งบประมาณ<br>การปรับปรุง/ตกแต่ง:</label>
							<div class="col-sm-10" style="padding-top: 7px;">
								<div class="form-inline">
								<span runat="server" id="inn_decoration_fee" class="control-label left-label"></span>
								<span runat="server" id="inn_request_file7" class="control-label left-label"></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ค่ารปภ.(ถ้ามี):</label>
							<span runat="server" id="inn_ax20" class="col-sm-10 control-label left-label"></span>
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
				<div class="panel-body" runat="server" id="edit_form" xd="edit_form">
					<div class="form-horizontal">
					<div runat="server" id="edit_sub_form" xd="edit_sub_form">
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">เรื่อง</label>
							<div class="col-sm-10">
								<asp:DropDownList runat="server" id="sel_title" xd="sel_title" class="form-control input-sm width700"></asp:DropDownList>
								<input runat="server" id="txt_request_title" xd="txt_request_title" type="text" style="display:none;">
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">รหัสศูนย์บริการ</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_newshop_code" xd="txt_newshop_code" class="form-control input-sm box-search auto-sch">
									<!-- <input type="text" id="auto_shop_code" class="form-control input-sm box-search auto-sch" placeholder="ค้นหาอัตโนมัติโดย รหัสศูนย์บริการ, ชื่อ หรือที่อยู่">
									<input runat="server" id="hide_shop_code" xd="hide_shop_code" type="hidden"> -->
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
						<div class="form-group required">
							<label class="col-sm-2 control-label">ชื่อศูนย์บริการ</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_newshop_name" class="form-control input-sm box-search auto-sch">
								</div>
							</div>
						</div>
                        <div class="form-group">
							<label class="col-sm-2 control-label">รหัสศูนย์บริการเดิม(ถ้ามี)</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input runat="server" type="text" id="txt_oldshop_code" class="form-control input-sm box-search auto-sch">
								</div>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">ประเภทศูนย์บริการ</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<asp:DropDownList runat="server" id="sel_type_shop" xd="sel_type_shop" class="form-control input-sm">
									</asp:DropDownList>							
								</div>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">สถานะการรับเงิน</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<asp:DropDownList runat="server" id="sel_payback_status" xd="sel_payback_status" class="form-control input-sm">
									</asp:DropDownList>							
								</div>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">ชื่อ-สถานที่ตั้ง</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txtar_location" xd="txtar_location" class="form-control width700" rows="4" placeholder="ถ้ามีรายละเอียดเพิ่มเติมกรอกที่ช่องนี้.."></textarea>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">วันที่คาดว่าจะเปิดบริการ</label>
							<div class="col-sm-10">
								<input runat="server" name="txt_dx01" type="text" id="txt_dx01" class="form-control input-sm datepicker" maxlength="10" placeholder="30/12/2016">
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">จำนวนเครื่อง POS</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_nx01" xd="txt_nx01" class="form-control input-sm num-only " placeholder="4">
									<div class="input-group-addon addon-w0">เครื่อง</div>
								</div>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">ขนาดพื้นที่</label>
							<div class="col-sm-10">
								<div class="input-group">
									<input runat="server" type="text" id="txt_ax19" xd="txt_ax19" class="form-control input-sm num-only " placeholder="99999.99">
									<div class="input-group-addon addon-w0">ตร.ม.</div>
								</div>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">รายละเอียดการให้บริการ</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txtar_request_remark" xd="txtar_request_remark" class="form-control width700" rows="4" placeholder="ข้อความ ตย.ควบคุมเบิก-จ่าย อุปกรณ์สำหรับงานติดตั้ง DW จ.กระบี่"></textarea>
							</div>
						</div>
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">เหตุผล/สาเหตุ<br>การขอเพิ่มศูนย์บริการ</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txtar_tx02" xd="txtar_tx02" class="form-control width700" rows="4" placeholder="ข้อความ ตย.ปัจจุบันงานติดตั้ง DW ของ จ.กระบี่เพิ่มขึ้นเป็นจำนวนมาก ทำให้การจัดการไม่คล่องตัวและมีความล่าช้า"></textarea>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">แบบงานสร้าง</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="request_file1" id="request_file1" type="file" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file1"></span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">แบบงานระบบ</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="request_file2" id="request_file2" type="file" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file2"></span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">รูปหน้างานจริง</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="request_file3" id="request_file3" type="file" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file3"></span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">แบบ LayOut พื้นที่</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input name="request_file4" id="request_file4" type="file" class="form-control input-sm file-10mb">
									<span runat="server" id="current_request_file4"></span>
								</div>
							</div>
						</div>
                        <div class="space-br"></div>
						<div class="panel panel-info">
							<div class="panel-heading panel-fonting">
								ข้อมูลแบบที่ห้างอนุมัติก่อนประเมินราคา
							</div>
							<div class="space-br"></div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">แบบงานสร้างห้างอนุมัติฯ</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file5" id="request_file5" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file5"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">แบบงานระบบห้างอนุมัติ</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file6" id="request_file6" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file6"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">งบประมาณ<br>การปรับปรุง/ตกแต่ง</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<div class="input-group">
											<input runat="server" type="text" id="txt_decoration_fee" xd="txt_decoration_fee" class="form-control input-sm num-only input-addon-bath-ea" placeholder="99.99">
											<div class="input-group-addon addon-w0">บาท</div>
										</div>
										<input name="request_file7" id="request_file7" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file7"></span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">ค่ารปภ.(ถ้ามี)</label>
								<div class="col-sm-10">
									<div class="input-group">
										<input runat="server" type="text" id="txt_ax20" xd="txt_ax20" class="form-control input-sm num-only input-addon-bath-ea" placeholder="99.99">
										<div class="input-group-addon addon-w0">บาท/คืน</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				    	<div class="space-br"></div>
						<div id="mkt_update" runat="server" class="panel panel-info" style="display: none;">
							<div class="panel-heading panel-fonting">
								เอกสารประกอบการจดทะเบียน ภพ (หากเอกสารที่จะใช้ทำการยื่นในข้อใดมีมากกว่า 1 ไฟล์ ให้ทำการ zip ไฟล์ก่อนทำการ Upload)
							</div>
							<div class="space-br"></div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">สำเนาสัญญาเช่าพื้นที่</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file8" id="request_file8" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file8"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">สำเนาทะเบียนบ้าน<br>ของสถานที่เช่า<br>และสำเนาโฉนดที่ดิน</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file9" id="request_file9" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file9"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">แผนที่สถานที่เช่า</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file10" id="request_file10" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file10"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">เอกสารแสดงตัวตน<br>ของผู้ให้เช่า</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file11" id="request_file11" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file11"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">หนังสือมอบอำนาจ<br>ของฝ่ายผู้ให้เช่า<br>และเอกสารประกอบ (ถ้ามี)</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file12" id="request_file12" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file12"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">เอกสารอื่นๆ (ถ้ามี)</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file13" id="request_file13" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file13"></span>
									</div>
								</div>
							</div>
						</div>
				    	<div class="space-br"></div>
						<div id="law_update" runat="server" class="panel panel-info" style="display: none;">
							<div class="panel-heading panel-fonting">
								เอกสารฝ่ายกฎหมาย (เอกสารที่ฝ่ายกฎหมายจะ upload เพิ่มเติม หลังจากจดทะเบียนเพิ่มสาขาแล้ว)
							</div>
							<div class="space-br"></div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ภพ. 09 แสดงการ<br>จดเพิ่มสาขา (TI)</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file14" id="request_file14" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file14"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ภพ. 20 (TI)</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file15" id="request_file15" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file15"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ภพ. 09 แสดงการ<br>จดเพิ่มสาขา (BB)</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file16" id="request_file16" type="file" class="form-control input-sm file-10mb">
										<span runat="server" id="current_request_file16"></span>
									</div>
								</div>
							</div>
							<div class="form-group form-500">
								<label class="col-sm-2 control-label">ภพ. 20 (BB)</label>
								<div class="col-sm-10">
									<div class="form-inline">
										<input name="request_file17" id="request_file17" type="file" class="form-control input-sm file-10mb">
										<input name="request_file18" id="request_file18" type="file" style="display:none;">
										<input name="request_file19" id="request_file19" type="file" style="display:none;">
										<input name="request_file20" id="request_file20" type="file" style="display:none;">
										<span runat="server" id="current_request_file17"></span>
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
<script type="text/javascript" src="App_Inc/_js/ctshop_search_autoinput.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_operator.js?v=38"></script>
<script type="text/javascript" src="App_Inc/_js/ctshop_form.js?v=38"></script>
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

	AutoElechargeUnit();

<%--$('#inn_placetype').html($("select[xd='sel_placetype'] option:selected").html());
	$('#inn_ctphase').html($("select[xd='sel_ctphase'] option:selected").html());

	$('[id*=inn_uprent_rate]').html(convertUprentPercent($('[id*=inn_uprent_rate]').html()));

	'$('[id*=inn_amount]').html(convertAmount($('[id*=inn_amount]').html()) + " บาท/เดือน (ไม่มี VAT)");
	$('[id*=inn_ax05]').html(convertAmount($('[id*=inn_ax05]').html()) + " บาท/เดือน (รวม VAT)");
	$('[id*=inn_ax06]').html(convertAmount($('[id*=inn_ax06]').html()) + " บาท/เดือน (รวม VAT)");
	$('[id*=inn_ax07]').html(convertAmount($('[id*=inn_ax07]').html()) + " บาท/เดือน (รวม VAT)");
	$('[id*=inn_ax08]').html(convertAmount($('[id*=inn_ax08]').html()) + " บาท/เดือน (รวม VAT)");
	$('[id*=inn_ax09]').html(convertAmount($('[id*=inn_ax09]').html()) + " บาท/เดือน (รวม VAT)");
	$('[id*=inn_ax10]').html(convertAmount($('[id*=inn_ax10]').html()) + " บาท/เดือน (รวม VAT)");
	$('[id*=inn_ax11]').html(convertAmount($('[id*=inn_ax11]').html()) + " บาท/เดือน");
	$('[id*=inn_ax12]').html(convertAmount($('[id*=inn_ax12]').html()) + " บาท");
	$('[id*=inn_ax13]').html(convertAmount($('[id*=inn_ax13]').html()));
	$('[id*=inn_ax14]').html(convertAmount($('[id*=inn_ax14]').html()) + " บาท/หน่วย");
	
	$('[id*=inn_ax01]').html(convertAmount($('[id*=inn_ax01]').html()) + " บาท");
	$('[id*=inn_ax02]').html(convertAmount($('[id*=inn_ax02]').html()) + " บาท");
	$('[id*=inn_ax03]').html(convertAmount($('[id*=inn_ax03]').html()) + " บาท");	
	$('[id*=inn_nx02]').html(convertAnumber($('[id*=inn_nx02]').html()) + " port");
	$('[id*=inn_nx03]').html(convertAnumber($('[id*=inn_nx03]').html()) + " port"); --%>

	$('[id*=inn_nx01]').html(convertAnumber($('[id*=inn_nx01]').html()) + " เครื่อง");
	$('[id*=inn_decoration_fee]').html(convertAmount($('[id*=inn_decoration_fee]').html()) + " บาท"); 
	$('[id*=inn_ax20]').html(convertAmount($('[id*=inn_ax20]').html()) + " บาท/คืน"); 
	
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
