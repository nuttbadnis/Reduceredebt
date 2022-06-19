Imports System.Data

Partial Class mode_approve_a
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu

    Dim tabSys As String = "a"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()

        If Session("Uemail") IsNot Nothing Then
            user_logon.InnerHtml = "<span class='glyphicon glyphicon-off user_logon' aria-hidden='true'></span> " + Session("Uemail")
            
            hide_token.Value() = Session("token")
            hide_udepart.Value() = CP.userDepartment(Session("Uemail"))
            hide_group_email.Value() = CP.userGroupEmail(Session("Uemail"))
            hide_uemail.Value() = Session("Uemail")
            
            hide_depart_approve.Value() = CP.checkDepartApprove()
            hide_pushpin.Value() = CP.getSettingTabPin()
            hide_tabsys.Value() = tabSys
        End If

        CP.checkLogin()
        CP.Analytics()
    End Sub

    Sub Save_Pushpin(ByVal Source As Object, ByVal E As EventArgs)
        CP.savePushpin(tabSys)
    End Sub
End Class
