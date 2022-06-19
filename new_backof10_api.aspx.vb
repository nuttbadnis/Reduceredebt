Imports System.IO
Imports System.Data

Partial Class new_backof10_api
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DB106 As New Cls_Data
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Dim pageUrl As String = "backof10"
    Dim pageSubject_id As String = 911001

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.Form("uemail") <> Nothing Then
            Session("Uemail") = Request.Form("uemail")
            Session("token") = Request.Form("token")

            Submit_ShopStock()

            ' Dim vSql As String 
            ' Dim vDT As New DataTable
            ' vDT = CF.rLoadSubject(pageSubject_id, pageUrl)

            ' Me.Page.Title = "+ " + vDT.Rows(0).Item("subject_prefix") + ". " + vDT.Rows(0).Item("subject_name") + " [" + Me.Page.Title + "]"

            ' hide_flow_id.Value() = vDT.Rows(0).Item("flow_id")
            ' hide_prefix_id.Value() = vDT.Rows(0).Item("prefix_id")
            ' project_name.InnerHtml = vDT.Rows(0).Item("project_name")
            ' subject_name.InnerHtml = vDT.Rows(0).Item("subject_prefix") + ". " + vDT.Rows(0).Item("subject_name")
            ' subject_desc.InnerHtml = vDT.Rows(0).Item("subject_desc")

            ' '''''''''''''''''''''''''''''''''''''''''''''''' Load Title ''''''''''''''''''''''''''''''''''''''''''''''''
            ' vSql = CF.rSqlDDTitle(pageSubject_id)
            ' DB105.SetDropDownList(sel_title, vSql, "request_title", "request_title_id", "เลือกเรื่องที่แจ้ง")
            ' '''''''''''''''''''''''''''''''''''''''''''''''' Load Title ''''''''''''''''''''''''''''''''''''''''''''''''

            ' vSql = CF.rSqlDDRO()
            ' DB105.SetDropDownList(sel_create_ro, vSql, "ro_title", "ro_value", "เลือก RO ผู้สร้างคำขอ")
        Else
            ' Response.Write("error!!!")
        End If

        CP.Analytics()
    End Sub

    Sub Submit_ShopStock()
        Dim vSql As String 
        Dim vDT As New DataTable
        vDT = CF.rLoadSubject(pageSubject_id, pageUrl)

        Dim flow_id As String = vDT.Rows(0).Item("flow_id")
        Dim prefix_id As String = vDT.Rows(0).Item("prefix_id")
        Dim create_by As String = Request.Form("uemail")
        Dim create_ro As String = Request.Form("ro") 'CP.rReplaceQuote(hide_create_ro.Value)
        Dim create_shop As String = CP.rReplaceQuote(Request.Form("shop_code").ToUpper()) 'CP.rReplaceQuote(hide_create_shop.Value)

        Dim request_title_id As String = "58" 'CP.rReplaceQuote(sel_title.selectedValue)
        Dim request_title As String = "ขออนุมัติปิดสำนักงานชั่วคราว เป็นกรณีพิเศษ" 'CP.rReplaceQuote(txt_request_title.Value)

        Dim fx01 As String = CP.rReplaceQuote(Request.Form("shop_code").ToUpper()) 'CP.rReplaceQuote(hide_select_shop.Value)
        Dim area_ro As String = Request.Form("ro") 'CP.rReplaceQuote(hide_area_ro.Value)
        Dim shop_code As String = Request.Form("province_short") 'CP.rReplaceQuote(hide_province_short.Value)

        Dim tx01 As String = CP.rReplaceQuote(Request.Form("note_desc")) 'หมายเหตุ '
        Dim request_remark As String = CP.rReplaceQuote(Request.Form("explain_desc")) 'คำอธิบายชี้แจง CP.rReplaceQuote(txt_request_remark.Value)

        Dim uemail_cc1 As String = CP.rReplaceQuote(Request.Form("uemail_cc1")) 'CP.rReplaceQuote(txt_uemail_cc1.Value)
        Dim uemail_cc2 As String = CP.rReplaceQuote(Request.Form("uemail_cc2")) 'CP.rReplaceQuote(txt_uemail_cc2.Value)
        Dim uemail_verify1 As String = CP.rReplaceQuote(Request.Form("uemail_verify1")) 'CP.rReplaceQuote(hide_uemail_verify1.Value)
        Dim uemail_verify2 As String = CP.rReplaceQuote(Request.Form("uemail_verify2")) 'CP.rReplaceQuote(hide_uemail_verify2.Value)
        Dim uemail_approve As String = CP.rReplaceQuote(Request.Form("uemail_approve")) 'CP.rReplaceQuote(hide_uemail_approve.Value)

        Dim mx01 As String = CP.rReplaceQuote(Request.Form("mx01"))

        Dim dx01 As String = dateYearTH(Request.Form("dx01"))
        Dim dx02 As String = dateYearTH(Request.Form("dx02"))
        Dim dx03 As String = dateYearTH(Request.Form("dx03"))
        Dim dx04 As String = dateYearTH(Request.Form("dx04"))

        CF.InsertRequest( _
            pageUrl, pageSubject_id, prefix_id _
            , flow_id, request_title_id, request_title _
            , request_remark, uemail_verify1, uemail_verify2, uemail_approve _
            , uemail_cc1, uemail_cc2, "", create_by _
            , create_ro, create_shop, "" _
            , "", "", "" _
            , "", "" _
            , "", "" _
            , "", area_ro, shop_code _
            , dx01, dx02, dx03 _
            , mx01, "", "" _
            , tx01, "", "" _
            , fx01, "", "" _
            , 0, 0, 0 _
            , 0, 0, 0 _
            , "ajax", dx04 _
        )

        ' CF.InsertRequest( _
        '     "", "", "" _
        '     , "", "", "" _
        '     , "", "", "", "" _
        '     , "", "", "", "" _
        '     , "", "", "" _
        '     , "", "", "" _
        '     , "", "" _
        '     , "", "" _
        '     , "", "", "" _
        '     , "", "", "" _
        '     , "", "", "" _
        '     , "", "", "" _
        '     , "", "", "" _
        '     , "", "ajax" _
        ' )
    End Sub

    Public Function dateYearTH(ByVal dxdt As String) As String
        If dxdt.Trim().Length = 10 Then
            ' Return "DATEADD(YEAR,-543,CONVERT(DATETIME,'" & dxdt & "',103)) "
            Return "dbo.dateTH2EN('" & dxdt & "') "
        Else 
            Return "NULL "
        End If
    End Function
End Class
