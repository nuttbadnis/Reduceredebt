
$(document).ready(function() { 
	if($('select[xd="sel_title"] > option').length == 2 && $('input[xd="txt_request_title"]').val().length == 0) {
		$('select[xd="sel_title"]').prop('selectedIndex', 1);
		$('input[xd="txt_request_title"]').val($('select[xd="sel_title"] option:selected').text());
		
		if (typeof $('select[xd="sel_cause"]').val() != 'undefined') {
			loadCause($('select[xd="sel_title"]').val());
		}
	}
});

$('select[xd="sel_title"]').change(function() {
	var $el = $('input[xd="txt_request_title"]');

	if ($('select[xd="sel_title"]').val().trim().length > 0){
		$el.val($('select[xd="sel_title"] option:selected').text());
	}
	else {
		$el.val("");
	}

	if($(this).val().trim().length > 0)
		$el.removeClass("error");
	else
		$el.addClass("error");
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
			$('input[xd="hide_create_ro"]').val($('select[xd="sel_create_ro"]').val());
			$('input[xd="hide_redebt_cause"]').val($('select[xd="sel_cause"]').val());
			$('input[xd="btn_submit_hidden"]').click();
		}
	}
});
