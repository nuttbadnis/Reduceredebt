Imports System.IO
Imports System.Data

Partial Class replace_userify
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.checkLogin()
        
        ' If Array.IndexOf(CF.system_admin, Session("Uemail")) > -1 Then
        If CF.rSpecialDepart(CF.system_admin) = 1 Then
            hide_uemail.Value() = Session("Uemail")
            hide_token.Value() = Session("token")
        Else
            CP.kickDefault("nopermiss")
        End If

        If Not Page.IsPostBack Then
            Me.Page.Title = "อัพเดท ผู้ตรวจสอบ/ผู้อนุมัติ [" + Me.Page.Title + "]"
        End If

        CP.Analytics()
    End Sub

    ' Sub Submit_Clear(ByVal Source As Object, ByVal E As EventArgs)
    '     Dim vRequest_id As String = txt_request_id.Value
    '     Dim create_by As String = hide_uemail.Value

    '     Dim vSql As String 
    '     vSql = "select subject_url, redebt_number, redebt_file, redebt_update, redebt_update_by from request "
    '     vSql += "join subject_dim on request.subject_id = subject_dim.subject_id "
    '     vSql += "where request.request_id = '" + vRequest_id + "'"

    '     Dim vDT As New DataTable
    '     vDT = DB105.GetDataTable(vSql)

    '     If vDT.Rows().Count() > 0 Then
    '         Dim vSqlIn As String 

    '         vSqlIn += "insert into log_clear_redebt ("
    '         vSqlIn += "request_id "
    '         vSqlIn += ", redebt_number "
    '         vSqlIn += ", redebt_file "
    '         vSqlIn += ", redebt_update "
    '         vSqlIn += ", redebt_update_by "
    '         vSqlIn += ", log_create_by"
    '         vSqlIn += ", log_create_date "
    '         vSqlIn += ") select "
    '         vSqlIn += "request_id "
    '         vSqlIn += ", redebt_number "
    '         vSqlIn += ", redebt_file "
    '         vSqlIn += ", redebt_update "
    '         vSqlIn += ", redebt_update_by "
    '         vSqlIn += ", '" + create_by + "'"
    '         vSqlIn += ", getdate() "
    '         vSqlIn += "from request "
    '         vSqlIn += "where request_id = '" + vRequest_id + "'"
    '         ' vSqlIn += ") values ("
    '         ' vSqlIn += " '" + CP.rReplaceQuote(vRequest_id) + "' "
    '         ' vSqlIn += ", '" & vDT.Rows(0).Item("redebt_number") & "'"
    '         ' vSqlIn += ", '" & vDT.Rows(0).Item("redebt_file") & "'"
    '         ' vSqlIn += ", '" & vDT.Rows(0).Item("redebt_update") & "'"
    '         ' vSqlIn += ", '" & vDT.Rows(0).Item("redebt_update_by") & "'"
    '         ' vSqlIn += ", '" + create_by + "'"
    '         ' vSqlIn += ", getdate()"
    '         ' vSqlIn += ") "

    '         vSqlIn += "update request set "
    '         vSqlIn += "redebt_number = '' "
    '         vSqlIn += ", redebt_file = '' "
    '         vSqlIn += ", redebt_update = NULL "
    '         vSqlIn += ", redebt_update_by = 'clear_redebt' "
    '         vSqlIn += "where request_id = '" + vRequest_id + "' "

    '         If DB105.ExecuteNonQuery(vSqlIn).ToString() >= 1 Then
    '             Dim vAlert_Mss As String = "เคลียใบลดหนี้เรียบร้อยแล้ว สามารถเลือกใบลดหนี้ใหม่ได้"
    '             Dim vUrl_Redirect = "update_" & vDT.Rows(0).Item("subject_url") & ".aspx?request_id=" & vRequest_id

    '             CF.RedirectSubmit(vAlert_Mss, vUrl_Redirect)
    '         Else
    '             Page.ClientScript.RegisterStartupScript(Me.GetType(), "alertscript", "alert('failed! ติดต่อ support pos');", True)
    '         End If
    '     Else
    '         Page.ClientScript.RegisterStartupScript(Me.GetType(), "alertscript", "alert('failed! ติดต่อ support pos');", True)
    '     End If
    ' End Sub
End Class
