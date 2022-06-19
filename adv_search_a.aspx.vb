Imports System.Data

Partial Class adv_search_a
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()

        If Session("Uemail") IsNot Nothing Then
            hide_today.Value() = Today
            hide_token.Value() = Session("token")
            hide_udepart.Value() = CP.userDepartment(Session("Uemail"))
            hide_group_email.Value() = CP.userGroupEmail(Session("Uemail"))
            hide_uemail.Value() = Session("Uemail")
            user_logon.InnerHtml = "<span class='glyphicon glyphicon-off user_logon' aria-hidden='true'></span> " + Session("Uemail")
            webtest.Href = "https://posbcs.triplet.co.th/FRTest/login.aspx?token=" + Session("token")
        End If

        CP.checkLogin()
        CP.Analytics()
    End Sub
End Class
