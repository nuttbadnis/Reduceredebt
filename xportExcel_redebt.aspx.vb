Imports System.Data
Imports System.Text
Imports System.IO
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html
Imports iTextSharp.text.html.simpleparser

Partial Class xportExcel_redebt
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim CP As New Cls_Panu
    Dim CF As New Cls_RequestFlow

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' CP.Analytics()
        
        xportExcel()
    End Sub

    Private Sub xportExcel()
        Dim vSaveName As String = "adv_search_" & Request.QueryString("file_name")
        vSaveName += ".xls"

        Dim vSql As String
        vSql += "select request.request_id 'เลขที่คำขอ'"
        vSql += ", subject_prefix + '. ' + subject_name 'หัวข้อ'"
        vSql += ", request_title_dim.request_title 'เรื่อง'"
        vSql += ", amount 'จำนวนเงิน'"
        vSql += ", shop_code 'จังหวัดที่ออกใบเสร็จ'"
        vSql += ", 'RO' + area_ro 'RO ที่ออกใบเสร็จ'"
        vSql += ", 'RO' + create_ro 'RO ผู้สร้างคำขอ'"
        vSql += ", case when create_shop = 'none' then 'ไม่ได้ประจำ Shop' when create_shop = '' then '-' else create_shop end 'Shop ผู้สร้างคำขอ'"
        vSql += ", request.create_by 'ผู้สร้างคำขอ'"
        vSql += ", uemail_approve 'ผู้อนุมัติ'"
        vSql += ", next_depart.depart_name 'หน่วยงานที่รับผิดชอบ'"
        vSql += ", status_name 'สถานะล่าสุด'"
        vSql += ", request.create_date 'วันที่เริ่มเปิดคำขอ'"
        vSql += ", case when last_update is null then request.create_date else last_update end 'วันที่อัพเดทล่าสุด'"
        vSql += ", account_number 'Account'"
        vSql += ", account_name 'ชื่อลูกค้า'"

        vSql += ", bcs_number 'ลขที่ใบเสร็จ BCS'"
        vSql += ", doc_number 'เลขที่ใบเสร็จ POS'"
        vSql += ", case "
        vSql += "   when cndot.f05 is not null then cndot.f05 "
        vSql += "   when cnbill.f05 is not null then cnbill.f05 "
        vSql += "   else '' "
        vSql += "end 'เลขที่ใบลดหนี้ POS'"
        vSql += ", redebt_number 'เลขที่ใบลดหนี้'"

        vSql += ", rp_no 'เลขที่ E-Pay'"
        vSql += ", rp_date 'วันที่สร้าง E-Pay'"
        vSql += ", pay_date 'Paid Date E-Pay'"
        vSql += ", due_date 'Due Date E-Pay'"
        vSql += ", after_end_status_name 'สถานะหลังปิดคำขอ'"
        vSql += ", '' as '|'"
        vSql += ", pick_refund_title 'รูปแบบการคืนเงิน' "
        vSql += ", account_number_to 'ที่ Account'"
        vSql += ", account_name_to 'ที่ ชื่อลูกค้า'"
        vSql += ", tx01 'รายละเอียดการคืนเงิน'"
        vSql += ", bank_title 'ธนาคาร'"
        vSql += ", fx01 'รหัสสาขาธนาคาร'"
        vSql += ", fx02 'เลขที่บัญชี'"
        vSql += ", mx03 'ชื่อบัญชี'"

        If Request.QueryString("col_cause") <> Nothing Then
            vSql += ", redebt_cause_title '+ สาเหตุที่ต้องการลดหนี้'"
        End If

        If Request.QueryString("col_remark") <> Nothing Then
            vSql += ", request_remark '+ หมายเหตุเพิ่มเติม'"
        End If

        vSql += CF.rSqlSearchAllRequest()

        ' Response.Write(vSql)


        Dim DT As New DataTable
        DT = DB105.GetDataTable(vSql)

        'Create a dummy GridView
        Dim GridView1 As New GridView()
        GridView1.AllowPaging = False
        GridView1.DataSource = dt
        GridView1.DataBind()
 
        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", _
             "attachment;filename=" + vSaveName)
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
 
        For i As Integer = 0 To GridView1.Rows.Count - 1
          'Apply text style to each Row
           GridView1.Rows(i).Attributes.Add("class", "textmode")
        Next
        GridView1.RenderControl(hw)
 
        'style to format numbers to string
        Dim style As String = "<style> .textmode{mso-number-format:\@;}</style>"
        Response.Write(style)
        Response.Output.Write(sw.ToString())
        Response.Flush()
        Response.End()
    End Sub
End Class
