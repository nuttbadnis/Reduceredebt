
function modalAlert(e){
	$('#txt_alert').html(e)
	$('#modal_alert').modal("show");
}

function ajaxError(){
	modalAlert("ไม่สำเร็จ กรุณาลองอีกครั้ง หรือติดต่อ support_pos@jasmine.com");
	$('#modal_alert').on('hidden.bs.modal', function (e) {
		location.reload();
	})
}

function startTime(){
	startTime = new Date().getTime();
}

function finishTime(){
	loadTime = (new Date().getTime() - startTime)/1000;
	console.log("loadTime = " + loadTime + " sec");
}

function startLoader(){
	$('#page_loading').show();

	if(count_loading < 0){
		count_loading = 0;
		$('#count_loading').html("");

		loop_loading = setInterval(function(){
			$('#count_loading').html("- " + (++count_loading) + " -");

			if (count_loading%5 == 0) {
				quoteShow();
			}
		}, 1000);
	}

	if(quote_load == ""){
		quoteShow();
	}
}

function quoteShow() {
	var url = "App_Inc/quote_txt.json";
	// console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 500,
		success: function( data ) { 
			if(data.length > 0) {
				var rnd = randomNum(0, data.length-1)
				quote_load = data[rnd].quote_txt;

				$('#txt_quote').html(quote_load);
			}
		},
		error: function(x, t, m) {
			console.log('ajax error quoteShow');
		}
	});

	function randomNum(min, max){
		return Math.floor(Math.random() * max) + min;
	}
}

function endLoader(){
	$('#page_loading').fadeOut();

	count_loading = -1;
	clearInterval(loop_loading)
	quote_load = "";
}

var istart_typ = 0;

function dotTypeWriter() {
	var speed = 1000;
	var txt = 'เพราะคนเราไม่ได้ยืน ณ จุดเดียวกัน เหตุผลในการตัดสินใจจึงแตกต่างกัน';

	if (istart_typ < txt.length) {
		document.getElementById("txt_quote").innerHTML += txt.charAt(istart_typ);
		istart_typ++;
		setTimeout(dotTypeWriter, speed);
	}
}

function itemShop(shop_code, shop_name, limit) {
	if(checkNotEmpty(shop_code)) {
		shop_name = shop_code + ": " + shop_name;
		return limitStr(shop_name, limit);
	}

	return '-';
}

function itemNullConvertAmount(amount, unitStr) {
	amount = itemNull(amount)
	
	if(amount != "-") {
		amount = convertAmount(amount) + " " + unitStr;
	}

	return amount;
}

function itemNullConvertUprentPercent(amount) {
	var str_amount = itemNull(amount)

	if(amount != "-") {
		str_amount = "คงเดิม";

		if($.isNumeric(amount) == true){
			if(amount > 0) {
				str_amount = amount + "%";
			}
			amount = amount + "%";
		}

		str_amount = "<span title='" + amount + "'>" +  str_amount  + "</span>";
	}

	return str_amount;
}

//-------------------------------------------------------------- custom table & cookie

function paginateScroll() {
	$('html, body').animate({
		scrollTop: $("body").offset().top
	}, 100);

	$(".paginate_button").unbind('click', paginateScroll);
	$(".paginate_button").bind('click', paginateScroll);
}

function doubleScroll(element) {
	var top_scroll = document.getElementById('top_scroll');
	if (top_scroll) top_scroll.parentNode.removeChild(top_scroll);

	var scrollbar= document.createElement('div');
	scrollbar.setAttribute("id", "top_scroll");
	scrollbar.appendChild(document.createElement('div'));
	scrollbar.style.overflow= 'auto';
	scrollbar.style.overflowY= 'hidden';
	scrollbar.firstChild.style.width= element.scrollWidth+'px';
	scrollbar.firstChild.style.paddingTop= '1px';
	scrollbar.firstChild.appendChild(document.createTextNode('\xA0'));
	scrollbar.onscroll= function() {
		element.scrollLeft= scrollbar.scrollLeft;
	};
	element.onscroll= function() {
		scrollbar.scrollLeft= element.scrollLeft;
	};
	element.parentNode.insertBefore(scrollbar, element);
}

function loadCustomTable(){

	$.each(ck_ordercolumn, function( i, value ) {
		$('#ordercolumn').append(li_ordercolumn[value]);
	});

	$.each(ck_nonedis, function( i, value ) {
		$('.disorplay:checkbox:eq(' + value + ')').prop('checked', false);
		$('#ordercolumn li:eq(' + value + ')').addClass('txt-red');
	});

	$('.disorplay').click(function() {
		if($('#chk_' + $(this).val()).prop('checked') == false){
			$('#' + $(this).val()).addClass('txt-red');
		}
		else {
			$('#' + $(this).val()).removeClass('txt-red');
		}
	});
}

$('#btn_save_custom').click(function() {
	$('#page_loading').fadeIn();
	$('#modal_custom').modal('hide');

	ck_ordercolumn = $("#ordercolumn").sortable("toArray");

	ck_nonedis = [];
	$('.disorplay:checkbox').each(function(i){
		if($(this).prop('checked') == false){
			ck_nonedis.push(parseInt(i));
		}
	});

	loadAllRequest();
});

function modalCustom(){
	$( "#ordercolumn" ).sortable({
		placeholder: "placeholder"
	});
	$( "#ordercolumn" ).disableSelection();

	$('#modal_custom').modal("show");
}


$('#btn_default_custom').click(function() {
	clearCookie();
});

function clearCookie(){
	$.removeCookie('cookie_ordercolumn_' + ck_version + ck_uemail);
	$.removeCookie('cookie_nonedis_' + ck_version + ck_uemail);
	$.removeCookie('cookie_sorting_' + ck_version + ck_uemail);

	location.reload();
}

function saveCookie(){
	$.cookie('cookie_ordercolumn_' + ck_version + ck_uemail, JSON.stringify(ck_ordercolumn), { expires : 30 });
	$.cookie('cookie_nonedis_' + ck_version + ck_uemail, JSON.stringify(ck_nonedis), { expires : 30 });
	$.cookie('cookie_subject_' + ck_version + ck_uemail, $('#sel_subject_search').val(), { expires : 7 });
	$.cookie('cookie_status_' + ck_version + ck_uemail, $('#sel_status_search').val(), { expires : 7 });
	$.cookie('cookie_area_ro_' + ck_version + ck_uemail, $('#sel_area_ro_search').val(), { expires : 7 });
}

function firstCookie(){
	if(typeof $.cookie('cookie_ordercolumn_' + ck_version + ck_uemail) === 'undefined'){
		$.cookie('cookie_ordercolumn_' + ck_version + ck_uemail, JSON.stringify(first_ordercolumn)); // JSON.stringify บันทึก array เป็น text json
	}
	else{
		$.cookie('cookie_ordercolumn_' + ck_version + ck_uemail, $.cookie('cookie_ordercolumn_' + ck_version + ck_uemail), { expires : 30 });
	}

	if(typeof $.cookie('cookie_nonedis_' + ck_version + ck_uemail) === 'undefined'){
		$.cookie('cookie_nonedis_' + ck_version + ck_uemail, JSON.stringify(first_nonedis));
	}
	else{
		$.cookie('cookie_nonedis_' + ck_version + ck_uemail, $.cookie('cookie_nonedis_' + ck_version + ck_uemail), { expires : 30 });
	}

	if(typeof $.cookie('cookie_sorting_' + ck_version + ck_uemail) === 'undefined'){
		$.cookie('cookie_sorting_' + ck_version + ck_uemail, "create_date desc");
	}
	else{
		$.cookie('cookie_sorting_' + ck_version + ck_uemail, $.cookie('cookie_sorting_' + ck_version + ck_uemail), { expires : 30 });
	}

	if(typeof $.cookie('cookie_subject_' + ck_version + ck_uemail) === 'undefined'){
		$.cookie('cookie_subject_' + ck_version + ck_uemail, firstsubject);
	}
	else{
		$.cookie('cookie_subject_' + ck_version + ck_uemail, $.cookie('cookie_subject_' + ck_version + ck_uemail), { expires : 7 });
	}

	if(typeof $.cookie('cookie_status_' + ck_version + ck_uemail) === 'undefined'){
		$.cookie('cookie_status_' + ck_version + ck_uemail, "0,110,10,20,50,60,105");
	}
	else{
		$.cookie('cookie_status_' + ck_version + ck_uemail, $.cookie('cookie_status_' + ck_version + ck_uemail), { expires : 7 });
	}

	if(typeof $.cookie('cookie_area_ro_' + ck_version + ck_uemail) === 'undefined'){
		$.cookie('cookie_area_ro_' + ck_version + ck_uemail, "01,02,03,04,05,06,07,08,09,10");
	}
	else{
		$.cookie('cookie_area_ro_' + ck_version + ck_uemail, $.cookie('cookie_area_ro_' + ck_version + ck_uemail), { expires : 7 });
	}

	if(typeof $.cookie('cookie_btn_search_' + ck_version + ck_uemail) === 'undefined'){
		$.cookie('cookie_btn_search_' + ck_version + ck_uemail, "x");
	}
	else{
		$.cookie('cookie_btn_search_' + ck_version + ck_uemail, $.cookie('cookie_btn_search_' + ck_version + ck_uemail), { expires : 7 });
	}

	ck_ordercolumn = $.parseJSON($.cookie('cookie_ordercolumn_' + ck_version + ck_uemail)); // parse จาก json (ข้อความ) เป็น array
	ck_nonedis = $.parseJSON($.cookie('cookie_nonedis_' + ck_version + ck_uemail)); // parse จาก json (ข้อความ) เป็น array
}

//-------------------------------------------------------------- custom table & cookie

//-------------------------------------------------------------- popup patch

var temp_patch_number = "";
var temp_read_patch_number = "";

lightbox.option({
	'positionFromTop' : 30,
	'fitImagesInViewport' : false,
	'alwaysShowNavOnTouchDevices' : false
});

$('.lb-close').click(function() { 
	if(temp_patch_number != ""){
		var url = "json_default.aspx?qrs=acknowPatch";

		console.log(url + " patch_number=" + temp_patch_number + " uemail=" + $('#hide_uemail').val());

		$.ajax({
			url: url,
			cache: false,
			type: "post",
			timeout: 60000,
			data: {  
				patch_number: temp_patch_number,
				uemail: $('#hide_uemail').val()
			},
			success: function( res ) {
				if(res == 1) {
					nextCurrentPatch();
				}
			},
			error: function(x, t, m) {
			}
		});
	}

	if(temp_read_patch_number != ""){
		$('#' + temp_read_patch_number).fadeOut();

		var url = "json_default.aspx?qrs=readingPatch";

		console.log(url + " patch_number=" + temp_read_patch_number + " uemail=" + $('#hide_uemail').val());

		$.ajax({
			url: url,
			cache: false,
			type: "post",
			timeout: 60000,
			data: {  
				patch_number: temp_read_patch_number,
				uemail: $('#hide_uemail').val()
			},
			success: function( res ) {
				if(res == 1) {
					console.log("read patch_number " + temp_read_patch_number + " success!!")
				}
			},
			error: function(x, t, m) {
			}
		});
	}
});

function readPatch(patch_number){ 
	temp_patch_number = "";
	temp_read_patch_number = patch_number;
}

//-------------------------------------------------------------- popup patch

//-------------------------------------------------------------- page tab bar

function modalPushpin(){
	$('#modal_pushpin').modal("show");
}

function loadPage(thismode) {
	$('#ul_tab').append(liTabHTML(thismode, "all", "ทุกระบบ"));

	var url = "json_default.aspx?qrs=loadProject";
	// console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			var sum_all = 0;

			$.each(data,function( i,item ) {
				// $('#ul_tab').append(liTabHTML(thismode, item.project_prefix, item.project_prefix + ". " + item.project_name));
				$('#ul_tab').append(liTabHTML(thismode, item.project_prefix, item.project_name));
				// loadNumCurrentStep(thismode, item.project_prefix);
			})
		},
		error: function(x, t, m) {
			console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);

			modalAlert("ไม่สำเร็จ กรุณาลองอีกครั้ง หรือติดต่อ support_pos@jasmine.com");
			$('#modal_alert').on('hidden.bs.modal', function (e) {
				location.reload();
			})
		}
	});

	btnpin();
	paginateScroll();

	setTimeout(function() {
		nextCurrentPatch();
		loadNotReadPatch();
	}, 1000);
}

function btnpin() {
	if($('#hide_pushpin').val() != $('#hide_tabsys').val()){
		$('#li_pin').show();
	}
}

function liTabHTML(thismode, prefix, title){
	var class_active = "";
	var span_pin = "";
	var str = prefix.toUpperCase();
	prefix = prefix.toLowerCase();

	if(thismode == "modeApprove"){
		thismode = "mode_approve_";
	}
	else {
		thismode = "mode_data_";
	}

	prefix = prefix.toLowerCase();

	if($('#hide_tabsys').val() == prefix){
		class_active = " class='active'";
		str = str + ". " + title;
		$('.tab_name').html(str);
	}

	if($('#hide_pushpin').val() == prefix){
		span_pin = "<span class='glyphicon icon-pin'></span> ";
	}

	if(prefix == "all") {
		str = title;
	}

	return "<li" + class_active + "><a href='" + thismode + prefix + ".aspx'>" + span_pin + str + "</a></li>";
	// return "<li" + class_active + "><a href='" + thismode + prefix + ".aspx'>" + span_pin + str + " <span id='badge_" + prefix + "' class='badge'><span class='glyphicon icon-spinner8 gly-spin'></span></span></a></li>";
}

function liTabHTMLbak(thismode, prefix, str){
	var class_active = "";
	var span_pin = "";

	if(thismode == "modeApprove"){
		thismode = "mode_approve_";
	}
	else {
		thismode = "mode_data_";
	}

	prefix = prefix.toLowerCase();

	if($('#hide_tabsys').val() == prefix){
		class_active = " class='active'";
		$('.tab_name').html(str);
	}

	if($('#hide_pushpin').val() == prefix){
		span_pin = "<span class='glyphicon icon-pin'></span> ";
	}

	return "<li" + class_active + "><a href='" + thismode + prefix + ".aspx'>" + span_pin + str + " <span id='badge_" + prefix + "' class='badge'><span class='glyphicon icon-spinner8 gly-spin'></span></span></a></li>";
}


function loadNumCurrentStep(thismode, prefix) {
	var url = "json_default.aspx?qrs=" + thismode + "CountAllRequest";
	url += "&uemail=" + $('#hide_uemail').val();
	url += "&udepart=" + $('#hide_udepart').val();
	url += "&groupemail=" + $('#hide_group_email').val();
	url += "&project_prefix=" + prefix.toLowerCase();
	url += "&current=1";

	if(thismode == "modeApprove"){
		url += "&status_id=0,10,20,50,60";
	}

	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		timeout: 120000,
		success: function( count_data ) { 
			spanBadgeHTML(prefix, count_data);
			temp_sum_all += parseInt(count_data);
			spanBadgeHTML("all", temp_sum_all);
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

function spanBadgeHTML(prefix, num){
	var span_html = "<span id='badge_" + prefix + "' class='badge'>0</span>";

	if(num > 0){
		span_html = "<span id='badge_" + prefix + "' class='badge badge-red'>" + num + "</span>";
	}

	prefix = prefix.toLowerCase();
	$('#badge_' + prefix).replaceWith(span_html);
}

//-------------------------------------------------------------- page tab bar