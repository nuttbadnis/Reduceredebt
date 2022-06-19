var not_page_loading = 1;
var temp_acc_redoc = -1;
var temp_elm_redoc = "";

$(document).ready(function() {
	if(_GET('request_id') != null && checkNotEmpty($('input[xd="hide_redoc_no_item"]').val())){
		// โหลดเฉพาะคำขอ 55 แบบล่าสุด (มีเลขที่ใบรับคืนอุปกรณ์*)

		temp_acc_redoc = $('input[xd="txt_account_number"]').val();
		$('#rad_redoc' + $('input[xd="hide_redoc_type"]').val()).prop('checked', true);

		var load_acc = $('input[xd="txt_redoc_account_number_to"]').val();

		if(checkIsEmpty(load_acc)) {
			load_acc = $('input[xd="txt_account_number"]').val();
		}

		displayRedoc();
		loadRedocItem(load_acc, $('input[xd="hide_redoc_no_item"]').val());
		loadRedocAdapter(load_acc, $('input[xd="hide_redoc_no_adapter"]').val());
	}
	else {
		not_page_loading = 0;
	}

	checkChangeAccNum();
});

function checkChangeAccNum() {
	// หากมีการแก้ไข ข้อมูลใบเสร็จ (Account) จะต้องกรอกข้อมูลใบรับคืนอุปกรณ์ใหม่เสมอ
	// console.log("checkChangeAccNum temp_acc_redoc = " + temp_acc_redoc);

	if(temp_acc_redoc != $('input[xd="txt_account_number"]').val()) {
		temp_acc_redoc = $('input[xd="txt_account_number"]').val();

		resetFormReDoc();
		$('input[name="rad_redoc"]').prop('checked', false);
    }

    setTimeout(function() {
    	checkChangeAccNum();
    }, 1000);
}

$('input[name="rad_redoc"]').click(function(){
	resetFormReDoc();
	displayRedoc();
});

$('#sel_redoc_no_item').change(function(){
	if($(this).val() != ""){
		temp_elm_redoc = 'sel_redoc_no_item';
		checkUsedRedocNo($(this).val());

	}
});

$('#sel_redoc_no_adapter').change(function(){
	if($(this).val() != ""){
		temp_elm_redoc = 'sel_redoc_no_adapter';
		checkUsedRedocNo($(this).val());
	}
});

$('#btn_receipt_used_cancle').click(function(){
	$('#'+temp_elm_redoc).val("");
});

function inputHiddenRedoc() {
	if(temp_elm_redoc.indexOf('adap') > -1) {
		countRedocAdapterRQprocess($('#'+temp_elm_redoc).val());
	}
	else {
		countRedocItemRQprocess($('#'+temp_elm_redoc).val());
	}

	var hide_elm_redoc = temp_elm_redoc.replace("sel_", "hide_")
	$('input[xd="' + hide_elm_redoc + '"]').val($('#'+temp_elm_redoc).val());
}

function checkUsedRedocNo(redoc_no){
	var url = "json_redebt.aspx?qrs=checkUsedReceipt&redoc_no=" + redoc_no + "&request_id=" + _GET('request_id');

	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0) {
				$('#txt_alert_receipt_used').html("<b>เคยมี " + data.length + " คำขอ</b> ที่อ้างถึงเอกสาร <br>เลขที่ <b>" + redoc_no + "</b>")
				$('#btn_receipt_used_confirm').replaceWith("<button type='button' class='btn btn-success' data-dismiss='modal' id='btn_receipt_used_confirm' onclick='inputHiddenRedoc(\"" + temp_elm_redoc + "\", 1)'>ยืนยัน</button>");
				$('#modal_alert_receipt_used').modal("show");
			}
			else {
				inputHiddenRedoc();
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

function displayRedoc() {
	if ($('input[xd="txt_account_number"]').val().trim().length == 0) {
		modalAlert("กรุณาระบุ ข้อมูลลูกค้า ก่อน");

		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('input[name="rad_redoc"]').prop('checked', false);
			$('input[xd="txt_account_number"]').focus();
		});
	}
	else {
		if($('#rad_redoc0').prop('checked')){
			$('input[xd="hide_redoc_type"]').val(0);
			$('#div_inn_redoc_account_to').hide();
			$('#div_redoc_account_to').hide();
			$('#div_redoc_account_to .required').removeClass('required');

			if(not_page_loading == 0) {
				loadRedocItem($('input[xd="txt_account_number"]').val());
				loadRedocAdapter($('input[xd="txt_account_number"]').val());
			}

			$('#inn_redoc_type').html("รับอุปกรณ์และ Adapter จาก Account เดียวกัน");
		}
		else if($('#rad_redoc1').prop('checked')){
			$('input[xd="hide_redoc_type"]').val(1);
			$('#div_inn_redoc_account_to').show();
			$('#div_redoc_account_to').show();
			$('#div_redoc_account_to .form-group').addClass('required');

			$('#inn_redoc_type').html("รับอุปกรณ์และ Adapter ต่าง Account");
		}
	}
}
/********************* auto redoc search *********************/

$('.auto-redoc, .auto-redoc_2').focusout(function() {
	$('.auto-redoc').removeClass("txt-blue-highlight");
	$('.auto-redoc_2').removeClass("txt-blue-highlight");
});


$('#btn_account_redoc_search').click(function() {
	$('input[xd="txt_redoc_account_number_to"]').val($('input[xd="txt_redoc_account_number_to"]').val().trim());
	
	var url = "json_redebt.aspx?qrs=searchAccount&account_number=" + $('input[xd="txt_redoc_account_number_to"]').val();
	console.log(url);

	$('.auto-redoc_2').removeClass("txt-blue-highlight");
	$('#search0_redoc').hide();

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			clearAutoReDoc();

			if(data.length > 0) {
				var acc_name = data[0].prefix_name + " " + data[0].first_name + " " + data[0].last_name
				$('input[xd="txt_redoc_account_name_to"]').val(acc_name);

				$('input[xd="txt_redoc_account_number_to"]').addClass("txt-blue-highlight");
				$('input[xd="txt_redoc_account_name_to"]').addClass("txt-blue-highlight");

				$('input[xd="txt_redoc_account_number_to"]').removeClass("error");
				$('input[xd="txt_redoc_account_name_to"]').removeClass("error");

				loadRedocItem($('input[xd="txt_redoc_account_number_to"]').val());
				loadRedocAdapter($('input[xd="txt_redoc_account_number_to"]').val());
			}
			else {
				$('#dis_search_redoc').html($('input[xd="txt_redoc_account_number_to"]').val());
				$('#search0_redoc').fadeIn();
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
});

function loadRedocItem(acc, redoc_no = ""){
	loadRedocForClaim(acc);

	var $el = $('#sel_redoc_no_item');

	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด.."));

	var url = "json_redebt.aspx?qrs=loadRedocItem&acc=" + acc;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			$el.empty();

			if(data.length > 0) {
				$el.append($("<option></option>")
					.attr("value", "").text("กรุณาเลือกใบรับคืนอุปกรณ์"));

				$.each(data,function( i,item ) {
					$el.append($("<option></option>")
						.attr("value", item.redoc_no).text(item.redoc_no));
				});
			}
			else {
				$el.append($("<option></option>")
					.attr("value", "").text("ไม่มีใบรับคืนอุปกรณ์"));
			}

			$el.val(redoc_no);
			not_page_loading = 0;
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

function loadRedocAdapter(acc, redoc_no = ""){
	var $el = $('#sel_redoc_no_adapter');

	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด.."));

	var url = "json_redebt.aspx?qrs=loadRedocAdapter&acc=" + acc;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			$el.empty();

			if(data.length > 0) {
				$el.append($("<option></option>")
					.attr("value", "").text("กรุณาเลือกใบรับคืน Adapter"));

				$.each(data,function( i,item ) {
					$el.append($("<option></option>")
						.attr("value", item.redoc_no).text(item.redoc_no));
				});
			}
			else {
				$el.append($("<option></option>")
					.attr("value", "").text("ไม่มีใบรับคืน Adapter (กรุณาอัพโหลด ไฟล์ใบเสร็จค่าปรับ)"));

				$el.attr("disabled", true);
				$('#div_file_adapter').show();
				$('#div_file_adapter').addClass('required');
				$('#div_sel_adapter').removeClass('required');
			}

			$el.val(redoc_no);
			not_page_loading = 0;
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

function loadRedocForClaim(acc){
	var url = "json_redebt.aspx?qrs=loadRedocForClaim&acc=" + acc;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0) {
				var txt_redoc_claim = "";

				$.each(data,function( i,item ) {
					txt_redoc_claim += "<br>" + (i+1) + ". " + item.F23;
				});

				$('#txt_redoc_claim').html(txt_redoc_claim);
				$('#div_redoc_claim').show();
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

function resetFormReDoc() {
	$('#search0_redoc').hide();
	$('#div_redoc_account_to').hide();

	unCorrect2('input[xd="hide_redoc_type"]');
	unCorrect2('input[xd="txt_redoc_remark"]');
	unCorrect2('input[xd="txt_redoc_account_number_to"]');

	clearAutoReDoc();
}

function clearAutoReDoc() {
	$('#div_redoc_claim').hide();
	$('#div_file_adapter').hide();
	$('#div_file_adapter').removeClass('required');
	$('#div_sel_adapter').addClass('required');
	
	unCorrect2('input[xd="txt_redoc_account_name_to"]');

	unCorrect2('#request_file5');
	unCorrect2('input[xd="hide_redoc_no_item"]');
	unCorrect2('input[xd="hide_redoc_no_adapter"]');
	unCorrect2('#sel_redoc_no_item');
	unCorrect2('#sel_redoc_no_adapter');

	$('#sel_redoc_no_item').empty();
	$('#sel_redoc_no_item').append($("<option></option>")
		.attr("value", "").text("กรุณาเลือก ประเภทใบรับคืน และระบุ Account ก่อน"));

	$('#sel_redoc_no_adapter').attr("disabled", false);
	$('#sel_redoc_no_adapter').empty();
	$('#sel_redoc_no_adapter').append($("<option></option>")
		.attr("value", "").text("กรุณาเลือก ประเภทใบรับคืน และระบุ Account ก่อน"));

	$('.count-redoc-item-close').hide();
	$('.count-redoc-item-process').hide();
	$('.count-redoc-adap-close').hide();
	$('.count-redoc-adap-process').hide();
}

function unCorrect2(el){
	if (typeof $(el).val() != 'undefined') {
		$(el).val("");
		$(el).removeClass("error");
	}
}
/********************* auto redoc search *********************/


/********************* auto redoc count *********************/

function  countRedocItemRQclose(redoc_no){
	var url = "json_redebt.aspx?qrs=countRedocRQclose&redoc_no=" + redoc_no;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		timeout: 120000,
		success: function( data ) { 
			if(data > 0){
				$('.count-redoc-item-close').addClass("btn-count-acc");
			}

			$('.count-redoc-item-close b').html(data);
			$('.count-redoc-item-close').fadeIn();

			statusDotRedocItem()
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

function  countRedocItemRQprocess(redoc_no){
	if(redoc_no.trim().length > 1){
		var url = "json_redebt.aspx?qrs=countRedocRQprocess&redoc_no=" + redoc_no + "&request_id=" + _GET('request_id');
		console.log(url);

		$.ajax({
			url: url,
			cache: false,
			timeout: 120000,
			success: function( data ) { 
				if(data > 0){
					$('.count-redoc-item-process').addClass("btn-count-acc");
				}

				$('.count-redoc-item-process b').html(data);
				$('.count-redoc-item-process').fadeIn();

				countRedocItemRQclose(redoc_no);
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
	else {
		$('.count-redoc-item-close').hide();
		$('.count-redoc-item-process').hide();
	}
}

function  countRedocAdapterRQclose(redoc_no){
	var url = "json_redebt.aspx?qrs=countRedocRQclose&redoc_no=" + redoc_no;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		timeout: 120000,
		success: function( data ) { 
			if(data > 0){
				$('.count-redoc-adap-close').addClass("btn-count-acc");
			}

			$('.count-redoc-adap-close b').html(data);
			$('.count-redoc-adap-close').fadeIn();
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

function  countRedocAdapterRQprocess(redoc_no){
	if(redoc_no.trim().length > 1){
		var url = "json_redebt.aspx?qrs=countRedocRQprocess&redoc_no=" + redoc_no + "&request_id=" + _GET('request_id');
		console.log(url);

		$.ajax({
			url: url,
			cache: false,
			timeout: 120000,
			success: function( data ) { 
				if(data > 0){
					$('.count-redoc-adap-process').addClass("btn-count-acc");
				}

				$('.count-redoc-adap-process b').html(data);
				$('.count-redoc-adap-process').fadeIn();

				countRedocAdapterRQclose(redoc_no);
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
	else {
		$('.count-redoc-adap-close').hide();
		$('.count-redoc-adap-process').hide();
	}
}

function statusDotRedocItem(){
	var redoc_no = $('input[xd="hide_redoc_no_item"]').val();
	var pos_receipt = $('input[xd="txt_doc_number"]').val();

	if(redoc_no.trim().length > 1 && pos_receipt.trim().length > 1){
		var url = "json_redebt.aspx?qrs=statusDotRedocItem&redoc_no=" + redoc_no + "&pos_receipt=" + pos_receipt;
		console.log(url);

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				// console.log(data);

				if(data.length > 0){
					if(itemNull(data[0].count_reccm) == 0) {
						$('#doc_ref_qq').html(itemNull(data[0].doc_ref));
						$('#status_reccm_qq').show();
					}
					else {
						$('#status_reccm_ok').show();
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
}

$('#status_reccm_qq').click(function() {
	$('#doc_ref_qq').show();
});

/********************* auto redoc count *********************/


/********************* pop redoc history *********************/

// var temp_account_number;
// var temp_pophistory = 0;
// extend ใช้การแสดงผลเดียวกับ pop redebt history (redebt_search_redoc.js)

$('.count-redoc-item-process, .count-redoc-item-close').click(function() {
	var redoc_no = $('input[xd="hide_redoc_no_item"]').val();
	$('#acc_num').html(redoc_no);

	redoc_popHistory(redoc_no, _GET('request_id'));
});

$('.count-redoc-adap-process, .count-redoc-adap-close').click(function() {
	var redoc_no = $('input[xd="hide_redoc_no_adapter"]').val();
	$('#acc_num').html(redoc_no);

	redoc_popHistory(redoc_no, _GET('request_id'));
});

function redoc_popHistory(redoc_no, request_id){
	$('#acc_num').html(redoc_no);

	if(temp_pophistory >= 2 && temp_account_number == redoc_no){
		$('#modal_redebt_history').modal('show');
	}
	else {
		temp_account_number = redoc_no;

		loadRedocHistoryInProcess(redoc_no, request_id);
		loadRedocHistoryInClose(redoc_no);
	}
}

function checkredoc_PopHistory(){
	temp_pophistory++;

	if(temp_pophistory >= 2){
		$('#modal_redebt_history').modal('show');
	}
}

function loadRedocHistoryInProcess(redoc_no, request_id){
	var url = "json_redebt.aspx?qrs=loadRedocHistoryInProcess&redoc_no=" + redoc_no + "&request_id=" + request_id;
	console.log(url);

	not_page_loading = 0;
	$.ajax({
		url: url,
		dataType: "json",
		cache: false,
		timeout: 120000,
		success: function( data ) { 
			var txt_html = "";

			$.each(data,function( i,item ) {
				txt_html += "<div class='space-br'></div>" +
				"<div class='row'>" +
				"<div class='col-xs-12'>" +
				"<div class='input-group' style='width: 100%;'>" +
				"<a href='update_" + item.subject_url + ".aspx?request_id=" + item.request_id + "' target='_blank'>" + item.request_id + " <span class='glyphicon icon-new-tab'></span></a>" +
				"<textarea class='form-control' rows='13' readonly>" +
				"สถานะล่าสุด: " + item.last_status +
				"\nเลขที่ใบรับคืนอุปกรณ์: " + itemNull(item.gx01) +
				"\nเลขที่ใบรับคืน Adapter: " + itemNull(item.gx02) +
				"\nขอใบรับคืนต่าง Account: " + itemNull(item.fx03) +
				"\nขอใบลดหนี้ให้ Account: " + itemNull(item.account_number) +
				"\nจำนวนที่ต้องการลดหนี้: " + item.amount + " บาท" +
				"\nเลขที่ใบเสร็จ BCS: " + itemNull(item.bcs_number) +
				"\nเลขที่ใบลดหนี้: " + itemNull(item.redebt_number) +
				"\nเลขที่ E-Pay: " + itemNull(item.rp_no) +
				"\nวันที่สร้าง E-Pay: " + itemNull(item.rp_date) +
				"\nวันทีอนุมัติ E-Pay: " + itemNull(item.prove_date) +
				"\nPaid Date E-Pay: " + itemNull(item.pay_date) +
				"\nDue Date E-Pay: " + itemNull(item.due_date) +
				"</textarea>" +
				"</div>" +
				"</div>" +
				"</div>" +
				"</div>";
			});

			$('.count-acc-in-process b').html(data.length);
			$('#acc_in_process').html(txt_html);
			checkredoc_PopHistory();
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

function loadRedocHistoryInClose(redoc_no){
	var url = "json_redebt.aspx?qrs=loadRedocHistoryInClose&redoc_no=" + redoc_no;
	console.log(url);

	not_page_loading = 0;
	$.ajax({
		url: url,
		dataType: "json",
		cache: false,
		timeout: 120000,
		success: function( data ) { 
			var txt_html = "";

			$.each(data,function( i,item ) {
				txt_html += "<div class='space-br'></div>" +
				"<div class='row'>" +
				"<div class='col-xs-12'>" +
				"<div class='input-group' style='width: 100%;'>" +
				"<a href='update_" + item.subject_url + ".aspx?request_id=" + item.request_id + "' target='_blank'>" + item.request_id + " <span class='glyphicon icon-new-tab'></span></a>" +
				"<textarea class='form-control' rows='13' readonly>" +
				"สถานะล่าสุด: " + item.last_status +
				"\nเลขที่ใบรับคืนอุปกรณ์: " + itemNull(item.gx01) +
				"\nเลขที่ใบรับคืน Adapter: " + itemNull(item.gx02) +
				"\nขอใบรับคืนต่าง Account: " + itemNull(item.fx03) +
				"\nขอใบลดหนี้ให้ Account: " + itemNull(item.account_number) +
				"\nจำนวนที่ต้องการลดหนี้: " + item.amount + " บาท" +
				"\nเลขที่ใบเสร็จ BCS: " + itemNull(item.bcs_number) +
				"\nเลขที่ใบลดหนี้: " + itemNull(item.redebt_number) +
				"\nเลขที่ E-Pay: " + itemNull(item.rp_no) +
				"\nวันที่สร้าง E-Pay: " + itemNull(item.rp_date) +
				"\nวันทีอนุมัติ E-Pay: " + itemNull(item.prove_date) +
				"\nPaid Date E-Pay: " + itemNull(item.pay_date) +
				"\nDue Date E-Pay: " + itemNull(item.due_date) +
				"</textarea>" +
				"</div>" +
				"</div>" +
				"</div>" +
				"</div>";
			});

			$('.count-acc-in-close b').html(data.length);
			$('#acc_in_close').html(txt_html);
			checkredoc_PopHistory();
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

/********************* pop redoc history *********************/


