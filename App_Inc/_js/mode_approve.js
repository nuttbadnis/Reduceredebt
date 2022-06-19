
function callDataTable() {
	var onthetable = $('#onthetable').DataTable({
		bFilter: false
		,paging: false
		,"aaSorting": []
		,"ordering": false
		,"bLengthChange": false
		,"responsive": false
		,"bInfo" : false
	});
}

function reqAprrove(id){
	resetModalConfirm();
	resetBtnApprove();

	$('#btn_app_' + id).hide();
	$('#btn_notapp_' + id).show();
}

function confirmAprrove(id, num_last_update){
	$('#btn_notapp_' + id).replaceWith("<button type='button' class='btn btn-primary btn-sm btn-approve'>ยืนยัน</span></button>");
	$('#tr_' + id).fadeOut(200);
	submitApproveFlow(50, id, num_last_update);
	// 50 = อนุมัติ
}

function reqNotApprove(id, num_last_update){
	resetModalConfirm();
	resetBtnApprove();

	$('#request_id_confirm').html(id);
	$('#hide_request_id_confirm').val(id);
	$('#hide_request_num_last_update').val(num_last_update);

	$('#modal_confirm').modal("show");
}

$('#btn_reply').click(function() {
	$('#body_remark').show();
	$('#txt_flow_remark').focus();
	$('#btn_reply_confirm').show();

	$('#btn_reply').hide();
	$('#btn_not_approve').hide();
});

$('#btn_not_approve').click(function() {
	$('#body_remark').show();
	$('#txt_flow_remark').focus();
	$('#btn_not_approve_confirm').show();

	$('#btn_reply').hide();
	$('#btn_not_approve').hide();
});

$('#btn_reply_confirm').click(function() {
	var remark_confirm = $('#txt_flow_remark').val();
	var id_confirm = $('#hide_request_id_confirm').val();
	var num_last_update = $('#hide_request_num_last_update').val();

	if(remark_confirm.trim().length == 0){
		$('#remark_error').show();
	}
	else {
		$('#modal_confirm').modal("hide");
		$('#tr_' + id_confirm).fadeOut(200);
		submitApproveFlow(30, id_confirm, num_last_update);
		// 30 = ขอข้อมูลเพิ่ม
	}
});

$('#btn_not_approve_confirm').click(function() {
	var remark_confirm = $('#txt_flow_remark').val();
	var id_confirm = $('#hide_request_id_confirm').val();
	var num_last_update = $('#hide_request_num_last_update').val();

	if(remark_confirm.trim().length == 0){
		$('#remark_error').show();
	}
	else {
		$('#modal_confirm').modal("hide");
		$('#tr_' + id_confirm).fadeOut(200);
		submitApproveFlow(55, id_confirm, num_last_update);
		// 55 = ไม่อนุมัติ
	}
});

function resetBtnApprove(){
	$('.btn-2').hide();
	$('.btn-1').show();
}

function resetModalConfirm(){
	$('#request_id_confirm').html("");
	$('#hide_request_id_confirm').val("");
	$('#hide_request_num_last_update').val("");
	$('#txt_flow_remark').val("");

	$('#body_remark').hide();
	$('#remark_error').hide();
	$('#btn_reply_confirm').hide();
	$('#btn_not_approve_confirm').hide();

	$('#btn_reply').show();
	$('#btn_not_approve').show();
}

function submitApproveFlow(flow_status, request_id, num_last_update) {
	$('#count_req').addClass("blink-text");

	var url = "json_redebt.aspx?qrs=submitApproveFlow";
	console.log(url + " request_id=" + request_id + " flow_status=" + flow_status + " num_last_update=" + num_last_update);

	$.ajax({
		url: url,
		cache: false,
		type: "post",
		timeout: 60000,
		data: {  
			request_id: request_id,
			update_by: $('#hide_uemail').val(),
			flow_status: flow_status,
			flow_remark: $('#txt_flow_remark').val(),
			num_last_update: num_last_update
		},
		success: function( res ) {
			console.log("response=" + res);
			if(res == 9) {
				console.log("success!!!! request_id=" + request_id + " flow_status=" + flow_status);
			}
			else if(res == 1) {
				modalAlert('คำขอเลขที่ ' + request_id + ' มีการเปลี่ยนแปลง <br><br>กรุณาปิดแจ้งเตือน ระบบจะโหลดข้อมูลใหม่');
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				})
			}
			else if(res == 2) {
				modalAlert('คำขอเลขที่ ' + request_id + ' Flow Step ไม่ถูกต้อง <br><br>กรุณาติดต่อ support_pos@jasmine.com เพื่อตรวจสอบ');
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				})
			}
			else if(res == 3) {
				modalAlert('คำสั่งอนุมัติคำขอเลขที่ ' + request_id + ' ไม่สำเร็จ <br><br>กรุณาติดต่อ support_pos@jasmine.com เพื่อตรวจสอบ');
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				})
			}
			else {
				modalAlert('คำสั่งอนุมัติคำขอเลขที่ ' + request_id + ' มีปัญหา!!');
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				})
			}
			$('#count_req').html(--count_req);
			$('#count_req').removeClass("blink-text");
		},
		error: function(x, t, m) {
			ajaxError();
		}
	});
}

function sampleDetail(request_id, project_prefix){
	$('#sample_manual').hide();

	if(temp_sample_detail != request_id && loading_sample_detail == 0){
		temp_sample_detail = request_id;
		loading_sample_detail = 1;

		$('.sample-detail').hide();
		$('#sample_load').show();

		if(project_prefix == "A"){
			getRequest_redebt(request_id);
		}
		else if(project_prefix == "B"){
			getRequest_backof(request_id);
		}
		else if(project_prefix == "C"){
			getRequest_ctshop(request_id);
		}
		else{
			getRequest_default(request_id);
		}
	}
}

function getRequest_default(request_id) {
	var url = "json_default.aspx?qrs=getRequest&request_id=" + request_id;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			loading_sample_detail = 0;

			$('#def_request_title').html(itemNull(data[0].request_title));
			$('#def_request_remark').html(itemNull(data[0].request_remark));

			$('#def_province_name').html(itemNull(data[0].province_name));

			$('#def_create_by').html(itemNull(data[0].create_by));
			$('#def_create_date').html(itemNull(data[0].create_date));

			$('#sample_load').hide();
			$('#sample_default').fadeIn();
		},
		error: function(x, t, m) {
			loading_sample_detail = 0;
			ajaxError();
		}
	});
}

function getRequest_redebt(request_id) {
	var url = "json_redebt.aspx?qrs=getRequest&request_id=" + request_id;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			loading_sample_detail = 0;

			var a_pick_refund = data[0].pick_refund_title;

			if(data[0].pick_refund_type == 1){
				a_pick_refund += " (" + itemBlank(data[0].tx01) + ")"
			}
			else if(data[0].pick_refund_type == 2){
				a_pick_refund += " (" + itemBlank(data[0].account_number_to) + " / " + itemBlank(data[0].account_name_to) + ")"
			}
			else if(data[0].pick_refund_type == 3){
				a_pick_refund += " (" + itemBlank(data[0].account_number_to) + " / " + itemBlank(data[0].account_name_to) + " / " + itemBlank(data[0].tx01) + ")"
			}

			$('#a_request_title').html(itemNull(data[0].request_title));
			$('#a_redebt_cause_title').html(itemNull(data[0].redebt_cause_title));
			$('#a_request_remark').html(itemNull(data[0].request_remark));

			$('#a_amount').html(convertAmount(data[0].amount) + " บาท");
			$('#a_pick_refund').html(a_pick_refund);

			$('#a_province_name').html(itemNull(data[0].province_name));
			$('#a_create_by').html(itemNull(data[0].create_by));

			$('#a_create_date').html(itemNull(data[0].create_date));
			$('#a_dx03').html(itemNull(data[0].dx03));

			$('#sample_load').hide();
			$('#sample_redebt').fadeIn();
		},
		error: function(x, t, m) {
			loading_sample_detail = 0;
			ajaxError();
		}
	});
}

function getRequest_backof(request_id) {
	var url = "json_backof.aspx?qrs=getRequest&request_id=" + request_id;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			loading_sample_detail = 0;


			$('#sample_load').hide();
			if(data[0].subject_prefix == 10){
				$('#b10_request_title').html(itemNull(data[0].request_title));
				$('#b10_request_remark').html(itemNull(data[0].request_remark));

				$('#b10_tx01').html(itemNull(data[0].tx01));
				$('#b10_mx01').html(itemNull(data[0].mx01));

				$('#b10_shop_name').html(itemNull(data[0].shop_name));
				$('#b10_province_name').html(itemNull(data[0].province_name));

				$('#b10_create_by').html(itemNull(data[0].create_by));
				$('#b10_create_date').html(itemNull(data[0].create_date));

				$('#sample_backof10').fadeIn();
			}
			else {
				$('#b_request_title').html(itemNull(data[0].request_title));

				$('#b_tx01').html(itemNull(data[0].tx01));

				$('#b_shop_name').html(itemNull(data[0].shop_name));
				$('#b_province_name').html(itemNull(data[0].province_name));

				$('#b_create_by').html(itemNull(data[0].create_by));
				$('#b_create_date').html(itemNull(data[0].create_date));

				$('#sample_backof20').fadeIn();
			}
		},
		error: function(x, t, m) {
			loading_sample_detail = 0;
			ajaxError();
		}
	});
}

function getRequest_ctshop(request_id) {
	var url = "json_ctshop.aspx?qrs=getRequest&request_id=" + request_id;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			loading_sample_detail = 0;

			$('#c_request_title').html(itemNull(data[0].request_title));

			$('#c_create_by').html(itemNull(data[0].create_by));
			$('#c_create_date').html(itemNull(data[0].create_date));

			$('#c_tx01').html(itemNull(data[0].tx01));
			$('#c_request_remark').html(itemNull(data[0].request_remark));

			$('#c_shop_name').html(itemNull(data[0].shop_name));
			$('#c_province_name').html(itemNull(data[0].province_name));
			$('#c_area_ro').html(itemNull(data[0].area_ro));

			$('#c_phase_title').html(itemNull(data[0].phase_title));
			$('#c_storeplacetype_name').html(itemNull(data[0].storeplacetype_name));

			$('#c_ax04').html(itemNullConvertUprentPercent(data[0].ax04));
			$('#c_ax07').html(itemNullConvertAmount(data[0].ax07, "บาท/เดือน (รวม VAT)"));
			$('#c_ax09').html(itemNullConvertAmount(data[0].ax09, "บาท/เดือน"));
			$('#c_ax10').html(itemNullConvertAmount(data[0].ax10, "บาท/เดือน (รวม VAT)"));
			$('#c_ax13').html(itemNullConvertAmount(data[0].ax13, data[0].mx01));
			$('#c_ax16').html(itemNullConvertAmount(data[0].ax16, "บาท"));
			$('#c_ax17').html(itemNullConvertAmount(data[0].ax17, "บาท/เดือน (รวม VAT)"));
			$('#c_ax19').html(itemNullConvertAmount(data[0].ax19, "ตร.ม."));

			$('#sample_load').hide();
			$('#sample_ctshop').fadeIn();
		},
		error: function(x, t, m) {
			loading_sample_detail = 0;
			ajaxError();
		}
	});
}
//-------------------------------------------------------------- page tab bar

function nextCurrentPatch() {
	var url = "json_default.aspx?qrs=loadCurrentPatchModeApprove";

	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				temp_patch_number = data[0].patch_number;

				var html = '<a href="' + data[0].patch_img + '" data-lightbox="updatePatch" id="alert_update"></a>';

				$('#update_patch').html(html);
				$('#alert_update').click();
			}
		},
		error: function(x, t, m) {
			console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);
		}

	});
}

function loadNotReadPatch() {
	var url = "json_default.aspx?qrs=loadNotReadPatchModeApprove";

	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				$.each(data,function( i,item ) {

					var html = '<div class="alert alert-patch info-warning alert-dismissible" role="alert" id="' + item.patch_number + '">' +
					'<a href="' + item.patch_img + '" data-lightbox="' + item.patch_number + '" class="close" onclick="readPatch(\'' + item.patch_number + '\')"><span class="glyphicon glyphicon glyphicon-export"></span> คลิกอ่าน</a>' +
					'<p><span>แจ้งอัพเดท (' + item.patch_date + '): ' + item.patch_title + '</span></p>' +
					'</div>';

					$('.alert-bar').append(html);
				});
				
				$('.alert-bar').slideDown( 300, function() {});
			}
		},
		error: function(x, t, m) {
			console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);
		}
	});
}

//-------------------------------------------------------------- page tab bar
