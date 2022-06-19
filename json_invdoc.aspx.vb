Imports System.Data
Imports System.Web.Script.Serialization
Imports System.Collections.Generic

Partial Class json_invdoc
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim qrs As String = ""

        If Request.QueryString("qrs") <> Nothing Then
            qrs = Request.QueryString("qrs")
        End If

        If qrs = "loadItemUnit" Then
            loadItemUnit()
        End If

        If qrs = "loadItemInvdoc" Then
            loadItemInvdoc()
        End If

        If qrs = "insertItemInvdoc" Then
            insertItemInvdoc()
        End If

        If qrs = "deleteItemInvdoc" Then
            deleteItemInvdoc()
        End If

        If qrs = "getItemInvdoc" Then
            getItemInvdoc()
        End If

        If qrs = "getItemTotalAmount" Then
            getItemTotalAmount()
        End If

        If qrs = "updateItemTotalAmount" Then
            updateItemTotalAmount()
        End If

    End Sub

    Protected Sub loadItemUnit()
        Dim vSql As String = "select item_invdoc_unit_id, item_invdoc_unit_th, item_invdoc_unit_en "
        vSql += "from item_invdoc_unit "
        vSql += "where disable = 0"

        ' Response.Write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadItemInvdoc()
        Dim ref_number As String = Request.QueryString("ref_number")

        Dim vSql As String = "exec SP_load_item_invdoc '" & ref_number & "' "

        ' Response.Write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub insertItemInvdoc()
        Dim xCreate_by As String = Request.Form("create_by")

        Dim item_id As String = Request.Form("item_id")
        Dim ref_number As String = Request.Form("ref_number")
        Dim request_id As String = Request.Form("request_id")
        Dim item_name As String = Request.Form("item_name")
        Dim item_unit_qty As String = Request.Form("item_unit_qty")
        Dim item_unit_price As String = Request.Form("item_unit_price")
        Dim item_amount As String = Request.Form("item_amount")
        Dim account_code As String = Request.Form("account_code")
        Dim item_unit_id As String = Request.Form("item_unit_id")

        Dim vSqlIn As String = "exec SP_insert_item_invdoc '" & item_id & "', '" & ref_number & "', '" & request_id & "', '" & item_name & "', '" & item_unit_qty & "', '" & item_unit_id & "', '" & item_unit_price & "', '" & item_amount & "', '" & account_code & "', '" & xCreate_by & "' "

        ' Response.Write(vSqlIn)
        Response.Write(DB105.ExecuteNonQuery(vSqlIn).ToString())
    End Sub

    Protected Sub deleteItemInvdoc()
        Dim xUpdate_by As String = Request.Form("update_by")
        Dim item_id As String = Request.Form("item_id")

        Dim vSqlIn As String = "exec SP_delete_item_invdoc '" & item_id & "', '" & xUpdate_by & "' "

        ' Response.Write(vSqlIn)
        Response.Write(DB105.ExecuteNonQuery(vSqlIn).ToString())
    End Sub

    Protected Sub getItemInvdoc()
        Dim item_id As String = Request.QueryString("item_id")

        Dim vSql As String = "exec SP_get_item_invdoc '" & item_id & "' "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub getItemTotalAmount()
        Dim request_id As String = Request.QueryString("request_id")
        Dim item_amount_sum As String = Request.QueryString("item_amount_sum")
        Dim item_amount_vat As String = Request.QueryString("item_amount_vat")

        Dim vSql As String = "exec SP_get_item_total_amount '" & request_id & "', '" & item_amount_sum & "', '" & item_amount_vat & "' "

        ' Response.Write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub updateItemTotalAmount()
        Dim xCreate_by As String = Request.Form("create_by")

        Dim request_id As String = Request.Form("request_id")
        Dim item_amount_sum As String = Request.Form("item_amount_sum")
        Dim item_amount_vat As String = Request.Form("item_amount_vat")

        Dim vSqlIn As String = "exec SP_update_item_total_amount '" & request_id & "', '" & item_amount_sum & "', '" & item_amount_vat & "', '" & xCreate_by & "' "

        ' Response.Write(vSqlIn)
        Response.Write(DB105.ExecuteNonQuery(vSqlIn).ToString())
    End Sub

End Class
