///////////////////////// btn_print /////////////////////////
$('#print_request_id').val(_GET('request_id'));

$('button[xd="btn_print"]').click(function() {
	$('input[xd="btn_print_hidden"]').click();
});

///////////////////////// btn_print /////////////////////////
// ------------------ หน่วย ค่าไฟฟ้า

// $('#chk_ax13').change(function() {
// 	chk_elecharge_unit();
// });

function chk_elecharge_unit() {
	var txt_unit = "บาท/หน่วย";
	$('#ea_ax13').removeClass('txt-blue');

	if($('#chk_ax13').prop('checked') == true) {
		txt_unit = "บาท/เดือน";
		$('#ea_ax13').addClass('txt-blue');
	}

	$('#ea_ax13').html(txt_unit);
	$('input[xd="hide_elecharge_unit"]').val(txt_unit);
}

$('#chk_uprent_rate').change(function() {
	chk_uprent_rate();
});

function AutoElechargeUnit() {
	if($('input[xd="hide_elecharge_unit"]').val() == "บาท/เดือน") {
		$('#chk_ax13').prop('checked', true);
		chk_elecharge_unit();
	}
}

//------------------ ค่าเช่ารวมค่าบริการ

$('input[xd="txt_amount"]').focusout(function() {
	sum_uprent();
});
$('input[xd="txt_ax05"]').focusout(function() {
	sum_uprent();
});

function sum_uprent(){
	var cost_uprent = $('input[xd="txt_amount"]').val();
	var cost_service = $('input[xd="txt_ax05"]').val();
	var sum_uprent_service = 0;
	sum_uprent_service = Number(cost_uprent)+Number(cost_service);
	$('#view_ax07').html(Number(cost_uprent)+" + "+Number(cost_service));
	if (sum_uprent_service >= 0){
		$('input[xd="txt_ax07"]').val(sum_uprent_service);	
	}
}

//------------------ รวมงบประมาณการตกแต่ง

$('input[xd="txt_decoration_fee"]').focusout(function() {
	sum_decoration();
});
$('input[xd="txt_ax18"]').focusout(function() {
	sum_decoration();
});
$('input[xd="txt_ax20"]').focusout(function() {
	sum_decoration();
});

function sum_decoration(){
	var deco_fee = $('input[xd="txt_decoration_fee"]').val();
	var deco_ins = $('input[xd="txt_ax18"]').val();
	var sec_cost = $('input[xd="txt_ax20"]').val();
	var sum_uprent_service = 0;
	var txt_uprent_service = "(งบประมาณการตกแต่ง + เงินประกันการตกแต่ง + ค่ารปภ.)";
	sum_uprent_service = Number(deco_fee )+Number(deco_ins)+Number(sec_cost);	
	$('#view_gx01').html(Number(deco_fee )+" + "+Number(deco_ins)+" + "+Number(sec_cost)+ "<br/>"+txt_uprent_service);
	if (sum_uprent_service >= 0){
		$('input[xd="txt_gx01"]').val(sum_uprent_service);

	}
}

//------------------ อัตราการปรับค่าเช่า

function chk_uprent_rate() {
	if($('#chk_uprent_rate').prop('checked') == true) {
		$('input[xd="txt_uprent_rate"]').prop('readonly', true);
		$('input[xd="txt_uprent_rate"]').val(0);
	}
	else {
		$('input[xd="txt_uprent_rate"]').prop('readonly', false);
		$('input[xd="txt_uprent_rate"]').val("");
	}
}

$('input[xd="txt_uprent_rate"]').focusout(function() {
	validate_uprent_rate();
});

function validate_uprent_rate($el) {
	var $el = $('input[xd="txt_uprent_rate"]');

	if($el.val().length > 0 && $el.val() <= 0 && $('#chk_uprent_rate').prop('checked') != true){
    	modalAlert("<b class='txt-red'>\"" + $el.val() + "\"</b> จำนวนไม่ถูกต้อง<br> อัตราการปรับค่าเช่า ต้องมากกว่า 0");
    	$el.val(""); 
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$el.focus();   	
		})
    	return false;
    }
    return true;
}

function convertUprentPercent(amount) {
	var str_amount = "คงเดิม";

	if($.isNumeric(amount) == true){
		if(amount > 0) {
			str_amount = amount + "%";
		}
		else {
			$('#chk_uprent_rate').prop('checked', true);
			chk_uprent_rate();
		}
		amount = amount + "%";
	}

	str_amount = "<span title='" + amount + "'>" +  str_amount  + "</span>";

	return str_amount;
}

//------------------ งบประมาณทั้งหมดตลอดระยะสัญญา

$('select[xd="sel_ctphase"]').focusout(function() {
	sum_all_cost();
});
$('input[xd="txt_ctphase_remark"]').focusout(function() {
	sum_all_cost();
});
$('input[xd="txt_amount"]').focusout(function() {
	sum_all_cost();
});
$('input[xd="txt_ax05"]').focusout(function() {
	sum_all_cost();
});
$('input[xd="txt_ax13"]').focusout(function() {
	sum_all_cost();
});
$('#chk_ax13').focusout(function() {
	console.log("check all");
	sum_all_cost();
});
//------------------ เงินประกันค่าเช่าและเงินประกันค่าบริการ
$('input[xd="txt_ax16"]').focusout(function() {
	sum_all_cost();
});
$('input[xd="txt_ax17"]').focusout(function() {
	sum_all_cost();
});

function sum_all_cost(){

	var sum_all = 0;
	var contact_term = Number($('select[xd="sel_ctphase"]').val());
	var other_contact_term = Number($('input[xd="txt_ctphase_remark"]').val());
	var sum_uprent_service = Number($('input[xd="txt_ax07"]').val());
	var cost_electricity = Number($('input[xd="txt_ax13"]').val());
	var deposit_uprent = Number($('input[xd="txt_ax16"]').val());
	var deposit_service = Number($('input[xd="txt_ax17"]').val());
	var sum_deposit = deposit_uprent + deposit_service
	var view_sum_deposit = " + ( "+Number(deposit_uprent)+" + "+Number(deposit_service)+" ) ";
	var txt_sum_deposit = " + ( เงินประกันค่าเช่า + เงินประกันค่าบริการ ) ";
	var txt_sum_all = "";
	 if( isNaN(sum_deposit) == true){
	 	sum_deposit = 0;
		view_sum_deposit = "";
		txt_sum_deposit = "";
	 }

	console.log("contact_term = "+contact_term +" other_contact_term = "+Number(other_contact_term));
	console.log("sum_uprent_service = "+sum_uprent_service +" cost_electricity = "+cost_electricity);
	console.log("deposit_uprent = "+ deposit_uprent +" deposit_service = "+deposit_service);
	console.log("sum_deposit = "+sum_deposit);


	if($('#chk_ax13').prop('checked') == true) {	
		if(contact_term == "99999"){
			console.log("check 99999");
			sum_all = (sum_uprent_service * other_contact_term) + cost_electricity + sum_deposit;
			txt_sum_all = "( ( ค่าเช่ารวมค่าบริการ x ระบุระยะสัญญา(เลือกอายุสัญญา อื่นๆ) ) + ค่าไฟ ) "+ txt_sum_deposit;
			$('#view_gx01').html("( ( "+Number(sum_uprent_service )+" * "+Number(other_contact_term)+" ) + "+Number(cost_electricity)+" ) " + view_sum_deposit + "</br>" + txt_sum_all);
		}else{
			console.log("check not 99999");
			sum_all = (sum_uprent_service * Math.trunc(contact_term/30) ) + cost_electricity + sum_deposit
			txt_sum_all = "( ( ค่าเช่ารวมค่าบริการ x อายุสัญญา ) + ค่าไฟ ) "+ txt_sum_deposit;
			$('#view_gx01').html("( ( "+Number(sum_uprent_service )+" * "+Math.trunc(contact_term/30)+" ) + "+Number(cost_electricity)+" ) " + view_sum_deposit + "</br>" + txt_sum_all);
		}
	}else if(contact_term == "99999"){
		console.log("99999");
		sum_all = ((sum_uprent_service + cost_electricity) * other_contact_term) + sum_deposit
		txt_sum_all = "( ( ค่าเช่ารวมค่าบริการ + ค่าไฟ ) x ระบุระยะสัญญา(เลือกอายุสัญญา อื่นๆ) ) "+ txt_sum_deposit;
		$('#view_gx01').html("( ( "+Number(sum_uprent_service )+" + "+Number(cost_electricity)+" ) * "+Number(other_contact_term)+" ) "+ view_sum_deposit + "</br>" + txt_sum_all);
	}else{
		console.log("other basic");
		sum_all = ((sum_uprent_service + cost_electricity) * Math.trunc(contact_term/30) ) + sum_deposit
		txt_sum_all = "( ( ค่าเช่ารวมค่าบริการ  + ค่าไฟ ) x อายุสัญญา ) "+ txt_sum_deposit;
		$('#view_gx01').html("( ( "+Number(sum_uprent_service )+" + "+Number(cost_electricity)+" ) * "+Math.trunc(contact_term/30)+" ) " + view_sum_deposit + "</br>" + txt_sum_all);
	}

	if (sum_all >= 0){
		sum_all = Math.trunc(sum_all); 
		console.log("sum_all = "+sum_all);
		$('input[xd="txt_gx01"]').val(sum_all);
	}
}

function check_amount(){
	var isValid = true;
	var subject_alert = "";
	var page_url = $('input[xd="hide_page_url"]').val();
	if(page_url == "ctshop50" ){
		subject_alert = "งบประมาณการตกแต่ง";
	}else{
		subject_alert = "งบประมาณตลอดระยะสัญญา";
	}
	var cost_contact = $('input[xd="txt_gx01"]').val();
	var min_cost_contract = $('input[xd="hide_min_cost"]').val();
	var max_cost_contract = $('input[xd="hide_max_cost"]').val();
	console.log("cost_contact : "+cost_contact+ " min_cost_contract : " +min_cost_contract+ " max_cost_contract : "+max_cost_contract);
	if( max_cost_contract == 0){
		console.log("max == 0");
		if( Number(cost_contact) <= Number(min_cost_contract)){
			modalAlert("<b class='txt-red'>\"" + convertAmount(cost_contact) + "\"</b> "+subject_alert+"ไม่อยู่ในงบที่กำหนด <br> "+subject_alert+" ต้องมากกว่า "+convertAmount(min_cost_contract)+" บาท");
			isValid = false;
		}
	}else if(min_cost_contract == 0){
		console.log("min == 0");
		if( Number(cost_contact) > Number(max_cost_contract)){
			modalAlert("<b class='txt-red'>\"" + convertAmount(cost_contact) + "\"</b> "+subject_alert+"ไม่อยู่ในงบที่กำหนด <br> "+subject_alert+" ต้องมากกว่า "+convertAmount(min_cost_contract)+" บาท และไม่เกิน "+convertAmount(max_cost_contract)+" บาท ");
			isValid = false;
		}
	}else{
		console.log("min,max > 0");
		if(Number(cost_contact) <= Number(min_cost_contract) || Number(cost_contact) > Number(max_cost_contract)){
			modalAlert("<b class='txt-red'>\"" + convertAmount(cost_contact) + "\"</b> "+subject_alert+"ไม่อยู่ในงบที่กำหนด <br> "+subject_alert+" ต้องมากกว่า "+convertAmount(min_cost_contract)+" บาท และไม่เกิน "+convertAmount(max_cost_contract)+" บาท ");
			isValid = false;
		}
	}

	console.log("return : "+isValid);
	return isValid;
}