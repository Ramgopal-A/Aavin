Imports System.IO
Imports System.Text
Imports MySql.Data.MySqlClient
Imports Newtonsoft.Json

Public Class BenSchemeDefault
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrdb As New bgrdb
    Dim bgrenc As New bgrenc

    Private Function GetBenId() As String
        Dim encId As String = Session(bgr.NiotEncrypt("ben_id", bgr.enc_key("SESSION_VAR"))).ToString()
        Return bgr.NiotDecrypt(encId, bgr.enc_key("SESSION_VAL"))
    End Function

    Private Function IsRejectedStatus(ByVal statusEn As String) As Boolean
        Dim s As String = Convert.ToString(statusEn).Trim()
        Return (s = "Rejected by Union" OrElse s = "Rejected by Bank")
    End Function

    Private Function IsSchemeLockedStatus(ByVal statusEn As String) As Boolean
        Select Case Convert.ToString(statusEn).Trim()
            Case "Loan Application Submitted",
                 "Recommended by Union and Forwarded to Bank",
                 "Loan is Sanctioned by Bank",
                 "Loan is Disbursed by Bank"
                Return True
            Case Else
                Return False
        End Select
    End Function

    Private Sub BenSchemeDefault_Init(sender As Object, e As EventArgs) Handles Me.Init
        conn.ConnectionString = bgrdb.conn_str("mini_diary")
        cmnd.Connection = conn
        cmnd.CommandType = CommandType.StoredProcedure
        errmsg.Visible = False
        succmsg.Visible = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            LoadBeneficiarySummary()
            Dim status As String = Convert.ToString(Session("otr_stat")).Trim()
            If status = "Loan Data Submitted" Then
                pnl_scheme_select.Visible = False
                pnl_app_letter.Visible = True
                ltl_page_heading.Text = "Step 5: Generate & Upload Signed Application Letter (விண்ணப்பக் கடிதம் பதிவிறக்கம் & பதிவேற்றம்)"
            Else
                pnl_scheme_select.Visible = True
                pnl_app_letter.Visible = False
                ltl_page_heading.Text = "Step 3: Select Dairy Farm Scheme (பால் பண்ணைத் திட்டத்தைத் தேர்ந்தெடுக்கவும்)"
            End If
        End If
    End Sub

    Private Sub LoadBeneficiarySummary()
        Try
            Dim benId As String = GetBenId()
            cmnd.CommandText = "sp_gridview_ben"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@icmd", "ben_loan_application")
            cmnd.Parameters.AddWithValue("@id1", benId)
            cmnd.Parameters.AddWithValue("@id2", bgr.enc_key("DB_BENEFICIARY"))

            Dim adptr As New MySqlDataAdapter(cmnd)
            Dim dt As New DataTable
            adptr.Fill(dt)

            rb_mini.Enabled = True
            rb_medium.Enabled = True
            btn_save_scheme.Enabled = True

            If dt.Rows.Count > 0 Then
                Dim row As DataRow = dt.Rows(0)
                Dim bankName As String = If(dt.Columns.Contains("ben_bank_name") AndAlso Not IsDBNull(row("ben_bank_name")), row("ben_bank_name").ToString(), "Registered Bank")
                Dim accNo As String = If(dt.Columns.Contains("ben_bank_acc_no") AndAlso Not IsDBNull(row("ben_bank_acc_no")), row("ben_bank_acc_no").ToString(), "")
                Dim ifsc As String = If(dt.Columns.Contains("ben_ifsc") AndAlso Not IsDBNull(row("ben_ifsc")), row("ben_ifsc").ToString(), "")
                Dim bankSummary As String = bankName & If(accNo <> "", " | A/C: " & accNo, "") & If(ifsc <> "", " | IFSC: " & ifsc, "")

                lbl_reg_bank_info.Text = bankSummary
                lbl_letter_bank_info.Text = bankSummary

                Dim existingScheme As String = If(dt.Columns.Contains("scheme_type") AndAlso Not IsDBNull(row("scheme_type")), Convert.ToString(row("scheme_type")).Trim().ToUpper(), "")
                Dim dbStatusEn As String = If(dt.Columns.Contains("status_en") AndAlso Not IsDBNull(row("status_en")), Convert.ToString(row("status_en")).Trim(), "")

                If IsRejectedStatus(dbStatusEn) Then
                    ' Previous application was rejected: allow ONLY the alternate scheme
                    Dim altScheme As String = If(existingScheme = "MEDIUM", "MINI", "MEDIUM")
                    If altScheme = "MEDIUM" Then
                        rb_medium.Checked = True
                        rb_medium.Enabled = True
                        rb_mini.Checked = False
                        rb_mini.Enabled = False
                        lbl_selected_scheme_summary.Text = "Your previous Mini Dairy application was rejected (" & dbStatusEn & "). You may apply for Medium Dairy Farm Scheme (Up to 5 Milch Animals - Sanctioned by IOB)."
                    Else
                        rb_mini.Checked = True
                        rb_mini.Enabled = True
                        rb_medium.Checked = False
                        rb_medium.Enabled = False
                        lbl_selected_scheme_summary.Text = "Your previous Medium Dairy application was rejected (" & dbStatusEn & "). You may apply for Mini Dairy Farm Scheme (Up to 4 Milch Animals)."
                    End If
                    succmsg.Visible = True
                    succmsg.InnerHtml = "Earlier application status: <strong>" & dbStatusEn & "</strong>. You can now apply under the alternate scheme."
                ElseIf IsSchemeLockedStatus(dbStatusEn) Then
                    ' Signed letter submitted or application under processing/sanctioned/disbursed: lock scheme selection
                    Dim displayScheme As String = If(String.IsNullOrEmpty(existingScheme), "MINI", existingScheme)
                    rb_mini.Checked = (displayScheme <> "MEDIUM")
                    rb_medium.Checked = (displayScheme = "MEDIUM")
                    rb_mini.Enabled = False
                    rb_medium.Enabled = False
                    btn_save_scheme.Enabled = False
                    lbl_selected_scheme_summary.Text = If(displayScheme = "MEDIUM",
                        "Medium Dairy Farm Scheme (Up to 5 Milch Animals - Sanctioned by IOB)",
                        "Mini Dairy Farm Scheme (Up to 4 Milch Animals)")
                    errmsg.Visible = True
                    errmsg.InnerHtml = "You already have a submitted, active, or sanctioned application under the <strong>" & displayScheme & "</strong> scheme (Status: <strong>" & dbStatusEn & "</strong>). Scheme changes are locked."
                Else
                    ' Before signed letter submission: allow selecting or switching between MINI and MEDIUM
                    If existingScheme = "MEDIUM" Then
                        rb_medium.Checked = True
                        rb_mini.Checked = False
                        lbl_selected_scheme_summary.Text = "Medium Dairy Farm Scheme (Up to 5 Milch Animals - Sanctioned by IOB)"
                    ElseIf existingScheme = "MINI" Then
                        rb_mini.Checked = True
                        rb_medium.Checked = False
                        lbl_selected_scheme_summary.Text = "Mini Dairy Farm Scheme (Up to 4 Milch Animals)"
                    Else
                        ' NULL / unselected in DB: default radio selection to MINI without forcing a saved DB value yet
                        rb_mini.Checked = True
                        rb_medium.Checked = False
                        lbl_selected_scheme_summary.Text = "Not yet saved (Select Mini or Medium Dairy Scheme below)"
                    End If
                End If
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error loading profile: " & ex.Message
        End Try
    End Sub

    Private Sub btn_save_scheme_Click(sender As Object, e As EventArgs) Handles btn_save_scheme.Click
        Try
            Dim benId As String = GetBenId()
            Dim scheme As String = If(rb_medium.Checked, "MEDIUM", "MINI")

            cmnd.CommandText = "sp_ben_select_scheme"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_BENEFICIARY"))
            cmnd.Parameters.AddWithValue("@iben_id", Convert.ToInt32(benId))
            cmnd.Parameters.AddWithValue("@ischeme_type", scheme)

            conn.Open()
            Dim resCode As String = Convert.ToString(cmnd.ExecuteScalar()).Trim()
            conn.Close()

            Select Case resCode
                Case "SUCCESS"
                    Session("otr_stat") = "Scheme Selected"
                    Response.Redirect("~/ONLINE/BEN/LOANAPP", False)
                    Context.ApplicationInstance.CompleteRequest()
                Case "BLOCKED_ACTIVE_APPLICATION"
                    errmsg.Visible = True
                    errmsg.InnerHtml = "You cannot apply for another scheme while an existing application is under processing or sanctioned."
                Case "SAME_SCHEME_REJECTED"
                    errmsg.Visible = True
                    errmsg.InnerHtml = "Your application under this scheme was rejected. Please select the alternate scheme to reapply."
                Case Else
                    errmsg.Visible = True
                    errmsg.InnerHtml = "Unable to save scheme selection (" & resCode & ")."
            End Select
        Catch ex As Exception
            If conn.State = ConnectionState.Open Then conn.Close()
            errmsg.Visible = True
            errmsg.InnerHtml = "Error saving scheme: " & ex.Message
        End Try
    End Sub

    Private Sub btn_download_letter_Click(sender As Object, e As EventArgs) Handles btn_download_letter.Click
        Try
            Dim benId As String = GetBenId()
            cmnd.CommandText = "sp_gridview_ben"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@icmd", "ben_loan_application")
            cmnd.Parameters.AddWithValue("@id1", benId)
            cmnd.Parameters.AddWithValue("@id2", bgr.enc_key("DB_BENEFICIARY"))

            Dim adptr As New MySqlDataAdapter(cmnd)
            Dim dt As New DataTable
            adptr.Fill(dt)
            If dt.Rows.Count = 0 Then Exit Sub

            Dim r As DataRow = dt.Rows(0)
            Dim isMedium As Boolean = (Convert.ToString(r("scheme_type")).Trim().ToUpper() = "MEDIUM")
            Dim schemeEn As String = If(isMedium, "Medium Dairy Farm Scheme (Up to 5 Milch Animals - Sanctioned by Indian Overseas Bank)", "Mini Dairy Farm Scheme (Up to 4 Milch Animals)")
            Dim schemeTa As String = If(isMedium, "நடுத்தர பால் பண்ணைத் திட்டம் (5 கறவை மாடுகள் - இந்தியன் ஓவர்சீஸ் வங்கி மூலம்)", "சிறு பால் பண்ணைத் திட்டம் (4 கறவை மாடுகள்)")
            Dim headName As String = If(dt.Columns.Contains("mpcs_head_name") AndAlso Not String.IsNullOrWhiteSpace(Convert.ToString(r("mpcs_head_name"))), r("mpcs_head_name").ToString(), "_____________________________")

            Dim html As New StringBuilder()
            html.Append("<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'>")
            html.Append("<head><meta charset='utf-8'><style>body{font-family:'Times New Roman',serif;font-size:12pt;line-height:1.5;} .hdr{text-align:center;font-weight:bold;} table{width:100%;border-collapse:collapse;margin:10px 0;} td,th{border:1px solid #333;padding:6px;}</style></head><body>")
            html.Append("<div class='hdr'><h3>TAMIL NADU CO-OPERATIVE MILK PRODUCERS' FEDERATION LTD. (AAVIN)<br/>தமிழ்நாடு கூட்டுறவு பால் உற்பத்தியாளர்கள் இணையம் (ஆவின்)</h3>")
            html.Append("<h4>DAIRY LOAN APPLICATION &amp; SOCIETY RECOMMENDATION LETTER / கடன் விண்ணப்பம் மற்றும் சங்கத்தின் பரிந்துரைக் கடிதம்</h4>")
            html.Append("<p><strong>Scheme / திட்டம்:</strong> " & schemeEn & "<br/>" & schemeTa & "</p></div>")

            html.Append("<table>")
            html.Append("<tr><th style='width:35%;'>Aavin Beneficiary ID</th><td>" & Convert.ToString(r("ben_avinid")) & "</td></tr>")
            html.Append("<tr><th>Applicant Name / விண்ணப்பதாரர் பெயர்</th><td>" & Convert.ToString(r("ben_name")) & " (" & Convert.ToString(r("care_of")) & " " & Convert.ToString(r("ben_fh_name")) & ")</td></tr>")
            html.Append("<tr><th>Address / முகவரி</th><td>" & Convert.ToString(r("ben_addr")) & ", " & Convert.ToString(r("district")) & " - " & Convert.ToString(r("ben_pincode")) & "</td></tr>")
            html.Append("<tr><th>Mobile Number / கைபேசி எண்</th><td>" & Convert.ToString(r("ben_mobile_no")) & "</td></tr>")
            html.Append("<tr><th>MPCS Society / பால் உற்பத்தியாளர் சங்கம்</th><td>" & Convert.ToString(r("mpcs_name")) & " (Member No: " & Convert.ToString(r("mpcs_member_no")) & ")</td></tr>")
            html.Append("<tr><th>Disbursement Bank Account</th><td>" & Convert.ToString(r("ben_bank_name")) & " - " & Convert.ToString(r("ben_branch_name")) & " | A/c: " & Convert.ToString(r("ben_bank_acc_no")) & " | IFSC: " & Convert.ToString(r("ben_ifsc")) & "</td></tr>")
            html.Append("</table>")

            html.Append("<p><strong>Declaration by Applicant &amp; Milk Producers' Co-operative Society (MPCS):</strong><br/>")
            html.Append("This is to certify that Thiru/Tmt. <strong>" & Convert.ToString(r("ben_name")) & "</strong> is an active milk-pouring member of our Milk Producers' Co-operative Society. ")
            html.Append("The applicant requests loan sanction under the <strong>" & schemeEn & "</strong> with direct disbursement to the registered bank account listed above, and the society undertakes to recover monthly installments from the member's milk pourings.</p>")

            html.Append("<p><strong>விண்ணப்பதாரர் மற்றும் பால் உற்பத்தியாளர்கள் கூட்டுறவு சங்கத்தின் சான்று:</strong><br/>")
            html.Append("திரு/திருமதி. <strong>" & Convert.ToString(r("ben_name")) & "</strong> அவர்கள் எமது பால் உற்பத்தியாளர்கள் கூட்டுறவு சங்கத்தில் தொடர்ந்து பால் வழங்கும் உறுப்பினராக உள்ளார் என சான்றளிக்கப்படுகிறது. ")
            html.Append("<strong>" & schemeTa & "</strong> கீழ் அனுமதிக்கப்படும் கடன் தொகையை மேற்கண்ட பதிவு செய்யப்பட்ட வங்கிக் கணக்கில் வரவு வைக்கவும், மாதாந்திர தவணைத் தொகையை பால் பணத்திலிருந்து பிடித்தம் செய்து செலுத்தவும் ஒப்புக்கொள்கப்படுகிறது.</p>")

            html.Append("<br/><br/><table style='border:none;'><tr>")
            html.Append("<td style='border:none;width:50%;'><strong>Signature of Applicant / விண்ணப்பதாரர் கையொப்பம்</strong><br/><br/>Date / தேதி: _______________</td>")
            html.Append("<td style='border:none;width:50%;text-align:right;'><strong>Signature of Society Secretary / President</strong><br/>Name: " & headName & "<br/>(Office Seal / சங்க முத்திரை)</td>")
            html.Append("</tr></table></body></html>")

            Response.Clear()
            Response.Buffer = True
            Response.ContentType = "application/msword"
            Response.AddHeader("Content-Disposition", "attachment;filename=Aavin_Application_Letter_" & Convert.ToString(r("ben_avinid")) & ".doc")
            Response.ContentEncoding = Encoding.UTF8
            Response.BinaryWrite(Encoding.UTF8.GetPreamble())
            Response.Write(html.ToString())
            Response.Flush()
            Response.End()
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error generating letter: " & ex.Message
        End Try
    End Sub

    Private Sub btn_upload_letter_Click(sender As Object, e As EventArgs) Handles btn_upload_letter.Click
        Try
            If Not fu_signed_letter.HasFile Then
                errmsg.Visible = True
                errmsg.InnerHtml = "Please select your signed Application Letter file before uploading."
                Exit Sub
            End If

            If fu_signed_letter.PostedFile.ContentLength > 2 * 1024 * 1024 Then
                errmsg.Visible = True
                errmsg.InnerHtml = "File size must be less than 2 MB."
                Exit Sub
            End If

            Dim benId As String = GetBenId()
            Dim bytes As Byte() = fu_signed_letter.FileBytes
            Dim base64Plain As String = Convert.ToBase64String(bytes)
            Dim encData As String = bgr.NiotEncrypt(base64Plain, bgr.enc_key("BENEFICIARY_FILE_DATA"))

            Dim fp As String = Server.MapPath("~/UPLOAD/DOC/" & bgrenc.file_name_encrypt(benId) & ".json")
            Dim dt As DataTable
            If File.Exists(fp) Then
                dt = JsonConvert.DeserializeObject(Of DataTable)(File.ReadAllText(fp))
            Else
                dt = New DataTable()
                dt.Columns.Add("id", GetType(String))
                dt.Columns.Add("val", GetType(String))
            End If

            While dt.Rows.Count <= 8
                    dt.Rows.Add((dt.Rows.Count + 1).ToString(), "0")
                End While
                dt.Rows(8)("val") = encData
                dt.AcceptChanges()
                File.WriteAllText(fp, JsonConvert.SerializeObject(dt))

                cmnd.CommandText = "sp_ben_signed_letter_done"
                cmnd.Parameters.Clear()
                cmnd.Parameters.AddWithValue("@iben_id", Convert.ToInt32(benId))
                conn.Open()
                cmnd.ExecuteNonQuery()
                conn.Close()

                Session("otr_stat") = "Loan Application Submitted"
                Response.Redirect("~/ONLINE/BEN/APPSTAT", False)
                Context.ApplicationInstance.CompleteRequest()
        Catch ex As Exception
            If conn.State = ConnectionState.Open Then conn.Close()
            errmsg.Visible = True
            errmsg.InnerHtml = "Error uploading signed letter: " & ex.Message
        End Try
    End Sub
End Class