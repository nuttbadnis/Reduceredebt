
Partial Class master_request
    Inherits System.Web.UI.MasterPage
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()
        CP.checkLogin()

        If Session("Uemail") IsNot Nothing Then
            user_logon.InnerHtml = "<span class='glyphicon glyphicon-off user_logon' aria-hidden='true'></span> " + Session("Uemail")
        End If
    End Sub
End Class

