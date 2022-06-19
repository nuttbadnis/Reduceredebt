Imports System.Data

Partial Class xpatch_update
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DB106 As New Cls_Data
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()
        CP.checkLogin()
            
        Me.Page.Title = "Patch Update [" + Me.Page.Title + "]"

        If Session("Uemail") IsNot Nothing Then
            hide_uemail.Value() = Session("Uemail")
            user_logon.InnerHtml = "<span class='glyphicon glyphicon-off user_logon' aria-hidden='true'></span> " + Session("Uemail")
        End If

        loadPage()

        CP.Analytics()
    End Sub

    Sub loadPage()
        Dim vSql As String = "select patch_number, patch_tag, "
        vSql += "patch_title, patch_img, patch_date "
        vSql += "from xpatch_update "
        vSql += "where disable = 0 and patch_date <= cast(getdate() as date) "
        vSql += "order by patch_number desc "

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim txt_content As String = ""

        For i As Integer = 0 To vDT.Rows().Count() - 1
            txt_content += "<div class='panel panel-default'>" + _
            "    <div class='panel-heading panel-fonting'>" & vDT.Rows(i).Item("patch_title") & "</div>" + _
            "    <div class='panel-body'>" + _
            "        <div class='form-horizontal'>" + _
            "            <blockquote>" + _
            "                <a href='" & vDT.Rows(i).Item("patch_img") & "' title='คลิกเพื่อดูรูปใหญ่' data-title='" & vDT.Rows(i).Item("patch_title") & "' data-lightbox='" & vDT.Rows(i).Item("patch_number") & "'>" + _
            "                    <img src='" & vDT.Rows(i).Item("patch_img") & "' style='max-width: 20%;'>" + _
            "                </a>" + _
            "            </blockquote>" + _
            "            <blockquote>" + _
            "                <span class='txt-blue'>#" & vDT.Rows(i).Item("patch_number") & " " & vDT.Rows(i).Item("patch_tag") & "</span>" + _
            "            </blockquote>" + _
            "            <blockquote>" + _
            "                <span>วันที่อัพเดท: " & vDT.Rows(i).Item("patch_date") & "</span>" + _
            "            </blockquote>" + _
            "        </div>" + _
            "    </div>" + _
            "</div>"
        Next

        div_content.InnerHtml = txt_content
    End Sub
End Class
