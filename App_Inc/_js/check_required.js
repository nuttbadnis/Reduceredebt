function checkSubmit(rq) {
	var isValid = true;

	// เช็คเฉพาะ required ที่มองเห็น

	$('.panel-body:visible .'+rq+' input').each(function(){
		if(!checkRequired($(this))) {
			isValid = false;
		}
	});

	$('.panel-body:visible .'+rq+' select').each(function(){
		if(!checkRequired($(this))) {
			isValid = false;
		}
	});

	$('.panel-body:visible .'+rq+' textarea').each(function(){
		if(!checkRequired($(this))) {
			isValid = false;
		}
	});

	return isValid;
}

$('.required input, .required select, .required textarea').focusout(function() {
	$el = $(this);
	setTimeout( function() {
		checkRequired($el);
	}, 100);
});

$('.required-f input, .required-f select, .required-f textarea').focusout(function() {
	$el = $(this);
	setTimeout( function() {
		checkRequired($el);
	}, 100);
});

$('.required-n input, .required-n select, .required-n textarea').focusout(function() {
	$el = $(this);
	setTimeout( function() {
		checkRequired($el);
	}, 100);
});

function checkRequired($el) {
	if($el.val() == null){
		console.log("error required -> " + $el.attr('id'));
		$el.addClass("error");
		return false;
	}
	else if($el.val().trim().length > 0) {
		$el.removeClass("error");
		return true;
	}
	else {
		console.log("error required -> " + $el.attr('id'));
		$el.addClass("error");
		return false;
	}
}

$('.file-10mb').change(function() {
	var ext = this.value.split('.').pop().toLowerCase();
	console.log("ext="+ext);

	if (ext != "pdf" && ext != "png" && ext != "jpg" && ext != "jpeg" && ext != "jpg" && ext != "zip" && ext != "rar") {
		modalAlert("กรุณาตรวจสอบประเภทไฟล์ <br>อนุญาติไฟล์ pdf, jpg, png, zip, rar,  เท่านั้น");
		this.value = '';
	} 
	else {
		var maxsize = 1024*10;
		var filesize = this.files[0].size/1024;
		
		if(filesize > maxsize){
			modalAlert("ขนาดไฟล์สูงสุดต้องไม่เกิน 10MB");
			this.value = '';
		}
	}
});

$('.file-excel-10mb').change(function() {
	var ext = this.value.split('.').pop().toLowerCase();
	console.log("ext="+ext);

	if (ext != "xls" && ext != "xlsx") {
		modalAlert("กรุณาตรวจสอบประเภทไฟล์ <br>อนุญาติไฟล์ xls, xlsx  เท่านั้น");
		this.value = '';
	} 
	else {
		var maxsize = 1024*10;
		var filesize = this.files[0].size/1024;
		
		if(filesize > maxsize){
			modalAlert("ขนาดไฟล์สูงสุดต้องไม่เกิน 10MB");
			this.value = '';
		}
	}
});

$('.datepicker').focusout(function() {
	$el = $(this);
	setTimeout( function() {
		validateDate($el);
	}, 500);
});

$('input[xd="txt_amount"]').focusout(function() {
	var txt_amount = parseFloat($('input[xd="txt_amount"]').val());
	var max_amount = parseFloat($('#hide_max_amount').val());

	console.log("txt_amount=" + txt_amount + " | max_amount=" + max_amount);
	if( txt_amount > max_amount){
		modalAlert("กรุณาตรวจสอบจำนวนที่ต้องการลดหนี้ <br>ไม่ควรมากกว่ายอดตามใบเสร็จ");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('input[xd="txt_amount"]').val("").focus();
		})
	}
	else{
		$('input[xd="txt_amount"]').removeClass("error");
	}

	validateFloatFocusOut($(this));
});

function validateFloatKeyPress(el, evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    var number = el.value.split('.');
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
    	modalAlert("จำนวนต้องเป็น ตัวเลขเท่านั้น");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			el.focus();
		})
        return false;
    }
    //just one dot
    if(number.length>1 && charCode == 46){
         return false;
    }
    //get the carat position
    var caratPos = getSelectionStart(el);
    var dotPos = el.value.indexOf(".");
    var maxbit = 5;
    maxbit = maxbit-1;
    if( caratPos > dotPos && dotPos>-1 && (number[1].length > maxbit)){
    	console.log("number[1].length="+number[1].length + " | caratPos=" + caratPos + " | dotPos=" + dotPos);
        return false;
    }
    return true;
}

function validateFloatFocusOut($el) {
	var sNum = $el.val();
    var pattern = /^\d+(\.\d{1,5})?$/;
    console.log(sNum + " is " + ((pattern.test(sNum)) ? "" : "not ") + "valid.");

    if(!pattern.test(sNum) && sNum.length > 0){
    	modalAlert("<b class='txt-red'>\"" + $el.val() + "\"</b> จำนวนไม่ถูกต้อง<br> กรอกได้เฉพาะตัวเลขและจุดทศนิยมเท่านั้น");
    	$el.val(""); 

		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$el.focus();   	
		})
    	return false;
    }
    return true;
}

function validateDate($el) {
	var sDate = $el.val();

	if(parseDMY(sDate) == false && sDate.length > 0){
		modalAlert("กรุณาตรวจสอบวันที่ <br><p class='txt-red'>ตัวอย่าง 31/12/2017 **ใช้ปี ค.ศ</p>");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$el.focus(); 
			$el.val("");   	
		})
	}
	console.log(sDate + " is " + parseDMY(sDate) + " date");

	function parseDMY(value) {
		var check = false;
		var re = /^\d{1,2}\/\d{1,2}\/\d{4}$/;

		if(re.test(value)){
			var adata = value.split('/');
			var dd = parseInt(adata[0],10);
			var mm = parseInt(adata[1],10);
			var yyyy = parseInt(adata[2],10);
			var xdata = new Date(yyyy,mm-1,dd);

			if(yyyy > 2100){
				check = false;
			}
			else if ( ( xdata.getFullYear() === yyyy ) && ( xdata.getMonth () === mm - 1 ) && ( xdata.getDate() === dd ) ) {
				check = true;
			}
			else {
				check = false;
			}
		} else {
			check = false;
		}

		return check;
	}
}

function getSelectionStart(o) {
	if (o.createTextRange) {
		var r = document.selection.createRange().duplicate()
		r.moveEnd('character', o.value.length)
		if (r.text == '') return o.value.length
		return o.value.lastIndexOf(r.text)
	} else return o.selectionStart
}

function checkReceiptOther(){
	var doc_number = $('input[xd="txt_doc_number"]').val();
	var bcs_number = $('input[xd="txt_bcs_number"]').val();

	if (typeof doc_number != 'undefined') {
		if(doc_number.length != 22){
			$('input[xd="txt_doc_number"]').val("null");
			$('#div_pos').hide();
			$('#div_oth').show();
		}
		else {
			$('#div_oth').hide();
			$('#div_pos').show();
		}

		if(doc_number.substring(0,3).toUpperCase() == "SRC" && bcs_number.length < 20){
			$('input[xd="txt_bcs_number"]').val("null");
			$('#div_bcs').hide();
			$('#div_src').show();
		}
		else {
			$('#div_src').hide();
			$('#div_bcs').show();
		}
	}
	else {
		$('#div_oth').hide();
		$('#div_pos').show();
		$('#div_src').hide();
		$('#div_bcs').show();
	}
}

$('.num-only').focusout(function() {
	validateFloatFocusOut($(this));
});

$('.int-only').focusout(function() {
	validateIntFocusOut($(this));
});

function validateIntFocusOut($el) {
	var sNum = $el.val();
    var pattern = /^\d+$/;
    console.log(sNum + " is " + ((pattern.test(sNum)) ? "" : "not ") + "valid.");

    if(!pattern.test(sNum) && sNum.length > 0){
    	modalAlert("<b class='txt-red'>\"" + $el.val() + "\"</b> จำนวนไม่ถูกต้อง<br> กรอกได้เฉพาะตัวเลขเท่านั้น");
    	$el.val(""); 

		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$el.focus();   	
		})
    	return false;
    }
    return true;
}