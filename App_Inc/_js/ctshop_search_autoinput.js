

/********************* autocomplete shop code *********************/

$('#auto_shop_code').autocomplete({
	minLength: 2,
	focus: function(event, ui) {
		event.preventDefault();
		$("#auto_shop_code-search").val(ui.item.label);
	},
	source: function( request, response ) {
		var url = "json_ctshop.aspx?qrs=autoShopCode&kw=" + request.term;
		console.log(url)

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			success: function( data ) {
				response( $.map( data, function( item ) {
					return {
						ro: item.ro,
						cluster: item.cluster,
						province_short: item.province_short,
						label: item.shop_code + " / " + item.shop_name + " / " + item.province_short + " / " + item.cluster + " / RO" + item.ro ,
						value: item.shop_code
					}
				}));
			},
			error: function() {
				console.log("autocomplete fail!!");
				$('#page_loading').fadeOut();
			}
		});
	}
});

$('#auto_shop_code').on('autocompleteselect', function (e, ui) {
	$('input[xd="hide_shop_code"]').val(ui.item.value);

	$('#auto_province_short').prop('readonly', true);
	$('#auto_province_short').val(ui.item.province_short);
	$('input[xd="hide_province_short"]').val(ui.item.province_short);

	$('input[xd="txt_cluster"]').val(ui.item.cluster);
	$('input[xd="txt_area_ro"]').val(ui.item.ro);
	// span_inn_area_ro();

	recommendOperator();
});

$('#auto_shop_code').click(function(){
	$('#auto_shop_code').val("");
});

$('#auto_shop_code').focusout(function() {
	$('#auto_shop_code').val("");
	
	if($('input[xd="hide_shop_code"]').val().trim().length > 0){
		$('#auto_shop_code').val($('input[xd="hide_shop_code"]').val());
	}
});

function loadAutoBoxShopCode(){
	$('#auto_shop_code').val($('input[xd="hide_shop_code"]').val());
	$('#inn_shop_code').html($('input[xd="hide_shop_code"]').val());

	$('#auto_shop_code').attr("placeholder", $('input[xd="hide_shop_code"]').val());

	// span_inn_area_ro();
}

/********************* autocomplete shop code *********************/

/********************* autocomplete province *********************/

$('#auto_province_short').autocomplete({
	minLength: 2,
	focus: function(event, ui) {
		event.preventDefault();
		$("#auto_province_short-search").val(ui.item.label);
	},
	source: function( request, response ) {
		var url = "json_redebt.aspx?qrs=autoProvince&kw=" + request.term;
		console.log(url)

		$.ajax({
			url: url,
			cache: false,
			dataType: "json",
			success: function( data ) {
				response( $.map( data, function( item ) {
					return {
						ro: item.ro,
						cluster: item.cluster,
						label: item.province_name + " / " + item.province_short + " / " + item.cluster + " / RO" + item.ro ,
						value: item.province_short
					}
				}));
			},
			error: function() {
				console.log("autocomplete fail!!");
				$('#page_loading').fadeOut();
			}
		});
	}
});

$('#auto_province_short').on('autocompleteselect', function (e, ui) {
	$('input[xd="hide_province_short"]').val(ui.item.value);
	$('input[xd="txt_cluster"]').val(ui.item.cluster);
	$('input[xd="txt_area_ro"]').val(ui.item.ro);
	// span_inn_area_ro();

	recommendOperator();
});

$('#auto_province_short').click(function(){
	if ( $('#auto_province_short').is('[readonly]') ) { 
	}
	else {
		$('#auto_province_short').val("");
	}
});

$('#auto_province_short').focusout(function() {
	$('#auto_province_short').val("");
	
	if($('input[xd="hide_province_short"]').val().trim().length > 0){
		$('#auto_province_short').val($('input[xd="hide_province_short"]').val());
	}
});

function loadAutoBoxProvShort(){
	$('#auto_province_short').val($('input[xd="hide_province_short"]').val());
	$('#inn_province_short').html($('input[xd="hide_province_short"]').val());

	$('#auto_province_short').attr("placeholder", $('input[xd="hide_province_short"]').val());

	// span_inn_area_ro();
}

// function span_inn_area_ro(){
// 	$('#span_area_ro').html("");

// 	if($('input[xd="hide_area_ro"]').val().trim().length > 0){
// 		$('#span_area_ro').html("RO" + $('input[xd="hide_area_ro"]').val() + "");
// 		$('#inn_area_ro').html("(RO" + $('input[xd="hide_area_ro"]').val() + ")");
// 	}
// }
/********************* autocomplete shop code *********************/


/********************* auto default search input *********************/
