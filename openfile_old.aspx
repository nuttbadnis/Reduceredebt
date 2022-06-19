<%@ Page Language="VB" AutoEventWireup="false" CodeFile="openfile_old.aspx.vb" Inherits="openfile_old" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Open Old File</title>

  <link rel="shortcut icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">
  <link rel="icon" href="App_Inc/_img/FBLUE.ico" type="image/x-icon">

    <script src="App_Inc/jquery-1.11.3.min.js"></script>

    <link rel="stylesheet" type="text/css" href="App_Inc/jquery-ui-1.11.4/jquery-ui.css"/>
    <script type="text/javascript" src="App_Inc/jquery-ui-1.11.4/jquery-ui.js"></script>

    <link rel="stylesheet" href="App_Inc/bootstrap/css/bootstrap.css" />
    <script src="App_Inc/bootstrap/js/bootstrap.js"></script>

    <style type="text/css">
    @import url('https://fonts.googleapis.com/css?family=Kanit:400,600');

    body {
      font-family: 'kanit', sans-serif;
    }
    img.center {
        display: block;
        margin: 0 auto;
        margin-top: 40px;
        cursor: pointer;
    }
    h2, p {
        text-align: center;
    }
    h2 {
        display: block;
        font-size: 24px;
        margin-block-start: 0.83em;
        margin-block-end: 0.83em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
        font-weight: bold;
    }
    p {
        font-size: 16px;
        padding: 8px;
    }
    .ored {
        color: #ff3d00;
    }
    .button {
      display: inline-block;
      color: #FFFFFF;
      background-color: #f4511e;
      border: none;
      border-radius: 4px;
      font-size: 18px;
      font-family: 'kanit', sans-serif;
      text-align: center;
      padding: 15px;
      margin: 5px;
      width: auto;
      cursor: pointer;
  }
    </style>
</head>
<body style="background-color: #fcfcfc;">
    <h2>ไฟล์ที่ต้องการเข้าถึง มีอายุมากกว่า 10 เดือน</h2>

    <form id="form1" runat="server">
            <p id="p_path" runat="server">
                <b>กรุณาแจ้งขอไฟล์</b> 
                <span id="span_path" class="ored" runat="server"></span> 
                <b>ได้ที่อีเมล์</b> 
                <a onclick="copyPath()" href="mailto:support_pos@jasmine.com?subject=Follow Request ขอไฟล์เก่าเกิน 10 เดือน (File Backup)">support_pos@jasmine.com</a>
            </span> 
        </p>
    </form>

    <p>
        <input type="text" value="Hello World" id="copy_path" style="position: absolute; top: -100px;">
        <button class="button" onclick="copyPath()">คลิกเพื่อ Copy ชื่อไฟล์</button>
    </p>

    <div style="display: flex;justify-content: center;align-items: center;">
      <span style=" text-align: center;
      border: 2px solid #ff784e;
      padding: 10px 15px;
      border-radius: 3px;
      background-color: #fff2ed;
      font-size: 15px;">
        เนื่องจาก ในเดือน มิ.ย. 64 พบทาง RO03 มีการขอเอกสารลูกค้าย้อนหลังที่เกิน 10 เดือนเข้ามาเป็นจำนวนมาก 
        <br>
        และ เมื่อตรวจสอบกับทางบัญชีส่วนกลาง และ ผู้เกี่ยวข้องแล้ว พบว่าดูจะเป็นการไม่เหมาะสม
        <br>
        <br>

        ทางระบบ และ Support 2727 จึงขอระงับการให้ข้อมูลดังกล่าว และ รอตรวจสอบกับทางนโยบาย ว่าจะให้ดำเนินการอย่างไร ระหว่างนี้ 
        <br>
        ของดการให้บริการเรียกดูข้อมูลย้อนหลังที่เกิน 10 เดือนจากทาง RO03 ครับ
      </span>
    </div>

    <p>
        <span id="span_error" class="ored" runat="server"></span> 
    </p>

    <img src="App_Inc/_img/search_file.png" height="300" class="center" onclick="copyPath()">

    <div id="modal_ex" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-nm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">
                        Copy ชื่อไฟล์แล้ว
                    </h4>
                </div>
                <div class="modal-body">
                    <span>*ตัวอย่างการแจ้งขอไฟล์ <b>ส่งไปที่อีเมล์ทีม POS : <a href="mailto:support_pos@jasmine.com?subject=Follow Request ขอไฟล์เก่าเกิน 10 เดือน (File Backup)">support_pos@jasmine.com</a></b></span>
                    <br>
                    <br>
                    <img src="App_Inc/_img/ex_mail_old_file.png" width="570" style="border-radius: 3px;border: 1px solid #2196F3;">
                    <br>
                    <br>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">

    window.onload = function() {
       document.getElementById("copy_path").value = document.getElementById('span_path').innerHTML;

       setTimeout( function() {
        copyPath();
       }, 5000);
   };

   function copyPath() {
      var copyText = document.getElementById("copy_path");

      copyText.select();

      document.execCommand("copy");

      // alert("Copy ชื่อไฟล์แล้ว: " + copyText.value);
        $('#modal_ex').modal("show");
  }
    </script>
</body>
</html>
