Imports System.Data

Partial Class mode_data
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()

        If Session("Uemail") IsNot Nothing Then
            hide_token.Value() = Session("token")
            hide_udepart.Value() = CP.userDepartment(Session("Uemail"))
            hide_group_email.Value() = CP.userGroupEmail(Session("Uemail"))
            hide_uemail.Value() = Session("Uemail")
            user_logon.InnerHtml = "<span class='glyphicon glyphicon-off user_logon' aria-hidden='true'></span> " + Session("Uemail")
        End If

        CP.checkLogin()

        Dim vThisMode As Integer = 1

        If CP.checkDepartApprove() > 0 Then
            If CP.checkSettingModeData() = 0 Then
                vThisMode = 0
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "alertscript", "settingModeApprove();", True)
            End If
        End If

        If vThisMode = 1 Then
            gotoTabPin()
        End If
    End Sub

    Sub Setting_Mode(ByVal Source As Object, ByVal E As EventArgs)
        Dim vSqlIn As String
        vSqlIn = "delete from setting_mode where uemail = '" & Session("Uemail") & "' "
        vSqlIn += "insert into setting_mode (uemail, mode_data) values ('" & Session("Uemail") & "', 1) "

        If DB105.ExecuteNonQuery(vSqlIn).ToString() >= 1 Then
            Response.Redirect(Page.Request.Url.ToString())
        End If
    End Sub

    Sub Setting_Skip(ByVal Source As Object, ByVal E As EventArgs)
        gotoTabPin()
    End Sub

    Sub gotoTabPin()
        Dim vRedirect As String = Page.Request.Url.ToString()
        Dim vTab As String = CP.getSettingTabPin()

        If vTab <> "" Then
            vRedirect = vRedirect.Replace("mode_data.aspx", "mode_data_" & vTab & ".aspx")
        Else
            vRedirect = vRedirect.Replace("mode_data.aspx", "mode_data_all.aspx")
        End If

        Response.Redirect(vRedirect)
    End Sub
End Class
