Imports System.Data

Partial Class advance_search
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        CP.SessionUemail()

        Response.Redirect("~/adv_search_a.aspx")



        If Session("Uemail") IsNot Nothing Then
            hide_today.Value() = Today
            hide_token.Value() = Session("token")
            hide_udepart.Value() = CP.userDepartment(Session("Uemail"))
            hide_group_email.Value() = CP.userGroupEmail(Session("Uemail"))
            hide_uemail.Value() = Session("Uemail")
            user_logon.InnerHtml = "<span class='glyphicon glyphicon-off user_logon' aria-hidden='true'></span> " + Session("Uemail")
            webtest.Href = "https://posbcs.triplet.co.th/FRTest/login.aspx?token=" + Session("token")
        End If

        CP.checkLogin()
        CP.Analytics()
    End Sub

    Sub Save_Pushpin(ByVal Source As Object, ByVal E As EventArgs)
        Dim vSqlIn As String
        ' vSqlIn = "delete from setting_mode where uemail = '" & Session("Uemail") & "' "
        ' vSqlIn += "insert into setting_mode (uemail, mode_data) values ('" & Session("Uemail") & "', 1) "

        ' If DB105.ExecuteNonQuery(vSqlIn).ToString() >= 1 Then
            Response.Redirect(Page.Request.Url.ToString())
        ' End If
    End Sub
End Class
