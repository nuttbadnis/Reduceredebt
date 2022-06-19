Imports System.IO
Imports System.Data
Imports Microsoft.VisualBasic
Imports iTextSharp.text
Imports iTextSharp.text.html.simpleparser
Imports iTextSharp.text.pdf
Imports iTextSharp.tool.xml

Partial Class openprint_pdf
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.checkLogin()

        If Not Page.IsPostBack Then
            If Session("print_request_id") Is Nothing Then
                ClientScript.RegisterStartupScript(Page.GetType, "", "alert(""ไม่สามารถแสดงข้อมูลได้ กรุณากลับไปกดปุ่ม Print ใหม่""); window.location = 'default.aspx';", True)
            Else
                Dim xRequest_id = Session("print_request_id")
                Session.Remove("print_request_id")

                loadDetail(xRequest_id)
                hide_request_id.Value() = xRequest_id
                hide_token.Value() = Session("token")
                hide_uemail.Value() = Session("Uemail")
                showemail.Text = Session("Uemail")
                datetime.Text = Now
            End If
        End If
    End Sub

    Sub loadDetail(ByVal vRequest_id As String)
        Dim vSql As String = "select * from log_request_print where request_id = '" + vRequest_id + "'"

        Dim vDT,vDT2 As New DataTable

        vDT = CF.rSqlLoadDetailRedebt(vRequest_id)
        vDT2 = DB105.GetDataTable(vSql)

        If (vDT.Rows().Count() > 0) Then
            Me.Page.Title = "#" + vRequest_id + " [" + Me.Page.Title + "]"

            hide_redebt_cause.Value() = vDT.Rows(0).Item("redebt_cause_id")
            inn_request_id.InnerHtml = vRequest_id

            '''''''''''''''''''''''''''''''''''''''''''''''' Load Title ''''''''''''''''''''''''''''''''''''''''''''''''
            vSql = CF.rSqlDDTitle(vDT.Rows(0).Item("subject_id"))
            '''''''''''''''''''''''''''''''''''''''''''''''' Load Title ''''''''''''''''''''''''''''''''''''''''''''''''

            '''''''''''''''''''''''''''''''''''''''''''''''' Data ''''''''''''''''''''''''''''''''''''''''''''''''
            Dim request_file1 As String = "-"
            Dim request_file2 As String = "-"
            Dim request_file3 As String = "-"

            If vDT.Rows(0).Item("request_file1").Trim() <> "" Then
                request_file1 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file1"), vDT.Rows(0).Item("request_file1"))
            End If
            If vDT.Rows(0).Item("request_file2").Trim() <> "" Then
                request_file2 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file2"), vDT.Rows(0).Item("request_file2"))
            End If
            If vDT.Rows(0).Item("request_file3").Trim() <> "" Then
                request_file3 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file3"), vDT.Rows(0).Item("request_file3"))
            End If

            Dim uemail_cc As String = ""
            If vDT.Rows(0).Item("uemail_cc1").Trim().Length > 0 Then
                uemail_cc += vDT.Rows(0).Item("uemail_cc1") + "@jasmine.com"
            End If
            If vDT.Rows(0).Item("uemail_cc2").Trim().Length > 0 Then
                If uemail_cc.Length > 0 Then uemail_cc += ", "
                uemail_cc += vDT.Rows(0).Item("uemail_cc2") + "@jasmine.com"
            End If

            vSql = CF.rSqlDDRO()

            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            inn_request_title.InnerHtml = vDT.Rows(0).Item("request_title")
            inn_request_remark.InnerHtml = vDT.Rows(0).Item("request_remark")
            inn_redebt_cause.InnerHtml = vDT.Rows(0).Item("redebt_cause_title")

            inn_account_number.InnerHtml = vDT.Rows(0).Item("account_number")
            inn_account_name.InnerHtml = vDT.Rows(0).Item("account_name")

            inn_doc_number.InnerHtml = vDT.Rows(0).Item("doc_number")
            inn_bcs_number.InnerHtml = vDT.Rows(0).Item("bcs_number")
            inn_amount.InnerHtml = vDT.Rows(0).Item("amount")

            inn_dx02.InnerHtml = vDT.Rows(0).Item("dx02") 'วันที่ยกเลิก
            inn_dx03.InnerHtml = vDT.Rows(0).Item("dx03") 'วันที่ลูกค้าขอลดหนี้

            inn_pick_refund_title1.InnerHtml = vDT.Rows(0).Item("pick_refund_title")

            Dim refund_title2 As String = ""
            
            If vDT.Rows(0).Item("pick_refund_type") = 1 Then
                refund_title2 += vDT.Rows(0).Item("tx01")
            
            Else If vDT.Rows(0).Item("pick_refund_type") = 2 Then
                refund_title2 += vDT.Rows(0).Item("account_number_to") & " / " & vDT.Rows(0).Item("account_name_to")
            
            Else If vDT.Rows(0).Item("pick_refund_type") = 3 Then
                refund_title2 += vDT.Rows(0).Item("account_number_to") & " / " & vDT.Rows(0).Item("account_name_to") + " / " + vDT.Rows(0).Item("tx01")
            
            Else If vDT.Rows(0).Item("pick_refund_type") = 0 Then
                If vDT.Rows(0).Item("tx01").Length > 0 Then
                    refund_title2 += vDT.Rows(0).Item("tx01")
                End If

                If vDT.Rows(0).Item("bank_title").Length > 0 Then
                    refund_title2 += " / " & vDT.Rows(0).Item("bank_title")
                End If

                If vDT.Rows(0).Item("fx01").Length > 0 Then
                    refund_title2 += " / รหัสสาขา " & vDT.Rows(0).Item("fx01")
                End If

                If vDT.Rows(0).Item("fx02").Length > 0 Then
                    refund_title2 += " / เลขที่บัญชี " & vDT.Rows(0).Item("fx02")
                End If

                If vDT.Rows(0).Item("mx03").Length > 0 Then
                    refund_title2 += " / ชื่อบัญชี " & vDT.Rows(0).Item("mx03")
                End If
            End If

            If refund_title2.Length > 0 Then
                inn_pick_refund_title2.InnerHtml = "(" + refund_title2 + ")"
            End If

            inn_create_date.InnerHtml = vDT.Rows(0).Item("create_date")
            inn_redebt_number.InnerHtml = vDT.Rows(0).Item("redebt_number")

            count_print.Text = vDT2.Rows().Count()

            loadFlow(vRequest_id, vDT.Rows(0).Item("request_status"), vDT.Rows(0).Item("request_step"))
        Else
            ClientScript.RegisterStartupScript(Page.GetType, "", "alert(""No Request!!""); window.location = 'default.aspx';", True)
        End If
    End Sub

    Sub loadFlow(ByVal vRequest_id As String, ByVal vRequest_status As String, ByVal vRequest_step As String)
        Dim vRequest_permiss As Integer = CF.rViewDetail(vRequest_id)

        If CF.rCheckCanEditAndIsRequestor(vRequest_id) = 1 Then
            hide_can_edit_approval.Value() = 1
        End If

        inn_flow.InnerHtml = CF.rLoadFlowBody_pdf(vRequest_id, vRequest_status, vRequest_step, vRequest_permiss)
    End Sub


    Protected Sub ExportToPDF(sender As Object, e As EventArgs)
        Response.ContentType = "application/pdf"
        Response.AddHeader("content-disposition", "attachment;filename=FollowReq-" + hide_request_id.Value + "-" + Today + ".pdf")
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        ' Dim arial As BaseFont = BaseFont.CreateFont("c:\windows\fonts\UPCDL.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED)
        Dim arial As BaseFont = BaseFont.CreateFont("c:\windows\fonts\THSarabunNew.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED)
        Dim Font = New Font(arial, 16)
        Dim imageFile As String = Server.MapPath(".") + "/App_Inc/_img/3BB.jpg"
        Dim sr As New StringReader(Request.Form(hfGridHtml.UniqueID))
        Dim pdfDoc As New Document(PageSize.A4, 10.0F, 10.0F, 10.0F, 0.0F)
        Dim writer As PdfWriter = PdfWriter.GetInstance(pdfDoc, Response.OutputStream)
        pdfDoc.Open()
        Dim myImage As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(imageFile)
        myImage.ScaleToFit(100.0F, 500.0F)
        myImage.SetAbsolutePosition(10, 765)
        pdfDoc.Add(myImage)
        XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr)
        pdfDoc.Close()

        Response.Write(pdfDoc)
        Response.End()
    End Sub

End Class

