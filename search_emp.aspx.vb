Imports System.Data
Imports System.Web.Script.Serialization
Imports System.Collections.Generic

Partial Class search_emp
    Inherits System.Web.UI.Page
    Dim DB106 As New Cls_Data
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        autoEmp()
    End Sub

    Protected Sub autoEmp()
        Dim xKeyword As String = Request.QueryString("kw")
        Dim xToken As String = Request.QueryString("token")

        Dim vJson As String = CP.rGetDataOAuthjson(xKeyword, xToken)
        Dim vJson_addon As String = ""

        'Add Group email'
        ' If xKeyword <> Nothing Then
        '     ' Dim vSql As String = "select depart_name thaiFullname, depart_name engFullname "
        '     ' vSql += ", group_email + '@jasmine.com' email "
        '     ' vSql += ", 'Group Email' position, depart_desc department "
        '     ' vSql += "from department "
        '     ' vSql += "where group_email is not null and LTRIM(RTRIM(group_email)) <> '' "
        '     ' vSql += "and ( "
        '     ' vSql += "depart_name like '%" + xKeyword + "%' or "
        '     ' vSql += "depart_desc like '%" + xKeyword + "%' or "
        '     ' vSql += "group_email like '%" + xKeyword + "%' or "
        '     ' vSql += "'Group Email' like '%" + xKeyword + "%' "
        '     ' vSql += ") "

        '     ' Dim vDT As New DataTable
        '     ' vDT = DB105.GetDataTable(vSql)

        '     ' vJson_addon = CP.rConvertDataTableToJSONv1(vDT)
        '     ' ' Response.Write(vSql)
        ' End If

        ' If vJson.Length > 2 Then
        '     If vJson_addon.Length > 2 Then
        '         vJson = vJson.Remove(vJson.Length - 1, 1)
        '         vJson += "," + vJson_addon.Remove(0, 1)
        '     End If
        ' Else
        '     vJson = vJson_addon
        ' End If
        'Add Group email'

        Response.Write(vJson)
    End Sub

End Class
