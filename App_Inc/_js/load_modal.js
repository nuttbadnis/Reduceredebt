
function modalAlert(e){
	$('#txt_alert').html(e)
	$('#modal_alert').modal("show");
}

$( document ).ajaxStart(function() {
	$('#page_loading').fadeIn();
});

$( document ).ajaxStop(function() {
	$('#page_loading').fadeOut();
});

function modalPopLink(e, url){
	$('#txt_title').html(e)
	$('#modal_pop_link').modal('show').find('.modal-body').load(url);
}