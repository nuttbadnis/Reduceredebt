Imports System.IO
Imports System.Data
Imports Microsoft.VisualBasic
Imports iTextSharp.text
Imports iTextSharp.text.html.simpleparser
Imports iTextSharp.text.pdf
Imports iTextSharp.tool.xml

Partial Class openprint_ctshoppdf
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DBShopStock As New Cls_DataShopStock
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
        Dim vSql As String = "select * from request where request_id = '" + vRequest_id + "'"

        Dim vDT,vDT2,vDT3,vDT4 As New DataTable

        vDT = CF.rSqlLoadDetailProjectC(vRequest_id)
        vDT2 = DB105.GetDataTable(vSql)

        If (vDT.Rows().Count() > 0) Then
            Me.Page.Title = "#" + vRequest_id + " [" + Me.Page.Title + "]"
            inn_request_id.InnerHtml = vRequest_id

            '''''''''''''''''''''''''''''''''''''''''''''''' Data ''''''''''''''''''''''''''''''''''''''''''''''''
            ' Dim request_file1 As String = "-"
            ' Dim request_file2 As String = "-"
            ' Dim request_file3 As String = "-"

            ' If vDT.Rows(0).Item("request_file1").Trim() <> "" Then
            '     request_file1 = CF.rLinkOpenfile(vDT.Rows(0).Item("path_file1"), vDT.Rows(0).Item("request_file1"))
            ' End If
            ' If vDT.Rows(0).Item("request_file2").Trim() <> "" Then
            '     request_file2 = CF.rLinkOpenfile(vDT.Rows(0).Item("path_file2"), vDT.Rows(0).Item("request_file2"))
            ' End If
            ' If vDT.Rows(0).Item("request_file3").Trim() <> "" Then
            '     request_file3 = CF.rLinkOpenfile(vDT.Rows(0).Item("path_file3"), vDT.Rows(0).Item("request_file3"))
            ' End If

            ' Dim uemail_cc As String = ""
            ' If vDT.Rows(0).Item("uemail_cc1").Trim().Length > 0 Then
            '     uemail_cc += vDT.Rows(0).Item("uemail_cc1") + "@jasmine.com"
            ' End If
            ' If vDT.Rows(0).Item("uemail_cc2").Trim().Length > 0 Then
            '     If uemail_cc.Length > 0 Then uemail_cc += ", "
            '     uemail_cc += vDT.Rows(0).Item("uemail_cc2") + "@jasmine.com"
            ' End If

            ' vSql = CF.rSqlDDRO()

            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            inn_subject_name.InnerHtml = vDT.Rows(0).Item("subject_name")
            inn_province.InnerHtml = vDT.Rows(0).Item("shop_code")
            inn_cluster.InnerHtml = vDT.Rows(0).Item("fx02")

            inn_area_ro.InnerHtml = vDT.Rows(0).Item("area_ro")
            inn_shop_code.InnerHtml = vDT.Rows(0).Item("fx01")

            vSql = CF.rSqlDDstorePlaceType()
            vDT4 = DBShopStock.GetDataTable(vSql)
            If vDT4.Rows().Count() > 0 Then
                for i as integer = 0 to vDT4.Rows().Count()-1
                    if vDT.Rows(0).Item("sx01") = vDT4.Rows(i).Item("storeplacetype_id") Then             
                        inn_storeplace_type.InnerHtml = vDT4.Rows(i).Item("storeplacetype_name")
                    End if
                Next
              
            End If
            
            inn_txtar_location.InnerHtml = vDT.Rows(0).Item("tx01")

            vSql = CF.rSqlDDcontractPhase()
            vDT3 = DBShopStock.GetDataTable(vSql)
            Dim phase_title as string = ""
            If vDT3.Rows().Count() > 0 Then
                for i as integer = 0 to vDT3.Rows().Count()-1
                    if vDT.Rows(0).Item("fx03") = vDT3.Rows(i).Item("phase_id") Then             
                        phase_title = vDT3.Rows(i).Item("phase_title")
                    End if
                Next
              
            End If

            If vDT.Rows(0).Item("fx03") = "99999"
               inn_phase_title.InnerHtml = phase_title+"( "+vDT.Rows(0).Item("mx02")+" )"
            Else
               inn_phase_title.InnerHtml = phase_title
            End if
            inn_uprent_rate.InnerHtml = vDT.Rows(0).Item("ax04")+" %"
            inn_ax07.InnerHtml = vDT.Rows(0).Item("ax07")+" บาท/เดือน (รวม VAT)" 

            inn_create_by.InnerHtml = vDT.Rows(0).Item("create_by")

            Dim uemail_cc as string = ""
            If vDT.Rows(0).Item("uemail_cc1") <> Nothing
                uemail_cc += vDT.Rows(0).Item("uemail_cc1")
            End If
            If vDT.Rows(0).Item("uemail_cc2") <> Nothing
                uemail_cc += ","+vDT.Rows(0).Item("uemail_cc2")
            End If
            inn_uemail_cc.InnerHtml = uemail_cc
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
        Dim arial As BaseFont = BaseFont.CreateFont("c:\windows\fonts\THSarabunNew.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED)
        Dim Font = New Font(arial, 16)
        Dim imageFile As String = Server.MapPath(".") + "/App_Inc/_img/3BB.jpg"
        Dim sr As New StringReader(Request.Form(hfGridHtml.UniqueID))
        Dim pdfDoc As New Document(PageSize.A4, 20.0F, 20.0F, 20.0F, 0.0F)
        Dim writer As PdfWriter = PdfWriter.GetInstance(pdfDoc, Response.OutputStream)
        pdfDoc.Open()
        Dim myImage As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(imageFile)
        myImage.ScaleToFit(100.0F, 500.0F)
        myImage.SetAbsolutePosition(20, 755)
        pdfDoc.Add(myImage)
        XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr)
        pdfDoc.Close()

        Response.Write(pdfDoc)
        Response.End()
    End Sub

End Class

