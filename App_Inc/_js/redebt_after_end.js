
$('button[xd="btn_modal_after_end"]').click(function() {
	$('#modal_after_end').modal("show");

	$('#span_last_after_end').html("-");
	$('#txt_after_end_remark').val("");
	loadAfterEndLasted();
	loadAfterStatusSelected();
});

$('#btn_update_after_end').click(function() {
	if($('#sel_after_end_status').val() == ""){
		modalAlert('กรุณาเลือก สถานะหลังปิดคำขอ');
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('#sel_after_end_status').focus();
		})
	}
	else if($('#sel_after_end_status').val() != 10 && $('#txt_after_end_remark').val().trim().length < 5){
		modalAlert('กรุณากรอก รายละเอียดเพิ่มเติม');
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('#txt_after_end_remark').focus();
		})
	}
	else {
		$('#modal_after_end').modal("hide");
		updateAfterEnd();
	}
});

function loadAfterStatusSelected(){
	var $el = $('#sel_after_end_status');
	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด.."));

	var url = "json_redebt.aspx?qrs=loadAfterStatusSelected";
	console.log(url);

	$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				$el.empty();
				$el.append($("<option></option>")
					.attr('selected', true).attr("value", "").text("กรุณาเลือก"));

				$.each(data,function( i,item ) {
					$el.append($("<option></option>")
						.attr("value", item.after_end_status_id).text(item.after_end_status_name));
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

function loadAfterEndLasted(){
	$('#span_last_after_end').html("กำลังโหลด..");

	var url = "json_redebt.aspx?qrs=loadAfterEndLasted&request_id=" + _GET('request_id');
	console.log(url);

	$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				var last_after_end = "-";

				if(data.length > 0){
					last_after_end = data[0].after_end_status_name + " ";
					last_after_end += "<br>"

					if(data[0].after_end_remark.length > 0) {
						last_after_end += "<b>รายละเอียดเพิ่มเติม:</b> " + data[0].after_end_remark + "";
						last_after_end += "<br>"
					}

					last_after_end += "<b>โดย:</b> " + data[0].create_by + " ";
					last_after_end += "<b>เมื่อ:</b> " + data[0].create_date + " ";

				}

				$('#span_last_after_end').html(last_after_end);
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

function updateAfterEnd(){
	var after_end_status_id = $('#sel_after_end_status').val();
	var after_end_remark = $('#txt_after_end_remark').val();

	var url = "json_redebt.aspx?qrs=updateAfterEnd";

	$.ajax({
		url: url,
		type: "post",
		timeout: 60000,
		cache: false,
		data: { 
			request_id: _GET('request_id'),
			after_end_status_id: after_end_status_id,
			after_end_remark: after_end_remark,
			uemail: $('input[xd="hide_uemail"]').val()
		},
		success: function( res ) {
			// console.log("res = " + res);
			if(res > 0){
				modalAlert('อัพเดท "สถานะหลังปิดคำขอ" แล้ว');
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
