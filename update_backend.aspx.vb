Imports System.IO
Imports System.Data

Partial Class update_backend
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()
        CP.checkLogin()
        
        If CF.rSpecialDepart(CF.system_admin) = 1 Then 'สำหรับ System Admin เท่านั้น
            hide_uemail.Value() = Session("Uemail")
        Else
            CP.kickDefault("nopermiss")
        End If

        If Not Page.IsPostBack Then
            Me.Page.Title = "Update Backend" + " [" + Me.Page.Title + "]"
        End If

        CP.Analytics()
    End Sub

    Sub Submit_Update(ByVal Source As Object, ByVal E As EventArgs)
        Dim log_by As String = hide_uemail.Value
        Dim log_remark As String = CP.rReplaceQuote(txt_log_remark.Value)
        Dim log_ref_id As String = CP.rReplaceQuote(txt_log_ref_id.Value)

        Dim request_id As String =          hide_request_id.Value
        Dim subject_id As String =          hide_subject_id.Value
        Dim request_title_id As String =    hide_request_title_id.Value
        Dim request_title As String =       CP.rReplaceQuote(hide_request_title.Value)
        Dim request_status As String =      hide_request_status.Value
        Dim request_step As String =        hide_request_step.Value
        Dim request_remark As String =      CP.rReplaceQuote(hide_request_remark.Value)
        Dim uemail_verify1 As String =      hide_uemail_verify1.Value
        Dim uemail_verify2 As String =      hide_uemail_verify2.Value
        Dim uemail_approve As String =      hide_uemail_approve.Value
        Dim uemail_cc1 As String =          hide_uemail_cc1.Value
        Dim uemail_cc2 As String =          hide_uemail_cc2.Value
        Dim uemail_ccv1 As String =         hide_uemail_ccv1.Value
        Dim create_date As String =         hide_create_date.Value
        Dim create_by As String =           hide_create_by.Value
        Dim create_ro As String =           hide_create_ro.Value
        Dim create_shop As String =         hide_create_shop.Value
        Dim create_amount As String =       hide_create_amount.Value
        Dim update_date As String =         hide_update_date.Value
        Dim update_by As String =           hide_update_by.Value
        Dim last_update As String =         hide_last_update.Value
        Dim last_depart As String =         hide_last_depart.Value
        Dim next_depart As String =         hide_next_depart.Value

        Dim account_number As String =      CP.rReplaceSpace(CP.rReplaceQuote(hide_account_number.Value))
        Dim account_name As String =        CP.rReplaceQuote(hide_account_name.Value)
        Dim account_number_to As String =   CP.rReplaceSpace(CP.rReplaceQuote(hide_account_number_to.Value))
        Dim account_name_to As String =     CP.rReplaceQuote(hide_account_name_to.Value)
        Dim doc_number As String =          CP.rReplaceSpace(CP.rReplaceQuote(hide_doc_number.Value))
        Dim bcs_number As String =          CP.rReplaceSpace(CP.rReplaceQuote(hide_bcs_number.Value))
        Dim redebt_number As String =       CP.rReplaceSpace(CP.rReplaceQuote(hide_redebt_number.Value))
        Dim redebt_file As String =         CP.rReplaceSpace(CP.rReplaceQuote(hide_redebt_file.Value))
        Dim redebt_update As String =       CP.rReplaceQuote(hide_redebt_update.Value)
        Dim redebt_update_by As String =    CP.rReplaceQuote(hide_redebt_update_by.Value)
        Dim redebt_cause_id As String =     CP.rReplaceQuote(hide_redebt_cause_id.Value)
        Dim amount As String =              CP.rReplaceQuote(hide_amount.Value)
        Dim area_ro As String =             CP.rReplaceQuote(hide_area_ro.Value)
        Dim shop_code As String =           CP.rReplaceQuote(hide_shop_code.Value)
        Dim pick_refund As String =         CP.rReplaceQuote(hide_pick_refund.Value)
        Dim lock_receipt As String =        CP.rReplaceQuote(hide_lock_receipt.Value)

        Dim fx01 As String = CP.rReplaceQuote(hide_fx01.Value)
        Dim fx02 As String = CP.rReplaceQuote(hide_fx02.Value)
        Dim fx03 As String = CP.rReplaceQuote(hide_fx03.Value)

        Dim mx01 As String = CP.rReplaceQuote(hide_mx01.Value)
        Dim mx02 As String = CP.rReplaceQuote(hide_mx02.Value)
        Dim mx03 As String = CP.rReplaceQuote(hide_mx03.Value)

        Dim tx01 As String = CP.rReplaceQuote(hide_tx01.Value)
        Dim tx02 As String = CP.rReplaceQuote(hide_tx02.Value)
        Dim tx03 As String = CP.rReplaceQuote(hide_tx03.Value)

        Dim nx01 As String = CP.rReplaceQuote(hide_nx01.Value)
        Dim nx02 As String = CP.rReplaceQuote(hide_nx02.Value)
        Dim nx03 As String = CP.rReplaceQuote(hide_nx03.Value)

        Dim sx01 As String = CP.rReplaceQuote(hide_sx01.Value)
        Dim sx02 As String = CP.rReplaceQuote(hide_sx02.Value)
        Dim sx03 As String = CP.rReplaceQuote(hide_sx03.Value)

        Dim dx01 As String = CP.rReplaceQuote(hide_dx01.Value)
        Dim dx02 As String = CP.rReplaceQuote(hide_dx02.Value)
        Dim dx03 As String = CP.rReplaceQuote(hide_dx03.Value)
        Dim dx04 As String = CP.rReplaceQuote(hide_dx04.Value)

        Dim ax01 As String = CP.rReplaceQuote(hide_ax01.Value)
        Dim ax02 As String = CP.rReplaceQuote(hide_ax02.Value)
        Dim ax03 As String = CP.rReplaceQuote(hide_ax03.Value)
        Dim ax04 As String = CP.rReplaceQuote(hide_ax04.Value)
        Dim ax05 As String = CP.rReplaceQuote(hide_ax05.Value)
        Dim ax06 As String = CP.rReplaceQuote(hide_ax06.Value)
        Dim ax07 As String = CP.rReplaceQuote(hide_ax07.Value)
        Dim ax08 As String = CP.rReplaceQuote(hide_ax08.Value)
        Dim ax09 As String = CP.rReplaceQuote(hide_ax09.Value)
        Dim ax10 As String = CP.rReplaceQuote(hide_ax10.Value)
        Dim ax11 As String = CP.rReplaceQuote(hide_ax11.Value)
        Dim ax12 As String = CP.rReplaceQuote(hide_ax12.Value)
        Dim ax13 As String = CP.rReplaceQuote(hide_ax13.Value)
        Dim ax14 As String = CP.rReplaceQuote(hide_ax14.Value)
        Dim ax15 As String = CP.rReplaceQuote(hide_ax15.Value)
        Dim ax16 As String = CP.rReplaceQuote(hide_ax16.Value)
        Dim ax17 As String = CP.rReplaceQuote(hide_ax17.Value)
        Dim ax18 As String = CP.rReplaceQuote(hide_ax18.Value)
        Dim ax19 As String = CP.rReplaceQuote(hide_ax19.Value)
        Dim ax20 As String = CP.rReplaceQuote(hide_ax20.Value)

        Dim gx01 As String = CP.rReplaceQuote(hide_gx01.Value)
        Dim gx02 As String = CP.rReplaceQuote(hide_gx02.Value)
        Dim gx03 As String = CP.rReplaceQuote(hide_gx03.Value)
        Dim gx04 As String = CP.rReplaceQuote(hide_gx04.Value)
        Dim gx05 As String = CP.rReplaceQuote(hide_gx05.Value)

        CF.UpdateBackend(log_by, log_remark _
            , log_ref_id, request_id _
            , subject_id, request_title_id, request_title _
            , request_status, request_step, request_remark _
            , uemail_verify1, uemail_verify2, uemail_approve _
            , uemail_cc1, uemail_cc2, uemail_ccv1 _
            , create_date, create_by _
            , create_ro, create_shop, create_amount _
            , update_date, update_by _
            , last_update, last_depart, next_depart _
            , account_number, account_name _
            , account_number_to, account_name_to _
            , doc_number, bcs_number _
            , redebt_number, redebt_file _
            , redebt_update, redebt_update_by _
            , redebt_cause_id, amount _
            , area_ro, shop_code _
            , pick_refund, lock_receipt _
            , fx01, fx02, fx03 _
            , mx01, mx02, mx03 _
            , tx01, tx02, tx03 _
            , nx01, nx02, nx03 _
            , sx01, sx02, sx03 _
            , dx01, dx02, dx03, dx04 _
            , ax01, ax02, ax03, ax04, ax05 _
            , ax06, ax07, ax08, ax09, ax10 _
            , ax11, ax12, ax13, ax14, ax15 _
            , ax16, ax17, ax18, ax19, ax20 _
            , gx01, gx02, gx03, gx04, gx05 _
        )
    End Sub
End Class
