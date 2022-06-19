Imports System.Data

Partial Class link_newbcs2
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()
        CP.checkLogin()
        CP.Analytics()

        ' Dim vURL As String = "new_redebt26.aspx?subject_id=1002601"
        Dim vURL As String = "new_redebt228.aspx?subject_id=702001"

        If Request.QueryString("bcs_receipt") <> Nothing Then
            vURL = vURL & "&bcs_receipt=" & Request.QueryString("bcs_receipt")
        End If

        Response.Redirect(vURL)
    End Sub
End Class
