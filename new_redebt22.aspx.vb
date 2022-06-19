Imports System.IO
Imports System.Data

Partial Class new_redebt22
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DB106 As New Cls_Data
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Dim pageUrl As String = "redebt22"
    Dim pageSubject_id As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        pageSubject_id = Request.QueryString("subject_id")

        hide_token.Value() = Session("token")
        hide_uemail.Value() = Session("Uemail")
        txt_create_by.Value() = Session("Uemail")

        If Not Page.IsPostBack Then
            Dim vSql As String 
            Dim vDT As New DataTable
            vDT = CF.rLoadSubject(pageSubject_id, pageUrl)

            Me.Page.Title = "+ " + vDT.Rows(0).Item("subject_prefix") + ". " + vDT.Rows(0).Item("subject_name") + " [" + Me.Page.Title + "]"

            hide_flow_id.Value() = vDT.Rows(0).Item("flow_id")
            hide_prefix_id.Value() = vDT.Rows(0).Item("prefix_id")
            hide_subject_id.Value() = vDT.Rows(0).Item("subject_id")
            project_name.InnerHtml = vDT.Rows(0).Item("project_name")
            subject_name.InnerHtml = vDT.Rows(0).Item("subject_prefix") + ". " + vDT.Rows(0).Item("subject_name")
            subject_desc.InnerHtml = vDT.Rows(0).Item("subject_desc")

            '''''''''''''''''''''''''''''''''''''''''''''''' Load Title ''''''''''''''''''''''''''''''''''''''''''''''''
            vSql = CF.rSqlDDTitle(pageSubject_id)
            DB105.SetDropDownList(sel_title, vSql, "request_title", "request_title_id", "เลือกเรื่องที่แจ้ง")
            '''''''''''''''''''''''''''''''''''''''''''''''' Load Title ''''''''''''''''''''''''''''''''''''''''''''''''

            vSql = CF.rSqlDDRO()
            DB105.SetDropDownList(sel_create_ro, vSql, "ro_title", "ro_value", "เลือก RO ผู้สร้างคำขอ")
        End If

        CP.Analytics()
    End Sub

    Sub Submit_ShopStock(ByVal Source As Object, ByVal E As EventArgs)
        Dim flow_id As String = hide_flow_id.Value
        Dim prefix_id As String = hide_prefix_id.Value
        Dim create_by As String = hide_uemail.Value
        Dim create_ro As String = CP.rReplaceQuote(hide_create_ro.Value)
        Dim create_shop As String = CP.rReplaceQuote(hide_create_shop.Value)

        Dim request_title_id As String = CP.rReplaceQuote(sel_title.selectedValue)
        Dim request_title As String = CP.rReplaceQuote(txt_request_title.Value)

        Dim account_number As String = CP.rReplaceQuote(txt_account_number.Value)
        Dim account_name As String = CP.rReplaceQuote(txt_account_name.Value)

        Dim amount As String = CP.rReplaceQuote(txt_amount.Value)
        Dim doc_number As String = CP.rReplaceQuote(txt_doc_number.Value).ToUpper()
        Dim bcs_number As String = CP.rReplaceQuote(txt_bcs_number.Value).ToUpper()
        Dim area_ro As String = CP.rReplaceQuote(hide_area_ro.Value)
        Dim shop_code As String = CP.rReplaceQuote(hide_province_short.Value)

        Dim account_number_to As String = CP.rReplaceQuote(txt_account_number_to.Value)
        Dim account_name_to As String = CP.rReplaceQuote(txt_account_name_to.Value)

        Dim redebt_cause_id As String = CP.rReplaceQuote(hide_redebt_cause.Value)
        Dim request_remark As String = CP.rReplaceQuote(txt_request_remark.Value)
        Dim pick_refund As String = CP.rReplaceQuote(hide_pick_refund.Value)

        Dim uemail_cc1 As String = CP.rReplaceQuote(txt_uemail_cc1.Value)
        Dim uemail_cc2 As String = CP.rReplaceQuote(txt_uemail_cc2.Value)
        Dim uemail_verify1 As String = CP.rReplaceQuote(hide_uemail_verify1.Value)
        Dim uemail_verify2 As String = CP.rReplaceQuote(hide_uemail_verify2.Value)
        Dim uemail_approve As String = CP.rReplaceQuote(hide_uemail_approve.Value)

        Dim dx01 As String = ""'CP.rReplaceQuote(txt_dx01.Value)
        Dim dx02 As String = CP.rReplaceQuote(txt_dx02.Value) 'วันที่ยกเลิก
        Dim dx03 As String = CP.rReplaceQuote(txt_dx03.Value) 'วันที่ลูกค้าขอลดหนี้

        Dim mx01 As String = CP.rReplaceQuote(txt_mx01.Value) 'คำนวณจาก
        Dim mx02 As String = ""'CP.rReplaceQuote(txt_mx02.Value)
        Dim mx03 As String = CP.rReplaceQuote(txt_mx03.Value) 'ชื่อบัญชี

        Dim tx01 As String = CP.rReplaceQuote(txt_tx01.Value) 'ลูกค้าต้องการคืนเงินเป็น
        Dim tx02 As String = ""'CP.rReplaceQuote(txt_tx02.Value) 'ไม่คืนเงินลูกค้า

        Dim fx01 As String = CP.rReplaceQuote(txt_fx01.Value) 'รหัสสาขาธนาคาร
        Dim fx02 As String = CP.rReplaceQuote(txt_fx02.Value) 'เลขที่บัญชี

        Dim nx01 As Integer = CP.rReplaceQuote(hide_bank_code.Value)

        ' ข้อมูลใบรับคืนอุปกรณ์และ ใบรับคืน Adapter
        Dim sx01 As String = hide_redoc_type.Value 
        Dim fx03 As String = CP.rReplaceQuote(txt_redoc_account_number_to.Value)
        Dim gx03 As String = CP.rReplaceQuote(txt_redoc_account_name_to.Value)
        Dim tx03 As String = CP.rReplaceQuote(txt_redoc_remark.Value)
        Dim gx01 As String = CP.rReplaceQuote(hide_redoc_no_item.Value)
        Dim gx02 As String = CP.rReplaceQuote(hide_redoc_no_adapter.Value)

        If sx01 = 0 Then
            fx03 = ""
            gx03 = ""
            tx03 = ""
        End If
        ' ข้อมูลใบรับคืนอุปกรณ์และ ใบรับคืน Adapter

        Dim specFile As Integer = 5

        CF.InsertRequest( _
            pageUrl, pageSubject_id, prefix_id _
            , flow_id, request_title_id, request_title _
            , request_remark, uemail_verify1, uemail_verify2, uemail_approve _
            , uemail_cc1, uemail_cc2, "", create_by _
            , create_ro, create_shop, pick_refund _
            , bcs_number, doc_number, amount _
            , account_number, account_name _
            , account_number_to, account_name_to _
            , redebt_cause_id, area_ro, shop_code _
            , dx01, dx02, dx03 _
            , mx01, mx02, mx03 _
            , tx01, tx02, tx03 _
            , fx01, fx02, fx03 _
            , nx01, 0, 0 _
            , sx01, 0, 0 _
            , "", "", specFile _
            , "", "", "" _
            , "", "", "" _
            , "", "", "" _
            , "", "", "" _
            , "", "", "" _
            , "", "", "" _
            , "", "" _
            , gx01, gx02, gx03 _
        )
    End Sub

    ' Public Sub InsertRequest(
    '     pageUrl, subject_id, prefix_id _
    '     , flow_id, request_title_id, request_title _
    '     , request_remark, uemail_verify1, uemail_verify2, uemail_approve _
    '     , uemail_cc1, uemail_cc2, uemail_ccv1, create_by  _
    '     , create_ro, create_shop, pick_refund _
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
    '     , byAjax, dx04, specFile _
    '     , ax01, ax02, ax03 _
    '     , ax04, ax05, ax06 _
    '     , ax07, ax08, ax09 _
    '     , ax10, ax11, ax12 _
    '     , ax13, ax14, ax15 _
    '     , ax16, ax17, ax18 _
    '     , ax19, ax20 _
    '     , gx01, gx02, gx03 _
    '     , gx04, gx05 _
    ' )
    ' End Sub
End Class
