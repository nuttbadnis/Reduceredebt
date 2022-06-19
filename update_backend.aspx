<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="update_backend.aspx.vb" Inherits="update_backend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">
<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">

	<ol class="breadcrumb">
		<li class="active">Update Request Backend</li>
	</ol>

	<div class="container">
		<div class="tab-content">

			<div class="panel panel-default panel-space">
				<div class="panel-heading panel-fonting">รายละเอียด</div>
				<div class="panel-body">
					<div class="form-horizontal">
						<div class="form-group required">
							<label class="col-sm-2 control-label">request_id</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_request_id" xd="txt_request_id" class="form-control box-search input-sm" placeholder="A4017070008" style="text-transform: uppercase">
									<button class="btn btn-primary btn-glyphicon-sm" type="button" id="btn_get_request"><span class="glyphicon glyphicon-search"></span></button>
									<input type="hidden" runat="server" id="hide_request_id" xd="hide_request_id" class="input-hide">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">subject_id</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_subject_id" xd="txt_subject_id" class="form-control box-search input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_subject_id" xd="hide_subject_id" class="form-control box-search input-sm input-hide" maxlength="12" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_subject_id" onclick="showBox('subject_id')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_subject_id" onclick="closedBox('subject_id')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">request_title_id</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_request_title_id" xd="txt_request_title_id" class="form-control box-search input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_request_title_id" xd="hide_request_title_id" class="form-control box-search input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_request_title_id" onclick="showBox('request_title_id')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_request_title_id" onclick="closedBox('request_title_id')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">request_title</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_request_title" xd="txt_request_title" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_request_title" xd="hide_request_title" class="form-control input-sm input-hide" maxlength="255" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_request_title" onclick="showBox('request_title')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_request_title" onclick="closedBox('request_title')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">request_remark</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_request_remark" xd="txt_request_remark" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_request_remark" xd="hide_request_remark" class="form-control input-hide" rows="2" style="display: none;"></textarea>
									<span>
										<a id="btn_show_request_remark" onclick="showBox('request_remark')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_request_remark" onclick="closedBox('request_remark')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">uemail_verify1</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_uemail_verify1" xd="txt_uemail_verify1" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_uemail_verify1" xd="hide_uemail_verify1" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_uemail_verify1" onclick="showBox('uemail_verify1')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_uemail_verify1" onclick="closedBox('uemail_verify1')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">uemail_verify2</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_uemail_verify2" xd="txt_uemail_verify2" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_uemail_verify2" xd="hide_uemail_verify2" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_uemail_verify2" onclick="showBox('uemail_verify2')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_uemail_verify2" onclick="closedBox('uemail_verify2')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">uemail_approve</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_uemail_approve" xd="txt_uemail_approve" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_uemail_approve" xd="hide_uemail_approve" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_uemail_approve" onclick="showBox('uemail_approve')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_uemail_approve" onclick="closedBox('uemail_approve')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">uemail_cc1</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_uemail_cc1" xd="txt_uemail_cc1" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_uemail_cc1" xd="hide_uemail_cc1" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_uemail_cc1" onclick="showBox('uemail_cc1')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_uemail_cc1" onclick="closedBox('uemail_cc1')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">uemail_cc2</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_uemail_cc2" xd="txt_uemail_cc2" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_uemail_cc2" xd="hide_uemail_cc2" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_uemail_cc2" onclick="showBox('uemail_cc2')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_uemail_cc2" onclick="closedBox('uemail_cc2')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">uemail_ccv1</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_uemail_ccv1" xd="txt_uemail_ccv1" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_uemail_ccv1" xd="hide_uemail_ccv1" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_uemail_ccv1" onclick="showBox('uemail_ccv1')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_uemail_ccv1" onclick="closedBox('uemail_ccv1')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">create_ro</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_create_ro" xd="txt_create_ro" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_create_ro" xd="hide_create_ro" class="form-control input-sm input-hide" maxlength="2" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_create_ro" onclick="showBox('create_ro')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_create_ro" onclick="closedBox('create_ro')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">create_shop</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_create_shop" xd="txt_create_shop" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_create_shop" xd="hide_create_shop" class="form-control input-sm input-hide" maxlength="10" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_create_shop" onclick="showBox('create_shop')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_create_shop" onclick="closedBox('create_shop')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">create_amount</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_create_amount" xd="txt_create_amount" class="form-control box-search input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_create_amount" xd="hide_create_amount" class="form-control box-search input-sm input-hide" maxlength="20" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_create_amount" onclick="showBox('create_amount')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_create_amount" onclick="closedBox('create_amount')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">create_date</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_create_date" xd="txt_create_date" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_create_date" xd="hide_create_date" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_create_date" onclick="showBox('create_date')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_create_date" onclick="closedBox('create_date')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">create_by</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_create_by" xd="txt_create_by" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_create_by" xd="hide_create_by" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_create_by" onclick="showBox('create_by')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_create_by" onclick="closedBox('create_by')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">update_date</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_update_date" xd="txt_update_date" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_update_date" xd="hide_update_date" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_update_date" onclick="showBox('update_date')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_update_date" onclick="closedBox('update_date')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">update_by</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_update_by" xd="txt_update_by" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_update_by" xd="hide_update_by" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_update_by" onclick="showBox('update_by')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_update_by" onclick="closedBox('update_by')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">last_update</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_last_update" xd="txt_last_update" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_last_update" xd="hide_last_update" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_last_update" onclick="showBox('last_update')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_last_update" onclick="closedBox('last_update')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">last_depart</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_last_depart" xd="txt_last_depart" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_last_depart" xd="hide_last_depart" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_last_depart" onclick="showBox('last_depart')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_last_depart" onclick="closedBox('last_depart')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">next_depart</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_next_depart" xd="txt_next_depart" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_next_depart" xd="hide_next_depart" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_next_depart" onclick="showBox('next_depart')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_next_depart" onclick="closedBox('next_depart')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">request_status</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_request_status" xd="txt_request_status" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_request_status" xd="hide_request_status" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_request_status" onclick="showBox('request_status')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_request_status" onclick="closedBox('request_status')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">request_step</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_request_step" xd="txt_request_step" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_request_step" xd="hide_request_step" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_request_step" onclick="showBox('request_step')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_request_step" onclick="closedBox('request_step')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">account_number</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_account_number" xd="txt_account_number" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_account_number" xd="hide_account_number" class="form-control input-sm input-hide" maxlength="50" style="display: none;">
									<span>
										<a id="btn_show_account_number" onclick="showBox('account_number')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_account_number" onclick="closedBox('account_number')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">account_name</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_account_name" xd="txt_account_name" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_account_name" xd="hide_account_name" class="form-control input-sm input-hide" maxlength="255" style="display: none;">
									<span>
										<a id="btn_show_account_name" onclick="showBox('account_name')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_account_name" onclick="closedBox('account_name')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">account_number_to</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_account_number_to" xd="txt_account_number_to" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_account_number_to" xd="hide_account_number_to" class="form-control input-sm input-hide" maxlength="50" style="display: none;">
									<span>
										<a id="btn_show_account_number_to" onclick="showBox('account_number_to')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_account_number_to" onclick="closedBox('account_number_to')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">account_name_to</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_account_name_to" xd="txt_account_name_to" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_account_name_to" xd="hide_account_name_to" class="form-control input-sm input-hide" maxlength="255" style="display: none;">
									<span>
										<a id="btn_show_account_name_to" onclick="showBox('account_name_to')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_account_name_to" onclick="closedBox('account_name_to')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">doc_number</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_doc_number" xd="txt_doc_number" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_doc_number" xd="hide_doc_number" class="form-control input-sm input-hide" maxlength="50" style="display: none;">
									<span>
										<a id="btn_show_doc_number" onclick="showBox('doc_number')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_doc_number" onclick="closedBox('doc_number')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">bcs_number</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_bcs_number" xd="txt_bcs_number" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_bcs_number" xd="hide_bcs_number" class="form-control input-sm input-hide" maxlength="50" style="display: none;">
									<span>
										<a id="btn_show_bcs_number" onclick="showBox('bcs_number')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_bcs_number" onclick="closedBox('bcs_number')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">amount</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_amount" xd="txt_amount" class="form-control box-search input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_amount" xd="hide_amount" class="form-control box-search input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_amount" onclick="showBox('amount')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_amount" onclick="closedBox('amount')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">area_ro</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_area_ro" xd="txt_area_ro" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_area_ro" xd="hide_area_ro" class="form-control input-sm input-hide" maxlength="2" style="display: none;">
									<span>
										<a id="btn_show_area_ro" onclick="showBox('area_ro')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_area_ro" onclick="closedBox('area_ro')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">shop_code</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_shop_code" xd="txt_shop_code" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_shop_code" xd="hide_shop_code" class="form-control input-sm input-hide" maxlength="10" style="display: none;">
									<span>
										<a id="btn_show_shop_code" onclick="showBox('shop_code')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_shop_code" onclick="closedBox('shop_code')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">pick_refund</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_pick_refund" xd="txt_pick_refund" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_pick_refund" xd="hide_pick_refund" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_pick_refund" onclick="showBox('pick_refund')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_pick_refund" onclick="closedBox('pick_refund')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">lock_receipt</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_lock_receipt" xd="txt_lock_receipt" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_lock_receipt" xd="hide_lock_receipt" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_lock_receipt" onclick="showBox('lock_receipt')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_lock_receipt" onclick="closedBox('lock_receipt')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">redebt_cause_id</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_redebt_cause_id" xd="txt_redebt_cause_id" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_redebt_cause_id" xd="hide_redebt_cause_id" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_redebt_cause_id" onclick="showBox('redebt_cause_id')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_redebt_cause_id" onclick="closedBox('redebt_cause_id')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">redebt_number</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_redebt_number" xd="txt_redebt_number" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_redebt_number" xd="hide_redebt_number" class="form-control input-sm input-hide" maxlength="50" style="display: none;">
									<span>
										<a id="btn_show_redebt_number" onclick="showBox('redebt_number')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_redebt_number" onclick="closedBox('redebt_number')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">redebt_file</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_redebt_file" xd="txt_redebt_file" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_redebt_file" xd="hide_redebt_file" class="form-control input-sm input-hide" maxlength="255" style="display: none;">
									<span>
										<a id="btn_show_redebt_file" onclick="showBox('redebt_file')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_redebt_file" onclick="closedBox('redebt_file')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">redebt_update</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_redebt_update" xd="txt_redebt_update" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_redebt_update" xd="hide_redebt_update" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_redebt_update" onclick="showBox('redebt_update')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_redebt_update" onclick="closedBox('redebt_update')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">redebt_update_by</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_redebt_update_by" xd="txt_redebt_update_by" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_redebt_update_by" xd="hide_redebt_update_by" class="form-control input-sm input-hide" style="display: none;">
									<span style="display: none;">
										<a id="btn_show_redebt_update_by" onclick="showBox('redebt_update_by')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_redebt_update_by" onclick="closedBox('redebt_update_by')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">fx01</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_fx01" xd="txt_fx01" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_fx01" xd="hide_fx01" class="form-control input-sm input-hide" maxlength="50" style="display: none;">
									<span>
										<a id="btn_show_fx01" onclick="showBox('fx01')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_fx01" onclick="closedBox('fx01')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">fx02</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_fx02" xd="txt_fx02" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_fx02" xd="hide_fx02" class="form-control input-sm input-hide" maxlength="50" style="display: none;">
									<span>
										<a id="btn_show_fx02" onclick="showBox('fx02')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_fx02" onclick="closedBox('fx02')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">fx03</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_fx03" xd="txt_fx03" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_fx03" xd="hide_fx03" class="form-control input-sm input-hide" maxlength="50" style="display: none;">
									<span>
										<a id="btn_show_fx03" onclick="showBox('fx03')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_fx03" onclick="closedBox('fx03')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">mx01</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_mx01" xd="txt_mx01" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_mx01" xd="hide_mx01" class="form-control input-hide" rows="2" maxlength="255" style="display: none;"></textarea>
									<span>
										<a id="btn_show_mx01" onclick="showBox('mx01')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_mx01" onclick="closedBox('mx01')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">mx02</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_mx02" xd="txt_mx02" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_mx02" xd="hide_mx02" class="form-control input-hide" rows="2" maxlength="255" style="display: none;"></textarea>
									<span>
										<a id="btn_show_mx02" onclick="showBox('mx02')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_mx02" onclick="closedBox('mx02')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">mx03</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_mx03" xd="txt_mx03" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_mx03" xd="hide_mx03" class="form-control input-hide" rows="2" maxlength="255" style="display: none;"></textarea>
									<span>
										<a id="btn_show_mx03" onclick="showBox('mx03')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_mx03" onclick="closedBox('mx03')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">tx01</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_tx01" xd="txt_tx01" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_tx01" xd="hide_tx01" class="form-control input-hide" rows="2" style="display: none;"></textarea>
									<span>
										<a id="btn_show_tx01" onclick="showBox('tx01')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_tx01" onclick="closedBox('tx01')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">tx02</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_tx02" xd="txt_tx02" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_tx02" xd="hide_tx02" class="form-control input-hide" rows="2" style="display: none;"></textarea>
									<span>
										<a id="btn_show_tx02" onclick="showBox('tx02')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_tx02" onclick="closedBox('tx02')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">tx03</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_tx03" xd="txt_tx03" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_tx03" xd="hide_tx03" class="form-control input-hide" rows="2" style="display: none;"></textarea>
									<span>
										<a id="btn_show_tx03" onclick="showBox('tx03')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_tx03" onclick="closedBox('tx03')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">nx01</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_nx01" xd="txt_nx01" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_nx01" xd="hide_nx01" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_nx01" onclick="showBox('nx01')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_nx01" onclick="closedBox('nx01')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">nx02</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_nx02" xd="txt_nx02" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_nx02" xd="hide_nx02" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_nx02" onclick="showBox('nx02')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_nx02" onclick="closedBox('nx02')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">nx03</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_nx03" xd="txt_nx03" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_nx03" xd="hide_nx03" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_nx03" onclick="showBox('nx03')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_nx03" onclick="closedBox('nx03')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">sx01</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_sx01" xd="txt_sx01" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_sx01" xd="hide_sx01" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_sx01" onclick="showBox('sx01')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_sx01" onclick="closedBox('sx01')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">sx02</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_sx02" xd="txt_sx02" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_sx02" xd="hide_sx02" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_sx02" onclick="showBox('sx02')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_sx02" onclick="closedBox('sx02')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-75">
							<label class="col-sm-2 control-label">sx03</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_sx03" xd="txt_sx03" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_sx03" xd="hide_sx03" class="form-control input-sm input-hide" style="display: none;">
									<span>
										<a id="btn_show_sx03" onclick="showBox('sx03')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_sx03" onclick="closedBox('sx03')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">dx01</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_dx01" xd="txt_dx01" class="form-control box-search input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_dx01" xd="hide_dx01" class="form-control datepicker box-search input-sm input-hide" readonly style="display: none;">
									<span>
										<a id="btn_show_dx01" onclick="showBox('dx01')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_dx01" onclick="closedBox('dx01')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">dx02</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_dx02" xd="txt_dx02" class="form-control box-search input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_dx02" xd="hide_dx02" class="form-control datepicker box-search input-sm input-hide" readonly style="display: none;">
									<span>
										<a id="btn_show_dx02" onclick="showBox('dx02')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_dx02" onclick="closedBox('dx02')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">dx03</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_dx03" xd="txt_dx03" class="form-control box-search input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_dx03" xd="hide_dx03" class="form-control datepicker box-search input-sm input-hide" readonly style="display: none;">
									<span>
										<a id="btn_show_dx03" onclick="showBox('dx03')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_dx03" onclick="closedBox('dx03')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">dx04</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_dx04" xd="txt_dx04" class="form-control box-search input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_dx04" xd="hide_dx04" class="form-control datepicker box-search input-sm input-hide" readonly style="display: none;">
									<span>
										<a id="btn_show_dx04" onclick="showBox('dx04')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_dx04" onclick="closedBox('dx04')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax01</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax01" xd="txt_ax01" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax01" xd="hide_ax01" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax01" onclick="showBox('ax01')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax01" onclick="closedBox('ax01')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax02</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax02" xd="txt_ax02" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax02" xd="hide_ax02" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax02" onclick="showBox('ax02')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax02" onclick="closedBox('ax02')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax03</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax03" xd="txt_ax03" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax03" xd="hide_ax03" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax03" onclick="showBox('ax03')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax03" onclick="closedBox('ax03')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax04</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax04" xd="txt_ax04" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax04" xd="hide_ax04" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax04" onclick="showBox('ax04')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax04" onclick="closedBox('ax04')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax05</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax05" xd="txt_ax05" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax05" xd="hide_ax05" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax05" onclick="showBox('ax05')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax05" onclick="closedBox('ax05')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax06</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax06" xd="txt_ax06" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax06" xd="hide_ax06" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax06" onclick="showBox('ax06')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax06" onclick="closedBox('ax06')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax07</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax07" xd="txt_ax07" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax07" xd="hide_ax07" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax07" onclick="showBox('ax07')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax07" onclick="closedBox('ax07')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax08</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax08" xd="txt_ax08" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax08" xd="hide_ax08" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax08" onclick="showBox('ax08')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax08" onclick="closedBox('ax08')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax09</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax09" xd="txt_ax09" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax09" xd="hide_ax09" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax09" onclick="showBox('ax09')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax09" onclick="closedBox('ax09')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax10</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax10" xd="txt_ax10" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax10" xd="hide_ax10" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax10" onclick="showBox('ax10')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax10" onclick="closedBox('ax10')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax11</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax11" xd="txt_ax11" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax11" xd="hide_ax11" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax11" onclick="showBox('ax11')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax11" onclick="closedBox('ax11')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax12</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax12" xd="txt_ax12" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax12" xd="hide_ax12" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax12" onclick="showBox('ax12')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax12" onclick="closedBox('ax12')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax13</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax13" xd="txt_ax13" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax13" xd="hide_ax13" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax13" onclick="showBox('ax13')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax13" onclick="closedBox('ax13')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax14</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax14" xd="txt_ax14" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax14" xd="hide_ax14" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax14" onclick="showBox('ax14')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax14" onclick="closedBox('ax14')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax15</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax15" xd="txt_ax15" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax15" xd="hide_ax15" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax15" onclick="showBox('ax15')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax15" onclick="closedBox('ax15')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax16</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax16" xd="txt_ax16" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax16" xd="hide_ax16" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax16" onclick="showBox('ax16')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax16" onclick="closedBox('ax16')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax17</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax17" xd="txt_ax17" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax17" xd="hide_ax17" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax17" onclick="showBox('ax17')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax17" onclick="closedBox('ax17')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax18</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax18" xd="txt_ax18" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax18" xd="hide_ax18" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax18" onclick="showBox('ax18')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax18" onclick="closedBox('ax18')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax19</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax19" xd="txt_ax19" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax19" xd="hide_ax19" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax19" onclick="showBox('ax19')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax19" onclick="closedBox('ax19')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">ax20</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_ax20" xd="txt_ax20" class="form-control input-sm input-txt" readonly>
									<input type="text" runat="server" id="hide_ax20" xd="hide_ax20" class="form-control input-sm input-hide" maxlength="20" style="display: none;">
									<span>
										<a id="btn_show_ax20" onclick="showBox('ax20')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_ax20" onclick="closedBox('ax20')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">gx01</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_gx01" xd="txt_gx01" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_gx01" xd="hide_gx01" class="form-control input-hide" rows="2" maxlength="500" style="display: none;"></textarea>
									<span>
										<a id="btn_show_gx01" onclick="showBox('gx01')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_gx01" onclick="closedBox('gx01')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">gx02</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_gx02" xd="txt_gx02" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_gx02" xd="hide_gx02" class="form-control input-hide" rows="2" maxlength="500" style="display: none;"></textarea>
									<span>
										<a id="btn_show_gx02" onclick="showBox('gx02')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_gx02" onclick="closedBox('gx02')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">gx03</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_gx03" xd="txt_gx03" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_gx03" xd="hide_gx03" class="form-control input-hide" rows="2" maxlength="500" style="display: none;"></textarea>
									<span>
										<a id="btn_show_gx03" onclick="showBox('gx03')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_gx03" onclick="closedBox('gx03')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">gx04</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_gx04" xd="txt_gx04" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_gx04" xd="hide_gx04" class="form-control input-hide" rows="2" maxlength="500" style="display: none;"></textarea>
									<span>
										<a id="btn_show_gx04" onclick="showBox('gx04')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_gx04" onclick="closedBox('gx04')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label">gx05</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<textarea runat="server" type="text" id="txt_gx05" xd="txt_gx05" class="form-control input-txt" rows="2" readonly></textarea>
									<textarea runat="server" type="text" id="hide_gx05" xd="hide_gx05" class="form-control input-hide" rows="2" maxlength="500" style="display: none;"></textarea>
									<span>
										<a id="btn_show_gx05" onclick="showBox('gx05')" class="btn-show btn-addon"><span class="glyphicon icon-edit2"></span></a>
										<a id="btn_closed_gx05" onclick="closedBox('gx05')" class="btn-closed btn-addon txt-red dis-none"><span class="glyphicon glyphicon-remove"></span></a>
									</span>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label txt-blue">Ref ID</label>
							<div class="col-sm-10">
								<input type="text" runat="server" id="txt_log_ref_id" xd="txt_log_ref_id" class="form-control input-sm" placeholder="เช่น เลขที่ Incident Log" maxlength="50">
							</div>
						</div>
						<div class="form-group form-500">
							<label class="col-sm-2 control-label txt-blue">Remark</label>
							<div class="col-sm-10">
								<textarea runat="server" type="text" id="txt_log_remark" xd="txt_log_remark" class="form-control" rows="4" placeholder="หมายเหตุ ที่ต้องแก้ไข Backend เนื่องจาก.." maxlength="500"></textarea>
							</div>
						</div>
						<div id="div_submit" style="display:none;">
							<div class="space-br"></div>
							<div class="form-group form-500">
								<div class="col-sm-offset-2 col-sm-10">
									<div class="form-inline">
										<button type="button" class="btn btn-danger btn-sm" id="btn_update_backend">
											<span class="glyphicon icon-save" aria-hidden="true"></span> บันทึก
										</button>
										<input runat="server" id="btn_update_backend_hidden" xd="btn_update_backend_hidden" OnServerClick="Submit_Update" type="submit" style="display:none;">
										<span class="txt-gray">กรุณาตรวจสอบข้อมูลให้ดี ก่อนบันทึก</span>
									</div>
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

<script type="text/javascript">
$(document).ready(function() { 
	setDatePicker();
	resetBox();

	$('#page_loading').fadeOut();
});

$('#btn_update_backend').click(function() {
	$('input[xd="btn_update_backend_hidden"]').click();
});

$('#btn_get_request').click(function() {
	resetBox();

	var request_id = $('input[xd="txt_request_id"]').val();

	if(request_id.trim().length > 0){
		getRequestStarField(request_id);
	}
	else {
		modalAlert("กรุณากรอกเลขที่คำขอ");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('input[xd="txt_request_id"]').focus();
		})
	}
});

function getRequestStarField(request_id) {
	var url = "json_default.aspx?qrs=getRequestStarField&request_id=" + request_id;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: 'json',
		timeout: 120000,
		success: function( data ) { 
			console.log(data);

			if(data.length > 0){
				$('.btn-show').show();
				$('#div_submit').show();

				$('input[xd="hide_'+	'request_id'		+'"]').val(	data[0].request_id );

				$('input[xd="txt_'+		'subject_id'		+'"]').val(	data[0].subject_id );
				$('input[xd="txt_'+		'request_title_id'	+'"]').val(	itemBlank(data[0].request_title_id) );
				$('input[xd="txt_'+		'request_title'		+'"]').val(	itemBlank(data[0].request_title) );
				$('input[xd="txt_'+		'request_status'	+'"]').val(	data[0].request_status );
				$('input[xd="txt_'+		'request_step'		+'"]').val(	data[0].request_step );
				$('textarea[xd="txt_'+	'request_remark'	+'"]').val(	data[0].request_remark );
				$('input[xd="txt_'+		'uemail_verify1'	+'"]').val(	data[0].uemail_verify1 );
				$('input[xd="txt_'+		'uemail_verify2'	+'"]').val(	data[0].uemail_verify2 );
				$('input[xd="txt_'+		'uemail_approve'	+'"]').val(	data[0].uemail_approve );
				$('input[xd="txt_'+		'uemail_cc1'		+'"]').val(	data[0].uemail_cc1 );
				$('input[xd="txt_'+		'uemail_cc2'		+'"]').val(	data[0].uemail_cc2 );
				$('input[xd="txt_'+		'uemail_ccv1'		+'"]').val(	data[0].uemail_ccv1 );
				$('input[xd="txt_'+		'create_date'		+'"]').val(	itemBlank(data[0].create_date) );
				$('input[xd="txt_'+		'create_by'			+'"]').val(	itemBlank(data[0].create_by) );
				$('input[xd="txt_'+		'create_ro'			+'"]').val(	itemBlank(data[0].create_ro) );
				$('input[xd="txt_'+		'create_shop'		+'"]').val(	data[0].create_shop );
				$('input[xd="txt_'+		'create_amount'		+'"]').val(	data[0].create_amount );
				$('input[xd="txt_'+		'update_date'		+'"]').val(	itemBlank(data[0].update_date) );
				$('input[xd="txt_'+		'update_by'			+'"]').val(	itemBlank(data[0].update_by) );
				$('input[xd="txt_'+		'last_update'		+'"]').val(	itemBlank(data[0].last_update) );
				$('input[xd="txt_'+		'last_depart'		+'"]').val(	data[0].last_depart );
				$('input[xd="txt_'+		'next_depart'		+'"]').val(	data[0].next_depart );

				$('input[xd="txt_'+		'account_number'	+'"]').val(	itemBlank(data[0].account_number) );
				$('input[xd="txt_'+		'account_name'		+'"]').val(	itemBlank(data[0].account_name) );
				$('input[xd="txt_'+		'account_number_to'	+'"]').val(	data[0].account_number_to );
				$('input[xd="txt_'+		'account_name_to'	+'"]').val(	data[0].account_name_to );
				$('input[xd="txt_'+		'doc_number'		+'"]').val(	data[0].doc_number );
				$('input[xd="txt_'+		'bcs_number'		+'"]').val(	data[0].bcs_number );
				$('input[xd="txt_'+		'amount'			+'"]').val(	data[0].amount );
				$('input[xd="txt_'+		'area_ro'			+'"]').val(	data[0].area_ro );
				$('input[xd="txt_'+		'shop_code'			+'"]').val(	data[0].shop_code );
				$('input[xd="txt_'+		'pick_refund'		+'"]').val(	data[0].pick_refund );
				$('input[xd="txt_'+		'lock_receipt'		+'"]').val(	data[0].lock_receipt );

				$('input[xd="txt_'+		'redebt_cause_id'	+'"]').val(	itemBlank(data[0].redebt_cause_id) );
				$('input[xd="txt_'+		'redebt_number'		+'"]').val(	itemBlank(data[0].redebt_number) );
				$('input[xd="txt_'+		'redebt_file'		+'"]').val(	itemBlank(data[0].redebt_file) );
				$('input[xd="txt_'+		'redebt_update'		+'"]').val(	itemBlank(data[0].redebt_update) );
				$('input[xd="txt_'+		'redebt_update_by'	+'"]').val(	itemBlank(data[0].redebt_update_by) );

				$('input[xd="txt_'+		'fx01'				+'"]').val(	data[0].fx01 );
				$('input[xd="txt_'+		'fx02'				+'"]').val(	data[0].fx02 );
				$('input[xd="txt_'+		'fx03'				+'"]').val(	data[0].fx03 );

				$('textarea[xd="txt_'+	'mx01'				+'"]').val(	data[0].mx01 );
				$('textarea[xd="txt_'+	'mx02'				+'"]').val(	data[0].mx02 );
				$('textarea[xd="txt_'+	'mx03'				+'"]').val(	data[0].mx03 );

				$('textarea[xd="txt_'+	'tx01'				+'"]').val(	data[0].tx01 );
				$('textarea[xd="txt_'+	'tx02'				+'"]').val(	data[0].tx02 );
				$('textarea[xd="txt_'+	'tx03'				+'"]').val(	data[0].tx03 );

				$('input[xd="txt_'+		'nx01'				+'"]').val(	data[0].nx01 );
				$('input[xd="txt_'+		'nx02'				+'"]').val(	data[0].nx02 );
				$('input[xd="txt_'+		'nx03'				+'"]').val(	data[0].nx03 );

				$('input[xd="txt_'+		'sx01'				+'"]').val(	data[0].sx01 );
				$('input[xd="txt_'+		'sx02'				+'"]').val(	data[0].sx02 );
				$('input[xd="txt_'+		'sx03'				+'"]').val(	data[0].sx03 );

				$('input[xd="txt_'+		'dx01'				+'"]').val(	itemBlank(data[0].dx01) );
				$('input[xd="txt_'+		'dx02'				+'"]').val(	itemBlank(data[0].dx02) );
				$('input[xd="txt_'+		'dx03'				+'"]').val(	itemBlank(data[0].dx03) );
				$('input[xd="txt_'+		'dx04'				+'"]').val(	itemBlank(data[0].dx04) );

				$('input[xd="txt_'+		'ax01'				+'"]').val(	itemBlank(data[0].ax01) );
				$('input[xd="txt_'+		'ax02'				+'"]').val(	itemBlank(data[0].ax02) );
				$('input[xd="txt_'+		'ax03'				+'"]').val(	itemBlank(data[0].ax03) );
				$('input[xd="txt_'+		'ax04'				+'"]').val(	itemBlank(data[0].ax04) );
				$('input[xd="txt_'+		'ax05'				+'"]').val(	itemBlank(data[0].ax05) );
				$('input[xd="txt_'+		'ax06'				+'"]').val(	itemBlank(data[0].ax06) );
				$('input[xd="txt_'+		'ax07'				+'"]').val(	itemBlank(data[0].ax07) );
				$('input[xd="txt_'+		'ax08'				+'"]').val(	itemBlank(data[0].ax08) );
				$('input[xd="txt_'+		'ax09'				+'"]').val(	itemBlank(data[0].ax09) );
				$('input[xd="txt_'+		'ax10'				+'"]').val(	itemBlank(data[0].ax10) );
				$('input[xd="txt_'+		'ax11'				+'"]').val(	itemBlank(data[0].ax11) );
				$('input[xd="txt_'+		'ax12'				+'"]').val(	itemBlank(data[0].ax12) );
				$('input[xd="txt_'+		'ax13'				+'"]').val(	itemBlank(data[0].ax13) );
				$('input[xd="txt_'+		'ax14'				+'"]').val(	itemBlank(data[0].ax14) );
				$('input[xd="txt_'+		'ax15'				+'"]').val(	itemBlank(data[0].ax15) );
				$('input[xd="txt_'+		'ax16'				+'"]').val(	itemBlank(data[0].ax16) );
				$('input[xd="txt_'+		'ax17'				+'"]').val(	itemBlank(data[0].ax17) );
				$('input[xd="txt_'+		'ax18'				+'"]').val(	itemBlank(data[0].ax18) );
				$('input[xd="txt_'+		'ax19'				+'"]').val(	itemBlank(data[0].ax19) );
				$('input[xd="txt_'+		'ax20'				+'"]').val(	itemBlank(data[0].ax20) );

				$('textarea[xd="txt_'+	'gx01'				+'"]').val(	itemBlank(data[0].gx01) );
				$('textarea[xd="txt_'+	'gx02'				+'"]').val(	itemBlank(data[0].gx02) );
				$('textarea[xd="txt_'+	'gx03'				+'"]').val(	itemBlank(data[0].gx03) );
				$('textarea[xd="txt_'+	'gx04'				+'"]').val(	itemBlank(data[0].gx04) );
				$('textarea[xd="txt_'+	'gx05'				+'"]').val(	itemBlank(data[0].gx05) );
			}
		},
		error: function(x, t, m) {
			console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);

			modalAlert("ไม่สำเร็จ กรุณาลองอีกครั้ง หรือติดต่อ support_pos@jasmine.com");
			$('#modal_alert').on('hidden.bs.modal', function (e) {
				location.reload();
			})
		}
	});
}

function resetBox() {
	$('.input-txt').show();
	$('.input-hide').hide();

	$('.input-txt').val("");
	$('.input-hide').val("valueEmpty");

	$('.btn-show').hide();
	$('.btn-closed').hide();

	$('#div_submit').hide();
}

function showBox(id) {
	$('input[xd="hide_'+id+'"]').show();
	$('input[xd="txt_'+id+'"]').hide();
	$('input[xd="hide_'+id+'"]').val($('input[xd="txt_'+id+'"]').val());

	$('textarea[xd="hide_'+id+'"]').show();
	$('textarea[xd="txt_'+id+'"]').hide();
	$('textarea[xd="hide_'+id+'"]').val($('textarea[xd="txt_'+id+'"]').val());

	$('#btn_show_'+id).hide();
	$('#btn_closed_'+id).show();
}

function closedBox(id) {
	$('input[xd="hide_'+id+'"]').hide();
	$('input[xd="txt_'+id+'"]').show();
	$('input[xd="hide_'+id+'"]').val("valueEmpty");

	$('textarea[xd="hide_'+id+'"]').hide();
	$('textarea[xd="txt_'+id+'"]').show();
	$('textarea[xd="hide_'+id+'"]').val("valueEmpty");

	$('#btn_show_'+id).show();
	$('#btn_closed_'+id).hide();
}
</script>

</asp:Content>
