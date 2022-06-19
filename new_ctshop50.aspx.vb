Imports System.IO
Imports System.Data

Partial Class new_ctshop50
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DBShopStock As New Cls_DataShopStock
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Dim pageUrl As String = "ctshop50"
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
            hide_page_url.Value() = pageUrl
            hide_min_cost.Value() = vDT.Rows(0).Item("min_cost")
            hide_max_cost.Value() = vDT.Rows(0).Item("max_cost")
            project_name.InnerHtml = vDT.Rows(0).Item("project_name")
            subject_name.InnerHtml = vDT.Rows(0).Item("subject_prefix") + ". " + vDT.Rows(0).Item("subject_name")
            subject_desc.InnerHtml = vDT.Rows(0).Item("subject_desc")

            '''''''''''''''''''''''''''''''''''''''''''''''' Load Title ''''''''''''''''''''''''''''''''''''''''''''''''
            vSql = CF.rSqlDDTitle(pageSubject_id)
            DB105.SetDropDownList(sel_title, vSql, "request_title", "request_title_id", "เลือกเรื่องที่แจ้ง")
            '''''''''''''''''''''''''''''''''''''''''''''''' Load Title ''''''''''''''''''''''''''''''''''''''''''''''''

            vSql = CF.rSqlDDRO()
            DB105.SetDropDownList(sel_create_ro, vSql, "ro_title", "ro_value", "เลือก RO ผู้สร้างคำขอ")

            'vSql = CF.rSqlDDstorePlaceType()
            'DBShopStock.SetDropDownList(sel_placetype, vSql, "storeplacetype_name", "storeplacetype_id", "เลือกประเภทพื้นที่")
            
            ' vSql = CF.rSqlDDcontractPhase()
            ' DBShopStock.SetDropDownList(sel_ctphase, vSql, "phase_title", "phase_id", "เลือกอายุสัญญา")
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

        Dim amount As String = ""'CP.rReplaceQuote(txt_amount.Value)
        Dim area_ro As String = CP.rReplaceQuote(txt_area_ro.Value)
        Dim shop_code As String = CP.rReplaceQuote(hide_province_short.Value)

        Dim request_remark As String = ""'CP.rReplaceQuote(txtar_request_remark.Value)

        Dim uemail_cc1 As String = CP.rReplaceQuote(txt_uemail_cc1.Value)
        Dim uemail_cc2 As String = CP.rReplaceQuote(txt_uemail_cc2.Value)
        Dim uemail_verify1 As String = CP.rReplaceQuote(hide_uemail_verify1.Value)
        Dim uemail_verify2 As String = CP.rReplaceQuote(hide_uemail_verify2.Value)
        Dim uemail_approve As String = CP.rReplaceQuote(hide_uemail_approve.Value)

        Dim tx01 As String = ""'CP.rReplaceQuote(txtar_location.Value)
        Dim tx02 As String = ""'CP.rReplaceQuote(txtar_tx02.Value)
        Dim tx03 As String = ""'CP.rReplaceQuote(txtar_tx03.Value)

        Dim fx01 As String = CP.rReplaceQuote(hide_shop_code.Value)
        Dim fx02 As String = CP.rReplaceQuote(txt_cluster.Value)
        Dim fx03 As String = ""'CP.rReplaceQuote(hide_ctphase.Value)

        Dim mx01 As String = 0'CP.rReplaceQuote(hide_elecharge_unit.Value)
        Dim mx02 As String = 0'CP.rReplaceQuote(txt_ctphase_remark.Value)
        Dim mx03 As String = CP.rReplaceQuote(txt_decoration_fee.Value)

        Dim nx01 As String = 0'CP.rReplaceQuote(txt_nx01.Value)
        Dim nx02 As String = 0'CP.rReplaceQuote(txt_nx02.Value)
        Dim nx03 As String = 0'CP.rReplaceQuote(txt_nx03.Value)

        Dim sx01 As String = 0'CP.rReplaceQuote(hide_placetype.Value)
        Dim sx02 As String = 0'CP.rReplaceQuote(txt_sx02.Value)
        Dim sx03 As String = 0'CP.rReplaceQuote(txt_sx03.Value)

        Dim ax01 As String = ""'CP.rReplaceQuote(txt_ax01.Value)
        Dim ax02 As String = ""'CP.rReplaceQuote(txt_ax02.Value)
        Dim ax03 As String = ""'CP.rReplaceQuote(txt_ax03.Value)
        Dim ax04 As String = ""'CP.rReplaceQuote(txt_uprent_rate.Value)
        Dim ax05 As String = ""'CP.rReplaceQuote(txt_ax05.Value)
        Dim ax06 As String = ""'CP.rReplaceQuote(txt_ax06.Value)
        Dim ax07 As String = ""'CP.rReplaceQuote(txt_ax07.Value)
        Dim ax08 As String = ""'CP.rReplaceQuote(txt_ax08.Value)
        Dim ax09 As String = ""'CP.rReplaceQuote(txt_ax09.Value)
        Dim ax10 As String = ""'CP.rReplaceQuote(txt_ax10.Value)
        Dim ax11 As String = ""'CP.rReplaceQuote(txt_ax11.Value)
        Dim ax12 As String = ""'CP.rReplaceQuote(txt_ax12.Value)
        Dim ax13 As String = ""'CP.rReplaceQuote(txt_ax13.Value)
        Dim ax14 As String = ""'CP.rReplaceQuote(txt_ax14.Value)
        Dim ax15 As String = ""'CP.rReplaceQuote(txt_ax15.Value)
        Dim ax16 As String = ""'CP.rReplaceQuote(txt_ax15.Value)
        Dim ax17 As String = ""'CP.rReplaceQuote(txt_ax15.Value)
        Dim ax18 As String = CP.rReplaceQuote(txt_ax18.Value)
        Dim ax19 As String = CP.rReplaceQuote(txt_ax19.Value)
        Dim ax20 As String = CP.rReplaceQuote(txt_ax20.Value)

        Dim gx01 As String = CP.rReplaceQuote(txt_gx01.Value)

        Dim specFile As Integer = 15

        CF.InsertRequest( _
            pageUrl, pageSubject_id, prefix_id _
            , flow_id, request_title_id, request_title _
            , request_remark, uemail_verify1, uemail_verify2, uemail_approve _
            , uemail_cc1, uemail_cc2, "", create_by _
            , create_ro, create_shop, "" _
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
            , "", "", specFile _
            , ax01, ax02, ax03 _
            , ax04, ax05, ax06 _
            , ax07, ax08, ax09 _
            , ax10, ax11, ax12 _
            , ax13, ax14, ax15 _
            , ax16, ax17, ax18 _
            , ax19, ax20, gx01 _
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
    ' )
    ' End Sub
End Class
