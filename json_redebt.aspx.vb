Imports System.Data
Imports System.Web.Script.Serialization
Imports System.Collections.Generic

Partial Class json_redebt
    Inherits System.Web.UI.Page
    Dim DB106 As New Cls_Data
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim qrs As String = ""

        If Request.QueryString("qrs") <> Nothing Then
            qrs = Request.QueryString("qrs")
        End If

        If qrs = "loadCause" Then
            loadCause()
        End If

        If qrs = "searchReceiptPOS" Then
            searchReceiptPOS()
        End If

        If qrs = "searchAccount" Then
            searchAccount()
        End If

        If qrs = "autoEmp" Then
            autoEmp()
        End If

        If qrs = "getEmpDetail" Then
            getEmpDetail()
        End If

        If qrs = "searchReceipt" Then
            searchReceipt()
        End If

        If qrs = "getRedebtDoc" Then
            getRedebtDoc()
        End If

        If qrs = "getCNepay" Then
            getCNepay()
        End If

        If qrs = "count_acc_RQprocess" Then
            count_acc_RQprocess()
        End If

        If qrs = "count_acc_RQclose" Then
            count_acc_RQclose()
        End If

        If qrs = "loadRedebtHistoryInProcess" Then
            loadRedebtHistoryInProcess()
        End If

        If qrs = "loadRedebtHistoryInClose" Then
            loadRedebtHistoryInClose()
        End If

        If qrs = "getRedebtFile" Then
            getRedebtFile()
        End If

        If qrs = "searchRedebtClear" Then
            searchRedebtClear()
        End If

        If qrs = "autoDepartUser" Then
            autoDepartUser()
        End If

        If qrs = "autoShopCode" Then
            autoShopCode()
        End If

        If qrs = "autoProvince" Then
            autoProvince()
        End If

        If qrs = "getRequest" Then
            getRequest()
        End If

        If qrs = "submitApproveFlow" Then
            submitApproveFlow()
        End If

        If qrs = "checkUsedReceipt" Then
            checkUsedReceipt()
        End If

        If qrs = "getRedebtPos" Then
            getRedebtPos()
        End If

        If qrs = "loadPickRefund" Then
            loadPickRefund()
        End If

        If qrs = "loadPickRefundIn" Then
            loadPickRefundIn()
        End If

        If qrs = "loadPickRefundType" Then
            loadPickRefundType()
        End If

        If qrs = "loadCheckEditRefund" Then
            loadCheckEditRefund()
        End If

        If qrs = "submitEditRefund" Then
            submitEditRefund()
        End If

        If qrs = "loadDepartmentSearch" Then
            loadDepartmentSearch()
        End If

        If qrs = "loadAfterStatusSearch" Then
            loadAfterStatusSearch()
        End If

        If qrs = "loadAfterStatusSelected" Then
            loadAfterStatusSelected()
        End If

        If qrs = "loadAfterEndLasted" Then
            loadAfterEndLasted()
        End If

        If qrs = "updateAfterEnd" Then
            updateAfterEnd()
        End If

        If qrs = "loadBankCode" Then
            loadBankCode()
        End If

        If qrs = "countRedebtPOS" Then
            countRedebtPOS()
        End If

        If qrs = "loadRedocItem" Then
            loadRedocItem()
        End If

        If qrs = "loadRedocAdapter" Then
            loadRedocAdapter()
        End If

        If qrs = "loadRedocForClaim" Then
            loadRedocForClaim()
        End If

        If qrs = "statusDotRedocItem" Then
            statusDotRedocItem()
        End If

        If qrs = "countRedocRQprocess" Then
            countRedocRQprocess()
        End If

        If qrs = "countRedocRQclose" Then
            countRedocRQclose()
        End If

        If qrs = "loadRedocHistoryInProcess" Then
            loadRedocHistoryInProcess()
        End If

        If qrs = "loadRedocHistoryInClose" Then
            loadRedocHistoryInClose()
        End If

        If qrs = "CheckCompanyReceipt" Then
            CheckCompanyReceipt()
        End If

        If qrs = "checkEPayGroupReceipt" Then
            checkEPayGroupReceipt()
        End If

        If qrs = "rejectEPayGroupReceipt" Then
            rejectEPayGroupReceipt()
        End If

        If qrs = "fixreject" Then
            fixreject()
        End If
    End Sub

    Protected Sub searchReceiptPOS()
        Dim xDocNum As String = Request.QueryString("doc_number")

        Dim vSql As String = "select account_num, account_name, '' bcs_receipt_id"
        vSql += ", pos_receipt_id, receipt_date, receipt_amount "
        ' vSql += ", m30.f03 ro, all_receipt.shop_code shop_code, province_short "
        ' vSql += ", branch.ro, case when branch.province_short = 'bkk' then '' else branch.province_short end province_short, all_receipt.shop_code shop_code "
        vSql += ", branch.ro, case when branch.province_short = 'bkk' and all_receipt.shop_code <> 'BKKA0' then '' else branch.province_short end province_short, all_receipt.shop_code shop_code "
        vSql += "from ( "
        vSql += "    select onetime.f02 shop_code, "
        vSql += "    onetime.f05 pos_receipt_id, cast(onetime.f06 as date) receipt_date, onetime.f33 receipt_amount, "
        vSql += "    onetime.f35 account_num, onetime.f36 + ' ' + onetime.f37 + ' ' + onetime.f38 account_name "
        vSql += "    from r17520 onetime "
        vSql += "    where onetime.f05 = '" + xDocNum + "' "

        vSql += "    union "
        vSql += "    select billpay.f02 shop_code, "
        vSql += "    billpay.f05 pos_receipt_id, cast(billpay.f06 as date) receipt_date, billpay.f33 receipt_amount, "
        vSql += "    billpay.f35 account_num, billpay.f36 + ' ' + billpay.f37 + ' ' + billpay.f38 account_name "
        vSql += "    from r17510 billpay "
        vSql += "    where billpay.f05 = '" + xDocNum + "' "
        vSql += "    and billpay.f04='DRCPV' "

        vSql += "    union "
        vSql += "    select kaysod.f02 shop_code, "
        vSql += "    kaysod.f05 pos_receipt_id, cast(kaysod.f06 as date) receipt_date, kaysod.f34 receipt_amount, "
        vSql += "    kaysod.f11 account_num, kaysod.f45 account_name "
        vSql += "    from r11060 kaysod "
        vSql += "    where kaysod.f05 = '" + xDocNum + "' "

        vSql += ") all_receipt "
        vSql += "join vw_branch_shop_all branch on branch.shop_code = all_receipt.shop_code "
        ' vSql += "join m00030 m30 on m30.f02 = all_receipt.shop_code "
        ' vSql += "left join vw_branch_shop_all branch on branch.shop_code = all_receipt.shop_code "

        Response.Write(CP.rJsonDBv4(vSql, "DB106"))
    End Sub

    Protected Sub searchAccount()
        Dim vJson As String = ""
        Dim sv As New newsearchcustomer.searchcustomer
        Dim account_number As String = Request.QueryString("account_number")

        If sv.SearchCustomer("", "", account_number).transactions.Length > 0 Then
            For i As Integer = 0 To sv.SearchCustomer("", "", account_number).transactions.Length - 1

                If sv.SearchCustomer("", "", account_number).transactions(0).prefix_name <> "" _
                Or sv.SearchCustomer("", "", account_number).transactions(0).first_name <> "" _ 
                Or sv.SearchCustomer("", "", account_number).transactions(0).last_name <> "" _
                Then
                    vJson += "{"
                    'vJson += " ""length"":""" & sv.SearchCustomer("", "", account_number).transactions.Length & """ ,"
                    vJson += " ""prefix_name"":""" & sv.SearchCustomer("", "", account_number).transactions(0).prefix_name & """ ,"
                    vJson += " ""first_name"":""" & sv.SearchCustomer("", "", account_number).transactions(0).first_name & """ ,"
                    vJson += " ""last_name"":""" & sv.SearchCustomer("", "", account_number).transactions(0).last_name & """"
                    vJson += "},"
                End If

            Next
        End If

        If vJson <> Nothing Then
            vJson = "[" + vJson
            vJson = vJson.Remove(vJson.Length - 1, 1)
            vJson += "]"
        Else
            vJson = "[]"
        End If

        Response.Write(vJson)
    End Sub

    Protected Sub count_acc_RQprocess() '***** นับเฉพาะคำขอที่ยังไม่ปิด
        Dim account_number As String = Request.QueryString("account_number")
        Dim request_id As String = Request.QueryString("request_id")

        Dim vSql As String
        vSql = "select COUNT(1) count_acc from request "
        vSql += "where account_number = '" + account_number + "'"
        vSql += "and account_number <> '' and account_number is not null "
        vSql += "and request_status <> 105 and request_status <> 100 "
        vSql += "and request_id <> '" + request_id + "'"

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim count_acc As Integer = 0

        If vDT.Rows().Count() > 0 Then
            count_acc = vDT.Rows(0).Item("count_acc")
        End If

        Response.Write(count_acc)
    End Sub

    Protected Sub count_acc_RQclose() '***** นับเฉพาะคำขอที่ปิดแล้ว
        Dim account_number As String = Request.QueryString("account_number")

        Dim vSql As String
        vSql = "select COUNT(1) count_acc from request "
        vSql += "where account_number = '" + account_number + "'"
        vSql += "and account_number <> '' and account_number is not null "
        vSql += "and request_status <> 105 and request_status = 100 "

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim count_acc As Integer = 0

        If vDT.Rows().Count() > 0 Then
            count_acc = vDT.Rows(0).Item("count_acc")
        End If

        Response.Write(count_acc)
    End Sub

    Protected Sub loadCause()
        Dim request_title_id As String = Request.QueryString("request_title_id")

        Dim vSql_main As String = "select rc.redebt_cause_id, rc.request_title_id, redebt_cause_title "
        vSql_main += "from redebt_cause rc "
        vSql_main += "inner join redebt_cause_title rt "
        vSql_main += "on rt.redebt_cause_id = rc.redebt_cause_id "
        vSql_main += "where rt.disable = 0 "

        Dim vSql As String = vSql_main
        vSql += "and request_title_id = '" + request_title_id + "' "

        vSql += "UNION ALL "
        vSql += vSql_main
        vSql += "and request_title_id = 0 "
        vSql += "and NOT EXISTS ( "
        vSql += "   " + vSql_main
        vSql += "   and request_title_id = '" + request_title_id + "' "
        vSql += ") "

        vSql += "order by redebt_cause_title "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadCause_back()
        Dim request_title_id As String = Request.QueryString("request_title_id")

        Dim vSql As String = "select rc.redebt_cause_id, rc.request_title_id, redebt_cause_title "
        vSql += "from redebt_cause rc "
        vSql += "inner join redebt_cause_title rt "
        vSql += "on rt.redebt_cause_id = rc.redebt_cause_id "
        vSql += "where rt.disable = 0 "
        vSql += "and (request_title_id = 0 or request_title_id = '" + request_title_id + "')"
        vSql += "order by redebt_cause_title "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub autoEmp_20170824()
        Dim xKeyword As String = Request.QueryString("kw")
        Dim xToken As String = Request.QueryString("token")
        
        Dim vJson As String
        vJson = CP.rGetDataOAuthjson(xKeyword, xToken)

        'Add Group email'
        Dim vJson_addon As String = ""
        Dim vGroup_support_op As String = "{""thaiFullname"":""support op"",""email"":""support_op@jasmine.com"",""position"":""group email"",""section"":null,""division"":null,""department"":""RO10"",""accountStatus"":true,""dateExpired"":null},"
        'Dim vGroup_support_op As String = ""
        Dim vKw_support_op As String = "supportop,support op,ro10"
        'Dim vKw_support_op As String = ""

        Dim vPanu As String = "{""thaiFullname"":""ภาณุพงศ์ พันธ์เวช"",""email"":""panupong.pa@jasmine.com"",""position"":""positionfix"",""section"":null,""division"":null,""department"":""departadmin"",""accountStatus"":true,""dateExpired"":null},"
        Dim vKw_panu As String = "panupong.pa"

        If vKw_support_op Like "*" + xKeyword + "*" Then
            vJson_addon += vGroup_support_op
        End If

        If vKw_panu Like "*" + xKeyword + "*" Then
            vJson_addon += vPanu
        End If

        If vJson_addon.Length > 0 Then
            vJson_addon = vJson_addon.Remove(vJson_addon.Length - 1, 1)
            vJson = vJson.Remove(vJson.Length - 1, 1)
            vJson += "," + vJson_addon + "]"
        End If
        'Add Group email'

        Response.Write(vJson)
    End Sub

    Protected Sub getEmpDetail()
        Dim xUemail As String = Request.QueryString("uemail")
        Dim xToken As String = Request.QueryString("token")
        
        Dim vJson As String
        ' vJson = CP.rGetDataOAuthjson(xUemail & "@jasmine.com", xToken)

        Dim vDT_OAUTH As New DataTable 
        vDT_OAUTH = CP.rGetDataOAuthDT(xUemail, xToken)

        If vDT_OAUTH.Rows.Count > 0 Then
            For i2 As Integer = 0 To vDT_OAUTH.Rows.Count - 2
                If xUemail & "@jasmine.com" = vDT_OAUTH.Rows(i2).Item("email") _
                AND (vDT_OAUTH.Rows(i2).Item("dateExpired") = "" Or vDT_OAUTH.Rows(i2).Item("dateExpired") = "null") _
                And vDT_OAUTH.Rows(i2).Item("accountStatus") = "true" Then

                    vJson += "{"
                    vJson += " ""thaiFullname"":""" & vDT_OAUTH.Rows(i2).Item("thaiFullname") & """ ,"
                    vJson += " ""engFullname"":""" & vDT_OAUTH.Rows(i2).Item("engFullname") & """ ,"
                    vJson += " ""email"":""" & vDT_OAUTH.Rows(i2).Item("email") & """ ,"
                    vJson += " ""position"":""" & vDT_OAUTH.Rows(i2).Item("position") & """ ,"
                    vJson += " ""department"":""" & vDT_OAUTH.Rows(i2).Item("department") & """ ,"
                    vJson += " ""section"":""" & vDT_OAUTH.Rows(i2).Item("section") & """ ,"
                    vJson += " ""division"":""" & vDT_OAUTH.Rows(i2).Item("division") & """ "
                    vJson += "},"
                End If
            Next
        End If

        If vJson <> Nothing Then
            vJson = "[" + vJson
            vJson = vJson.Remove(vJson.Length - 1, 1)
            vJson += "]"
        Else
            vJson = "[]"
        End If

        '''''''''''' hard coded ''''''''''''
        If xUemail = "pornphimon.k" Then
            vJson = "[]"
        End If
        '''''''''''' hard coded ''''''''''''

        Response.Write(vJson)
    End Sub

    Protected Sub searchReceipt()
        Dim account_number As String = ""
        Dim bcs_receipt As String = ""
        Dim pos_receipt As String = ""

        If Request.QueryString("account_number") <> Nothing Then
            account_number = Request.QueryString("account_number")
        End If

        If Request.QueryString("bcs_receipt") <> Nothing Then
            bcs_receipt = Request.QueryString("bcs_receipt")
        End If
        
        If Request.QueryString("pos_receipt") <> Nothing Then
            pos_receipt = Request.QueryString("pos_receipt")
        End If

        'Dim sv As New getaccountcninfo.getaccountcninfo
        Dim sv As New newgetaccountcninfo.getaccountcninfo
        Dim res As New getaccountcninfo.response
        Dim vJson As String = ""

        If sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details.Length > 0 Then
            'vJson += " {""length"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details.Length & """ ,"
            'vJson += " ""resultCode"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(0).resultCode & """ ,"
            'vJson += " ""resultMsg"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(0).resultMsg & """ },"

            If sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(0).resultMsg = "" Then 
                For i As Integer = 0 To sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details.Length - 1
                    vJson += "{"
                    vJson += " ""account_num"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).account_num & """ ,"
                    vJson += " ""account_name"":""" & CP.rValidJson(sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).account_name) & """ ,"
                    vJson += " ""bcs_receipt_id"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).bcs_receipt_id & """ ,"
                    vJson += " ""pos_receipt_id"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).pos_receipt_id & """ ,"
                    vJson += " ""receipt_date"":""" & rConvertddMMyyyy(sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).receipt_date) & """ ,"
                    vJson += " ""receipt_amount"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).receipt_amount & """ ,"
                    ' vJson += " ""ro"":""" & rZeroRO(sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).ro, sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).shop_code) & """, "
                    vJson += " ""company_code"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).pos_company & """ ,"
                    vJson += " ""shop_code"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).shop_code & """ ,"
                    vJson += " ""province_short"":""" & rGetProvinceShort(sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).shop_code) & """ ,"
                    vJson += " ""ro"":""" & rGetRO(sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).shop_code) & """ ,"
                    vJson += " ""cn_no"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).cn_no & """ ,"
                    vJson += " ""cn_date"":""" & rConvertddMMyyyy(sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).cn_date) & """ ,"
                    vJson += " ""cn_amount"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).cn_amount & """ ,"
                    vJson += " ""card_id"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).card_id & """ ,"
                    vJson += " ""tax_id"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).tax_id & """ ,"
                    vJson += " ""remark"":""" & CP.rValidJson(sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).remark) & """ ,"
                    vJson += " ""rp_num"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).rp_num & """ ,"
                    vJson += " ""rp_due_dat"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).rp_due_dat & """ ,"
                    vJson += " ""epay_date"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).epay_date & """ ,"
                    vJson += " ""pay_date"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).pay_date & """ ,"
                    vJson += " ""pay_user"":""" & sv.GetAccountCnInfo(account_number, bcs_receipt, pos_receipt).details(i).pay_user & """ "
                    vJson += "},"
                Next
            End If
        End If

        If vJson <> Nothing Then
            vJson = "[" + CP.rReplaceSpecialSting(vJson)
            vJson = vJson.Remove(vJson.Length - 1, 1)
            vJson += "]"
        Else
            vJson = "[]"
        End If

        Response.Write(vJson)
    End Sub

    Protected Sub getRedebtDoc()
        Dim bcs_receipt As String = ""

        If Request.QueryString("bcs_receipt") <> Nothing Then
            bcs_receipt = Request.QueryString("bcs_receipt")
        End If

        Dim sv As New newgetdocumentcninfo.getdocumentcninfo
        Dim res As New getdocumentcninfo.response
        Dim vJson As String = ""

        If sv.GetDocumentCNInfo(bcs_receipt).details.Length > 0 Then

            If sv.GetDocumentCNInfo(bcs_receipt).details(0).resultMsg = "" Then
                For i As Integer = 0 To sv.GetDocumentCNInfo(bcs_receipt).details.Length - 1
                    vJson += "{"
                    vJson += " ""cn_no"":""" & sv.GetDocumentCNInfo(bcs_receipt).details(i).cn_no & """ ,"
                    vJson += " ""cn_url"":""" & sv.GetDocumentCNInfo(bcs_receipt).details(i).url & """ ,"
                    vJson += " ""rp_num"":""" & sv.GetDocumentCNInfo(bcs_receipt).details(i).rp_num & """ ,"
                    vJson += " ""rp_due_dat"":""" & sv.GetDocumentCNInfo(bcs_receipt).details(i).rp_due_dat & """ ,"
                    vJson += " ""epay_date"":""" & sv.GetDocumentCNInfo(bcs_receipt).details(i).rp_date & """ ,"
                    vJson += " ""pay_date"":""" & sv.GetDocumentCNInfo(bcs_receipt).details(i).pay_date & """ ,"
                    vJson += " ""pay_user"":""" & sv.GetDocumentCNInfo(bcs_receipt).details(i).pay_user & """ "
                    vJson += "},"
                Next
            End If
        End If

        If vJson <> Nothing Then
            vJson = "[" + vJson
            vJson = vJson.Remove(vJson.Length - 1, 1)
            vJson += "]"
        Else
            vJson = "[]"
        End If

        Response.Write(vJson)
    End Sub

    Protected Sub getCNepay()
        Dim cn_no As String = Request.QueryString("cn_no")

        Dim vSql As String = "select * from cnepay.dbo.vw_cn_epay "
        vSql += "where cn_no = '" + cn_no + "'"

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadRedebtHistoryInProcess()
        Dim account_number As String = Request.QueryString("account_number")
        Dim request_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select request.request_id, status_name last_status "
        vSql += ", subject_url, account_number, bcs_number, amount "
        vSql += ", redebt_number, rp_no, rp_date, prove_date, pay_date, due_date "
        vSql += "from request "
        vSql += "left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "left join request_status on request_status.status_id = request.request_status "
        vSql += "left join cnepay.dbo.vw_cn_epay epay on epay.cn_no = request.redebt_number "
        vSql += "where account_number = '" + account_number + "' and account_number <> '' "
        vSql += "and request.request_id <> '" + request_id + "'"
        vSql += "and request_status <> 105 and request_status <> 100 "
        vSql += "order by request.create_date "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadRedebtHistoryInClose()
        Dim account_number As String = Request.QueryString("account_number")

        Dim vSql As String = "select request.request_id, status_name last_status "
        vSql += ", subject_url, account_number, bcs_number, amount "
        vSql += ", redebt_number, rp_no, rp_date, prove_date, pay_date, due_date "
        vSql += "from request "
        vSql += "left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "left join request_status on request_status.status_id = request.request_status "
        vSql += "left join cnepay.dbo.vw_cn_epay epay on epay.cn_no = request.redebt_number "
        vSql += "where account_number = '" + account_number + "' and account_number <> '' "
        vSql += "and request_status <> 105 and request_status = 100 "
        vSql += "order by request.create_date "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub getRedebtFile()
        Dim xRequest_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select redebt_number, redebt_update, redebt_file, "
        vSql += "case when redebt_update is null then '' else CONVERT(VARCHAR(7), redebt_update, 126) end path_file "
        vSql += "from request "
        vSql += "where request_id = '" + xRequest_id + "' "

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        If vDT.Rows().Count() > 0 Then
            If vDT.Rows(0).Item("redebt_file") <> "" Then
                Response.Write(CF.rLinkOpenfile(xRequest_id, vDT.Rows(0).Item("path_file"), vDT.Rows(0).Item("redebt_file")))
            Else
                Response.Write("not file")
            End If
        End If

    End Sub

    Protected Sub searchRedebtClear()
        Dim xRequest_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select redebt_number "
        vSql += "from request "
        vSql += "where request_id = '" + xRequest_id + "' "

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        If vDT.Rows().Count() > 0 Then
            If vDT.Rows(0).Item("redebt_number") <> "" Then
                Response.Write(vDT.Rows(0).Item("redebt_number"))
            Else
                Response.Write("not file")
            End If
        End If

    End Sub

    Protected Sub autoDepartUser()
        Dim kw As String = Request.QueryString("kw")
        Dim xShop_code As String = Request.QueryString("shop_code")
        Dim xProvince As String = Request.QueryString("province_short")
        Dim xUemail As String = Request.QueryString("uemail")
        Dim xIn_depart As String = Request.QueryString("in_depart")

        Dim vSql As String = "select depart_name, depart_user.depart_id, depart_user.uemail, depart_user.user_desc "
        vSql += ",depart_user.ro, depart_user.cluster, depart_user.province "
        vSql += ",case when jas_department is null then 'department' else jas_department end jas_department "
        vSql += ",case when jas_position is null then 'position' else jas_position end jas_position "
        vSql += ",case when jas_thaiFullname is null then 'thaiFullname' else jas_thaiFullname end jas_thaiFullname "
        vSql += "from RMSDAT.dbo.vw_branch_shop branch "

        vSql += "join vw_depart_user depart_user "
        vSql += "on (depart_user.ro = 'ALL') "
        vSql += "or (depart_user.ro = branch.ro and depart_user.cluster = 'ALL' and depart_user.province = 'ALL') "
        vSql += "or (depart_user.ro = branch.ro and depart_user.cluster = branch.cluster and depart_user.province = 'ALL') "
        vSql += "or (depart_user.ro = branch.ro and depart_user.cluster = branch.cluster and depart_user.province = branch.province_short) "

        vSql += "where 1 = 1 "

        If xIn_depart <> Nothing Then
            vSql += "and depart_user.depart_id in (" + xIn_depart + ") "
        Else
            vSql += "and depart_user.depart_id in (1001, 1002, 1003, 1011, 1012, 1013, 1008) "
        End If

        If xShop_code <> Nothing Then
            vSql += "and branch.shop_code = '" + xShop_code + "' "
        End If

        If xProvince <> Nothing Then
            vSql += "and branch.province_short = '" + xProvince + "' "
        End If

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "depart_user.uemail like '%" + kw + "%' "
            vSql += "or depart_user.user_desc like '%" + kw + "%' "
            vSql += "or jas_thaiFullname like '%" + kw + "%' "
            vSql += ") "
        End If

        If xUemail <> Nothing Then
            vSql += "and depart_user.uemail = '" + xUemail + "' "
        End If

        vSql += "group by depart_name, depart_user.depart_id, depart_user.uemail, depart_user.user_desc, "
        vSql += "depart_user.ro, depart_user.cluster, depart_user.province, "
        vSql += "jas_department, jas_position, jas_thaiFullname  "

        vSql += "order by depart_id, depart_user.uemail "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
        'Response.Write(vSql)
    End Sub

    Protected Sub autoDepartUser_20180717()
        Dim kw As String = Request.QueryString("kw")
        Dim xShop_code As String = Request.QueryString("shop_code")
        Dim xProvince As String = Request.QueryString("province_short")
        Dim xUemail As String = Request.QueryString("uemail")
        Dim xIn_depart As String = Request.QueryString("in_depart")

        Dim vSql As String = "select depart_name, depart_user.depart_id, depart_user.uemail, depart_user.user_desc "
        vSql += ",depart_user.ro, depart_user.cluster, depart_user.province "
        vSql += ",case when jas_department is null then 'department' else jas_department end jas_department "
        vSql += ",case when jas_position is null then 'position' else jas_position end jas_position "
        vSql += ",case when jas_thaiFullname is null then 'thaiFullname' else jas_thaiFullname end jas_thaiFullname "
        vSql += "from [10.11.5.106].[RMSDAT01].[dbo].[vw_branch_shop] branch "

        vSql += "join ( "
        vSql += "    select * from depart_user "
        vSql += "    where start_date <= getdate() "
        vSql += "    and (expired_date is null or expired_date >= getdate()) "
        vSql += ") depart_user "
        vSql += "on (depart_user.ro = 'ALL') "
        vSql += "or (depart_user.ro = branch.ro and depart_user.cluster = 'ALL' and depart_user.province = 'ALL') "
        vSql += "or (depart_user.ro = branch.ro and depart_user.cluster = branch.cluster and depart_user.province = 'ALL') "
        vSql += "or (depart_user.ro = branch.ro and depart_user.cluster = branch.cluster and depart_user.province = branch.province_short) "

        vSql += "join department "
        vSql += "on department.depart_id = depart_user.depart_id "

        vSql += "left join depart_user_detail "
        vSql += "on depart_user_detail.uemail = depart_user.uemail "

        vSql += "where 1 = 1 "

        If xIn_depart <> Nothing Then
            vSql += "and depart_user.depart_id in (" + xIn_depart + ") "
        Else
            vSql += "and depart_user.depart_id in (1001, 1002, 1003) "
        End If

        If xShop_code <> Nothing Then
            vSql += "and branch.shop_code = '" + xShop_code + "' "
        End If

        If xProvince <> Nothing Then
            vSql += "and branch.province_short = '" + xProvince + "' "
        End If

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "depart_user.uemail like '%" + kw + "%' "
            vSql += "or depart_user.user_desc like '%" + kw + "%' "
            vSql += "or jas_thaiFullname like '%" + kw + "%' "
            vSql += ") "
        End If

        If xUemail <> Nothing Then
            vSql += "and depart_user.uemail = '" + xUemail + "' "
        End If

        vSql += "group by depart_name, depart_user.depart_id, depart_user.uemail, depart_user.user_desc, "
        vSql += "depart_user.ro, depart_user.cluster, depart_user.province, "
        vSql += "jas_department, jas_position, jas_thaiFullname  "

        vSql += "order by depart_user.uemail "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
        'Response.Write(vSql)
    End Sub

    Protected Sub autoShopCode()
        Dim kw As String = Request.QueryString("kw")

        Dim vSql As String = "select ro, shop_code, shop_name, province_short, province_name "
        vSql += "from RMSDAT.dbo.vw_branch_shop "
        vSql += "where "

        If kw <> Nothing Then
            vSql += "shop_code like '%" + kw + "%' or shop_name like '%" + kw + "%' "
        Else
            vSql += "1 = 0 "
        End If

        vSql += "order by shop_code "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub autoProvince()
        Dim kw As String = Request.QueryString("kw")

        Dim vSql As String = "select ro, cluster, province_code, province_short, province_name "
        vSql += "from RMSDAT.dbo.vw_branch_shop "
        vSql += "where province_short <> 'BKK' "
        ' vSql += "where 1 = 1 "

        If kw <> Nothing Then
            vSql += "and ( "
            vSql += "ro like '%" + kw + "%' or "
            vSql += "cluster like '%" + kw + "%' or "
            vSql += "province_short like '%" + kw + "%' or "
            vSql += "province_name like '%" + kw + "%' "
            vSql += ") "
        End If

        vSql += "group by ro, cluster, province_code, province_short, province_name "
        vSql += "order by ro, cluster, province_name "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub getRequest()
        Dim xRequest_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select request_id, amount "
        vSql += ",shop_code + ' ' + province_name + ' (RO' + ro + ')' province_name "
        vSql += ",request.create_by + ' (RO' + create_ro + ')' create_by "
        vSql += ",convert(varchar(10), request.create_date, 103) create_date "
        vSql += ",convert(varchar(10), dx03, 103) dx03 "
        vSql += ",account_number_to, account_name_to, tx01, pick_refund, pick_refund_title, pick_refund_type "
        vSql += ",request_title, redebt_cause_title, request_remark "
        vSql += "from request "
        vSql += "left join redebt_cause_title on redebt_cause_title.redebt_cause_id = request.redebt_cause_id "
        vSql += "left join ( "
        vSql += "    select ro, cluster, province_short, province_name "
        vSql += "    from RMSDAT.dbo.vw_branch_shop_all "
        vSql += "    group by ro, cluster, province_short, province_name "
        vSql += ") province on province.province_short = request.shop_code "
        vSql += "left join pick_refund on pick_refund.pick_refund_id = request.pick_refund "
        vSql += "where request_id = '" & xRequest_id & "' "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    ' Protected Function rGetProvinceShort(ByVal vShop_code As String) As String
    '     Dim vSql As String = "select ro, shop_code, shop_name, province_short, province_name "
    '     vSql += "from RMSDAT.dbo.vw_branch_shop_all "
    '     vSql += "where shop_code = '" + vShop_code + "' "
    '     vSql += "and province_short <> 'BKK' "

    '     Dim vDT As New DataTable
    '     vDT = DB105.GetDataTable(vSql)

    '     If vDT.Rows().Count() > 0 Then
    '         Return vDT.Rows(0).Item("province_short")
    '     Else
    '         Return ""
    '     End If
    ' End Function

    Protected Function rGetProvinceShort(ByVal vShop_code As String) As String
        Dim vSql As String = ""
        vSql += "declare @shopF29 varchar(5) = 'BKKA0'"
        vSql += "declare @shop_code varchar(5) = '" + vShop_code + "'"

        vSql += "select ro, shop_code, shop_name, province_short, province_name "
        vSql += "from RMSDAT.dbo.vw_branch_shop_all "
        vSql += "where (shop_code = @shop_code and province_short <> 'BKK') "
        vSql += "or (shop_code = @shop_code and @shop_code = @shopF29) "

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        If vDT.Rows().Count() > 0 Then
            Return vDT.Rows(0).Item("province_short")
        Else
            Return ""
        End If
    End Function

    Protected Function rGetRO(ByVal vShop_code As String) As String
        Dim vSql As String = "select ro, shop_code, shop_name, province_short, province_name "
        vSql += "from RMSDAT.dbo.vw_branch_shop_all "
        vSql += "where shop_code = '" + vShop_code + "' "

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        If vDT.Rows().Count() > 0 Then
            Return vDT.Rows(0).Item("ro")
        Else
            Return ""
        End If
    End Function

    Protected Sub autoEmp()
        Dim xKeyword As String = Request.QueryString("kw")
        Dim xToken As String = Request.QueryString("token")

        Dim vJson As String = CP.rGetDataOAuthjson(xKeyword, xToken)

        'Add Group email'
        ' Dim vSql As String = "select '-' as employeeId, '-' as thaiFullname, '-' as engFullname, group_email as email "
        ' vSql += ", '-' as position, '-' as department, '-' as section, '-' as division "
        ' vSql += "from department "
        ' vSql += "where group_email is not NULL and group_email like '%"+xKeyword+"%' "
        ' vSql += "group by group_email "


            Dim vSql As String = "select depart_name thaiFullname, depart_name engFullname "
            vSql += ", group_email + '@jasmine.com' email "
            vSql += ", 'Group Email' position, depart_desc department "
            vSql += "from department "
            vSql += "where disable = 0 and group_email is not null and LTRIM(RTRIM(group_email)) <> '' "
            vSql += "and ( "
            vSql += "depart_name like '%" + xKeyword + "%' or "
            vSql += "depart_desc like '%" + xKeyword + "%' or "
            vSql += "group_email like '%" + xKeyword + "%' or "
            vSql += "'Group Email' like '%" + xKeyword + "%' "
            vSql += ") "

        Dim vJson_addon As String = CP.rJsonDBv4(vSql, "DB105")
        
        ' Dim theString = "{ ""employeeId"":""20-059BB"" , ""thaiFullname"":""ศุภวรรณ ช่างเรือ"" , ""engFullname"":""Supawan Changruea"" , ""email"":""supawan.c@jasmine.com"" , ""position"":""AVP"" , ""department"":""Corporate Sales Business Unit"" , ""section"":""null"" , ""division"":""Corporate Sales"" },"
        ' Dim aStringBuilder = New StringBuilder(vJson)
        ' aStringBuilder.Insert(1, theString)
        ' vJson = aStringBuilder.ToString()
        'System.Console.WriteLine(vJson_addon)
        If vJson <> "[]" then
            vJson = CP.rMergeJson( vJson, vJson_addon)
        Else
            vJson = vJson_addon
        End If
        
        'Add Group email'

        Response.Write(vJson)
    End Sub

    Protected Sub submitApproveFlow()
        Dim res As Integer = 0
        Dim xRequest_id As String = Request.Form("request_id")
        Dim xUpdate_by As String = Request.Form("update_by")
        Dim xFlow_status As String = Request.Form("flow_status")
        Dim xFlow_remark As String = Request.Form("flow_remark")
        Dim xNum_last_update As String = Request.Form("num_last_update")

        If CF.rLoadRequestLastUpdate(xRequest_id, xNum_last_update) > 0 Then
            Dim vDT As New DataTable
            vDT = CF.rLoadRequestFlowCurrentStep(xRequest_id)
            ' Response.Write(CP.rConvertDataTableToJSONv2(vDT))

            If vDT.Rows().Count() = 1 Then
                If vDT.Rows(0).Item("uemail") = xUpdate_by Or vDT.Rows(0).Item("uemail") Like "*" + xUpdate_by + ";*" Then
                    Dim vFlow_no As String = vDT.Rows(0).Item("no")
                    Dim vFlow_sub As String = vDT.Rows(0).Item("flow_sub")
                    Dim vNext_step As String = vDT.Rows(0).Item("next_step")
                    Dim vBack_step As String = vDT.Rows(0).Item("back_step")
                    Dim vDepartment As String = vDT.Rows(0).Item("depart_id")

                    If CF.SaveFlowAjax(xUpdate_by, vFlow_no, vFlow_sub, vNext_step, vBack_step, vDepartment, xFlow_status, xFlow_remark, xRequest_id) = 1 Then
                        res = 9
                    Else
                        res = 3
                    End If
                Else
                    res = 2
                End If
            Else
                res = 2
            End If
        Else
            res = 1
        End If

        ' res = 1 อนุมัติไม่ได้ เพราะคำขอมีการเปลี่ยนแปลง
        ' res = 2 Flow Step ไม่ถูกต้อง ติดต่อ support pos เพื่อตรวจสอบ
        ' res = 3 คำสั่งอนุมัติไม่สำเร็จ ติดต่อ support pos เพื่อตรวจสอบ
        ' res = 9 success
        Response.Write(res)
    End Sub

    Public Function rConvertddMMyyyy(ByVal vDateTime As String) As String
        If vDateTime <> "" Then
            Dim Dt As DateTime = vDateTime
            Dt = vDateTime
            vDateTime = Dt.ToString("dd/MM/yyyy")
        End If

        Return vDateTime
    End Function

    Public Function rZeroRO(ByVal vRo As String, ByVal vShop_code As String) As String
        vRo = vRo.Trim()

        If vRo = "0" Or vRo = 0 Then
            vRo = ""

            '************* แก้เฉพาะหน้า ระหว่างรอ BCS & CCS ตรวจสอบ ทำไมถึง return RO มาไม่ถูกต้อง
            ' vRo = rGetRO(vShop_code)
            '************* แก้เฉพาะหน้า ระหว่างรอ BCS & CCS ตรวจสอบ ทำไมถึง return RO มาไม่ถูกต้อง
            
        Else If vRo.Length = 1 Then
            vRo = "0" & vRo
        End If

        Return vRo
    End Function

    Protected Sub checkUsedReceipt()
        Dim bcs_receipt As String = Request.QueryString("bcs_receipt")
        Dim pos_receipt As String = Request.QueryString("pos_receipt")
        Dim redoc_no As String = Request.QueryString("redoc_no")
        Dim request_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select request_id, doc_number, bcs_number from request "
        vSql += "where request_status <> 105 "

        If bcs_receipt <> Nothing Then
            vSql += "and bcs_number = '" & bcs_receipt & "' "
        End If
        
        If pos_receipt <> Nothing Then
            vSql += "and doc_number = '" & pos_receipt & "' "
        End If
        
        If redoc_no <> Nothing Then
            vSql += "and (gx01 = '" + redoc_no + "' or gx02 = '" + redoc_no + "') "
        End If

        If request_id <> Nothing Then
        vSql += "and request.request_id <> '" + request_id + "'"
        End If
        

        ' Response.Write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub


    Protected Sub getRedebtPos()
        Dim vSql As String = "select f05 redebt_number from r11090 where f10 = '" & Request.QueryString("pos_receipt") & "' "

        Response.Write(CP.rJsonDBv4(vSql, "DB106"))
    End Sub


    Protected Sub loadPickRefund()
        Dim vSql As String = "select pick_refund_id, pick_refund_type, pick_refund_title "
        vSql += "from pick_refund "
        
        vSql += "join subject_dim on "
        vSql += "subject_dim.pick_refund_in like '%' + pick_refund.pick_refund_id + '%' "

        vSql += "where subject_dim.subject_id = '" & Request.QueryString("subject_id") & "' "
        vSql += "and pick_refund.disable = 0 "
        vSql += "order by pick_refund_id "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub


    Protected Sub loadPickRefundIn()
        Dim vSql As String = "select distinct pick_refund_id, pick_refund_type, pick_refund_title "
        vSql += "from pick_refund "
        
        vSql += "join subject_dim on "
        vSql += "subject_dim.pick_refund_in like '%' + pick_refund.pick_refund_id + '%' "

        vSql += "where subject_dim.subject_id in (" + Request.QueryString("subject_id") + ") "
        vSql += "and pick_refund.disable = 0 "
        vSql += "order by pick_refund_id "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadPickRefundType()
        Dim vSql As String = "select pick_refund_id, pick_refund_type_title, pick_refund_type_value "
        vSql += "from pick_refund_type "
        
        vSql += "where pick_refund_id = '" & Request.QueryString("pick_refund_id") & "' "
        vSql += "and disable = 0 "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadCheckEditRefund()
        Dim vSql As String = "select request_status, rp_no "
        vSql += "from pick_refund "

        ' vSql += "join subject_dim "
        ' vSql += "on subject_dim.pick_refund_in like '%' + pick_refund.pick_refund_id + '%' "

        ' vSql += "join request "
        ' vSql += "on request.subject_id = subject_dim.subject_id "

        vSql += "join request "
        vSql += "on request.pick_refund = pick_refund.pick_refund_id "

        vSql += "left join cnepay.dbo.vw_cn_epay epay "
        vSql += "on epay.cn_no = request.redebt_number "

        vSql += "where request_id = '" & Request.QueryString("request_id") & "' "
        vSql += "and pick_refund.epayment = 1 "
        vSql += "and pick_refund.disable = 0 "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub submitEditRefund20190515()
        Dim request_id As String = Request.Form("request_id")
        Dim uemail As String = Request.Form("uemail")

        Dim edit_pick_refund As String = "20"
        Dim edit_tx01 As String = Request.Form("edit_tx01")

        Dim vSqlIn As String = ""
        Dim vRes As Integer = 0

        If request_id <> Nothing And edit_tx01 <> Nothing Then
            vSqlIn = "      insert into log_edit_refund ( "
            vSqlIn += "     request_id,pick_refund,tx01,"
            vSqlIn += "     edit_pick_refund,edit_tx01,"
            vSqlIn += "     edit_date,edit_by) "
            vSqlIn += "     select "
            vSqlIn += "     '" & request_id & "',pick_refund,tx01,"
            vSqlIn += "     '" & edit_pick_refund & "','" & edit_tx01 & "',"
            vSqlIn += "     getdate(),'" & uemail & "'"
            vSqlIn += "     from request "
            vSqlIn += "     where request_id = '" & request_id & "' "

            If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
                vSqlIn = "      update request set "
                vSqlIn += "     pick_refund='" + edit_pick_refund + "',tx01='" + edit_tx01 + "' "
                vSqlIn += "     where request_id = '" & request_id & "' "

                If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
                    vRes = 1

                    CF.SendMailSubmitRefund(request_id)
                End If
            End If
        End If

        Response.Write(vRes)
    End Sub

    Protected Sub submitEditRefund()
        Dim request_id As String = Request.Form("request_id")
        Dim uemail As String = Request.Form("uemail")

        Dim edit_pick_refund As String = "20"
        Dim edit_tx01 As String = Request.Form("edit_tx01")
        Dim edit_nx01 As String = Request.Form("edit_nx01")
        Dim edit_fx01 As String = Request.Form("edit_fx01")
        Dim edit_fx02 As String = Request.Form("edit_fx02")
        Dim edit_mx03 As String = Request.Form("edit_mx03")

        Dim vSqlIn As String = ""
        Dim vRes As Integer = 0

        If request_id <> Nothing And edit_tx01 <> Nothing Then
            vSqlIn = "      insert into log_edit_refund ( "
            vSqlIn += "     request_id, pick_refund, tx01, "
            vSqlIn += "     nx01, fx01, fx02, mx03, "
            vSqlIn += "     edit_pick_refund, edit_tx01, "
            vSqlIn += "     edit_nx01, edit_fx01, edit_fx02, edit_mx03, "
            vSqlIn += "     edit_date, edit_by) "
            vSqlIn += "     select "
            vSqlIn += "     '" & request_id & "', pick_refund, tx01, "
            vSqlIn += "     nx01, fx01, fx02, mx03, "
            vSqlIn += "     '" & edit_pick_refund & "', '" & edit_tx01 & "', "
            vSqlIn += "     '" & edit_nx01 & "', '" & edit_fx01 & "', '" & edit_fx02 & "', '" & edit_mx03 & "', "
            vSqlIn += "     getdate(), '" & uemail & "'"
            vSqlIn += "     from request "
            vSqlIn += "     where request_id = '" & request_id & "' "

            If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
                vSqlIn = "      update request set "
                vSqlIn += "     pick_refund='" & edit_pick_refund & "', tx01='" & edit_tx01 & "', "
                vSqlIn += "     nx01='" & edit_nx01 & "', fx01='" & edit_fx01 & "', fx02='" & edit_fx02 & "', mx03='" & edit_mx03 & "' "
                vSqlIn += "     where request_id = '" & request_id & "' "

                If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
                    vRes = 1

                    CF.SendMailSubmitRefund(request_id)
                End If
            End If
        End If

        Response.Write(vRes)
    End Sub

    Protected Sub loadDepartmentSearch()
        Dim vSql As String = "select depart_id, depart_name "
        vSql += "from department "
        vSql += "where depart_id in ( "
        vSql += "    select depart_id from flow_pattern "
        vSql += "    where depart_id <> 0 and flow_id in ( "
        vSql += "        select flow_id from subject_dim "
        vSql += "        where subject_id in (" + Request.QueryString("subject_id") + ") "
        vSql += "    ) "
        vSql += ") "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadAfterStatusSearch()
        Dim vSql As String = "select after_end_status_id, after_end_status_name "
        vSql += "from after_end_status "
        vSql += "where searched = 1 "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadAfterStatusSelected()
        Dim vSql As String = "select after_end_status_id, after_end_status_name "
        vSql += "from after_end_status "
        vSql += "where selected = 1 "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadAfterEndLasted()
        Dim vSql As String = "select request_id "
        vSql += ", after_end_remark.after_end_status_id, after_end_status_name "
        vSql += ", after_end_remark, create_by, create_date "
        vSql += "from after_end_remark "

        vSql += "join after_end_status "
        vSql += "on after_end_status.after_end_status_id = after_end_remark.after_end_status_id "

        vSql += "where after_end_lasted = 1 "
        vSql += "and request_id = '" & Request.QueryString("request_id") & "' "

        vSql += "order by create_date desc  "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub updateAfterEnd()
        Dim request_id As String = Request.Form("request_id")
        Dim uemail As String = Request.Form("uemail")

        Dim after_end_status_id As String = Request.Form("after_end_status_id")
        Dim after_end_remark As String = Request.Form("after_end_remark")

        Dim vSqlIn As String = ""
        Dim vRes As Integer = 0

        If request_id <> Nothing And after_end_status_id <> Nothing Then
            vSqlIn = "update after_end_remark set "
            vSqlIn += "after_end_lasted = 0 "
            vSqlIn += "where request_id = '" & request_id & "' "

            vSqlIn += "insert into after_end_remark ( "
            vSqlIn += "request_id, after_end_status_id, after_end_remark,"
            vSqlIn += "create_date, create_by) "
            vSqlIn += "values ( "
            vSqlIn += "     '" & request_id & "', " & after_end_status_id & ", '" & after_end_remark & "',"
            vSqlIn += "     getdate(),'" & uemail & "'"
            vSqlIn += ") "

            If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
                vRes = 1
            End If
        End If

        Response.Write(vRes)
    End Sub

    Protected Sub loadBankCode()
        Dim vSql As String = "select bank_code, bank_title "
        vSql += "from redebt_bank_code "
        vSql += "where bank_code > 0 and disable = 0 "
        vSql += "order by bank_popular desc, bank_code "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub countRedebtPOS() ''check ว่าออกใบลดหนี้ POS หรือยัง
        Dim cn_no As String = Request.QueryString("cn_no")

        Dim vSql As String = "select count_billpay + count_onetime count_cn "
        vSql += "from ( "
        vSql += "    select ( "
        vSql += "        select COUNT(1) FROM r17510 "
        vSql += "        where f08 = '" & cn_no & "' "
        vSql += "    ) as count_billpay, "
        vSql += "    ( "
        vSql += "        select COUNT(1) FROM r11090 "
        vSql += "        where f11 = '" & cn_no & "' "
        vSql += "    ) as count_onetime "
        vSql += ") cnt "

        Dim vDT As New DataTable
        vDT = DB106.GetDataTable(vSql)

        Dim count_cn As Integer = 0

        If vDT.Rows().Count() > 0 Then
            count_cn = vDT.Rows(0).Item("count_cn")
        End If

        Response.Write(count_cn)
    End Sub

    Protected Sub loadRedocItem() 
        Dim acc As String = Request.QueryString("acc")

        ' 1. ใบรับคืนอุปกรณ์ 
        Dim vSql As String = ""
        vSql += "select distinct 'doc_item' doc_type, r01010.f05 redoc_no, r01010.f18 account_num "
        vSql += "from r01010 with (nolock) "
        vSql += "join r01011 with (nolock) "
        vSql += "on r01010.F05 = r01011.F05 "
        vSql += "where r01010.f04 = 'RECCM' and r01010.f15<>'A' and r01011.f12 <> 'AC' "
        vSql += "and r01010.f05 not in (select f23 from r01090 with (nolock) where f11 <>'ISS04') "
        vSql += "and r01010.f18 = '" & acc & "' "
        vSql += "order by redoc_no "

        Response.Write(CP.rJsonDBv4(vSql, "DB106"))
    End Sub

    Protected Sub loadRedocAdapter()
        Dim acc As String = Request.QueryString("acc")

        ' 2.1 ใบรับคืน Adapter กรณีมี Adapter 
        Dim vSql As String = ""
        vSql += "select 'doc_adapter1' doc_type, r01010.f05 redoc_no, r01010.f18 account_num "
        vSql += "from r01010 with (nolock) "
        vSql += "join r01011 with (nolock) "
        vSql += "on r01010.F05 = r01011.F05 "
        vSql += "where r01010.f04 = 'RECCM' and r01010.f15<>'A' and r01011.f12 = 'AC' "
        vSql += "and r01010.f05 not in (select f23 from r01090 with (nolock) where f11 <>'ISS04') "
        vSql += "and r01010.f18 = '" & acc & "' "

        vSql += "union all "

        ' 2.2 ใบรับคืน Adapter จ่ายค่าปรับ
        vSql += "select 'doc_adapter2' doc_type, r11060.f05 redoc_no, r11060.f11 account_num  "
        vSql += "from r11060 with (nolock) "
        vSql += "join r11061 with (nolock) "
        vSql += "on r11060.F05=r11061.F05 "
        vSql += "where r11061.F14 in ('IPSER07TI','IPSER01BB') and r11060.f63<>'A' "
        vSql += "and r11060.f11 = '" & acc & "' "

        vSql += "order by redoc_no "

        ' 2.3 กรณีไม่มี 2.1 และ 2.2 ให้บังคับ Upload ใบเสร็จ ค่าปรับ 

        Response.Write(CP.rJsonDBv4(vSql, "DB106"))
    End Sub

    Protected Sub loadRedocForClaim() 
        Dim acc As String = Request.QueryString("acc")

        ' noti ใบรับคืนเพื่อเคลม
        Dim vSql As String = "select F23, F19, f11 from r01090 with (nolock) where F19='" & acc & "' and f11 ='ISS25'"

        Response.Write(CP.rJsonDBv4(vSql, "DB106"))
    End Sub

    Protected Sub statusDotRedocItem() 
        Dim pos_receipt As String = Request.QueryString("pos_receipt")
        Dim redoc_no As String = Request.QueryString("redoc_no")

        Dim vSql As String = ""
        vSql += "declare @pos_receipt varchar(30) = '" & pos_receipt & "' " 'เลขที่ใบเสร็จ POS
        vSql += "declare @doc_reccm varchar(30) = '" & redoc_no & "' " 'เลขที่ใบรับคืนอุปกรณ์

        ' 3. Check ใบรับคืนว่ารับคืนจากใบเสร็จ DOT ตรงกับใบเสร็จ POS ที่สร้างคำขอหรือไม่
        vSql += "select "
        vSql += "case "
        vSql += "    when r01010.f08 like 'AISSN%' then (select count(1) from r01090 with (nolock) where f05=r01010.f08 and f23=@pos_receipt) "
        vSql += "    when r01010.f08=@pos_receipt then 1 "
        vSql += "    else 0 "
        vSql += "end as count_reccm "
        vSql += ", case "
        vSql += "    when r01010.f08 like 'AISSN%' then (select f23 from r01090 with (nolock) where f05=r01010.f08) "
        vSql += "    else r01010.f08 "
        vSql += "end as doc_ref "
        ' vSql += "--, r01010.f05 doc_receipt "
        ' vSql += "--, r01010.f18 account_num "
        vSql += "from r01010 with (nolock) "
        vSql += "where r01010.f05=@doc_reccm  "

        Response.Write(CP.rJsonDBv4(vSql, "DB106"))
    End Sub

    Protected Sub countRedocRQprocess() '***** นับเฉพาะคำขอที่ยังไม่ปิด
        Dim redoc_no As String = Request.QueryString("redoc_no")
        Dim request_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select count_gx01 + count_gx02 count_redoc "
        vSql += "from ( "
        vSql += "    select ( "
        vSql += "       select COUNT(1) from request "
        vSql += "       where gx01 = '" + redoc_no + "' "
        vSql += "       and gx01 <> '' and gx01 is not null "
        vSql += "       and request_status <> 105 and request_status <> 100 "
        vSql += "       and request_id <> '" + request_id + "' "
        vSql += "    ) as count_gx01, "
        vSql += "    ( "
        vSql += "       select COUNT(1) from request "
        vSql += "       where gx02 = '" + redoc_no + "' "
        vSql += "       and gx02 <> '' and gx02 is not null "
        vSql += "       and request_status <> 105 and request_status <> 100 "
        vSql += "       and request_id <> '" + request_id + "' "
        vSql += "    ) as count_gx02 "
        vSql += ") cnt "

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim count_redoc As Integer = 0

        If vDT.Rows().Count() > 0 Then
            count_redoc = vDT.Rows(0).Item("count_redoc")
        End If

        Response.Write(count_redoc)
    End Sub

    Protected Sub countRedocRQclose() '***** นับเฉพาะคำขอที่ปิดแล้ว
        Dim redoc_no As String = Request.QueryString("redoc_no")

        Dim vSql As String = "select count_gx01 + count_gx02 count_redoc "
        vSql += "from ( "
        vSql += "    select ( "
        vSql += "       select COUNT(1) from request "
        vSql += "       where gx01 = '" + redoc_no + "' "
        vSql += "       and gx01 <> '' and gx01 is not null "
        vSql += "       and request_status <> 105 and request_status = 100 "
        vSql += "    ) as count_gx01, "
        vSql += "    ( "
        vSql += "       select COUNT(1) from request "
        vSql += "       where gx02 = '" + redoc_no + "' "
        vSql += "       and gx02 <> '' and gx02 is not null "
        vSql += "       and request_status <> 105 and request_status = 100 "
        vSql += "    ) as count_gx02 "
        vSql += ") cnt "

        Dim vDT As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim count_redoc As Integer = 0

        If vDT.Rows().Count() > 0 Then
            count_redoc = vDT.Rows(0).Item("count_redoc")
        End If

        Response.Write(count_redoc)
    End Sub

    Protected Sub loadRedocHistoryInProcess()
        Dim redoc_no As String = Request.QueryString("redoc_no")
        Dim request_id As String = Request.QueryString("request_id")

        Dim vSql As String = "select request.request_id, status_name last_status "
        vSql += ", subject_url, account_number, bcs_number, amount "
        vSql += ", redebt_number, rp_no, rp_date, prove_date, pay_date, due_date "
        vSql += ", gx01, gx02, fx03 "
        vSql += "from request "
        vSql += "left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "left join request_status on request_status.status_id = request.request_status "
        vSql += "left join cnepay.dbo.vw_cn_epay epay on epay.cn_no = request.redebt_number "
        vSql += "where (gx01 = '" + redoc_no + "' or gx02 = '" + redoc_no + "') "
        vSql += "and gx01 <> '' and gx02 <> '' "
        vSql += "and request.request_id <> '" + request_id + "'"
        vSql += "and request_status <> 105 and request_status <> 100 "
        vSql += "order by request.create_date "

        ' Response.Write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub loadRedocHistoryInClose()
        Dim redoc_no As String = Request.QueryString("redoc_no")

        Dim vSql As String = "select request.request_id, status_name last_status "
        vSql += ", subject_url, account_number, bcs_number, amount "
        vSql += ", redebt_number, rp_no, rp_date, prove_date, pay_date, due_date "
        vSql += ", gx01, gx02, fx03 "
        vSql += "from request "
        vSql += "left join subject_dim on subject_dim.subject_id = request.subject_id "
        vSql += "left join request_status on request_status.status_id = request.request_status "
        vSql += "left join cnepay.dbo.vw_cn_epay epay on epay.cn_no = request.redebt_number "
        vSql += "where (gx01 = '" + redoc_no + "' or gx02 = '" + redoc_no + "') "
        vSql += "and gx01 <> '' and gx02 <> '' "
        vSql += "and request_status <> 105 and request_status = 100 "
        vSql += "order by request.create_date "

        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub CheckCompanyReceipt()
        Dim subject_id As String = Request.QueryString("subject_id")
        Dim company_code As String = Request.QueryString("company_code")
        Dim pos_receipt As String = Request.QueryString("pos_receipt")

        Dim vSql As String = "exec SP_get_company_pre_create '"+subject_id+"', '"+company_code+"', '"+pos_receipt+"',0,0,0,0,0,0 "
        'Response.Write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub checkEPayGroupReceipt()
        Dim bcs_receipt As String = Request.QueryString("bcs_receipt")
        Dim pos_receipt As String = Request.QueryString("pos_receipt")

        Dim vSql As String = "select request_id, doc_number, bcs_number, create_by, create_date, s.status_name "
        vSql += "from request r inner join request_status s on r.request_status = s.status_id "
        vSql += "where request_status <> 105 and ax02 = '' "

        If bcs_receipt <> Nothing Then
            vSql += "and bcs_number = '" & bcs_receipt & "' "
        End If
        
        If pos_receipt <> Nothing Then
            vSql += "and doc_number = '" & pos_receipt & "' "
        End If

        'Response.Write(vSql)
        Response.Write(CP.rJsonDBv4(vSql, "DB105"))
    End Sub

    Protected Sub rejectEPayGroupReceipt()
        Dim search As String = Request.Form("search")
        Dim txt_receipt As String = Request.Form("txt_receipt")
        Dim txt_reject_remark As String = Request.Form("txt_remark")'"ทดสอบการยกเลิกใบลดหนี้ อัตโนมัติ โดยพิมพ์ประโยคยาวๆสักประโยค ขอเซ็ทหย่อสูดต่อซูดฝ่อซีหม่อสองห่อใส่ไข่"
        Dim uemail As String = Request.Form("uemail")'"nat.m"'


        Dim vSql As String = ""
        Dim vSqlIn As String = ""
        Dim vRes As Integer = 0

            Dim flow_step As Integer = 0
            Dim request_id As String = ""'"A2020062583"
            Dim log_error As String = ""

            'CF.SendMailRejcetAll(request_id, uemail, txt_reject_remark)

            vSqlIn = "select f.request_id, f.flow_step from request_flow f inner join "
            vSqlIn +="request r on r.request_id = f.request_id "
            vSqlIn +="where f.next_step='end' and r.request_status <> 105 and r.ax02 = '' and f.disable = 0 "
                
                If search = "bcs_number" Then
                     vSqlIn += "and r.bcs_number = '" & txt_receipt & "' "
                End If
                If search = "doc_number" Then
                     vSqlIn += "and r.doc_number = '" & txt_receipt & "' "
                End If

            ' Dim vDT As New DataTable
            ' vDT = DB105.GetDataTable(vSqlIn)
            ' If vDT.Rows().Count() > 0 Then
            '     vRes = 1
            '     log_error += "select request_id success \n"
            '     for i as Integer = 0 to vDT.Rows().Count() - 1 
                    
            '         flow_step = vDT.Rows(i).Item("flow_step")
            '         request_id = vDT.Rows(i).Item("request_id")

            '         vSqlIn = "insert into request_flow ( request_id, flow_id, depart_id, "
            '         vSqlIn += "flow_step, next_step, back_step, send_uemail, uemail, approval, "
            '         vSqlIn += "add_next, require_remark, require_file, flow_remark, flow_file, "
            '         vSqlIn += "flow_status, flow_complete, begin_date, update_date, update_by, disable ) "
            '         vSqlIn += "select request_id,flow_id,depart_id "
            '         vSqlIn +=",flow_step+1 "
            '         vSqlIn +=",next_step,back_step,send_uemail,uemail "
            '         vSqlIn +=",approval,add_next,require_remark,require_file "
            '         vSqlIn +=",'[FR Reject] " & txt_reject_remark & "' "
            '         vSqlIn +=",flow_file "
            '         vSqlIn +=",'105','1',GETDATE(),GETDATE() "
            '         vSqlIn +=",'" & uemail & "', '0' " 
            '         vSqlIn +="from request_flow "
            '         vSqlIn +="where next_step='end' and request_id='" & request_id & "' and disable = 0 "

            '         log_error += "insert request_flow request_id : "+request_id+" \n"
            '         If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
            '             vRes = 2
            '             log_error += "success \n"
            '             vSqlIn = "update request_flow "
            '             vSqlIn += "set next_step=" & (flow_step + 1).ToString & " "
            '             vSqlIn += "where request_id='" & request_id & "' and flow_step=" & flow_step.ToString & " "

            '             log_error += "update request_flow request_id : " & request_id & " \n"
            '               If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
            '                 vRes = 3
            '                 log_error += "success \n"
            '                 vSqlIn = "update request "
            '                 vSqlIn += "set request_status = '105', "
            '                 vSqlIn += "last_update =getdate(), "
            '                 vSqlIn += "update_by = '" & uemail & "' "
            '                 vSqlIn += "where request_status <> 105 and ax02 = '' and request_id= '" & request_id & "'  "

            '                     log_error += "update request request_id : " & request_id & " \n"
            '                     If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
            '                         vRes = 4
            '                         log_error += "success \n"
            '                         CF.SendMailRejcetAll(request_id, uemail, txt_reject_remark)
            '                     End If
            '              Else
            '                  log_error += "failed \n"
            '              End If
            '         Else
            '             log_error += "failed \n"
            '         End If
            '     Next

            ' End If
            'Response.write(vSqlIn)
            Response.Write(CP.rJsonDBv4(vSqlIn, "DB105"))
            'vSql = "select top 1 " & vRes.ToString & " as res_id, '" & vSqlIn.ToString & "' as log_text from request "
            ' vSql = "select top 1 " & vRes.ToString & " as res_id, '" & log_error & "' as log_text from request "
            'Response.Write(CP.rJsonDBv4(vSql, "DB105"))
        ' res = 2 
        ' res = 3 
        ' res = 4 success
    End Sub

    Protected Sub fixreject()
            Dim vSql As String = ""
            Dim vSqlIn As String = ""
            Dim vRes As Integer = 0

                Dim flow_step As Integer = 0
                Dim request_id As String = ""'"A2020062583"
                Dim log_error As String = ""

                'CF.SendMailRejcetAll(request_id, uemail, txt_reject_remark)

                vSql = "select f.request_id, f.flow_step from request_flow f inner join "
                vSql +="request r on r.request_id = f.request_id "
                vSql +="where f.next_step='end' and convert(date,f.update_date) = '2022-06-15' and f.update_by='nat.m' "

                Dim vDT As New DataTable
                vDT = DB105.GetDataTable(vSql)
                If vDT.Rows().Count() > 0 Then
                    vRes = 1
                    log_error += "select request_id success \n"
                    for i as Integer = 0 to vDT.Rows().Count() - 1 
                        
                        flow_step = vDT.Rows(i).Item("flow_step")
                        request_id = vDT.Rows(i).Item("request_id")

                            ' vSqlIn = "update request_flow "
                            ' vSqlIn += "set next_step='end' "
                            ' vSqlIn += "where request_id='" & request_id & "' and flow_step='" & (flow_step - 1).ToString & "' "

                            ' log_error += "update request_flow request_id : " & request_id & " \n"
                            ' If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
                                ' vRes = 2
                                ' log_error += "success \n"
                                vSqlIn = "delete request_flow "
                                vSqlIn += "where request_id='" & request_id & "' and flow_step='" & (flow_step).ToString & "'  " 
                                
                                 log_error += "delete request_flow request_id : " & request_id & " \n"
                                If DB105.ExecuteNonQuery(vSqlIn).ToString() > 0 Then
                                    vRes = 3
                                    log_error += "success \n"

                                Else
                                    log_error += "failed \n"
                                End If
                            ' Else
                            '     log_error += "failed \n"
                            ' End If
                    Next

                End If
                'Response.Write(vSqlIn)
                vSql = "select top 1 " & vRes.ToString & " as res_id, '" & log_error & "' as log_text from request "
                Response.Write(CP.rJsonDBv4(vSql, "DB105"))
            'Response.Write(CP.rJsonDBv4(vSqlIn, "DB105"))
            ' res = 2 
            ' res = 3 
            ' res = 4 success
        End Sub


End Class
