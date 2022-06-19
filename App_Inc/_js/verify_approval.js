function resetModal() {
    $('#hide_id').val("");
    $('#hide_transfer_id').val("");
    $('#hide_new_id').val("");
    $('#hide_new_uemail').val("");
    $('#auto_uemail').val("");
    $('#sel_ro').val("ALL");
    $('#sel_cluster').val("ALL");
    $('#sel_province').val("ALL");
    $('#sel_department').val("");
    $('#txt_user_desc').val("");
    $('#txt_start_date').val("");
    $('#txt_expired_date').val("");

    $('#auto_uemail').attr('disabled', false);
    $('#sel_ro').prop('disabled', false);
    $('#sel_cluster').prop('disabled', true);
    $('#sel_province').prop('disabled', true);
    $('#sel_department').attr('disabled', false);
    $('#txt_start_date').attr('disabled', false);
    $('#txt_expired_date').attr('disabled', false);

    $('#btn_save_load').hide();
    $('#btn_save_edit').hide();
    $('#btn_save_new').hide();
    $('#btn_save_transfer').hide();

    $('.txt-transfer').hide();
}

function newUser(){
    resetModal();

    $('#sel_cluster').prop('disabled', true);
    $('#sel_province').prop('disabled', true);

    $('#btn_save_new').show();
    $('#modal_title').html("เพิ่ม User ใหม่");
    $('#modal_edit').modal("show");
}

function editUser(id, uemail, ro, cluster, province, department, user_desc, start, expire){
    resetModal();

    $('#hide_id').val(id);
    $('#hide_new_uemail').val(uemail);
    $('#auto_uemail').val(uemail);
    $('#sel_ro').val(ro);
    loadCluster('#sel_cluster', ro, cluster);
    loadProvince('#sel_province', cluster, province);

    $('#sel_department').val(department);
    $('#txt_user_desc').val(user_desc);
    $('#txt_start_date').val(start);
    $('#txt_expired_date').val(expire);

    $('#auto_uemail').attr('disabled', true);
    $('#sel_department').attr('disabled', true);
    $('#txt_start_date').attr('disabled', true);

    $('#btn_save_edit').show();
    $('#modal_title').html("แก้ไขข้อมูล  User");
    $('#modal_edit').modal("show");
}

function transferUser(id, uemail, ro, cluster, province, department, user_desc){
    resetModal();

    $('#hide_transfer_id').val(id);
    $('#sel_ro').val(ro);
    loadCluster('#sel_cluster', ro, cluster, 'disabled');
    loadProvince('#sel_province', cluster, province, 'disabled');

    $('#sel_department').val(department);
    $('#txt_user_desc').val(user_desc);

    $('#sel_ro').attr('disabled', true);
    $('#sel_department').attr('disabled', true);

    $('#btn_save_transfer').show();
    $('#modal_title').html("แทนที่สิทธิ์ [" +uemail + "] ด้วย User ใหม่");
    $('#modal_edit').modal("show");

    $('.txt-transfer').show();
}

function modalEdit(duid) {
	var url = "json_default.aspx?qrs=getDUID&duid=" + duid;
	console.log(url);

	$.ajax({
		url: url,
		cache: false,
		dataType: "json",
		timeout: 120000,
		success: function( data ) { 
			if(data.length > 0) {
				editUser(duid, data[0].uemail, data[0].ro, data[0].cluster, data[0].province, data[0].depart_id, data[0].user_desc, data[0].start_date, data[0].expired_date);
			}
			else {
				modalAlert("duid: " + duid + " ?");
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

function modalTransfer(duid) {
    var url = "json_default.aspx?qrs=getDUID&duid=" + duid;
    console.log(url);

    $.ajax({
        url: url,
        cache: false,
        dataType: "json",
        timeout: 120000,
        success: function( data ) { 
            if(data.length > 0) {
                transferUser(duid, data[0].uemail, data[0].ro, data[0].cluster, data[0].province, data[0].depart_id, data[0].user_desc);
            }
            else {
                modalAlert("duid: " + duid + " ?");
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

function loadRO(id, ro = "ALL") {
    var $el = $(id);
    $el.empty();
    $el.append($("<option></option>")
        .attr("value", "").text("กำลังโหลด"));

    $.getJSON('json_default.aspx?qrs=loadRO', function(data) {
        $el.empty();
        $el.append($("<option></option>")
            .attr("value", "ALL").text("ALL"));

        $.each(data,function( i,item ) {
            $el.append($("<option></option>")
                .attr("value", item.ro_value).text(item.ro_title));
        });

        $el.val(ro);
    });
}

function loadCluster(id, ro, cluster = "ALL", dis = "") {
	var url = 'json_default.aspx?qrs=loadCluster&ro=' + ro;
	console.log(url);

    var $el = $(id);
    $el.empty();
    $el.append($("<option></option>")
        .attr("value", "").text("กำลังโหลด"));

    $.getJSON(url, function(data) {
        $el.empty();
        $el.append($("<option></option>")
            .attr("value", "ALL").text("ALL"));
            // .attr("value", "ALL").text("ALL RO" + ro));

        $.each(data,function( i,item ) {
            $el.append($("<option></option>")
                .attr("value", item.cluster).text(item.cluster));
        });

        if(ro != "ALL"){
            $el.val(cluster);
            $el.prop('disabled', false);
        }

        if(dis == "disabled"){
            $el.prop('disabled', true);
        }
    });
}

function loadProvince(id, cluster, province = "ALL", dis = "") {
    var $el = $(id);
    $el.empty();
    $el.append($("<option></option>")
        .attr("value", "").text("กำลังโหลด"));

    $.getJSON('json_default.aspx?qrs=loadProvince&cluster=' + cluster, function(data) {
        $el.empty();
        $el.append($("<option></option>")
            .attr("value", "ALL").text("ALL"));

        $.each(data,function( i,item ) {
            $el.append($("<option></option>")
                .attr("value", item.province_short).text(item.province_name));
        });

        if(cluster != "ALL"){
            $el.val(province);
            $el.prop('disabled', false);
        }

        if(dis == "disabled"){
            $el.prop('disabled', true);
        }
    });
}

$('#sel_ro').change(function() {
    var sel_ro = $(this).val();
    var sel_cluster = '#sel_cluster';
    var sel_province = '#sel_province';

    if(sel_ro != "ALL") {
        loadCluster(sel_cluster, sel_ro);
    }
    else {
        $(sel_cluster).val("ALL");
        $(sel_cluster).prop('disabled', true);
        $(sel_province).val("ALL");
        $(sel_province).prop('disabled', true);
    }
});

$('#sel_cluster').change(function() {
    var sel_cluster = $(this).val();
    var sel_province = '#sel_province';

    if(sel_cluster != "ALL") {
        loadProvince('#sel_province', sel_cluster);
    }
    else {
        $(sel_province).val("ALL");
        $(sel_province).prop('disabled', true);
    }
});


////////////////////////// autocomplete /////////////////////////////////


$('#auto_uemail').on('autocompleteselect', function (e, ui) {
    // ajaxcheckEmpPermiss(ui.item.value, function(data){
        // if(data.length == 0 || $('#hide_new_uemail').val() == ui.item.value){
            $('#hide_new_uemail').val(ui.item.value);
            $('#hide_new_id').val(ui.item.newid);
        // }
    //     else{
    //         if (typeof $('#hide_confirm_new_uemail').val() != 'undefined') {
    //             $('#hide_confirm_new_uemail').val(ui.item.value);
    //             $('#hide_confirm_new_id').val(ui.item.newid);
    //             confirmPermiss(data);
    //         }
    //         else{
    //             modalAlert("ไม่สามารถเลือกได้ เนื่องจากมี " + ui.item.value + " ในระบบแล้ว");
    //         }
    //     }
    // });

    // function ajaxcheckEmpPermiss(uemail, handleData) {
    //     var url = "json_default.aspx?qrs=checkEmpPermissJson&uemail=" + uemail + "&permission=" + $('#hide_this_edit').val();
    //     console.log(url)
    //     $.ajax({
    //         url: url,
    //         cache: false,
    //         dataType: "json",
    //         success: function( data ) {
    //             handleData(data); 
    //         }
    //     });
    // }

    // function confirmPermiss(data) {
    //     var txt_permiss;
    //     txt_permiss = "<b class='txt-red'>กรุณาตรวจสอบ และยืนยันหากต้องการเพิ่มสิทธิ์</b>";
    //     txt_permiss += "<br>"
    //     txt_permiss += "<br>"
    //     txt_permiss += "<b class='txt-blue'>สิทธิ์ปัจจุบันของ: " + data[0].uemail + " (" + data[0].jas_thaiFullname + ")</b>";
    //     txt_permiss += "<br>"

    //     txt_permiss += "<table class='table'>"
    //     txt_permiss += "<thead>"
    //     txt_permiss += "<tr>"
    //     txt_permiss += "<th>RO</th>"
    //     txt_permiss += "<th>CLUSTER</th>"
    //     txt_permiss += "<th>PROVINCE</th>"
    //     txt_permiss += "</tr>"
    //     txt_permiss += "</thead>"

    //     txt_permiss += "<tbody>"
    //     $.each(data,function( i,item ) {
    //         txt_permiss += "<tr>"
    //         txt_permiss += "<td>" + item.ro + "</td>"
    //         txt_permiss += "<td>" + item.cluster + "</td>"
    //         txt_permiss += "<td>" + item.province + "</td>"
    //         txt_permiss += "</tr>"
    //     });
    //     txt_permiss += "</tbody>"
    //     txt_permiss += "</table>"


    //     $('#txt_permiss').html(txt_permiss);
    //     $('#modal_permiss_confirm').modal("show");
    // }
});

$('#btn_permiss_confirm').click(function(){
    $('#hide_new_uemail').val($('#hide_confirm_new_uemail').val());
    $('#hide_new_id').val($('#hide_confirm_new_id').val());
    $('#auto_uemail').val($('#hide_new_uemail').val());
    $('#modal_permiss_confirm').modal("hide");
});

$('#auto_uemail').click(function(){
    $('#auto_uemail').val("");
});

$('#auto_uemail').focusout(function() {
    $('#auto_uemail').val("");

    if($('#hide_new_uemail').val().trim().length > 0){
        $('#auto_uemail').val($('#hide_new_uemail').val());
    }
});

$('#auto_uemail').autocomplete({
    minLength: 3,
    focus: function(event, ui) {
        event.preventDefault();
        $("#auto_uemail-search").val(ui.item.label);
    },
    source: function( request, response ) {
        source_auto_emp(request, response);
    }
});

function source_auto_emp(request, response) {
    var url = "json_default.aspx?qrs=autoEmp&kw=" + request.term + "&token=" + $('#hide_token').val();
    console.log(url)
    $.ajax({
        url: url,
        cache: false,
        dataType: "json",
        success: function( data ) {
        	console.log(data);
            response( $.map( data, function( item ) {
                return {
                    newid: item.employeeId,
                    label: item.email.replace("@jasmine.com", "") + " / " + item.thaiFullname + " / " + item.position + " / " + item.department,
                    value: item.email.replace("@jasmine.com", "")
                }
            }));
        },
        error: function() {
            console.log("autocomplete fail!!");
            $('#page_loading').fadeOut();
        }
    });
}

////////////////////////// autocomplete /////////////////////////////////

function saveNewDuid() {
    var uemail = $('#hide_new_uemail').val();
    var ro = $('#sel_ro').val();
    var cluster = $('#sel_cluster').val();
    var province = $('#sel_province').val();

    var department = $('#sel_department').val();
    var user_desc = $('#txt_user_desc').val();
    var start = $('#txt_start_date').val();
    var expire = $('#txt_expired_date').val();

    if(uemail.length > 0 && ro.length > 0 && cluster.length > 0 && province.length > 0 && department.length > 0 && start.length > 0){
        $('#btn_save_new').hide();
        $('#btn_save_load').show();

        $.ajax({
            url: "json_default.aspx?qrs=insertDUID",
            cache: false,
            type: "post",
            timeout: 60000,
            data: {  
                create_by: $('#hide_uemail').val(),
                uemail: uemail,
                ro: ro,
                cluster: cluster,
                province: province,
                department: department,
                user_desc: user_desc,
                start: start,
                expire: expire
            },
            success: function( res_duid ) {
            	console.log("res_duid = [" + res_duid + "]");

                if(res_duid > 0) {
                    reSyncJas(uemail, res_duid, ro);
                }
                else {
                    modalAlert('saveNewDuid ไม่สำเร็จ');
                }
            },
            error: function(x, t, m) {
                ajaxError();
            }
        });
    }
    else {
        modalAlert("กรุณากรอกข้อมูลให้ครบถ้วน!!");
    }
}

function saveEditDuid() {
    var duid = $('#hide_id').val();
    var uemail = $('#hide_new_uemail').val();
    var ro = $('#sel_ro').val();
    var cluster = $('#sel_cluster').val();
    var province = $('#sel_province').val();

    var department = $('#sel_department').val();
    var user_desc = $('#txt_user_desc').val();
    var expire = $('#txt_expired_date').val();

    if(duid.length > 0 && uemail.length > 0 && ro.length > 0 && cluster.length > 0 && province.length > 0){
        $('#btn_save_edit').hide();
        $('#btn_save_load').show();
        
        $.ajax({
            url: "json_default.aspx?qrs=updateDUID",
            cache: false,
            type: "post",
            timeout: 60000,
            data: {  
                update_by: $('#hide_uemail').val(),
                duid: duid,
                ro: ro,
                cluster: cluster,
                province: province,
                department: department,
                user_desc: user_desc,
                expire: expire
            },
            success: function( res ) {
            	console.log("res update = [" + res + "]");

                if(res > 0) {
                    reSyncJas(uemail, duid, ro);
                }
                else {
                    modalAlert('saveEditDuid ไม่สำเร็จ');
                }
            },
            error: function(x, t, m) {
                ajaxError();
            }
        });
    }
    else {
        modalAlert("กรุณากรอกข้อมูลให้ครบถ้วน!!");
    }
}

function saveTransferDuid() {
    var transferid = $('#hide_transfer_id').val();
    var uemail = $('#hide_new_uemail').val();
    var ro = $('#sel_ro').val();
    var cluster = $('#sel_cluster').val();
    var province = $('#sel_province').val();

    var department = $('#sel_department').val();
    var user_desc = $('#txt_user_desc').val();
    var start = $('#txt_start_date').val();
    var expire = $('#txt_expired_date').val();

    if(transferid.length > 0 && uemail.length > 0 && ro.length > 0 && cluster.length > 0 && province.length > 0 && department.length > 0 && start.length > 0){
        $('#btn_save_transfer').hide();
        $('#btn_save_load').show();
    
        $.ajax({
            url: "json_default.aspx?qrs=transferDUID",
            cache: false,
            type: "post",
            timeout: 60000,
            data: {  
                update_by: $('#hide_uemail').val(),
                transferid: transferid,
                uemail: uemail,
                ro: ro,
                cluster: cluster,
                province: province,
                department: department,
                user_desc: user_desc,
                start: start,
                expire: expire
            },
            success: function( res_duid ) {
                console.log("res_duid = [" + res_duid + "]");

                if(res_duid > 0) {
                    reSyncJas(uemail, res_duid, ro);
                }
                else {
                    modalAlert('saveTransferDuid ไม่สำเร็จ');
                }
            },
            error: function(x, t, m) {
                ajaxError();
            }
        });
    }
    else {
        modalAlert("กรุณากรอกข้อมูลให้ครบถ้วน!!");
    }
}

function reSyncJas(uemail, duid, ro){
    var url = "json_default.aspx?qrs=reSyncJas";

    if($('#hide_token').val().length > 0) {
        $.ajax({
            url: url,
            type: "post",
            timeout: 60000,
            cache: false,
            data: { 
                token: $('#hide_token').val(),
                uemail: uemail
            },
            success: function( res ) {
                if(res > 0){
                    window.location.replace("verify_approval.aspx?ro=RO" + ro + "&duid=" + duid);
                }
                else
                    modalAlert('reSyncJas ไม่สำเร็จ');
            },
            error: function(x, t, m) {
                ajaxError()
            }
        });
    }
    else {
        modalAlert('กรุณา Log in เข้าสู่ระบบ');
    }
}

function reLoadPage(){
    location.reload();
}