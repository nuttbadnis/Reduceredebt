///////////////////////// btn_print /////////////////////////
$('#print_pdf1_request_id').val(_GET('request_id'));
$('#print_pdf2_request_id').val(_GET('request_id'));

$('button[xd="btn_print_pdf1"]').click(function() {
	$('#formprint1').attr('action', 'openprint_invdoc.aspx?pdf=1');
	$('input[xd="btn_print_pdf1_hidden"]').click();
});

$('button[xd="btn_print_pdf2"]').click(function() {
	$('#formprint2').attr('action', 'openprint_invdoc.aspx?pdf=2');
	$('input[xd="btn_print_pdf2_hidden"]').click();
});

$('button[xd="btn_preview_pdf1"]').click(function() {
	$('#formprint1').attr('action', 'openprint_invdoc.aspx?pdf=1&preview=1');
	$('input[xd="btn_print_pdf1_hidden"]').click();
});

$('button[xd="btn_preview_pdf2"]').click(function() {
	$('#formprint2').attr('action', 'openprint_invdoc.aspx?pdf=2&preview=1');
	$('input[xd="btn_print_pdf2_hidden"]').click();
});
///////////////////////// btn_print /////////////////////////

$(document).ready(function() { 
	invdoc_form = "preVat"; // requirement ใหม่ ยกเลิกไม่มี (รวม Vat) แล้ว ให้ใช้ (ก่อน Vat) ทั้งหมด
	loadItemUnit();
	loadItemInvdocTable();
});

function loadItemInvdocTable() {

	if(invdoc_form == "netVat") { // (รวม Vat)
		loadItemInvdocNetVat();
	}
	else if(invdoc_form == "preVat"){ //(ก่อน Vat) invdoc_form == "preVat" 
		loadItemInvdocPreVat();
	}
	else { 
		console.log("no condition");
	}
}

function loadItemUnit() {
	var $el = $('#sel_item_unit');
	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด.."));

	var url = "json_invdoc.aspx?qrs=loadItemUnit";
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			// console.log(data);

			$el.empty();

			$.each(data,function( i,item ) {
				$el.append($("<option></option>")
					.attr("value", item.item_invdoc_unit_id).text(item.item_invdoc_unit_th));
			});
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

function loadItemInvdocNetVat() {
	if($('input[xd="hide_can_edit_item"]').val() > 0){
		$('#click_add_item').show();
	}
	else {
		$('#click_add_item').replaceWith("");
		$('#box_add_item').replaceWith("");
	}

	var url = "json_invdoc.aspx?qrs=loadItemInvdoc&ref_number=" + $('input[xd="hide_ref_number"]').val();
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			// console.log(data);

			var table_item = `
				<table id="table_item" class="table table-striped table-bordered">
					<thead class="txt-bold">
						<tr id="item_row">
							<th>#</th>
							<th>รายการสินค้า</th>
							<th align="right">จำนวน/Quantity</th>
							<th align="right">จำนวนเงิน/Amount(รวม Vat)/บาท</th>
							<th align="right">รหัสบันทึกบัญชี/Account Code</th>
						</tr>
					</thead>
					<tbody>
			`;

			var amount_sum = 0;

			if(data.length > 0){
				$.each(data,function( i,item ) {
					var a_modify = "";

					if($('input[xd="hide_can_edit_item"]').val() > 0){
						a_modify = `
							<div class='btn-group' style='float: right;'>
								<button class='btn btn-default btn-sm' type="button" title="แก้ไขรายการ" onclick="showEditItem('` + item.item_id + `')"><span class="glyphicon icon-edit2 txt-red"></span></button>
								<button class='btn btn-default btn-sm' type="button" title="ลบรายการ" onclick="confirmDeleteItem('` + item.item_id + `','` + item.item_name + `','` + item.item_amount + `')"><span class="glyphicon icon-trash-o txt-red"></span></button>
							</div>
						`;
					}

					table_item += `
						<tr>
							<td>` + (i+1) + `</td>
							<td>` + item.item_name + `</td>
							<td align="right">` + parseInt(item.item_unit_qty).toLocaleString() + `</td>
							<td align="right">` + parseFloatInvDoc(item.item_amount) + `</td>
							<td align="center">` + itemNull(item.account_code) + a_modify + `</td>
						</tr>
					`;

					amount_sum += parseFloat(item.item_amount);
				});
			}

			table_item += `
					</tbody>
					<tfoot class="txt-bold">
						<tr class="warning txt-bold">
							<td align="right" colspan="3">รวมจำนวนเงินที่ได้รับ		</td>
							<td align="right">` + parseFloatInvDoc(amount_sum) + `</td>
						</tr>
					</tfoot>
				</table>
			`;

			$('#table_item').replaceWith(table_item);
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

function loadItemInvdocPreVat() {
	if($('input[xd="hide_can_edit_item"]').val() > 0){
		$('#click_add_item').show();
	}
	else {
		$('#click_add_item').replaceWith("");
		$('#box_add_item').replaceWith("");
	}

	var url = "json_invdoc.aspx?qrs=loadItemInvdoc&ref_number=" + $('input[xd="hide_ref_number"]').val();
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			// console.log(data);

			var table_item = `
				<table id="table_item" class="table table-striped table-bordered">
					<thead class="txt-bold">
						<tr id="item_row">
							<th>#</th>
							<th>รายการสินค้า</th>
							<th align="right">จำนวน/Quantity</th>
							<th align="right">ราคาต่อหน่วย/Unit Price (ก่อน Vat)/บาท</th>
							<th align="right">จำนวนเงิน/Amount(ก่อน Vat)/บาท</th>
							<th align="right">รหัสบันทึกบัญชี/Account Code</th>
						</tr>
					</thead>
					<tbody>
			`;

			var amount_sum = 0;
			var amount_vat = 0;

			if(data.length > 0){
				$.each(data,function( i,item ) {
					var a_modify = "";

					if($('input[xd="hide_can_edit_item"]').val() > 0){
						a_modify = `
							<div class='btn-group' style='float: right;'>
								<button class='btn btn-default btn-sm' type="button" title="แก้ไขรายการ" onclick="showEditItem('` + item.item_id + `')"><span class="glyphicon icon-edit2 txt-red"></span></button>
								<button class='btn btn-default btn-sm' type="button" title="ลบรายการ" onclick="confirmDeleteItem('` + item.item_id + `','` + item.item_name + `','` + item.item_amount + `')"><span class="glyphicon icon-trash-o txt-red"></span></button>
							</div>
						`;
					}

					table_item += `
						<tr>
							<td>` + (i+1) + `</td>
							<td>` + item.item_name + `</td>
							<td align="right">` + parseInt(item.item_unit_qty).toLocaleString() + ` ` + itemNull(item.item_invdoc_unit_th) + `</td>
							<td align="right">` + parseFloatInvDoc(item.item_unit_price) + `</td>
							<td align="right">` + parseFloatInvDoc(item.item_amount) + `</td>
							<td align="left">` + itemNull(item.account_code) + a_modify + `</td>
						</tr>
					`;

					amount_sum += parseFloat(item.item_amount);
				});
			}

			amount_vat = amount_sum*0.07;

			table_item += `
					</tbody>
					<tfoot class="txt-bold">
						<tr class="warning">
							<td align="right" colspan="4">รวม</td>
							<td align="right" id="item_amount_sum">กำลังโหลด..</td>
						</tr>
						<tr class="warning txt-bold">
							<td align="right" colspan="4">Vat 7%</td>
							<td align="right" id="item_amount_vat">กำลังโหลด..</td>
						</tr>
						<tr class="warning txt-bold">
							<td align="right" colspan="4">รวมทั้งหมด</td>
							<td align="right" id="item_amount_total">กำลังโหลด..</td>
						</tr>
					</tfoot>
				</table>
			`;

			$('#table_item').replaceWith(table_item);

			getItemTotalAmount(amount_sum, amount_vat);
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

function getItemTotalAmount(amount_sum, amount_vat) {
	var e_modify = "";
	var request_id = checkTempItem();

	if(request_id != "temp_item"){
		amount_sum = parseFloat(amount_sum).toFixed(2);
		amount_vat = parseFloat(amount_vat).toFixed(2);

		var url = "json_invdoc.aspx?qrs=getItemTotalAmount&request_id=" + request_id + "&item_amount_sum=" + amount_sum + "&item_amount_vat=" + amount_vat;
		console.log(url);

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				console.log(data);

				if(data.length) {
					amount_sum = parseFloat(data[0].item_amount_sum);
					amount_vat = parseFloat(data[0].item_amount_vat);
				}
				else {
					amount_sum = 0;
					amount_vat = 0;
				}

				if($('input[xd="hide_can_edit_item"]').val() > 0){
					e_modify = ` <a title="แก้ไข" href="#" onclick="showItemEditTotalAmount('` + amount_sum + `','` + amount_vat + `')"><span class="glyphicon icon-edit2 txt-red"></span></a> `;
				}

				var amount_total = amount_sum+amount_vat;
				$('#item_amount_sum').html(parseFloatInvDoc(amount_sum) + e_modify);
				$('#item_amount_vat').html(parseFloatInvDoc(amount_vat) + e_modify);
				$('#item_amount_total').html(parseFloatInvDoc(amount_total));
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
		// console.log('else');
		var amount_total = amount_sum+amount_vat;
		$('#item_amount_sum').html(parseFloatInvDoc(amount_sum));
		$('#item_amount_vat').html(parseFloatInvDoc(amount_vat));
		$('#item_amount_total').html(parseFloatInvDoc(amount_total));
	}
}

function insertItemInvdoc() {
    var item_id = $('#hide_item_id').val();
    var ref_number = $('input[xd="hide_ref_number"]').val();
    var item_name = $('#txt_item_name').val();
    var item_unit_qty = $('#txt_item_unit_qty').val();
    var item_unit_price = $('#txt_item_unit_price').val();
    var item_amount = $('#txt_item_amount').val();
    var account_code = $('#txt_account_code').val();
    var item_unit_id = $('#sel_item_unit').val();

    if(ref_number.length > 0 && item_name.length > 0 && item_unit_qty.length > 0 && (item_unit_price.length > 0 || item_amount.length > 0)){
		if(invdoc_form == "netVat") { // (รวม Vat)
    		item_unit_price = 0;
    	}

		if(invdoc_form == "preVat") { // (ก่อน Vat)
    		item_amount = parseFloat(item_unit_price).toFixed(2) * parseInt(item_unit_qty);
    	}
        
        $.ajax({
            url: "json_invdoc.aspx?qrs=insertItemInvdoc",
            cache: false,
            type: "post",
            timeout: 60000,
            data: {  
                create_by: $('input[xd="hide_uemail"]').val(),
                request_id: checkTempItem(),
                ref_number: ref_number,
                item_name: item_name,
                item_unit_qty: parseInt(item_unit_qty),
                item_unit_price: parseFloat(item_unit_price).toFixed(2),
                item_amount: parseFloat(item_amount).toFixed(2),
                account_code: account_code,
                item_unit_id: item_unit_id,
                item_id: item_id,
            },
            success: function( res ) {
            	// console.log("res insertItemInvdoc = [" + res + "]");

            	if(res > 0) {
            		resetBoxAddIem();
            		loadItemInvdocTable();
            	}
                else {
                    modalAlert('บันทึกรายการสินค้า ไม่สำเร็จ');
                }
            },
            error: function(x, t, m) {
                ajaxError();
            }
        });
    }
    else {
        modalAlert("กรุณากรอกข้อมูล รายการสินค้า ให้ครบถ้วน");
    }
}

function insertItemInvdoc_noncalculate() {
    var item_id = $('#hide_item_id').val();
    var ref_number = $('input[xd="hide_ref_number"]').val();
    var item_name = $('#txt_item_name').val();
    var item_unit_qty = $('#txt_item_unit_qty').val();
    var item_unit_price = $('#txt_item_unit_price').val();
    var item_amount = $('#txt_item_amount').val();
    var account_code = $('#txt_account_code').val();
    var item_unit_id = $('#sel_item_unit').val();

    if(ref_number.length > 0 && item_name.length > 0 && item_unit_qty.length > 0 && (item_unit_price.length > 0 || item_amount.length > 0)){

        $.ajax({
            url: "json_invdoc.aspx?qrs=insertItemInvdoc",
            cache: false,
            type: "post",
            timeout: 60000,
            data: {  
                create_by: $('input[xd="hide_uemail"]').val(),
                request_id: checkTempItem(),
                ref_number: ref_number,
                item_name: item_name,
                item_unit_qty: parseInt(item_unit_qty),
                item_unit_price: parseFloat(item_unit_price).toFixed(2),
                item_amount: parseFloat(item_amount).toFixed(2),
                account_code: account_code,
                item_unit_id: item_unit_id,
                item_id: item_id,
            },
            success: function( res ) {
            	// console.log("res insertItemInvdoc = [" + res + "]");

            	if(res > 0) {
            		resetBoxAddIem();
            		loadItemInvdocTable();
            	}
                else {
                    modalAlert('บันทึกรายการสินค้า ไม่สำเร็จ');
                }
            },
            error: function(x, t, m) {
                ajaxError();
            }
        });
    }
    else {
        modalAlert("กรุณากรอกข้อมูล รายการสินค้า ให้ครบถ้วน");
    }
}

function confirmDeleteItem(item_id, item_name, item_amount) {
	resetBoxEditTotalAmount();
	resetBoxAddIem();
	$('#txt_confirm_delete_item').html("ต้องการลบรายการ <b class='txt-red'>" + item_name + " จำนวนเงิน " + parseFloatInvDoc(item_amount) + " บาท</b>")
	$('#btn_delete_item_confirm').replaceWith("<button type='button' class='btn btn-danger' data-dismiss='modal' id='btn_delete_item_confirm' onclick='deleteItemInvdoc(\"" + item_id + "\")'>ยืนยันลบ</button>");
	$('#modal_confirm_delete_item').modal("show");
}

function deleteItemInvdoc(item_id) {
	$.ajax({
		url: "json_invdoc.aspx?qrs=deleteItemInvdoc",
		cache: false,
		type: "post",
		timeout: 60000,
		data: {  
			update_by: $('input[xd="hide_uemail"]').val(),
			item_id: item_id,
		},
		success: function( res ) {
            // console.log("res deleteItemInvdoc = [" + res + "]");

        	if(res > 0) {
        		loadItemInvdocTable();
        	}
        	else {
        		modalAlert('ลบรายการสินค้า ไม่สำเร็จ');
        	}
        },
        error: function(x, t, m) {
        	ajaxError();
        }
    });
}

function showItemInvdoc() {
	resetBoxEditTotalAmount();
	resetBoxAddIem();

	$('#click_add_item').hide();
	$('#box_add_item').show();
	$('#btn_add_item').show();
    $('html, body').animate({scrollTop:$('#box_add_item').position().top -90 }, 500);
}

function resetBoxAddIem() {
	$('#hide_item_id').val("");
	$('#txt_item_name').val("");
	$('#txt_item_unit_qty').val("");
	$('#txt_item_unit_price').val("");
	$('#txt_item_amount').val("");
	$('#txt_account_code').val("");

	$('#btn_add_item').hide();
	$('#btn_update_item').hide();
	$('#box_add_item').hide();
	$('#click_add_item').show();
	$('#div_account_code').hide();

	if($('input[xd="hide_can_edit_item"]').val() == 2){
		$('#div_account_code').show();
	}
    $('html, body').animate({scrollTop:$('#table_item').position().top -90 }, 500);
}

function showEditItem(item_id) {
	var url = "json_invdoc.aspx?qrs=getItemInvdoc&item_id=" + item_id;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0) {
				resetBoxEditTotalAmount();
				resetBoxAddIem();

				$('#click_add_item').hide();
				$('#box_add_item').show();
				$('#btn_update_item').show();
				$('html, body').animate({scrollTop:$('#box_add_item').position().top -90 }, 500);

				var item_name = itemBlank(data[0].item_name);
				var item_unit_qty = itemBlank(data[0].item_unit_qty);
				var item_invdoc_unit_id = itemBlank(data[0].item_invdoc_unit_id);
				var item_unit_price = itemBlank(data[0].item_unit_price);
				var item_amount = itemBlank(data[0].item_amount);
				var account_code = itemBlank(data[0].account_code);

				$('#hide_item_id').val(item_id)
				$('#txt_item_name').val(item_name);
				$('#txt_item_unit_qty').val(item_unit_qty);
				$('#sel_item_unit').val(item_invdoc_unit_id);
				$('#txt_item_unit_price').val(item_unit_price);
				$('#txt_item_amount').val(item_amount);
				$('#txt_account_code').val(account_code);
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

function updateItemTotalAmount() {
    var item_amount_sum = $('#txt_item_amount_sum').val();
    var item_amount_vat = $('#txt_item_amount_vat').val();

    if(item_amount_sum.length > 0 && item_amount_vat.length > 0){
        $.ajax({
            url: "json_invdoc.aspx?qrs=updateItemTotalAmount",
            cache: false,
            type: "post",
            timeout: 60000,
            data: {  
                create_by: $('input[xd="hide_uemail"]').val(),
                request_id: checkTempItem(),
                item_amount_sum: parseFloat(item_amount_sum).toFixed(2),
                item_amount_vat: parseFloat(item_amount_vat).toFixed(2),
            },
            success: function( res ) {
            	// console.log("res updateItemTotalAmount = [" + res + "]");

            	if(res > 0) {
            		resetBoxEditTotalAmount();
            		loadItemInvdocTable();
            	}
                else {
                    modalAlert('บันทึกยอดรวม/Vat ไม่สำเร็จ');
                }
            },
            error: function(x, t, m) {
                ajaxError();
            }
        });
    }
    else {
        modalAlert("กรุณากรอกข้อมูล ยอดรวม/Vat ให้ครบถ้วน");
    }
}

function showItemEditTotalAmount(amount_sum, amount_vat) {
	resetBoxAddIem();
	resetBoxEditTotalAmount();

	$('#txt_item_amount_sum').val(amount_sum);
	$('#txt_item_amount_vat').val(amount_vat);

	$('#click_add_item').hide();
	$('#box_edit_total').show();
    $('html, body').animate({scrollTop:$('#box_edit_total').position().top -220 }, 500);
}

function resetBoxEditTotalAmount() {
	$('#txt_item_amount_sum').val("");
	$('#txt_item_amount_vat').val("");
	$('#click_add_item').show();
	$('#box_edit_total').hide();

    $('html, body').animate({scrollTop:$('#table_item').position().top -90 }, 500);
}

function parseFloatInvDoc(num) {
	num = parseFloat(num);

	return num.toLocaleString(undefined, {
		minimumFractionDigits: 2,
		maximumFractionDigits: 2
	})
}
function parseFloatInvDocpdf(num) {
	num = parseFloatInvDoc(num);
	if(num == "0.00"){
		num = "";	
	}
	return num;
}
function parseIntInvDocpdf(num) {
	num = parseInt(num);
	if(num == "0"){
		num = "";	
	}
	return num;
}

function checkTempItem(){
	var request_id = _GET('request_id');

	if(request_id != null) {
		if(request_id != "") {
			return request_id;
		}
	}

	return "temp_item";
}

$('#btn_submit_invfile').click(function() {
	if (!checkSubmit('required')) { // ถ้าช่อง required มีค่าว่าง
		modalAlert("กรุณากรอกข้อมูลให้ครบ");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('.error:first').focus();
		})
	}
	else{ // บันทึกแนบหลักฐานการชำระเงิน
		$('input[xd="btn_submit_invfile_hidden"]').click();
	}
});

$('#btn_submit_invref').click(function() {
	if (!checkSubmit('required')) { // ถ้าช่อง required มีค่าว่าง
		modalAlert("กรุณากรอกข้อมูลให้ครบ");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('.error:first').focus();
		})
	}
	else{ // บันทึกแนบหลักฐานการชำระเงิน
		$('input[xd="btn_submit_invref_hidden"]').click();
	}
});

function convertThaiNumber(money){
	const THBText = window.THBText

	// This module is very simple to use
	// You just put the number that you want to convert into the first parameter
	// LIKE THIS --> THBText(Number)

	const moneyText = THBText(money)
	return moneyText
}
function convertThaiDate(convertdate){
	if(convertdate == ""){
		return "-";
	}else{
		var split_date = convertdate.split("/");
		const date = new Date(split_date[2], (split_date[1]-1), split_date[0])
		const result = date.toLocaleDateString('th-TH', {
		year: 'numeric',
		month: 'long',
		day: 'numeric',
		})
		console.log(result);
		return result
	}

}

$('select[xd="sel_payment"]').change(function() {
	var payment_id = $(this).val()
	if(payment_id == "20" || payment_id == "30"){
		$('#div_txt_dx04').show();
		$('#div_bank_title').hide();
	}else if(payment_id == "40"){
		$('#div_txt_dx04').show();
		$('#div_bank_title').show();
	}else{
		$('#div_txt_dx04').hide();
		$('#div_bank_title').hide();
	}
});

function loadpayment(){
	var payment_id = $('select[xd="sel_payment"]').val();
	console.log("p_id : "+payment_id);
	if(payment_id == "20" || payment_id == "30"){
		$('#div_txt_dx04').show();
		$('#div_bank_title').hide();
	}else if(payment_id == "40"){
		$('#div_txt_dx04').show();
		$('#div_bank_title').show();
	}else{
		$('#div_txt_dx04').hide();
		$('#div_bank_title').hide();
	}
}
