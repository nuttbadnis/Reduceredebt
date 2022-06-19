Imports System.Data

Partial Class _Default
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()
        
        If Request.QueryString("code") <> Nothing Then
            Session("Uemail") = CP.SetOAuthSingleSignOn(Request.QueryString("code"))
            
            If Session("current_url") <> Nothing Then
                Response.Redirect(Session("current_url"))
            Else
                Response.Redirect("~/default.aspx")
            End If
        End If

         CP.checkLogin()

         checkError()
    End Sub

    Protected Sub checkError()
        Dim vError As String = Request.QueryString("error")
        
        If vError <> Nothing Then
            Dim vTxtAlert As String = "Page Failed!!"

            If vError = "nopermiss" Then
                vTxtAlert = "No Permission!!"
            Else If vError = "pagefailed" Then
                vTxtAlert = "Page Failed!!"
            Else If vError = "norequest" Then
                vTxtAlert = "No Request!!"
            End If

            Page.ClientScript.RegisterStartupScript(Me.GetType(), "alertscript", "alert('" + vTxtAlert + "'); window.location = 'default.aspx';", True)
        Else
            CP.stampPatchUserFirstCome()

            If CP.checkDepartApprove() > 0 Then
                If CP.checkSettingModeData() > 0 Then
                    Response.Redirect("~/mode_data.aspx")
                End If

                Response.Redirect("~/mode_approve.aspx")
            Else

                Response.Redirect("~/mode_data.aspx")
            End If
        End If
    End Sub
End Class
