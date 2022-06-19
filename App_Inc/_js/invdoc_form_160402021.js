$(document).ready(function() { 
	loadItemInvdocTable();
});

function loadItemInvdocTable() {
	if(invdoc_form == "netVat") { // (รวม Vat)
		loadItemInvdocNetVat();
	}
	else if(invdoc_form == "preVat"){ //(ก่อน Vat) invdoc_form == "preVat" 
		loadItemInvdocPreVat();
	}
	else { //(InvdocPDF) invdoc_form == "InvdocPdf" 
		loadItemInvdocPdf();
	}
}

function loadItemInvdocNetVat() {
	if($('input[xd="hide_can_edit_approval"]').val() == 1){
		$('#click_add_item').show();
	}
	else {
		$('#click_add_item').replaceWith("");
		$('#box_add_item').replaceWith();
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
			var table_html = "";

			var table_item = `
				<table id="table_item" class="table table-striped table-bordered">
					<thead class="txt-bold">
						<tr id="item_row">
							<th>#</th>
							<th>รายการสินค้า</th>
							<th align="right">จำนวน/Quantity/ชิ้น</th>
							<th align="right">จำนวนเงิน/Amount(รวม Vat)/บาท</th>
						</tr>
					</thead>
					<tbody>
			`;

			var table_item_view = `
				<table id="table_item_view" class="table table-striped table-bordered">
					<thead class="txt-bold">
						<tr id="item_row">
							<th>#</th>
							<th>รายการสินค้า</th>
							<th align="right">จำนวน/Quantity/ชิ้น</th>
							<th align="right">จำนวนเงิน/Amount(รวม Vat)/บาท</th>
						</tr>
					</thead>
					<tbody>
			`;

			var sum_amount = 0;

			if(data.length > 0){
				$.each(data,function( i,item ) {
					var a_del = "";

					if($('input[xd="hide_can_edit_approval"]').val() == 1){
						a_del = `<a title="ลบรายการ" href="#" onclick="confirmDeleteItem('` + item.item_id + `','` + item.item_name + `','` + item.item_amount + `')"><span class="glyphicon icon-trash-o txt-red"></span></a> `;
					}

					table_item += `
						<tr>
							<td>` + a_del + (i+1) + `</td>
							<td>` + item.item_name + `</td>
							<td align="right">` + parseInt(item.item_unit_qty).toLocaleString() + `</td>
							<td align="right">` + parseFloatInvDoc(item.item_amount) + `</td>
						</tr>
					`;

					table_item_view += `
						<tr>
							<td>` + (i+1) + `</td>
							<td>` + item.item_name + `</td>
							<td align="right">` + parseInt(item.item_unit_qty).toLocaleString() + `</td>
							<td align="right">` + parseFloatInvDoc(item.item_amount) + `</td>
						</tr>
					`;

					sum_amount += parseFloat(item.item_amount);
				});
			}
			else {
				table_html = `
						<tr>
							<td>-</td>
							<td>-</td>
							<td align="right">-</td>
							<td align="right">0.00</td>
						</tr>
				`;

				table_item += table_html;
				table_item_view += table_html;
			}

			table_html = `
					</tbody>
					<tfoot class="txt-bold">
						<tr class="warning txt-bold">
							<td align="right" colspan="3">รวมจำนวนเงินที่ได้รับ		</td>
							<td align="right">` + parseFloatInvDoc(sum_amount) + `</td>
						</tr>
					</tfoot>
				</table>
			`;

			table_item += table_html;
			table_item_view += table_html;

			$('#table_item').replaceWith(table_item);
			$('#table_item_view').replaceWith(table_item_view);
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
	if($('input[xd="hide_can_edit_approval"]').val() == 1){
		$('#click_add_item').show();
	}
	else {
		$('#click_add_item').replaceWith("");
		$('#box_add_item').replaceWith();
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

			var table_html = "";

			var table_item = `
				<table id="table_item" class="table table-striped table-bordered">
					<thead class="txt-bold">
						<tr id="item_row">
							<th>#</th>
							<th>รายการสินค้า</th>
							<th align="right">จำนวน/Quantity/ชิ้น</th>
							<th align="right">ราคาต่อหน่วย/Unit Price (ก่อน Vat)/บาท</th>
							<th align="right">จำนวนเงิน/Amount(ก่อน Vat)/บาท</th>
						</tr>
					</thead>
					<tbody>
			`;
			
			var table_item_view = `
				<table id="table_item_view" class="table table-striped table-bordered">
					<thead class="txt-bold">
						<tr id="item_row">
							<th>#</th>
							<th>รายการสินค้า</th>
							<th align="right">จำนวน/Quantity/ชิ้น</th>
							<th align="right">ราคาต่อหน่วย/Unit Price (ก่อน Vat)/บาท</th>
							<th align="right">จำนวนเงิน/Amount(ก่อน Vat)/บาท</th>
						</tr>
					</thead>
					<tbody>
			`;

			var sum_amount = 0;
			var num_vat = 0;
			var num_total = 0;

			if(data.length > 0){
				$.each(data,function( i,item ) {
					var a_del = "";

					if($('input[xd="hide_can_edit_approval"]').val() == 1){
						a_del = `<a title="ลบรายการ" href="#" onclick="confirmDeleteItem('` + item.item_id + `','` + item.item_name + `','` + item.item_amount + `')"><span class="glyphicon icon-trash-o txt-red"></span></a> `;
					}

					table_item += `
						<tr>
							<td>` + a_del + (i+1) + `</td>
							<td>` + item.item_name + `</td>
							<td align="right">` + parseInt(item.item_unit_qty).toLocaleString() + `</td>
							<td align="right">` + parseFloatInvDoc(item.item_unit_price) + `</td>
							<td align="right">` + parseFloatInvDoc(item.item_amount) + `</td>
						</tr>
					`;


					table_item_view += `
						<tr>
							<td>` + (i+1) + `</td>
							<td>` + item.item_name + `</td>
							<td align="right">` + parseInt(item.item_unit_qty).toLocaleString() + `</td>
							<td align="right">` + parseFloatInvDoc(item.item_unit_price) + `</td>
							<td align="right">` + parseFloatInvDoc(item.item_amount) + `</td>
						</tr>
					`;

					sum_amount += parseFloat(item.item_amount);
				});
			}
			else {
				table_html = `
						<tr>
							<td>-</td>
							<td>-</td>
							<td align="right">-</td>
							<td align="right">0.00</td>
							<td align="right">0.00</td>
						</tr>
				`;

				table_item += table_html;
				table_item_view += table_html;
			}

			num_vat = sum_amount*0.07;
			num_total = sum_amount+num_vat;

			table_html = `
					</tbody>
					<tfoot class="txt-bold">
						<tr class="warning">
							<td align="right" colspan="4">รวม</td>
							<td align="right">` + parseFloatInvDoc(sum_amount) + `</td>
						</tr>
						<tr class="warning txt-bold">
							<td align="right" colspan="4">Vat 7%</td>
							<td align="right">` + parseFloatInvDoc(num_vat) + `</td>
						</tr>
						<tr class="warning txt-bold">
							<td align="right" colspan="4">รวมทั้งหมด</td>
							<td align="right">` + parseFloatInvDoc(num_total) + `</td>
						</tr>
					</tfoot>
				</table>
			`;

			table_item += table_html;
			table_item_view += table_html;

			$('#table_item').replaceWith(table_item);
			$('#table_item_view').replaceWith(table_item_view);
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

function loadItemInvdocPdf() {
	var detail_remark = $('input[xd="hide_request_remark"]').val();
	var ref_number = $('input[xd="hide_ref_number"]').val();
	var test= $('input[xd="hide_category_id"]').val();
	var url = "json_invdoc.aspx?qrs=loadItemInvdoc&ref_number=" + ref_number;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			// console.log(data);

			var table_html = "";

			var table_item = `
				<table id="table_item" cellspacing="0" class="table table-striped table-bordered" style="width: 98%;font-family:'TH Sarabun New';font-size: 14px;">
					<thead class="txt-bold">
						<tr id="item_row">
							<th class="text-center" style="text-align:center;border-top: 1px solid black; border-left: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black;">ลำดับที่ <br/> No.</th>
							<th class="text-center" style="text-align:center;border-top: 1px solid black; border-bottom: 1px solid black;border-right: 1px solid black;">รายการ <br/> Description </th>
							<th class="text-center" align="right" style="text-align:center;border-top: 1px solid black; border-bottom: 1px solid black;border-right: 1px solid black;">จำนวน <br/> Quantity</th>
							<th class="text-center" align="right" style="text-align:center;border-top: 1px solid black; border-bottom: 1px solid black;border-right: 1px solid black;">ราคาต่อหน่วย <br/> Unit Price</th>
							<th class="text-center" align="right" style="text-align:center;border-top: 1px solid black; border-bottom: 1px solid black;border-right: 1px solid black;">จำนวนเงิน <br/> Amount</th>
						</tr>
					</thead>
					<tbody>
			`;
			var sum_amount = 0;
			var num_vat = 0;
			var num_total = 0;
			//var x = 0;
			if(data.length > 0){
				x = data.length;
				$.each(data,function( i,item ) {
					table_item += `
						<tr>
							<td width="12%" align="center" style="border-left: 1px solid black;border-right: 1px solid black;">` + (i+1) + `</td>
							<td style="border-right: 1px solid black;">&nbsp;` + item.item_name + `</td>
							<td width="8%" align="right" style="border-right: 1px solid black;">` + parseInt(item.item_unit_qty).toLocaleString() + `&nbsp;</td>
							<td width="10%" align="right" style="border-right: 1px solid black;">` + parseFloatInvDoc(item.item_unit_price) + `&nbsp;</td>
							<td width="12%" align="right" style="border-right: 1px solid black;">` + parseFloatInvDoc(item.item_amount) + `&nbsp;</td>
						</tr>
					`;

					sum_amount += parseFloat(item.item_amount);
				});
				for(i=data.length;i<=data.length+3;i++){
					table_item += `
						<tr>						
						`;
						if(i==data.length){
							table_item += `<td align="center" style="border-left: 1px solid black;border-right: 1px solid black;"></td>`;
							table_item += `<td style="border-right: 1px solid black;">&nbsp;อ้างอิง : `+ detail_remark +`</td>`;
						}else if(i==data.length+3){
							table_item += `<td align="center" style="border-left: 1px solid black;border-right: 1px solid black;">`+ (data.length+1) +`</td>`;
							table_item += `<td style="border-right: 1px solid black;">&nbsp;Ref. : `+ ref_number +`</td>`;
						}else{
							table_item += `<td align="center" style="border-left: 1px solid black;border-right: 1px solid black;">&nbsp; </td>`;
							table_item += `<td style="border-right: 1px solid black;"></td>`;
						}	
						table_item += `	
							<td style="border-right: 1px solid black;"></td>
							<td style="border-right: 1px solid black;"></td>
							<td style="border-right: 1px solid black;"></td>
						</tr>
					`;
				}
			}
			else {
				table_html += `
						<tr>
							<td style="border-left: 1px solid black;border-right: 1px solid black;"></td>
							<td style="border-right: 1px solid black;">&nbsp;-</td>
							<td align="right" style="border-right: 1px solid black;">0&nbsp;</td>
							<td align="right" style="border-right: 1px solid black;">0.00&nbsp;</td>
							<td align="right" style="border-right: 1px solid black;">0.00&nbsp;</td>
						</tr>
				`;

				table_item += table_html;
			}

			num_vat = sum_amount*0.07;
			num_total = sum_amount+num_vat;

			table_html += `
					</tbody>
					<tfoot class="txt-bold">
						<tr class="warning">
							<td align="right" colspan="4" style="border-top: 1px solid black;border-left: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black;">รวมเงิน / Sub Total&nbsp;</td>
							<td align="right" style="border-top: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black;">` + parseFloatInvDoc(sum_amount) + `&nbsp;</td>
						</tr>
						<tr class="warning txt-bold">
							<td align="right" colspan="4" style="border-left: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black;">ภาษีมูลค่าเพิ่ม 7 % / VAT&nbsp;</td>
							<td align="right" style="border-bottom: 1px solid black;border-right: 1px solid black;">` + parseFloatInvDoc(num_vat) + `&nbsp;</td>
						</tr>
						<tr class="warning txt-bold">
							<td align="right" colspan="4" style="border-left: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black;">ราคารวมภาษีมูลค่าเพิ่ม 7% / Grand Total&nbsp;</td>
							<td align="right" style="border-bottom: 1px solid black;border-right: 1px solid black;">` + parseFloatInvDoc(num_total) + `&nbsp;</td>
						</tr>
						<tr>
							<th style="border-left: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black;">จำนวนเงิน <br/> Amount in Words</th>
							<th colspan="4" style="border-bottom: 1px solid black;border-right: 1px solid black;text-align: center;vertical-align: middle;">` + convertThaiNumber(num_total) + `</th>
						</tr>
					</tfoot>
				</table>
			`;

			table_item += table_html;

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

function showItemInvdoc() {
	$('#click_add_item').hide();
	$('#box_add_item').show();
}

function resetBoxAddIem() {
	$('#txt_item_name').val("");
	$('#txt_item_unit_qty').val("");
	$('#txt_item_unit_price').val("");
	$('#txt_item_amount').val("");

	$('#box_add_item').hide();
	$('#click_add_item').show();
}

function insertItemInvdoc() {
    var ref_number = $('input[xd="hide_ref_number"]').val();
    var item_name = $('#txt_item_name').val();
    var item_unit_qty = $('#txt_item_unit_qty').val();
    var item_unit_price = $('#txt_item_unit_price').val();
    var item_amount = $('#txt_item_amount').val();

    if(ref_number.length > 0 && item_name.length > 0 && item_unit_qty.length > 0 && (item_unit_price.length > 0|| item_amount.length > 0)){
    	resetBoxAddIem();

    	if ($.trim(item_unit_price) == "" && $.trim(item_amount) != "") {
    		item_unit_price = 0;
    	}

    	if ($.trim(item_amount) == "" && $.trim(item_unit_price) != "") {
    		item_amount = parseFloat(item_unit_price).toFixed(2) * parseInt(item_unit_qty);
    	}

    	console.log("item_unit_qty = " + item_unit_qty);
    	console.log("item_unit_price = " + item_unit_price);
    	console.log("item_amount = " + item_amount);
        
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
	resetBoxAddIem();
	$('#txt_confirm_delete_item').html("ต้องการลบรายการ <b class='txt-red'>" + item_name + " จำนวนเงิน " + parseFloatInvDoc(item_amount) + " บาท</b>")
	$('#btn_delete_item_confirm').replaceWith("<button type='button' class='btn btn-danger' data-dismiss='modal' id='btn_delete_item_confirm' onclick='deleteItemInvdoc(\"" + item_id + "\", 1)'>ยืนยันลบ</button>");
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

function parseFloatInvDoc(num) {
	num = parseFloat(num);

	return num.toLocaleString(undefined, {
		minimumFractionDigits: 2,
		maximumFractionDigits: 2
	})
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
function convertThaiNumber(money){
	const THBText = window.THBText

	// This module is very simple to use
	// You just put the number that you want to convert into the first parameter
	// LIKE THIS --> THBText(Number)

	const moneyText = THBText(money)
	return moneyText
}
