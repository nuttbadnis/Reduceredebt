Imports System.IO
Imports System.Net
Imports System.Data

Partial Class openfile_old
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu
    Dim CUP As New Cls_UploadFile

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.checkLogin()
        
        If Request.QueryString("file") = Nothing Or Request.QueryString("path") = Nothing Then
            span_error.InnerHtml = "not path file!!"
            p_path.Style.Add("display", "none")
        Else
            Dim path_file As String = Request.QueryString("path") 
            path_file = path_file.Replace("-","/") + "/" 
            path_file += Request.QueryString("file")
            
            span_path.InnerHtml = CUP.rGetPathParent() + "File/upload/" + path_file
        End If

        CP.Analytics()
    End Sub

    ' Private Sub ftpWeb()
    '     Dim request As FtpWebRequest = DirectCast(WebRequest.Create(New Uri("ftp://10.11.153.246/posfilescan/FollowRequestFile/upload/2017/A1017050001_R1_170526_17555.pdf")), FtpWebRequest)
    '     request.Method = WebRequestMethods.Ftp.DownloadFile
    '     request.EnableSsl = True
    '     request.Credentials = New Net.NetworkCredential("posfscan", "posfscan")
    '     request.UsePassive = True
    '     Dim response As FtpWebResponse = DirectCast(request.GetResponse(), FtpWebResponse)
 
    '     Using fs As FileStream = File.OpenWrite("fileName.txt")
    '         response.GetResponseStream.Copyto(fs)
    '     End Using
    ' End Sub

    ' Private Sub ftpWeb2()
    '     Dim ftp As String = "ftp://10.11.153.246/"
    '     Dim ftpFolder As String = "posfilescan/FollowRequestFile/upload/2017/"
    '     Dim fileName As String = "A1017050001_R1_170526_17555.pdf"
 
    '     Try
    '         'Create FTP Request.
    '         Dim request As FtpWebRequest = DirectCast(WebRequest.Create(Convert.ToString(ftp & ftpFolder) & fileName), FtpWebRequest)
    '         request.Method = WebRequestMethods.Ftp.DownloadFile

    '         'Enter FTP Server credentials.
    '         request.Credentials = New NetworkCredential("posfscan", "posfscan")
    '         request.UsePassive = True
    '         request.UseBinary = True
    '         request.EnableSsl = False

    '         'Fetch the Response and read it into a MemoryStream object.
    '         Dim resp As FtpWebResponse = DirectCast(request.GetResponse(), FtpWebResponse)
    '         Using stream As New MemoryStream()

    '         'Download the File.
    '         resp.GetResponseStream().CopyTo(stream)
    '         Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
    '         Response.Cache.SetCacheability(HttpCacheability.NoCache)
    '         Response.BinaryWrite(stream.ToArray())
    '         Response.End()
    '         End Using

    '     Catch ex As WebException
    '         Throw New Exception(TryCast(ex.Response, FtpWebResponse).StatusDescription)
    '     End Try
    ' End Sub

End Class
