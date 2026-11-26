Imports Newtonsoft.Json
Imports System.IO

Public Class ZMASTERBEN
    Inherits System.Web.UI.MasterPage
    Dim bgr As New bgr
    Dim bgrenc As New bgrenc
    Dim defaultBase64 As String = "0"

    Private Sub ZMASTERBEN_Init(sender As Object, e As EventArgs) Handles Me.Init
        If Convert.ToString(Session("loggedin")) = "BEN" Then
            Dim path As String = Request.Url.AbsolutePath.TrimEnd("/"c).ToUpperInvariant()
            Dim status As String = Convert.ToString(Session("otr_stat")).Trim()

            Dim isDashboard As Boolean = (path = "/ONLINE/BEN" OrElse path = "/ONLINE/BEN/DEFAULT" OrElse path = "/ONLINE/BEN/DEFAULT.ASPX")
            Dim isFileUpload As Boolean = (path = "/ONLINE/BEN/FILEUPLOAD" OrElse path = "/ONLINE/BEN/FILEUPLOAD.ASPX")
            Dim isLoanApp As Boolean = (path = "/ONLINE/BEN/LOANAPP" OrElse path = "/ONLINE/BEN/LOANAPP.ASPX")
            Dim isAppStat As Boolean = (path = "/ONLINE/BEN/APPSTAT" OrElse path = "/ONLINE/BEN/APPSTAT.ASPX")

            Select Case status
                Case "", "One Time Registration Completed"
                    If Not isFileUpload Then
                        Response.Redirect("~/ONLINE/BEN/FILEUPLOAD", False)
                        Context.ApplicationInstance.CompleteRequest()
                    End If

                Case "File Uploaded", "Loan Data Submitted"
                    If Not isDashboard Then
                        Response.Redirect("~/ONLINE/BEN", False)
                        Context.ApplicationInstance.CompleteRequest()
                    End If

                Case "Scheme Selected"
                    If Not isLoanApp Then
                        Response.Redirect("~/ONLINE/BEN/LOANAPP", False)
                        Context.ApplicationInstance.CompleteRequest()
                    End If

                Case "Loan Application Submitted",
                 "Recommended by Society and Forwarded to Union",
                 "Rejected by Society",
                 "Recommended by Union and Forwarded to Bank",
                 "Rejected by Union",
                 "Rejected by Bank",
                 "Loan is Sanctioned by Bank"
                    If Not isAppStat Then
                        Response.Redirect("~/ONLINE/BEN/APPSTAT", False)
                        Context.ApplicationInstance.CompleteRequest()
                    End If
            End Select
        Else
            Response.Redirect("~/ONLINE", False)
            Context.ApplicationInstance.CompleteRequest()
        End If
    End Sub

    Private Sub lbtn_logout_Click(sender As Object, e As EventArgs) Handles lbtn_logout.Click
        Session.Clear()
        Response.Redirect("~/ONLINE")
    End Sub

    Protected Function check_all_file_upload(ByVal ben_id As String) As Boolean
        Dim fp = Server.MapPath("~/UPLOAD/DOC/" + bgrenc.file_name_encrypt(ben_id) + ".json")
        Dim jsonstr As String
        If File.Exists(fp) = False Then
            Dim dttbl1 As New DataTable
            dttbl1.Columns.Add("id", GetType(String))
            dttbl1.Columns.Add("val", GetType(String))
            For i As Integer = 1 To 8
                dttbl1.Rows.Add(i.ToString(), defaultBase64)
            Next
            dttbl1.AcceptChanges()
            jsonstr = JsonConvert.SerializeObject(dttbl1)
            Dim sw As StreamWriter = New StreamWriter(fp, False)
            sw.WriteLine(jsonstr)
            sw.Close()
            Return False
        Else
            jsonstr = File.ReadAllText(fp)
            Dim dt As DataTable = JsonConvert.DeserializeObject(Of DataTable)(jsonstr)
            Dim count As Integer = dt.AsEnumerable().Count(Function(r) r.Field(Of String)("val") = defaultBase64)
            If count > 0 Then
                Return False
            Else
                Return True
            End If
        End If
    End Function
End Class