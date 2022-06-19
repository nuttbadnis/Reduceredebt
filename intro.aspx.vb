Imports System.Data

Partial Class intro
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DB106 As New Cls_Data
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Response.Redirect("~/xmaintenance.aspx")
        
        CP.checkLogin()
            
        Me.Page.Title = "+ สร้างคำขอใหม่ [" + Me.Page.Title + "]"

        If Session("Uemail") IsNot Nothing Then
            hide_uemail.Value() = Session("Uemail")
            user_logon.InnerHtml = "<span class='glyphicon glyphicon-off user_logon' aria-hidden='true'></span> " + Session("Uemail")
        End If

        loadPage()

        CP.Analytics()
    End Sub

    Sub loadPage()
        Dim vSql As String
        vSql = "select project_id, project_prefix, project_name "
        vSql += "from project_dim "
        vSql += "where disable = 0 and hide_intro = 0 "
        vSql += "order by project_prefix "

        Dim vDT,vDT2,vDT3 As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim tab_project As String = ""
        Dim detail_supject  As String = ""

        For i As Integer = 0 To vDT.Rows().Count() - 1
        
            tab_project += "<li><a href='#tab" & i & "' data-toggle='tab'>" & vDT.Rows(i).Item("project_prefix") & ". " & vDT.Rows(i).Item("project_name") & "</a></li>"
            detail_supject += "<div class='tab-pane' id='tab" & i & "'>"
            detail_supject += "     <div class='panel-group' id='accordion" & vDT.Rows(i).Item("project_prefix") & "' aria-multiselectable='true'>"

            vSql = "select subject_group_id, subject_group_prefix, subject_group_name "
            vSql += "from subject_group_dim "
            vSql += "where disable = 0 "
            vSql += "and project_id = '" & vDT.Rows(i).Item("project_id") & "' "
            vSql += "order by subject_group_prefix "

            vDT2 = DB105.GetDataTable(vSql)

            If vDT2.Rows().Count() > 0 Then
                
                For i2 As Integer = 0 To vDT2.Rows().Count() - 1

                    vSql = "select hide_intro, subject_id, subject_prefix, subject_name, subject_desc, subject_url, subject_group_id "
                    vSql += "from subject_dim "
                    vSql += "where disable = 0 and hide_intro = 0 "
                    vSql += "and project_id = '" & vDT.Rows(i).Item("project_id") & "' and subject_group_id ='" & vDT2.Rows(i2).Item("subject_group_id") & "' "
                    vSql += "order by subject_prefix "    
                        
                    detail_supject += "         <div class='panel panel-default'>"
                    detail_supject += "             <div class='panel-heading'>"
                    detail_supject += "                 <h4 class='panel-title'>"
                    detail_supject += "                     <a class='collapsed' data-toggle='collapse' data-parent='#accordion" & vDT2.Rows(i2).Item("subject_group_prefix") & "' href='#collapse" & vDT2.Rows(i2).Item("subject_group_id") & "'>"
                    detail_supject += "                          <b>" & vDT2.Rows(i2).Item("subject_group_prefix") & ".</b> " & vDT2.Rows(i2).Item("subject_group_name")
                    detail_supject += "                     </a>"
                    detail_supject += "                 </h4>"
                    detail_supject += "             </div>"
                    detail_supject += "             <div id='collapse" & vDT2.Rows(i2).Item("subject_group_id") & "' class='panel-collapse collapse'>"
                    detail_supject += "                 <div class='panel-body' style='padding-top: 10px;'>"
                
                    vDT3 = DB105.GetDataTable(vSql)
            
                    For i3 As Integer = 0 To vDT3.Rows().Count() - 1

                        detail_supject += "         <div class='panel panel-default'>"
                        detail_supject += "             <div class='panel-heading' id='headingOne'>"
                        detail_supject += "                 <h4 class='panel-title'>"
                        detail_supject += "                     <a class='collapsed' data-toggle='collapse' data-parent='#accordion" & vDT.Rows(i).Item("project_prefix") & "' href='#collapse" & vDT3.Rows(i3).Item("subject_id") & "'>"
                        detail_supject += "                          <b>" & vDT3.Rows(i3).Item("subject_prefix") & ".</b> " & vDT3.Rows(i3).Item("subject_name")
                        detail_supject += "                     </a>"
                        detail_supject += "                 </h4>"
                        detail_supject += "             </div>"
                        detail_supject += "             <div id='collapse" & vDT3.Rows(i3).Item("subject_id") & "' class='panel-collapse collapse'>"
                        detail_supject += "                 <div class='panel-body' style='padding-top: 10px;'>"
                        detail_supject += "                     <p style='line-height: 32px;'>" & vDT3.Rows(i3).Item("subject_desc")
                        detail_supject += "                     </p>"
                        detail_supject += "                     <a class='btn btn-sm btn-primary' href='new_" & vDT3.Rows(i3).Item("subject_url") & ".aspx?subject_id=" & vDT3.Rows(i3).Item("subject_id") & "'>คลิกสร้างคำขอ</a>"
                        detail_supject += "                 </div>"
                        detail_supject += "             </div>"
                        detail_supject += "         </div>"

                    Next
                    
                    detail_supject += "                 </div>"
                    detail_supject += "             </div>"
                    detail_supject += "         </div>"

                Next
                
            Else

                vSql = "select hide_intro, subject_id, subject_prefix, subject_name, subject_desc, subject_url, subject_group_id "
                vSql += "from subject_dim "
                vSql += "where disable = 0 and hide_intro = 0 "
                vSql += "and project_id = '" & vDT.Rows(i).Item("project_id") & "' "
                vSql += "order by subject_prefix "
          
                vDT3 = DB105.GetDataTable(vSql)

                For i3 As Integer = 0 To vDT3.Rows().Count() - 1
                    ' vSql = "select request_title_id, request_title "
                    ' vSql += "from request_title_dim "
                    ' vSql += "where disable = 0 "
                    ' vSql += "and subject_id = " & vDT3.Rows(i2).Item("subject_id") & " "
                    ' vSql += "order by request_title "

                    ' vDT3 = DB105.GetDataTable(vSql)

                    detail_supject += "         <div class='panel panel-default'>"
                    detail_supject += "             <div class='panel-heading' id='headingOne'>"
                    detail_supject += "                 <h4 class='panel-title'>"
                    detail_supject += "                     <a class='collapsed' data-toggle='collapse' data-parent='#accordion" & vDT.Rows(i).Item("project_prefix") & "' href='#collapse" & vDT3.Rows(i3).Item("subject_id") & "'>"
                    'detail_supject += "                         <span class='glyphicon glyphicon-plus'></span> "
                    detail_supject += "                          <b>" & vDT3.Rows(i3).Item("subject_prefix") & ".</b> " & vDT3.Rows(i3).Item("subject_name")
                    detail_supject += "                     </a>"
                    detail_supject += "                 </h4>"
                    detail_supject += "             </div>"
                    detail_supject += "             <div id='collapse" & vDT3.Rows(i3).Item("subject_id") & "' class='panel-collapse collapse'>"
                    detail_supject += "                 <div class='panel-body' style='padding-top: 10px;'>"
                    detail_supject += "                     <p style='line-height: 32px;'>" & vDT3.Rows(i3).Item("subject_desc")
                    ' detail_supject += "                     <p><b>คำอธิบายหัวข้อ:</b> " & vDT3.Rows(i3).Item("subject_desc")
                
                    ' For i3 As Integer = 0 To vDT3.Rows().Count() - 1
                    '     detail_supject += "                     <ul>"
                    '     detail_supject += "                         <li class='li-title'>" & vDT3.Rows(i3).Item("request_title") & "</li>"
                    '     detail_supject += "                     </ul>"
                    ' Next

                    detail_supject += "                     </p>"
                    detail_supject += "                     <a class='btn btn-sm btn-primary' href='new_" & vDT3.Rows(i3).Item("subject_url") & ".aspx?subject_id=" & vDT3.Rows(i3).Item("subject_id") & "'>คลิกสร้างคำขอ</a>"
                    detail_supject += "                 </div>"
                    detail_supject += "             </div>"
                    detail_supject += "         </div>"
                Next
            
            End If

            detail_supject += "     </div>"
            detail_supject += "</div>"
        Next

        nav_tab_project.InnerHtml = tab_project
        content_subject.InnerHtml = detail_supject
    End Sub
End Class
