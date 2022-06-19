
function callDataTable() {
	var onthetable = $('#onthetable').DataTable({
		bFilter: false
		,paging: false
		,"aaSorting": []
		,"ordering": false
		,"iDisplayLength": -1
		,"bLengthChange": false
		,"responsive": false
		,"bInfo" : false
		,colReorder: {
			order: ck_ordercolumn
		}
	});

	onthetable.columns( ck_nonedis ).visible( false, false );

	let viewport = document.querySelector('#display_table')
	let content = viewport.querySelector('#onthetable_wrapper')

	let sb = new ScrollBooster({
		viewport,
		content,
		mode: 'x',
		textSelection: true,
		onUpdate: (data)=> {
			viewport.scrollLeft = data.position.x
		}
	})
}

$('#btn_filter_search').click(function() {
	loadAllRequest();
});

function loadProject() {
	var $el = $('#sel_project_search');

	$.getJSON('json_default.aspx?qrs=loadProject', function(data) {
		$el.empty();

		$.each(data,function( i,item ) {
			$($el).append($("<option></option>")
				.attr('selected', true).attr("value", item.project_id).text(item.project_prefix + ". " + item.project_name));
		});

		$el.multiselect({
			nonSelectedText: 'เลือกระบบ'
			, allSelectedText: 'ทุกระบบ'
			, includeSelectAllOption: true
			, selectAllText: 'ทุกระบบ'
			, buttonWidth: '155px'
			, onDropdownHide: function(event) {
				if($('#sel_project_search').val() != "") {
					loadSubject($('#sel_project_search').val());
				}
			}
		});

		$('#sel_project_fake').hide();
		$el.show();
	});
}

function loadSubject(project_id) {
	var div_sel_subject = "<div id='div_sel_subject' class='form-control'><select id='sel_subject_fake' class='form-control'><option value=''>กำลังโหลด..</option></select><select id='sel_subject_search' class='form-control multiselect' multiple='multiple' style='display:none;'></select></div>";
	$('#div_sel_subject').replaceWith(div_sel_subject);

	var $el = $('#sel_subject_search');

	$el.empty();
	$el.append($("<option></option>")
		.attr("value", "").text("กำลังโหลด"));

	var url = 'json_default.aspx?qrs=loadSubject&project_id=' + project_id;
	console.log(url);

	$.getJSON(url, function(data) {
		$el.empty();

		$.each(data,function( i,item ) {
			$($el).append($("<option></option>")
				.attr('selected', true).attr("value", item.subject_id).text(item.project_prefix + " " + item.subject_prefix + ". " + item.subject_name));

			firstsubject += item.subject_id + ",";
		});

		$el.multiselect({
			nonSelectedText: 'เลือกหัวข้อ'
			, allSelectedText: 'ทุกหัวข้อ'
			, includeSelectAllOption: true
			, selectAllText: 'ทุกหัวข้อ'
			, buttonWidth: '155px'
		});

		$('#sel_subject_fake').hide();
		$el.show();


		if(firstload == 1){
			if(firstsubject.length > 0){
				firstsubject = firstsubject.slice(0, -1);
			}

			firstCookie(firstsubject);
			loadCustomTable();

			loadStatus();
		}
	});
}

function loadStatus() {
	var $el = $('#sel_status_search');

	$.getJSON('json_default.aspx?qrs=loadStatus', function(data) {
		$el.empty();

		$.each(data,function( i,item ) {
			if(item.status_id != 100){
				$el.append($("<option></option>")
					.attr('selected', true).attr("value", item.status_id).text(item.status_name));
			}
			else {
				$el.append($("<option></option>")
					.attr("value", item.status_id).text(item.status_name));
			}
		});

		$el.multiselect({
			nonSelectedText: 'เลือกสถานะ'
			, allSelectedText: 'ทุกสถานะ'
			, includeSelectAllOption: true
			, selectAllText: 'ทุกสถานะ'
			, buttonWidth: '155px'
		});

		$('#sel_status_fake').hide();
		$el.show();

		loadRO();
	});
}

function loadRO() {
	var $el = $('#sel_area_ro_search');

	$.getJSON('json_default.aspx?qrs=loadRO', function(data) {
		$el.empty();

		$.each(data,function( i,item ) {
			$el.append($("<option></option>")
				.attr('selected', true).attr("value", item.ro_value).text(item.ro_title));
		});

		$el.multiselect({
			nonSelectedText: 'เลือกพื้นที่'
			, allSelectedText: 'ทุกพื้นที่'
			, includeSelectAllOption: true
			, selectAllText: 'ทุกพื้นที่'
			, buttonWidth: '155px'
		});

		$('#sel_area_ro_fake').hide();
		$el.show();

		loadAllRequest();
	});
}


function modeDataCountAllRequest(main_url){
	var count_url = "json_default.aspx?qrs=modeDataCountAllRequest" + main_url;

	$.ajax({
		url: count_url,
		cache: false,
		timeout: 120000,
		success: function( count_data ) { 
			temp_url = main_url;

			$('#count_data').html("จำนวนข้อมูล  " + numberWithCommas(count_data) + " ผลลัพธ์");
			$('#twbs_pagination').replaceWith("<ul id='twbs_pagination' class='pagination-sm'></ul>");

			if(count_data > 0) {
				$('#twbs_pagination').twbsPagination({
					totalPages: ((count_data-1)/page_size) + 1,
					visiblePages: 5,
					onPageClick: function (event, page) {
						$('#page-content').text('Page ' + page);

						startLoader();
						modeDataAllRequest(temp_url, page);
					},
					first: 'หน้าแรก',
					last: 'สุดท้าย',
					prev: 'ก่อนหน้า',
					next: 'ถัดไป'
				});
			}
			else {
				modeDataAllRequest(main_url, 1);
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

function explainFilter() {
	$('#filter_bar').slideDown( 300, function() {});
	$('#btn_search').hide();
	$('#btn_search_x').show();

	$.cookie('cookie_btn_search_' + ck_version + ck_uemail, "show", { expires : 7 });
	console.log("set cookie_btn_search = " + $.cookie('cookie_btn_search_' + ck_version + ck_uemail));
}

function unplainFilter() {
	$('#filter_bar').slideUp( 300, function() {});
	$('#btn_search_x').hide();
	$('#btn_search').show();

	$.cookie('cookie_btn_search_' + ck_version + ck_uemail, "x", { expires : 7 });
	console.log("set cookie_btn_search = " + $.cookie('cookie_btn_search_' + ck_version + ck_uemail));
}

function cookieFilter() {
	if(typeof $.cookie('cookie_btn_search_' + ck_version + ck_uemail) === 'undefined'){
	}
	else{
		if($.cookie('cookie_btn_search_' + ck_version + ck_uemail) == "show"){
			explainFilter();
		}
	}
}

//-------------------------------------------------------------- page tab bar

function nextCurrentPatch() {
	var url = "json_default.aspx?qrs=loadCurrentPatchModeData";

	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				temp_patch_number = data[0].patch_number;

				var html = '<a href="' + data[0].patch_img + '" data-lightbox="updatePatch" id="alert_update"></a>';

				$('#update_patch').html(html);
				$('#alert_update').click();
			}
		},
		error: function(x, t, m) {
			console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);
		}
	});
}

function loadNotReadPatch() {
	var url = "json_default.aspx?qrs=loadNotReadPatchModeData";

	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0){
				$.each(data,function( i,item ) {

					var html = '<div class="alert alert-patch info-warning alert-dismissible" role="alert" id="' + item.patch_number + '">' +
					'<a href="' + item.patch_img + '" data-lightbox="' + item.patch_number + '" class="close" onclick="readPatch(\'' + item.patch_number + '\')"><span class="glyphicon glyphicon glyphicon-export"></span> คลิกอ่าน</a>' +
					'<p><span>แจ้งอัพเดท (' + item.patch_date + '): ' + item.patch_title + '</span></p>' +
					'</div>';

					$('.alert-bar').append(html);
				});

				$('.alert-bar').slideDown( 300, function() {});
			}
		},
		error: function(x, t, m) {
			console.log('ajax error /n x>' + x + ' t>' + t + ' m>' + m);
		}
	});
}

//-------------------------------------------------------------- page tab bar
