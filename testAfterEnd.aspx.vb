Imports System.IO
Imports System.Net
Imports System.Data
Imports System.Web.Script.Serialization
Imports System.Collections.Generic
Imports System.Net.Mail
Imports System.Net.Mime
Imports System.Net.IPAddress
Imports System.Threading

Partial Class testAfterEnd
    Inherits System.Web.UI.Page
    Dim DB105 As New Cls_Data105
    Dim DB106 As New Cls_Data
    Dim CP As New Cls_Panu
    Dim callback_api_3bbshop as String = "http://posbcs.triplet.co.th/3bbShop/"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' autoAfterEnd("B2021030003")
        Dim url As String = "http://posbcs.triplet.co.th/3bbShop/updateStockShopJson.aspx?qrs=followRejectSubmit&request_id=B2021030003"


            ' Dim request As WebRequest = WebRequest.Create(url)
            ' Dim response As WebResponse = request.GetResponse()

        Dim json As String
        Dim reader As StreamReader

        Dim Request As HttpWebRequest
        Dim Response As HttpWebResponse

        ' Try
            Request = DirectCast(WebRequest.Create(New Uri(url)), HttpWebRequest)
            Response = DirectCast(Request.GetResponse(), HttpWebResponse)
            reader = New StreamReader(Response.GetResponseStream())
            json = reader.ReadToEnd()

            CP.echo(json)
        ' Catch ex As Exception
        '     Return False
        ' End Try
    End Sub

    ' Public Sub autoAfterEnd(ByVal vRequest_id As String)
    '     Dim vSql As String = ""
    '     vSql += "select project_prefix, request_status from FollowRequest.dbo.request "
    '     vSql += "join FollowRequest.dbo.subject_dim on subject_dim.subject_id = request.subject_id "
    '     vSql += "join FollowRequest.dbo.project_dim on project_dim.project_id = subject_dim.project_id "
    '     vSql += "where request_id = '" + vRequest_id + "' "

    '     Dim vDT As New DataTable
    '     vDT = DB105.GetDataTable(vSql)

    '     If vDT.Rows().Count() > 0 Then
    '         If vDT.Rows(0).Item("project_prefix") = "B" Then
    '             ' CP.rRequestAddress("http://posbcs.triplet.co.th/3bbShop/updateStockShopJson.aspx?qrs=followSubmitNewStockShopNote&request_id=" + vRequest_id)
    '             ' Dim callback_api_3bbshop As String = "http://posbcs.triplet.co.th/3bbShop/"

    '             If vDT.Rows(0).Item("request_status") = "100" Then
    '                 Response.Write("rRequestAddress = " & callback_api_3bbshop + "updateStockShopJson.aspx?qrs=followEndSubmit&request_id=" + vRequest_id)
    '                 Response.Write("<br>rRequestAddress = " & rRequestAddress(callback_api_3bbshop + "updateStockShopJson.aspx?qrs=followEndSubmit&request_id=" + vRequest_id))
                
    '             Else If vDT.Rows(0).Item("request_status") = "105" Then
    '                 Response.Write("rRequestAddress = " & callback_api_3bbshop + "updateStockShopJson.aspx?qrs=followRejectSubmit&request_id=" + vRequest_id)
    '                 Response.Write("<br>rRequestAddress = " & rRequestAddress(callback_api_3bbshop + "updateStockShopJson.aspx?qrs=followRejectSubmit&request_id=" + vRequest_id))
    '             End If
    '         End If
    '     End If
    ' End Sub

    ' Public Function rRequestAddress(ByVal URL As String) As Boolean
    '     ' Try
    '         Dim request As WebRequest = WebRequest.Create(URL)
    '         Dim response As WebResponse = request.GetResponse()
    '     ' Catch ex As Exception
    '     '     Return False
    '     ' End Try
    '     ' Return True
    ' End Function
End Class
