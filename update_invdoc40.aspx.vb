Imports System.IO
Imports System.Data

Partial Class update_invdoc40
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Dim pageUrl As String = "update_invdoc40"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        hide_token.Value() = Session("token")
        hide_uemail.Value() = Session("Uemail")

        If Not Page.IsPostBack Then
            Dim xRequest_id = Request.QueryString("request_id")
            'CF.checkPage(xRequest_id, pageUrl)
            CF.checkRequestFlowBroken(xRequest_id)
            loadDetail(xRequest_id)
            checkRequestEnd(xRequest_id)
        End If
    
        CP.Analytics()
    End Sub

    Sub checkRequestEnd(ByVal vRequest_id As String) '<< by panu
        If CF.rGetRequestStatus(vRequest_id) <> 100 Then
            ' btn_print_pdf1.Visible = False
            ' btn_print_pdf1_hidden.Visible = False
            ' btn_print_pdf2_hidden.Visible = False
            btn_print_pdf2.Visible = False
            btn_modal_after_end.Visible = False
        End If
    End Sub

    Sub loadDetail(ByVal vRequest_id As String)
        Dim vDT As New DataTable
        vDT = CF.rSqlLoadDetailProjectE(vRequest_id)

        If(vDT.Rows().Count() > 0)
            Dim vSql As String
            
            Me.Page.Title = "#" + vRequest_id + " [" + Me.Page.Title + "]"

            hide_ref_number.Value() = vDT.Rows(0).Item("doc_number") '<< invdoc_form by panu
            project_name.InnerHtml = vDT.Rows(0).Item("project_name")
            subject_name.InnerHtml = vDT.Rows(0).Item("subject_prefix") + ". " + vDT.Rows(0).Item("subject_name")
            inn_request_id.InnerHtml = vRequest_id
            inn_status_name.InnerHtml = vDT.Rows(0).Item("status_name")

            '''''''''''''''''''''''''''''''''''''''''''''''' Load Title ''''''''''''''''''''''''''''''''''''''''''''''''
            vSql = CF.rSqlDDTitle(vDT.Rows(0).Item("subject_id"))
            DB105.SetDropDownList(sel_title, vSql, "request_title", "request_title_id", "เลือกหัวข้อ")
            sel_title.SelectedValue = vDT.Rows(0).Item("request_title_id")
            '''''''''''''''''''''''''''''''''''''''''''''''' Load Title ''''''''''''''''''''''''''''''''''''''''''''''''

            '''''''''''''''''''''''''''''''''''''''''''''''' Data ''''''''''''''''''''''''''''''''''''''''''''''''
            Dim request_file1 As String = "-"
            Dim request_file2 As String = "-"
            Dim request_file3 As String = "-"
            Dim request_file4 As String = "-"
            Dim request_file5 As String = "-"
            Dim request_file6 As String = "-"
            Dim request_file7 As String = "-"
            Dim request_file8 As String = "-"

            If vDT.Rows(0).Item("request_file1").Trim() <> "" Then
                request_file1 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file1"), vDT.Rows(0).Item("request_file1"))
            End If
            If vDT.Rows(0).Item("request_file2").Trim() <> "" Then
                request_file2 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file2"), vDT.Rows(0).Item("request_file2"))
            End If
            If vDT.Rows(0).Item("request_file3").Trim() <> "" Then
                request_file3 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file3"), vDT.Rows(0).Item("request_file3"))
            End If
            If vDT.Rows(0).Item("request_file4").Trim() <> "" Then
                request_file4 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file4"), vDT.Rows(0).Item("request_file4"))
            End If
            If vDT.Rows(0).Item("request_file5").Trim() <> "" Then
                request_file5 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file5"), vDT.Rows(0).Item("request_file5"))
            End If
            If vDT.Rows(0).Item("request_file6").Trim() <> "" Then
                request_file6 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file6"), vDT.Rows(0).Item("request_file6"))
            End If
            If vDT.Rows(0).Item("request_file7").Trim() <> "" Then
                request_file7 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file7"), vDT.Rows(0).Item("request_file7"))
            End If
            If vDT.Rows(0).Item("request_file8").Trim() <> "" Then
                request_file8 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file8"), vDT.Rows(0).Item("request_file8"))
            End If

            Dim uemail_cc As String = ""
            If vDT.Rows(0).Item("uemail_cc1").Trim().Length > 0 Then
                form_cc1.Style.Add("display", "block")
                uemail_cc += vDT.Rows(0).Item("uemail_cc1") + "@jasmine.com"
            End If
            If vDT.Rows(0).Item("uemail_cc2").Trim().Length > 0 Then
                If uemail_cc.Length > 0 Then uemail_cc += ", "
                form_cc2.Style.Add("display", "block")
                uemail_cc += vDT.Rows(0).Item("uemail_cc2") + "@jasmine.com"
            End If

            hide_subject_id.Value() = vDT.Rows(0).Item("subject_id")
            '''''''''''''''''''''''''''''''''''''''''''''''' Data ''''''''''''''''''''''''''''''''''''''''''''''''

            txt_request_title.Value() = vDT.Rows(0).Item("request_title")
            txt_request_remark.Value() = vDT.Rows(0).Item("request_remark") 'รายละเอียดการขาย

            txt_invdate.Value() = vDT.Rows(0).Item("dx01") 'วันที่ออกใบแจ้งหนี้
            txt_dx02.Value() = vDT.Rows(0).Item("dx02") 'ครบกำหนดชำระ

            txt_customer_name.Value() = vDT.Rows(0).Item("mx01") 'ชื่อลูกค้า/Customer Name
            txt_branch.Value() = vDT.Rows(0).Item("mx02") 'สำนักงานใหญ่/สาขา

            txtar_customer_address.Value() = vDT.Rows(0).Item("tx01") 'ที่อยู่/Address
            txt_tx02.Value() = vDT.Rows(0).Item("tx02") 'รายละเอียดการชำระเงิน
            txt_tx03.Value() = vDT.Rows(0).Item("tx03") 'อ้างอิง ใบสั่งซื้อ/สั่งจ้าง,ใบอนุมัติการขายเศษซาก ฯลฯ

            txt_customer_idcard.Value() =  vDT.Rows(0).Item("ax01") 'เลขประจำตัวผู้เสียภาษีอากร/เลขที่บัตรประจำตัวประชาชน

            current_request_file1.InnerHtml = request_file1
            current_request_file2.InnerHtml = request_file2
            current_request_file3.InnerHtml = request_file3
            current_request_file4.InnerHtml = request_file4
            current_request_file5.InnerHtml = request_file5
            current_request_file6.InnerHtml = request_file6
            current_request_file7.InnerHtml = request_file7
            current_request_file8.InnerHtml = request_file8

            vSql = CF.rSqlDDRO()
            DB105.SetDropDownList(sel_create_ro, vSql, "ro_title", "ro_value", "เลือก RO ผู้สร้างคำขอ")
            sel_create_ro.SelectedValue = vDT.Rows(0).Item("create_ro")
            txt_create_by.Value() = vDT.Rows(0).Item("create_by")
            txt_create_date.Value() = vDT.Rows(0).Item("create_date")

            txt_uemail_cc1.Value() = vDT.Rows(0).Item("uemail_cc1")
            txt_uemail_cc2.Value() = vDT.Rows(0).Item("uemail_cc2")

            txt_dx03.Value() = vDT.Rows(0).Item("dx03") 'วันที่รับเงิน
            txt_invref_no.Value() = vDT.Rows(0).Item("invdoc_ref")

            vSql = CF.rSqlDDInvidocPayment()
            DB105.SetDropDownList(sel_payment, vSql, "payment_title", "payment_id", "เลือกประเภทการชำระ")
            sel_payment.SelectedValue = vDT.Rows(0).Item("nx01") 'เลือกประเภทการชำระ

            vSql = CF.rSqlDDInvidocBanktitle()
            DB105.SetDropDownList(sel_bank_title, vSql, "real_title", "bank_code")
            sel_bank_title.Items.Insert(0, New ListItem("เลือกธนาคาร", "0"))
            sel_bank_title.SelectedValue = vDT.Rows(0).Item("nx02") 'ชื่อธนาคาร
            txt_bank_branch.Value() = vDT.Rows(0).Item("mx03") 'สาขาธนาคาร
            txt_bank_cheque.Value() = vDT.Rows(0).Item("fx01") 'เลขที่เช็ค
            txt_dx04.Value() = vDT.Rows(0).Item("dx04") 'วันที่ชำระเงิน

            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            inn_request_title.InnerHtml = vDT.Rows(0).Item("request_title")

            Dim inn_request_file1 as string = " ( "+request_file1+" ) "
            Dim inn_request_file2 as string = " ( "+request_file2+" ) "

            inn_request_remark.InnerHtml = vDT.Rows(0).Item("request_remark")+inn_request_file1 'รายละเอียดการขาย

            inn_invdate.InnerHtml = vDT.Rows(0).Item("dx01") 'วันที่ออกใบแจ้งหนี้
            inn_dx02.InnerHtml = vDT.Rows(0).Item("dx02") 'ครบกำหนดชำระ
            inn_dx03.InnerHtml = vDT.Rows(0).Item("dx03") 'วันที่รับเงิน

            inn_customer_name.InnerHtml = vDT.Rows(0).Item("mx01") 'ชื่อลูกค้า/Customer Name
            inn_branch.InnerHtml = vDT.Rows(0).Item("mx02") 'สำนักงานใหญ่/สาขา

            inn_customer_address.InnerHtml = vDT.Rows(0).Item("tx01") 'ที่อยู่/Address
            inn_tx02.InnerHtml = vDT.Rows(0).Item("tx02")+inn_request_file2 'รายละเอียดการชำระเงิน
            inn_tx03.InnerHtml = vDT.Rows(0).Item("tx03") 'อ้างอิง ใบสั่งซื้อ/สั่งจ้าง,ใบอนุมัติการขายเศษซาก ฯลฯ

            inn_customer_idcard.InnerHtml = vDT.Rows(0).Item("ax01") 'เลขประจำตัวผู้เสียภาษีอากร/เลขที่บัตรประจำตัวประชาชน

            Dim bank_name = vDT.Rows(0).Item("real_title")
            Dim bank_branchname = " สาขา "+vDT.Rows(0).Item("mx03")
            Dim bank_cheque = " เลขที่เช็ค "+vDT.Rows(0).Item("fx01")
            Dim bank_detail as string = bank_name  + " " + bank_branchname + " " + bank_cheque'ชื่อธนาคาร
            Dim payment_detail as string = ""

            If vDT.Rows(0).Item("nx01") = 20 or vDT.Rows(0).Item("nx01") = 30 Then
                payment_detail = "( ลว." + vDT.Rows(0).Item("dx04") + " )"         
            Else If vDT.Rows(0).Item("nx01") = 40 Then
                payment_detail = bank_detail + "( ลว." + vDT.Rows(0).Item("dx04") + " )" 
            End If

            inn_payment.InnerHtml = vDT.Rows(0).Item("payment_title").ToString + " " + payment_detail 'ประเภทการชำระเงิน

            inn_request_file3.InnerHtml = request_file3    
            inn_request_file4.InnerHtml = request_file4
            inn_request_file5.InnerHtml = request_file5
            inn_request_file6.InnerHtml = request_file6
            inn_request_file7.InnerHtml = request_file7
            inn_request_file8.InnerHtml = request_file8

            inn_create_ro.InnerHtml = "(RO" + vDT.Rows(0).Item("create_ro") + ")"
            inn_create_by.InnerHtml = vDT.Rows(0).Item("create_by") + "@jasmine.com"
            inn_create_date.InnerHtml = vDT.Rows(0).Item("create_date")
            inn_update.InnerHtml =  vDT.Rows(0).Item("update_date") & " <b>โดย</b> " & vDT.Rows(0).Item("update_by") + "@jasmine.com"

            inn_uemail_cc.InnerHtml = uemail_cc

            btnContactShop(vDT.Rows(0).Item("create_shop"))

            loadFlow(vRequest_id, vDT.Rows(0).Item("request_status"), vDT.Rows(0).Item("request_step"))
            loadInvDocRef(vRequest_id, vDT.Rows(0).Item("request_status"), vDT.Rows(0).Item("request_step"), vDT.Rows(0).Item("invdoc_update")) '<< invdoc_form by panu
            
            hide_can_edit_item.Value() = CF.checkCanEditItem(vRequest_id, vDT.Rows(0).Item("request_status"), vDT.Rows(0).Item("request_step"), vDT.Rows(0).Item("next_depart")) '<< invdoc_form by panu
        Else
            ClientScript.RegisterStartupScript(Page.GetType, "", "alert(""No Request!!""); window.location = 'default.aspx';", True)
        End If
    End Sub

    Sub btnContactShop(ByVal vCreate_shop As String)
        hide_create_shop.Value() = vCreate_shop

        If vCreate_shop.Trim().Length = 5 Then
            inn_create_shop.InnerHtml = vCreate_shop
            a_href_3bbshop.Attributes.Add("href", CF.url_3bbshop & "?shop_code=" & vCreate_shop)
        
        Else
            inn_create_shop.InnerHtml = "ไม่มีข้อมูลติดต่อ"
            a_href_3bbshop.Attributes("class") += " disabled"

        End If
    End Sub

    Sub loadFlow(ByVal vRequest_id As String, ByVal vRequest_status As String, ByVal vRequest_step As String)
        Dim vRequest_permiss As Integer = CF.rViewDetail(vRequest_id)

        If CF.rCheckCanEditAndIsRequestor(vRequest_id) = 1 Then 
            edit_form.Style.Add("display", "block")
            view_form.Style.Add("display", "none")
            hide_can_edit_approval.Value() = 1

        Else If vRequest_status = 105 Then
            view_form.Style.Add("display", "block")
            edit_form.Style.Add("display", "none")

        Else If vRequest_permiss = 0 Then
            edit_form.Style.Add("display", "none")
            inn_request_file3.InnerHtml = CF.file_dont_request_permiss
            inn_request_file4.InnerHtml = CF.file_dont_request_permiss
            inn_request_file5.InnerHtml = CF.file_dont_request_permiss
            inn_request_file6.InnerHtml = CF.file_dont_request_permiss
            inn_request_file7.InnerHtml = CF.file_dont_request_permiss
            inn_request_file8.InnerHtml = CF.file_dont_request_permiss
            btn_print_pdf1.Visible = False
            btn_print_pdf2.Visible = False
            btn_modal_edit_refund.Visible = False

        Else If vRequest_permiss = 1 Then
            view_form.Style.Add("display", "block")
            edit_form.Style.Add("display", "none")

        Else If vRequest_permiss = 2 Then
            edit_form.Style.Add("display", "block")
            view_form.Style.Add("display", "none")
        End If

        inn_flow.InnerHtml = CF.rLoadFlowBody(vRequest_id, vRequest_status, vRequest_step, vRequest_permiss)
    End Sub

    Sub loadInvDocRef(ByVal vRequest_id As String, ByVal vRequest_status As String, ByVal vRequest_step As String, ByVal invdoc_update As String) '<< invdoc_form by panu
        If CF.checkPreviewInvDocRef(vRequest_id, vRequest_status, vRequest_step) <> 1 Then
            form_invref.Style.Add("display", "none")
        End If

        If CF.rCheckInDepart(vRequest_id,92) = 1 Or CF.rCheckInDepart(vRequest_id,94) = 1 Then
            If invdoc_update = "" And CF.rCheckNotWaitReply(vRequest_id) And vRequest_step >= 2 Then
                edit_invref.Style.Add("display", "block")
                view_invref.Style.Add("display", "none")

            Else
                edit_invref.Style.Add("display", "none")
                view_invref.Style.Add("display", "block")
            End If
        Else
            edit_invref.Style.Add("display", "none")
            view_invref.Style.Add("display", "block")
        End If
    End Sub

    Sub Invref_Submit(ByVal Source As Object, ByVal E As EventArgs) '<< invdoc_form by panu
        Dim xRequest_id = Request.QueryString("request_id")
        Dim update_by As String = hide_uemail.Value
        Dim dx03 As String = CP.rReplaceQuote(txt_dx03.Value)
        Dim indoc_ref As String = CP.rReplaceQuote(txt_invref_no.Value)

        CF.UpdateInvDocRef(xRequest_id, update_by, dx03, indoc_ref)
    End Sub

    Sub Update_Submit(ByVal Source As Object, ByVal E As EventArgs)
        If CF.rCheckCanSaveEditAndIsRequestor(Request.QueryString("request_id")) = 1 Then 
            Update_Submited()
        Else
            CF.RedirectSubmit("ไม่สามารถบันทึกได้ เนื่องจากมีการอนุมัติคำขอแล้ว")
        End If
    End Sub

    Sub Update_Submited()
        Dim vRequest_id = Request.QueryString("request_id")
        Dim create_by As String = CP.rReplaceQuote(txt_create_by.Value)
        Dim create_ro As String = CP.rReplaceQuote(sel_create_ro.selectedValue)
        Dim create_shop As String = CP.rReplaceQuote(hide_create_shop.Value)
        Dim update_by As String = hide_uemail.Value

        Dim request_title_id As String = CP.rReplaceQuote(sel_title.selectedValue)
        Dim request_title As String = CP.rReplaceQuote(txt_request_title.Value)

        Dim doc_number As String = hide_ref_number.Value '<< invdoc_form by panu
        Dim amount As String = ""'CP.rReplaceQuote(txt_amount.Value)
        Dim area_ro As String = CP.rReplaceQuote(sel_create_ro.selectedValue)
        Dim shop_code As String = ""'CP.rReplaceQuote(hide_province_short.Value)

        Dim request_remark As String = CP.rReplaceQuote(txt_request_remark.Value)

        Dim uemail_cc1 As String = CP.rReplaceQuote(txt_uemail_cc1.Value)
        Dim uemail_cc2 As String = CP.rReplaceQuote(txt_uemail_cc2.Value)
        Dim uemail_verify1 As String = ""'CP.rReplaceQuote(hide_uemail_verify1.Value)
        Dim uemail_verify2 As String = ""'CP.rReplaceQuote(hide_uemail_verify2.Value)
        Dim uemail_approve As String = ""'CP.rReplaceQuote(hide_uemail_approve.Value)

        Dim tx01 As String = CP.rReplaceQuote(txtar_customer_address.Value)
        Dim tx02 As String = CP.rReplaceQuote(txt_tx02.Value)
        Dim tx03 As String = CP.rReplaceQuote(txt_tx03.Value)

        Dim dx01 As String = CP.rReplaceQuote(txt_invdate.Value)
        Dim dx02 As String = CP.rReplaceQuote(txt_dx02.Value)
        Dim dx04 As String = CP.rReplaceQuote(txt_dx04.Value)

        Dim fx01 As String = CP.rReplaceQuote(txt_bank_cheque.Value)
        Dim fx02 As String = ""'CP.rReplaceQuote(txt_fx02.Value)
        Dim fx03 As String = ""'CP.rReplaceQuote(txt_fx02.Value)

        Dim mx01 As String = CP.rReplaceQuote(txt_customer_name.Value)
        Dim mx02 As String = CP.rReplaceQuote(txt_branch.Value)
        Dim mx03 As String = CP.rReplaceQuote(txt_bank_branch.Value)
        
        Dim nx01 As String = CP.rReplaceQuote(sel_payment.selectedValue)
        Dim nx02 As String = CP.rReplaceQuote(sel_bank_title.selectedValue)

        Dim ax01 As String = CP.rReplaceQuote(txt_customer_idcard.Value)
        
        
        Dim specFile As Integer = 10

        CF.UpdateRequest(vRequest_id _
            , uemail_cc1, uemail_cc2, "", update_by _
            , create_by, create_ro _
            , create_shop, "" _
            , uemail_verify1, uemail_verify2, uemail_approve _
            , request_title_id, request_title, request_remark _
            , "", doc_number, amount _
            , "", "" _
            , "", "" _
            , "", area_ro, shop_code _
            , dx01, dx02, "" _
            , mx01, mx02, mx03 _
            , tx01, tx02, tx03 _
            , fx01, fx02, fx03 _
            , nx01, nx02, 0 _
            , 0, 0, 0 _
            , dx04, specFile _
            , ax01, "", "" _
            , "", "", "" _
            , "", "", "" _
            , "", "", "" _
            , "", "", "" _
        )

    End Sub

    Sub Cancle_Request(ByVal Source As Object, ByVal E As EventArgs)
        Dim xRequest_id = Request.QueryString("request_id")
        Dim update_by As String = hide_uemail.Value

        CF.CancleRequest(xRequest_id, update_by)
    End Sub

    Sub Flow_Submit(ByVal Source As Object, ByVal E As EventArgs)
        CF.SaveFlow(hide_uemail.Value, hide_flow_no.Value, hide_flow_sub.Value, hide_next_step.Value, hide_back_step.Value, hide_department.Value, hide_flow_status.Value, hide_flow_remark.Value)
    End Sub

    Sub Add_Next(ByVal Source As Object, ByVal E As EventArgs)
        CF.AddNext(hide_uemail.Value, hide_flow_no.Value, hide_flow_sub.Value, hide_depart_id.Value)
    End Sub
End Class
