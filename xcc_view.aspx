<%@ Page Language="VB" AutoEventWireup="false" CodeFile="xcc_view.aspx.vb" Inherits="xcc_view" ValidateRequest="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

    <title>Easy View</title>

	<link rel="shortcut icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">
	<link rel="icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">

    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-147978262-1"></script>
    <script type="text/javascript" src="App_Inc/_js/gtag_frq.js?id=UA-147978262-1&vs=37"></script>
    
    <link type="text/css" rel="stylesheet" href="App_Inc/_css/reset.css" />
    <link rel="stylesheet" href="./App_Inc/_css/boostrap-4.0.0-beta.2/bootstrap.min.css" />

    <script src="App_Inc/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="App_Inc/_js/panu.js?v=38"></script>

    <!--[if IE]>
      <link rel="stylesheet" href="./App_Inc/_css/bootstrap-ie9.css" />
      <![endif]-->
    <!--[if lt IE 9]>
	  <link rel="stylesheet" href="./App_Inc/_css/bootstrap-ie8.css" />
      <![endif]-->
      <style>
      @font-face{
        font-family: 'TH Sarabun New';
        src: url('App_Inc/Font/THSarabunNew.ttf');
        font-weight: normal;
        font-style: normal;
    }
    body {
        font-family:'TH Sarabun New';
        font-size: 25px;
        padding: 20px;
        font-weight: bolder;
        background: #EEE;
    }
    .form-group {
        margin-top: 0px;
        margin-bottom: 0px;
    }
    table {
        border-collapse: collapse;
    }
    .border-left-card-primary{
        margin-top: 1.25rem !important;
        margin-bottom: 1.25rem !important;
        border-left-width: 0.40rem !important;
        border-radius: .25rem !important;
        border-left-color: #0275d8 !important;
    }
    .border-left-card-dark{
        margin-top: 1.25rem !important;
        margin-bottom: 1.25rem !important;
        border-left-width: 0.40rem !important;
        border-radius: .25rem !important;
        border-left-color: #12354A !important;
    }
    .badge {
        font-size: 80%;
    }
    .badge-dark {
        background-color: #12354A;
    }
    .badge-status {
        color: #fff;
        background-color: #FF9800;
    }
    .card-outline-dark{
       border-color: #12354A;
   }
   .card-outline-primary{
       border-color: #0275d8;
   }
   .table .thead-followtest th{
       color: #fff;
       background-color: #12354A;
       font-weight:normal;            
   }
   .table .thead-followtest td{
       color: #fff;
       background-color: #FFF;
       font-weight:normal;            
   }
   .table td{
       padding: 0px 0px 0px 8px;
   }
   .table-striped tbody tr:nth-of-type(even) {
       background-color: #FFF;
   }
   .test td{

   }
   </style>


</head>
<body>
    <form id="form1" runat="server">
        <div id="Grid">
            <table style="width: 100%;">
                <thead>
                   <tr>
                    <th style="width:255px;text-align: left;vertical-align:bottom;">คำขอเลขที่:
                        <span id="inn_request_id" runat="server" class="badge badge-dark"></span>
                    </th>
                    <th style="text-align: left;vertical-align:bottom;">สถานะล่าสุด:
                        <span id="inn_status_name" runat="server" class="badge badge-status"></span>
                    </th>
                </tr>
            </thead>
        </table>

        <div class="card card-outline-dark text-dark border-left-card-dark">
            <div class="card-body">

               <table style="width: 100%;">
                   <tbody>
                       <tr>
                        <td style="width:230px;font-weight: bold;text-decoration: underline;">รายละเอียดคำขอ</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;">เรื่อง:</td>
                        <td><span runat="server" id="inn_request_title"></span></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;">สาเหตุที่ต้องการลดหนี้:</td>
                        <td><span runat="server" id="inn_redebt_cause" xd="inn_redebt_cause"></span></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;vertical-align: top;">หมายเหตุเพิ่มเติม:</td>
                        <td style="vertical-align: top;text-align: left;"><span runat="server" id="inn_request_remark"></span></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;">Account:</td>
                        <td><span runat="server" id="inn_account_number"></span></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;">ชื่อลูกค้า:</td>
                        <td><span runat="server" id="inn_account_name"></span></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;">จำนวนที่ต้องการลดหนี้:</td>
                        <td><span runat="server" id="inn_amount"></span></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;vertical-align: top;">รูปแบบการคืนเงิน:</td>
                        <td>
                            <span runat="server" id="inn_pick_refund_title1"></span>
                            <br>
                            <span runat="server" id="inn_pick_refund_title2"></span>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;">เลขที่ใบเสร็จ POS:</td>
                        <td><span runat="server" id="inn_doc_number"></span></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;">เลขที่ใบเสร็จ BCS:</td>
                        <td><span runat="server" id="inn_bcs_number"></span></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;">วันที่มีผลยกเลิกบริการ:</td>
                        <td><span runat="server" id="inn_dx02"></span></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;">วันที่ลูกค้าขอลดหนี้:</td>
                        <td><span runat="server" id="inn_dx03"></span></td>
                    </tr>
                    <tr>
                        <td style="width:230px;font-weight: bold;">วันที่สร้างคำขอ:</td>
                        <td><span runat="server" id="inn_create_date"></span></td>
                    </tr>
                </tbody>    
            </table>
            
        </div>
    </div>
    
    <div class="card card-outline-dark text-dark border-left-card-dark">
        <div class="card-body">

           <table style="width: 100%;">
               <tbody>
                   <tr>
                    <td style="width:230px;font-weight: bold;text-decoration: underline;">ข้อมูลการลดหนี้</td>
                    <td>
                        <button type="button" class="btn btn-sm btn-primary" onclick="modalPopLink()" style="font-size:18px;">คำอธิบายวันที่ E-Payment</button>
                    </td>
                </tr>
                <tr>
                    <td style="width:230px;font-weight: bold;">เลขที่ใบลดหนี้:</td>
                    <td><span runat="server" id="inn_redebt_number"></span></td>
                </tr>
                <tr>
                    <td style="width:230px;font-weight: bold;">เลขที่ E-Pay:</td>
                    <td><span runat="server" id="inn_rp_no"></span></td>
                </tr>
                <tr>
                    <td style="width:230px;font-weight: bold;">วันที่สร้าง E-Pay:</td>
                    <td><span runat="server" id="inn_rp_date"></span></td>
                </tr>
                <tr>
                    <td style="width:230px;font-weight: bold;">วันที่อนุมัติ E-Pay:</td>
                    <td><span runat="server" id="inn_prove_date"></span></td>
                </tr>
                <tr>
                    <td style="width:230px;font-weight: bold;">วันที่ทำรายการจ่ายเงิน:</td>
                    <td><span runat="server" id="inn_pay_date"></span></td>
                </tr>
                <tr>
                    <td style="width:230px;font-weight: bold;">วันที่ลูกค้าได้รับเงิน:</td>
                    <td><span runat="server" id="inn_due_date"></span><span runat="server" id="inn_due_date2"></span></td>
                </tr>
            </tbody>    
        </table>

    </div>
</div>

<div class="bs-component">
    <table cellspacing="0" id="table_flow" style="width: 100%;border: 1px solid black;" class="table table-striped table-hover table-bordered">
        <thead class="thead-followtest">
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
    <tbody runat="server" id="inn_flow">
    </tbody>
</table>
</div>  


</div>
</form>

<script type="text/javascript">
$(document).ready(function() { 
    $('#inn_amount').html( convertAmount( $('#inn_amount').html() ) + " บาท" );
});

function modalPopLink() {
    var w = 850;
    var h = 350;
    var top = 100;
    var left = (screen.width/2)-(w/2);
    window.open("info_epay.aspx", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, width=" + w + ", height=" + h + ", top=" + top + ", left=" + left );
}
</script>
</body>
</html>
