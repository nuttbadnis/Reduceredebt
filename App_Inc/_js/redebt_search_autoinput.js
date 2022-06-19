var not_page_loading = 1;

$('input[name="rad_search"]').click(function(){
	$('#search0').hide();

	if($('#rad_search1').prop("checked")){
		$('#txt_search').attr("placeholder", "640555999");
		$('#btn_account_search').show();
		$('#btn_doc_num_search').hide();
		$('#btn_bcs_num_search').hide();
	}
	else if($('#rad_search2').prop("checked")){
		$('#txt_search').attr("placeholder", "DOTCV05BKKFA/1703/0555");
		$('#btn_account_search').hide();
		$('#btn_doc_num_search').show();
		$('#btn_bcs_num_search').hide();
	}
	else if($('#rad_search3').prop("checked")){
		$('#txt_search').attr("placeholder", "4-BS-BKKFA-201703-0000999");
		$('#btn_doc_num_search').hide();
		$('#btn_account_search').hide();
		$('#btn_bcs_num_search').show();
	}
});

/********************* auto search input *********************/

$('.auto-sch, .auto-sch_2').focusout(function() {
	$('.auto-sch').removeClass("txt-blue-highlight");
	$('.auto-sch_2').removeClass("txt-blue-highlight");
});


$('#btn_account_to_search').click(function() {
	$('input[xd="txt_account_number_to"]').val($('input[xd="txt_account_number_to"]').val().trim());
	
	var url = "json_redebt.aspx?qrs=searchAccount&account_number=" + $('input[xd="txt_account_number_to"]').val();
	console.log(url);

	$('.auto-sch_2').removeClass("txt-blue-highlight");
	$('#search0_2').hide();

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0) {
				var acc_name = data[0].prefix_name + " " + data[0].first_name + " " + data[0].last_name
				$('input[xd="txt_account_name_to"]').val(acc_name);

				$('input[xd="txt_account_number_to"]').addClass("txt-blue-highlight");
				$('input[xd="txt_account_name_to"]').addClass("txt-blue-highlight");

				$('input[xd="txt_account_number_to"]').removeClass("error");
				$('input[xd="txt_account_name_to"]').removeClass("error");
			}
			else {
				$('#dis_search_2').html($('input[xd="txt_account_number_to"]').val());
				$('#search0_2').fadeIn();
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

$('#btn_doc_num_search').click(function() {
	checkSearchReceipt("doc_number");
});

$('#btn_bcs_num_search').click(function() {
	checkSearchReceipt("bcs_number");
});

function checkSearchReceipt(search) {
	$el = $('#txt_search');

	$el.val($el.val().trim());

	if($el.val() != ""){
		searchAutoReceipt(search);
	}
	else {
		modalAlert("กรุณากรอกคำค้น");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$el.focus();
		})
	}
}
function checkCompanyReceipt(company_code, pos_receipt_id){
	var result = false;
	//company_code = "03";
	$('input[xd="hide_company_code"]').val(company_code);
	var txt_subject = $('input[xd="hide_subject_id"]').val();
	console.log("hide_subject_id : "+txt_subject);
		var url = "json_redebt.aspx?qrs=CheckCompanyReceipt&subject_id="+txt_subject+"&company_code="+company_code+"&pos_receipt=" + pos_receipt_id;
			console.log(url);
	
				$.ajax({
					url: url,
					cache: false,
					dataType: "json",
					timeout: 120000,
					async: false,
					success: function( data ) {
						if(data.length > 0) {
							console.log(data[0]);
							if(data[0].chk == '1'){
								result = true;
								var table_redoc_item = "";
								var redoc_item = "";
								table_redoc_item += "<tr>";
								table_redoc_item += "<th>#</th>";
								table_redoc_item += "<th>Account Number</th>";
								table_redoc_item += "<th>เลขที่เอกสาร</th>";
								table_redoc_item += "</tr>";
								for(i=0;i<data.length;i++){
										if(i == "0"){
											redoc_item += data[i].doc;
										}else{
											redoc_item += ","+data[i].doc;
										}
									table_redoc_item += "<tr>";
									table_redoc_item += "<td>"+(i+1)+"</td>";
									table_redoc_item += "<td>"+data[i].account_num+"</td>";
									table_redoc_item += "<td>"+data[i].doc+"</td>";
									table_redoc_item += "</tr>";
								}
								console.log(redoc_item);
								$('#table_redoc_item').html(table_redoc_item);
								$('input[xd="hide_redoc_value"]').val(redoc_item);	
							}else{
								if(data[0].chk == '2'){
									result = true;
								}else{
									var textmsg = data[0].errorMsg;
									modalAlert(textmsg);
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
	console.log("return result : "+result)
	return result;
	
}
function searchAutoReceipt(search, check_used = 0){
	var txt_search = $('#txt_search').val();
	

	if( check_used != 1 ){
		checkUsedReceipt(search, txt_search);
	}
	else {
		var url = "json_redebt.aspx?qrs=searchReceipt&bcs_receipt=" + txt_search;

		if(search == "doc_number"){
			url = "json_redebt.aspx?qrs=searchReceipt&pos_receipt=" + txt_search;
		}

		console.log(url);

		$('.auto-sch').removeClass("txt-blue-highlight");
		$('#search0').hide();

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				if(data.length > 0) {
					console.log("company code : "+data[0].company_code+" recieipt : "+data[0].pos_receipt_id)
					//console.log("test : "+checksubjectdoc(data[0].company_code,data[0].pos_receipt_id))
					if( checkCompanyReceipt(data[0].company_code,data[0].pos_receipt_id) == true ){
						$('input[xd="txt_doc_number"]').val(data[0].pos_receipt_id);
						$('input[xd="txt_bcs_number"]').val(data[0].bcs_receipt_id);
						$('input[xd="txt_account_number"]').val(data[0].account_num);
						$('input[xd="txt_account_name"]').val(data[0].account_name);
						// $('input[xd="txt_amount"]').val("");
						$('input[xd="txt_amount"]').val(data[0].receipt_amount);
						$('#hide_max_amount').val(data[0].receipt_amount);
						$('#span_amount').html("ยอดตามใบเสร็จ <span class='txt-blue-highlight'>" + data[0].receipt_amount + "</span> บาท");
						$('input[xd="txt_dx01"]').val(data[0].receipt_date);
						$('#auto_province_short').val(data[0].province_short);
						$('input[xd="hide_province_short"]').val(data[0].province_short);
						$('input[xd="hide_area_ro"]').val(data[0].ro);
						span_inn_area_ro();

						autoCorrect('input[xd="txt_doc_number"]');
						autoCorrect('input[xd="txt_bcs_number"]');
						autoCorrect('input[xd="txt_account_number"]');
						autoCorrect('input[xd="txt_account_name"]');
						autoCorrect('input[xd="txt_amount"]');
						autoCorrect('input[xd="txt_dx01"]');
						autoCorrect('#auto_province_short');

						count_acc_RQprocess($('input[xd="txt_account_number"]').val());

						recommendOperator();
						checkReceiptOther();
						checkNotRefund();
					}else{
						resetAutoReceipt();
					}
				}
				else {
					if(search == "doc_number"){
						searchReceiptPOS();
					}
					else{
						resetAutoReceipt();
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

function searchReceiptPOS(){
	var url = "json_redebt.aspx?qrs=searchReceiptPOS&doc_number=" + $('#txt_search').val();

	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0) {
				console.log("company code : "+data[0].company_code+" recieipt : "+data[0].pos_receipt_id)
				//console.log("test : "+checksubjectdoc(data[0].company_code,data[0].pos_receipt_id))
					if( checkCompanyReceipt(data[0].company_code,data[0].pos_receipt_id) == true ){
					$('input[xd="txt_doc_number"]').val(data[0].pos_receipt_id);
					$('input[xd="txt_bcs_number"]').val(data[0].bcs_receipt_id);
					$('input[xd="txt_account_number"]').val(data[0].account_num);
					$('input[xd="txt_account_name"]').val(data[0].account_name);
					// $('input[xd="txt_amount"]').val("");
					$('input[xd="txt_amount"]').val(data[0].receipt_amount);
					$('#hide_max_amount').val(data[0].receipt_amount);
					$('#span_amount').html("ยอดตามใบเสร็จ <span class='txt-blue-highlight'>" + data[0].receipt_amount + "</span> บาท");
					$('input[xd="txt_dx01"]').val(data[0].receipt_date);
					$('#auto_province_short').val(data[0].province_short);
					$('input[xd="hide_province_short"]').val(data[0].province_short);
					$('input[xd="hide_area_ro"]').val(data[0].ro);
					span_inn_area_ro();

					count_acc_RQprocess($('input[xd="txt_account_number"]').val());

					autoCorrect('input[xd="txt_doc_number"]');
					autoCorrect('input[xd="txt_bcs_number"]');
					autoCorrect('input[xd="txt_account_number"]');
					autoCorrect('input[xd="txt_account_name"]');
					autoCorrect('input[xd="txt_amount"]');
					autoCorrect('input[xd="txt_dx01"]');
					autoCorrect('#auto_province_short');

					recommendOperator();
					checkReceiptOther();
					checkNotRefund();
			
				}else{
					resetAutoReceipt();
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

function autoCorrect(el){
	if (typeof $(el).val() != 'undefined') {
		if($(el).val().trim().length > 0){
			$(el).addClass("txt-blue-highlight");
			$(el).removeClass("error");
			$(el).prop('readonly', true);

			if(el == 'input[xd="txt_amount"]'){
				$(el).prop('readonly', false);
			}

			if(el == 'input[xd="txt_dx01"]'){
				$(el).prop('readonly', true).datepicker("destroy");;
			}

			if(el == '#auto_province_short'){
				$(el).attr("placeholder", $(el).val());
			}
		}
		else {
			$(el).removeClass("txt-blue-highlight");
			$(el).prop('readonly', false);

			if(el == 'input[xd="txt_dx01"]'){
				$(el).prop('readonly', false).datepicker();
			}

			if(el == '#auto_province_short'){
				$(el).attr("placeholder", "ค้นหาอัตโนมัติโดย ชื่อ หรือรหัสจังหวัด");
			}
		}
	}
}

function resetAutoReceipt() {
	$('#dis_search').html($('#txt_search').val());
	$('#search0').fadeIn();
	$('#span_amount').html("");

	$('#div_oth').hide();
	$('#div_src').hide();
	$('#div_bcs').show();
	$('#div_pos').show();

	unCorrect('input[xd="txt_doc_number"]');
	unCorrect('input[xd="txt_bcs_number"]');
	unCorrect('input[xd="txt_account_number"]');
	unCorrect('input[xd="txt_account_name"]');
	unCorrect('input[xd="txt_amount"]');
	unCorrect('input[xd="txt_dx01"]');
	unCorrect('#auto_province_short');

	$('#auto_province_short').attr("placeholder", "BKK");
	$('input[xd="hide_province_short"]').val("");
	$('input[xd="hide_area_ro"]').val("");
	span_inn_area_ro();

	checkNotRefund();
}

function unCorrect(el){
	if (typeof $(el).val() != 'undefined') {
		$(el).val("");
		$(el).removeClass("error");
		$(el).prop('readonly', true);
	}
}

function checkUsedReceipt(search, receipt){
	var url = "json_redebt.aspx?qrs=checkUsedReceipt&bcs_receipt=" + receipt;

	if(search == "doc_number"){
		url = "json_redebt.aspx?qrs=checkUsedReceipt&pos_receipt=" + receipt;
	}

	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0) {
				$('#txt_alert_receipt_used').html("<b>เคยมี " + data.length + " คำขอ</b> ที่อ้างถึงเอกสาร <br>เลขที่ <b>" + $('#txt_search').val() + "</b>")
				$('#btn_receipt_used_confirm').replaceWith("<button type='button' class='btn btn-success' data-dismiss='modal' id='btn_receipt_used_confirm' onclick='searchAutoReceipt(\"" + search + "\", 1)'>ยืนยัน</button>");
				$('#modal_alert_receipt_used').modal("show");
			}
			else {
				searchAutoReceipt(search, 1);
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

$('#span_amount').click(function() {
	$el = $('input[xd="txt_amount"]');
	$el.val($('#hide_max_amount').val());
	$el.addClass("txt-blue-highlight");
	$el.removeClass("error");

	checkNotRefund();
});

$('input[xd="txt_amount"]').focusout(function() {
	checkNotRefund();
});

function checkNotRefund(){
	if (typeof $('#sel_pick_refund').val() != 'undefined') {
		var exists = false;
		var len = 0;

		$('#sel_pick_refund option').each(function(){
			len += 1;

			if (this.value == '{"id":"90","type":"1"}') {
				exists = true;
			}
		});

		if($('input[xd="txt_amount"]').val() == 0 && exists == true){
			$('#sel_pick_refund').val('{"id":"90","type":"1"}');
		}
		else if(len > 2){
			$('#sel_pick_refund').val("");
		}

		setPickRefund();
	}
}

/********************* auto search input *********************/


/********************* autocomplete shop code *********************/

$('#auto_province_short').autocomplete({
	minLength: 2,
	focus: function(event, ui) {
		event.preventDefault();
		$("#auto_province_short-search").val(ui.item.label);
	},
	source: function( request, response ) {
		// var url = "json_redebt.aspx?qrs=autoShopCode&kw=" + request.term;
		// console.log(url)

		// $.ajax({
		// 	url: url,
		// 	cache: false,
		// 	dataType: "json",
		// 	success: function( data ) {
		// 		response( $.map( data, function( item ) {
		// 			return {
		// 				ro: item.ro,
		// 				label: item.shop_code + ": " + item.shop_name + " / " + item.province_name + " / RO" + item.ro ,
		// 				value: item.shop_code
		// 			}
		// 		}));
		// 	},
		// 	error: function() {
		// 		console.log("autocomplete fail!!");
		// 		$('#page_loading').fadeOut();
		// 	}
		// });
		var url = "json_redebt.aspx?qrs=autoProvince&kw=" + request.term;
		console.log(url)

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			success: function( data ) {
				response( $.map( data, function( item ) {
					return {
						ro: item.ro,
						label: item.province_name + " / " + item.province_short + " / " + item.cluster + " / RO" + item.ro ,
						value: item.province_short
					}
				}));
			},
			error: function() {
				console.log("autocomplete fail!!");
				$('#page_loading').fadeOut();
			}
		});
	}
});

$('#auto_province_short').on('autocompleteselect', function (e, ui) {
	$('input[xd="hide_province_short"]').val(ui.item.value);
	$('input[xd="hide_area_ro"]').val(ui.item.ro);
	span_inn_area_ro();

	recommendOperator();
});

$('#auto_province_short').click(function(){
	$('#auto_province_short').val("");
});

$('#auto_province_short').focusout(function() {
	$('#auto_province_short').val("");
	
	if($('input[xd="hide_province_short"]').val().trim().length > 0){
		$('#auto_province_short').val($('input[xd="hide_province_short"]').val());
	}
});

function loadAutoBoxShopCode(){
	$('#auto_province_short').val($('input[xd="hide_province_short"]').val());
	$('#inn_shop_code').html($('input[xd="hide_province_short"]').val());

	$('#auto_province_short').attr("placeholder", $('input[xd="hide_province_short"]').val());

	span_inn_area_ro();
}

function span_inn_area_ro(){
	$('#span_area_ro').html("");

	if($('input[xd="hide_area_ro"]').val().trim().length > 0){
		$('#span_area_ro').html("RO" + $('input[xd="hide_area_ro"]').val() + "");
		$('#inn_area_ro').html("(RO" + $('input[xd="hide_area_ro"]').val() + ")");
	}
}
/********************* autocomplete shop code *********************/


/********************* auto count acc *********************/

function count_acc_RQclose(account_number){
	var url = "json_redebt.aspx?qrs=count_acc_RQclose&account_number=" + account_number;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		timeout: 120000,
		success: function( data ) { 
			if(data > 0){
				$('.count-acc-close').addClass("btn-count-acc");
			}

			$('.count-acc-in-close b').html(data);
			$('.count-acc-close b').html(data);
			$('.count-acc-close').fadeIn();
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

function count_acc_RQprocess(account_number){
	var url = "json_redebt.aspx?qrs=count_acc_RQprocess&account_number=" + account_number + "&request_id=" + _GET('request_id');
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		timeout: 120000,
		success: function( data ) { 
			if(data > 0){
				$('.count-acc-process').addClass("btn-count-acc");
			}

			$('.count-acc-in-process b').html(data);
			$('.count-acc-process b').html(data);
			$('.count-acc-process').fadeIn();

			count_acc_RQclose(account_number);
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

$('input[xd="txt_account_number"]').focusout(function() {
	var account_number = $('input[xd="txt_account_number"]').val();

	if( account_number.trim().length == 9 ){
		count_acc_RQprocess(account_number);
	}
	else {
		$('.count-acc-close').hide();
		$('.count-acc-process').hide();
	}
});

/********************* auto count acc *********************/


/********************* pop redebt history *********************/

var temp_account_number;
var temp_pophistory = 0;

$('.count-acc-process, .count-acc-close').click(function() {
	var account_number = $('input[xd="txt_account_number"]').val();
	$('#acc_num').html(account_number);

	popHistory(account_number, _GET('request_id'));
});

function popHistory(account_number, request_id){
	$('#acc_num').html(account_number);

	if(temp_pophistory >= 2 && temp_account_number == account_number){
		$('#modal_redebt_history').modal('show');
	}
	else {
		temp_account_number = account_number;

		loadRedebtHistoryInProcess(account_number, request_id);
		loadRedebtHistoryInClose(account_number);
	}
}

function checkPopHistory(){
	temp_pophistory++;

	if(temp_pophistory >= 2){
		$('#modal_redebt_history').modal('show');
	}
}

function loadRedebtHistoryInProcess(account_number, request_id){
	var url = "json_redebt.aspx?qrs=loadRedebtHistoryInProcess&account_number=" + account_number + "&request_id=" + request_id;
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
				"<textarea class='form-control' rows='9' readonly>" +
				"สถานะล่าสุด: " + item.last_status +
				"\nจำนวนที่ต้องการลดหนี้: " + item.amount + " บาท" +
				"\nเลขที่ใบเสร็จ BCS: " + item.bcs_number +
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
			checkPopHistory();
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

function loadRedebtHistoryInClose(account_number){
	var url = "json_redebt.aspx?qrs=loadRedebtHistoryInClose&account_number=" + account_number;
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
				"<textarea class='form-control' rows='9' readonly>" +
				"สถานะล่าสุด: " + item.last_status +
				"\nจำนวนที่ต้องการลดหนี้: " + item.amount + " บาท" +
				"\nเลขที่ใบเสร็จ BCS: " + item.bcs_number +
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
			checkPopHistory();
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

/********************* pop redebt history *********************/



/********************* load Cause สาเหตุ *********************/
jQuery.fn.exists = function(){ return this.length > 0; }

$('select[xd="sel_title"]').change(function() {
	// if ($('select[xd="sel_cause"]').exists() && $(this).val().trim().length > 0){
		loadCause($(this).val());
	// }
});

function loadCause(request_title_id, redebt_cause_id = ""){
	if (request_title_id == null)
		request_title_id = "";
	
	var $el = $('select[xd="sel_cause"]');
	// var $el2 = $('span[xd="inn_redebt_cause"]');
	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด.."));

	var url = "json_redebt.aspx?qrs=loadCause&request_title_id=" + request_title_id;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			$el.empty();
			$el.append($("<option></option>")
				.attr("value", "").text("เลือกสาเหตุ"));

			$.each(data,function( i,item ) {
				$el.append($("<option></option>")
					.attr("value", item.redebt_cause_id).text(item.redebt_cause_title));

				// if(item.redebt_cause_id == redebt_cause_id)
				// 	$el2.text(item.redebt_cause_title);

			});

			$el.val(redebt_cause_id);
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
/********************* load Cause สาเหตุ *********************/


/********************* auto default search input *********************/

function autoDefSearchInput() {
	var rReceipt = checkGetBCSReceipt();

	if(rReceipt != "") {
		$('#txt_search').val(rReceipt);
		$('#btn_bcs_num_search').click();
	}
}


function checkGetBCSReceipt(){
	var rReceipt = _GET('bcs_receipt');

	if(rReceipt != null) {
		if(rReceipt != "") {
			return rReceipt;
		}
	}

	return "";
}

/********************* auto default search input *********************/
