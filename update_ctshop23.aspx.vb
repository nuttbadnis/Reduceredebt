Imports System.IO
Imports System.Data

Partial Class update_ctshop23
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DBShopStock As New Cls_DataShopStock
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Dim pageUrl As String = "ctshop23"

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
        End If
    End Sub

    Sub loadDetail(ByVal vRequest_id As String)
        Dim vDT As New DataTable
        vDT = CF.rSqlLoadDetailProjectC(vRequest_id)

        If(vDT.Rows().Count() > 0)
            Dim vSql As String
            
            Me.Page.Title = "#" + vRequest_id + " [" + Me.Page.Title + "]"

            project_name.InnerHtml = vDT.Rows(0).Item("project_name")
            subject_name.InnerHtml = vDT.Rows(0).Item("subject_prefix") + ". " + vDT.Rows(0).Item("subject_name")
            hide_page_url.Value() = pageUrl
            hide_min_cost.Value() = vDT.Rows(0).Item("min_cost")
            hide_max_cost.Value() = vDT.Rows(0).Item("max_cost")
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
            Dim request_file4 As String = "-"

            If vDT.Rows(0).Item("request_file1").Trim() <> "" Then
                request_file1 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file1"), vDT.Rows(0).Item("request_file1"))
            End If
            If vDT.Rows(0).Item("request_file2").Trim() <> "" Then
                request_file2 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file2"), vDT.Rows(0).Item("request_file2"))
            End If
            If vDT.Rows(0).Item("request_file4").Trim() <> "" Then
                request_file4 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file4"), vDT.Rows(0).Item("request_file4"))
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

            hide_uemail_verify1.Value() = vDT.Rows(0).Item("uemail_verify1")
            hide_uemail_verify2.Value() = vDT.Rows(0).Item("uemail_verify2")
            hide_uemail_approve.Value() = vDT.Rows(0).Item("uemail_approve")
            hide_subject_id.Value() = vDT.Rows(0).Item("subject_id")

            '''''''''''''''''''''''''''''''''''''''''''''''' Data ''''''''''''''''''''''''''''''''''''''''''''''''

            txt_request_title.Value() = vDT.Rows(0).Item("request_title")
            'txtar_request_remark.Value() = vDT.Rows(0).Item("request_remark")

            txt_amount.Value() = vDT.Rows(0).Item("amount")
            txt_area_ro.Value() = vDT.Rows(0).Item("area_ro")
            hide_province_short.Value() = vDT.Rows(0).Item("shop_code")


            'hide_shop_code.Value() = vDT.Rows(0).Item("fx01")
            txt_cluster.Value() = vDT.Rows(0).Item("fx02")
            'hide_elecharge_unit.Value() = vDT.Rows(0).Item("mx01") 
            txtar_location.Value() = vDT.Rows(0).Item("tx01")
            txtar_newlocation.Value() = vDT.Rows(0).Item("tx02") 

            txt_nx01.Value() = vDT.Rows(0).Item("nx01") 
            txt_nx02.Value() = vDT.Rows(0).Item("nx02") 
            txt_nx03.Value() = vDT.Rows(0).Item("nx03") 

            txt_ax01.Value() = vDT.Rows(0).Item("ax01") 
            txt_ax02.Value() = vDT.Rows(0).Item("ax02") 
            txt_ax03.Value() = vDT.Rows(0).Item("ax03") 
            txt_uprent_rate.Value() = vDT.Rows(0).Item("ax04") 
            txt_ax05.Value() = vDT.Rows(0).Item("ax05") 
            txt_ax06.Value() = vDT.Rows(0).Item("ax06") 
            txt_ax07.Value() = vDT.Rows(0).Item("ax07") 
            txt_ax08.Value() = vDT.Rows(0).Item("ax08") 
            txt_ax09.Value() = vDT.Rows(0).Item("ax09") 
            txt_ax10.Value() = vDT.Rows(0).Item("ax10") 
            txt_ax11.Value() = vDT.Rows(0).Item("ax11") 
            txt_ax12.Value() = vDT.Rows(0).Item("ax12") 
            txt_ax13.Value() = vDT.Rows(0).Item("ax13") 
            txt_ax14.Value() = vDT.Rows(0).Item("ax14")
            txt_gx01.Value() = vDT.Rows(0).Item("gx01") 

            current_request_file1.InnerHtml = request_file1
            current_request_file2.InnerHtml = request_file2
            current_request_file4.InnerHtml = request_file4

            vSql = CF.rSqlDDstorePlaceType()
            DBShopStock.SetDropDownList(sel_placetype, vSql, "storeplacetype_name", "storeplacetype_id", "เลือกประเภทพื้นที่")
            sel_placetype.SelectedValue = vDT.Rows(0).Item("sx01")
            
            vSql = CF.rSqlDDcontractPhase()
            DBShopStock.SetDropDownList(sel_ctphase, vSql, "phase_title", "phase_id", "เลือกอายุสัญญา")
            sel_ctphase.SelectedValue = vDT.Rows(0).Item("fx03")
            txt_ctphase_remark.Value() = vDT.Rows(0).Item("mx02")

            vSql = CF.rSqlDDRO()
            DB105.SetDropDownList(sel_create_ro, vSql, "ro_title", "ro_value", "เลือก RO ผู้สร้างคำขอ")
            sel_create_ro.SelectedValue = vDT.Rows(0).Item("create_ro")

            txt_create_by.Value() = vDT.Rows(0).Item("create_by")
            txt_create_date.Value() = vDT.Rows(0).Item("create_date")

            txt_uemail_cc1.Value() = vDT.Rows(0).Item("uemail_cc1")
            txt_uemail_cc2.Value() = vDT.Rows(0).Item("uemail_cc2")
            txt_uemail_verify1.Value() = vDT.Rows(0).Item("uemail_verify1")
            txt_uemail_verify2.Value() = vDT.Rows(0).Item("uemail_verify2")
            txt_uemail_approve.Value() = vDT.Rows(0).Item("uemail_approve")

            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            inn_request_title.InnerHtml = vDT.Rows(0).Item("request_title")
            'inn_request_remark.InnerHtml = vDT.Rows(0).Item("request_remark")

            inn_amount.InnerHtml = vDT.Rows(0).Item("amount")

            inn_area_ro.InnerHtml = vDT.Rows(0).Item("area_ro")
            inn_cluster.InnerHtml = vDT.Rows(0).Item("fx02")
            'inn_elecharge_unit.InnerHtml = vDT.Rows(0).Item("mx01") 
            inn_tx01.InnerHtml = vDT.Rows(0).Item("tx01")
            inn_tx02.InnerHtml = vDT.Rows(0).Item("tx02")  

            inn_nx01.InnerHtml = vDT.Rows(0).Item("nx01") 
            inn_nx02.InnerHtml = vDT.Rows(0).Item("nx02") 
            inn_nx03.InnerHtml = vDT.Rows(0).Item("nx03") 

            inn_ax01.InnerHtml = vDT.Rows(0).Item("ax01") 
            inn_ax02.InnerHtml = vDT.Rows(0).Item("ax02") 
            inn_ax03.InnerHtml = vDT.Rows(0).Item("ax03") 
            inn_uprent_rate.InnerHtml = vDT.Rows(0).Item("ax04") 
            inn_ax05.InnerHtml = vDT.Rows(0).Item("ax05") 
            inn_ax06.InnerHtml = vDT.Rows(0).Item("ax06") 
            inn_ax07.InnerHtml = vDT.Rows(0).Item("ax07") 
            inn_ax08.InnerHtml = vDT.Rows(0).Item("ax08") 
            inn_ax09.InnerHtml = vDT.Rows(0).Item("ax09") 
            inn_ax10.InnerHtml = vDT.Rows(0).Item("ax10") 
            inn_ax11.InnerHtml = vDT.Rows(0).Item("ax11") 
            inn_ax12.InnerHtml = vDT.Rows(0).Item("ax12") 
            inn_ax13.InnerHtml = vDT.Rows(0).Item("ax13") 
            inn_ax14.InnerHtml = vDT.Rows(0).Item("ax14") 

            inn_gx01.InnerHtml = vDT.Rows(0).Item("gx01") 

            inn_request_file1.InnerHtml = request_file1
            inn_request_file2.InnerHtml = request_file2
            inn_request_file4.InnerHtml = request_file4

            inn_create_ro.InnerHtml = "(RO" + vDT.Rows(0).Item("create_ro") + ")"
            inn_create_by.InnerHtml = vDT.Rows(0).Item("create_by") + "@jasmine.com"
            inn_create_date.InnerHtml = vDT.Rows(0).Item("create_date")
            inn_update.InnerHtml =  vDT.Rows(0).Item("update_date") & " <b>โดย</b> " & vDT.Rows(0).Item("update_by") + "@jasmine.com"

            inn_uemail_cc.InnerHtml = uemail_cc
            inn_uemail_verify1.InnerHtml = vDT.Rows(0).Item("uemail_verify1") + "@jasmine.com"
            inn_uemail_verify2.InnerHtml = vDT.Rows(0).Item("uemail_verify2") + "@jasmine.com"
            inn_uemail_approve.InnerHtml = vDT.Rows(0).Item("uemail_approve") + "@jasmine.com"

            btnContactShop(vDT.Rows(0).Item("create_shop"))

            loadFlow(vRequest_id, vDT.Rows(0).Item("request_status"), vDT.Rows(0).Item("request_step"))
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
            inn_request_file2.InnerHtml = CF.file_dont_request_permiss
            inn_request_file4.InnerHtml = CF.file_dont_request_permiss
            ' btn_print.Visible = False
            ' btn_modal_edit_refund.Visible = False

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

        Dim amount As String = CP.rReplaceQuote(txt_amount.Value)
        Dim area_ro As String = CP.rReplaceQuote(txt_area_ro.Value)
        Dim shop_code As String = CP.rReplaceQuote(hide_province_short.Value)

        Dim request_remark As String = ""'CP.rReplaceQuote(txtar_request_remark.Value)

        Dim uemail_cc1 As String = CP.rReplaceQuote(txt_uemail_cc1.Value)
        Dim uemail_cc2 As String = CP.rReplaceQuote(txt_uemail_cc2.Value)
        Dim uemail_verify1 As String = CP.rReplaceQuote(hide_uemail_verify1.Value)
        Dim uemail_verify2 As String = CP.rReplaceQuote(hide_uemail_verify2.Value)
        Dim uemail_approve As String = CP.rReplaceQuote(hide_uemail_approve.Value)

        Dim tx01 As String = CP.rReplaceQuote(txtar_location.Value)
        Dim tx02 As String = CP.rReplaceQuote(txtar_newlocation.Value)
        Dim tx03 As String = ""'CP.rReplaceQuote(txtar_tx03.Value)

        Dim fx01 As String = ""'CP.rReplaceQuote(hide_shop_code.Value)
        Dim fx02 As String = CP.rReplaceQuote(txt_cluster.Value)
        Dim fx03 As String = CP.rReplaceQuote(sel_ctphase.selectedValue)

        Dim mx01 As String = ""'CP.rReplaceQuote(hide_elecharge_unit.Value)
        Dim mx02 As String = CP.rReplaceQuote(txt_ctphase_remark.Value)
        Dim mx03 As String = 0'CP.rReplaceQuote(txt_mx03.Value)

        Dim nx01 As String = CP.rReplaceQuote(txt_nx01.Value)
        Dim nx02 As String = CP.rReplaceQuote(txt_nx02.Value)
        Dim nx03 As String = CP.rReplaceQuote(txt_nx03.Value)

        Dim sx01 As String = CP.rReplaceQuote(sel_placetype.selectedValue)
        Dim sx02 As String = 0'CP.rReplaceQuote(txt_sx02.Value)
        Dim sx03 As String = 0'CP.rReplaceQuote(txt_sx03.Value)

        Dim ax01 As String = CP.rReplaceQuote(txt_ax01.Value)
        Dim ax02 As String = CP.rReplaceQuote(txt_ax02.Value)
        Dim ax03 As String = CP.rReplaceQuote(txt_ax03.Value)
        Dim ax04 As String = CP.rReplaceQuote(txt_uprent_rate.Value)
        Dim ax05 As String = CP.rReplaceQuote(txt_ax05.Value)
        Dim ax06 As String = CP.rReplaceQuote(txt_ax06.Value)
        Dim ax07 As String = CP.rReplaceQuote(txt_ax07.Value)
        Dim ax08 As String = CP.rReplaceQuote(txt_ax08.Value)
        Dim ax09 As String = CP.rReplaceQuote(txt_ax09.Value)
        Dim ax10 As String = CP.rReplaceQuote(txt_ax10.Value)
        Dim ax11 As String = CP.rReplaceQuote(txt_ax11.Value)
        Dim ax12 As String = CP.rReplaceQuote(txt_ax12.Value)
        Dim ax13 As String = CP.rReplaceQuote(txt_ax13.Value)
        Dim ax14 As String = CP.rReplaceQuote(txt_ax14.Value)
        Dim ax15 As String = ""'CP.rReplaceQuote(txt_ax15.Value)
        Dim ax16 As String = ""'CP.rReplaceQuote(txt_ax16.Value)
        Dim ax17 As String = ""'CP.rReplaceQuote(txt_ax17.Value)
        Dim ax18 As String = ""'CP.rReplaceQuote(txt_ax18.Value)
        Dim ax19 As String = ""'CP.rReplaceQuote(txt_ax19.Value)
        Dim ax20 As String = ""'CP.rReplaceQuote(txt_ax20.Value)

        Dim gx01 As String = CP.rReplaceQuote(txt_gx01.Value)
        
        Dim specFile As Integer = 5

        CF.UpdateRequest(vRequest_id _
            , uemail_cc1, uemail_cc2, "", update_by _
            , create_by, create_ro _
            , create_shop, "" _
            , uemail_verify1, uemail_verify2, uemail_approve _
            , request_title_id, request_title, request_remark _
            , "", "", amount _
            , "", "" _
            , "", "" _
            , "", area_ro, shop_code _
            , "", "", "" _
            , mx01, mx02, mx03 _
            , tx01, tx02, tx03 _
            , fx01, fx02, fx03 _
            , nx01, nx02, nx03 _
            , sx01, sx02, sx03 _
            , "", specFile _
            , ax01, ax02, ax03 _
            , ax04, ax05, ax06 _
            , ax07, ax08, ax09 _
            , ax10, ax11, ax12 _
            , ax13, ax14, ax15 _
            , ax16, ax17, ax18 _
            , ax19, ax20, gx01 _
        )


    ' Public Sub UpdateRequest(vRequest_id _
    '     , uemail_cc1, uemail_cc2, uemail_ccv1, update_by _
    '     , create_by, create_ro _
    '     , create_shop, pick_refund _
    '     , uemail_verify1, uemail_verify2, uemail_approve _
    '     , request_title_id, request_title, request_remark _
    '     , bcs_number, doc_number, amount _
    '     , account_number, account_name _
    '     , account_number_to, account_name_to _
    '     , redebt_cause_id, area_ro, shop_code _
    '     , dx01, dx02, dx03 _
    '     , mx01, mx02, mx03 _
    '     , tx01, tx02, tx03 _
    '     , fx01, fx02, fx03 _
    '     , nx01, nx02, nx03 _
    '     , sx01, sx02, sx03 _
    '     , dx04 , specFile _
    '     , ax01, ax02, ax03 _
    '     , ax04, ax05, ax06 _
    '     , ax07, ax08, ax09 _
    '     , ax10, ax11, ax12 _
    '     , ax13, ax14, ax15 _
    ' )
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
