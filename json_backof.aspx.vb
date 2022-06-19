Imports System.Data
Imports System.Web.Script.Serialization
Imports System.Collections.Generic

Partial Class json_backof
    Inherits System.Web.UI.Page
    Dim DB106 As New Cls_Data
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim qrs As String = ""

        If Request.QueryString("qrs") <> Nothing Then
            qrs = Request.QueryString("qrs")
        End If

        If qrs = "loadShopStock" Then
            loadShopStock()
        End If

        If qrs = "getProvinceShort" Then
            getProvinceShort()
        End If

        If qrs = "getRequest" Then
            getRequest()
        End If

    End Sub

    Protected Sub loadShopStock()
        Dim xRo As String = Request.QueryString("ro")

        Dim vSql As String = "select shop_code, shop_name, shop_code + ': ' + shop_name shop_label "
        vSql += "from shopStock.dbo.shopStock "
        vSql += "where delete_date IS NULL and dis_3bb_shop = 0 "
        vSql += "order by shop_code "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub getProvinceShort()
        Dim vSql As String = "select ro, shop_code, shop_name, province_short, province_name "
        vSql += "from RMSDAT.dbo.vw_branch_shop "
        vSql += "where shop_code = '" + Request.QueryString("shop_code") + "' "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub getRequest()
        Dim xRequest_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select request_id, subject_prefix, request_title_dim.request_title, request_remark "
        vSql += ",request.create_by + ' (RO' + create_ro + ')' create_by "
        vSql += ",convert(varchar(10), request.create_date, 103) create_date "
        vSql += ",convert(varchar(10), dx01, 103) dx01 "
        vSql += ",convert(varchar(10), dx02, 103) dx02 "
        vSql += ",convert(varchar(10), dx03, 103) dx03 "
        vSql += ",convert(varchar(10), dx04, 103) dx04 "
        vSql += ",fx01 + ' ' + shop_name shop_name, mx01, tx01, tx02 "
        vSql += ",request.shop_code + ' ' + province_name + ' (RO' + area_ro + ')' province_name "
        vSql += "from request "

        vSql += "left join RMSDAT.dbo.vw_branch_shop vw "
        vSql += "on vw.shop_code = request.fx01 "

        vSql += "left join request_title_dim "
        vSql += "on request_title_dim.request_title_id = request.request_title_id "

        vSql += "left join subject_dim "
        vSql += "on subject_dim.subject_id = request_title_dim.subject_id "

        vSql += "where request_id = '" & xRequest_id & "' "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

End Class
