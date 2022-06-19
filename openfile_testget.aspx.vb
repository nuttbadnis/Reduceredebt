Partial Class openfile_testget
    Inherits System.Web.UI.Page
    Dim CP As New Cls_Panu

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CP.checkLogin()

        If Request.QueryString("file") = Nothing Then
            Response.Write("not file!!")
        Else If Request.QueryString("path") = Nothing Then
            Response.Write("not path!!")
        Else
            openfile()
        End If
        
        CP.Analytics()
    End Sub

    Sub openfile()
        Dim currentDate As DateTime = DateTime.Now
        Dim currentMonth As Integer = currentDate.Month
        Dim currentYear As Integer = currentDate.Year

        Dim pathSplit() As String = Request.QueryString("path").Split("-")
        Dim pathMonth As Integer = pathSplit(1)
        Dim pathYear As Integer = pathSplit(0)

        Dim curDate As New DateTime(currentYear,currentMonth,1)
        Dim pastDate As New DateTime(pathYear,pathMonth,1)

        ' Response.Write(MonthDifference(curDate, pastDate))

        If MonthDifference(curDate, pastDate) >= 14 Then
            Response.Redirect("openfile_old.aspx?path=" + Request.QueryString("path") + "&file=" + Request.QueryString("file"))
        Else
            iframe_file.Attributes("src") = "openfile_iframe_testget.aspx?file=" + Request.QueryString("file") + "&path=" + Request.QueryString("path")
        End If
            
    End Sub

    Public Function MonthDifference(ByVal curDate As DateTime, ByVal pastDate As DateTime) As Integer
        Return Math.Abs((curDate.Month - pastDate.Month) + 12 * (curDate.Year - pastDate.Year))
    End Function
End Class
