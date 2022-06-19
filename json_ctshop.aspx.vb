Imports System.Data
Imports System.Web.Script.Serialization
Imports System.Collections.Generic

Partial Class json_ctshop
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim qrs As String = ""

        If Request.QueryString("qrs") <> Nothing Then
            qrs = Request.QueryString("qrs")
        End If

        If qrs = "autoShopCode" Then
            autoShopCode()
        End If

        If qrs = "getProvinceShort" Then
            getProvinceShort()
        End If

        If qrs = "getShopCode" Then
            getShopCode()
        End If

        If qrs = "getRequest" Then
            getRequest()
        End If

        If qrs = "searchRequestShop" Then
            searchrequestShop()
        End If

    End Sub

    Protected Sub autoShopCode()
        Dim kw As String = Request.QueryString("kw")

        Dim vSql As String = "select ro, cluster, province_short, province_name "
        vSql += ", shop_code, shop_name "
        vSql += "from vw_shopStock_joined_pos "
        vSql += "where (ro is not null "
        vSql += "and cluster is not null "
        vSql += "and province_short is not null) "
        vSql += "and ( "

        If kw <> Nothing Then
            vSql += "shop_code like '%" + kw + "%' "
            vSql += "or shop_name like '%" + kw + "%' "
            vSql += "or shop_location like '%" + kw + "%' "
            vSql += "or shop_address like '%" + kw + "%' "
            vSql += "or province_short like '%" + kw + "%' "
            vSql += "or province_name like '%" + kw + "%' "
        Else
            vSql += "1 = 0 "
        End If

        vSql += ") "
        vSql += "order by ro, cluster, province_short, shop_code "

        Response.Write(CP.rJsonDBv4(vSql, "DBShopStock"))
    End Sub

    Protected Sub getProvinceShort()
        Dim vSql As String = "select ro, shop_code, shop_name, province_short, province_name "
        vSql += "from RMSDAT.dbo.vw_branch_shop "
        vSql += "where shop_code = '" + Request.QueryString("shop_code") + "' "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub
    
    Protected Sub getRequest()
        Dim xRequest_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select request_id, subject_prefix, request_title_dim.request_title, request_remark "
        vSql += ", convert(varchar(10), request.create_date, 103) create_date "
        ' vSql += ", request.create_by + ' (RO' + create_ro + ')' create_by "
        vSql += ", request.create_by + ' (' + "
        vSql += "case when create_shop is null or create_shop = 'none' then 'ไม่ได้ประจำ Shop' else create_shop + ' ' + by_shop.shop_name end "
        vSql += " + ')' create_by "

        vSql += ", case when fx01 is null then '-' when fx01 = '' then '-' else fx01 + ' ' + req_shop.shop_name end shop_name "
        vSql += ", request.shop_code + ' ' + area.province_name province_name "
        vSql += ", fx02 + ' (RO' + area_ro + ')' area_ro "
        vSql += ", case when fx03 = '99999' then mx02 + ' (' + phase_title + ')' else phase_title end phase_title "
        vSql += ", storeplacetype_name, tx01, mx01 "
        vSql += ", ax04, ax07, ax09, ax10, ax13, ax16, ax17, ax19 "
        ' vSql += ", case when ax04 is null then '-' when ax04 = '' then '-' when ax04 = 0 then 'คงเดิม' else ax04 + '%' end ax04 "
        ' vSql += ", case when ax07 is null then '-' when ax07 = '' then '-' else ax07 + ' บาท/เดือน (รวม VAT)' end ax07 "
        ' vSql += ", case when ax09 is null then '-' when ax09 = '' then '-' else ax09 + ' บาท/เดือน' end ax09 "
        ' vSql += ", case when ax10 is null then '-' when ax10 = '' then '-' else ax10 + ' บาท/เดือน (รวม VAT)' end ax10 "
        ' vSql += ", case when ax13 is null then '-' when ax13 = '' then '-' else ax13 + ' ' + mx01 end ax13 "
        ' vSql += ", case when ax16 is null then '-' when ax16 = '' then '-' else ax16 + ' บาท' end ax16 "
        ' vSql += ", case when ax17 is null then '-' when ax17 = '' then '-' else ax17 + ' บาท/เดือน (รวม VAT)' end ax17 "
        ' vSql += ", case when ax19 is null then '-' when ax19 = '' then '-' else ax19 + ' ตร.ม.' end ax19 "
        vSql += "from request "

        vSql += "left join shopStock.dbo.vw_shopStock_joined_pos by_shop "
        vSql += "on by_shop.shop_code = request.create_shop "

        vSql += "left join shopStock.dbo.vw_shopStock_joined_pos req_shop "
        vSql += "on req_shop.shop_code = request.fx01 "

        vSql += "left join ( "
        vSql += "   select ro, cluster, province_code, province_short, province_name "
        vSql += "   from RMSDAT.dbo.vw_branch_shop "
        vSql += "   group by ro, cluster, province_code, province_short, province_name "
        vSql += ") area on area.province_short = request.shop_code " 'shop_code คือ province_short

        vSql += "left join request_title_dim "
        vSql += "on request_title_dim.request_title_id = request.request_title_id "

        vSql += "left join subject_dim "
        vSql += "on subject_dim.subject_id = request_title_dim.subject_id "

        vSql += "left join shopStock.dbo.storeplacetype "
        vSql += "on storeplacetype.storeplacetype_id = request.sx01 "

        vSql += "left join shopStock.dbo.contract_phase "
        vSql += "on contract_phase.phase_id = request.fx03 "

        vSql += "where request_id = '" & xRequest_id & "' "
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub getShopCode()
        Dim xProvince as string = Request.QueryString("province")
        Dim vSql As String = "select ro, cluster, province_code, province_short, shop_code, shop_name "
        vSql += "from [10.11.5.106].[RMSDAT01].[dbo].[vw_branch_shop] "

        If xProvince <> Nothing Then
            vSql += "where province_short in (" & xProvince & ") "
        End If

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub searchRequestShop()
        Dim keyword as string = Request.QueryString("kw")
        Dim area as string = Request.QueryString("area_ro")
        Dim shopcode as string = Request.QueryString("shop_code")
        Dim vSql As String = ""
        vSql += "SELECT * FROM ("
        vSql += "select request.request_id, "
        vSql += "project_dim.project_prefix+'.'+project_dim.project_name as project_name, "
        vSql += "subject_dim.subject_prefix+'.'+subject_dim.subject_name as subtitle_name, "
        vSql += "request.request_title,request.create_ro, "
       ' vSql += "branchshop.province_name as province, "
        vSql += "request.fx01 as shopcode, request.fx03 as shopname, "
        vSql += "request.create_by, 'new' as request_type, "
        vSql += "request.create_date,request.last_update,request_status.status_name,next_depart.depart_name "
        vSql += "from request "
        vSql += "left join request_title_dim on request_title_dim.request_title_id = request.request_title_id "
        vSql += "left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "left join project_dim on project_dim.project_id = subject_dim.project_id " 
        vSql += "left join request_status on request_status.status_id = request.request_status " 
        vSql += "left join department next_depart on next_depart.depart_id = request.next_depart "
       ' vSql += "inner join [10.11.5.106].[RMSDAT01].[dbo].[vw_branch_shop] branchshop on branchshop.province_short = request.shop_code " 
        vSql += "where subject_dim.disable = 0 and project_dim.disable = 0 "
        vSql += "and subject_dim.subject_id in (1804001) "
        vSql += "and request.request_status in (0,110,10,20,50,60,105) "
        if keyword <> Nothing
            vSql += "and request.request_id = '"+keyword+"' "
        end if
        if area <> Nothing
            vSql += "and request.create_ro = '"+area+"' "
        end if
        if shopcode <> Nothing
            vSql += "and request.fx01 = '"+shopcode+"' "
        end if
        vSql += "UNION all "
        vSql += "select RequestNo as request_id,'-' as project_name,'-' as subtitle_name, "
        vSql += "type.TypeName as request_title,Area as create_ro, "
       ' vSql += "Province as province, "
        vSql += "CodeShop as shopcode,ShopName as shopname, "
        vSql += "replace(email,'@jasmine.com' ,'' ) as createby, 'old' as request_type, "
        vSql += "convert(datetime,DateAdd,120) as create_date,UpdateDate as last_update, "
        vSql += "status.StatusName as status_name,'-' as depart_name "
        vSql += "from [RequestShop].[dbo].[OpenShop] openshop "
        vSql += "left join [RequestShop].[dbo].[Status] status on openshop.RequestStatus = status.StatusCode "
        vSql += "left join [RequestShop].[dbo].[RequestType] type on openshop.RequestType = type.RequestType "
        vSql += "where openshop.RequestStatus not in(20) "
        if keyword <> Nothing
            vSql += "and openshop.RequestNo = '"+keyword+"' "
        end if
        if area <> Nothing
            vSql += "and openshop.Area = '"+area+"' "
        end if
        if shopcode <> Nothing
            vSql += "and openshop.CodeShop = '"+shopcode+"' "
        end if
        vSql += ") as table_all "
        ' vSql += "where shop_code = '" + Request.QueryString("shop_code") + "' "
        'Response.write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

End Class
