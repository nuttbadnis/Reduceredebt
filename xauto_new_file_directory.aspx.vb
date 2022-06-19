
Partial Class xauto_new_file_directory
    Inherits System.Web.UI.Page
    Dim CUL As New Cls_UploadFile
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CUL.rAutoCreateDirectory()
        CP.Analytics()
    End Sub
End Class
