Imports System.Data
Imports System.Web.Script.Serialization
Imports System.Collections.Generic

Partial Class json_default
    Inherits System.Web.UI.Page
    Dim DB106 As New Cls_Data
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Dim super_admin As String = "'panupong.pa','kanoktip.s', 'kirk.p'"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim qrs As String = ""

        If Request.QueryString("qrs") <> Nothing Then
            qrs = Request.QueryString("qrs")
        End If

        If qrs = "loadProject" Then
            loadProject()
        End If

        If qrs = "loadSubject" Then
            loadSubject()
        End If

        If qrs = "loadTitle" Then
            loadTitle()
        End If

        If qrs = "loadStatus" Then
            loadStatus()
        End If

        If qrs = "loadRO" Then
            loadRO()
        End If

        If qrs = "loadCluster" Then
            loadCluster()
        End If

        If qrs = "loadProvince" Then
            loadProvince()
        End If

        If qrs = "autoEmp" Then
            autoEmp()
        End If

        If qrs = "getDUID" Then
            getDUID()
        End If

        If qrs = "insertDUID" Then
            insertDUID()
        End If

        If qrs = "updateDUID" Then
            updateDUID()
        End If

        If qrs = "transferDUID" Then
            transferDUID()
        End If

        If qrs = "reSyncJas" Then
            reSyncJas()
        End If

        If qrs = "load3bbShop" Then
            load3bbShop()
        End If

        If qrs = "getRequest" Then
            getRequest()
        End If

        If qrs = "getRequestStarField" Then
            getRequestStarField()
        End If

        If qrs = "modeDataAllRequest" Then
            modeDataAllRequest()
        End If

        If qrs = "modeDataCountAllRequest" Then
            modeDataCountAllRequest()
        End If

        If qrs = "modeApproveAllRequest" Then
            modeApproveAllRequest()
        End If

        If qrs = "modeApproveCountAllRequest" Then
            modeApproveCountAllRequest()
        End If

        If qrs = "xccAllRequest" Then
            xccAllRequest()
        End If

        If qrs = "searchAllRequest" Then
            searchAllRequest()
        End If

        If qrs = "searchAllRequestCount" Then
            searchAllRequestCount()
        End If

        If qrs = "loadCurrentPatchModeData" Then
            loadCurrentPatchModeData()
        End If

        If qrs = "loadCurrentPatchModeApprove" Then
            loadCurrentPatchModeApprove()
        End If

        If qrs = "acknowPatch" Then
            acknowPatch()
        End If

        If qrs = "loadNotReadPatchModeData" Then
            loadNotReadPatchModeData()
        End If

        If qrs = "loadNotReadPatchModeApprove" Then
            loadNotReadPatchModeApprove()
        End If

        If qrs = "readingPatch" Then
            readingPatch()
        End If

        If qrs = "loadProjectTabList" Then
            loadProjectTabList()
        End If

        If qrs = "loadCountFlowReject" Then
            loadCountFlowReject()
        End If

        If qrs = "loadRequestFlowReject" Then
            loadRequestFlowReject()
        End If

        If qrs = "strReplaceUserify" Then
            strReplaceUserify()
        End If

        If qrs = "getSession" Then
            Response.Write(Session("Uemail"))
        End If

        If qrs = "getToken" Then
            Response.Write(Session("token"))
        End If

    End Sub

    Protected Sub loadProject()
        Dim vSql As String = "select project_id, project_prefix, project_name  "
        vSql += "from project_dim "
        vSql += "where disable = 0 and this_demo = 0 "
        vSql += "order by project_prefix "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadSubject()
        Dim vSql As String = "select subject_id, subject_prefix, subject_name, subject_url, project_prefix  "
        vSql += "from subject_dim "
        vSql += "join project_dim on project_dim.project_id = subject_dim.project_id "

        vSql += "where subject_dim.disable = 0 "
        vSql += "and project_dim.disable = 0 "
        vSql += "and project_dim.this_demo = 0 "

        If Request.QueryString("project_id") <> Nothing Then
            vSql += "and subject_dim.project_id in (" + Request.QueryString("project_id") + ") "
        End If

        vSql += "order by project_prefix, subject_prefix "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadTitle()
        Dim vSql As String 
        vSql = "select subject_prefix, subject_name, request_title_id, request_title, "
        vSql += "case request_title_dim.disable when 1 then '[disable]' else '' end disable "
        vSql += "from request_title_dim "
        vSql += "join subject_dim on subject_dim.subject_id = request_title_dim.subject_id "
        vSql += "where request_title_dim.subject_id in (" + Request.QueryString("subject_id") + ") "
        vSql += "order by subject_prefix, request_title "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadStatus()
        Dim vSql As String = "select status_id, status_name  "
        vSql += "from request_status "
        vSql += "where disable = 0 "
        vSql += "and searched = 1 and nexted <> 3 "
        vSql += "order by status_priority, status_id "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadRO()
        Dim vSql As String = CF.rSqlDDRO()

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadCluster()
        Dim vSql As String = CF.rSqlDDCluster(Request.QueryString("ro"))

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadProvince()
        Dim vSql As String = CF.rSqlDDProvince(Request.QueryString("ro"), Request.QueryString("cluster"))

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub autoEmp()
        Dim xKeyword As String = Request.QueryString("kw")
        Dim xToken As String = Request.QueryString("token")

        Dim vJson As String = CP.rGetDataOAuthjson(xKeyword, xToken)
        
        Response.Write(vJson)
    End Sub

    Protected Sub getDUID()
        Dim vSql As String = " select depart_user_id  "
        vSql += ", depart_id , uemail , user_desc "
        vSql += ", ro, cluster, province "
        vSql += ", case when start_date is null then '' else convert(varchar(10), start_date, 103) end start_date "
        vSql += ", case when expired_date is null then '' else convert(varchar(10), expired_date, 103) end expired_date "
        vSql += "from depart_user "
        vSql += "where depart_user_id = " & Request.QueryString("duid") & " "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub insertDUID()
        Dim xCreate_by As String = Request.Form("create_by")
        Dim xUemail As String = Request.Form("uemail")
        Dim xRo As String = Request.Form("ro")
        Dim xCluster As String = Request.Form("cluster")
        Dim xProvince As String = Request.Form("province")
        Dim xDepart_id As String = Request.Form("department")
        Dim xDesc As String = Request.Form("user_desc")
        Dim xStart As String = Request.Form("start")
        Dim xExpire As String = Request.Form("expire")

        Dim vSqlIn As String = ""

        If xStart <> Nothing Then
            vSqlIn += "declare @start_date date = convert(date, '" + xStart + "', 103) "
        Else 
            vSqlIn += "declare @start_date date = NULL "
        End If

        If xExpire <> Nothing Then
            vSqlIn += "declare @exp_date date = convert(date, '" + xExpire + "', 103) "
        Else 
            vSqlIn += "declare @exp_date date = NULL "
        End If

        vSqlIn += "exec SP_insertDUID '" & xUemail & "', '" & xRo & "', '" & xCluster & "', '" & xProvince & "', '" & xDepart_id & "', '" & xDesc & "', @start_date, @exp_date, '" & xCreate_by & "' "

        ' Response.Write(vSqlIn)
        ' Response.Write(DB105.ExecuteNonQuery(vSqlIn).ToString())

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSqlIn)
        If vDT.Rows().Count() > 0 Then
            Response.Write(vDT.Rows(0).Item("duid"))
        Else
            Response.Write(0)
        End If
    End Sub

    Protected Sub updateDUID()
        Dim xUpdate_by As String = Request.Form("update_by")
        Dim xRo As String = Request.Form("ro")
        Dim xCluster As String = Request.Form("cluster")
        Dim xProvince As String = Request.Form("province")
        Dim xDepart_id As String = Request.Form("department")
        Dim xDesc As String = Request.Form("user_desc")
        Dim xExpire As String = Request.Form("expire")
        Dim duid As String = Request.Form("duid")
        
        Dim vSqlIn As String = ""

        If xExpire <> Nothing Then
            vSqlIn += "declare @exp_date date = convert(date, '" + xExpire + "', 103) "
        Else 
            vSqlIn += "declare @exp_date date = NULL "
        End If

        vSqlIn += "exec SP_updateDUID '" & xRo & "', '" & xCluster & "', '" & xProvince & "', '" & xDepart_id & "', '" & xDesc & "', @exp_date, '" & xUpdate_by & "', '" & duid & "' "
        
        ' Response.Write(vSqlIn)
        Response.Write(DB105.ExecuteNonQuery(vSqlIn).ToString())
    End Sub

    Protected Sub transferDUID()
        Dim xUpdate_by As String = Request.Form("update_by")
        Dim xUemail As String = Request.Form("uemail")
        Dim xRo As String = Request.Form("ro")
        Dim xCluster As String = Request.Form("cluster")
        Dim xProvince As String = Request.Form("province")
        Dim xDepart_id As String = Request.Form("department")
        Dim xDesc As String = Request.Form("user_desc")
        Dim xStart As String = Request.Form("start")
        Dim xExpire As String = Request.Form("expire")
        Dim transferid As String = Request.Form("transferid")
        
        Dim vSqlIn As String = ""

        If xStart <> Nothing Then
            vSqlIn += "declare @start_date date = convert(date, '" + xStart + "', 103) "
        Else 
            vSqlIn += "declare @start_date date = NULL "
        End If

        If xExpire <> Nothing Then
            vSqlIn += "declare @exp_date date = convert(date, '" + xExpire + "', 103) "
        Else 
            vSqlIn += "declare @exp_date date = NULL "
        End If

        vSqlIn += "exec SP_transferDUID '" & xUemail & "', '" & xRo & "', '" & xCluster & "', '" & xProvince & "', '" & xDepart_id & "', '" & xDesc & "', @start_date, @exp_date, '" & xUpdate_by & "', '" & transferid & "' "
        
        ' Response.Write(vSqlIn)
        ' Response.Write(DB105.ExecuteNonQuery(vSqlIn).ToString())

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSqlIn)
        If vDT.Rows().Count() > 0 Then
            Response.Write(vDT.Rows(0).Item("duid"))
        Else
            Response.Write(0)
        End If
    End Sub

    Protected Sub reSyncJas()
        Dim xResponse As Integer = 0
        Dim vSqlIn As String = ""
        Dim xUemail As String = Request.Form("uemail")
        Dim vToken As String = Request.Form("token")

        If xUemail <> Nothing And vToken <> Nothing Then
            Dim vDT_OAUTH As New DataTable 
            vDT_OAUTH = CP.rGetDataOAuthDT(xUemail, vToken)

            If vDT_OAUTH.Rows.Count > 0 Then
                For i2 As Integer = 0 To vDT_OAUTH.Rows.Count - 2
                    If xUemail & "@jasmine.com" = vDT_OAUTH.Rows(i2).Item("email") _
                    AND (vDT_OAUTH.Rows(i2).Item("dateExpired") = "" Or vDT_OAUTH.Rows(i2).Item("dateExpired") = "null") _
                    And vDT_OAUTH.Rows(i2).Item("accountStatus") = "true" Then

                        vSqlIn = "update depart_user_detail set "
                        vSqlIn += "jas_employeeId = '" & vDT_OAUTH.Rows(i2).Item("employeeId") & "' "
                        vSqlIn += ", jas_thaiFullname = '" & vDT_OAUTH.Rows(i2).Item("thaiFullname") & "' "
                        vSqlIn += ", jas_engFullname = '" & vDT_OAUTH.Rows(i2).Item("engFullname") & "' "
                        vSqlIn += ", jas_position = '" & vDT_OAUTH.Rows(i2).Item("position") & "' "
                        vSqlIn += ", jas_department = '" & vDT_OAUTH.Rows(i2).Item("department") & "' "
                        ' vSqlIn += ", jas_update = getdate() "
                        vSqlIn += "where uemail = '" & xUemail & "' "

                        If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
                            xResponse = 1
                        End If
                    End If
                Next
            End If
        End If

        Response.Write(xResponse)
    End Sub

    Protected Sub load3bbShop()
        Dim xRo As String = Request.QueryString("ro")

        Dim vSql As String = "select shop_code, shop_name, shop_code + ': ' + shop_name shop_label "
        vSql += "from shopStock.dbo.vw_shop_active_join_pos "

        If xRo <> Nothing Then
            vSql += "where ro = '" & xRo & "' "
        End If

        vSql += "order by shop_code "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub getRequest()
        Dim xRequest_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select request_id "
        vSql += ",shop_code + ' ' + province_name + ' (RO' + ro + ')' province_name "
        vSql += ",request.create_by + ' (RO' + create_ro + ')' create_by "
        vSql += ",convert(varchar(10), request.create_date, 103) create_date "
        vSql += ",request_title, request_remark "
        vSql += "from request "
        vSql += "left join ( "
        vSql += "    select ro, cluster, province_short, province_name "
        vSql += "    from RMSDAT.dbo.vw_branch_shop_all "
        vSql += "    group by ro, cluster, province_short, province_name "
        vSql += ") province on province.province_short = request.shop_code "
        vSql += "where request_id = '" & xRequest_id & "' "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub getRequestStarField()
        Dim request_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select * from request "

        If request_id <> Nothing Then
            vSql += "where request_id = '" & request_id & "' "
        Else 
            vSql += "where 1 = 0 "
        End If

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    '------------------------------------------------------------ modeData ------------------------------------------------------------

    Protected Sub modeDataAllRequest()
        Dim xPageSize As Integer = Request.QueryString("page_size")
        Dim xPageNum As Integer = Request.QueryString("page_num")
        Dim xSorting As String = Request.QueryString("sorting")

        If xSorting = Nothing Then
            xSorting = "create_date desc"
        End If

        Dim row_start As Integer = 1
        Dim row_end As Integer = (xPageNum * xPageSize)

        If xPageNum > 1 Then
            row_start = ((xPageNum - 1) * xPageSize) + 1
        End If

        Dim tabsys As String = Request.QueryString("tabsys")
        Dim vSql_temp As String

        If tabsys = "a"
            vSql_temp = rSqlModeData_A_request()

        Else If tabsys = "b"
            vSql_temp = rSqlModeData_B_request()

        Else If tabsys = "c"
            vSql_temp = rSqlModeData_C_request()

        Else If tabsys = "d"
            vSql_temp = rSqlModeData_D_request()

        Else If tabsys = "e"
            vSql_temp = rSqlModeData_E_request()

        Else If tabsys = "old"
            vSql_temp = rSqlModedata_old_request()

        Else
            vSql_temp = rSqlModeData_All_request(0)
        End If

        Dim vSql As String
        vSql = "WITH ALL_RQ AS ( "
        vSql += "   select ROW_NUMBER() OVER (ORDER BY current_step desc, " + xSorting + ") row_no, * from (" + vSql_temp + ") modeData "
        vSql += ") "

        vSql += "SELECT * FROM ALL_RQ WHERE row_no BETWEEN " & row_start & " AND " & row_end & ";"

        ' Response.Write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub modeDataCountAllRequest()
        Dim tabsys As String = Request.QueryString("tabsys")
        Dim vSql_temp As String

        If tabsys = "a"
            vSql_temp = rSqlModeData_A_request()

        Else If tabsys = "b"
            vSql_temp = rSqlModeData_B_request()

        Else If tabsys = "c"
            vSql_temp = rSqlModeData_C_request()

        Else If tabsys = "d"
            vSql_temp = rSqlModeData_D_request()

        Else If tabsys = "e"
            vSql_temp = rSqlModeData_E_request()

        Else If tabsys = "old"
            vSql_temp = rSqlModedata_old_request()

        Else
            vSql_temp = rSqlModeData_All_request(0)
        End If

        Dim vSql As String
        vSql = "select count(1) COUNT_RQ from (" + vSql_temp + ") modeData "
        
        ' Response.Write(vSql)

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Response.Write(vDT.Rows(0).Item("COUNT_RQ"))
    End Sub

    Function rSqlModeData_All_request(ByVal vApprove As Integer) As String
        Dim inDepart As String = Request.QueryString("udepart")
        Dim inGroupEmail As String = Request.QueryString("groupemail")
        Dim uemail As String = Request.QueryString("uemail")

        Dim xProduct As String = Request.QueryString("project_prefix")
        Dim xSubject As String = Request.QueryString("subject_id")
        Dim xStatus As String = Request.QueryString("status_id")
        Dim xArea_ro As String = Request.QueryString("area_ro")

        Dim kw As String = Request.QueryString("kw")
        Dim xCurrent As String = Request.QueryString("current")

        If inDepart = Nothing Then
            inDepart = "999888898"
        End If

        If inGroupEmail = Nothing Then
            inGroupEmail = "'999888898'"
        End If

        Dim vSql As String
        vSql = "select request_id, subject_prefix, subject_name, subject_url "
        vSql += ", project_prefix, project_name, request_title, next_depart_name, status_name "
        vSql += ", create_by, create_date, last_update "
        vSql += ", current_step, havepermis, dash_step "

        vSql += "from ( "
        vSql += "    select request.request_id, project_prefix, project_name, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, status_priority, request.request_status "
        vSql += "    , request.create_by, request.create_date, uemail_verify1 "
        vSql += "    , case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , case when request.request_status <> 100 and request.request_status <> 105 then "
        vSql += "           case "
        vSql += "               when next_depart = 0 and request.create_by = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_ccv1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and cc_group = 1 then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 3 and uemail_verify2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2
        vSql += "               when next_depart = 2 and uemail_verify1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1
        vSql += "               when next_depart = 1 and uemail_approve = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ

        If vApprove = 0 Then
            vSql += "               when next_depart = 8 and uemail_takecn = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ลดหนี้ตามเขตพื้นที่ ไม่ต้องแสดงใน modeapprove
        End If

        vSql += "               when next_depart in (" + inDepart + ") then 1 " '***** ถ้าเป็นผู้อยู่ใน next_depart นั้น
        vSql += "               when next_depart = 3 and uemail_verify2 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 2 and uemail_verify1 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 1 and uemail_approve in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               else 0 "
        vSql += "           end "
        vSql += "    end current_step, cc_group "
        vSql += "    , case when havepermis.request_id is null then 0 else 1 end havepermis "
        ' vSql += "    , isnull(( "
        ' vSql += "        select case "
        ' vSql += "            when next_step = '-' and flow_complete = 0 then 1 "
        ' vSql += "            when next_step = '-' and flow_complete = 1 then -1 "
        ' vSql += "            else 0 "
        ' vSql += "        end "
        ' vSql += "        from request_flow rfd "
        ' vSql += "        where rfd.request_id = request.request_id "
        ' vSql += "        and rfd.flow_step = request.request_step "
        ' vSql += "        and rfd.depart_id = request.next_depart "
        ' vSql += "        and disable = 0 "
        ' vSql += "    ),0) dash_step "
        vSql += "    , 0 dash_step "
        
        vSql += "    from ( "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where send_uemail in (" + inGroupEmail + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow_sub "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request "
        vSql += "        where ("
        vSql += "        create_by = '" + uemail + "' or uemail_cc1 = '" + uemail + "' or uemail_cc2 = '" + uemail + "' or uemail_ccv1 = '" + uemail + "' "
        vSql += "        or uemail_verify2 = '" + uemail + "' or uemail_verify1 = '" + uemail + "' or uemail_approve = '" + uemail + "' or uemail_takecn = '" + uemail + "' "
        vSql += "        or '" + uemail + "' in (" + super_admin + ") "
        vSql += "        ) "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, cc_group from vw_cc_group_1 where uemail = '" + uemail + "' "
        vSql += "    ) havepermis "

        vSql += "    left join request on request.request_id = havepermis.request_id "

        vSql += "    left join request_title_dim on request_title_dim.request_title_id = request.request_title_id "
        vSql += "    left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "    left join project_dim on project_dim.project_id = subject_dim.project_id "
        vSql += "    left join request_status on request_status.status_id = request.request_status "
        vSql += "    left join department next_depart on next_depart.depart_id = request.next_depart "

        vSql += "    where subject_dim.disable = 0 "
        vSql += "    and project_dim.disable = 0 "

        If xProduct <> Nothing Then
            vSql += "   and project_dim.project_prefix = '" + xProduct + "' "
            vSql += "   and subject_dim.disable = 0 and project_dim.disable = 0 "
        End If

        If xSubject <> Nothing Then
            vSql += "   and subject_dim.subject_id in (" + xSubject + ") "
        End If

        If xStatus <> Nothing Then
            vSql += "   and request.request_status in (" + xStatus + ") "
        End If

        If xArea_ro <> Nothing Then
            vSql += "   and request.area_ro in (" + xArea_ro + ") "
        End If

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "request.create_by like '%" + kw + "%' "
            vSql += "or request.request_id like '%" + kw + "%' "
            vSql += "or request.account_number like '%" + kw + "%' "
            vSql += "or request.account_name like '%" + kw + "%' "
            vSql += "or request.account_number_to like '%" + kw + "%' "
            vSql += "or request.account_name_to like '%" + kw + "%' "
            vSql += "or request.doc_number like '%" + kw + "%' "
            vSql += "or request.bcs_number like '%" + kw + "%' "
            vSql += "or request.redebt_number like '%" + kw + "%' "
            vSql += ") "
        End If

        vSql += ") all_request "
        vSql += "where 1=1 "

        If xCurrent <> Nothing Then
            vSql += "and ("
            vSql += "   current_step = 1 and dash_step >= 0 "
            vSql += ") "
        End If

        Return vSql
    End Function

    Function rSqlModeData_A_request() As String
        Dim xProduct As String = "A"

        Dim inDepart As String = Request.QueryString("udepart")
        Dim inGroupEmail As String = Request.QueryString("groupemail")
        Dim uemail As String = Request.QueryString("uemail")

        Dim xSubject As String = Request.QueryString("subject_id")
        Dim xStatus As String = Request.QueryString("status_id")
        Dim xArea_ro As String = Request.QueryString("area_ro")

        Dim kw As String = Request.QueryString("kw")
        Dim xCurrent As String = Request.QueryString("current")

        If inDepart = Nothing Then
            inDepart = "999888898"
        End If

        If inGroupEmail = Nothing Then
            inGroupEmail = "'999888898'"
        End If

        Dim vSql As String
        vSql = "select request_id, subject_prefix, subject_name, subject_url "
        vSql += ", project_prefix, project_name, request_title, next_depart_name, status_name "
        vSql += ", create_by, create_date, last_update, amount "
        vSql += ", current_step, havepermis, dash_step "
        vSql += ", account_number, account_name, shop_code, area_ro, convert(varchar(10), dx03, 103) dx03 "
        vSql += ", redebt_number, rp_no, rp_date, prove_date, pay_date, due_date "

        vSql += "from ( "
        vSql += "    select request.request_id, project_prefix, project_name, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, status_priority, request.request_status, amount "
        vSql += "    , request.create_by, request.create_date, uemail_cc1, uemail_cc2, uemail_ccv1, uemail_verify1, uemail_verify2, uemail_approve "
        vSql += "    , case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , case when request.request_status <> 100 and request.request_status <> 105 then "
        vSql += "           case "
        vSql += "               when next_depart = 0 and request.create_by = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_ccv1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and cc_group = 1 then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 3 and uemail_verify2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2
        vSql += "               when next_depart = 2 and uemail_verify1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1
        vSql += "               when next_depart = 1 and uemail_approve = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ
        vSql += "               when next_depart = 8 and uemail_takecn = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ลดหนี้ตามเขตพื้นที่ 20210420
        vSql += "               when next_depart in (" + inDepart + ") then 1 " '***** ถ้าเป็นผู้อยู่ใน next_depart นั้น
        vSql += "               when next_depart = 3 and uemail_verify2 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 2 and uemail_verify1 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 1 and uemail_approve in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               else 0 "
        vSql += "           end "
        vSql += "    end current_step, cc_group "
        vSql += "    , request.account_number, account_name, shop_code, area_ro, dx03 "
        vSql += "    , redebt_number, rp_no, rp_date, prove_date, pay_date, due_date "
        vSql += "    , case when havepermis.request_id is null then 0 else 1 end havepermis "
        vSql += "    , isnull(( "
        vSql += "        select case "
        vSql += "            when next_step = '-' and flow_complete = 0 then 1 "
        vSql += "            when next_step = '-' and flow_complete = 1 then -1 "
        vSql += "            else 0 "
        vSql += "        end "
        vSql += "        from request_flow rfd "
        vSql += "        where rfd.request_id = request.request_id "
        vSql += "        and rfd.flow_step = request.request_step "
        vSql += "        and rfd.depart_id = request.next_depart "
        vSql += "        and disable = 0 "
        vSql += "    ),0) dash_step "
        
        vSql += "    from ( "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where send_uemail in (" + inGroupEmail + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow_sub "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request "
        vSql += "        where ("
        vSql += "        create_by = '" + uemail + "' or uemail_cc1 = '" + uemail + "' or uemail_cc2 = '" + uemail + "' or uemail_ccv1 = '" + uemail + "' "
        vSql += "        or uemail_verify2 = '" + uemail + "' or uemail_verify1 = '" + uemail + "' or uemail_approve = '" + uemail + "' or uemail_takecn = '" + uemail + "' "
        vSql += "        or '" + uemail + "' in (" + super_admin + ") "
        vSql += "        ) "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, cc_group from vw_cc_group_1 where uemail = '" + uemail + "' "
        vSql += "    ) havepermis "

        vSql += "    left join request on request.request_id = havepermis.request_id "
        vSql += "    left join cnepay.dbo.vw_cn_epay epay on epay.cn_no = request.redebt_number "

        vSql += "    left join request_title_dim on request_title_dim.request_title_id = request.request_title_id "
        vSql += "    left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "    left join project_dim on project_dim.project_id = subject_dim.project_id "
        vSql += "    left join request_status on request_status.status_id = request.request_status "
        vSql += "    left join department next_depart on next_depart.depart_id = request.next_depart "

        vSql += "    where subject_dim.disable = 0 "
        vSql += "    and project_dim.disable = 0 "

        vSql += "    and project_dim.project_prefix = '" + xProduct + "' "

        If xSubject <> Nothing Then
            vSql += "   and subject_dim.subject_id in (" + xSubject + ") "
        End If

        If xStatus <> Nothing Then
            vSql += "   and request.request_status in (" + xStatus + ") "
        End If

        If xArea_ro <> Nothing Then
            vSql += "   and request.area_ro in (" + xArea_ro + ") "
        End If

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "request.create_by like '%" + kw + "%' "
            vSql += "or request.request_id like '%" + kw + "%' "
            vSql += "or request.account_number like '%" + kw + "%' "
            vSql += "or request.account_name like '%" + kw + "%' "
            vSql += "or request.account_number_to like '%" + kw + "%' "
            vSql += "or request.account_name_to like '%" + kw + "%' "
            vSql += "or request.doc_number like '%" + kw + "%' "
            vSql += "or request.bcs_number like '%" + kw + "%' "
            vSql += "or request.redebt_number like '%" + kw + "%' "
            vSql += "or rp_no like '%" + kw + "%' "
            vSql += ") "
        End If

        vSql += ") all_request "
        vSql += "where 1=1 "

        If xCurrent <> Nothing Then
            vSql += "and ("
            vSql += "   current_step = 1 and dash_step >= 0 "
            vSql += ") "
        End If

        Return vSql
    End Function

    Function rSqlModeData_B_request() As String
        Dim xProduct As String = "B"

        Dim inDepart As String = Request.QueryString("udepart")
        Dim inGroupEmail As String = Request.QueryString("groupemail")
        Dim uemail As String = Request.QueryString("uemail")

        Dim xSubject As String = Request.QueryString("subject_id")
        Dim xStatus As String = Request.QueryString("status_id")
        Dim xArea_ro As String = Request.QueryString("area_ro")

        Dim kw As String = Request.QueryString("kw")
        Dim xCurrent As String = Request.QueryString("current")

        If inDepart = Nothing Then
            inDepart = "999888898"
        End If

        If inGroupEmail = Nothing Then
            inGroupEmail = "'999888898'"
        End If

        Dim vSql As String
        vSql = "select request_id, subject_prefix, subject_name, subject_url "
        vSql += ", project_prefix, project_name, request_title, next_depart_name, status_name "
        vSql += ", create_by, create_date, last_update "
        vSql += ", current_step, havepermis, dash_step "
        vSql += ", fx01, shop_name, area_ro, mx01, mx02, mx03 "

        vSql += "from ( "
        vSql += "    select request.request_id, project_prefix, project_name, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, status_priority, request.request_status "
        vSql += "    , request.create_by, request.create_date, uemail_verify1 "
        vSql += "    , case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , case when request.request_status <> 100 and request.request_status <> 105 then "
        vSql += "           case "
        vSql += "               when next_depart = 0 and request.create_by = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_ccv1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and cc_group = 1 then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 3 and uemail_verify2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2
        vSql += "               when next_depart = 2 and uemail_verify1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1
        vSql += "               when next_depart = 1 and uemail_approve = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ
        vSql += "               when next_depart in (" + inDepart + ") then 1 " '***** ถ้าเป็นผู้อยู่ใน next_depart นั้น
        vSql += "               when next_depart = 3 and uemail_verify2 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 2 and uemail_verify1 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 1 and uemail_approve in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               else 0 "
        vSql += "           end "
        vSql += "    end current_step, cc_group "
        vSql += "    , case when havepermis.request_id is null then 0 else 1 end havepermis "
        vSql += "    , isnull(( "
        vSql += "        select case "
        vSql += "            when next_step = '-' and flow_complete = 0 then 1 "
        vSql += "            when next_step = '-' and flow_complete = 1 then -1 "
        vSql += "            else 0 "
        vSql += "        end "
        vSql += "        from request_flow rfd "
        vSql += "        where rfd.request_id = request.request_id "
        vSql += "        and rfd.flow_step = request.request_step "
        vSql += "        and rfd.depart_id = request.next_depart "
        vSql += "        and disable = 0 "
        vSql += "    ),0) dash_step "
        vSql += "    , fx01, shop_name, area_ro, mx01, mx02, mx03 "
        
        vSql += "    from ( "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where send_uemail in (" + inGroupEmail + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow_sub "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request "
        vSql += "        where ("
        vSql += "        create_by = '" + uemail + "' or uemail_cc1 = '" + uemail + "' or uemail_cc2 = '" + uemail + "' or uemail_ccv1 = '" + uemail + "' "
        vSql += "        or uemail_verify2 = '" + uemail + "' or uemail_verify1 = '" + uemail + "' or uemail_approve = '" + uemail + "' "
        vSql += "        or '" + uemail + "' in (" + super_admin + ") "
        vSql += "        ) "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, cc_group from vw_cc_group_1 where uemail = '" + uemail + "' "
        vSql += "    ) havepermis "

        vSql += "    left join request on request.request_id = havepermis.request_id "
        vSql += "    left join shopStock.dbo.shopStock shopStock on shopStock.shop_code = request.fx01 "

        vSql += "    left join request_title_dim on request_title_dim.request_title_id = request.request_title_id "
        vSql += "    left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "    left join project_dim on project_dim.project_id = subject_dim.project_id "
        vSql += "    left join request_status on request_status.status_id = request.request_status "
        vSql += "    left join department next_depart on next_depart.depart_id = request.next_depart "


        vSql += "    where subject_dim.disable = 0 "
        vSql += "    and project_dim.disable = 0 "
        
        vSql += "    and project_dim.project_prefix = '" + xProduct + "' "

        If xSubject <> Nothing Then
            vSql += "   and subject_dim.subject_id in (" + xSubject + ") "
        End If

        If xStatus <> Nothing Then
            vSql += "   and request.request_status in (" + xStatus + ") "
        End If

        If xArea_ro <> Nothing Then
            vSql += "   and request.area_ro in (" + xArea_ro + ") "
        End If

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "request.create_by like '%" + kw + "%' "
            vSql += "or request.request_id like '%" + kw + "%' "
            vSql += "or fx01 like '%" + kw + "%' "
            vSql += "or shop_name like '%" + kw + "%' "
            vSql += ") "
        End If

        vSql += ") all_request "
        vSql += "where 1=1 "

        If xCurrent <> Nothing Then
            vSql += "and ("
            vSql += "   current_step = 1 and dash_step >= 0 "
            vSql += ") "
        End If

        Return vSql
    End Function

    Function rSqlModeData_C_request() As String
        Dim xProduct As String = "C"

        Dim inDepart As String = Request.QueryString("udepart")
        Dim inGroupEmail As String = Request.QueryString("groupemail")
        Dim uemail As String = Request.QueryString("uemail")

        Dim xSubject As String = Request.QueryString("subject_id")
        Dim xStatus As String = Request.QueryString("status_id")
        Dim xArea_ro As String = Request.QueryString("area_ro")

        Dim kw As String = Request.QueryString("kw")
        Dim xCurrent As String = Request.QueryString("current")

        If inDepart = Nothing Then
            inDepart = "999888898"
        End If

        If inGroupEmail = Nothing Then
            inGroupEmail = "'999888898'"
        End If

        Dim vSql As String
        vSql = "select request_id, subject_prefix, subject_name, subject_url "
        vSql += ", project_prefix, project_name, request_title, next_depart_name, status_name "
        vSql += ", create_by, create_date, last_update "
        vSql += ", current_step, havepermis, dash_step "
        vSql += ", fx01, fx02, shop_name, prov_short, area_ro, mx01, mx02, mx03 "

        vSql += "from ( "
        vSql += "    select request.request_id, project_prefix, project_name, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, status_priority, request.request_status "
        vSql += "    , request.create_by, request.create_date, uemail_verify1 "
        vSql += "    , case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , case when request.request_status <> 100 and request.request_status <> 105 then "
        vSql += "           case "
        vSql += "               when next_depart = 0 and request.create_by = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_ccv1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and cc_group = 1 then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 3 and uemail_verify2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2
        vSql += "               when next_depart = 2 and uemail_verify1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1
        vSql += "               when next_depart = 1 and uemail_approve = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ
        vSql += "               when next_depart in (" + inDepart + ") then 1 " '***** ถ้าเป็นผู้อยู่ใน next_depart นั้น
        vSql += "               when next_depart = 3 and uemail_verify2 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 2 and uemail_verify1 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 1 and uemail_approve in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               else 0 "
        vSql += "           end "
        vSql += "    end current_step, cc_group "
        vSql += "    , case when havepermis.request_id is null then 0 else 1 end havepermis "
        vSql += "    , isnull(( "
        vSql += "        select case "
        vSql += "            when next_step = '-' and flow_complete = 0 then 1 "
        vSql += "            when next_step = '-' and flow_complete = 1 then -1 "
        vSql += "            else 0 "
        vSql += "        end "
        vSql += "        from request_flow rfd "
        vSql += "        where rfd.request_id = request.request_id "
        vSql += "        and rfd.flow_step = request.request_step "
        vSql += "        and rfd.depart_id = request.next_depart "
        vSql += "        and disable = 0 "
        vSql += "    ),0) dash_step "
        vSql += "    , fx01, fx02, shopStock.shop_name, request.shop_code prov_short, area_ro, mx01, mx02, mx03 "
        
        vSql += "    from ( "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where send_uemail in (" + inGroupEmail + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow_sub "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request "
        vSql += "        where ("
        vSql += "        create_by = '" + uemail + "' or uemail_cc1 = '" + uemail + "' or uemail_cc2 = '" + uemail + "' or uemail_ccv1 = '" + uemail + "' "
        vSql += "        or uemail_verify2 = '" + uemail + "' or uemail_verify1 = '" + uemail + "' or uemail_approve = '" + uemail + "' "
        vSql += "        or '" + uemail + "' in (" + super_admin + ") "
        vSql += "        ) "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, cc_group from vw_cc_group_1 where uemail = '" + uemail + "' "
        vSql += "    ) havepermis "

        vSql += "    left join request on request.request_id = havepermis.request_id "
        vSql += "    left join shopStock.dbo.shopStock shopStock on shopStock.shop_code = request.fx01 "

        vSql += "    left join request_title_dim on request_title_dim.request_title_id = request.request_title_id "
        vSql += "    left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "    left join project_dim on project_dim.project_id = subject_dim.project_id "
        vSql += "    left join request_status on request_status.status_id = request.request_status "
        vSql += "    left join department next_depart on next_depart.depart_id = request.next_depart "


        vSql += "    where subject_dim.disable = 0 "
        vSql += "    and project_dim.disable = 0 "
        
        vSql += "    and project_dim.project_prefix = '" + xProduct + "' "

        If xSubject <> Nothing Then
            vSql += "   and subject_dim.subject_id in (" + xSubject + ") "
        End If

        If xStatus <> Nothing Then
            vSql += "   and request.request_status in (" + xStatus + ") "
        End If

        If xArea_ro <> Nothing Then
            vSql += "   and request.area_ro in (" + xArea_ro + ") "
        End If

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "request.create_by like '%" + kw + "%' "
            vSql += "or request.request_id like '%" + kw + "%' "
            vSql += "or fx01 like '%" + kw + "%' "
            vSql += "or shop_name like '%" + kw + "%' "
            vSql += ") "
        End If

        vSql += ") all_request "
        vSql += "where 1=1 "

        If xCurrent <> Nothing Then
            vSql += "and ("
            vSql += "   current_step = 1 and dash_step >= 0 "
            vSql += ") "
        End If

        Return vSql
    End Function

    Function rSqlModeData_D_request() As String
        Dim xProduct As String = "D"

        Dim inDepart As String = Request.QueryString("udepart")
        Dim inGroupEmail As String = Request.QueryString("groupemail")
        Dim uemail As String = Request.QueryString("uemail")

        Dim xSubject As String = Request.QueryString("subject_id")
        Dim xStatus As String = Request.QueryString("status_id")
        Dim xArea_ro As String = Request.QueryString("area_ro")

        Dim kw As String = Request.QueryString("kw")
        Dim xCurrent As String = Request.QueryString("current")

        If inDepart = Nothing Then
            inDepart = "999888898"
        End If

        If inGroupEmail = Nothing Then
            inGroupEmail = "'999888898'"
        End If

        Dim vSql As String
        vSql = "select request_id, subject_prefix, subject_name, subject_url "
        vSql += ", project_prefix, project_name, request_title, next_depart_name, status_name "
        vSql += ", create_by, create_date, last_update "
        vSql += ", current_step, havepermis, dash_step "
        vSql += ", fx01, fx02, shop_name, prov_short, area_ro, mx01, mx02, mx03 "

        vSql += "from ( "
        vSql += "    select request.request_id, project_prefix, project_name, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, status_priority, request.request_status "
        vSql += "    , request.create_by, request.create_date, uemail_verify1 "
        vSql += "    , case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , case when request.request_status <> 100 and request.request_status <> 105 then "
        vSql += "           case "
        vSql += "               when next_depart = 0 and request.create_by = '" + uemail + "' then 1 " '***** ??? next_depart ???????????????
        vSql += "               when next_depart = 0 and request.uemail_cc1 = '" + uemail + "' then 1 " '***** ??? next_depart ???????????????
        vSql += "               when next_depart = 0 and request.uemail_cc2 = '" + uemail + "' then 1 " '***** ??? next_depart ???????????????
        vSql += "               when next_depart = 0 and request.uemail_ccv1 = '" + uemail + "' then 1 " '***** ??? next_depart ???????????????
        vSql += "               when next_depart = 0 and cc_group = 1 then 1 " '***** ??? next_depart ???????????????
        vSql += "               when next_depart = 3 and uemail_verify2 = '" + uemail + "' then 1 " '***** ??? next_depart ??????????????2
        vSql += "               when next_depart = 2 and uemail_verify1 = '" + uemail + "' then 1 " '***** ??? next_depart ??????????????1
        vSql += "               when next_depart = 1 and uemail_approve = '" + uemail + "' then 1 " '***** ??? next_depart ??????????????
        vSql += "               when next_depart in (" + inDepart + ") then 1 " '***** ???????????????? next_depart ????
        vSql += "               when next_depart = 3 and uemail_verify2 in (" + inGroupEmail + ") then 1 " '***** ??? next_depart ??????????????2 ???????????????? groupemail ????
        vSql += "               when next_depart = 2 and uemail_verify1 in (" + inGroupEmail + ") then 1 " '***** ??? next_depart ??????????????1 ???????????????? groupemail ????
        vSql += "               when next_depart = 1 and uemail_approve in (" + inGroupEmail + ") then 1 " '***** ??? next_depart ?????????????? ???????????????? groupemail ????
        vSql += "               else 0 "
        vSql += "           end "
        vSql += "    end current_step, cc_group "
        vSql += "    , case when havepermis.request_id is null then 0 else 1 end havepermis "
        vSql += "    , isnull(( "
        vSql += "        select case "
        vSql += "            when next_step = '-' and flow_complete = 0 then 1 "
        vSql += "            when next_step = '-' and flow_complete = 1 then -1 "
        vSql += "            else 0 "
        vSql += "        end "
        vSql += "        from request_flow rfd "
        vSql += "        where rfd.request_id = request.request_id "
        vSql += "        and rfd.flow_step = request.request_step "
        vSql += "        and rfd.depart_id = request.next_depart "
        vSql += "        and disable = 0 "
        vSql += "    ),0) dash_step "
        vSql += "    , fx01, fx02, shopStock.shop_name, request.shop_code prov_short, area_ro, mx01, mx02, mx03 "
        
        vSql += "    from ( "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where send_uemail in (" + inGroupEmail + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow_sub "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request "
        vSql += "        where ("
        vSql += "        create_by = '" + uemail + "' or uemail_cc1 = '" + uemail + "' or uemail_cc2 = '" + uemail + "' or uemail_ccv1 = '" + uemail + "' "
        vSql += "        or uemail_verify2 = '" + uemail + "' or uemail_verify1 = '" + uemail + "' or uemail_approve = '" + uemail + "' "
        vSql += "        or '" + uemail + "' in (" + super_admin + ") "
        vSql += "        ) "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, cc_group from vw_cc_group_1 where uemail = '" + uemail + "' "
        vSql += "    ) havepermis "

        vSql += "    left join request on request.request_id = havepermis.request_id "
        vSql += "    left join shopStock.dbo.shopStock shopStock on shopStock.shop_code = request.fx01 "

        vSql += "    left join request_title_dim on request_title_dim.request_title_id = request.request_title_id "
        vSql += "    left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "    left join project_dim on project_dim.project_id = subject_dim.project_id "
        vSql += "    left join request_status on request_status.status_id = request.request_status "
        vSql += "    left join department next_depart on next_depart.depart_id = request.next_depart "


        vSql += "    where subject_dim.disable = 0 "
        vSql += "    and project_dim.disable = 0 "
        
        vSql += "    and project_dim.project_prefix = '" + xProduct + "' "

        If xSubject <> Nothing Then
            vSql += "   and subject_dim.subject_id in (" + xSubject + ") "
        End If

        If xStatus <> Nothing Then
            vSql += "   and request.request_status in (" + xStatus + ") "
        End If

        If xArea_ro <> Nothing Then
            vSql += "   and request.area_ro in (" + xArea_ro + ") "
        End If

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "request.create_by like '%" + kw + "%' "
            vSql += "or request.request_id like '%" + kw + "%' "
            vSql += "or fx01 like '%" + kw + "%' "
            vSql += "or shop_name like '%" + kw + "%' "
            vSql += ") "
        End If

        vSql += ") all_request "
        vSql += "where 1=1 "

        If xCurrent <> Nothing Then
            vSql += "and ("
            vSql += "   current_step = 1 and dash_step >= 0 "
            vSql += ") "
        End If

        Return vSql
    End Function

    Function rSqlModeData_E_request() As String
        Dim xProduct As String = "E"

        Dim inDepart As String = Request.QueryString("udepart")
        Dim inGroupEmail As String = Request.QueryString("groupemail")
        Dim uemail As String = Request.QueryString("uemail")

        Dim xSubject As String = Request.QueryString("subject_id")
        Dim xStatus As String = Request.QueryString("status_id")
        Dim xArea_ro As String = Request.QueryString("area_ro")

        Dim kw As String = Request.QueryString("kw")
        Dim xCurrent As String = Request.QueryString("current")

        If inDepart = Nothing Then
            inDepart = "999888898"
        End If

        If inGroupEmail = Nothing Then
            inGroupEmail = "'999888898'"
        End If

        Dim vSql As String
        vSql = "select request_id, subject_prefix, subject_name, subject_url "
        vSql += ", project_prefix, project_name, request_title, next_depart_name, status_name "
        vSql += ", create_by, create_date, last_update "
        vSql += ", current_step, havepermis, dash_step "
        vSql += ", fx01, fx02, shop_name, prov_short, area_ro, mx01, mx02, mx03, isnull(invdoc_runid, '-') invdoc_runid "

        vSql += "from ( "
        vSql += "    select request.request_id, project_prefix, project_name, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, status_priority, request.request_status "
        vSql += "    , request.create_by, request.create_date, uemail_verify1 "
        vSql += "    , case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , case when request.request_status <> 100 and request.request_status <> 105 then "
        vSql += "           case "
        vSql += "               when next_depart = 0 and request.create_by = '" + uemail + "' then 1 " '***** ??? next_depart ???????????????
        vSql += "               when next_depart = 0 and request.uemail_cc1 = '" + uemail + "' then 1 " '***** ??? next_depart ???????????????
        vSql += "               when next_depart = 0 and request.uemail_cc2 = '" + uemail + "' then 1 " '***** ??? next_depart ???????????????
        vSql += "               when next_depart = 0 and request.uemail_ccv1 = '" + uemail + "' then 1 " '***** ??? next_depart ???????????????
        vSql += "               when next_depart = 0 and cc_group = 1 then 1 " '***** ??? next_depart ???????????????
        vSql += "               when next_depart = 3 and uemail_verify2 = '" + uemail + "' then 1 " '***** ??? next_depart ??????????????2
        vSql += "               when next_depart = 2 and uemail_verify1 = '" + uemail + "' then 1 " '***** ??? next_depart ??????????????1
        vSql += "               when next_depart = 1 and uemail_approve = '" + uemail + "' then 1 " '***** ??? next_depart ??????????????
        vSql += "               when next_depart in (" + inDepart + ") then 1 " '***** ???????????????? next_depart ????
        vSql += "               when next_depart = 3 and uemail_verify2 in (" + inGroupEmail + ") then 1 " '***** ??? next_depart ??????????????2 ???????????????? groupemail ????
        vSql += "               when next_depart = 2 and uemail_verify1 in (" + inGroupEmail + ") then 1 " '***** ??? next_depart ??????????????1 ???????????????? groupemail ????
        vSql += "               when next_depart = 1 and uemail_approve in (" + inGroupEmail + ") then 1 " '***** ??? next_depart ?????????????? ???????????????? groupemail ????
        vSql += "               else 0 "
        vSql += "           end "
        vSql += "    end current_step, cc_group "
        vSql += "    , case when havepermis.request_id is null then 0 else 1 end havepermis "
        vSql += "    , isnull(( "
        vSql += "        select case "
        vSql += "            when next_step = '-' and flow_complete = 0 then 1 "
        vSql += "            when next_step = '-' and flow_complete = 1 then -1 "
        vSql += "            else 0 "
        vSql += "        end "
        vSql += "        from request_flow rfd "
        vSql += "        where rfd.request_id = request.request_id "
        vSql += "        and rfd.flow_step = request.request_step "
        vSql += "        and rfd.depart_id = request.next_depart "
        vSql += "        and disable = 0 "
        vSql += "    ),0) dash_step "
        vSql += "    , fx01, fx02, shopStock.shop_name, request.shop_code prov_short, area_ro, mx01, mx02, mx03, invdoc_runid "
        
        vSql += "    from ( "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where send_uemail in (" + inGroupEmail + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow_sub "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request "
        vSql += "        where ("
        vSql += "        create_by = '" + uemail + "' or uemail_cc1 = '" + uemail + "' or uemail_cc2 = '" + uemail + "' or uemail_ccv1 = '" + uemail + "' "
        vSql += "        or uemail_verify2 = '" + uemail + "' or uemail_verify1 = '" + uemail + "' or uemail_approve = '" + uemail + "' "
        vSql += "        or '" + uemail + "' in (" + super_admin + ") "
        vSql += "        ) "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, cc_group from vw_cc_group_1 where uemail = '" + uemail + "' "
        vSql += "    ) havepermis "

        vSql += "    left join request on request.request_id = havepermis.request_id "
        vSql += "    left join shopStock.dbo.shopStock shopStock on shopStock.shop_code = request.fx01 "

        vSql += "    left join request_title_dim on request_title_dim.request_title_id = request.request_title_id "
        vSql += "    left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "    left join project_dim on project_dim.project_id = subject_dim.project_id "
        vSql += "    left join request_status on request_status.status_id = request.request_status "
        vSql += "    left join department next_depart on next_depart.depart_id = request.next_depart "
        vSql += "    left join request_invdoc on request_invdoc.request_id = request.request_id "

        vSql += "    where subject_dim.disable = 0 "
        vSql += "    and project_dim.disable = 0 "
        
        vSql += "    and project_dim.project_prefix = '" + xProduct + "' "

        If xSubject <> Nothing Then
            vSql += "   and subject_dim.subject_id in (" + xSubject + ") "
        End If

        If xStatus <> Nothing Then
            vSql += "   and request.request_status in (" + xStatus + ") "
        End If

        If xArea_ro <> Nothing Then
            vSql += "   and request.area_ro in (" + xArea_ro + ") "
        End If

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "request.create_by like '%" + kw + "%' "
            vSql += "or request.request_id like '%" + kw + "%' "
            vSql += "or fx01 like '%" + kw + "%' "
            vSql += "or shop_name like '%" + kw + "%' "
            vSql += "or invdoc_runid like '%" + kw + "%' "
            vSql += ") "
        End If

        vSql += ") all_request "
        vSql += "where 1=1 "

        If xCurrent <> Nothing Then
            vSql += "and ("
            vSql += "   current_step = 1 and dash_step >= 0 "
            vSql += ") "
        End If

        Return vSql
    End Function

    Function rSqlModedata_old_request() As String
        Dim inDepart As String = Request.QueryString("udepart")
        Dim inGroupEmail As String = Request.QueryString("groupemail")
        Dim uemail As String = Request.QueryString("uemail")

        Dim xProduct As String = Request.QueryString("project_id")
        Dim xSubject As String = Request.QueryString("subject_id")
        Dim xStatus As String = Request.QueryString("status_id")
        Dim kw As String = Request.QueryString("kw")
        Dim xCurrent As String = Request.QueryString("current")

        Dim xArea_ro As String = Request.QueryString("area_ro")

        If inDepart = Nothing Then
            inDepart = "999888898"
        End If

        If inGroupEmail = Nothing Then
            inGroupEmail = "'999888898'"
        End If

        Dim vSql As String
        vSql = "select request_id, subject_prefix, subject_name, subject_url "
        vSql += ", project_name, request_title, next_depart_name, status_name "
        vSql += ", create_by, create_date, last_update "
        vSql += ", current_step, havepermis, dash_step "
        vSql += ", amount, account_number, account_name, shop_code, area_ro "
        vSql += ", redebt_number, rp_no, rp_date, prove_date, pay_date "

        vSql += "from ( "
        vSql += "    select request.request_id, project_name, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, status_priority, request.request_status, amount "
        vSql += "    , request.create_by, request.create_date, uemail_cc1, uemail_cc2, uemail_ccv1, uemail_verify1, uemail_verify2, uemail_approve "
        vSql += "    , case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , case when request.request_status <> 100 and request.request_status <> 105 then "
        vSql += "           case "
        vSql += "               when next_depart = 0 and request.create_by = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_ccv1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and cc_group = 1 then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 3 and uemail_verify2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2
        vSql += "               when next_depart = 2 and uemail_verify1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1
        vSql += "               when next_depart = 1 and uemail_approve = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ
        vSql += "               when next_depart in (" + inDepart + ") then 1 " '***** ถ้าเป็นผู้อยู่ใน next_depart นั้น
        vSql += "               when next_depart = 3 and uemail_verify2 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 2 and uemail_verify1 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 1 and uemail_approve in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               else 0 "
        vSql += "           end "
        vSql += "    end current_step, cc_group "
        vSql += "    , account_number, account_name, shop_code, area_ro "
        vSql += "    , redebt_number, rp_no, rp_date, prove_date, pay_date "
        vSql += "    , case when havepermis.request_id is null then 0 else 1 end havepermis "
        vSql += "    , isnull(( "
        vSql += "        select case "
        vSql += "            when next_step = '-' and flow_complete = 0 then 1 "
        vSql += "            when next_step = '-' and flow_complete = 1 then -1 "
        vSql += "            else 0 "
        vSql += "        end "
        vSql += "        from request_flow rfd "
        vSql += "        where rfd.request_id = request.request_id "
        vSql += "        and rfd.flow_step = request.request_step "
        vSql += "        and rfd.depart_id = request.next_depart "
        vSql += "        and disable = 0 "
        vSql += "    ),0) dash_step "
        
        vSql += "    from ( "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where send_uemail in (" + inGroupEmail + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow_sub "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request "
        vSql += "        where ("
        vSql += "        create_by = '" + uemail + "' or uemail_cc1 = '" + uemail + "' or uemail_cc2 = '" + uemail + "' or uemail_ccv1 = '" + uemail + "' "
        vSql += "        or uemail_verify2 = '" + uemail + "' or uemail_verify1 = '" + uemail + "' or uemail_approve = '" + uemail + "' "
        vSql += "        or '" + uemail + "' in (" + super_admin + ") "
        vSql += "        ) "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, cc_group from vw_cc_group_1 where uemail = '" + uemail + "' "
        vSql += "    ) havepermis "

        vSql += "    left join request on request.request_id = havepermis.request_id "
        vSql += "    left join cnepay.dbo.vw_cn_epay epay on epay.cn_no = request.redebt_number "

        vSql += "    left join request_title_dim on request_title_dim.request_title_id = request.request_title_id "
        vSql += "    left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "    left join project_dim on project_dim.project_id = subject_dim.project_id "
        vSql += "    left join request_status on request_status.status_id = request.request_status "
        vSql += "    left join department next_depart on next_depart.depart_id = request.next_depart "

        vSql += "    where 1=1 "

        If xSubject <> Nothing Then
            vSql += "   and subject_dim.subject_id in (" + xSubject + ") "
        End If

        If xStatus <> Nothing Then
            vSql += "   and request.request_status in (" + xStatus + ") "
        End If

        If xArea_ro <> Nothing Then
            vSql += "   and request.area_ro in (" + xArea_ro + ") "
        End If

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "request.create_by like '%" + kw + "%' "
            vSql += "or request.request_id like '%" + kw + "%' "
            vSql += "or request.account_number like '%" + kw + "%' "
            vSql += "or request.account_name like '%" + kw + "%' "
            vSql += "or request.account_number_to like '%" + kw + "%' "
            vSql += "or request.account_name_to like '%" + kw + "%' "
            vSql += "or request.doc_number like '%" + kw + "%' "
            vSql += "or request.bcs_number like '%" + kw + "%' "
            vSql += "or request.redebt_number like '%" + kw + "%' "
            vSql += "or rp_no like '%" + kw + "%' "
            vSql += ") "
        End If

        vSql += ") all_request "
        vSql += "where 1=1 "

        If xCurrent <> Nothing Then
            vSql += "and ("
            vSql += "   current_step = 1 and dash_step >= 0 "
            vSql += ") "
        End If

        Return vSql
    End Function

    '------------------------------------------------------------ modeData ------------------------------------------------------------

    '------------------------------------------------------------ modeApprove ------------------------------------------------------------

    Protected Sub modeApproveAllRequest()
        Dim tabsys As String = Request.QueryString("tabsys")

        Dim vSql As String = "select request_id, create_by "
        vSql += ", project_prefix, project_name "
        vSql += ", subject_prefix, subject_name, subject_url "
        vSql += ", convert(varchar(10), create_date, 103) create_date "
        vSql += ", convert(varchar(10), last_update, 103) last_update "
        vSql += ", dbo.numDatetime(last_update) num_last_update, last_update date_order "
        vSql += ", dash_step "

        If tabsys = "a"
            vSql += ", account_number, amount, count_acc, shop_code "
            vSql += ", convert(varchar(10), dx03, 103) dx03 "
            vSql += "from (" + rSqlModeApprove_A_request() + ") modeApprove "

        Else If tabsys = "b"
            vSql += ", shop_name, fx01 "
            vSql += "from (" + rSqlModeData_B_request() + ") modeApprove "

        Else If tabsys = "c"
            vSql += ", shop_name, fx01, fx02, prov_short, area_ro "
            vSql += "from (" + rSqlModeData_C_request() + ") modeApprove "
    
        Else If tabsys = "d"
            vSql += ", shop_name, fx01, fx02, prov_short, area_ro "
            vSql += "from (" + rSqlModeData_D_request() + ") modeApprove "

        Else If tabsys = "e"
            vSql += ", shop_name, fx01, fx02, prov_short, area_ro "
            vSql += "from (" + rSqlModeData_E_request() + ") modeApprove "

        Else
            vSql += "from (" + rSqlModeData_All_request(1) + ") modeApprove "
        End If

        vSql += "order by date_order "

        ' Response.Write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub modeApproveCountAllRequest()
        Dim tabsys As String = Request.QueryString("tabsys")
        Dim vSql As String

        If tabsys = "a"
            vSql = rSqlModeApprove_A_request()

        Else If tabsys = "b"
            vSql = rSqlModeData_B_request()

        Else If tabsys = "c"
            vSql = rSqlModeData_C_request()
        
        Else If tabsys = "d"
            vSql = rSqlModeData_D_request()

        Else If tabsys = "e"
            vSql = rSqlModeData_E_request()

        Else
            vSql = rSqlModeData_All_request(1)
        End If

        vSql = "select count(1) COUNT_RQ from (" + vSql + ") modeApprove "

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Response.Write(vDT.Rows(0).Item("COUNT_RQ"))
    End Sub

    Function rSqlModeApproveAllRequest() As String
        Dim inDepart As String = Request.QueryString("udepart")
        Dim inGroupEmail As String = Request.QueryString("groupemail")
        Dim uemail As String = Request.QueryString("uemail")

        Dim xProduct As String = Request.QueryString("project_id")
        Dim xSubject As String = Request.QueryString("subject_id")
        Dim xStatus As String = Request.QueryString("status_id")
        Dim kw As String = Request.QueryString("kw")
        Dim xCurrent As String = Request.QueryString("current")

        If inDepart = Nothing Then
            inDepart = "999888898"
        End If

        If inGroupEmail = Nothing Then
            inGroupEmail = "'999888898'"
        End If

        Dim vSql As String
        vSql = "select top 1000 request_id, project_prefix, subject_prefix, subject_name, subject_url "
        vSql += ", project_name, request_title "
        vSql += ", create_by, convert(varchar(10), create_date, 103) create_date, last_update date_order "
        vSql += ", convert(varchar(10), last_update, 103) last_update "
        vSql += ", dbo.numDatetime(last_update) num_last_update "
        vSql += ", current_step, havepermis, dash_step "
        vSql += ", convert(varchar(10), dx03, 103) dx03, shop_code province_name "
        vSql += ", account_number, amount, count_acc "

        vSql += "from ( "
        vSql += "    select request.request_id, project_prefix, project_name, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, status_priority, request.request_status "
        vSql += "    , request.create_by, request.create_date, uemail_cc1, uemail_cc2, uemail_ccv1, uemail_verify1, uemail_verify2, uemail_approve "
        vSql += "    , request.dx03, case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , case when request.request_status <> 100 and request.request_status <> 105 then "
        vSql += "           case "
        vSql += "               when next_depart = 0 and request.create_by = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_ccv1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and cc_group = 1 then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 3 and uemail_verify2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2
        vSql += "               when next_depart = 2 and uemail_verify1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1
        vSql += "               when next_depart = 1 and uemail_approve = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ
        vSql += "               when next_depart in (" + inDepart + ") then 1 " '***** ถ้าเป็นผู้อยู่ใน next_depart นั้น
        vSql += "               when next_depart = 3 and uemail_verify2 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 2 and uemail_verify1 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 1 and uemail_approve in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               else 0 "
        vSql += "           end "
        vSql += "    end current_step, cc_group "
        vSql += "    , request.account_number, account_name, amount, count_acc "
        vSql += "    , redebt_number, rp_no, rp_date, pay_date "
        vSql += "    , case when havepermis.request_id is null then 0 else 1 end havepermis "
        vSql += "    , isnull(( "
        vSql += "        select case "
        vSql += "            when next_step = '-' and flow_complete = 0 then 1 "
        vSql += "            when next_step = '-' and flow_complete = 1 then -1 "
        vSql += "            else 0 "
        vSql += "        end "
        vSql += "        from request_flow rfd "
        vSql += "        where rfd.request_id = request.request_id "
        vSql += "        and rfd.flow_step = request.request_step "
        vSql += "        and rfd.depart_id = request.next_depart "
        vSql += "        and disable = 0 "
        vSql += "    ),0) dash_step "
        vSql += "    , shop_code "
        
        vSql += "    from ( "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where send_uemail in (" + inGroupEmail + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow_sub "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request "
        vSql += "        where ("
        vSql += "        create_by = '" + uemail + "' or uemail_cc1 = '" + uemail + "' or uemail_cc2 = '" + uemail + "' or uemail_ccv1 = '" + uemail + "' "
        vSql += "        or uemail_verify2 = '" + uemail + "' or uemail_verify1 = '" + uemail + "' or uemail_approve = '" + uemail + "' or uemail_takecn = '" + uemail + "' "
        vSql += "        or '" + uemail + "' in (" + super_admin + ") "
        vSql += "        ) "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, cc_group from vw_cc_group_1 where uemail = '" + uemail + "' "
        vSql += "    ) havepermis "

        vSql += "    left join request on request.request_id = havepermis.request_id "
        vSql += "    left join cnepay.dbo.vw_cn_epay epay on epay.cn_no = request.redebt_number "

        vSql += "    left join request_title_dim on request_title_dim.request_title_id = request.request_title_id "
        vSql += "    left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "    left join project_dim on project_dim.project_id = subject_dim.project_id "
        vSql += "    left join request_status on request_status.status_id = request.request_status "
        vSql += "    left join department next_depart on next_depart.depart_id = request.next_depart "
        vSql += "    left join (select * from vw_count_acc_redebt) count_acc on count_acc.account_number = request.account_number "

        vSql += "    where 1=1 "

        If xSubject <> Nothing Then
            vSql += "   and subject_dim.subject_id in (" + xSubject + ") "
        End If

        If xStatus <> Nothing Then
            vSql += "   and request.request_status in (" + xStatus + ") "
        End If

        vSql += ") all_request "

        vSql += "where 1=1 "

        If xCurrent <> Nothing Then
            vSql += "and ("
            vSql += "   current_step = 1 and dash_step >= 0 "
            vSql += ") "
        End If

        vSql += "order by current_step desc, date_order "

        Return vSql
    End Function

    Function rSqlModeApprove_A_request() As String
        Dim xProduct As String = "A"

        Dim inDepart As String = Request.QueryString("udepart")
        Dim inGroupEmail As String = Request.QueryString("groupemail")
        Dim uemail As String = Request.QueryString("uemail")

        Dim xSubject As String = Request.QueryString("subject_id")
        Dim xStatus As String = Request.QueryString("status_id")
        Dim xArea_ro As String = Request.QueryString("area_ro")

        Dim kw As String = Request.QueryString("kw")
        Dim xCurrent As String = Request.QueryString("current")

        If inDepart = Nothing Then
            inDepart = "999888898"
        End If

        If inGroupEmail = Nothing Then
            inGroupEmail = "'999888898'"
        End If

        Dim vSql As String
        vSql = "select request_id, subject_prefix, subject_name, subject_url "
        vSql += ", project_prefix, project_name, request_title, next_depart_name, status_name "
        vSql += ", create_by, create_date, last_update "
        vSql += ", current_step, havepermis, dash_step "
        vSql += ", amount, account_number, account_name, shop_code, area_ro, convert(varchar(10), dx03, 103) dx03 "
        vSql += ", redebt_number, rp_no, rp_date, prove_date, pay_date, count_acc "

        vSql += "from ( "
        vSql += "    select request.request_id, project_prefix, project_name, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, status_priority, request.request_status, amount, count_acc "
        vSql += "    , request.create_by, request.create_date, uemail_cc1, uemail_cc2, uemail_ccv1, uemail_verify1, uemail_verify2, uemail_approve "
        vSql += "    , case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , case when request.request_status <> 100 and request.request_status <> 105 then "
        vSql += "           case "
        vSql += "               when next_depart = 0 and request.create_by = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_cc2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and request.uemail_ccv1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 0 and cc_group = 1 then 1 " '***** ถ้า next_depart เป็นผู้กรอกคำขอ
        vSql += "               when next_depart = 3 and uemail_verify2 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2
        vSql += "               when next_depart = 2 and uemail_verify1 = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1
        vSql += "               when next_depart = 1 and uemail_approve = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ
        ' vSql += "               when next_depart = 8 and uemail_takecn = '" + uemail + "' then 1 " '***** ถ้า next_depart เป็นผู้ลดหนี้ตามเขตพื้นที่ ไม่ต้องแสดงใน modeapprove
        vSql += "               when next_depart in (" + inDepart + ") then 1 " '***** ถ้าเป็นผู้อยู่ใน next_depart นั้น
        vSql += "               when next_depart = 3 and uemail_verify2 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ2 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 2 and uemail_verify1 in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้ตรวจสอบ1 และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               when next_depart = 1 and uemail_approve in (" + inGroupEmail + ") then 1 " '***** ถ้า next_depart เป็นผู้อนุมัติ และเป็นผู้อยู่ใน groupemail นั้น
        vSql += "               else 0 "
        vSql += "           end "
        vSql += "    end current_step, cc_group "
        vSql += "    , request.account_number, account_name, shop_code, area_ro, dx03 "
        vSql += "    , redebt_number, rp_no, rp_date, prove_date, pay_date "
        vSql += "    , case when havepermis.request_id is null then 0 else 1 end havepermis "
        vSql += "    , isnull(( "
        vSql += "        select case "
        vSql += "            when next_step = '-' and flow_complete = 0 then 1 "
        vSql += "            when next_step = '-' and flow_complete = 1 then -1 "
        vSql += "            else 0 "
        vSql += "        end "
        vSql += "        from request_flow rfd "
        vSql += "        where rfd.request_id = request.request_id "
        vSql += "        and rfd.flow_step = request.request_step "
        vSql += "        and rfd.depart_id = request.next_depart "
        vSql += "        and disable = 0 "
        vSql += "    ),0) dash_step "
        
        vSql += "    from ( "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where send_uemail in (" + inGroupEmail + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request_flow_sub "
        vSql += "        where depart_id in (" + inDepart + ") "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, 0 cc_group from request "
        vSql += "        where ("
        vSql += "        create_by = '" + uemail + "' or uemail_cc1 = '" + uemail + "' or uemail_cc2 = '" + uemail + "' or uemail_ccv1 = '" + uemail + "' "
        vSql += "        or uemail_verify2 = '" + uemail + "' or uemail_verify1 = '" + uemail + "' or uemail_approve = '" + uemail + "' "
        vSql += "        or '" + uemail + "' in (" + super_admin + ") "
        vSql += "        ) "
        vSql += "        and request_id not in (select request_id from vw_cc_group_1 where uemail = '" + uemail + "')"
        vSql += "        group by request_id "

        vSql += "        union "
        vSql += "        select request_id, cc_group from vw_cc_group_1 where uemail = '" + uemail + "' "
        vSql += "    ) havepermis "

        vSql += "    left join request on request.request_id = havepermis.request_id "
        vSql += "    left join cnepay.dbo.vw_cn_epay epay on epay.cn_no = request.redebt_number "
        vSql += "    left join (select * from vw_count_acc_redebt) count_acc on count_acc.account_number = request.account_number "

        vSql += "    left join request_title_dim on request_title_dim.request_title_id = request.request_title_id "
        vSql += "    left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "    left join project_dim on project_dim.project_id = subject_dim.project_id "
        vSql += "    left join request_status on request_status.status_id = request.request_status "
        vSql += "    left join department next_depart on next_depart.depart_id = request.next_depart "

        vSql += "    where subject_dim.disable = 0 "
        vSql += "    and project_dim.disable = 0 "

        vSql += "    and project_dim.project_prefix = '" + xProduct + "' "

        If xSubject <> Nothing Then
            vSql += "   and subject_dim.subject_id in (" + xSubject + ") "
        End If

        If xStatus <> Nothing Then
            vSql += "   and request.request_status in (" + xStatus + ") "
        End If

        If xArea_ro <> Nothing Then
            vSql += "   and request.area_ro in (" + xArea_ro + ") "
        End If

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "request.create_by like '%" + kw + "%' "
            vSql += "or request.request_id like '%" + kw + "%' "
            vSql += "or request.account_number like '%" + kw + "%' "
            vSql += "or request.account_name like '%" + kw + "%' "
            vSql += "or request.account_number_to like '%" + kw + "%' "
            vSql += "or request.account_name_to like '%" + kw + "%' "
            vSql += "or request.doc_number like '%" + kw + "%' "
            vSql += "or request.bcs_number like '%" + kw + "%' "
            vSql += "or request.redebt_number like '%" + kw + "%' "
            vSql += "or rp_no like '%" + kw + "%' "
            vSql += ") "
        End If

        vSql += ") all_request "
        vSql += "where 1=1 "

        If xCurrent <> Nothing Then
            vSql += "and ("
            vSql += "   current_step = 1 and dash_step >= 0 "
            vSql += ") "
        End If

        Return vSql
    End Function

    '------------------------------------------------------------ modeApprove ------------------------------------------------------------

    Protected Sub xccAllRequest()
        Dim vSql As String = ""
        vSql += "    select ROW_NUMBER() OVER (ORDER BY request.create_date desc) row_no "
        vSql += "    , request.request_id, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, request.request_status "
        vSql += "    , request.create_by, request.create_date "
        vSql += "    , case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , account_number, account_name, shop_code "
        vSql += "    , redebt_number, rp_no, rp_date, prove_date, pay_date, due_date "
        vSql += "    , amount, 'RO' + create_ro create_ro, 'RO' + area_ro area_ro "
        vSql += "    , case when create_shop = 'none' then 'ไม่ได้ประจำ Shop' else create_shop end create_shop "
        vSql += "    , doc_number, bcs_number, uemail_approve, after_end_status_name "
        vSql += "    , pick_refund.pick_refund_title, tx01 "
        vSql += "    , case when pick_refund.pick_refund_type = 0 then bank_title end bank_title "
        vSql += "    , case when pick_refund.pick_refund_type = 0 then fx02 end fx02 "
        vSql += "    , case "
        vSql += "       when redebt_bank_code.bank_code <> 2 and due_date is not null then ' (+2 วันทำการ)' "
        vSql += "       else '' "
        vSql += "    end txt_due_date "
        vSql += CF.rSqlSearchAllRequest()

        ' Response.Write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub searchAllRequest()
        Dim xPageSize As Integer = Request.QueryString("page_size")
        Dim xPageNum As Integer = Request.QueryString("page_num")
        Dim xSorting As String = Request.QueryString("sorting")

        If xSorting = Nothing Then
            xSorting = "request.create_date desc"
        End If

        Dim row_start As Integer = 1
        Dim row_end As Integer = (xPageNum * xPageSize)

        If xPageNum > 1 Then
            row_start = ((xPageNum - 1) * xPageSize) + 1
        End If

        Dim vSql As String
        vSql = "WITH ALL_RQ AS ( "
        vSql += "    select ROW_NUMBER() OVER (ORDER BY " + xSorting + ") row_no "
        vSql += "    , request.request_id, subject_prefix, subject_name, subject_url "
        vSql += "    , request_title_dim.request_title, next_depart.depart_name next_depart_name "
        vSql += "    , status_name, request.request_status "
        vSql += "    , request.create_by, request.create_date "
        vSql += "    , case when last_update is null then request.create_date else last_update end last_update "
        vSql += "    , account_number, account_name, shop_code "
        vSql += "    , redebt_number, rp_no, rp_date, prove_date, pay_date, due_date "
        vSql += "    , amount, 'RO' + create_ro create_ro, 'RO' + area_ro area_ro "
        vSql += "    , case when create_shop = 'none' then 'ไม่ได้ประจำ Shop' else create_shop end create_shop "
        vSql += "    , doc_number, bcs_number, uemail_approve, after_end_status_name "
        vSql += CF.rSqlSearchAllRequest()
        vSql += ") "

        vSql += "SELECT * FROM ALL_RQ WHERE row_no BETWEEN " & row_start & " AND " & row_end & ";"

        'Response.Write(vSql)
         Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub searchAllRequestCount()
        Dim vSql As String = "select count(1) COUNT_RQ "
        vSql += CF.rSqlSearchAllRequest()

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Response.Write(vDT.Rows(0).Item("COUNT_RQ"))
    End Sub

    Protected Sub loadCurrentPatchModeData()
        Dim vSql As String = CP.rLoadCurrentPatch()
        vSql += "and mode_data = 1 "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadCurrentPatchModeApprove()
        Dim vSql As String = CP.rLoadCurrentPatch()
        vSql += "and mode_approve = 1 "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub acknowPatch()
        Dim res As Integer = 0

        Dim xPatch_number As String = Request.Form("patch_number")
        Dim xUemail As String = Request.Form("uemail")

        Dim vSqlIn As String = "update xpatch_close_popup set "
        vSqlIn += "patch_number = '" & xPatch_number & "' "
        vSqlIn += ", update_date = getdate() "
        vSqlIn += "where uemail = '" & xUemail & "' "

        If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
            res = 1
        End If

        ' res = 1 success
        Response.Write(res)
    End Sub

    Protected Sub loadNotReadPatchModeData()
        Dim vSql As String = CP.rLoadNotReadedPatch()
        vSql += "and mode_data = 1 "

        vSql += "order by patch_date desc, patch_number desc "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadNotReadPatchModeApprove()
        Dim vSql As String = CP.rLoadNotReadedPatch()
        vSql += "and mode_approve = 1 "
        
        vSql += "order by patch_date desc, patch_number desc "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub readingPatch()
        Dim res As Integer = 0

        Dim xPatch_number As String = Request.Form("patch_number")
        Dim xUemail As String = Request.Form("uemail")

        Dim vSqlIn As String = "insert into xpatch_readed (uemail, patch_number) values ('" & xUemail & "', '" & xPatch_number & "') "

        If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
            res = 1
        End If

        ' res = 1 success
        Response.Write(res)
    End Sub

    Protected Sub loadProjectTabList()
        Dim vSql As String = "select project_id, project_prefix, project_name  "
        vSql += "from project_dim "
        vSql += "where disable = 0 "
        vSql += "order by project_prefix "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub
    Protected Sub loadCountFlowReject()
        Dim vSql As String = "select "
        vSql += "case when max(reject_no) is null then 0 else max(reject_no) end max_reject_no "
        vSql += "from request_flow_xback_reject "
        vSql += "where request_id = '" & Request.QueryString("request_id") & "' "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadRequestFlowReject()
        Dim vRequest_id As String = Request.QueryString("request_id")
        Dim vSql As String = CF.rSqlRequestFlowReject(vRequest_id)

        ' Response.Write(vSql)

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim vJson As String = ""

        For i As Integer = 0 To vDT.Rows().Count() - 1
            Dim vFile As String = "-"

            If vDT.Rows(i).Item("flow_file").Trim() <> "" Then
                If CF.rCheckLoginCanOpenFile(vRequest_id) > 0 Then
                    vFile = CF.rLinkOpenfile(vRequest_id, vDT.Rows(i).Item("path_file"), vDT.Rows(i).Item("flow_file"))
                Else
                    vFile = CF.file_dont_request_permiss
                End If
            End If

            vJson += "{"
            vJson += " ""reject_no"":""" & vDT.Rows(i).Item("reject_no") & """ ,"
            vJson += " ""flow_step"":""" & vDT.Rows(i).Item("flow_step") & """ ,"
            vJson += " ""flow_sub_step"":""" & vDT.Rows(i).Item("flow_sub_step") & """ ,"
            vJson += " ""next_step"":""" & vDT.Rows(i).Item("next_step") & """ ,"
            vJson += " ""back_step"":""" & vDT.Rows(i).Item("back_step") & """ ,"
            vJson += " ""uemail"":""" & CF.rSplit_uemail(vDT.Rows(i).Item("send_uemail"), vDT.Rows(i).Item("uemail")) & """ ,"
            vJson += " ""depart_id"":""" & vDT.Rows(i).Item("depart_id") & """ ,"
            vJson += " ""depart_name"":""" & vDT.Rows(i).Item("depart_name") & """ ,"
            vJson += " ""flow_status"":""" & vDT.Rows(i).Item("flow_status") & """ ,"
            vJson += " ""status_name"":""" & vDT.Rows(i).Item("status_name") & """ ,"
            vJson += " ""update_date"":""" & vDT.Rows(i).Item("update_date") & """ ,"
            vJson += " ""update_by"":""" & vDT.Rows(i).Item("update_by") & """ ,"
            vJson += " ""flow_remark"":""" & CP.rValidJson(vDT.Rows(i).Item("flow_remark")) & """, "
            vJson += " ""flow_file"":""" & vFile & """ "
            vJson += "},"
        Next

        If vJson <> Nothing Then
            vJson = "[" + vJson
            vJson = vJson.Remove(vJson.Length - 1, 1)
            vJson += "]"
        Else
            vJson = "[]"
        End If

        ' Response.Write(CP.rConvertDataTableToJSONv2(vDT))
        Response.Write(vJson)
    End Sub

    Protected Sub strReplaceUserify()
        Dim xDepart_id As String = Request.QueryString("depart_id")

        Dim vSql As String = "DECLARE @old_uemail varchar(100), @new_uemail varchar(100); "
        vSql += "SET @old_uemail = '" + Request.QueryString("old_uemail") + "'; "
        vSql += "SET @new_uemail = '" + Request.QueryString("new_uemail") + "'; "

        vSql += "select request.request_id "
        vSql += "from request_flow "
        vSql += "join request on request.request_id = request_flow.request_id "
        vSql += "where request_flow.uemail = @old_uemail "
        vSql += "and request_flow.flow_complete = 0 "
        vSql += "and request_status not in (100,105) "
        vSql += "and request_flow.depart_id = " & xDepart_id & " "

        vSql += "union "
        vSql += "select request.request_id "
        vSql += "from request_flow_sub request_flow "
        vSql += "join request on request.request_id = request_flow.request_id "
        vSql += "where request_flow.uemail = @old_uemail "
        vSql += "and request_flow.flow_complete = 0 "
        vSql += "and request_status not in (100,105) "
        vSql += "and request_flow.depart_id = " & xDepart_id & " "
        vSql += "order by 1 desc "

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim vSqlIn As String = ""

        If vDT.Rows().Count() > 0 Then
            Dim U(8) As String
            U(1) = "uemail_approve"
            U(2) = "uemail_verify1"
            U(3) = "uemail_verify2"
            U(8) = "uemail_takecn"

            vSqlIn = "DECLARE @old_uemail varchar(100), @new_uemail varchar(100); <BR>"
            vSqlIn += "SET @old_uemail = '" + Request.QueryString("old_uemail") + "'; <BR>"
            vSqlIn += "SET @new_uemail = '" + Request.QueryString("new_uemail") + "'; <BR><BR>"

            For i As Integer = 0 To vDT.Rows.Count - 1
                vSqlIn += "update request set " + U(xDepart_id) + " = @new_uemail, uemail_ccv1 = REPLACE(uemail_ccv1, @old_uemail, @new_uemail) where request_id = '" & vDT.Rows(i).Item("request_id") & "' <BR>"
                vSqlIn += "update request_flow set uemail = REPLACE(uemail, @old_uemail, @new_uemail), send_uemail = REPLACE(send_uemail, @old_uemail, @new_uemail) where flow_complete = 0 and uemail = @old_uemail and depart_id = '" & xDepart_id & "' and request_id = '" & vDT.Rows(i).Item("request_id") & "' <BR>"
                vSqlIn += "update request_flow_sub set uemail = REPLACE(uemail, @old_uemail, @new_uemail), send_uemail = REPLACE(send_uemail, @old_uemail, @new_uemail) where flow_complete = 0 and uemail = @old_uemail and depart_id = '" & xDepart_id & "' and request_id = '" & vDT.Rows(i).Item("request_id") & "' <BR><BR>"
            Next
        End If

        Response.Write(vSqlIn)
    End Sub

    Function limitStr(ByVal vStr As String, ByVal vLimit As Integer) As String
        If vStr.Length > vLimit Then
            Return vStr.Substring(0, vLimit) & "..."
        Else
            Return vStr
        End If
    End Function

    Function itemNull(ByVal vStr As Object) As String
        If IsDBNull(vStr) Then
            Return "-"
        Else If vStr.ToString().Length = 0 Then
            Return "-"
        Else If vStr.ToString().Trim() = "" Then
            Return "-"
        Else
            Return vStr
        End If
    End Function

    Function itemBlank(ByVal vStr As String) As String
        If IsDBNull(vStr) Then
            Return ""
        Else If vStr.ToString().Length = 0 Then
            Return ""
        Else If vStr.ToString().Trim() = "" Then
            Return ""
        Else
            Return vStr
        End If
    End Function

End Class
