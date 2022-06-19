Imports System.IO
Imports System.Data

Partial Class update_backof30
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Dim pageUrl As String = "backof30"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        hide_token.Value() = Session("token")
        hide_uemail.Value() = Session("Uemail")

        If Not Page.IsPostBack Then
            Dim xRequest_id = Request.QueryString("request_id")
            CF.checkPage(xRequest_id, pageUrl)
            CF.checkRequestFlowBroken(xRequest_id)
            loadDetail(xRequest_id)
        End If
    
        CP.Analytics()
    End Sub

    Sub loadDetail(ByVal vRequest_id As String)
        Dim vDT As New DataTable
        vDT = CF.rSqlLoadBackof(vRequest_id)

        If(vDT.Rows().Count() > 0)
            Dim vSql As String
            
            Me.Page.Title = "#" + vRequest_id + " [" + Me.Page.Title + "]"

            project_name.InnerHtml = vDT.Rows(0).Item("project_name")
            subject_name.InnerHtml = vDT.Rows(0).Item("subject_prefix") + ". " + vDT.Rows(0).Item("subject_name")
            inn_request_id.InnerHtml = vRequest_id
            inn_status_name.InnerHtml = vDT.Rows(0).Item("status_name")

            '''''''''''''''''''''''''''''''''''''''''''''''' Data ''''''''''''''''''''''''''''''''''''''''''''''''
            Dim request_file3 As String = "-"

            If vDT.Rows(0).Item("request_file3").Trim() <> "" Then
                request_file3 = CF.rLinkOpenfile(vRequest_id, vDT.Rows(0).Item("path_file3"), vDT.Rows(0).Item("request_file3"))
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
            hide_subject_id.Value() = vDT.Rows(0).Item("subject_id")
            hide_request_title_id.Value() = vDT.Rows(0).Item("request_title_id")
            '''''''''''''''''''''''''''''''''''''''''''''''' Data ''''''''''''''''''''''''''''''''''''''''''''''''

            hide_select_shop.Value() = vDT.Rows(0).Item("fx01")
            hide_area_ro.Value() = vDT.Rows(0).Item("area_ro")
            hide_province_short.Value() = vDT.Rows(0).Item("shop_code")

            vSql = CF.rSqlDDRO()
            DB105.SetDropDownList(sel_create_ro, vSql, "ro_title", "ro_value", "เลือก RO ผู้สร้างคำขอ")
            sel_create_ro.SelectedValue = vDT.Rows(0).Item("create_ro")
            txt_create_by.Value() = vDT.Rows(0).Item("create_by")
            txt_create_date.Value() = vDT.Rows(0).Item("create_date")

            txt_uemail_cc1.Value() = vDT.Rows(0).Item("uemail_cc1")
            txt_uemail_cc2.Value() = vDT.Rows(0).Item("uemail_cc2")
            txt_uemail_verify1.Value() = vDT.Rows(0).Item("uemail_verify1")

            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            inn_request_title.InnerHtml = vDT.Rows(0).Item("request_title")

            inn_tx01.InnerHtml = vDT.Rows(0).Item("tx01")
            inn_tx02.InnerHtml = vDT.Rows(0).Item("tx02")

            inn_request_file3.InnerHtml = request_file3

            inn_create_ro.InnerHtml = "(RO" + vDT.Rows(0).Item("create_ro") + ")"
            inn_create_by.InnerHtml = vDT.Rows(0).Item("create_by") + "@jasmine.com"
            inn_create_date.InnerHtml = vDT.Rows(0).Item("create_date")
            inn_update.InnerHtml =  vDT.Rows(0).Item("update_date") & " <b>โดย</b> " & vDT.Rows(0).Item("update_by") + "@jasmine.com"

            inn_uemail_cc.InnerHtml = uemail_cc
            inn_uemail_verify1.InnerHtml = vDT.Rows(0).Item("uemail_verify1") + "@jasmine.com"

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
            inn_request_file3.InnerHtml = CF.file_dont_request_permiss

        Else If vRequest_permiss = 1 Then
            view_form.Style.Add("display", "block")
            edit_form.Style.Add("display", "none")

        Else If vRequest_permiss = 2 Then
            edit_form.Style.Add("display", "block")
            view_form.Style.Add("display", "none")
        End If

        If vRequest_permiss > 0 And vRequest_status < 100 Then
            cancle_form.Style.Add("display", "block")
        Else 
            cancle_form.Style.Add("display", "none")
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

        Dim request_title_id As String = CP.rReplaceQuote(hide_request_title_id.Value)
        Dim request_title As String = CP.rReplaceQuote(inn_request_title.InnerHtml)

        Dim fx01 As String = CP.rReplaceQuote(hide_select_shop.Value)
        Dim area_ro As String = CP.rReplaceQuote(hide_area_ro.Value)
        Dim shop_code As String = CP.rReplaceQuote(hide_province_short.Value)

        Dim uemail_cc1 As String = CP.rReplaceQuote(txt_uemail_cc1.Value)
        Dim uemail_cc2 As String = CP.rReplaceQuote(txt_uemail_cc2.Value)
        Dim uemail_verify1 As String = CP.rReplaceQuote(hide_uemail_verify1.Value)

        Dim tx01 As String = CP.rReplaceQuote(inn_tx01.InnerHtml)
        Dim tx02 As String = CP.rReplaceQuote(inn_tx02.InnerHtml)

        CF.UpdateRequest(vRequest_id _
            , uemail_cc1, uemail_cc2, "", update_by _
            , create_by, create_ro _
            , create_shop, "" _
            , uemail_verify1, "", "" _
            , request_title_id, request_title, "" _
            , "", "", "" _
            , "", "" _
            , "", "" _
            , "", area_ro, shop_code _
            , "", "", "" _
            , "", "", "" _
            , tx01, tx02, "" _
            , fx01 _
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
