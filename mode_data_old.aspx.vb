Imports System.Data

Partial Class mode_data_old
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
            webtest.Href = "https://posbcs.triplet.co.th/FRTest/login.aspx?token=" + Session("token")
        End If

        CP.checkLogin()
        CP.Analytics()
        
        ' If CP.checkModeApprove() > 0 Then
        '     If CP.checkSettingModeData() = 0 Then
        '         Page.ClientScript.RegisterStartupScript(Me.GetType(), "alertscript", "settingModeApprove();", True)
        '     End If
        ' End If
    End Sub

    Sub Save_Setting(ByVal Source As Object, ByVal E As EventArgs)
        Dim vSqlIn As String
        vSqlIn = "delete from setting_mode where uemail = '" & Session("Uemail") & "' "
        vSqlIn += "insert into setting_mode (uemail, mode_data) values ('" & Session("Uemail") & "', 1) "

        If DB105.ExecuteNonQuery(vSqlIn).ToString() >= 1 Then
            Response.Redirect(Page.Request.Url.ToString())
        End If
    End Sub
End Class
