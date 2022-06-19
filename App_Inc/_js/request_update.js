
$(document).ready(function() { 
	$('#fix_request_id').html($('span[xd="inn_request_id"]').text());
	$('#fix_status_name').html($('span[xd="inn_status_name"]').text());

	window.onscroll = function() {
        if(window.pageYOffset >= 75){
			$('#fixbar_status').show();
        }
        else {
			$('#fixbar_status').hide();
        }
	}

	loadCountFlowReject();
});

$('#btn_ctshop_submit').click(function() {
	if(check_amount()){
		if(checkSubmitOperator()){
			if (!checkSubmit('required')) { // ถ้าช่อง required มีค่าว่าง
				modalAlert("กรุณากรอกข้อมูลให้ครบถ้วน");
				$('#modal_alert').on('hidden.bs.modal', function (e) {
					$('.error:first').focus();
				})
			}
			else{ // บันทึก
				$('#btn_ctshop_submit').prop('disabled', true);
				$('input[xd="hide_redebt_cause"]').val($('select[xd="sel_cause"]').val());
				$('input[xd="btn_submit_hidden"]').click();
			}
		}
	}
});

$('#btn_submit').click(function() {
	if(checkSubmitOperator()){
		if (!checkSubmit('required')) { // ถ้าช่อง required มีค่าว่าง
			modalAlert("กรุณากรอกข้อมูลให้ครบถ้วน");
			$('#modal_alert').on('hidden.bs.modal', function (e) {
				$('.error:first').focus();
			})
		}
		else{ // บันทึก
			$('#btn_submit').prop('disabled', true);
			$('input[xd="hide_redebt_cause"]').val($('select[xd="sel_cause"]').val());
			$('input[xd="btn_submit_hidden"]').click();
		}
	}
});

$('#btn_cancle').click(function() {
	$('#modal_confirm_cancle').modal("show");
});

function loadCountFlowReject(){
	var url = "json_default.aspx?qrs=loadCountFlowReject&request_id=" + _GET('request_id');
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				if(data[0].max_reject_no > 0){
					var html = "<thead id='xback_reject'>" +
								"	<tr ><td colspan='10' style='padding: 5px 0px 15px 0px; border: 0;'>" +
								"		<button onclick='loadRequestFlowReject()' class='btn btn-sm btn-count-reject' type='button' title='คลิกเพื่อแสดงประวัติ'><span class='glyphicon icon-backspace-outline' style='font-size: 15px;'></span> มีประวัติไม่อนุมัติ " + data[0].max_reject_no + " ครั้ง</button>" +
								"	</td></tr>" +
								"</thead>";

					$(html).prependTo( $('#table_flow') );
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

function loadRequestFlowReject(){
	$('#page_loading').fadeIn();

	var url = "json_default.aspx?qrs=loadRequestFlowReject&request_id=" + _GET('request_id');
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				var html = "";
				var temp_reject_no = 0;
				var n = 1;

				$.each(data,function( i,item ) {
					if(temp_reject_no != item.reject_no) {
						html += "<tr><td colspan='10' class='flow-reject'><span class='head-flow-reject'>" + 
								"	<span class='glyphicon icon-backspace-outline' style='font-size: 15px;'></span> ประวัติไม่อนุมัติ ครั้งที่ " + item.reject_no +
								"</span></td></tr>" +
				    			"<tr class='txt-red txt-bold'>" +
				    			"	<th>#</th>" +
				    			"	<th>Step</th>" +
				    			"	<th>Next</th>" +
				    			"	<th>ส่วนงาน</th>" +
				    			"	<th>อีเมล์</th>" +
				    			"	<th>สถานะ</th>" +
				    			"	<th>อัพเดทล่าสุด</th>" +
				    			"	<th>โดย</th>" +
				    			"	<th>หมายเหตุ</th>" +
				    			"	<th>เอกสารประกอบ</th>" +
				    			"</tr>";

						temp_reject_no = item.reject_no;
			    		n = 1;
					}

					var cls = "label-complete";

					if(i == data.length-1) {
						cls = "label-reject";
					}
					else if(data[i].reject_no != data[i+1].reject_no) {
						cls = "label-reject";
					}

					var sub_class = "";
					var flow_step = item.flow_step;

					if(item.flow_sub_step != 0) {
						flow_step += "." + item.flow_sub_step;
						sub_class = "flow-sub";
					}

			    	html += "<tr class='" + sub_class + "'>" +
			    			"	<td class='txt-red'>" + n + "</td>" +
			    			"	<td>" + flow_step + "</td>" +
			    			"	<td>" + item.next_step + "</td>" +
			    			"	<td>" + item.depart_name + "</td>" +
			    			"	<td>" + item.uemail + "</td>" +
			    			"	<td><span class='flow-sts label " + cls + "'>" + item.status_name + "</span></td>" +
			    			"	<td>" + item.update_date + "</td>" +
			    			"	<td>" + item.update_by + "</td>" +
			    			"	<td>" + itemNull(item.flow_remark) + "</td>" +
			    			"	<td>" + itemNull(item.flow_file) + "</td>" +
			    			"</tr>";
			    	n = n+1;
				});
				html += "<tr><td colspan='10' class='flow-current'><span class='head-flow-current'>" + 
						"	Flow Step ปัจจุบัน"
						"</td></tr>";

				$('#xback_reject').html(html);

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
