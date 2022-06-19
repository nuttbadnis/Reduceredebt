Imports System.Data

Partial Class update_user_detail
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("go") <> Nothing Then
            update_user_detail()
        Else
            Response.Write("parameter go")
        End If
    End Sub

    Sub update_user_detail()
        Dim vToken As String = Session("token")
        Response.Write("token = " & vToken)
        Response.Write("<br>")
        Response.Write("<br>")

        Dim vDT_EMP,vDT_OAUTH As New DataTable

        Dim vSql As String = "select uemail from depart_user_detail "

        If Request.QueryString("new") <> Nothing Then
            vSql += "where jas_employeeId = '' "
        End If

        vDT_EMP = DB105.GetDataTable(vSql)

        For i1 As Integer = 0 To vDT_EMP.Rows().Count() - 1
            vDT_OAUTH = CP.rGetDataOAuthDT(vDT_EMP.Rows(i1).Item("uemail"), vToken)

            If vDT_OAUTH.Rows.Count > 0 Then
                For i2 As Integer = 0 To vDT_OAUTH.Rows.Count - 2
                    If vDT_EMP.Rows(i1).Item("uemail") & "@jasmine.com" = vDT_OAUTH.Rows(i2).Item("email") _
                    AND (vDT_OAUTH.Rows(i2).Item("dateExpired") = "" Or vDT_OAUTH.Rows(i2).Item("dateExpired") = "null") _
                    And vDT_OAUTH.Rows(i2).Item("accountStatus") = "true" Then

            ' If vDT_OAUTH.Rows.Count > 0 Then
            '     For i2 As Integer = 0 To vDT_OAUTH.Rows.Count - 2
            '         If (vDT_OAUTH.Rows(i2).Item("dateExpired") = "" Or vDT_OAUTH.Rows(i2).Item("dateExpired") = "null") _
            '         And vDT_OAUTH.Rows(i2).Item("accountStatus") = "true" Then

                        Dim vSqlIn As String = "update depart_user_detail set "
                        vSqlIn += "jas_employeeId = '" & vDT_OAUTH.Rows(i2).Item("employeeId") & "' "
                        vSqlIn += ", jas_thaiFullname = '" & vDT_OAUTH.Rows(i2).Item("thaiFullname") & "' "
                        vSqlIn += ", jas_engFullname = '" & vDT_OAUTH.Rows(i2).Item("engFullname") & "' "
                        vSqlIn += ", jas_position = '" & vDT_OAUTH.Rows(i2).Item("position") & "' "
                        vSqlIn += ", jas_department = '" & vDT_OAUTH.Rows(i2).Item("department") & "' "
                        vSqlIn += "where uemail = '" & vDT_EMP.Rows(i1).Item("uemail") & "' "

                        Response.Write("email = " & vDT_OAUTH.Rows(i2).Item("email"))
                        Response.Write("<br>")
                        Response.Write("employeeId = " & vDT_OAUTH.Rows(i2).Item("employeeId"))
                        Response.Write("<br>")
                        Response.Write("thaiFullname = " & vDT_OAUTH.Rows(i2).Item("thaiFullname"))
                        Response.Write("<br>")
                        Response.Write("engFullname = " & vDT_OAUTH.Rows(i2).Item("engFullname"))
                        Response.Write("<br>")
                        Response.Write("position = " & vDT_OAUTH.Rows(i2).Item("position"))
                        Response.Write("<br>")
                        Response.Write("department = " & vDT_OAUTH.Rows(i2).Item("department"))
                        ' Response.Write("<br>")
                        ' Response.Write("dateExpired = " & vDT_OAUTH.Rows(i2).Item("dateExpired"))
                        ' Response.Write("<br>")
                        ' Response.Write("accountStatus = " & vDT_OAUTH.Rows(i2).Item("accountStatus"))

                        If DB105.ExecuteNonQuery(vSqlIn).ToString() >= 1 Then
                            Response.Write("<br>")
                            Response.Write("update success!!")
                        End If
                        Response.Write("<br>")
                        Response.Write("<br>")
                    End If
                Next
            End If
        Next
    End Sub
End Class
