$(document).ready(function() { 
	loadItemInvdocPdf();
	console.log('pdfprint');
});

function loadItemInvdocPdf() {
	var request_id = $('input[xd="hide_request_id"]').val();
	var doc_number = $('input[xd="hide_doc_number"]').val();
	var detail_remark = $('input[xd="hide_request_remark"]').val();
	var ref_number = $('input[xd="hide_ref_number"]').val();
	var url = "json_invdoc.aspx?qrs=loadItemInvdoc&ref_number=" + $('input[xd="hide_ref_number"]').val();

	//var url = "json_invdoc.aspx?qrs=loadItemInvdoc&ref_number=" + doc_number;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) {
			// console.log(data);

			var table_html = "";
			var amount_html = "";
			var table_item = `
				<table id="table_item" cellspacing="0" class="table table-striped table-bordered" style="width: 98%;font-family:'TH Sarabun New';font-size: 16px;">
					<thead class="txt-bold">
						<tr id="item_row">
							<th style="border: 1px solid black;text-align: center;">ลำดับที่ <br/> No.</th>
							<th style="border-top: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black;text-align: center;">รายการ <br/> Description </th>
							<th style="border-top: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black;text-align: center;">จำนวน <br/> Quantity</th>
							<th style="border-top: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black;text-align: center;">ราคาต่อหน่วย <br/> Unit Price</th>
							<th style="border-top: 1px solid black;border-bottom: 1px solid black;border-right: 1px solid black;text-align: center;">จำนวนเงิน <br/> Amount</th>
						</tr>
					</thead>
					<tbody>
			`;
			
			var amount_sum = 0;
			var amount_vat = 0;
			var amount_total = 0;
			var num = 0;
			if(data.length > 0){
				x = data.length;
				$.each(data,function( i,item ) {
					if(item.item_unit_qty == "0" && item.item_unit_price == "0.00" && item.item_amount == "0.00"){
						table_item += `
						<tr>
							<td width="8%" style="border-left: 1px solid black;border-right: 1px solid black;"></td>
							<td style="border-right: 1px solid black;">&nbsp;&nbsp;` + item.item_name + `</td>
							<td width="8%" style="border-right: 1px solid black;"></td>
							<td width="10%" style="border-right: 1px solid black;"></td>
							<td width="12%" style="border-right: 1px solid black;"></td>
						</tr>
						`;
					}else{
						num=num+1;
						table_item += `
						<tr>
							<td width="8%" align="center" style="border-left: 1px solid black;border-right: 1px solid black;">` + num + `</td>
							<td style="border-right: 1px solid black;">&nbsp;&nbsp;` + item.item_name + `</td>
							<td width="8%" align="right" style="border-right: 1px solid black;">` + parseIntInvDocpdf(item.item_unit_qty).toLocaleString() + ` ` + itemNull(item.item_invdoc_unit_th) + `&nbsp;&nbsp;</td>
							<td width="10%" align="right" style="border-right: 1px solid black;">` + parseFloatInvDocpdf(item.item_unit_price) + `&nbsp;&nbsp;</td>
							<td width="12%" align="right" style="border-right: 1px solid black;">` + parseFloatInvDocpdf(item.item_amount) + `&nbsp;&nbsp;</td>
						</tr>
						`;
					}
					amount_sum += parseFloat(item.item_amount);
				});
				data.length;

				for(i=data.length;i<=data.length+3;i++){
					table_item += `<tr>`;
						if(i==data.length){
							if(detail_remark == ""){
								
							}else{
								table_item += `
								<td align="center" style="border-left: 1px solid black;border-right: 1px solid black;">&nbsp;</td>
								<td style="border-right: 1px solid black;">&nbsp;&nbsp;อ้างอิง : `+ detail_remark +`</td>
								<td style="border-right: 1px solid black;"></td>
								<td style="border-right: 1px solid black;"></td>
								<td style="border-right: 1px solid black;"></td>`;	
							}
						}else if(i==data.length+3){
							table_item += `
							<td align="center" style="border-bottom: 1px solid black;border-left: 1px solid black;border-right: 1px solid black;">&nbsp;</td>
							<td style="border-bottom: 1px solid black;border-right: 1px solid black;">&nbsp;&nbsp;</td>
							<td style="border-bottom: 1px solid black;border-right: 1px solid black;"></td>
							<td style="border-bottom: 1px solid black;border-right: 1px solid black;"></td>
							<td style="border-bottom: 1px solid black;border-right: 1px solid black;"></td>`;
						}else{
							table_item += `
							<td align="center" style="border-left: 1px solid black;border-right: 1px solid black;">&nbsp;</td>
							<td style="border-right: 1px solid black;"></td>
							<td style="border-right: 1px solid black;"></td>
							<td style="border-right: 1px solid black;"></td>
							<td style="border-right: 1px solid black;"></td>`;
						}
						table_item += `</tr>`;
				}
			}
			else {
				table_html = `
						<tr>
							<td align="center" colspan="5">ไม่มีข้อมูล</td>
						</tr>
				`;

				table_item += table_html;
			}

			amount_vat = amount_sum*0.07;

			amount_vat = parseFloat(amount_vat).toFixed(2);
			amount_sum = parseFloat(amount_sum).toFixed(2);
			getItemTotalAmount(amount_sum, amount_vat, amount_total, request_id, table_item);

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

function getItemTotalAmount(amount_sum, amount_vat, amount_total, request_id, table_item) {
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
			amount_total = amount_sum+amount_vat;

			amount_html = `
			</tbody>
			<tfoot class="txt-bold" style="font-weight:bold;">
				<tr class="warning">
					<td align="right" colspan="4" style="border-right: 1px solid black;">รวมเงิน / Sub Total&nbsp;&nbsp;</td>
					<td align="right" style="border-bottom: 1px solid black;border-right: 1px solid black;">` + parseFloatInvDoc(amount_sum) + `&nbsp;&nbsp;</td>
				</tr>
				<tr class="warning txt-bold">
					<td align="right" colspan="4" style="border-right: 1px solid black;">ภาษีมูลค่าเพิ่ม 7 % / VAT&nbsp;&nbsp;</td>
					<td align="right" style="border-bottom: 1px solid black;border-right: 1px solid black;">` + parseFloatInvDoc(amount_vat) + `&nbsp;&nbsp;</td>
				</tr>
				<tr class="warning txt-bold">
					<td align="right" colspan="4" style="border-right: 1px solid black;">ราคารวมภาษีมูลค่าเพิ่ม 7% / Grand Total&nbsp;&nbsp;</td>
					<td align="right" style="border-bottom: 1px solid black;border-right: 1px solid black;">` + parseFloatInvDoc(amount_total) + `&nbsp;&nbsp;</td>
				</tr>
			</tfoot>
		</table>
		<table cellspacing="0" class="table table-striped table-bordered" style="width: 98%;font-family:'TH Sarabun New';font-size: 16px;font-weight: bold;">
			<tbody>
			<tr>
				<td colspan="2">&nbsp;</td>
				<td colspan="3" style="border-bottom: 1px solid black;"></td>
			</tr>
			<tr>
				<td colspan="2" style="width:20%;border-right: 1px solid black;">จำนวนเงิน <br/> Amount in Words</td>
				<td colspan="3" style="border-right: 1px solid black;border-bottom: 1px solid black;text-align: center;vertical-align: middle;background: #C0C0C0;">` + convertThaiNumber(amount_total) + `</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
				<td colspan="3"></td>
			</tr>
			</tbody>
		</table>
		`;

		table_item += amount_html;
				
		$('#tablecp_item').replaceWith(table_item);
		$('#table_item').replaceWith(table_item);
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

