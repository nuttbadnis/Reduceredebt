<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="replace_userify.aspx.vb" Inherits="replace_userify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">
<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">

	<ol class="breadcrumb">
		<li class="active">อัพเดท ผู้ตรวจสอบ1, ผู้ตรวจสอบ2 และผู้อนุมัติ มารับงานแทน ในคำขอที่ยังไม่ปิด</li>
	</ol>

	<div class="container">
		<div class="tab-content">

			<div class="panel panel-default panel-space">
				<div class="panel-heading panel-fonting">รายละเอียด</div>
				<div class="panel-body">
					<div class="form-horizontal">
						<div class="form-group required">
							<label class="col-sm-2 control-label">Department</label>
							<div class="col-sm-10">
								<select id="sel_depart" xd="sel_depart" class="form-control input-sm box-search">
									<option value="">กรุณาเลือก</option>
									<option value="2">ผู้ตรวจสอบ 1 ระบบลดหนี้</option>
									<option value="3">ผู้ตรวจสอบ 2 ระบบลดหนี้</option>
									<option value="1">ผู้อนุมัติ ระบบลดหนี้</option>
									<option value="2">ผู้จัดการจังหวัด</option>
									<option value="3">ผู้จัดการ Cluster</option>
									<option value="1">ผู้อำนวยการภาค</option>
									<option value="8">ผู้ลดหนี้ตามเขตพื้นที่</option>
								</select>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">Uemail คนเดิม ที่หมดความรับผิดชอบแล้ว</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" id="auto_old_uemail" class="form-control input-sm box-search" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
									<div class="input-group" style="display:none;">
										<input type="text" id="txt_old_uemail" xd="txt_old_uemail" class="form-control input-sm input-addon-email">
										<div class="input-group-addon">@jasmine.com</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">Uemail คนใหม่ ที่มารับงานแทน</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" id="auto_new_uemail" class="form-control input-sm box-search" placeholder="ค้นหาอัตโนมัติโดย ชื่อ หรืออีเมล์">
									<div class="input-group" style="display:none;">
										<input type="text" id="txt_new_uemail" xd="txt_new_uemail" class="form-control input-sm input-addon-email">
										<div class="input-group-addon">@jasmine.com</div>
									</div>
								</div>
							</div>
						</div>
						<div class="space-br"></div>
						<div class="form-group form-500">
							<div class="col-sm-offset-2 col-sm-10">
								<span class="txt-red">ต้องไปจัดการสิทธิ์ [เพิ่มสิทธิ์ให้ user ใหม่] และ [expire user เดิม] ให้เรียบร้อยก่อน</span>
							</div>
						</div>
						<div class="form-group form-500">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="form-inline">
									<button type="button" class="btn btn-primary btn-sm" id="btn_s">
										<span class="glyphicon glyphicon-search" aria-hidden="true"></span> ค้นหา
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="panel panel-default panel-space" id="div_sql" style="display:none;">
				<div class="panel-heading panel-fonting">
					<div class="form-inline">
						<button type="button" class="btn btn-danger btn-sm" onclick="copyToClipboard('#str_sql')">
							<span class="glyphicon glyphicon-copy" aria-hidden="true"></span> Copy SQL
						</button>
					</div>
				</div>
				<div class="panel-body">
					<span id="str_sql"></span>
				</div>
			</div>
		</div>
	</div>
</form>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">

<script type="text/javascript" src="App_Inc/_js/check_required.js?v=38"></script>
<!-- <script type="text/javascript" src="App_Inc/_js/redebt_operator.js?v=3888"></script> -->

<script type="text/javascript">
$(document).ready(function() { 
	$('#page_loading').fadeOut();
});

$('#btn_s').click(function() {
	$('#div_sql').hide();

	if (!checkSubmit('required')) { // ถ้าช่อง required มีค่าว่าง
		modalAlert("กรุณากรอกข้อมูลให้ครบถ้วน");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('.error:first').focus();
		})
	}
	else{ // go
		strReplaceUserify();
	}
});

function copyText() {
  var txt = document.getElementById("str_sql");

  txt.select();

  document.execCommand("copy");

  modalAlert("Copied the text: " + txt.value);
}

function copyToClipboard(element) {
  var $temp = $("<input>");
  $("body").append($temp);
  $temp.val($(element).text()).select();
  document.execCommand("copy");
  $temp.remove();

  modalAlert("Copied the text.");
}

function strReplaceUserify() {
	var url = "json_default.aspx?qrs=strReplaceUserify&old_uemail=" + $('#txt_old_uemail').val() + "&new_uemail=" + $('#txt_new_uemail').val() + "&depart_id=" + $('#sel_depart').val();
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				$('#str_sql').html(data);
				$('#div_sql').show();
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

function source_depart_user(request, response) {
	var url = "json_redebt.aspx?qrs=autoDepartUser&kw=" + request.term;
	console.log(url)

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		success: function( data ) {
			response( $.map( data, function( item ) {
				var user_desc = "";

				if(item.user_desc != ""){
					user_desc = " / " + item.user_desc;
				}

				return {
					uemail: item.uemail,
					desc: item.jas_thaiFullname + " / " + item.jas_position + " / " + item.jas_department,
					label: item.uemail + "@jasmine.com / " + item.jas_thaiFullname + " / " + item.jas_position + " / " + item.jas_department + user_desc,
					value: item.uemail + "@jasmine.com"
				}
			}));
		},
		error: function() {
			console.log("autocomplete fail!!");
			$('#page_loading').fadeOut();
		}
	});
}

//////////////////////////////////////////////////////////////////

$('#auto_old_uemail').autocomplete({
	minLength: 3,
	focus: function(event, ui) {
		event.preventDefault();
		$("#auto_old_uemail-search").val(ui.item.label);
	},
	source: function( request, response ) {
		source_depart_user(request, response);
	}
});

$('#auto_old_uemail').on('autocompleteselect', function (e, ui) {
	$('input[xd="txt_old_uemail"]').val(ui.item.uemail);
});

$('#auto_old_uemail').click(function(){
	$('#auto_old_uemail').val("");
});

$('#auto_old_uemail').focusout(function() {
	$('#auto_old_uemail').val("");

	if($('input[xd="txt_old_uemail"]').val().trim().length > 0){
		$('#auto_old_uemail').val($('input[xd="txt_old_uemail"]').val()+"@jasmine.com");
	}
});

//////////////////////////////////////////////////////////////////

$('#auto_new_uemail').autocomplete({
	minLength: 3,
	focus: function(event, ui) {
		event.preventDefault();
		$("#auto_new_uemail-search").val(ui.item.label);
	},
	source: function( request, response ) {
		source_depart_user(request, response);
	}
});

$('#auto_new_uemail').on('autocompleteselect', function (e, ui) {
	$('input[xd="txt_new_uemail"]').val(ui.item.uemail);
});

$('#auto_new_uemail').click(function(){
	$('#auto_new_uemail').val("");
});

$('#auto_new_uemail').focusout(function() {
	$('#auto_new_uemail').val("");

	if($('input[xd="txt_new_uemail"]').val().trim().length > 0){
		$('#auto_new_uemail').val($('input[xd="txt_new_uemail"]').val()+"@jasmine.com");
	}
});
</script>

</asp:Content>
