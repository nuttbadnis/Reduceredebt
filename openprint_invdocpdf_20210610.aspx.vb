Imports System.IO
Imports System.Data
Imports System.Text
Imports System.Globalization
Imports Microsoft.VisualBasic
Imports iTextSharp.text
Imports iTextSharp.text.html.simpleparser
Imports iTextSharp.text.pdf
Imports iTextSharp.tool.xml
Imports iTextSharp.text.pdf.parser
'Imports iTextSharp.text.font

Partial Class openprint_invdocpdf
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
            '// Check Font exist.
            'If My.Computer.FileSystem.FileExists(Environment.GetEnvironmentVariable("windir") & "\Fonts\angsana.ttc") Then
               'response.write("Font already exist."+Server.MapPath("~/App_Inc/Font/THSarabunNew.ttf"))
            'Else
               'response.write("Font not found."+Environment.GetEnvironmentVariable("windir") & "\Fonts\THSarabunNew.ttf")
            'End If
            Dim xRequest_id = Session("print_request_id") 
            Dim xCategory_id = Request.QueryString("pdf")
            Dim xPreview_id = Request.QueryString("preview")

            If xPreview_id = 1 Then
                btnExport.Style.Add("display", "none")
            End If
            'Session.Remove("print_request_id")
                loadDetail(xRequest_id, xCategory_id)
                hide_category_id.Value() = xCategory_id
                hide_request_id.Value() = xRequest_id
                'hide_token.Value() = Session("token")
                'hide_uemail.Value() = Session("Uemail")
                'showemail.Text = Session("Uemail")
                'datetime.Text = Now
            End If
        End If
    End Sub

    Sub loadDetail(ByVal vRequest_id As String,ByVal vCategory_id As String)
        
        Dim vSql As String = "select * from request where request_id = '" + vRequest_id + "'"

        Dim vDT,vDT2,vDT3,vDT4 As New DataTable

        vDT = CF.rSqlLoadDetailProjectE(vRequest_id)
        vDT2 = DB105.GetDataTable(vSql)

        If (vDT.Rows().Count() > 0) Then
            Me.Page.Title = "#" + vRequest_id + " [" + Me.Page.Title + "]"

            '''''''''''''''''''''''''''''''''''''''''''''''' Data ''''''''''''''''''''''''''''''''''''''''''''''''

            Dim receipt_nameTH as String
            Dim receipt_nameEN As String
            Dim receiptcopy_nameTH As String
            Dim receiptcopy_nameEN As String
            Dim receipt_footer as String
            Dim prepared_sign as String = "ผู้จัดทำ / Prepared"
            Dim reciecved_sign as String 
            Dim approved_sign as String = "ผู้อนุมัติ/ Approved"
            Dim prepared_date as String = vDT.Rows(0).Item("dx01")
            Dim reciecved_date as String 
            Dim approved_date as String = vDT.Rows(0).Item("dx01")
            Dim payment_value as String = vDT.Rows(0).Item("nx01")
            Dim payment_cheque as String = vDT.Rows(0).Item("nx01")

            If vCategory_id = 1 Then
                receipt_nameTH = "ต้นฉบับใบแจ้งหนี้/ใบกำกับภาษี/ใบส่งของ"
                receipt_nameEN = "TAX INVOICE/DELIVERY ORDER (ORIGINAL)"
                receiptcopy_nameTH = "สำเนาใบแจ้งหนี้/ใบกำกับภาษี/ใบส่งของ"
                receiptcopy_nameEN = "TAX INVOICE/DERIVERY ORDER (COPY)"
                receipt_footer = "<tr>"
                receipt_footer += "<th valign='top' style='width:12%;text-align: left;font-size: 16px;'>"
                receipt_footer += " ชำระโดย"
                receipt_footer += "</th>"
                receipt_footer += "<th valign='top' style='width:20%;text-align: left;font-size: 16px;'>"
                If payment_value = 10 Then
                    receipt_footer += "[ / ] &nbsp;เงินสด"
                    receipt_footer += "</th>"
                    receipt_footer += "<th valign='top' style='text-align: left;font-size: 16px;'>"
                    receipt_footer += "[ ] &nbsp;เช็คธนาคาร &nbsp;_________________________________________________ "
                    receipt_footer += "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;เลขที่เช็ค &nbsp;&nbsp;&nbsp;&nbsp;_________________________________________________ "
                Else If payment_value = 20 Then
                    receipt_footer += "[ / ] &nbsp;เงินโอน"
                    receipt_footer += "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ลว." + vDT.Rows(0).Item("dx04")
                    receipt_footer += "</th>"
                    receipt_footer += "<th valign='top' style='text-align: left;font-size: 16px;'>"
                    receipt_footer += "[ ] &nbsp;เช็คธนาคาร &nbsp;_________________________________________________ "
                    receipt_footer += "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;เลขที่เช็ค &nbsp;&nbsp;&nbsp;&nbsp;_________________________________________________ "
                Else If payment_value = 30 Then
                    receipt_footer += "[ / ] &nbsp;OFFSET"
                    receipt_footer += "</th>"
                    receipt_footer += "<th valign='top' style='text-align: left;font-size: 16px;'>"
                    receipt_footer += "[ ] &nbsp;เช็คธนาคาร &nbsp;_________________________________________________ "
                    receipt_footer += "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;เลขที่เช็ค &nbsp;&nbsp;&nbsp;&nbsp;_________________________________________________ "
                Else If payment_value = 40 Then
                    receipt_footer += "[ ] &nbsp;เงินสด"
                    receipt_footer += "</th>"
                    receipt_footer += "<th valign='top' style='text-align: left;font-size: 16px;'>"
                    receipt_footer += "[ / ] &nbsp;เช็คธนาคาร &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ vDT.Rows(0).Item("tx03") + " สาขา " + vDT.Rows(0).Item("ax02") 
                    receipt_footer += "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;เลขที่เช็ค &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+vDT.Rows(0).Item("fx02")+" ลว." + vDT.Rows(0).Item("dx04")
                End If

                receipt_footer += "</th>"
                receipt_footer += "</tr>"
                reciecved_sign = "ผู้รับสินค้า / Received by"
                reciecved_date = vDT.Rows(0).Item("dx01")
            
            Else
                receipt_nameTH = "ต้นฉบับใบเสร็จรับเงิน"
                receipt_nameEN = "RECEIPT (ORIGINAL)"
                receiptcopy_nameTH = "สำเนาใบเสร็จรับเงิน"
                receiptcopy_nameEN = "RECEIPT (COPY)"
                receipt_footer = "<tr>"
                receipt_footer += "<th>"
                receipt_footer += "</th>"
                receipt_footer += "</tr>"
                reciecved_sign = "ผู้รับเงิน / Receiver"
                reciecved_date = vDT.Rows(0).Item("dx03")
            End If

            Dim running_number_label as string = "เลขที่"
            Dim running_number_value as string = vDT.Rows(0).Item("invdoc_runid")
            
            inn_customer_idcard.InnerHtml = "เลขประจำตัวผู้เสียภาษี 0107550000149"'+vDT.Rows(0).Item("ax01")
            inn_branch.InnerHtml = "( "+vDT.Rows(0).Item("mx02")+" )"
            inn_receipt_nameTH.InnerHtml = receipt_nameTH
            inn_receipt_nameEN.InnerHtml = receipt_nameEN
            inn_running_number.InnerHtml = running_number_label
            txt_running_number.InnerHtml = running_number_value
            inn_receipt_date.InnerHtml = vDT.Rows(0).Item("dx01") 'วันที่ออกใบแจ้งหนี้
            inn_customer_name.InnerHtml = "ชื่อลูกค้า/Customer Name : "
            txt_customer_name.InnerHtml = vDT.Rows(0).Item("mx01")
            inn_address_name.InnerHtml = "ที่อยู่/Address : "
            txt_address_name.InnerHtml = vDT.Rows(0).Item("tx01")
            inn_customer_taxid.InnerHtml = "เลขประจำตัวผู้เสียภาษีอากร : "
            txt_customer_taxid.InnerHtml = vDT.Rows(0).Item("ax01")
            inn_subbranch.InnerHtml = "( "+vDT.Rows(0).Item("mx02")+" )"

            inn_prepared.InnerHtml = prepared_sign
            inn_date_prepared.InnerHtml = prepared_date
            inn_received.InnerHtml = reciecved_sign
            inn_date_received.InnerHtml = reciecved_date
            inn_approved.InnerHtml = approved_sign
            inn_date_approved.InnerHtml = approved_date

            inncp_customer_idcard.InnerHtml = "เลขประจำตัวผู้เสียภาษี 0107550000149"'+vDT.Rows(0).Item("ax01")
            inncp_branch.InnerHtml = "( "+vDT.Rows(0).Item("mx02")+" )"
            inncp_receipt_nameTH.InnerHtml = receiptcopy_nameTH 
            inncp_receipt_nameEN.InnerHtml = receiptcopy_nameEN
            inncp_running_number.InnerHtml = running_number_label
            txtcp_running_number.InnerHtml = running_number_value
            inncp_receipt_date.InnerHtml = vDT.Rows(0).Item("dx01") 'วันที่ออกใบแจ้งหนี้
            inncp_customer_name.InnerHtml = "ชื่อลูกค้า/Customer Name : "
            txtcp_customer_name.InnerHtml = vDT.Rows(0).Item("mx01")
            inncp_address_name.InnerHtml = "ที่อยู่/Address : "
            txtcp_address_name.InnerHtml = vDT.Rows(0).Item("tx01")
            inncp_customer_taxid.InnerHtml = "เลขประจำตัวผู้เสียภาษีอากร : "
            txtcp_customer_taxid.InnerHtml = vDT.Rows(0).Item("ax01")
            inncp_subbranch.InnerHtml = "( "+vDT.Rows(0).Item("mx02")+" )"

            inncp_prepared.InnerHtml = prepared_sign
            inncp_date_prepared.InnerHtml = prepared_date
            inncp_received.InnerHtml = reciecved_sign
            inncp_date_received.InnerHtml = reciecved_date
            inncp_approved.InnerHtml = approved_sign
            inncp_date_approved.InnerHtml = approved_date

            hide_doc_number.Value() = vDT.Rows(0).Item("doc_number")
            hide_ref_number.Value() = vDT.Rows(0).Item("doc_number")'vDT.Rows(0).Item("invdoc_ref")
            hide_request_remark.Value() = vDT.Rows(0).Item("request_remark")

            'table_footer.innerhtml = Footer_Doc.ToString
            table_exfooter.innerhtml = receipt_footer.ToString
            'tablecp_footer.innerhtml = Footer_Doc.ToString
            tablecp_exfooter.innerhtml = receipt_footer.ToString

            Dim uemail_cc as string = ""
            If vDT.Rows(0).Item("uemail_cc1") <> Nothing
                uemail_cc += vDT.Rows(0).Item("uemail_cc1")
            End If
            If vDT.Rows(0).Item("uemail_cc2") <> Nothing
                uemail_cc += ","+vDT.Rows(0).Item("uemail_cc2")
            End If

            'count_print.Text = vDT2.Rows().Count()
        Else
            ClientScript.RegisterStartupScript(Page.GetType, "", "alert(""No Request!!""); window.location = 'default.aspx';", True)
        End If
    End Sub

    Protected Sub ExportToPDF(sender As Object, e As EventArgs)
        Dim arial As BaseFont = BaseFont.CreateFont("C:/Windows/Fonts/THSarabunNew.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED)
        'Dim arial As BaseFont = FontFactory.getFont("arial", BaseFont.IDENTITY_H, BaseFont.EMBEDDED)
        Response.ContentType = "application/pdf"
        Response.AddHeader("content-disposition", "attachment;filename=FollowReq-" + hide_request_id.Value + "-" + Today + ".pdf")
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        'Dim arial As BaseFont = BaseFont.CreateFont(Environment.GetEnvironmentVariable("windir") & "\Fonts\angsana.ttc", BaseFont.Cp1252, BaseFont.EMBEDDED)
        'Dim tahoma As BaseFont = BaseFont.CreateFont("C:\WINDOWS\Fonts\upcjl.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED)
        'Dim arial As BaseFont = FontFactory.register("C:\WINDOWS\Fonts\THSarabunNew.ttf")
        'Dim Font = FontFactory.GetFont("AngsanaNew", 12)
        Dim table As New PdfPTable(3)
        table.WidthPercentage = 98
        table.HorizontalAlignment = 0
        Dim cell_top As New PdfPCell(new Phrase("  "))
		cell_top.Colspan = 3
		cell_top.HorizontalAlignment = 1
        cell_top.BorderWidthBottom = 0
		table.AddCell(cell_top)

        Dim path_sign_approve As String = Server.MapPath(".") + "/App_Inc/_img/signature_approve.png"
        Dim path_sign_prepare_1 As String = Server.MapPath(".") + "/App_Inc/_img/signature_prepare_1.png"
        Dim path_sign_prepare_2 As String = Server.MapPath(".") + "/App_Inc/_img/signature_prepare_2.png"

        Dim img_sign_approve As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(path_sign_approve)
        Dim img_sign_prepare_1 As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(path_sign_prepare_1)
        Dim img_sign_prepare_2 As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(path_sign_prepare_2)
        Dim Para As new Paragraph("Student code:")

        img_sign_approve.ScaleAbsolute(60.0F, 20.0F)
        img_sign_prepare_1.ScaleAbsolute(60.0F, 25.0F)
        img_sign_prepare_2.ScaleAbsolute(60.0F, 25.0F)

        Dim cell_col1_row1 As New PdfPCell(img_sign_approve)
        cell_col1_row1.HorizontalAlignment = 1
        cell_col1_row1.VerticalAlignment = 2
        cell_col1_row1.BorderWidthTop = 0
        cell_col1_row1.BorderWidthBottom = 0
        cell_col1_row1.BorderWidthRight = 0
        cell_col1_row1.PaddingBottom = 0f
        'table.addCell("a cell")
        table.AddCell(cell_col1_row1)
        'table.addCell("a cell")

        Dim cell_col1_row2 As New PdfPCell(img_sign_prepare_1)
        cell_col1_row2.HorizontalAlignment = 1
        cell_col1_row2.VerticalAlignment = 2
        cell_col1_row2.Border = 0
        cell_col1_row2.PaddingBottom = 0f
        'cell_col1_row2.setFixedHeight = 2f
        table.AddCell(cell_col1_row2)
        
        Dim cell_col1_row3 As New PdfPCell(img_sign_prepare_2)
        cell_col1_row3.HorizontalAlignment = 1
        cell_col1_row3.VerticalAlignment = 2
        cell_col1_row3.BorderWidthtop = 0
        cell_col1_row3.BorderWidthBottom = 0
        cell_col1_row3.BorderWidthLeft = 0
        'cell_col1_row3.Paddingtop = 2f
        cell_col1_row3.PaddingBottom = 0f
        'cell_col1_row3.setFixedHeight = 2f
        table.AddCell(cell_col1_row3)


        'p.add(underline)
        Dim cell_col2_row1 As New PdfPCell(new Phrase("_______________"))
        cell_col2_row1.setleading(1f, 0f)
        cell_col2_row1.VerticalAlignment = 0
        cell_col2_row1.HorizontalAlignment = 1
        cell_col2_row1.BorderWidthtop = 0
        cell_col2_row1.BorderWidthBottom = 0
        cell_col2_row1.PaddingTop = 0.0F
        cell_col2_row1.PaddingBottom = 0.0F

        Dim cell_col2_row2 As New PdfPCell(new Phrase("_______________"))
        cell_col2_row2.setleading(1f, 0f)
        cell_col2_row2.VerticalAlignment = 0
        cell_col2_row2.HorizontalAlignment = 1
        cell_col2_row2.BorderWidthtop = 0
        cell_col2_row2.BorderWidthBottom = 0
        cell_col2_row2.PaddingTop = 0.0F
        cell_col2_row2.PaddingBottom = 0.0F

        Dim cell_col2_row3 As New PdfPCell(new Phrase("_______________"))
        cell_col2_row3.setleading(1f, 0f)
        cell_col2_row3.VerticalAlignment = 0
        cell_col2_row3.HorizontalAlignment = 1
        cell_col2_row3.BorderWidthtop = 0
        cell_col2_row3.BorderWidthBottom = 0
        cell_col2_row3.PaddingTop = 0.0F
        cell_col2_row3.PaddingBottom = 0.0F
        
        table.AddCell(cell_col2_row1)
        table.AddCell(cell_col2_row2)
        table.AddCell(cell_col2_row3)
        
        'Dim Font As New Font(arial, 12,Font.Bold)
        Dim Font As New Font(arial, 12)
        Dim sign_prepared as New Paragraph(inn_prepared.innerhtml,Font)
        Dim sign_received as New Paragraph(inn_received.innerhtml,Font)
        Dim sign_approved as New Paragraph(inn_approved.innerhtml,Font)
        Dim sign_date_prepared as New Paragraph("วันที่/Date : "+ConvertThai_Date(inn_date_prepared.innerhtml),Font)
        Dim sign_date_received as New Paragraph("วันที่/Date : "+ConvertThai_Date(inn_date_received.innerhtml),Font)
        Dim sign_date_approved as New Paragraph("วันที่/Date : "+ConvertThai_Date(inn_date_approved.innerhtml),Font)

        Dim cell_col3_row1 As New PdfPCell(new Phrase(sign_prepared))
        cell_col3_row1.HorizontalAlignment = 1
        cell_col3_row1.BorderWidthRight = 0
        cell_col3_row1.BorderWidthtop = 0
        cell_col3_row1.BorderWidthBottom = 0
        Dim cell_col3_row2 As New PdfPCell(new Phrase(sign_received))
        cell_col3_row2.HorizontalAlignment = 1
        cell_col3_row2.BorderWidth = 0
        Dim cell_col3_row3 As New PdfPCell(new Phrase(sign_approved))
        cell_col3_row3.HorizontalAlignment = 1
        cell_col3_row3.BorderWidthLeft = 0
        cell_col3_row3.BorderWidthtop = 0
        cell_col3_row3.BorderWidthBottom = 0

        Dim cell_col4_row1 As New PdfPCell(new Phrase(sign_date_prepared))
        cell_col4_row1.HorizontalAlignment = 1
        cell_col4_row1.VerticalAlignment = 0
        cell_col4_row1.BorderWidthRight = 0
        cell_col4_row1.BorderWidthtop = 0
        cell_col4_row1.BorderWidthBottom = 0
        Dim cell_col4_row2 As New PdfPCell(new Phrase(sign_date_received))
        cell_col4_row2.HorizontalAlignment = 1
        cell_col4_row2.VerticalAlignment = 0
        cell_col4_row2.BorderWidth = 0
        Dim cell_col4_row3 As New PdfPCell(new Phrase(sign_date_approved))
        cell_col4_row3.HorizontalAlignment = 1
        cell_col4_row3.VerticalAlignment = 0
        cell_col4_row3.BorderWidthLeft = 0
        cell_col4_row3.BorderWidthtop = 0
        cell_col4_row3.BorderWidthBottom = 0

		table.AddCell(cell_col3_row1)
		table.AddCell(cell_col3_row2)
		table.AddCell(cell_col3_row3)

		table.AddCell(cell_col4_row1)
		table.AddCell(cell_col4_row2)
		table.AddCell(cell_col4_row3)
        
        Dim cell_bottom As New PdfPCell(new Phrase("  "))
		cell_bottom.Colspan = 3
		cell_bottom.HorizontalAlignment = 1
        cell_bottom.BorderWidthTop = 0
		table.AddCell(cell_bottom)

        'Dim xxx As String = "aaa"
        Dim text_heading As String = "(เอกสารเป็นชุด)"
        Dim imageFile As String = Server.MapPath(".") + "/App_Inc/_img/3BB.jpg"
        Dim image_Address As String = Server.MapPath(".") + "/App_Inc/_img/3BB_Address_Cut.jpg"
        Dim sr As New StringReader(Replace(Request.Form(hfGridHtml.UniqueID), "<br>", "<br/>"))
        Dim pdfDoc As New Document(PageSize.A4, 20.0F, 10.0F, 100.0F, 0.0F)
        Dim writer As PdfWriter = PdfWriter.GetInstance(pdfDoc, Response.OutputStream)
        pdfDoc.Open()
        'pdfDoc.Add(text_heading)

        '-----Set Text Header Position-----'
        Dim cb As PdfContentByte = writer.DirectContent
        cb.BeginText()
        cb.SetFontAndSize(arial, 12)
        cb.SetTextMatrix(520, 820)
        cb.ShowText(text_heading)
        cb.EndText()
        '-----Set Text Header Position-----'

        ' pdfDoc.Add(newp)
        ' Dim cb As PdfContentByte = writer.DirectContent
        ' cb.SetFontAndSize(Font,14)
        Dim myImage As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(imageFile)
        myImage.ScaleToFit(100.0F, 500.0F)
        myImage.SetAbsolutePosition(20, 750)
        pdfDoc.Add(myImage)
        Dim address_image As iTextSharp.text.Image = iTextSharp.text.Image.GetInstance(image_Address)
       ' Dim w_img as int = getScaledHeight(address_image)
        address_image.ScaleToFit(300.0F, 800.0F)
        address_image.SetAbsolutePosition(270, 750)
        pdfDoc.Add(address_image)
        XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr)
        pdfDoc.Add(new Phrase("   "))
        pdfDoc.Add(table)
        pdfDoc.NewPage()
        cb.BeginText()
        cb.SetFontAndSize(arial, 12)
        cb.SetTextMatrix(520, 820)
        cb.ShowText(text_heading)
        cb.EndText()
        pdfDoc.Add(myImage)
        pdfDoc.Add(address_image)
        Dim sr_1 As New StringReader(Replace(Request.Form(hfNewGridHtml.UniqueID), "<br>", "<br/>"))
        ' Dim pdfDoc As New Document(PageSize.A4, 20.0F, 20.0F, 100.0F, 0.0F)
        ' Dim writer As PdfWriter = PdfWriter.GetInstance(pdfDoc, Response.OutputStream)
        XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr_1)
        pdfDoc.Add(new Phrase("   "))
        pdfDoc.Add(table)
        pdfDoc.Close()
        Response.Write(pdfDoc)
        Response.End()

    End Sub
    Private Shared Sub FixText(ByVal text As String, ByVal x As Integer, ByVal y As Integer, ByVal writer As PdfWriter, ByVal size As Integer)
        Try
            Dim cb As PdfContentByte = writer.DirectContent
            Dim bf As BaseFont = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED)
            cb.SaveState()
            cb.BeginText()
            cb.MoveText(x, y)
            cb.SetFontAndSize(bf, size)
            cb.ShowText(text)
            cb.EndText()
            cb.RestoreState()
        Catch __unusedDocumentException1__ As DocumentException

        End Try
    End Sub

    Function ConvertThai_Date(ByVal date_value As String)
        Dim monthNames() As String = {"มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม"}
        Dim dateArr() As String
        Dim day_value As string
        Dim month_value As Integer
        Dim year_value As Integer

        If date_value <> "" Then
            dateArr = date_value.Split("/")
            day_value = dateArr(0)
            month_value = dateArr(1)
            year_value = dateArr(2)+543
            date_value = day_value +" "+monthNames(month_value - 1)+" "+year_value.ToString
        End If

        Return date_value    
    End Function
End Class

