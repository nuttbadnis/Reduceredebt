Partial Class xmanual_user
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.Analytics()
        Response.Redirect("file/Manual_Follow_Request_[USER]v171024.pdf")
    End Sub
End Class
