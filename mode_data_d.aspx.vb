Imports System.Data

Partial Class mode_data_d
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu

    Dim tabSys As String = "d"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()

        If Session("Uemail") IsNot Nothing Then
            user_logon.InnerHtml = "<span class='glyphicon glyphicon-off user_logon' aria-hidden='true'></span> " + Session("Uemail")
            
            hide_token.Value() = Session("token")
            hide_udepart.Value() = CP.userDepartment(Session("Uemail"))
            hide_group_email.Value() = CP.userGroupEmail(Session("Uemail"))
            hide_uemail.Value() = Session("Uemail")
            
            hide_pushpin.Value() = CP.getSettingTabPin()
            hide_tabsys.Value() = tabSys
            webtest.Href = "https://posbcs.triplet.co.th/FRTest/login.aspx?token=" + Session("token")
        End If

        CP.checkLogin()
        CP.Analytics()
    End Sub

    Sub Save_Pushpin(ByVal Source As Object, ByVal E As EventArgs)
        CP.savePushpin(tabSys)
    End Sub
End Class
