<%@ Page Language="VB" AutoEventWireup="false" CodeFile="openprint_invdocpdf.aspx.vb" Inherits="openprint_invdocpdf" ValidateRequest="false"%>

<!DOCTYPE html>
<meta charset='utf-8'>
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="content-type" content="application/html; charset=UTF-8"/>
<head runat="server">
    <title>Print PDF</title>

	<link rel="shortcut icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">
	<link rel="icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">

    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-147978262-1"></script>
    <script type="text/javascript" src="App_Inc/_js/gtag_frq.js?id=UA-147978262-1&vs=37"></script>

    <script src="App_Inc/jquery-1.11.3.min.js"></script>

    <link rel="stylesheet" type="text/css" href="App_Inc/jquery-ui-1.11.4/jquery-ui.css"/>
	<script type="text/javascript" src="App_Inc/jquery-ui-1.11.4/jquery-ui.js"></script>

    <link rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap.css" />
	<script src="App_Inc/bootstrap/js/bootstrap.js"></script>

    <link rel="stylesheet" href="App_Inc/followstyle.css" />

    <script type="text/javascript" src="https://docraptor.com/docraptor-1.0.0.js"></script>

    <script type="text/javascript" src="App_Inc/_js/panu.js?v=38"></script>
    <script type="text/javascript" src="App_Inc/_js/load_modal.js?v=38"></script>
</head>
<body onload="printpdf()" style="font-family:'TH Sarabun New';">
<style>
    .form-group {
        margin-top: 0px;
        margin-bottom: 0px;
    }
    table {
        border-collapse: collapse;
    }
    .table{
        margin: auto;
        width: 98%;
    }
</style>
<form id="form1" runat="server">
    <input runat="server" id="hide_request_id" xd="hide_request_id" type="hidden">
    <input runat="server" id="hide_category_id" xd="hide_category_id" type="hidden">
    <input runat="server" id="hide_request_title" xd="hide_request_title" type="hidden">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_uemail_create" xd="hide_uemail_create" type="hidden">
	<input runat="server" id="hide_redebt_cause" xd="hide_redebt_cause" type="hidden">
	<input runat="server" id="hide_redebt_number" xd="hide_redebt_number" type="hidden">
	<input runat="server" id="hide_hide_redebt_file" xd="hide_hide_redebt_file" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden">
        <input runat="server" id="hide_doc_number" xd="hide_doc_number" type="hidden">  <!-- << invdoc_form by panu -->
    <input runat="server" id="hide_ref_number" xd="hide_ref_number" type="hidden">  <!-- << invdoc_form by panu -->
    <input runat="server" id="hide_request_remark" xd="hide_request_remark" type="hidden">  <!-- << invdoc_form by panu -->
    <div class="col-md-12">
        <span class="pull-right" style="font-weight:bold;font-size:16px;">(เอกสารเป็นชุด)</div>
    </div>
    <br/>
    <div class="col-md-6">
        <img src="App_Inc/_img/3BB_Cut.jpg" style="width: 35%;"/>
    </div>
    <div class="col-md-6">
        <img src="App_Inc/_img/3BB_Address_Cut.jpg" style="width: 80%; float:right;"/>
    </div>
    <div id="Grid">
        <table style="width: 100%;font-family:'TH Sarabun New';font-size: 16px;">
			<tr>
			    <th style="font-size: 16px;"><span runat="server" id="inn_customer_idcard" class="col-sm-12 control-label left-label"></span></th>
                <th></th>
			</tr>
            <tr>
			    <th style="font-size: 16px;"><span runat="server" id="inn_branch" class="col-sm-12 control-label left-label"></span></th>
                <th></th>
			</tr>
        </table>
        <table style="width: 100%;font-family:'TH Sarabun New';font-size: 16px; text-align:center;">
            <tr>
		        <th style="font-size: 20px;text-align:center;"><span runat="server" id="inn_receipt_nameTH" class="col-sm-12"></span></th>
			</tr>
            <tr>
		        <th style="font-size: 20px;text-align:center;"><span runat="server" id="inn_receipt_nameEN" class="col-sm-12"></span></th>
			</tr>
        </table>
        <table style="width: 100%;font-family:'TH Sarabun New';font-size: 16px;">
            <tr>
		        <th style="font-size: 16px;width: 19%;"><span runat="server" id="inn_running_number" class="col-sm-12"></span></th>
		        <th style="font-size: 16px;width: 58%;"><span runat="server" id="txt_running_number" class="col-sm-12"></span></th>
                <th style="font-size: 16px;width: 23%;"></th>
			</tr>
            <tr>
		        <th style="font-size: 16px;"></th>
		        <th style="font-size: 16px;"></th>
                <th style="font-size: 16px;"><span runat="server" id="inn_receipt_date" class="col-sm-12"></span></th>
			</tr>
            <tr>
		        <th style="font-size: 16px;"><span runat="server" id="inn_customer_name" class="col-sm-12"></span></th>
		        <th style="font-size: 16px;"><span runat="server" id="txt_customer_name" class="col-sm-12"></span></th>
                <th style="font-size: 16px;"></th>
			</tr>
            <tr>
		        <th style="font-size: 16px;"><span runat="server" id="inn_address_name" class="col-sm-12"></span></th>
		        <th style="font-size: 16px;"><span runat="server" id="txt_address_name" class="col-sm-12"></span></th>
                <th style="font-size: 16px;"></th>
			</tr>
            <tr>
		        <th style="font-size: 16px;"><span runat="server" id="inn_customer_taxid" class="col-sm-12"></span></th>
		        <th style="font-size: 16px;"><span runat="server" id="txt_customer_taxid" class="col-sm-12"></span></th>
                <th style="font-size: 16px;"></th>
			</tr>
            <tr>
		        <th style="font-size: 16px;"><span runat="server" id="inn_subbranch" class="col-sm-12"></span></th>
		        <th style="font-size: 16px;"></th>
                <th style="font-size: 16px;"></th>
			</tr>
        </table>
        <div id="table_item">กำลังโหลด..<br><br></div>
        <table cellspacing="0" class="table table-striped table-bordered" style="width: 98%;font-family:'TH Sarabun New';font-size: 15px;">
            <tbody id="table_exfooter" runat="server"></tbody>
        </table>
    </div>
        <table cellspacing="0" class="table table-striped table-bordered" style="width: 98%;font-family:'TH Sarabun New';font-size: 16px;">
            <tr>
                <th colspan='3' style='border-bottom: 1px solid black;'>&nbsp;</th>
            </tr>
            <tr>
                <th style="border-left: 1px solid black;border-bottom: 1px solid black;text-align: center;font-size: 16px;">
                    <br><div id="inn_create_sign" runat="server" style="display:unset;"></div>
                    <br><span id="inn_prepared" runat="server" style="border-top: 1.5px solid black;padding: 4px 15px 0px 15px;"></span>
                    <br><span id="inn_date_prepared" runat="server"></span>
                </th>
                <th style="border-bottom: 1px solid black;text-align: center;font-size: 16px;">
                    <br><div id="inn_received_sign" runat="server" style="display:unset;"></div>
                    <br><span id="inn_received" runat="server" style="border-top: 1.5px solid black;padding: 4px 15px 0px 15px;"></span>
                    <br><span id="inn_date_received" runat="server"></span></span>
                </th>
                <th style="border-right: 1px solid black;border-bottom: 1px solid black;text-align: center;font-size: 16px;">
                    <br><img src="App_Inc/_img/signature_approve.png" style="width: 100px;height: 50px;padding-bottom: 10px;"/>
                    <br><span id="inn_approved" runat="server" style="border-top: 1.5px solid black;padding: 4px 15px 0px 15px;"></span>
                    <br><span id="inn_date_approved" runat="server"></span>
                </th>
            </tr>
        </table>
    <br/>
    <hr/>
    <div class="col-md-12">
        <span class="pull-right" style="font-weight:bold;font-size:16px;">(เอกสารเป็นชุด)</div>
    </div>
    <br/>
    <div class="col-md-6">
        <img src="App_Inc/_img/3BB_Cut.jpg" style="width: 35%;"/>
    </div>
    <div class="col-md-6">
        <img src="App_Inc/_img/3BB_Address_Cut.jpg" style="width: 80%; float:right;"/>
    </div>  
    <div id="NewGrid">
        <table style="width: 100%;font-family:'TH Sarabun New';font-size: 16px;">
			<tr>
			    <th style="font-size: 16px;"><span runat="server" id="inncp_customer_idcard" class="col-sm-12 control-label left-label"></span></th>
                <th></th>
			</tr>
            <tr>
			    <th style="font-size: 16px;"><span runat="server" id="inncp_branch" class="col-sm-12 control-label left-label"></span></th>
                <th></th>
			</tr>
        </table>
        <table style="width: 100%;font-family:'TH Sarabun New';font-size: 16px; text-align:center;">
            <tr>
		        <th style="font-size: 20px;text-align:center;"><span runat="server" id="inncp_receipt_nameTH" class="col-sm-12"></span></th>
			</tr>
            <tr>
		        <th style="font-size: 20px;text-align:center;"><span runat="server" id="inncp_receipt_nameEN" class="col-sm-12"></span></th>
			</tr>
        </table>
        <table style="width: 100%;font-family:'TH Sarabun New';font-size: 16px;">
            <tr>
		        <th style="font-size: 16px;width: 19%;"><span runat="server" id="inncp_running_number" class="col-sm-12"></span></th>
		        <th style="font-size: 16px;width: 58%;"><span runat="server" id="txtcp_running_number" class="col-sm-12"></span></th>
                <th style="font-size: 16px;width: 23%;"></th>
			</tr>
            <tr>
		        <th style="font-size: 16px;"></th>
		        <th style="font-size: 16px;"></th>
                <th style="font-size: 16px;"><span runat="server" id="inncp_receipt_date" class="col-sm-12"></span></th>
			</tr>
            <tr>
		        <th style="font-size: 16px;"><span runat="server" id="inncp_customer_name" class="col-sm-12"></span></th>
		        <th style="font-size: 16px;"><span runat="server" id="txtcp_customer_name" class="col-sm-12"></span></th>
                <th style="font-size: 16px;"></th>
			</tr>
            <tr>
		        <th style="font-size: 16px;"><span runat="server" id="inncp_address_name" class="col-sm-12"></span></th>
		        <th style="font-size: 16px;"><span runat="server" id="txtcp_address_name" class="col-sm-12"></span></th>
                <th style="font-size: 16px;"></th>
			</tr>
            <tr>
		        <th style="font-size: 16px;"><span runat="server" id="inncp_customer_taxid" class="col-sm-12"></span></th>
		        <th style="font-size: 16px;"><span runat="server" id="txtcp_customer_taxid" class="col-sm-12"></span></th>
                <th style="font-size: 16px;"></th>
			</tr>
            <tr>
		        <th style="font-size: 16px;"><span runat="server" id="inncp_subbranch" class="col-sm-12"></span></th>
		        <th style="font-size: 16px;"></th>
                <th style="font-size: 16px;"></th>
			</tr>
        </table>
        <div id="tablecp_item">กำลังโหลด..<br><br></div>
        <table cellspacing="0" class="table table-striped table-bordered" style="width: 98%;font-family:'TH Sarabun New';font-size: 15px;">
            <tbody id="tablecp_exfooter" runat="server"></tbody>
        </table>
    </div>
        <table cellspacing="0" class="table table-striped table-bordered" style="width: 98%;font-family:'TH Sarabun New';font-size: 16px;">
            <tr>
                <th colspan='3' style='border-bottom: 1px solid black;'>&nbsp;</th>
            </tr>
            <tr>
                <th style="border-left: 1px solid black;border-bottom: 1px solid black;text-align: center;font-size: 16px;">
                    <br><div id="inncp_create_sign" runat="server" style="display:unset;"></div>
                    <br><span id="inncp_prepared" runat="server" style="border-top: 1.5px solid black;padding: 4px 15px 0px 15px;"></span>
                    <br><span id="inncp_date_prepared" runat="server"></span>
                </th>
                <th style="border-bottom: 1px solid black;text-align: center;font-size: 16px;">
                    <br><div id="inncp_received_sign" runat="server" style="display:unset;"></div>
                    <br><span id="inncp_received" runat="server" style="border-top: 1.5px solid black;padding: 4px 15px 0px 15px;"></span>
                    <br><span id="inncp_date_received" runat="server"></span></span>
                </th>
                <th style="border-right: 1px solid black;border-bottom: 1px solid black;text-align: center;font-size: 16px;">
                    <br><img src="App_Inc/_img/signature_approve.png" style="width: 100px;height: 50px;padding-bottom: 10px;"/>
                    <br><span id="inncp_approved" runat="server" style="border-top: 1.5px solid black;padding: 4px 15px 0px 15px;"></span>
                    <br><span id="inncp_date_approved" runat="server"></span>
                </th>
            </tr>
        </table>       
    <!-- invdoc_form by panu { -->
    <script type="text/javascript" src="App_Inc/_js/thai-baht-text.js"></script>
    <script type="text/javascript" src="App_Inc/_js/invdoc_form_tam.js?v=48"></script>
    <!-- invdoc_form by panu } -->

    <script type="text/javascript">
    
        //convertThaiDate("15/02/2021");
        function printpdf() {
            $("span[id^='inn_']").text(function(i, oldText) {
                // console.log(oldText);
                return oldText.replace("/*", "/");
            });

            $("[id*=btnExport]").click(function () {
                $("[id*=hfGridHtml]").val($("#Grid").html());
                $("[id*=hfNewGridHtml]").val($("#NewGrid").html());
            });
        }
        $('#inn_receipt_date').html("วันที่/Date : "+convertThaiDate($("#inn_receipt_date").html()));
        $('#inncp_receipt_date').html("วันที่/Date : "+convertThaiDate($("#inncp_receipt_date").html()));
        $('#inn_date_prepared').html("วันที่/Date : "+convertThaiDate($("#inn_date_prepared").html()));
        $('#inn_date_received').html("วันที่/Date : "+convertThaiDate($("#inn_date_received").html()));
        $('#inn_date_approved').html("วันที่/Date : "+convertThaiDate($("#inn_date_approved").html()));
        $('#inncp_date_prepared').html("วันที่/Date : "+convertThaiDate($("#inncp_date_prepared").html()));
        $('#inncp_date_received').html("วันที่/Date : "+convertThaiDate($("#inncp_date_received").html()));
        $('#inncp_date_approved').html("วันที่/Date : "+convertThaiDate($("#inncp_date_approved").html()));

     </script>

      <asp:HiddenField ID="hfGridHtml" runat="server" />
      <asp:HiddenField ID="hfNewGridHtml" runat="server" />
      
      <div class="col-md-12" style="margin-top:1%;margin-bottom:4%;">
        <asp:Button ID="btnExport" cssclass="btn btn-primary pull-right" runat="server" Text="Download PDF" OnClick="ExportToPDF" />
       </div>
     <input id="pdf-button" type="button" value="Download PDF" onclick="downloadPDF()" style="display:none;"/>

    </form>

    <div id="modal_alert" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">แจ้งเตือน</h4>
                </div>
                <div class="modal-body">
                    <p id="txt_alert">ข้อความ</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">ปิด</button>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>
