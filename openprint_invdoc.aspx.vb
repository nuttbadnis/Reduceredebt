Partial Class openprint_invdoc
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow
    Dim DB105 As New Cls_Data105
    Dim pdf As String
    Dim preview As String = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim xRequest_id As String

            If Request.Form("print_pdf1_request_id") <> Nothing Then
                xRequest_id = Request.Form("print_pdf1_request_id")

            Else If Request.Form("print_pdf2_request_id") <> Nothing Then
                xRequest_id = Request.Form("print_pdf2_request_id")

            Else
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "alertscript", "alert('request_id failed! ติดต่อ support pos');", True)

            End If

            If Request.QueryString("pdf") <> Nothing Then
                pdf = Request.QueryString("pdf")
            End If

            If Request.QueryString("preview") <> Nothing Then
                preview = Request.QueryString("preview")
            End If

            checkRequestEnd(xRequest_id)
        End If

        CP.checkLogin()
        CP.Analytics()
    End Sub

    Sub checkRequestEnd(ByVal vRequest_id As String)
        If CF.rGetRequestStatus(vRequest_id) <> 100 And pdf <> 1 And preview <> 1 Then ' pdf = 1 คือเอกสารใบแจ้งหนี้ ไม่ต้องรอปิดคำขอ
            ClientScript.RegisterStartupScript(Page.GetType, "", "alert(""ต้องปิดคำขอแล้ว เท่านั้น!!""); window.location = 'default.aspx';", True)
        Else
            gotoPrint(vRequest_id)
        End If

    End Sub

    Sub gotoPrint(ByVal vRequest_id As String)

        Dim vSqlIn As String = "insert into log_request_print (request_id, print_count, print_by, print_date) values ("
        vSqlIn += "'" + vRequest_id + "',"
        vSqlIn += "(select count(1) from log_request_print where request_id = '" + vRequest_id + "') + 1,"
        vSqlIn += "'" + Session("Uemail") + "', getdate() ) "

        vSqlIn += "exec dbo.SP_runInvDocID '" + vRequest_id + "' "

        If DB105.ExecuteNonQuery(vSqlIn).ToString() >= 1 Then
            Dim vUrl As String = "~/openprint_invdocpdf.aspx?pdf=" & pdf

            If preview <> 0 Then
                vUrl += "&preview=" & preview
            End If

            Session("print_request_id") = vRequest_id
            Response.Redirect(vUrl)
        Else
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "alertscript", "alert('failed! ติดต่อ support pos');", True)
        End If
    End Sub

End Class

