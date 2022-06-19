
Partial Class update_checkend
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim xRequest_id As String = Request.QueryString("request_id")

        If xRequest_id <> Nothing Then
            Dim check_end As Integer = CF.rCheckEndFlow(xRequest_id)
            Dim vCase As String = ""
            Dim vAlert_Mss As String = ""   

            If check_end = 1 Then
                vCase = "End_Flow"
                vAlert_Mss = "ถึงลำดับสุดท้ายแล้ว ทำการปิดคำขออัตโนมัติ และส่งอีเมล์แจ้งผู้สร้างคำขอ"
            End If

            CF.SendMailSubmitAndUpdateNextFlow(vCase, xRequest_id)

            Response.Write("rCheckEndFlow = " & check_end)
        Else
            Response.Write("parameter request_id")
        End If
    End Sub
End Class
