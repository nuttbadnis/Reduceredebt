<%@ Page Language="VB" AutoEventWireup="false" CodeFile="openprint_pdf.aspx.vb" Inherits="openprint_pdf" ValidateRequest="false"%>

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
<body onload="printpdf()">
<style>
    .form-group {
        margin-top: 0px;
        margin-bottom: 0px;
    }
    table {
    border-collapse: collapse;
    }
</style>
<form id="form1" runat="server">
    <input runat="server" id="hide_request_id" xd="hide_request_id" type="hidden">
	<input runat="server" id="hide_token" xd="hide_token" type="hidden">
	<input runat="server" id="hide_uemail" xd="hide_uemail" type="hidden">
	<input runat="server" id="hide_uemail_create" xd="hide_uemail_create" type="hidden">
	<input runat="server" id="hide_redebt_cause" xd="hide_redebt_cause" type="hidden">
	<input runat="server" id="hide_redebt_number" xd="hide_redebt_number" type="hidden">
	<input runat="server" id="hide_hide_redebt_file" xd="hide_hide_redebt_file" type="hidden">
	<input runat="server" id="hide_can_edit_approval" xd="hide_can_edit_approval" type="hidden">

<div class="modal" id="aaa">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">Save changes</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<img src="App_Inc/_img/3BB.jpg" style="width: 8%;margin-bottom: -4%;"/>
    <div id="Grid">
        <table style="width: 100%;font-family:'TH Sarabun New';font-size: 26px;">
            <thead>
			    <tr>
			        <th style="width: 25%;"></th>
                    <th style="text-align: left;vertical-align:bottom;">เอกสารยืนยันการอนุมัติ&nbsp;คำขอเลขที่: <span id="inn_request_id" runat="server"></span></th>
			    </tr>
	        </thead>
       </table>
        <table style="width: 100%;font-family:'TH Sarabun New';font-size: 26px;">
            <thead>
			    <tr>
			        <th style="text-decoration: underline;font-size: 24px;"><div>รายละเอียดคำขอ</div></th>
                    <th></th>
			    </tr>
	        </thead>
            <tbody>
                <tr>
                    <td style="width:25%;font-weight: bold;">Account:</td>
                    <td><span runat="server" id="inn_account_number" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;">ชื่อลูกค้า:</td>
                    <td><span runat="server" id="inn_account_name" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;">จำนวนที่ต้องการลดหนี้:</td>
                    <td><span runat="server" id="inn_amount" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;">เลขที่ใบเสร็จ POS:</td>
                    <td><span runat="server" id="inn_doc_number" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;">เลขที่ใบเสร็จ BCS:</td>
                    <td><span runat="server" id="inn_bcs_number" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;">เลขที่ใบลดหนี้:</td>
                    <td style="font-weight: bold;"><span runat="server" id="inn_redebt_number" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;">วันที่มีผลยกเลิกบริการ:</td>
                    <td><span runat="server" id="inn_dx02" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;vertical-align: top;">วิธีการคืนเงิน:</td>
                    <td><span runat="server" id="inn_pick_refund_title1" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;"></td>
                    <td><span runat="server" id="inn_pick_refund_title2" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;">วันที่ลูกค้าขอลดหนี้:</td>
                    <td><span runat="server" id="inn_dx03" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;">วันที่สร้างคำขอ:</td>
                    <td><span runat="server" id="inn_create_date" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                 <tr>
                    <td style="width:25%;font-weight: bold;">เรื่อง:</td>
                    <td><span runat="server" id="inn_request_title" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;">สาเหตุที่ต้องการลดหนี้:</td>
                    <td><span runat="server" id="inn_redebt_cause" xd="inn_redebt_cause" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                    <td style="width:25%;font-weight: bold;vertical-align: top;">หมายเหตุเพิ่มเติม:</td>
                    <td style="vertical-align: top;text-align: left;"><span runat="server" id="inn_request_remark" class="col-sm-10 control-label left-label"></span></td>
                </tr>
                <tr>
                </tr>
            </tbody>    
        </table>
        
					<table cellspacing="0" id="table_flow" style="width: 100%;font-family:'TH Sarabun New';font-size: 16px;border: 1px solid black;">
						<thead>
							<tr>
								<th style="border: 1px solid black;">#</th>
								<th style="border: 1px solid black;">Step</th>
								<th style="border: 1px solid black;">Next</th>
								<th style="border: 1px solid black;">ส่วนงาน</th>
								<th style="border: 1px solid black;">สถานะ</th>
								<th style="border: 1px solid black;">อัพเดทล่าสุด</th>
								<th style="border: 1px solid black;">โดย</th>
								<th style="border: 1px solid black;width: 40%;">หมายเหตุ</th>
							</tr>
						</thead>
						<tbody runat="server" id="inn_flow"></tbody>
					</table>
                <table style="width: 100%;font-family:'TH Sarabun New';font-size: 18px">
                    <thead>
                        <tr>
                            <th>พิมพ์โดย:&nbsp;<asp:Label ID="showemail" runat="server" ></asp:Label></th>
                            <th></th>
                        </tr>
			            <tr>
			                <th>วันที่พิมพ์:&nbsp;<asp:Label ID="datetime" runat="server" ></asp:Label></th>
                            <th></th>
			            </tr>
                        <tr>
                            <th>พิมพ์ครั้งที่:&nbsp;<asp:Label ID="count_print" runat="server" ></asp:Label></th>
                            <th></th>
                        </tr>
	                </thead>
               </table>
    </div>

    <script type="text/javascript">
        function printpdf() {
            $("span[id^='inn_']").text(function(i, oldText) {
                // console.log(oldText);
                return oldText.replace("/*", "/");
            });

            $("[id*=btnExport]").click(function () {
                $("[id*=hfGridHtml]").val($("#Grid").html());
            });
        }

        $('#inn_amount').html( convertAmount( $('#inn_amount').html() ) + " บาท" );
     </script>

      <asp:HiddenField ID="hfGridHtml" runat="server" />
      
      <div class="col-md-12" style="margin-bottom:4%;">
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
