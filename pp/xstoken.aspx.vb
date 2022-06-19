Partial Class xstoken
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.QueryString("token") <> Nothing Then
            Session("token") = Request.QueryString("token")
        End If

        Response.Write(Session("token"))
    End Sub
End Class

