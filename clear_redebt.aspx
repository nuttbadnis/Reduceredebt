<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/master_request.Master" CodeFile="clear_redebt.aspx.vb" Inherits="clear_redebt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContent" runat="server">
<form id="form1" runat="server" enctype="multipart/form-data">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">

	<ol class="breadcrumb">
		<li class="active">เคลียใบลดหนี้</li>
	</ol>

	<div class="container">
		<div class="tab-content">

			<div class="panel panel-default panel-space">
				<div class="panel-heading panel-fonting">รายละเอียด</div>
				<div class="panel-body">
					<div class="form-horizontal">
						<div class="form-group form-500 required">
							<label class="col-sm-2 control-label">เลขที่คำขอ</label>
							<div class="col-sm-10">
								<div class="form-inline">
									<input type="text" runat="server" id="txt_request_id" xd="txt_request_id" class="form-control input-sm" placeholder="A4017070008" style="text-transform: uppercase">
									<button title="Reload" class="btn btn-primary btn-glyphicon-sm" type="button" id="btn_search_redebt"><span class="glyphicon glyphicon-search"></span></button>
									<span id="redebt_url" class="span-inline"></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">เลขที่ใบลดหนี้:</label>
							<span id="inn_redebt_number" class="col-sm-10 control-label left-label">-</span>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">ใบลดหนี้:</label>
							<span id="inn_redebt_url" class="col-sm-10 control-label left-label">-</span>
						</div>
						<div id="div_submit" style="display:none;">
							<div class="space-br"></div>
							<div class="form-group form-500">
								<div class="col-sm-offset-2 col-sm-10">
									<div class="form-inline">
										<button type="button" class="btn btn-danger btn-sm" id="btn_clear_redebt">
											<span class="glyphicon glyphicon-remove" aria-hidden="true"></span> เคลียใบลดหนี้
										</button>
										<input runat="server" id="btn_clear_redebt_hidden" xd="btn_clear_redebt_hidden" OnServerClick="Submit_Clear" type="submit" style="display:none;">
										<span class="txt-gray">กรุณาตรวจสอบ ใบลดหนี้ให้ถูกต้อง ก่อนเคลียใบลดหนี้</span>
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
	$('#page_loading').fadeOut();
});

$('#btn_clear_redebt').click(function() {
	$('input[xd="btn_clear_redebt_hidden"]').click();
});

$('#btn_search_redebt').click(function() {
	$('#div_submit').hide();
	$('#inn_redebt_number').html("-");
	$('#inn_redebt_url').html("-");

	var request_id = $('input[xd="txt_request_id"]').val();

	if(request_id.trim().length > 0){
		searchRedebtClear(request_id);
	}
	else {
		modalAlert("กรุณากรอกเลขที่คำขอ");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('input[xd="txt_request_id"]').focus();
		})
	}
});

function searchRedebtClear(request_id) {
	var url = "json_redebt.aspx?qrs=searchRedebtClear&request_id=" + request_id;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		timeout: 120000,
		success: function( data ) { 

			if(data.length > 0){
				if(data != "not file"){
					$('#div_submit').show();
					$('#inn_redebt_number').html(data);
					getRedebtFile(request_id);
				}
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

function getRedebtFile(request_id) {
	var url = "json_redebt.aspx?qrs=getRedebtFile&request_id=" + request_id;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		timeout: 120000,
		success: function( data ) { 

			if(data.length > 0){
				if(data != "not file"){
					$('#inn_redebt_url').html(data);
				}
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
</script>

</asp:Content>
