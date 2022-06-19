Imports System.Web
Imports System.IO
Imports System.Data
Imports System.Globalization
Imports System.Globalization.DateTimeStyles

Partial Class testupload
    Inherits System.Web.UI.Page
    Dim CUP As New Cls_UploadFile
    Dim DB105 As New Cls_Data105
    Dim CF As New Cls_RequestFlow

    Public Class MultipleValue
        Public upload_path As String
        Public file_path As String
        Public file_name As String
    End Class

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'CF.SendMailSubmit("Reply_2", "A5517050003")
    End Sub

    Sub load1()
        Dim vSql As String
        vSql = "select * from ( "
        vSql += "    select no, request_id, flow_step, 0 flow_sub_step, update_date "
        vSql += "    from request_flow "
        vSql += "    where disable = 0 and flow_complete = 1 "
        vSql += "    and flow_step = 1 "
        vSql += ") aa "
        vSql += "order by request_id, flow_step, flow_sub_step "

        Dim vDT,vDT2 As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim vSqlIn As String = ""
        Dim vRes As String = ""

        For i As Integer = 0 To vDT.Rows().Count() - 1
            vSql = "select create_date begin_date from request "
            vSql += "where request_id = '" & vDT.Rows(i).Item("request_id") & "'"

            vDT2 = DB105.GetDataTable(vSql)
            Dim oDate As DateTime = Convert.ToDateTime(vDT2.Rows(0).Item("begin_date"))
            vRes += "update request_flow set begin_date = '" & oDate.ToString("yyyy-MM-dd HH:mm:ss.fff") & "' "
            vRes += "where no = '" & vDT.Rows(i).Item("no") & "' <br>" 
        Next

        Response.Write(vRes)
    End Sub

    Sub load2()
        Dim vSql As String
        vSql = "select * from ( "
        vSql += "    select no, request_id, flow_step, 0 flow_sub_step, update_date "
        vSql += "    from request_flow "
        vSql += "    where disable = 0 and flow_complete = 1 "
        vSql += "    and flow_step <> 1 "
        vSql += ") aa "
        vSql += "order by request_id, flow_step, flow_sub_step "

        Dim vDT,vDT2 As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim vSqlIn As String = ""
        Dim vRes As String = ""

        For i As Integer = 0 To vDT.Rows().Count() - 1
            vSql = "select top 1 update_date begin_date from ( "
            vSql += "    select no, request_id, flow_step, 0 flow_sub_step, update_date "
            vSql += "    from request_flow "
            vSql += "    where disable = 0 and flow_complete = 1 "
            vSql += "    union all "
            vSql += "    select no, request_id, flow_step, flow_sub_step, update_date "
            vSql += "    from request_flow_sub "
            vSql += "    where disable = 0 and flow_complete = 1 "
            vSql += ") aa "
            vSql += "where request_id = '" & vDT.Rows(i).Item("request_id") & "' and flow_step < " & vDT.Rows(i).Item("flow_step") & " "
            vSql += "order by flow_step desc, flow_sub_step desc "

            vDT2 = DB105.GetDataTable(vSql)
            Dim oDate As DateTime = Convert.ToDateTime(vDT2.Rows(0).Item("begin_date"))
            vRes += "update request_flow set begin_date = '" & oDate.ToString("yyyy-MM-dd HH:mm:ss.fff") & "' "
            vRes += "where no = '" & vDT.Rows(i).Item("no") & "' <br>" 
        Next

        Response.Write(vRes)
    End Sub

    Sub load3()
        Dim vSql As String
        vSql = "select * from ( "
        vSql += "    select no, request_id, flow_step, flow_sub_step, update_date "
        vSql += "    from request_flow_sub "
        vSql += "    where disable = 0 and flow_complete = 1 "
        vSql += ") aa "
        vSql += "order by request_id, flow_step, flow_sub_step "

        Dim vDT,vDT2 As New DataTable
        vDT = DB105.GetDataTable(vSql)

        Dim vSqlIn As String = ""
        Dim vRes As String = ""

        For i As Integer = 0 To vDT.Rows().Count() - 1
            vSql = "select top 1 update_date begin_date from ( "
            vSql += "    select no, request_id, flow_step, 0 flow_sub_step, update_date "
            vSql += "    from request_flow "
            vSql += "    where disable = 0 and flow_complete = 1 "
            vSql += "    union all "
            vSql += "    select no, request_id, flow_step, flow_sub_step, update_date "
            vSql += "    from request_flow_sub "
            vSql += "    where disable = 0 and flow_complete = 1 "
            vSql += ") aa "
            vSql += "where request_id = '" & vDT.Rows(i).Item("request_id") & "' and flow_step = " & vDT.Rows(i).Item("flow_step") & " and flow_sub_step < " & vDT.Rows(i).Item("flow_sub_step") & " "
            vSql += "order by flow_step desc, flow_sub_step desc "

            vDT2 = DB105.GetDataTable(vSql)
            Dim oDate As DateTime = Convert.ToDateTime(vDT2.Rows(0).Item("begin_date"))
            vRes += "update request_flow_sub set begin_date = '" & oDate.ToString("yyyy-MM-dd HH:mm:ss.fff") & "' "
            vRes += "where no = '" & vDT.Rows(i).Item("no") & "' <br>" 
        Next

        Response.Write(vRes)
    End Sub

    Sub Submit_ShopStock(ByVal Source As Object, ByVal E As EventArgs)
        testup4()
    End Sub

    Sub testup4()
        Dim upload_file As String = CUP.rUploadFileDriveF("upload_file", "id_type")

        Response.Write("<b>file:</b> " & upload_file & "<br>")

        Dim alink As String = "http://" + CUP.rGetHost() + "/" + CUP.rGetPathParent() + "/openfile.aspx"
        alink += "?path=2017/05/"
        alink += "&file=" + upload_file
        Response.Write("<br><br><a href='" + alink + "' target='_blank'>" + alink + "</a>")
    End Sub

    Sub testup3()
        Dim upload_file As String = CUP.rUploadFile("upload_file", "id_type")

        Response.Write("<br><br><a href='" + upload_file + "' target='_blank'>" + upload_file + "</a>")
    End Sub

    Sub testup2()
        Dim upload_file As String() = CUP.rUploadFileMutivalue("upload_file", "id_type")

        Response.Write("<b>upload_path:</b> " & upload_file(0) & "<br>")
        Response.Write("<b>file_path:</b> " & upload_file(1) & "<br>")
        Response.Write("<b>file_name:</b> " & upload_file(2))

        Dim alink As String = "http://" + CUP.rGetHost() + "/" + CUP.rGetPathParent() + "/openfile.aspx"
        alink += "?path=" + upload_file(1)
        alink += "&file=" + upload_file(2)
        Response.Write("<br><br><a href='" + alink + "' target='_blank'>" + alink + "</a>")
    End Sub

    Sub testup1()
        Dim request_file = new MultipleValue()
        request_file = rUpFile("upload_file", "id")

        Response.Write(request_file.upload_path)
        Response.Write(request_file.file_name)

        Dim alink As String = "http://" + CUP.rGetHost() + "/" + CUP.rGetPathParent() + "/openfile.aspx"
        alink += "?path=" + request_file.file_path
        alink += "&file=" + request_file.file_name

        Response.Write("<br><a href='" + alink + "' target='_blank'>" + alink + "</a>")
    End Sub

    Public Function rUpFile(ByVal vInput As String, ByVal vPrefix As String) As MultipleValue
        Dim FileUpload As HttpPostedFile = Request.Files(vInput)
        Dim file_name AS String = ""
        Dim file_type As String
        Dim vFileName AS String
        Dim CurrentFileName As String = ""

        Dim upload_path As String = "upload\"
        'Dim upload_path As String = "F:\FollowRequest"
        Dim file_path As String = "http://posweb.triplet.co.th/FollowRequestFile" 

        Dim create_path As String = "\upload"
        create_path &= "\" & DateTime.Now.ToString("yyyy")
        create_path &= "\" & DateTime.Now.ToString("MM")

        'upload_path &= create_path & "\"
        'IF Not Directory.Exists(upload_path) then
        '    Directory.CreateDirectory(upload_path)
        'End IF
        'upload_path &= "\"

        file_path &= create_path.Replace("\","/") & "/"

        If FileUpload.FileName <> "" Then
            vFileName = System.IO.Path.GetFileName(FileUpload.FileName)

            If vFileName.Length >= 1 Then
                CurrentFileName = vFileName    ' FileName
                file_type = System.IO.Path.GetExtension(vFileName) 
            End If

            file_name = vPrefix 
            file_name &= DateTime.Now.ToString("_yyMMdd_HHmmss")
            file_name &= file_type

            FileUpload.SaveAs(Server.MapPath("temp/" & CurrentFileName))

            Dim TheFile As FileInfo = New FileInfo(MapPath(".") & "\" & "temp\" & CurrentFileName)

            If TheFile.Exists Then
                System.IO.File.Move(MapPath(".") & "\" & "temp\" & CurrentFileName, upload_path & file_name)  'Move File
            Else
                file_name = ""

                Throw New FileNotFoundException()
            End If
        End If

        Dim mValue = new MultipleValue()
        mValue.upload_path = upload_path
        mValue.file_path = file_path
        mValue.file_name = file_name

        return mValue
    End Function

    Sub test1()
        Dim DirInfo As New DirectoryInfo(Server.MapPath("MyFolder2"))        
        If Not DirInfo.Exists Then
            DirInfo.Create()
            Response.Write("Folder Created.")
        End If

        If Not Page.IsPostBack Then
        End If
    End Sub

    Sub test2()
        dim path as String = "F:\FollowRequest\upload" 
        path += "\" + DateTime.Now.ToString("yyyy")
        path += "\" + DateTime.Now.ToString("MM")
        path += "\" + DateTime.Now.ToString("dd")

        IF Not Directory.Exists(path) then
            Directory.CreateDirectory(path)
            Response.Write( path + " Created2.")
        End IF
    End Sub

    Sub test3()
        Dim file As String = "http://posweb.triplet.co.th/openfile.aspx?path=http://posweb.triplet.co.th/FollowRequestFile/upload/2017/05/&file=A2017050003_R1_170523_142126.pdf"

        file = "<a href='" + file + "' target='_blank'>http://posweb.triplet.co.th/" + file + "</a>"
        Response.Write(file)
    End Sub
End Class
