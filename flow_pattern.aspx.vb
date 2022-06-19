Imports System.Data

Partial Class flow_pattern
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DB106 As New Cls_Data
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()
        CP.checkLogin()
            
        Me.Page.Title = "Flow Pattern [" + Me.Page.Title + "]"

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
        vSql += "where disable = 0 "
        vSql += "order by project_prefix "

        Dim vDT,vDT2,vDT3,vDT4 As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim tab_project As String = ""
        Dim detail_supject  As String = ""

        For i As Integer = 0 To vDT.Rows().Count() - 1
            vSql = "select hide_intro, subject_id, subject_prefix, subject_name, subject_desc, subject_url, flow_id, subject_url, pick_refund_in "
            vSql += "from subject_dim "
            vSql += "where disable = 0 "
            vSql += "and project_id = '" & vDT.Rows(i).Item("project_id") & "' "
            vSql += "order by subject_prefix "

            vDT2 = DB105.GetDataTable(vSql)

            tab_project += "<li><a href='#tab" & i & "' data-toggle='tab'>" & vDT.Rows(i).Item("project_prefix") & ". " & vDT.Rows(i).Item("project_name") & "</a></li>"
            detail_supject += "<div class='tab-pane' id='tab" & i & "'>"
            detail_supject += "     <div class='panel-group' id='accordion" & vDT.Rows(i).Item("project_prefix") & "' aria-multiselectable='true'>"

            For i2 As Integer = 0 To vDT2.Rows().Count() - 1
                Dim vPickRefund As String = "''"

                If vDT2.Rows(i2).Item("pick_refund_in") <> "" Then
                    vPickRefund = vDT2.Rows(i2).Item("pick_refund_in")
                End If

                vSql = "select flow_step, next_step, back_step, replace(next_step, '-', 'x') sort_step, "
                vSql += "depart_name, isnull(group_email, uemail) send_uemail, uemail, add_next, approval, lock_receipt "
                vSql += "from flow_pattern "
                vSql += "join vw_depart_and_group_user dm on dm.depart_id = flow_pattern.depart_id "
                vSql += "where flow_id = '" & vDT2.Rows(i2).Item("flow_id") & "' "
                vSql += "order by flow_step, sort_step "

                vDT3 = DB105.GetDataTable(vSql)

                vSql = "select pick_refund_id, pick_refund_title "
                vSql += "from pick_refund "
                vSql += "where pick_refund_id in (" & vPickRefund & ") "
                vSql += "order by pick_refund_id "

                vDT4 = DB105.GetDataTable(vSql)

                detail_supject += "         <div class='panel panel-default'>"
                detail_supject += "             <div class='panel-heading' id='headingOne'>"
                detail_supject += "                 <h4 class='panel-title'>"
                detail_supject += "                     <a class='collapsed' data-toggle='collapse' data-parent='#accordion" & vDT.Rows(i).Item("project_prefix") & "' href='#collapse" & vDT2.Rows(i2).Item("subject_id") & "'>"
                detail_supject += "                          <b>" & vDT2.Rows(i2).Item("subject_prefix") & ".</b> " & vDT2.Rows(i2).Item("subject_name")
                detail_supject += "                     </a>"
                detail_supject += "                 </h4>"
                detail_supject += "             </div>"
                detail_supject += "             <div id='collapse" & vDT2.Rows(i2).Item("subject_id") & "' class='panel-collapse collapse'>"
                detail_supject += "                 <div class='panel-body'>"
                detail_supject += "                     <p>"
                detail_supject += "                         <b class='red'>Flow ID: " & vDT2.Rows(i2).Item("flow_id") & "</b> | "
                detail_supject += "                         <b class='blue'>Form Page: " & vDT2.Rows(i2).Item("subject_url") & "</b>"
                detail_supject += "                     </p>"

                detail_supject += "                     <div class='pick-refund'><b>รูปแบบการคืนเงิน:</b> <br><ol>"
                For i4 As Integer = 0 To vDT4.Rows().Count() - 1
                        detail_supject += "                 <li class='li-pick'>" & vDT4.Rows(i4).Item("pick_refund_title") & "</li>"
                Next
                detail_supject += "                     </ol></div>"

                detail_supject += "    <table class='table table-striped table-flow'>"
                detail_supject += "        <thead class='txt-blue txt-bold'>"
                detail_supject += "            <tr>"
                detail_supject += "                <th>#</th>"
                detail_supject += "                <th>Step</th>"
                detail_supject += "                <th>Next</th>"
                detail_supject += "                <th>ส่วนงาน</th>"
                detail_supject += "                <th>อีเมล์</th>"
                detail_supject += "                <th>ฟอร์ม</th>"
                detail_supject += "                <th>หากไม่อนุมัติ</th>"
                detail_supject += "                <th>แทรกลำดับถัดไป</th>"
                ' detail_supject += "                <th>เมื่ออนุมัติ<br>ห้ามแก้ไขข้อมูลสำคัญ</th>"
                detail_supject += "            </tr>"
                detail_supject += "        </thead>"
                detail_supject += "        <tbody>"
            
                For i3 As Integer = 0 To vDT3.Rows().Count() - 1
                    Dim add_next As String = "<span class='glyphicon glyphicon-remove'></span>"
                    Dim approval As String = "-"
                    Dim lock_receipt As String = ""
                    Dim reject_back As String = "ยกเลิกคำขอ"

                    If vDT3.Rows(i3).Item("add_next") = 1 Then
                        add_next = "<span class='glyphicon glyphicon-ok'></span>"
                    End If

                    If vDT3.Rows(i3).Item("approval") = 1 Then
                        approval = "ฟอร์มอนุมัติ"
                    Else If vDT3.Rows(i3).Item("approval") = 2 Then
                        approval = "ฟอร์มดำเนินการ"
                    Else If vDT3.Rows(i3).Item("approval") = 3 Then
                        approval = "ฟอร์มรับทราบ"
                    End If

                    If vDT3.Rows(i3).Item("lock_receipt") = 1 Then
                        lock_receipt = "<span class='glyphicon glyphicon-lock'></span>"
                    End If

                    If vDT3.Rows(i3).Item("back_step") > 0 Then
                        reject_back = "ย้อนไป Step " & vDT3.Rows(i3).Item("back_step")
                    End If

                    If vDT3.Rows(i3).Item("next_step") = "end" Then
                        add_next = "-"
                        reject_back = "-"
                    End If

                    detail_supject += "            <tr>"
                    detail_supject += "                <td>" & (i3+1) & "</td>"
                    detail_supject += "                <td>" & vDT3.Rows(i3).Item("flow_step") & "</td>"
                    detail_supject += "                <td>" & vDT3.Rows(i3).Item("next_step") & "</td>"
                    detail_supject += "                <td>" & vDT3.Rows(i3).Item("depart_name") & "</td>"
                    detail_supject += "                <td>" & CF.rSplit_uemail(vDT3.Rows(i3).Item("send_uemail"), vDT3.Rows(i3).Item("uemail")) & "</td>"
                    detail_supject += "                <td>" & approval & "</td>"
                    detail_supject += "                <td>" & reject_back & "</td>"
                    detail_supject += "                <td>" & add_next & "</td>"
                    ' detail_supject += "                <td>" & lock_receipt & "</td>"
                    detail_supject += "            </tr>"
                Next

                detail_supject += "        </tbody>"
                detail_supject += "    </table>"

                detail_supject += "                 </div>"
                detail_supject += "             </div>"
                detail_supject += "         </div>"
            Next

            detail_supject += "     </div>"
            detail_supject += "</div>"
        Next

        nav_tab_project.InnerHtml = tab_project
        content_subject.InnerHtml = detail_supject
    End Sub
End Class
