
Partial Class upload_file89_api
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow
    Dim DBVAS As New Cls_DataVAS

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.Analytics()
        chcked()
    End Sub

    Private Sub chcked()
        Try
            Dim log_no As String = DateTime.Now.ToString("yyMMddHHmmssfff") & CP.rRandomKeyGen(5)

            Dim request_id As String = HttpContext.Current.Request.QueryString("request_id")
            Dim log_upload As String = HttpContext.Current.Request.QueryString("log_upload")

            ' Response.Write("request_id = " + request_id)
            ' Response.Write(" log_upload = " + log_upload)

            If request_id <> Nothing Then
                If request_id.Trim() <> "" Then
                    CF.InsertLogRedebtAPI(log_no)
                    Dim vRequestStatus As String = CF.rGetRequestStatus(request_id)

                    If vRequestStatus <> 100 And vRequestStatus <> 105 Then
                        Dim insertSuccess As Boolean = CF.uploadFileAPIPhase2(log_upload)
                        ' CF.UpdateLogRedebtAPI(log_no, request_id, log_upload)
                        ' UpdateLogUploadComplete(log_upload)

                        If insertSuccess = True Then
                            CF.UpdateLogRedebtAPI(log_no, request_id, log_upload)
                            UpdateLogUploadComplete(log_upload)
                            
                            Dim vDT As New DataTable
                            vDT = CF.rLoadRequestFlowCurrentStep(request_id)

                            If vDT.Rows().Count() = 1 Then
                                Dim vFlow_no As String = vDT.Rows(0).Item("no")
                                Dim vFlow_sub As String = vDT.Rows(0).Item("flow_sub")
                                Dim vNext_step As String = vDT.Rows(0).Item("next_step")
                                Dim vBack_step As String = vDT.Rows(0).Item("back_step")
                                Dim vDepartment As String = vDT.Rows(0).Item("depart_id")

                                If vDepartment = 89 Then
                                    If CF.SaveFlowAjax("self_register", vFlow_no, vFlow_sub, vNext_step, vBack_step, vDepartment, 60, "", request_id) = 1 Then
                                        ' CF.UpdateLogRedebtAPI(log_no, request_id, log_upload)
                                        ' UpdateLogUploadComplete(log_upload)
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If

        Catch ex As Exception
        End Try
    End Sub

    Public Sub UpdateLogUploadComplete(ByVal log_upload As String)
        Try
            Dim vSqlIn As String 
            vSqlIn += "update log_api_upload set "
            vSqlIn += "log_complete = 1, log_update_date = getdate() "
            vSqlIn += "where log_no = '" + log_upload + "' "

            DBVAS.ExecuteNonQuery(vSqlIn)

        Catch ex As Exception
            ' ignore
            ' err_mss = ex.Message
            ' err_int = ex.HResult
        End Try
    End Sub
End Class
