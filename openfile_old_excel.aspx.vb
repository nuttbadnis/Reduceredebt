Partial Class openfile_old_excel
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.Analytics()
        Response.Redirect("file/แบบฟอร์มขอเปิดไฟล์เอกสาร.xlsx")
    End Sub
End Class
