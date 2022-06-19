///////////////////////// btn_print /////////////////////////
$('#print_request_id').val(_GET('request_id'));

$('button[xd="btn_print"]').click(function() {
	$('input[xd="btn_print_hidden"]').click();
});

///////////////////////// btn_print /////////////////////////

///////////////////////// หัวข้อ 20 /////////////////////////

function checkSubject20Forbidden() {
	var subject_id = $('input[xd="hide_subject_id"]').val();

	if (typeof subject_id != 'undefined') {
		if(subject_id == "902001"){ //902001 = หัวข้อ 20 
			return true;
		}
	}

	return false;
}

function checkOnloadForm20() {
	//เปลี่ยนจากโชว์ input แนบไฟล์ตอน onload > เป็นโชว์ตอนที่จะกรอกใบลดหนี้เอง
	// if(checkSubject20Forbidden() == false){
	// 	$('#div_redebt_file').show();
	// }

	if(checkSubject20Forbidden() == true && $('input[xd="hide_redebt_number"]').val().trim().length == 0 && $('div[xd="edit_redebt"]').css('display') != "none"){
		var txt_alert = "<p style='line-height: 30px; text-decoration: underline;' class='txt-bold'>กรณีหน้างานลดหนี้เองได้</p>"
		txt_alert += "<p style='line-height: 30px;'>กรุณาระบุเลขที่ใบลดหนี้ หลังปิดคำขอ</p>"
		txt_alert += "<h6 class='txt-red' style='font-size: 13px;line-height: 20px;'>**ตรวจสอบเลขที่ใบลดหนี้ให้ถูกต้อง เพราะหากไม่ถูกต้อง จะไม่สามารถบันทึกเบิก E-Payment ได้**</h6>"

		modalAlert(txt_alert);

		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('#sel_redebt_number').focus();
		})
	}
}

///////////////////////// หัวข้อ 20 /////////////////////////

$('#chk_kaysod').click(function(){
	if($('#chk_kaysod').prop("checked")){
		var txt_doc_number = $('input[xd="txt_doc_number"]').val();

		var url = "json_redebt.aspx?qrs=getRedebtPos&pos_receipt=" + txt_doc_number;
		console.log(url);

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				if(data.length > 0){
					setShowTextBoxRedebt()
					$('#div_redebt_file').show();
					$('#div_redebt_file').addClass('required-cn');
					$('[rel="pop_kaysod"]').popover('show');

					$('#sel_redebt_number').append($("<option></option>")
						.attr("value", "555").text("กรอกเลขที่ใบลดหนี้เอง"));
					$('#sel_redebt_number').val("555");

					$('#txt_redebt_number').val(data[0].redebt_number);
					$('#txt_redebt_number').prop('readonly', true);
				}
				else {
					modalAlert("ไม่พบใบลดหนี้ ใบเสร็จขายสดเลขที่ <br><b class='txt-blue'>" + txt_doc_number + "</b>");
					loadRedebtDoc();
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
	else{
		loadRedebtDoc();
	}
});

$('#btn_reload_redebtdoc').click(function() {
	loadRedebtDoc();
});

// $('#sel_redebt_number').change(function() {
// 	if( $(this).val() == 555 ) {
// 		setShowTextBoxRedebt()
// 	}
// 	else{
// 		var cn_url = "<a target='_blank' href='" + $(this).val() + "'>เปิดลิงค์.. (" + $(this).find("option:selected").text() + ")</a>";
// 		$('#redebt_url').html(cn_url);
// 		$('#txt_redebt_number').val("555");
// 	}
// });

$('#sel_redebt_number').change(function() {
	var redebt_url = $(this).val();
	var redebt_number = $(this).find("option:selected").text();

	if(redebt_url == "") {
		$('#redebt_url').html("");
	}
	else if( redebt_url == 555 ) {
		setShowTextBoxRedebt();

		//เปลี่ยนจากโชว์ input แนบไฟล์ตอน onload > เป็นโชว์ตอนที่จะกรอกใบลดหนี้เอง
		$('#div_redebt_file').show();
	}
	else{
		if(checkSubject20Forbidden() == false){
			selectedRedebt(redebt_url, redebt_number);
		} 
		else { //ถ้าเป็นหัวข้อ 20 ต้องเช็คด้วย ว่าออกใบลดหนี้ที่ POS หรือยัง
			var url = "json_redebt.aspx?qrs=countRedebtPOS&cn_no=" + redebt_number;
			console.log(url);

			$.ajax({
				url: url,
				cache: false,
				timeout: 120000,
				success: function( data ) { 
					if(data <= 0){
						var txt_alert = "<p style='line-height: 30px; text-decoration: underline;' class='txt-bold'>ไม่สามารถเลือกใบลดหนี้ได้</p>"
						txt_alert += "<h6 class='txt-red' style='font-size: 13px;line-height: 20px;'>**เนื่องจากเจ้าหน้าที่ยังไม่ได้ออกใบลดหนี้ที่ POS <br>กรุณาออกใบลดหนี้ที่ POS ก่อนการบันทึกด้วยค่ะ**</h6>"

						modalAlert(txt_alert);
						$('#sel_redebt_number').val("");
					}
					else {
						selectedRedebt(redebt_url, redebt_number);
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
});

function selectedRedebt(this_val, this_cn) {
	//selectedRedebt = เลือกใบลดหนี้นี้ได้
	var cn_url = "<a target='_blank' href='" + this_val + "'>เปิดลิงค์.. (" + this_cn + ")</a>";
	$('#redebt_url').html(cn_url);
	$('#txt_redebt_number').val("555");
}

function setShowTextBoxRedebt(){
	$('#sel_redebt_number').hide();
	$('#txt_redebt_number').prop('readonly', false);
	$('#txt_redebt_number').val("");
	$('#txt_redebt_number').show();
	$('#txt_redebt_number').focus();
}

function loadRedebtDoc(){
	$('#redebt_url').html("");
	$('#txt_redebt_number').val("");
	$('#txt_redebt_number').hide();
	$('#sel_redebt_number').show();

	$('#div_redebt_file').removeClass('required-cn');
	$('#div_redebt_file').hide();
	$('#chk_kaysod').prop('checked', false);
	$('#div_kaysod').hide();
	$('.popover').remove();

	if ( $('input[xd="hide_redebt_number"]').val().trim().length == 0 ){

		var $el = $('#sel_redebt_number');
		$el.empty();
		$el.append($("<option></option>")
			.attr("value", "").text("กำลังโหลด.."));

		var url = "json_redebt.aspx?qrs=getRedebtDoc&bcs_receipt=" + $('input[xd="txt_bcs_number"]').val();
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
						.attr("value", "").text("กรุณาเลือก ใบลดหนี้"));

					if(checkSubject20Forbidden() == false){
						$el.append($("<option></option>")
							.attr("value", "555").text("กรอกเลขที่ใบลดหนี้เอง"));
					}

					$.each(data,function( i,item ) {
						$el.append($("<option></option>")
							.attr("value", item.cn_url).text(item.cn_no));
					});
				}
				else {
					$el.empty();
					$el.append($("<option></option>")
						.attr("value", "").text("ยังไม่มีใบลดหนี้"));
					
					if(checkSubject20Forbidden() == false){
						$el.append($("<option></option>")
							.attr("value", "555").text("กรอกเลขที่ใบลดหนี้เอง"));
					}
					else {
						var txt_doc_number = $('input[xd="txt_doc_number"]').val();
						if (typeof txt_doc_number != 'undefined') {
							if(txt_doc_number.substring(0,3).toUpperCase() == "SRC") {
								$('#div_kaysod').show();
							}
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
		
		$('#inn_redebt_number').html("-");
		$('#inn_redebt_url').html("-");
		$('#inn_rp_no').html("-");
		$('#inn_rp_date').html("-");
		$('#inn_prove_date').html("-");
		$('#inn_pay_date').html("-");
		$('#inn_due_date').html("-");
	}
	else {
		$('#inn_redebt_number').html($('input[xd="hide_redebt_number"]').val());
		$('#inn_redebt_url').html("กำลังโหลด..");
		$('#inn_rp_no').html("กำลังโหลด..");
		$('#inn_rp_date').html("กำลังโหลด..");
		$('#inn_prove_date').html("กำลังโหลด..");
		$('#inn_pay_date').html("กำลังโหลด..");
		$('#inn_due_date').html("กำลังโหลด..");

		if( $('input[xd="hide_hide_redebt_file"]').val() == 1 ){
			$('#inn_redebt_url').html("<span class='txt-red'>เฉพาะผู้มีสิทธิ์</span>");
		}
		else {
			var exit = false;
			var url = "json_redebt.aspx?qrs=getRedebtFile&request_id=" + _GET('request_id');
			console.log(url);

			$.ajax({
				url: url,
				cache: false,
				timeout: 120000,
				success: function( data ) { 
					if(data.length > 0){
						if(data != "not file"){
							$('#inn_redebt_url').html(data);
							exit = true;
						}
					}

					//ถ้ามีการอัพโหลดไฟล์ลดหนี้ ให้แสดงใบลดหนี้ที่อัพโหลด
					//แต่ถ้าไม่มี ให้แสดงลิงค์ใบลดหนี้
					if(exit == false){
						url = "json_redebt.aspx?qrs=getRedebtDoc&bcs_receipt=" + $('input[xd="txt_bcs_number"]').val();
						console.log(url);

						$.ajax({
							url: url,
							cache: false,
							dataType: "json",
							timeout: 120000,
							success: function( data ) { 
								// console.log(data);

								if(data.length > 0){
									$.each(data,function( i,item ) {
										if(item.cn_no == $('input[xd="hide_redebt_number"]').val()){
											var cn_url = "<a target='_blank' href='" + item.cn_url + "'>เปิดลิงค์.. (" + item.cn_no + ")</a>";
											$('#inn_redebt_url').html(cn_url);
										}
									});
								}
								else {
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

		getCNepay($('input[xd="hide_redebt_number"]').val());
	}
}

function getCNepay(cn_no){
	var url = "json_redebt.aspx?qrs=getCNepay&cn_no=" + cn_no;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				$('#inn_rp_no').html(itemNull(data[0].rp_no));
				$('#inn_rp_date').html(itemNull(data[0].rp_date));
				$('#inn_prove_date').html(itemNull(data[0].prove_date));
				$('#inn_pay_date').html(itemNull(data[0].pay_date));
				$('#inn_due_date').html(itemNull(data[0].due_date));
			}
			else{
				$('#inn_rp_no').html("-");
				$('#inn_rp_date').html("-");
				$('#inn_prove_date').html("-");
				$('#inn_pay_date').html("-");
				$('#inn_due_date').html("-");
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

$('#btn_submit_redebt').click(function() {
	if (!checkSubmit('required-cn')) { // ถ้าช่อง required-cn มีค่าว่าง
		modalAlert("กรุณาระบุ เลขที่ใบลดหนี้");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('.error:first').focus();
		})
	}
	else{ // บันทึกใบลดหนี้
		if( $('#sel_redebt_number').val() == 555 ){
			$('input[xd="hide_redebt_number"]').val( $('#txt_redebt_number').val());
			$('input[xd="btn_submit_redebt_hidden"]').click();
		}
		else {
			$('input[xd="hide_redebt_number"]').val( $('#sel_redebt_number').find("option:selected").text() );
			$('input[xd="btn_submit_redebt_hidden"]').click();
		}
	}
});