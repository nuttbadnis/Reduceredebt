// ------------------ อายุสัญญา
function load_ctphase_remark(){
	var sel_ctphase = $('select[xd="sel_ctphase"]').val();
	if (sel_ctphase == 99999){
		$('#div_ctphase_remark').show();
		$('#inn_ctphase_remark').html("( "+$('[id*=txt_ctphase_remark]').val()+" )");
	}
	else {
		$('#div_ctphase_remark').hide();
	}
}
$('select[xd="sel_ctphase"]').change(function() {
	if($(this).val() == 99999){
		$('#div_ctphase_remark').show();
	}
	else {
		$('#div_ctphase_remark').hide();
	}
});

// function load_ctphase_remark(){
// 	var sel_ctphase = $('select[xd="sel_ctphase"]').val();
// 	get_ctphase_unit(sel_ctphase,1);
// }

// $('select[xd="sel_ctphase"]').change(function() {
// 	var ctphase_id = $(this).val();
// 	get_ctphase_unit(ctphase_id,0);

// });

function get_ctphase_unit(ctphase_id,get){
	var url = "json_ctshop.aspx?qrs=getContractUnit&p_id=" + ctphase_id;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		success: function( data ) {
			console.log(data[0].phase_unit);
			if(get == '0'){
				console.log('0');
				$('#ctphase_unit').html(data[0].phase_unit);
			}else{
				console.log('1');
				$('#inn_ctphase_remark').html("( "+$('[id*=txt_ctphase_remark]').val()+" "+data[0].phase_unit+" )");
			}
		},
	});
}
// function nums_character(nums,input){
// 	var input_char = $('#"'+input+'"').length;
// 	if(input_char < nums){
// 		check
// 	}else{

// 	}
// }
function preview_img_files(input) {
	console.log("preview_img_input_name : "+input.name);
	if (input.files && input.files[0]) {
		var reader = new FileReader();

		reader.onload = function (e) {
			$('#view_'+input.name+'')
				.attr('src', e.target.result)
				.width("min-content")
				.height("min-content")
				.css("display", "block");	
		};

		reader.readAsDataURL(input.files[0]);
	}
}
