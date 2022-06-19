
$(document).ready(function() { 
	$('[data-toggle="popover"]').popover({html:true, trigger:'hover'}); 
});

var firstload = 1;

var count_req = 0;
var loading_sample_detail = 0;

var temp_sample_detail = 0;
var temp_sum_all = 0;

var startTime,loadTime;
