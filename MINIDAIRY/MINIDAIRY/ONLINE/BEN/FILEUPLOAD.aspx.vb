Imports MySql.Data.MySqlClient
Imports Newtonsoft.Json
Imports System.IO

Public Class FILEUPLOAD
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrdb As New bgrdb
    Dim bgrenc As New bgrenc
    Dim defaultBase64 As String = "0"
    Dim jsondata As String
    Dim docNames As New List(Of String) From {
        "Aadhar Card",
        "PAN Card",
        "Smart Family Card",
        "First Page of Bank Passbook",
        "Applicant's passport size photos",
        "Chitta / Lease Agreement Page 1",
        "Adangal / Lease Agreement Page 2",
        "Society ID Card (சங்க அடையாள அட்டை)"
    }

    Private Function GetBenId() As String
        Dim ben_id As String = Session(bgr.NiotEncrypt("ben_id", bgr.enc_key("SESSION_VAR"))).ToString()
        Return bgr.NiotDecrypt(ben_id, bgr.enc_key("SESSION_VAL"))
    End Function

    Private Function GetCurrentLoanStatus(ByVal benid As String) As String
        Try
            Using localConn As New MySqlConnection(bgrdb.conn_str("mini_diary"))
                Using localCmd As New MySqlCommand("sp_gridview_ben", localConn)
                    localCmd.CommandType = CommandType.StoredProcedure
                    localCmd.Parameters.AddWithValue("@icmd", "ben_loan_application")
                    localCmd.Parameters.AddWithValue("@id1", benid)
                    localCmd.Parameters.AddWithValue("@id2", bgr.enc_key("DB_BENEFICIARY"))

                    Dim adptr As New MySqlDataAdapter(localCmd)
                    Dim dt As New DataTable()
                    adptr.Fill(dt)

                    If dt.Rows.Count > 0 AndAlso dt.Columns.Contains("status_en") AndAlso Not IsDBNull(dt.Rows(0)("status_en")) Then
                        Return Convert.ToString(dt.Rows(0)("status_en")).Trim()
                    End If
                End Using
            End Using
        Catch
            ' Fall back to session status if needed
        End Try

        Try
            If Session("otr_stat") IsNot Nothing Then
                Return Convert.ToString(Session("otr_stat")).Trim()
            End If
        Catch
        End Try

        Return ""
    End Function

    Private Function HasSignedLetterSubmitted(ByVal statusEn As String, ByVal fp As String) As Boolean
        Dim st As String = Convert.ToString(statusEn).Trim()
        If String.Equals(st, "Loan Application Submitted", StringComparison.OrdinalIgnoreCase) Then
            Return True
        End If

        ' Also check slot 9 in the beneficiary document JSON if present
        Try
            If Not String.IsNullOrEmpty(fp) AndAlso File.Exists(fp) Then
                Dim sr As New StreamReader(fp)
                Dim rawJson As String = sr.ReadToEnd()
                sr.Close()

                If Not String.IsNullOrWhiteSpace(rawJson) Then
                    Dim dtAll As DataTable = JsonConvert.DeserializeObject(Of DataTable)(rawJson)
                    If dtAll IsNot Nothing AndAlso dtAll.Columns.Contains("id") AndAlso dtAll.Columns.Contains("val") Then
                        Dim slot9Row As DataRow = dtAll.AsEnumerable().FirstOrDefault(Function(r) Convert.ToString(r("id")) = "9")
                        If slot9Row IsNot Nothing Then
                            Dim slot9Val As String = Convert.ToString(slot9Row("val")).Trim()
                            If Not String.IsNullOrEmpty(slot9Val) AndAlso slot9Val <> defaultBase64 Then
                                Return True
                            End If
                        End If
                    End If
                End If
            End If
        Catch
        End Try

        Return False
    End Function

    Protected Function IsDocEditingAllowed() As Boolean
        Dim benid As String = GetBenId()
        Dim statusEn As String = GetCurrentLoanStatus(benid)
        Dim fp As String = get_file_name()

        If HasSignedLetterSubmitted(statusEn, fp) Then
            Return False
        End If

        Select Case statusEn
            Case "",
                 "One Time Registration Completed",
                 "File Uploaded",
                 "Scheme Selected",
                 "Loan Data Submitted"
                Return True
            Case Else
                Return False
        End Select
    End Function

    Private Sub ApplyLockState()
        Dim allowed As Boolean = IsDocEditingAllowed()
        div_lock_notice.Visible = Not allowed
    End Sub

    Private Sub FILEUPLOAD_Init(sender As Object, e As EventArgs) Handles Me.Init
        conn.ConnectionString = bgrdb.conn_str("mini_diary")
        cmnd.Connection = conn
        cmnd.CommandType = CommandType.StoredProcedure
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim fp = get_file_name()
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
                gv_fill(fp)
            Else
                gv_fill(fp)
            End If
            mvDocs.ActiveViewIndex = 0
            errmsg.Visible = False
        End If
        ApplyLockState()
    End Sub

    Protected Sub gv_fill(ByVal fp As String)
        Dim sr As New StreamReader(fp)
        Dim jsondata As String = sr.ReadToEnd()
        sr.Close()
        Dim dtAll As DataTable = JsonConvert.DeserializeObject(Of DataTable)(jsondata)

        ' Only bind the 8 initial documents (slot 9 is reserved for the signed application letter in Step 2)
        Dim dtDocs As New DataTable()
        dtDocs.Columns.Add("id", GetType(String))
        dtDocs.Columns.Add("val", GetType(String))
        dtDocs.Columns.Add("name", GetType(String))

        For i As Integer = 1 To 8
            Dim existingRow As DataRow = dtAll.AsEnumerable().FirstOrDefault(Function(r) Convert.ToString(r("id")) = i.ToString())
            Dim valStr As String = If(existingRow IsNot Nothing, Convert.ToString(existingRow("val")), defaultBase64)
            dtDocs.Rows.Add(i.ToString(), valStr, docNames(i - 1))
        Next

        gvDocs.DataSource = dtDocs.DefaultView
        gvDocs.DataBind()

        Dim pendingCount As Integer = dtDocs.AsEnumerable().Count(Function(r) r.Field(Of String)("val") = defaultBase64)
        If pendingCount > 0 Then
            MultiView1.ActiveViewIndex = 0
        Else
            MultiView1.ActiveViewIndex = 1
        End If
    End Sub

    Protected Function get_file_name() As String
        Dim ben_id As String = Session(bgr.NiotEncrypt("ben_id", bgr.enc_key("SESSION_VAR")))
        Dim benid As String = bgr.NiotDecrypt(ben_id, bgr.enc_key("SESSION_VAL"))
        Return (Server.MapPath("~/UPLOAD/DOC/" + bgrenc.file_name_encrypt(benid) + ".json"))
    End Function

    Protected Sub file_display(ByVal file_no As String)
        Dim fp = get_file_name()
        Dim sr As StreamReader = New StreamReader(fp)
        jsondata = sr.ReadToEnd()
        sr.Close()
        Dim dt As DataTable = JsonConvert.DeserializeObject(Of DataTable)(jsondata)
        Dim base64Str As String = dt.Rows(Convert.ToInt32(file_no)).Item(1).ToString
        img_doc.ImageUrl = "data:image/jpeg;base64," & bgr.NiotDecrypt(base64Str, bgr.enc_key("BENEFICIARY_FILE_DATA"))
        Dim script As String = "window.onload = function() { var myModal = new bootstrap.Modal(document.getElementById('uploadPopup')); myModal.show(); };"
        ClientScript.RegisterStartupScript(Me.GetType(), "ShowPopup", script, True)
    End Sub

    Protected Sub gvDocs_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvDocs.RowCommand
        Try
            Dim doc_id As Integer = Convert.ToInt32(e.CommandArgument)
            ltl_header.Text = docNames(doc_id - 1)
            ltl_header1.Text = docNames(doc_id - 1)
            hf_image_no.Value = (doc_id - 1).ToString
            If e.CommandName = "UploadDoc" OrElse e.CommandName = "EditDoc" Then
                If Not IsDocEditingAllowed() Then
                    mvDocs.ActiveViewIndex = 0
                    errmsg.Visible = True
                    errmsg.InnerHtml = "Editing is locked because your Signed Application Letter has already been submitted. (கையொப்பமிட்ட விண்ணப்பக் கடிதம் சமர்ப்பிக்கப்பட்டதால் மாற்றம் செய்ய இயலாது.)"
                    Exit Sub
                End If
                mvDocs.ActiveViewIndex = 1
                Dim fp = get_file_name()
                ImageCropControl.file_name = fp
                ImageCropControl.doc_no = hf_image_no.Value
            ElseIf e.CommandName = "ViewDoc" Then
                file_display(doc_id - 1)
            End If
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Err 101 : " + ex.Message
        End Try
    End Sub

    Private Sub ImageCropControl_On_File_upload(status As String) Handles ImageCropControl.On_File_upload
        Select Case status
            Case "Success"
                If Not IsDocEditingAllowed() Then
                    mvDocs.ActiveViewIndex = 0
                    errmsg.Visible = True
                    errmsg.InnerHtml = "Editing is locked because your Signed Application Letter has already been submitted. (கையொப்பமிட்ட விண்ணப்பக் கடிதம் சமர்ப்பிக்கப்பட்டதால் மாற்றம் செய்ய இயலாது.)"
                    Exit Sub
                End If
                gv_fill(get_file_name())
                mvDocs.ActiveViewIndex = 0
                errmsg.Visible = False
            Case "Failure"
                errmsg.Visible = True
                errmsg.InnerHtml = "Error uploading file."
            Case "Cancel"
                mvDocs.ActiveViewIndex = 0
                errmsg.Visible = False
        End Select
    End Sub

    Private Sub btn_back_Click(sender As Object, e As EventArgs) Handles btn_back.Click
        mvDocs.ActiveViewIndex = 0
    End Sub

    Private Sub btn_submit_Click(sender As Object, e As EventArgs) Handles btn_submit.Click
        Try
            Dim benid As String = GetBenId()
            Dim currentStatus As String = GetCurrentLoanStatus(benid)

            ' Preserve already-advanced statuses if the user only came back to review/edit files
            If currentStatus = "Scheme Selected" OrElse currentStatus = "Loan Data Submitted" OrElse currentStatus = "Loan Application Submitted" Then
                Response.Redirect("~/ONLINE/BEN", False)
                Context.ApplicationInstance.CompleteRequest()
                Exit Sub
            End If

            cmnd.CommandText = "sp_ben_file_upload"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@iben_id", Convert.ToInt32(benid))
            conn.Open()
            Dim str As String = Convert.ToString(cmnd.ExecuteScalar())
            conn.Close()

            If str = "SUCCESS" Then
                Session("otr_stat") = "File Uploaded"
                Response.Redirect("~/ONLINE/BEN", False)
                Context.ApplicationInstance.CompleteRequest()
            Else
                errmsg.Visible = True
                errmsg.InnerHtml = "Error : Something went wrong while saving document status."
            End If
        Catch ex As Exception
            If conn.State = ConnectionState.Open Then conn.Close()
            errmsg.Visible = True
            errmsg.InnerHtml = "Error : " & ex.Message
        End Try
    End Sub
End Class