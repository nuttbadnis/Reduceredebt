Imports System.IO
Imports System.Data

Partial Class xcc_view
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim xRequest_id As String = Request.QueryString("request_id")

        If xRequest_id Is Nothing Then
            ClientScript.RegisterStartupScript(Page.GetType, "", "alert(""ไม่สามารถแสดงข้อมูลได้"");", True)
        Else
            loadDetail(xRequest_id)
        End If

        CP.Analytics()
    End Sub

    Sub loadDetail(ByVal vRequest_id As String)
        Dim vDT,vDT2 As New DataTable

        vDT = CF.rSqlLoadDetailRedebt(vRequest_id)

        If (vDT.Rows().Count() > 0) Then
            Me.Page.Title = "#" + vRequest_id + " [" + Me.Page.Title + "]"

            inn_request_id.InnerHtml = vRequest_id
            inn_status_name.InnerHtml = vDT.Rows(0).Item("status_name")

            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            inn_request_title.InnerHtml = vDT.Rows(0).Item("request_title")
            inn_request_remark.InnerHtml = vDT.Rows(0).Item("request_remark")
            inn_redebt_cause.InnerHtml = vDT.Rows(0).Item("redebt_cause_title")

            inn_account_number.InnerHtml = vDT.Rows(0).Item("account_number")
            inn_account_name.InnerHtml = vDT.Rows(0).Item("account_name")

            inn_doc_number.InnerHtml = vDT.Rows(0).Item("doc_number")
            inn_bcs_number.InnerHtml = vDT.Rows(0).Item("bcs_number")
            inn_amount.InnerHtml = vDT.Rows(0).Item("amount")

            inn_dx02.InnerHtml = vDT.Rows(0).Item("dx02") 'วันที่ยกเลิก
            inn_dx03.InnerHtml = vDT.Rows(0).Item("dx03") 'วันที่ลูกค้าขอลดหนี้

            inn_pick_refund_title1.InnerHtml = vDT.Rows(0).Item("pick_refund_title")

            Dim refund_title2 As String = ""
            
            If vDT.Rows(0).Item("pick_refund_type") = 1 Then
                refund_title2 += vDT.Rows(0).Item("tx01")
            
            Else If vDT.Rows(0).Item("pick_refund_type") = 2 Then
                refund_title2 += vDT.Rows(0).Item("account_number_to") & " / " & vDT.Rows(0).Item("account_name_to")
            
            Else If vDT.Rows(0).Item("pick_refund_type") = 3 Then
                refund_title2 += vDT.Rows(0).Item("account_number_to") & " / " & vDT.Rows(0).Item("account_name_to") + " / " + vDT.Rows(0).Item("tx01")
            
            Else If vDT.Rows(0).Item("pick_refund_type") = 0 Then
                If vDT.Rows(0).Item("tx01").Length > 0 Then
                    refund_title2 += vDT.Rows(0).Item("tx01")
                End If

                If vDT.Rows(0).Item("bank_title").Length > 0 Then
                    refund_title2 += " / " & vDT.Rows(0).Item("bank_title")
                End If

                If vDT.Rows(0).Item("fx01").Length > 0 Then
                    refund_title2 += " / รหัสสาขา " & vDT.Rows(0).Item("fx01")
                End If

                If vDT.Rows(0).Item("fx02").Length > 0 Then
                    refund_title2 += " / เลขที่บัญชี " & vDT.Rows(0).Item("fx02")
                End If

                If vDT.Rows(0).Item("mx03").Length > 0 Then
                    refund_title2 += " / ชื่อบัญชี " & vDT.Rows(0).Item("mx03")
                End If
            End If

            If refund_title2.Length > 0 Then
                inn_pick_refund_title2.InnerHtml = "(" + refund_title2 + ")"
            End If

            inn_create_date.InnerHtml = vDT.Rows(0).Item("create_date")
            inn_redebt_number.InnerHtml = vDT.Rows(0).Item("redebt_number")


            loadFlow(vRequest_id, vDT.Rows(0).Item("request_status"), vDT.Rows(0).Item("request_step"))



            Dim vSql As String = ""
            vSql += "select rp_no, rp_date, prove_date, pay_date, due_date "
            vSql += ", case "
            vSql += "   when '" & vDT.Rows(0).Item("nx01") & "' = 2 and due_date is not null then DATEADD(day, 2, due_date) "
            vSql += "   else due_date "
            vSql += "end auto_due_date "
            vSql += "from cnepay.dbo.vw_cn_epay "
            vSql += "where cn_no = '" & vDT.Rows(0).Item("redebt_number") & "'"

            vDT2 = DB105.GetDataTable(vSql)

            If (vDT2.Rows().Count() > 0) Then
                If Not IsDBNull(vDT2.Rows(0).Item("rp_no")) Then
                    inn_rp_no.InnerHtml = vDT2.Rows(0).Item("rp_no")
                End If

                If Not IsDBNull(vDT2.Rows(0).Item("rp_date")) Then
                    inn_rp_date.InnerHtml = vDT2.Rows(0).Item("rp_date")
                End If

                If Not IsDBNull(vDT2.Rows(0).Item("prove_date")) Then
                    inn_prove_date.InnerHtml = vDT2.Rows(0).Item("prove_date")
                End If

                If Not IsDBNull(vDT2.Rows(0).Item("pay_date")) Then
                    inn_pay_date.InnerHtml = vDT2.Rows(0).Item("pay_date")
                End If

                If Not IsDBNull(vDT2.Rows(0).Item("auto_due_date")) Then
                    inn_due_date.InnerHtml = vDT2.Rows(0).Item("auto_due_date")

                    If Not IsDBNull(vDT.Rows(0).Item("nx01")) Then
                        If vDT.Rows(0).Item("nx01") <> 2 Then
                            inn_due_date2.InnerHtml += " (+2 วันทำการ)"
                        End If
                    End If
                End If
            End If
        Else
            ClientScript.RegisterStartupScript(Page.GetType, "", "alert(""ไม่สามารถแสดงข้อมูลได้"");", True)
        End If
    End Sub

    Sub loadFlow(ByVal vRequest_id As String, ByVal vRequest_status As String, ByVal vRequest_step As String)
        Dim vRequest_permiss As Integer = CF.rViewDetail(vRequest_id)

        inn_flow.InnerHtml = CF.rLoadFlowBody_easy(vRequest_id, vRequest_status, vRequest_step, vRequest_permiss)
    End Sub

    Function ConvertAmount(ByVal amount As String) As String 
        Dim before As Double = CDbl(amount)
        before = Math.Round(before, 2, MidpointRounding.AwayFromZero)

        Return Format(CDbl(amount), "###,##0.00")
    End Function
End Class

