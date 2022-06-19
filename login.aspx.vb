Partial Class login
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Session().Clear()
        ' Response.Write("Session(Uemail) = " & Session("Uemail"))
        ' Response.Write("Session(token) = " & Session("token"))

        If Session("Uemail") <> Nothing And Session("token") <> Nothing Then
            Response.Redirect("~/default.aspx")
        End If

        If Request.QueryString("token") <> Nothing And Request.QueryString("token") <> "" Then
            Session("token") = Request.QueryString("token") 
            Response.Redirect("~/login.aspx")
        End If

        If Request.QueryString("Uemail") <> Nothing And Request.QueryString("Uemail") <> "" Then
            Session("Uemail") = Request.QueryString("Uemail") 
            Response.Redirect("~/login.aspx")
        End If

        If Session("token") <> Nothing Or Session("token") <> "" Then
            token_ex.Style.Add("display", "none")
        Else
            Session().Clear()
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "alertscript", "alert('Token หมดอายุไม่สามารถใช้ WebTest ได้ กรุณากลับไปคลิกเมนู WebTest จากเว็บ Follow Request');", True)
        End If

        CP.Analytics()
    End Sub
End Class
