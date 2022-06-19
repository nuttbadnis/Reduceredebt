
Partial Class _maintenance
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Response.Write("ขออภัย ปิดปรับปรุงระบบชั่วคราว")
        CP.Analytics()
    End Sub
End Class
