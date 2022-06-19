Imports System.IO
Imports System.Data

Partial Class new_backof30_api
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DB106 As New Cls_Data
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Dim pageUrl As String = "backof30"
    Dim pageSubject_id As String = 1401001

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.Form("uemail") <> Nothing Then
            Session("Uemail") = Request.Form("uemail")
            Session("token") = Request.Form("token")

            Submit_ShopStock()
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
        Dim create_ro As String = Request.Form("ro")
        Dim create_shop As String = CP.rReplaceQuote(Request.Form("shop_code").ToUpper())

        Dim request_title_id As String = "61"
        Dim request_title As String = "ขออนุมัติเปลี่ยนแปลงข้อมูลสำนักงาน"

        Dim fx01 As String = CP.rReplaceQuote(Request.Form("shop_code").ToUpper())
        Dim area_ro As String = Request.Form("ro")
        Dim shop_code As String = Request.Form("province_short")

        Dim uemail_cc1 As String = CP.rReplaceQuote(Request.Form("uemail_cc1"))
        Dim uemail_cc2 As String = CP.rReplaceQuote(Request.Form("uemail_cc2"))
        Dim uemail_verify1 As String = CP.rReplaceQuote(Request.Form("uemail_verify1"))

        Dim tx01 As String = CP.rReplaceConvertHTML(Request.Form("tx01"))
        Dim tx02 As String = CP.rReplaceConvertHTML(Request.Form("tx02"))

        ' Response.Write(tx01)
        CF.InsertRequest( _
            pageUrl, pageSubject_id, prefix_id _
            , flow_id, request_title_id, request_title _
            , "", uemail_verify1, "", "" _
            , uemail_cc1, uemail_cc2, "", create_by _
            , create_ro, create_shop, "" _
            , "", "", "" _
            , "", "" _
            , "", "" _
            , "", area_ro, shop_code _
            , "", "", "" _
            , "", "", "" _
            , tx01, tx02, "" _
            , fx01, "", "" _
            , 0, 0, 0 _
            , 0, 0, 0 _
            , "ajax", "" _
        )
    End Sub
End Class
