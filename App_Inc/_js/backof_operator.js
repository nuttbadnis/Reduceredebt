function checkSubmitOperator(){
	var $cc1 = $('input[xd="txt_uemail_cc1"]');
	var $cc2 = $('input[xd="txt_uemail_cc2"]');
	var $vr1 = $('input[xd="hide_uemail_verify1"]');

	if(	$cc1.val().indexOf("@") >= 0 ){
		modalAlert("กรุณาตรวจสอบ ผู้รับผิดชอบร่วม (CC) <br><b>ไม่ต้องใส่ @jasmine.com ต่อท้าย</b>");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$cc1.focus();
		})
	}
	else if( $cc2.val().indexOf("@") >= 0 ){
		modalAlert("กรุณาตรวจสอบ ผู้รับผิดชอบร่วม (CC) <br><b>ไม่ต้องใส่ @jasmine.com ต่อท้าย</b>");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$cc2.focus();
		})
	}
	else if( $cc1.val().trim().length > 0 &&  $cc1.val() == $vr1.val() ){
		modalAlert("ทุกคำขอจะมี <b>\"ผู้ตรวจสอบ 1\"</b> เป็นหนึ่งใน <br><b>\"ผู้รับผิดชอบร่วม\"</b> โดยอัตโนมัติเสมอ<br><br><span class='txt-red'>จึงไม่อนุญาตให้กรอก <b>\"ผู้ตรวจสอบ 1\"</b><br>ใน <b>\"ผู้รับผิดชอบร่วม (CC)\"</b> อีก</span>");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$cc1.focus();
		})
	}
	else if( $cc2.val().trim().length > 0 &&  $cc2.val() == $vr1.val() ){
		modalAlert("ทุกคำขอจะมี <b>\"ผู้ตรวจสอบ 1\"</b> เป็นหนึ่งใน <br><b>\"ผู้รับผิดชอบร่วม\"</b> โดยอัตโนมัติเสมอ<br><br><span class='txt-red'>จึงไม่อนุญาตให้กรอก <b>\"ผู้ตรวจสอบ 1\"</b><br>ใน <b>\"ผู้รับผิดชอบร่วม (CC)\"</b> อีก</span>");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$cc2.focus();
		})
	}
	else {
		return true;
	}

	return false;
}

$('#add_cc').click(function(){
	if($('.form-cc1').css('display') == 'none'){
		$('.form-cc1').show();
	}
	else if($('.form-cc2').css('display') == 'none'){
		$('.form-cc2').show();
	}
	else {
		modalAlert('ผู้รับผิดชอบร่วม ได้สูงสุด 2 คน');
	}
});

$('#remove_cc1').click(function(){
	$('.form-cc1').hide();
	$('input[xd="txt_uemail_cc1"]').val("");
	$('#auto_cc1').val("");
});

$('#remove_cc2').click(function(){
	$('.form-cc2').hide();
	$('input[xd="txt_uemail_cc2"]').val("");
	$('#auto_cc2').val("");
});

function loadAutoBoxApprove(){
	var uemail_verify1 = "";
	var uemail_verify2 = "";
	var uemail_approve = "";

	if (typeof $('input[xd="hide_uemail_verify1"]').val() != 'undefined') {
		if($('input[xd="hide_uemail_verify1"]').val().trim().length > 0){
			uemail_verify1 = $('input[xd="hide_uemail_verify1"]').val() + "@jasmine.com";
		}
		else{
			$('span[xd="inn_uemail_verify1"]').hide();
			$('.txt-desc-verify1').hide();
		}
	}

	if (typeof $('input[xd="hide_uemail_verify2"]').val() != 'undefined') {
		if($('input[xd="hide_uemail_verify2"]').val().trim().length > 0){
			uemail_verify2 = $('input[xd="hide_uemail_verify2"]').val() + "@jasmine.com";
		}
		else{
			$('span[xd="inn_uemail_verify2"]').hide();
			$('.txt-desc-verify2').hide();
		}
	}

	if (typeof $('input[xd="hide_uemail_approve"]').val() != 'undefined') {
		if($('input[xd="hide_uemail_approve"]').val().trim().length > 0){
			uemail_approve = $('input[xd="hide_uemail_approve"]').val() + "@jasmine.com";
		}
		else{
			$('span[xd="inn_uemail_approve"]').hide();
			$('.txt-desc-approve').hide();
		}
	}

	$('#auto_verify1').val(uemail_verify1);
	$('#auto_verify2').val(uemail_verify2);
	$('#auto_approve').val(uemail_approve);

	if($('input[xd="hide_can_edit_approval"]').val() == 1){
		$('.approve-readonly').hide();
		$('.approve-edit').show();
	}


	// // // // // // // // // // // // // // // // // // // // // // // // // 

	var uemail_cc1 = "";
	var uemail_cc2 = "";

	if($('input[xd="txt_uemail_cc1"]').val().trim().length > 0){
		uemail_cc1 = $('input[xd="txt_uemail_cc1"]').val() + "@jasmine.com";
	}

	if($('input[xd="txt_uemail_cc2"]').val().trim().length > 0){
		uemail_cc2 = $('input[xd="txt_uemail_cc2"]').val() + "@jasmine.com";
	}

	$('#auto_cc1').val(uemail_cc1);
	$('#auto_cc2').val(uemail_cc2);
}

function loadAutoBoxCC(){
	var uemail_cc1 = "";
	var uemail_cc2 = "";

	if($('input[xd="txt_uemail_cc1"]').val().trim().length > 0){
		uemail_cc1 = $('input[xd="txt_uemail_cc1"]').val() + "@jasmine.com";
	}

	if($('input[xd="txt_uemail_cc2"]').val().trim().length > 0){
		uemail_cc2 = $('input[xd="txt_uemail_cc2"]').val() + "@jasmine.com";
	}

	$('#auto_cc1').val(uemail_cc1);
	$('#auto_cc2').val(uemail_cc2);
}

////////////////////////////////////////////////////////////////////////////////////////////////////

$('#auto_approve').autocomplete({
	minLength: 0,
	focus: function(event, ui) {
		event.preventDefault();
		$("#auto_approve-search").val(ui.item.label);
	},
	source: function( request, response ) {
		source_depart_user(request, response, '1011');
	}
});

$('#auto_approve').on('autocompleteselect', function (e, ui) {
	$('input[xd="hide_uemail_approve"]').val(ui.item.uemail);
	$('#txt_desc_approve').html(ui.item.desc);
	
	$('#copy_same').show();
	$('#uncopy_same').hide();
});

$('#auto_approve').click(function(){
	$('#auto_approve').val("");
	$('#auto_approve').autocomplete("option", "minLength", 0).autocomplete("search", " ");
});

$('#auto_approve').focusout(function() {
	$('#auto_approve').val("");

	if($('input[xd="hide_uemail_approve"]').val().trim().length > 0){
		$('#auto_approve').val($('input[xd="hide_uemail_approve"]').val()+"@jasmine.com");
	}
});


////////////////////////////////////////////////////////////////////////////////////////////////////


$('#auto_verify1').autocomplete({
	minLength: 0,
	focus: function(event, ui) {
		event.preventDefault();
		$("#auto_verify1-search").val(ui.item.label);
	},
	source: function( request, response ) {
		source_depart_user(request, response, '1012');
	}
});

$('#auto_verify1').on('autocompleteselect', function (e, ui) {
	$('input[xd="hide_uemail_verify1"]').val(ui.item.uemail);
	$('#txt_desc_verify1').html(ui.item.desc);
});

$('#auto_verify1').click(function(){
	$('#auto_verify1').val("");
	$('#auto_verify1').autocomplete("option", "minLength", 0).autocomplete("search", " ");
});

$('#auto_verify1').focusout(function() {
	$('#auto_verify1').val("");

	if($('input[xd="hide_uemail_verify1"]').val().trim().length > 0){
		$('#auto_verify1').val($('input[xd="hide_uemail_verify1"]').val()+"@jasmine.com");
	}
});


////////////////////////////////////////////////////////////////////////////////////////////////////


$('#auto_verify2').autocomplete({
	minLength: 0,
	focus: function(event, ui) {
		event.preventDefault();
		$("#auto_verify2-search").val(ui.item.label);
	},
	source: function( request, response ) {
		source_depart_user(request, response, '1013');
	}
});

$('#auto_verify2').on('autocompleteselect', function (e, ui) {
	$('input[xd="hide_uemail_verify2"]').val(ui.item.uemail);
	$('#txt_desc_verify2').html(ui.item.desc);
});

$('#auto_verify2').click(function(){
	$('#auto_verify2').val("");
	$('#auto_verify2').autocomplete("option", "minLength", 0).autocomplete("search", " ");
});

$('#auto_verify2').focusout(function() {
	$('#auto_verify2').val("");

	if($('input[xd="hide_uemail_verify2"]').val().trim().length > 0){
		$('#auto_verify2').val($('input[xd="hide_uemail_verify2"]').val()+"@jasmine.com");
	}
});


////////////////////////////////////////////////////////////////////////////////////////////////////


$('#auto_cc1').autocomplete({
	minLength: 3,
	focus: function(event, ui) {
		event.preventDefault();
		$("#auto_cc1-search").val(ui.item.label);
	},
	source: function( request, response ) {
		source_auto_emp(request, response);
	}
});

$('#auto_cc1').on('autocompleteselect', function (e, ui) {
	$('input[xd="txt_uemail_cc1"]').val(ui.item.uemail);
});

$('#auto_cc1').click(function(){
	$('#auto_cc1').val("");
});

$('#auto_cc1').focusout(function() {
	$('#auto_cc1').val("");

	if($('input[xd="txt_uemail_cc1"]').val().trim().length > 0){
		$('#auto_cc1').val($('input[xd="txt_uemail_cc1"]').val()+"@jasmine.com");
	}
});


////////////////////////////////////////////////////////////////////////////////////////////////////


$('#auto_cc2').autocomplete({
	minLength: 3,
	focus: function(event, ui) {
		event.preventDefault();
		$("#auto_cc2-search").val(ui.item.label);
	},
	source: function( request, response ) {
		source_auto_emp(request, response);
	}
});

$('#auto_cc2').on('autocompleteselect', function (e, ui) {
	$('input[xd="txt_uemail_cc2"]').val(ui.item.uemail);
});

$('#auto_cc2').click(function(){
	$('#auto_cc2').val("");
});

$('#auto_cc2').focusout(function() {
	$('#auto_cc2').val("");

	if($('input[xd="txt_uemail_cc2"]').val().trim().length > 0){
		$('#auto_cc2').val($('input[xd="txt_uemail_cc2"]').val()+"@jasmine.com");
	}
});


////////////////////////////////////////////////////////////////////////////////////////////////////


function source_depart_user(request, response, in_depart) {
	var province_short = $('input[xd="hide_province_short"]').val();

	if(province_short.trim().length > 0) {
		var url = "json_redebt.aspx?qrs=autoDepartUser&kw=" + request.term + "&province_short=" + province_short + "&in_depart=" + in_depart;
		console.log(url)

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			success: function( data ) {
				response( $.map( data, function( item ) {
					var user_desc = "";

					if(item.user_desc != ""){
						user_desc = " / " + item.user_desc;
					}

					return {
						uemail: item.uemail,
						desc: item.jas_thaiFullname + " / " + item.jas_position + " / " + item.jas_department,
						label: item.uemail + "@jasmine.com / " + item.jas_thaiFullname + " / " + item.jas_position + " / " + item.jas_department + user_desc,
						value: item.uemail + "@jasmine.com"
					}
				}));
			},
			error: function() {
				console.log("autocomplete fail!!");
				$('#page_loading').fadeOut();
			}
		});
	}
	else {
		modalAlert("กรุณาระบุ สาขาที่ต้องการแจ้ง");
		$('#modal_alert').on('hidden.bs.modal', function (e) {
			$('#sel_select_shop').focus();
		})
	}
}

function source_auto_emp(request, response) {
	var url = "json_redebt.aspx?qrs=autoEmp&kw=" + request.term + "&token=" + $('input[xd="hide_token"]').val();
	console.log(url)
	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		success: function( data ) {
			response( $.map( data, function( item ) {
				return {
					uemail: item.email.replace("@jasmine.com", ""),
					label: item.email + " / " + item.thaiFullname + " / " + item.position + " / " + item.department ,
					value: item.email
				}
			}));
		},
		error: function() {
			console.log("autocomplete fail!!");
			$('#page_loading').fadeOut();
		}
	});
}

function recommendOperator() {
	if($('input[xd="hide_can_edit_approval"]').val() == 1){

		var province_short = $('input[xd="hide_province_short"]').val();

		if(province_short.trim().length == 0) {
			province_short = "none";
		}

		// var url = "json_redebt.aspx?qrs=autoDepartUser&shop_code=" + shop_code;
		var url = "json_redebt.aspx?qrs=autoDepartUser&province_short=" + province_short;
		console.log(url)
		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			success: function( data ) {
				var uemail_approve = "";
				var uemail_verify1 = "";
				var uemail_verify2 = "";

				var label_approve = "";
				var label_verify1 = "";
				var label_verify2 = "";

				var i_approve = 0;
				var i_verify1 = 0;
				var i_verify2 = 0;

				if(data.length > 0){

					$.each(data,function( i,item ) {
						var label = item.jas_thaiFullname + " / " + item.jas_position + " / " + item.jas_department;

						if( item.depart_id == 1011) {
							uemail_approve = item.uemail;
							label_approve = item.jas_thaiFullname + " / " + item.jas_position + " / " + item.jas_department;
							i_approve++;
						}

						if( item.depart_id == 1012) {
							uemail_verify1 = item.uemail;
							label_verify1 = item.jas_thaiFullname + " / " + item.jas_position + " / " + item.jas_department;
							i_verify1++;
						}

						if( item.depart_id == 1013) {
							uemail_verify2 = item.uemail;
							label_verify2 = item.jas_thaiFullname + " / " + item.jas_position + " / " + item.jas_department;
							i_verify2++;
						}
					});

					// ถ้ามีมากกว่า 1 ไม่ต้อง recommend ให้ search และเลือกเอง
					if(i_approve > 1){
						uemail_approve = "";
						label_approve = "";
					}

					if(i_verify1 > 1){
						uemail_verify1 = "";
						label_verify1 = "";
					}

					if(i_verify2 > 1){
						uemail_verify2 = "";
						label_verify2 = "";
					}
					// ถ้ามีมากกว่า 1 ไม่ต้อง recommend ให้ search และเลือกเอง

				}

				$('#auto_approve').removeClass("error");
				$('#auto_approve').val((uemail_approve != "" ? uemail_approve + "@jasmine.com" : uemail_approve));
				$('input[xd="hide_uemail_approve"]').val(uemail_approve);
				$('#txt_desc_approve').html(label_approve);

				$('#auto_verify1').removeClass("error");
				$('#auto_verify1').val((uemail_verify1 != "" ? uemail_verify1 + "@jasmine.com" : uemail_verify1));
				$('input[xd="hide_uemail_verify1"]').val(uemail_verify1);
				$('#txt_desc_verify1').html(label_verify1);

				$('#auto_verify2').removeClass("error");
				$('#auto_verify2').val((uemail_verify2 != "" ? uemail_verify2 + "@jasmine.com" : uemail_verify2));
				$('input[xd="hide_uemail_verify2"]').val(uemail_verify2);
				$('#txt_desc_verify2').html(label_verify2);
			},
			error: function() {
				console.log("autocomplete fail!!");
				$('#page_loading').fadeOut();
			}
		});
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////


function loadDescApprove(){
	var url = "json_redebt.aspx?qrs=autoDepartUser&uemail=" + $('input[xd="txt_uemail_approve"]').val();
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				var txt = data[0].jas_thaiFullname + " / " + data[0].jas_position + " / " + data[0].jas_department;
				$('.txt-desc-approve').html(txt);
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

function loadDescVerify1(){
	var url = "json_redebt.aspx?qrs=autoDepartUser&uemail=" + $('input[xd="txt_uemail_verify1"]').val();
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				var txt = data[0].jas_thaiFullname + " / " + data[0].jas_position + " / " + data[0].jas_department;
				$('.txt-desc-verify1').html(txt);
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

function loadDescVerify2(){
	var url = "json_redebt.aspx?qrs=autoDepartUser&uemail=" + $('input[xd="txt_uemail_verify2"]').val();
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				var txt = data[0].jas_thaiFullname + " / " + data[0].jas_position + " / " + data[0].jas_department;
				$('.txt-desc-verify2').html(txt);
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


function getEmpDetail() {
	var url = "json_redebt.aspx?qrs=getEmpDetail&uemail=" + $('input[xd="hide_uemail"]').val() + "&token=" + $('input[xd="hide_token"]').val();
	console.log(url)
	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		success: function( data ) {
			if(data.length > 0){
				$el = $('select[xd="sel_create_ro"]');

				switch(data[0].department) {
					case "ภาคตะวันออก (RO1)":
					$el.val("01")
					$el.attr("disabled", true); 
					load3bbShop("01")
					break;

					case "ภาคตะวันออกเฉียงเหนือตอนล่าง (RO2)":
					$el.val("02")
					$el.attr("disabled", true); 
					load3bbShop("02")
					break;

					case "ภาคตะวันออกเฉียงเหนือตอนบน (RO3)":
					$el.val("03")
					$el.attr("disabled", true); 
					load3bbShop("03")
					break;
					
					case "ภาคเหนือตอนล่าง (RO4)":
					$el.val("04")
					$el.attr("disabled", true); 
					load3bbShop("04")
					break;
					
					case "ภาคเหนือตอนบน (RO5)":
					$el.val("05")
					$el.attr("disabled", true); 
					load3bbShop("05")
					break;
					
					case "ภาคตะวันตก (RO6)":
					$el.val("06")
					$el.attr("disabled", true); 
					load3bbShop("06")
					break;
					
					case "ภาคใต้ตอนบน (RO7)":
					$el.val("07")
					$el.attr("disabled", true); 
					load3bbShop("07")
					break;
					
					case "ภาคใต้ตอนล่าง (RO8)":
					$el.val("08")
					$el.attr("disabled", true); 
					load3bbShop("08")
					break;
					
					case "ภาคกลาง (RO9)":
					$el.val("09")
					$el.attr("disabled", true); 
					load3bbShop("09")
					break;
					
					case "กรุงเทพฯและปริมณฑล (RO10)":
					$el.val("10");
					$el.attr("disabled", true); 
					load3bbShop("10")
					break;
				}
			}
		},
		error: function() {
			console.log("autocomplete fail!!");
			$('#page_loading').fadeOut();
		}
	});
}

function setCC1(uemail) {
	$('#modal_ro10').modal('hide');

	if($('input[xd="txt_uemail_cc1"]').val() == "") {
		$('.form-cc1').show();
		$('input[xd="txt_uemail_cc1"]').val(uemail);
		$('#auto_cc1').val(uemail+"@jasmine.com");
		$('#auto_cc1').focus();
	}
	else {
		$('.form-cc2').show();
		$('input[xd="txt_uemail_cc2"]').val(uemail);
		$('#auto_cc2').val(uemail+"@jasmine.com");
		$('#auto_cc2').focus();
	}
}


/********************* load Shop ผู้สร้างคำขอ *********************/
$('#sel_create_shop').change(function() {
	$('input[xd="hide_create_shop"]').val($(this).val());
});

$('select[xd="sel_create_ro"]').change(function() {
	load3bbShop($(this).val());
});

function load3bbShop(ro = "", shop_code = ""){
	var $el = $('#sel_create_shop');
	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด.."));

	if(ro == ""){
		$el.empty();
		$el.append($("<option></option>")
			.attr("value", "").text("กรุณาเลือก RO ผู้สร้างคำขอก่อน"));
	}
	else {
		var url = "json_default.aspx?qrs=load3bbShop&ro=" + ro;
		console.log(url);

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			timeout: 120000,
			success: function( data ) { 
				$el.empty();
				$el.append($("<option></option>")
					.attr("value", "").text("เลือก Shop ผู้สร้างคำขอ"));

				$el.append($("<option></option>")
					.attr("value", "none").text("ไม่ได้ประจำ Shop"));

				$.each(data,function( i,item ) {
					$el.append($("<option></option>")
						.attr("value", item.shop_code).text(item.shop_label));
				});

				$el.val(shop_code);
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
/********************* load Shop ผู้สร้างคำขอ *********************/

function loadSelectShop(shop_code, update_from = 0){
	var $el = $('#sel_select_shop');
	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด.."));

	var url = "json_backof.aspx?qrs=loadShopStock";
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			var temp_selected = "";

			$el.empty();
			$el.append($("<option></option>")
				.attr("value", "").text("กรุณาเลือกสาขา"));

			$.each(data,function( i,item ) {
				if(shop_code == item.shop_code) {
					temp_selected = item.shop_label;

					$el.append($("<option></option>")
						.attr("value", item.shop_code).text(item.shop_label)
						.attr('selected', 'selected'));
				}
				else {
					$el.append($("<option></option>")
						.attr("value", item.shop_code).text(item.shop_label));
				}
			});

			if(update_from == 0 && temp_selected != "") {
				$('input[xd="hide_select_shop"]').val(shop_code);
				selectShop(shop_code);
			}
			else if(update_from == 1) {
				$('#txt_select_shop').val(temp_selected);
				$('#inn_select_shop').html(temp_selected);
				$('#inn_shop_code').html($('input[xd="hide_province_short"]').val());
				$('#inn_area_ro').html("(RO" + $('input[xd="hide_area_ro"]').val() + ")");
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

$('#sel_select_shop').change(function() {
	$('input[xd="hide_select_shop"]').val($(this).val());
	selectShop($(this).val());
});

function selectShop(shop_code) {
	// clear recommendOperator
	$('input[xd="hide_area_ro"]').val("");
	$('input[xd="hide_province_short"]').val("");

	$('#auto_approve').val("");
	$('input[xd="hide_uemail_approve"]').val("");
	$('#txt_desc_approve').html("");

	$('#auto_verify1').val("");
	$('input[xd="hide_uemail_verify1"]').val("");
	$('#txt_desc_verify1').html("");

	$('#auto_verify2').val("");
	$('input[xd="hide_uemail_verify2"]').val("");
	$('#txt_desc_verify2').html("");
	// clear recommendOperator

	var url = "json_backof.aspx?qrs=getProvinceShort&shop_code=" + shop_code;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				$('input[xd="hide_area_ro"]').val(data[0].ro);
				$('input[xd="hide_province_short"]').val(data[0].province_short);
			}
			recommendOperator();
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