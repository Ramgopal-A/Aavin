Imports MySql.Data.MySqlClient
Imports System.Security.Cryptography

Public Class REGBEN2
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgrdb As New bgrdb
    Dim bgr As New bgr
    Dim bgrdd As New bgrdd
    Dim bgrsms As New bgrsms

    Private Sub REGBEN2_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            If IsNothing(Session("otrpk")) Then
                Response.Redirect("~/ONLINE")
            Else
                Dim keystr As String = bgr.NiotDecrypt(Session("otrpk").ToString, bgr.enc_key("SESSION_VAL"))
                If DecryptValue(Session("otrpa").ToString, keystr) = "REGBEN2" Then
                    Me.Master.FindControl("btn_lang").Visible = False
                    conn.ConnectionString = bgrdb.conn_str("mini_diary")
                    cmnd.Connection = conn
                    cmnd.CommandType = CommandType.StoredProcedure
                    bgrdd.fill_ben(conn, dd_ben_district, "district", "", "")
                    dd_ben_pdistrict.DataSource = dd_ben_district.DataSource
                    dd_ben_pdistrict.DataTextField = "textfield"
                    dd_ben_pdistrict.DataValueField = "valuefield"
                    dd_ben_pdistrict.DataBind()
                    cmnd.Connection = conn
                    data_fill(Session("tagv"), Session("tagk"))
                    errmsg.Visible = False
                Else
                    Response.Redirect("REGBEN1")
                End If
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 101 : " + ex.Message
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Try
            If IsNothing(Session("otrpk")) Then
                Response.Redirect("~/ONLINE")
            Else
                Dim keystr As String = bgr.NiotDecrypt(Session("otrpk").ToString, bgr.enc_key("SESSION_VAL"))
                If DecryptValue(Session("otrpa").ToString, keystr) = "REGBEN2" Then
                    errmsg.Visible = False
                Else
                    Response.Redirect("REGBEN1")
                End If
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 102 : " + ex.Message
        End Try
    End Sub

    Private Sub dd_ben_district_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dd_ben_district.SelectedIndexChanged
        Try
            bgrdd.fill_ben(conn, dd_ben_taluk, "taluk", dd_ben_district.SelectedValue.ToString, "")
            bgrdd.fill_ben(conn, dd_ben_village, "village", dd_ben_district.SelectedValue.ToString, "")
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 103 : " + ex.Message
        End Try
    End Sub

    Protected Sub data_fill(ByVal tagv As String, ByVal tagk As String)
        Try
            Dim decryptionKey As String = bgr.NiotDecrypt(tagk.ToString, bgr.enc_key("SESSION_VAL"))
            Dim decrypted As String = DecryptValue(tagv, decryptionKey)
            Dim values() As String = decrypted.Split("|"c)
            Dim maskedAadhar As String = MaskValue(values(5))
            Dim maskedSmartCard As String = MaskValue(values(6))
            lbl_salutation.Text = values(7)
            lbl_ben_name.Text = values(1)
            lbl_dob.Text = values(2)
            lbl_age.Text = bgr.dob2age(DateTime.ParseExact(lbl_dob.Text, "dd-MM-yyyy", Nothing))
            lbl_caste_cat.Text = values(8)
            lbl_mobno.Text = values(4)
            lbl_aadhar.Text = maskedAadhar
            lbl_smartcard.Text = maskedSmartCard
            bgrdd.fill_ben(conn, dd_ben_caste, "caste", values(3), "")
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 104 : " + ex.Message
        End Try
    End Sub

    Private Sub cb_address_CheckedChanged(sender As Object, e As EventArgs) Handles cb_address.CheckedChanged
        Try
            If cb_address.Checked Then
                tb_ben_paddr.Text = tb_ben_addr.Text
                tb_ben_ppincode.Text = tb_ben_pincode.Text
                dd_ben_pdistrict.SelectedIndex = dd_ben_district.SelectedIndex
                tb_ben_paddr.Enabled = False
                tb_ben_ppincode.Enabled = False
                dd_ben_pdistrict.Enabled = False
            Else
                tb_ben_paddr.Text = ""
                tb_ben_ppincode.Text = ""
                dd_ben_pdistrict.ClearSelection()
                tb_ben_paddr.Enabled = True
                tb_ben_ppincode.Enabled = True
                dd_ben_pdistrict.Enabled = True
            End If
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 105 : " + ex.Message
        End Try
    End Sub

    Private Function MaskValue(ByVal input As String) As String
        If input.Length >= 8 Then
            Return New String("*"c, 8) & input.Substring(8)
        End If
        Return New String("*"c, input.Length)
    End Function

    Private Sub btn_submit_Click(sender As Object, e As EventArgs) Handles btn_submit.Click
        Try
            If ckbox_ackw.Checked Then
                Dim tagk As String = Session("tagk").ToString
                Dim tagv As String = Session("tagv").ToString
                Dim decryptionKey As String = bgr.NiotDecrypt(tagk.ToString, bgr.enc_key("SESSION_VAL"))
                Dim decrypted As String = DecryptValue(tagv, decryptionKey)
                Dim values() As String = decrypted.Split("|"c)
                Dim autoPassword As String = Guid.NewGuid().ToString("N").Substring(0, 12)

                cmnd.CommandType = CommandType.StoredProcedure
                cmnd.CommandText = "sp_ben_otr"
                cmnd.Parameters.Clear()
                cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_BENEFICIARY"))
                cmnd.Parameters.AddWithValue("@iben_salutation", Val(values(0)))
                cmnd.Parameters.AddWithValue("@iben_name", values(1))
                cmnd.Parameters.AddWithValue("@iben_dob", Date.ParseExact(values(2), "dd-MM-yyyy", Nothing))
                cmnd.Parameters.AddWithValue("@iben_caste_cat_id", Val(values(3)))
                cmnd.Parameters.AddWithValue("@iben_caste_id", Val(dd_ben_caste.SelectedItem.Value.ToString))
                cmnd.Parameters.AddWithValue("@iben_mobile_no", values(4).Trim())
                cmnd.Parameters.AddWithValue("@iben_aadhar", values(5).Trim())
                cmnd.Parameters.AddWithValue("@iben_nfsc", values(6))
                cmnd.Parameters.AddWithValue("@iben_gender", Val(dd_ben_gen.SelectedItem.Value.ToString))
                cmnd.Parameters.AddWithValue("@iben_pan", tb_ben_pan.Text.ToUpper)
                cmnd.Parameters.AddWithValue("@iben_pword", autoPassword)
                cmnd.Parameters.AddWithValue("@icare_of", Val(dd_care_of.SelectedItem.Value.ToString))
                cmnd.Parameters.AddWithValue("@iben_fh_name", tb_ben_fh_name.Text.ToUpper)
                cmnd.Parameters.AddWithValue("@iben_relegion", Val(dd_ben_rel.SelectedItem.Value.ToString))
                cmnd.Parameters.AddWithValue("@iben_community_cert", tb_ben_comm_cer_no.Text.ToUpper)
                cmnd.Parameters.AddWithValue("@iben_widow", Val(dd_ben_disability.SelectedItem.Value.ToString))
                cmnd.Parameters.AddWithValue("@iben_district", Val(dd_ben_district.SelectedItem.Value.ToString))
                cmnd.Parameters.AddWithValue("@iben_pincode", tb_ben_pincode.Text)
                cmnd.Parameters.AddWithValue("@iben_taluk", Val(dd_ben_taluk.SelectedItem.Value.ToString))
                cmnd.Parameters.AddWithValue("@iben_village", Val(dd_ben_village.SelectedItem.Value.ToString))
                cmnd.Parameters.AddWithValue("@iben_addr", tb_ben_addr.Text)
                cmnd.Parameters.AddWithValue("@iben_email", "")
                cmnd.Parameters.AddWithValue("@iben_paddr", tb_ben_paddr.Text)
                cmnd.Parameters.AddWithValue("@iben_pdistrict", Val(dd_ben_pdistrict.SelectedItem.Value.ToString))
                cmnd.Parameters.AddWithValue("@iben_ppincode", tb_ben_ppincode.Text)
                cmnd.Parameters.AddWithValue("@iben_bank_acc_no", tb_bank_acc_no.Text)
                cmnd.Parameters.AddWithValue("@iben_bank_name", tb_bank_name.Text)
                cmnd.Parameters.AddWithValue("@iben_branch_name", tb_bank_branch.Text)
                cmnd.Parameters.AddWithValue("@iben_ifsc", tb_bank_ifsc.Text)

                Dim otr_status As String
                conn.Open()
                otr_status = Convert.ToString(cmnd.ExecuteScalar())
                conn.Close()

                Dim otr_result() As String = otr_status.Split("-"c)
                Select Case otr_result(0)
                    Case "0"
                        errmsg.Visible = True
                        errmsg.InnerHtml = otr_result(1)
                        errmsg.Focus()
                    Case Else
                        ' Fetch the exact numeric ben_id created by sp_ben_otr
                        cmnd.CommandType = CommandType.StoredProcedure
                        cmnd.CommandText = "sp_ben_otp_login"
                        cmnd.Parameters.Clear()
                        cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_BENEFICIARY"))
                        cmnd.Parameters.AddWithValue("@imobno", lbl_mobno.Text.Trim())
                        cmnd.Parameters.AddWithValue("@iip_address", Request.ServerVariables("REMOTE_ADDR"))
                        cmnd.Parameters.AddWithValue("@idevice_info", Request.UserAgent())
                        cmnd.Parameters.AddWithValue("@isession_id", Session.SessionID)

                        Dim adptr As New MySqlDataAdapter(cmnd)
                        Dim dttbl As New DataTable
                        adptr.Fill(dttbl)

                        If dttbl.Rows.Count > 0 Then
                            Dim newBenId As String = dttbl.Rows(0)("ben_id").ToString()
                            Dim benName As String = dttbl.Rows(0)("oben_name").ToString()
                            Dim otrStat As String = dttbl.Rows(0)("otr_status").ToString()

                            Session.Timeout = 30
                            Session("loggedin") = "BEN"
                            Session("enc_cap") = bgr.NiotEncrypt(bgr.generateotp(6), bgr.enc_key("SESSION_VAL"))
                            Session(bgr.NiotEncrypt("ben_id", bgr.enc_key("SESSION_VAR"))) = bgr.NiotEncrypt(newBenId, bgr.enc_key("SESSION_VAL"))
                            Session(bgr.NiotEncrypt("ben_name", bgr.enc_key("SESSION_VAR"))) = bgr.NiotEncrypt(benName, bgr.enc_key("SESSION_VAL"))
                            Session(bgr.NiotEncrypt("page_auth", bgr.enc_key("SESSION_VAR"))) = bgr.NiotEncrypt("BEN_OTR_REG_STEP1", bgr.enc_key("SESSION_VAL"))
                            Session(bgr.NiotEncrypt("otr_auth", bgr.enc_key("SESSION_VAR"))) = bgr.NiotEncrypt("BEN_OTR", bgr.enc_key("SESSION_VAL"))
                            Session("otr_stat") = If(String.IsNullOrWhiteSpace(otrStat), "One Time Registration Completed", otrStat)

                            Try
                                bgrsms.send_sms_loan_sub(lbl_mobno.Text, lbl_ben_name.Text, otr_result(0))
                            Catch
                            End Try

                            Response.Redirect("~/ONLINE/BEN/FILEUPLOAD", False)
                            Context.ApplicationInstance.CompleteRequest()
                        Else
                            Response.Redirect("~/ONLINE", False)
                            Context.ApplicationInstance.CompleteRequest()
                        End If
                End Select
            Else
                errmsg.Visible = True
                errmsg.InnerHtml = "Certify the data entered are correct by click the appropriate button at the bottom."
            End If
        Catch ex As Exception
            If conn.State = ConnectionState.Open Then conn.Close()
            errmsg.Visible = True
            errmsg.InnerHtml = "save_data " + ex.Message
        End Try
    End Sub

    Private Function EncryptValue(ByVal plainText As String, ByVal key As String) As String
        Dim aes As New System.Security.Cryptography.AesCryptoServiceProvider()
        aes.KeySize = 128
        aes.BlockSize = 128
        aes.Mode = System.Security.Cryptography.CipherMode.CBC
        aes.Padding = System.Security.Cryptography.PaddingMode.PKCS7
        Dim keyBytes As Byte() = System.Text.Encoding.UTF8.GetBytes(key.Substring(0, 16))
        aes.Key = keyBytes
        aes.GenerateIV()
        Dim iv As Byte() = aes.IV
        Dim encryptor As System.Security.Cryptography.ICryptoTransform = aes.CreateEncryptor()
        Dim plainBytes As Byte() = System.Text.Encoding.UTF8.GetBytes(plainText)
        Dim encryptedBytes As Byte() = encryptor.TransformFinalBlock(plainBytes, 0, plainBytes.Length)
        Dim resultBytes As Byte() = iv.Concat(encryptedBytes).ToArray()
        Return Convert.ToBase64String(resultBytes)
    End Function

    Private Function DecryptValue(ByVal base64Encrypted As String, ByVal key As String) As String
        Dim fullCipher As Byte() = Convert.FromBase64String(base64Encrypted)
        Dim iv As Byte() = fullCipher.Take(16).ToArray()
        Dim cipher As Byte() = fullCipher.Skip(16).ToArray()

        Using aes As New AesCryptoServiceProvider()
            aes.KeySize = 128
            aes.BlockSize = 128
            aes.Key = Encoding.UTF8.GetBytes(key.Substring(0, 16))
            aes.IV = iv
            aes.Padding = PaddingMode.PKCS7
            aes.Mode = CipherMode.CBC

            Using decryptor As ICryptoTransform = aes.CreateDecryptor()
                Dim decryptedBytes As Byte() = decryptor.TransformFinalBlock(cipher, 0, cipher.Length)
                Return Encoding.UTF8.GetString(decryptedBytes)
            End Using
        End Using
    End Function
End Class