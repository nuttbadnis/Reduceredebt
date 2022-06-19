Imports System.IO
Imports System.Net
Imports System.Data
Imports System.Net.Mail

Partial Class submit_run_mail
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow
    Dim DB105 As New Cls_Data105

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.QueryString("submit_go") = 99 Then
            Dim vSql As String = ""
            vSql += "select r.request_id, r.create_date, r.create_by "
            vSql += ",r.update_date, r.update_by, r.uemail_cc1, r.uemail_cc2, r.uemail_verify1 "
            vSql += ",subject_url "
            vSql += ",'http://posbcs.triplet.co.th/FollowRequest/update_' + subject_url + '.aspx?request_id=' + r.request_id herf_url "
            vSql += "from request r "
            vSql += "left join request_title_dim rt "
            vSql += "on rt.request_title_id = r.request_title_id "
            vSql += "left join subject_dim s "
            vSql += "on s.subject_id = rt.subject_id "
            vSql += "where r.create_date > '2019-01-28 00:00' and r.create_date < '2019-01-28 14:53' "
            vSql += "and request_id <> 'A1019010101' "
            vSql += "order by r.create_date "

            ' Response.Write("submit_go")

            Dim vDT As New DataTable
            vDT = DB105.GetDataTable(vSql)

            If vDT.Rows().Count() > 0 Then

                For i As Integer = 0 To vDT.Rows().Count() - 1
                    Dim vRequest_id As String = vDT.Rows(i).Item("request_id")
                    Dim vCreate_by As String = vDT.Rows(i).Item("create_by")
                    Dim vCC As String = vDT.Rows(i).Item("uemail_verify1")
                    Dim vCreate_date As String = vDT.Rows(i).Item("create_date")
                    Dim herf_url As String = vDT.Rows(i).Item("herf_url")

                    Response.Write("i = " & i & "<br>")
                    Response.Write("vRequest_id = " + vRequest_id + "<br>")
                    Response.Write("vCreate_by = " + vCreate_by + "<br>")
                    Response.Write("vCC = " + vCC + "<br>")
                    Response.Write("vCreate_date = " + vCreate_date + "<br>")
                    Response.Write("herf_url = " + herf_url + "<br>")
                    Response.Write("<hr>")
                    SendMailSubmit(vRequest_id, vCreate_by, vCC, vCreate_date, herf_url)
                Next

            End If
        Else
            Response.Write("submit_??")
        End If
    End Sub



    Public Sub SendMailSubmit(ByVal vRequest_id As String, ByVal vCreate_by As String, ByVal vCC As String, ByVal vCreate_date As String, ByVal herf_url As String)

            ' Dim vSplit_uemail As String() = Regex.Split(vSend_uemail, ";")
            ' Dim vSplit_uemail_cc As String() = Regex.Split(vSend_uemail_cc, ";")

            Dim mail As New MailMessage()
            mail.From = New MailAddress("FollowRequestError@jasmine.com")

            ' For Each sMail As String In vSplit_uemail
            '     If sMail.Trim() <> "" Then
            '         mail.To.Add(sMail + "@jasmine.com")
            '     End If
            ' Next

            ' For Each sMail_cc As String In vSplit_uemail_cc
            '     If sMail_cc.Trim() <> "" Then
            '         mail.CC.Add(sMail_cc + "@jasmine.com")
            '     End If
            ' Next

            mail.To.Add(vCreate_by + "@jasmine.com")
            mail.CC.Add(vCC + "@jasmine.com")
            mail.CC.Add("panupong.pa@jasmine.com")

            mail.Subject = "แจ้งการอัพโหลดไฟล์มีปัญหา (Follow Request)"

            mail.Body = rMailBody(vRequest_id, vCreate_by, vCreate_date, herf_url)

            mail.IsBodyHtml = True

            Dim smtp As New SmtpClient("smtp.jasmine.com")
            smtp.Credentials = New NetworkCredential("chancharas.w", "311227")

            smtp.Send(mail)

        ' Catch ex As Exception
        ' End Try
    End Sub

    Public Function rMailBody(ByVal vRequest_id As String, ByVal vCreate_by As String, ByVal vCreate_date As String, ByVal herf_url As String) As String
        Dim main_desc As String = "<p>เลขที่คำขอ: " + vRequest_id + "</p>"
        main_desc += "<p>ผู้สร้างคำขอ: " + vCreate_by + "</p>"
        main_desc += "<p>เมื่อเวลา: " + vCreate_date + "</p>"
        
        ' Dim vMain_Point As String = "<p>เนื่องจากในช่วงเวลาประมาณ 01:00น. - 14:52น. ของวันที่ 28/01/2562 ส่วนการอัพโหลดไฟล์มีปัญหา </p>"
        ' vMain_Point += "<p>ซึ่งส่งผลให้คำขอที่สร้างในช่วงเวลาดังกล่าว ไฟล์ที่อัพโหลดจะไม่บันทึกเข้าระบบ</p>"
        ' vMain_Point += "<p>จึงอยากให้ตรวจสอบอีกครั้ง ว่าคำขอที่ท่านสร้างนั้น ข้อมูลครบสมบูรณ์หรือไม่</p>"
        ' vMain_Point += "<p>ขออภัยในความไม่สะดวกครับ</p>"

        Dim vMain_Point As String = "<p>เรียนทุกท่าน </p>"
        vMain_Point += "<p>เรื่อง กรุณาตรวจสอบ ไฟล์แนบ ในคำขอที่สร้างใหม่ในวันที่ 28/01/2562 ก่อนเวลา 15:00 น.</p>"
        vMain_Point += "<p>เนื่องจาก มีการตรวจสอบพบปัญหาระบบ ไม่สามารถบันทึกไฟล์ที่ upload แนบคำขอในช่วงเวลาดังกล่าวได้</p>"
        vMain_Point += "<p>หากตรวจสอบแล้ว พบว่าเป็นคำขอ ที่มีการแนบไฟล์ แต่ไฟล์แนบไม่สามารถเรียกดูได้ รบกวนทำการแนบไฟล์ใหม่อีกครั้ง</p>"
        vMain_Point += "<p>จึงเรียนมาเพื่อโปรดตรวจสอบ และขออภัยในความไม่สะดวก</p>"

        return _
        "<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>" + _
        "<html lang='th'>" + _
        "<head>" + _
        "  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>" + _
        "  <meta name='viewport' content='width=device-width, initial-scale=1'>" + _
        "  <meta http-equiv='X-UA-Compatible' content='IE=edge'>" + _
        "  <meta name='format-detection' content='telephone=no'>" + _
        "</head>" + _
        "<body style='margin:0; padding:0;' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>" + _
        "  <table border='0' width='100%' height='100%' cellpadding='0' cellspacing='0'>" + _
        "    <tr>" + _
        "      <td align='center' valign='top'>" + _
        "        <br>" + _
        "        <table border='0' width='700' cellpadding='0' cellspacing='0' class='container' style='width:700px;max-width:700px;margin-top:-20px;'>" + _
        "         <tr>" + _
        "          <td class='container-padding content' align='left' style='padding:12px;background-color:#ffffff'>" + _
        "            <div class='title' style='font-family:tahoma;font-size:16px;color:red;font-weight:bold;'>" + vMain_Point + "</div>" + _
        "            <div class='body-text' style='font-family:tahoma;font-size:16px;line-height:12px;text-align:left;color:#333333'>" + _
        main_desc + _
        "              <br/>" + _
        "              <p><center><span style='font-family:tahoma;font-size: 13px;font-weight: bold;'>โปรดตรวจสอบและดำเนินการ</span></center></p>" + _
        "              <br/>" + _
        "              <center><a style='font-family:tahoma;font-size:35px;font-weight: bold;' href='" + herf_url + "'>Click link for more details</a></center>" + _
        "              <br/><center><span style='font-family:tahoma;font-size:13px;font-weight: bold;'>โปรดใช้โปรแกรมเปิดเว็บ Google Chrome หรือ Firefox เท่านั้น</span></center><br/>" + _
        "            </div>" + _
        "          </td>" + _
        "        </tr>" + _
        "        <tr>" + _
        "          <td class='container-padding footer-text' align='left' style='font-family:Helvetica, Arial, sans-serif;font-size: 12px;line-height:16px;color:#666;padding-left:12px;padding-right:12px'>" + _
        "            <span style='font-family:tahoma;font-size:11px;'>หากมีปัญหาการใช้งานโปรดติดต่อ:</span> support_pos@jasmine.com" + _
        "            <br><br><br><br>" + _
        "          </td>" + _
        "        </tr>" + _
        "      </table>" + _
        "    </td>" + _
        "  </tr>" + _
        "</table>" + _
        "</body>" + _
        "</html>"
    End Function
End Class
