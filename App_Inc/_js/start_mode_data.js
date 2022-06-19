
$(document).ready(function() { 
	$('[data-toggle="popover"]').popover({html:true, trigger:'hover'}); 

	if(_GET('all') == 1){
		$('#chk_current').prop('checked', true);
	}
});

var temp_url;
var page_size = 10;

var firstload = 1;
var firstsubject = "";

var ck_ordercolumn;
var ck_nonedis;
var ck_uemail = $('#hide_uemail').val();

var temp_sum_all = 0;

var startTime,loadTime;

var loop_loading;
var count_loading = -1;
var quote_load = "";



