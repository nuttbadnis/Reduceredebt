
Partial Class new_redebt28_api
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.Analytics()
        chcked()
    End Sub

    Private Sub chcked()
        Try
            Dim log_no As String = DateTime.Now.ToString("yyMMddHHmmssfff") & CP.rRandomKeyGen(5)

            Dim request_id As String = HttpContext.Current.Request.QueryString("request_id")
            Dim flow_id As String = HttpContext.Current.Request.QueryString("flow_id")
            Dim create_by As String = HttpContext.Current.Request.QueryString("create_by")

            If request_id <> Nothing Then
                If request_id.Trim() <> "" Then
                    CF.InsertLogRedebtAPI(log_no)

                    Dim insertSuccess As Boolean = CF.InsertRequestAPIPhase2(request_id, flow_id _
                        , "", "", "" _
                        , "", "", "", create_by  _
                    )

                    If insertSuccess = True Then
                        CF.UpdateLogRedebtAPI(log_no, request_id)
                    End If
                End If
            End If

        Catch ex As Exception
        End Try
    End Sub
End Class
