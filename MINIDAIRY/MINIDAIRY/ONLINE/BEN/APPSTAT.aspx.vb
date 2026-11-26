Imports System.IO
Imports MySql.Data.MySqlClient
Imports Newtonsoft.Json

Public Class APPSTAT
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrdb As New bgrdb
    Dim bgrlv As New bgrlv
    Dim bgrenc As New bgrenc

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Function GetLoanDetailText(ByVal dataItem As Object, ByVal colName As String, ByVal fallbackText As String, ByVal Optional prefix As String = "") As String
        Dim drv As DataRowView = TryCast(dataItem, DataRowView)
        If drv Is Nothing OrElse Not drv.DataView.Table.Columns.Contains(colName) Then
            Return fallbackText
        End If

        Dim val As Object = drv(colName)
        If val Is Nothing OrElse Convert.IsDBNull(val) Then
            Return fallbackText
        End If

        Dim strVal As String = Convert.ToString(val).Trim()
        If String.IsNullOrEmpty(strVal) Then
            Return fallbackText
        End If

        Return prefix & strVal
    End Function

    Protected Function GetDocDataUri(ByVal bid As String, ByVal did As String) As String
        Try
            If String.IsNullOrWhiteSpace(bid) OrElse String.IsNullOrWhiteSpace(did) Then
                Return String.Empty
            End If

            Dim fp As String = Server.MapPath("~/UPLOAD/DOC/" & bgrenc.file_name_encrypt(bid) & ".json")
            If Not File.Exists(fp) Then
                Return String.Empty
            End If

            Dim jsondata As String = File.ReadAllText(fp)
            Dim dt As DataTable = JsonConvert.DeserializeObject(Of DataTable)(jsondata)
            Dim rowIndex As Integer = Convert.ToInt32(did)

            If dt Is Nothing OrElse rowIndex < 0 OrElse rowIndex >= dt.Rows.Count Then
                Return String.Empty
            End If

            Dim base64Str As String = Convert.ToString(dt.Rows(rowIndex)("val")).Trim()
            If String.IsNullOrEmpty(base64Str) OrElse base64Str = "0" Then
                Return String.Empty
            End If

            Dim decryptedBase64 As String = bgr.NiotDecrypt(base64Str, bgr.enc_key("BENEFICIARY_FILE_DATA")).Trim()
            If String.IsNullOrWhiteSpace(decryptedBase64) Then
                Return String.Empty
            End If

            If decryptedBase64.StartsWith("JVBERi0", StringComparison.Ordinal) Then
                Return "data:application/pdf;base64," & decryptedBase64
            End If

            Return "data:image/jpeg;base64," & decryptedBase64
        Catch
            Return String.Empty
        End Try
    End Function

    Private Sub APPSTAT_Init(sender As Object, e As EventArgs) Handles Me.Init
        conn.ConnectionString = bgrdb.conn_str("mini_diary")
        cmnd.Connection = conn
        cmnd.CommandType = CommandType.StoredProcedure

        Dim rawBenId As String = Convert.ToString(Session(bgr.NiotEncrypt("ben_id", bgr.enc_key("SESSION_VAR"))))
        If String.IsNullOrWhiteSpace(rawBenId) Then
            Response.Redirect("~/ONLINE", False)
            Context.ApplicationInstance.CompleteRequest()
            Exit Sub
        End If

        Dim benid As String = bgr.NiotDecrypt(rawBenId, bgr.enc_key("SESSION_VAL"))
        If String.IsNullOrWhiteSpace(benid) Then
            Response.Redirect("~/ONLINE", False)
            Context.ApplicationInstance.CompleteRequest()
            Exit Sub
        End If

        bgrlv.fill_ben(conn, lv_loan_app, "ben_loan_application", benid, bgr.enc_key("DB_BENEFICIARY"))
        errmsg.Visible = False
    End Sub

    Private Sub lv_loan_app_ItemCommand(sender As Object, e As ListViewCommandEventArgs) Handles lv_loan_app.ItemCommand
        Try
            Dim rawBenId As String = Convert.ToString(Session(bgr.NiotEncrypt("ben_id", bgr.enc_key("SESSION_VAR"))))
            Dim benid As String = bgr.NiotDecrypt(rawBenId, bgr.enc_key("SESSION_VAL"))
            Dim doc As String = Convert.ToString(e.CommandArgument).ToLower()
            Dim slotIndex As String = ""
            Dim docTitle As String = ""

            Select Case doc
                Case "aadhar"
                    slotIndex = "0"
                    docTitle = "Aadhar Card"
                Case "pan"
                    slotIndex = "1"
                    docTitle = "PAN Card"
                Case "sfc"
                    slotIndex = "2"
                    docTitle = "Smart Family Card"
                Case "bank"
                    slotIndex = "3"
                    docTitle = "Bank Passbook First Page"
                Case "chitta"
                    slotIndex = "5"
                    docTitle = "Chitta / Lease Agreement Page 1"
                Case "adangal"
                    slotIndex = "6"
                    docTitle = "Adangal / Lease Agreement Page 2"
                Case "society"
                    slotIndex = "7"
                    docTitle = "Society ID Card"
                Case "signed_letter"
                    slotIndex = "8"
                    docTitle = "Signed Application Letter"
            End Select

            If Not String.IsNullOrEmpty(slotIndex) Then
                Dim docDataUri As String = GetDocDataUri(benid, slotIndex)
                If Not String.IsNullOrEmpty(docDataUri) Then
                    ltl_doc_type.Text = docTitle
                    errmsg.Visible = False

                    If docDataUri.StartsWith("data:application/pdf;base64,", StringComparison.OrdinalIgnoreCase) Then
                        img_doc.Visible = False
                        pdf_doc.Attributes("src") = docDataUri
                        pdf_doc.Visible = True
                    Else
                        pdf_doc.Visible = False
                        pdf_doc.Attributes("src") = ""
                        img_doc.ImageUrl = docDataUri
                        img_doc.Visible = True
                    End If

                    Dim script As String = "var myModal = new bootstrap.Modal(document.getElementById('uploadPopup')); myModal.show();"
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", script, True)
                Else
                    errmsg.Visible = True
                    errmsg.InnerHtml = docTitle & " is not uploaded or available."
                End If
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error opening document: " & ex.Message
        End Try
    End Sub

    Private Sub lv_loan_app_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lv_loan_app.ItemDataBound
        If e.Item.ItemType = ListViewItemType.DataItem Then
            Try
                Dim rawBenId As String = Convert.ToString(Session(bgr.NiotEncrypt("ben_id", bgr.enc_key("SESSION_VAR"))))
                Dim benid As String = bgr.NiotDecrypt(rawBenId, bgr.enc_key("SESSION_VAL"))
                Dim drv As DataRowView = TryCast(e.Item.DataItem, DataRowView)

                Dim imgPhoto As Image = TryCast(e.Item.FindControl("img_photo"), Image)
                If imgPhoto IsNot Nothing Then
                    Dim photoUrl As String = doc_image(benid, "4")
                    If Not String.IsNullOrEmpty(photoUrl) Then
                        imgPhoto.ImageUrl = photoUrl
                        imgPhoto.Visible = True
                    Else
                        imgPhoto.Visible = False
                    End If
                End If

                Dim btnSignedLetter As Button = TryCast(e.Item.FindControl("btn_signed_letter"), Button)
                If btnSignedLetter IsNot Nothing Then
                    btnSignedLetter.Visible = Not String.IsNullOrEmpty(GetDocDataUri(benid, "8"))
                End If

                Dim imgQr As Image = TryCast(e.Item.FindControl("img_qr"), Image)
                If imgQr IsNot Nothing AndAlso Not String.IsNullOrWhiteSpace(rawBenId) Then
                    Dim qrPayload As String = bgr.NiotEncrypt(rawBenId, bgr.enc_key("BENEFICIARY_FILE_NAME"))
                    imgQr.ImageUrl = bgr.generate_qrcode(qrPayload, Server.MapPath("~/ASSETS/IMAGES/tab_logo.jpg"))
                End If

                Dim imgMilkQr As Image = TryCast(e.Item.FindControl("img_milk_qr"), Image)
                If imgMilkQr IsNot Nothing AndAlso Not String.IsNullOrWhiteSpace(rawBenId) Then
                    Dim avinId As String = If(drv IsNot Nothing AndAlso drv.DataView.Table.Columns.Contains("ben_avinid"), Convert.ToString(drv("ben_avinid")), benid)
                    Dim mpcsNo As String = If(drv IsNot Nothing AndAlso drv.DataView.Table.Columns.Contains("mpcs_member_no"), Convert.ToString(drv("mpcs_member_no")), "")
                    Dim schemeVal As String = If(drv IsNot Nothing AndAlso drv.DataView.Table.Columns.Contains("scheme_type"), Convert.ToString(drv("scheme_type")), "")

                    Dim milkQrPlain As String = "BEN_ID=" & benid & "|AVIN_ID=" & avinId & "|MPCS_NO=" & mpcsNo & "|SCHEME=" & schemeVal
                    Dim milkQrEnc As String = bgr.NiotEncrypt(milkQrPlain, bgr.enc_key("BENEFICIARY_FILE_NAME"))
                    imgMilkQr.ImageUrl = bgr.generate_qrcode(milkQrEnc, Server.MapPath("~/ASSETS/IMAGES/tab_logo.jpg"))
                End If
            Catch ex As Exception
                errmsg.Visible = True
                errmsg.InnerHtml = "Error binding applicant preview: " & ex.Message
            End Try
        End If
    End Sub

    Protected Function doc_image(ByVal bid As String, ByVal did As String) As String
        Try
            If String.IsNullOrWhiteSpace(bid) OrElse String.IsNullOrWhiteSpace(did) Then
                Return String.Empty
            End If

            Dim fp As String = Server.MapPath("~/UPLOAD/DOC/" & bgrenc.file_name_encrypt(bid) & ".json")
            If Not File.Exists(fp) Then
                Return String.Empty
            End If

            Dim jsondata As String = File.ReadAllText(fp)
            Dim dt As DataTable = JsonConvert.DeserializeObject(Of DataTable)(jsondata)
            Dim rowIndex As Integer = Convert.ToInt32(did)

            If dt Is Nothing OrElse rowIndex < 0 OrElse rowIndex >= dt.Rows.Count Then
                Return String.Empty
            End If

            Dim base64Str As String = Convert.ToString(dt.Rows(rowIndex)("val")).Trim()
            If String.IsNullOrEmpty(base64Str) OrElse base64Str = "0" Then
                Return String.Empty
            End If

            Dim decryptedBase64 As String = bgr.NiotDecrypt(base64Str, bgr.enc_key("BENEFICIARY_FILE_DATA"))
            If String.IsNullOrWhiteSpace(decryptedBase64) Then
                Return String.Empty
            End If

            Return "data:image/jpeg;base64," & decryptedBase64
        Catch
            Return String.Empty
        End Try
    End Function
End Class