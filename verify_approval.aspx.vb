Imports System.Data

Partial Class verify_approval
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DB106 As New Cls_Data
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.SessionUemail()
        CP.checkLogin()

        Me.Page.Title = "Verify Approval [" + Me.Page.Title + "]"

        If Session("Uemail") IsNot Nothing Then
            ' Session("token") = "b36b6569-58a1-451b-a596-31da2bb19a22"
            hide_uemail.Value() = Session("Uemail")
            hide_token.Value() = Session("token")
            user_logon.InnerHtml = "<span class='glyphicon glyphicon-off user_logon' aria-hidden='true'></span> " + Session("Uemail")

            ' If Array.IndexOf(CF.system_admin, Session("Uemail")) > -1 Or CF.rCheckInDepart("", 999) = 1 Then
            If CF.rSpecialDepart(CF.system_admin) = 1 Then
                hide_permiss.Value() = 999
            Else
                hide_permiss.Value() = ""
            End If
        End If

        loadPage()

        CP.Analytics()
    End Sub

    Sub loadPage()
        Dim vSql As String
        vSql = "select ro, 'RO' + ro ro_name "
        vSql += "from [10.11.5.106].[RMSDAT01].[dbo].[vw_ro_cluster_province] "
        vSql += "group by ro "

        Dim vDT,vDT2,vDT3,vDT4 As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim tab_project As String = ""
        Dim detail_supject  As String = ""
        Dim colspan As Integer = 6

        If hide_permiss.Value = "999" Then
            colspan = 7
        End If

        For i As Integer = 0 To vDT.Rows().Count() - 1
            tab_project += "<li id='li_" + vDT.Rows(i).Item("ro_name") + "'><a href='#tab_" & vDT.Rows(i).Item("ro_name") & "' data-toggle='tab'>" & vDT.Rows(i).Item("ro_name") & "</a></li>"

            detail_supject += "<div role='tabpanel' class='tab-pane' id='tab_" & vDT.Rows(i).Item("ro_name") & "'> <br>"
        
            detail_supject += "<table class='table table-striped'> "
            detail_supject += "<thead>"
            detail_supject += "<tr>"
            detail_supject += "<th><b class='txt-blue'>ผู้ตรวจสอบ 1</b></th>"
            detail_supject += "<th colspan='" & colspan & "'></th>"
            detail_supject += "</tr>"
            detail_supject += "</thead>"
            detail_supject += "<tbody style='color:#555;'>"

            vSql = "select duid, uemail + '@jasmine.com' email, ro, cluster, province  "
            vSql += ", jas_thaiFullname, jas_position, jas_department, user_desc "
            vSql += "from vw_depart_user "
            vSql += "where ro = '" & vDT.Rows(i).Item("ro") & "' and depart_id = 1002 "
            vSql += "order by cluster, province, uemail "

            vDT2 = DB105.GetDataTable(vSql)

            For i2 As Integer = 0 To vDT2.Rows().Count() - 1
                detail_supject += "<tr id='duid_" & vDT2.Rows(i2).Item("duid") & "'>"
                detail_supject += "<td title='คำอธิบาย'><b>" & vDT2.Rows(i2).Item("user_desc") & "<b></td>"
                detail_supject += "<td title='CLUSTER'><b>" & vDT2.Rows(i2).Item("cluster") & "<b></td>"
                detail_supject += "<td title='จังหวัด'><b>" & vDT2.Rows(i2).Item("province") & "<b></td>"
                detail_supject += "<td title='อีเมล์'>" & vDT2.Rows(i2).Item("email") & "</td>"
                detail_supject += "<td title='ชื่อ-สกุล'>" & vDT2.Rows(i2).Item("jas_thaiFullname") & "</td>"
                detail_supject += "<td title='ตำแหน่ง'>" & vDT2.Rows(i2).Item("jas_position") & "</td>"
                detail_supject += "<td title='ฝ่าย'>" & vDT2.Rows(i2).Item("jas_department") & "</td>"

                If hide_permiss.Value = "999" Then
                    detail_supject += "<td>"
                    detail_supject += "  <div class='btn-group'>"
                    detail_supject += "      <button type='button' class='btn btn-default btn-sm' onclick='modalEdit(""" & vDT2.Rows(i2).Item("duid") & """);' title='แก้ไข'>"
                    detail_supject += "          <span class='glyphicon glyphicon-edit' aria-hidden='true'></span>"
                    detail_supject += "      </button>"
                    detail_supject += "  </div>"
                    detail_supject += "  <div class='btn-group'>"
                    detail_supject += "      <button type='button' class='btn btn-default btn-sm' onclick='modalTransfer(""" & vDT2.Rows(i2).Item("duid") & """);' title='แทนที่สิทธิ์ด้วย User ใหม่'>"
                    detail_supject += "          <span class='glyphicon glyphicon-plus-sign' aria-hidden='true'></span>"
                    detail_supject += "      </button>"
                    detail_supject += "  </div>"
                    detail_supject += "</td>"
                End If

                detail_supject += "</tr>"
            Next

            detail_supject += "<thead>"
            detail_supject += "<tr>"
            detail_supject += "<th><b class='txt-blue'>ผู้ตรวจสอบ 2</b></th>"
            detail_supject += "<th colspan='" & colspan & "'></th>"
            detail_supject += "</tr>"
            detail_supject += "</thead>"
            detail_supject += "<tbody style='color:#555;'>"

            vSql = "select duid, uemail + '@jasmine.com' email, ro, cluster, province  "
            vSql += ", jas_thaiFullname, jas_position, jas_department, user_desc "
            vSql += "from vw_depart_user "
            vSql += "where ro = '" & vDT.Rows(i).Item("ro") & "' and depart_id = 1003 "
            vSql += "order by cluster, province, uemail "

            vDT2 = DB105.GetDataTable(vSql)

            For i3 As Integer = 0 To vDT2.Rows().Count() - 1
                detail_supject += "<tr id='duid_" & vDT2.Rows(i3).Item("duid") & "'>"
                detail_supject += "<td title='คำอธิบาย'><b>" & vDT2.Rows(i3).Item("user_desc") & "<b></td>"
                detail_supject += "<td title='CLUSTER'><b>" & vDT2.Rows(i3).Item("cluster") & "<b></td>"
                detail_supject += "<td title='จังหวัด'><b>" & vDT2.Rows(i3).Item("province") & "<b></td>"
                detail_supject += "<td title='อีเมล์'>" & vDT2.Rows(i3).Item("email") & "</td>"
                detail_supject += "<td title='ชื่อ-สกุล'>" & vDT2.Rows(i3).Item("jas_thaiFullname") & "</td>"
                detail_supject += "<td title='ตำแหน่ง'>" & vDT2.Rows(i3).Item("jas_position") & "</td>"
                detail_supject += "<td title='ฝ่าย'>" & vDT2.Rows(i3).Item("jas_department") & "</td>"

                If hide_permiss.Value = "999" Then
                    detail_supject += "<td>"
                    detail_supject += "  <div class='btn-group'>"
                    detail_supject += "      <button type='button' class='btn btn-default btn-sm' onclick='modalEdit(""" & vDT2.Rows(i3).Item("duid") & """);' title='แก้ไข'>"
                    detail_supject += "          <span class='glyphicon glyphicon-edit' aria-hidden='true'></span>"
                    detail_supject += "      </button>"
                    detail_supject += "  </div>"
                    detail_supject += "  <div class='btn-group'>"
                    detail_supject += "      <button type='button' class='btn btn-default btn-sm' onclick='modalTransfer(""" & vDT2.Rows(i3).Item("duid") & """);' title='แทนที่สิทธิ์ด้วย User ใหม่'>"
                    detail_supject += "          <span class='glyphicon glyphicon-plus-sign' aria-hidden='true'></span>"
                    detail_supject += "      </button>"
                    detail_supject += "  </div>"
                    detail_supject += "</td>"
                End If

                detail_supject += "</tr>"
            Next

            detail_supject += "<thead>"
            detail_supject += "<tr>"
            detail_supject += "<th><b class='txt-blue'>ผู้อนุมัติ</b></th>"
            detail_supject += "<th colspan='" & colspan & "'></th>"
            detail_supject += "</tr>"
            detail_supject += "</thead>"
            detail_supject += "<tbody style='color:#555;'>"

            vSql = "select duid, uemail + '@jasmine.com' email, ro, cluster, province  "
            vSql += ", jas_thaiFullname, jas_position, jas_department, user_desc "
            vSql += "from vw_depart_user "
            vSql += "where ro = '" & vDT.Rows(i).Item("ro") & "' and depart_id = 1001 "
            vSql += "order by cluster, province, uemail "

            vDT2 = DB105.GetDataTable(vSql)

            For i4 As Integer = 0 To vDT2.Rows().Count() - 1
                detail_supject += "<tr id='duid_" & vDT2.Rows(i4).Item("duid") & "'>"
                detail_supject += "<td title='คำอธิบาย'><b>" & vDT2.Rows(i4).Item("user_desc") & "<b></td>"
                detail_supject += "<td title='CLUSTER'><b>" & vDT2.Rows(i4).Item("cluster") & "<b></td>"
                detail_supject += "<td title='จังหวัด'><b>" & vDT2.Rows(i4).Item("province") & "<b></td>"
                detail_supject += "<td title='อีเมล์'>" & vDT2.Rows(i4).Item("email") & "</td>"
                detail_supject += "<td title='ชื่อ-สกุล'>" & vDT2.Rows(i4).Item("jas_thaiFullname") & "</td>"
                detail_supject += "<td title='ตำแหน่ง'>" & vDT2.Rows(i4).Item("jas_position") & "</td>"
                detail_supject += "<td title='ฝ่าย'>" & vDT2.Rows(i4).Item("jas_department") & "</td>"

                If hide_permiss.Value = "999" Then
                    detail_supject += "<td>"
                    detail_supject += "  <div class='btn-group'>"
                    detail_supject += "      <button type='button' class='btn btn-default btn-sm' onclick='modalEdit(""" & vDT2.Rows(i4).Item("duid") & """);' title='แก้ไข'>"
                    detail_supject += "          <span class='glyphicon glyphicon-edit' aria-hidden='true'></span>"
                    detail_supject += "      </button>"
                    detail_supject += "  </div>"
                    detail_supject += "  <div class='btn-group'>"
                    detail_supject += "      <button type='button' class='btn btn-default btn-sm' onclick='modalTransfer(""" & vDT2.Rows(i4).Item("duid") & """);' title='แทนที่สิทธิ์ด้วย User ใหม่'>"
                    detail_supject += "          <span class='glyphicon glyphicon-plus-sign' aria-hidden='true'></span>"
                    detail_supject += "      </button>"
                    detail_supject += "  </div>"
                    detail_supject += "</td>"
                End If

                detail_supject += "</tr>"
            Next

            detail_supject += "<thead>"
            detail_supject += "<tr>"
            detail_supject += "<th><b class='txt-red'>ผู้ลดหนี้ตามเขตพื้นที่</b></th>"
            detail_supject += "<th colspan='" & colspan & "'></th>"
            detail_supject += "</tr>"
            detail_supject += "</thead>"
            detail_supject += "<tbody style='color:#555;'>"

            vSql = "select duid, uemail + '@jasmine.com' email, ro, cluster, province  "
            vSql += ", jas_thaiFullname, jas_position, jas_department, user_desc "
            vSql += "from vw_depart_user "
            vSql += "where ro = '" & vDT.Rows(i).Item("ro") & "' and depart_id = 1008 "
            vSql += "order by cluster, province, uemail "

            vDT2 = DB105.GetDataTable(vSql)

            For i8 As Integer = 0 To vDT2.Rows().Count() - 1
                detail_supject += "<tr id='duid_" & vDT2.Rows(i8).Item("duid") & "'>"
                detail_supject += "<td title='คำอธิบาย'><b>" & vDT2.Rows(i8).Item("user_desc") & "<b></td>"
                detail_supject += "<td title='CLUSTER'><b>" & vDT2.Rows(i8).Item("cluster") & "<b></td>"
                detail_supject += "<td title='จังหวัด'><b>" & vDT2.Rows(i8).Item("province") & "<b></td>"
                detail_supject += "<td title='อีเมล์'>" & vDT2.Rows(i8).Item("email") & "</td>"
                detail_supject += "<td title='ชื่อ-สกุล'>" & vDT2.Rows(i8).Item("jas_thaiFullname") & "</td>"
                detail_supject += "<td title='ตำแหน่ง'>" & vDT2.Rows(i8).Item("jas_position") & "</td>"
                detail_supject += "<td title='ฝ่าย'>" & vDT2.Rows(i8).Item("jas_department") & "</td>"

                If hide_permiss.Value = "999" Then
                    detail_supject += "<td>"
                    detail_supject += "  <div class='btn-group'>"
                    detail_supject += "      <button type='button' class='btn btn-default btn-sm' onclick='modalEdit(""" & vDT2.Rows(i8).Item("duid") & """);' title='แก้ไข'>"
                    detail_supject += "          <span class='glyphicon glyphicon-edit' aria-hidden='true'></span>"
                    detail_supject += "      </button>"
                    detail_supject += "  </div>"
                    detail_supject += "  <div class='btn-group'>"
                    detail_supject += "      <button type='button' class='btn btn-default btn-sm' onclick='modalTransfer(""" & vDT2.Rows(i8).Item("duid") & """);' title='แทนที่สิทธิ์ด้วย User ใหม่'>"
                    detail_supject += "          <span class='glyphicon glyphicon-plus-sign' aria-hidden='true'></span>"
                    detail_supject += "      </button>"
                    detail_supject += "  </div>"
                    detail_supject += "</td>"
                End If

                detail_supject += "</tr>"
            Next

            detail_supject += "</tbody>"
            detail_supject += "</table>"

            detail_supject += "</div>"
        Next

        nav_tab_project.InnerHtml = tab_project
        content_subject.InnerHtml = detail_supject
    End Sub
End Class
