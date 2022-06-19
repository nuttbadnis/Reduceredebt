Imports System.IO
Imports System.Data

Partial Class update_redebt28
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Dim pageUrl As String = "redebt28"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        hide_token.Value() = Session("token")
        hide_uemail.Value() = Session("Uemail")

        If Not Page.IsPostBack Then
            Dim xRequest_id = Request.QueryString("request_id")
            CF.checkPage(xRequest_id, pageUrl)
            CF.checkRequestFlowBroken(xRequest_id)
            loadDetail(xRequest_id)
            checkRequestEnd(xRequest_id)
        End If
    
        CP.Analytics()
    End Sub

    Sub checkRequestEnd(ByVal vRequest_id As String)
        If CF.rGetRequestStatus(vRequest_id) <> 100 Then
            btn_print.Visible = False
            btn_print_hidden.Visible = False
            btn_modal_after_end.Visible = False
        End If
    End Sub

    Sub loadDetail(ByVal vRequest_id As String)
        Dim vDT As New DataTable
        vDT = CF.rSqlLoadDetailRedebt(vRequest_id)

        If(vDT.Rows().Count() > 0)
            Dim vSql As String
            
            Me.Page.Title = "#" + vRequest_id + " [" + Me.Page.Title + "]"

            hide_redebt_cause.Value() = vDT.Rows(0).Item("redebt_cause_id")
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
            Dim request_file3 As String = "-"

            If vDT.Rows(0).Item("request_file1").Trim() <> "" Then
                request_file1 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file1"), vDT.Rows(0).Item("request_file1"))
            End If
            If vDT.Rows(0).Item("request_file3").Trim() <> "" Then
                request_file3 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file1"), vDT.Rows(0).Item("request_file3"))
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

            hide_area_ro.Value() = vDT.Rows(0).Item("area_ro")
            hide_province_short.Value() = vDT.Rows(0).Item("shop_code")
            hide_redebt_number.Value() = vDT.Rows(0).Item("redebt_number")
            hide_pick_refund.Value() = vDT.Rows(0).Item("pick_refund")
            hide_subject_id.Value() = vDT.Rows(0).Item("subject_id")
            hide_bank_code.Value() = vDT.Rows(0).Item("nx01")
            '''''''''''''''''''''''''''''''''''''''''''''''' Data ''''''''''''''''''''''''''''''''''''''''''''''''

            txt_request_title.Value() = vDT.Rows(0).Item("request_title")
            txt_request_remark.Value() = vDT.Rows(0).Item("request_remark")

            txt_account_number.Value() = vDT.Rows(0).Item("account_number")
            txt_account_name.Value() = vDT.Rows(0).Item("account_name")

            txt_amount.Value() = vDT.Rows(0).Item("amount")
            txt_doc_number.Value() = vDT.Rows(0).Item("doc_number")
            txt_bcs_number.Value() = vDT.Rows(0).Item("bcs_number")

            txt_account_number_to.Value() = vDT.Rows(0).Item("account_number_to")
            txt_account_name_to.Value() = vDT.Rows(0).Item("account_name_to")

            txt_dx03.Value() = vDT.Rows(0).Item("dx03") 'วันที่ลูกค้าขอลดหนี้

            txt_mx03.Value() = vDT.Rows(0).Item("mx03") 'ชื่อบัญชี

            txt_tx01.Value() = vDT.Rows(0).Item("tx01") 'ลูกค้าต้องการคืนเงินเป็น

            txt_fx01.Value() = vDT.Rows(0).Item("fx01") 'รหัสสาขาธนาคาร
            txt_fx02.Value() = vDT.Rows(0).Item("fx02") 'เลขที่บัญชี

            current_request_file1.InnerHtml = request_file1
            current_request_file3.InnerHtml = request_file3

            vSql = CF.rSqlDDRO()
            DB105.SetDropDownList(sel_create_ro, vSql, "ro_title", "ro_value", "เลือก RO ผู้สร้างคำขอ")
            sel_create_ro.SelectedValue = vDT.Rows(0).Item("create_ro")
            txt_create_by.Value() = vDT.Rows(0).Item("create_by")
            txt_create_date.Value() = vDT.Rows(0).Item("create_date")

            txt_uemail_cc1.Value() = vDT.Rows(0).Item("uemail_cc1")
            txt_uemail_cc2.Value() = vDT.Rows(0).Item("uemail_cc2")

            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            inn_request_title.InnerHtml = vDT.Rows(0).Item("request_title")
            inn_request_remark.InnerHtml = vDT.Rows(0).Item("request_remark")
            inn_redebt_cause.InnerHtml = vDT.Rows(0).Item("redebt_cause_title")

            inn_account_number.InnerHtml = vDT.Rows(0).Item("account_number")
            inn_account_name.InnerHtml = vDT.Rows(0).Item("account_name")

            inn_doc_number.InnerHtml = vDT.Rows(0).Item("doc_number")
            inn_bcs_number.InnerHtml = vDT.Rows(0).Item("bcs_number")
            inn_amount.InnerHtml = vDT.Rows(0).Item("amount")

            inn_account_number_to.InnerHtml = vDT.Rows(0).Item("account_number_to")
            inn_account_name_to.InnerHtml = vDT.Rows(0).Item("account_name_to")

            inn_dx03.InnerHtml = vDT.Rows(0).Item("dx03") 'วันที่ลูกค้าขอลดหนี้

            inn_mx03.InnerHtml = vDT.Rows(0).Item("mx03") 'ชื่อบัญชี

            inn_tx01.InnerHtml = vDT.Rows(0).Item("tx01") 'ลูกค้าต้องการคืนเงินเป็น

            inn_fx01.InnerHtml = vDT.Rows(0).Item("fx01") 'รหัสสาขาธนาคาร
            inn_fx02.InnerHtml = vDT.Rows(0).Item("fx02") 'เลขที่บัญชี

            inn_request_file1.InnerHtml = request_file1
            inn_request_file3.InnerHtml = request_file3

            inn_create_ro.InnerHtml = "(RO" + vDT.Rows(0).Item("create_ro") + ")"
            inn_create_by.InnerHtml = vDT.Rows(0).Item("create_by") + "@jasmine.com"
            inn_create_date.InnerHtml = vDT.Rows(0).Item("create_date")
            inn_update.InnerHtml =  vDT.Rows(0).Item("update_date") & " <b>โดย</b> " & vDT.Rows(0).Item("update_by") + "@jasmine.com"

            inn_uemail_cc.InnerHtml = uemail_cc

            btnContactShop(vDT.Rows(0).Item("create_shop"))

            loadFlow(vRequest_id, vDT.Rows(0).Item("request_status"), vDT.Rows(0).Item("request_step"))
            loadRedebt(vRequest_id)
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
            inn_request_file1.InnerHtml = CF.file_dont_request_permiss
            inn_request_file3.InnerHtml = CF.file_dont_request_permiss
            btn_print.Visible = False
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

        Dim account_number As String = CP.rReplaceQuote(txt_account_number.Value)
        Dim account_name As String = CP.rReplaceQuote(txt_account_name.Value)

        Dim bcs_number As String = CP.rReplaceQuote(txt_bcs_number.Value)
        Dim doc_number As String = CP.rReplaceQuote(txt_doc_number.Value)
        Dim amount As String = CP.rReplaceQuote(txt_amount.Value)
        Dim area_ro As String = CP.rReplaceQuote(hide_area_ro.Value)
        Dim shop_code As String = CP.rReplaceQuote(hide_province_short.Value)

        Dim account_number_to As String = CP.rReplaceQuote(txt_account_number_to.Value)
        Dim account_name_to As String = CP.rReplaceQuote(txt_account_name_to.Value)

        Dim redebt_cause_id As String = CP.rReplaceQuote(hide_redebt_cause.Value)
        Dim request_remark As String = CP.rReplaceQuote(txt_request_remark.Value)
        Dim pick_refund As String = CP.rReplaceQuote(hide_pick_refund.Value)

        Dim uemail_cc1 As String = CP.rReplaceQuote(txt_uemail_cc1.Value)
        Dim uemail_cc2 As String = CP.rReplaceQuote(txt_uemail_cc2.Value)

        Dim dx03 As String = CP.rReplaceQuote(txt_dx03.Value) 'วันที่ลูกค้าขอลดหนี้

        Dim mx03 As String = CP.rReplaceQuote(txt_mx03.Value) 'ชื่อบัญชี

        Dim tx01 As String = CP.rReplaceQuote(txt_tx01.Value) 'ลูกค้าต้องการคืนเงินเป็น

        Dim fx01 As String = CP.rReplaceQuote(txt_fx01.Value) 'รหัสสาขาธนาคาร
        Dim fx02 As String = CP.rReplaceQuote(txt_fx02.Value) 'เลขที่บัญชี

        Dim nx01 As Integer = CP.rReplaceQuote(hide_bank_code.Value)

        CF.UpdateRequest(vRequest_id _
            , uemail_cc1, uemail_cc2, "", update_by _
            , create_by, create_ro _
            , create_shop, pick_refund _
            , "", "", "" _
            , request_title_id, request_title, request_remark _
            , bcs_number, doc_number, amount _
            , account_number, account_name _
            , account_number_to, account_name_to _
            , redebt_cause_id, area_ro, shop_code _
            , "", "", dx03 _
            , "", "", mx03 _
            , tx01, "", "" _
            , fx01, fx02, "" _
            , nx01 _
        )
    End Sub

    Sub Cancle_Request(ByVal Source As Object, ByVal E As EventArgs)
        Dim xRequest_id = Request.QueryString("request_id")
        Dim update_by As String = hide_uemail.Value

        CF.CancleRequest(xRequest_id, update_by)
    End Sub

    Sub loadRedebt(ByVal vRequest_id As String)
        If CF.rCheckInDepart(vRequest_id,10) = 1 Or CF.rCheckInDepart(vRequest_id,20) = 1 Then
            If hide_redebt_number.Value = "" And CF.rCheckNotWaitReply(vRequest_id) Then
                view_redebt.Style.Add("display", "none")
                edit_redebt.Style.Add("display", "block")
                none_redebt.Style.Add("display", "none")
            Else
                view_redebt.Style.Add("display", "block")
                edit_redebt.Style.Add("display", "none")
                none_redebt.Style.Add("display", "none")
            End If

        Else If CF.rCheckNotEndAndIsRequestor(vRequest_id) = 1 Then 
            view_redebt.Style.Add("display", "none")
            edit_redebt.Style.Add("display", "none")
            none_redebt.Style.Add("display", "block")

        Else If hide_redebt_number.Value = "" And CF.rCheckNotWaitReply(vRequest_id) = 1 And (CF.rCheckInDepart(vRequest_id,10) = 1 Or CF.rCheckInDepart(vRequest_id,20) = 1 Or (hide_subject_id.Value = "902001" And CF.rCheckIsRequestor(vRequest_id) = 1)) Then
            view_redebt.Style.Add("display", "none")
            edit_redebt.Style.Add("display", "block")
            none_redebt.Style.Add("display", "none")

        Else
            view_redebt.Style.Add("display", "block")
            edit_redebt.Style.Add("display", "none")
            none_redebt.Style.Add("display", "none")
        End If
        
        hide_hide_redebt_file.Value() = CF.rCheckHideRedebtFileIsRequestor(vRequest_id, CF.rViewDetail(vRequest_id))
    End Sub

    Sub Redebt_Submit(ByVal Source As Object, ByVal E As EventArgs)
        Dim xRequest_id = Request.QueryString("request_id")
        Dim update_by As String = hide_uemail.Value
        Dim redebt_number As String = CP.rReplaceQuote(hide_redebt_number.Value)

        CF.UpdateRedebtNumber(xRequest_id, redebt_number, update_by)
    End Sub

    Sub Flow_Submit(ByVal Source As Object, ByVal E As EventArgs)
        CF.SaveFlow(hide_uemail.Value, hide_flow_no.Value, hide_flow_sub.Value, hide_next_step.Value, hide_back_step.Value, hide_department.Value, hide_flow_status.Value, hide_flow_remark.Value)
    End Sub

    Sub Add_Next(ByVal Source As Object, ByVal E As EventArgs)
        CF.AddNext(hide_uemail.Value, hide_flow_no.Value, hide_flow_sub.Value, hide_depart_id.Value)
    End Sub
End Class
