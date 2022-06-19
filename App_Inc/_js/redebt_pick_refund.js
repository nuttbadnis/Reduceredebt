var temp_account_number_to = "";
var temp_account_name_to = "";
var temp_tx01 = "";

var temp_bank_code = "0"; // ธนาคาร
var temp_fx01 = ""; // รหัสาขา
var temp_fx02 = ""; // เลขที่บัญชี
var temp_mx03 = ""; // ชื่อบัญชี

$('#sel_pick_refund').change(function() {
	setPickRefund();
});

function setPickRefund(){
	var str = $('#sel_pick_refund').val();

	if(str.trim().length > 0) {
		//keep temp input
		if($('input[xd="txt_account_number_to"]').val() != "null"){
			temp_account_number_to = $('input[xd="txt_account_number_to"]').val();
		}
		if($('input[xd="txt_account_name_to"]').val() != "null"){
			temp_account_name_to = $('input[xd="txt_account_name_to"]').val();
		}
		if($('textarea[xd="txt_tx01"]').val() != "null"){
			temp_tx01 = $('textarea[xd="txt_tx01"]').val();
		}
		if($('input[xd="txt_fx01"]').val() != "null"){
			temp_fx01 = $('input[xd="txt_fx01"]').val();
		}
		if($('input[xd="txt_fx02"]').val() != "null"){
			temp_fx02 = $('input[xd="txt_fx02"]').val();
		}
		if($('input[xd="txt_mx03"]').val() != "null"){
			temp_mx03 = $('input[xd="txt_mx03"]').val();
		}
		if($('input[xd="hide_bank_code"]').val() != "0"){
			temp_bank_code = $('input[xd="hide_bank_code"]').val();
		}
		//keep temp input

		//clear input null
		$('textarea[xd="txt_tx01"]').val("null");
		$('input[xd="txt_account_number_to"]').val("null");
		$('input[xd="txt_account_name_to"]').val("null");

		$('input[xd="txt_fx01"]').val("null");
		$('input[xd="txt_fx02"]').val("null");
		$('input[xd="txt_mx03"]').val("null");
		$('input[xd="hide_bank_code"]').val("0");
		//clear input null

		var objson = jQuery.parseJSON(str);

		$('.refund0').hide();
		$('textarea[xd="txt_tx01"]').attr("placeholder", "กรอกรายละเอียด..");
		$('input[xd="hide_pick_refund"]').val(objson.id);
		$('.label-pick-refund').text($('#sel_pick_refund option:selected').text());

		if(objson.type == 3){
			//refund type 3 = ออกใบเสร็จใหม่ที่ Account และคืนเงินบางส่วน

			$('textarea[xd="txt_tx01"]').val(temp_tx01);
			$('input[xd="txt_account_number_to"]').val(temp_account_number_to);
			$('input[xd="txt_account_name_to"]').val(temp_account_name_to);

			$('.label-pick-refund1').text("ยอดคืนเงินบางส่วน");
			$('.label-pick-refund2').text($('#sel_pick_refund option:selected').text());
			$('.refund3').hide();
			$('.refund2').show();
			$('.refund1').show();
		}
		else if(objson.type == 2){
			//refund type 2 = ออกใบเสร็จใหม่ที่ Account / โยกยอดไปที่ Account

			$('input[xd="txt_account_number_to"]').val(temp_account_number_to);
			$('input[xd="txt_account_name_to"]').val(temp_account_name_to);

			$('.label-pick-refund2').text($('#sel_pick_refund option:selected').text());
			$('.refund3').hide();
			$('.refund2').show();
			$('.refund1').hide();
		}
		else if(objson.type == 1){
			//refund type 1 = คืนเงินเข้าบัตรเครดิตลูกค้า / คืนเงินกรณีพิเศษ / ไม่คืนเงินลูกค้า

			$('textarea[xd="txt_tx01"]').val(temp_tx01);

			$('.label-pick-refund1').text($('#sel_pick_refund option:selected').text());
			$('.refund3').hide();
			$('.refund2').hide();
			$('.refund1').show();
		}
		else{
			//refund type 0 = ลูกค้าต้องการคืนเงินเป็น
			// เดิม ลูกค้าต้องการคืนเงินเป็น เป็น type 1
			// แต่เปลี่ยนเป็น 0 เพื่อเก็บ ข้อมูลธนาคาเพิ่มอีก 4 field

			$('textarea[xd="txt_tx01"]').attr("placeholder", "โอน/เช็ค");
			$('textarea[xd="txt_tx01"]').val(temp_tx01);

			$('input[xd="hide_bank_code"]').val(temp_bank_code);
			$('input[xd="txt_fx01"]').val(temp_fx01);
			$('input[xd="txt_fx02"]').val(temp_fx02);
			$('input[xd="txt_mx03"]').val(temp_mx03);

			if($('#sel_bank_code').val() == 0){
				loadBankCode();
			}

			$('.label-pick-refund1').text($('#sel_pick_refund option:selected').text());
			$('.refund3').show();
			$('.refund2').hide();
			$('.refund1').show();
		}
	}
	else {
		$('.refund3').hide();
		$('.refund2').hide();
		$('.refund1').hide();
		$('.refund0').show();
	}
}

function loadPickRefund(){
	var $el = $('#sel_pick_refund');
	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด.."));

	var url = "json_redebt.aspx?qrs=loadPickRefund&subject_id=" + $('input[xd="hide_subject_id"]').val();
	console.log(url);

	$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				if(data.length > 0){
					if(data.length == 1){
						$el.empty();
						$el.append($("<option></option>")
							.attr("value", "").text("กรุณาเลือก"));

						$.each(data,function( i,item ) {
							$el.append($("<option></option>")
								.attr("selected","selected").attr("value", '{"id":"' + item.pick_refund_id + '","type":"' + item.pick_refund_type + '"}').text(item.pick_refund_title));
						});

						setPickRefund();
					}
					else {
						$el.empty();
						$el.append($("<option></option>")
							.attr("value", "").text("กรุณาเลือก"));

						$.each(data,function( i,item ) {
							if(item.pick_refund_id == getHidePickRefund()){
								$el.append($("<option></option>")
									.attr("selected","selected").attr("value", '{"id":"' + item.pick_refund_id + '","type":"' + item.pick_refund_type + '"}').text(item.pick_refund_title));
							}
							else{
								$el.append($("<option></option>")
									.attr("value", '{"id":"' + item.pick_refund_id + '","type":"' + item.pick_refund_type + '"}').text(item.pick_refund_title));
							}
						});

						setPickRefund();
					}
				}
				else {
					$el.empty();
					$el.append($("<option></option>")
						.attr("value", "").text("ไม่มีตัวเลือก"));
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

function getHidePickRefund() {
	var pick_refund = "";

	if (typeof $('input[xd="hide_pick_refund"]').val() != 'undefined') {

		if($('input[xd="hide_pick_refund"]').val().trim().length > 0){
			pick_refund = $('input[xd="hide_pick_refund"]').val();
		}
	}

	return pick_refund;
}

function loadCheckEditRefund(){
	// เงื่อนไข ที่จะให้แก้ไข วิธีการคืนเงิน
	// 1 คำขอที่เลือกวิธีการคืนเงิน ที่มีการเบิก epay
	// 2 ปิดคำขอแล้ว
	// 3 ยังไม่มี rp_no

	var url = "json_redebt.aspx?qrs=loadCheckEditRefund&request_id=" + _GET('request_id');
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				if(data[0].request_status == 100 && itemBlank(data[0].rp_no) == ""){
					$('button[xd="btn_modal_edit_refund"]').show();

					if($('#sel_edit_bank_code').val() == 0){
						loadEditBankCode();
					}
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

$('button[xd="btn_modal_edit_refund"]').click(function() {
	$('#modal_edit_refund').modal("show");
});

$('#btn_edit_refund_submit').click(function() {
	if($('#sel_edit_refund').val() == ""){
		modalAlert('กรุณาเลือก "ลูกค้าต้องการให้คืนเงินเป็น"');
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('#sel_edit_refund').focus();
		})
	}
	else {
		$('#modal_edit_refund').modal("hide");
		submitEditRefund();
	}
});

function submitEditRefund20190515(){
	var edit_tx01 = $('#sel_edit_refund').val();

	if($('#txt_edit_refund').val().trim().length > 0){
		edit_tx01 += " " + $('#txt_edit_refund').val();
	}

	var url = "json_redebt.aspx?qrs=submitEditRefund";

	$.ajax({
		url: url,
		type: "post",
		timeout: 60000,
		cache: false,
		data: { 
			request_id: _GET('request_id'),
			edit_tx01: edit_tx01,
			uemail: $('input[xd="hide_uemail"]').val()
		},
		success: function( res ) {
			// console.log("res = " + res);
			if(res > 0){
				modalAlert('แก้ไขเรียบร้อย คลิกปุ่มปิดเพื่อโหลดหน้าใหม่');
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				})
			}
			else{
				modalAlert('ไม่สำเร็จ');
			}
		},
		error: function(x, t, m) {
			modalAlert('ajax fail!');
		}
	});
}

function submitEditRefund(){
	var url = "json_redebt.aspx?qrs=submitEditRefund";

	$.ajax({
		url: url,
		type: "post",
		timeout: 60000,
		cache: false,
		data: { 
			request_id: _GET('request_id'),
			edit_tx01: $('#sel_edit_refund').val(),
			edit_nx01: $('#sel_edit_bank_code').val(),
			edit_fx01: $('#txt_edit_fx01').val(),
			edit_fx02: $('#txt_edit_fx02').val(),
			edit_mx03: $('#txt_edit_mx03').val(),
			uemail: $('input[xd="hide_uemail"]').val()
		},
		success: function( res ) {
			console.log("res = " + res);
			if(res > 0){
				modalAlert('แก้ไขเรียบร้อย คลิกปุ่มปิดเพื่อโหลดหน้าใหม่');
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					location.reload();
				})
			}
			else{
				modalAlert('ไม่สำเร็จ');
			}
		},
		error: function(x, t, m) {
			modalAlert('ajax fail!');
		}
	});
}

function loadBankCode(){
	var $el = $('#sel_bank_code');
	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด.."));

	var url = "json_redebt.aspx?qrs=loadBankCode";
	console.log(url);

	$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 

				if(data.length > 0){
					$el.empty();
					$el.append($("<option></option>")
						.attr("value", "0").text("กรุณาเลือก"));

					$.each(data,function( i,item ) {
						if(item.bank_code == getHideBankCode()){
							$el.append($("<option></option>")
								.attr("selected","selected").attr("value", item.bank_code).text(item.bank_title));

							$('#inn_bank_title').text(item.bank_title);
						}
						else{
							$el.append($("<option></option>")
								.attr("value", item.bank_code).text(item.bank_title));
						}
					});
				}
				else {
					$el.empty();
					$el.append($("<option></option>")
						.attr("value", "").text("ไม่มีตัวเลือก"));
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

function getHideBankCode() {
	var bank_code = 0;

	if (typeof $('input[xd="hide_bank_code"]').val() != 'undefined') {

		if($('input[xd="hide_bank_code"]').val().trim().length > 0){
			bank_code = $('input[xd="hide_bank_code"]').val();
		}
	}

	return bank_code;
}

$('#sel_bank_code').change(function() {
	$('input[xd="hide_bank_code"]').val($(this).val());
});

function loadEditBankCode(){
	var $el = $('#sel_edit_bank_code');
	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด.."));

	var url = "json_redebt.aspx?qrs=loadBankCode";
	console.log(url);

	$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 

				if(data.length > 0){
					$el.empty();
					$el.append($("<option></option>")
						.attr("value", "0").text("กรุณาเลือก"));

					$.each(data,function( i,item ) {
						$el.append($("<option></option>")
							.attr("value", item.bank_code).text(item.bank_title));
					});
				}
				else {
					$el.empty();
					$el.append($("<option></option>")
						.attr("value", "").text("ไม่มีตัวเลือก"));
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