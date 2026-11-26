Imports MySql.Data.MySqlClient
Imports System.Security.Cryptography

Public Class REGBEN1
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrdb As New bgrdb
    Dim bgrdd As New bgrdd
    Dim bgrsms As New bgrsms
    Private Sub REG1_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            If IsNothing(Session("otrpk")) Then
                Response.Redirect("~/ONLINE")
            Else
                Dim keystr As String = bgr.NiotDecrypt(Session("otrpk").ToString, bgr.enc_key("SESSION_VAL"))
                If DecryptValue(Session("otrpa").ToString, keystr) = "REGBEN1" Then
                    Me.Master.FindControl("btn_lang").Visible = False
                    conn.ConnectionString = bgrdb.conn_str("mini_diary")
                    cmnd.Connection = conn
                    cmnd.CommandType = CommandType.StoredProcedure
                    bgrdd.fill_ben(conn, dd_ben_caste_cat, "caste_cat", "", "")
                    errmsg.Visible = False
                    MultiView1.ActiveViewIndex = 0
                Else
                    Response.Redirect("~/ONLINE")
                End If
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 100 : " + ex.Message
        End Try

    End Sub

    Private Sub btn_step1_next_Click(sender As Object, e As EventArgs) Handles btn_step1_next.Click
        Try
            MultiView1.ActiveViewIndex = 1
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 102 : " + ex.Message
        End Try

    End Sub
    Protected Function validate_data() As Boolean
        errmsg.Visible = True
        Dim dob As Date = Date.ParseExact(tb_ben_dob.Text, "yyyy-MM-dd", Nothing)
        Dim age As Integer = bgr.dob2age(dob)
        If IsDate(dob) = False Then
            errmsg.InnerHtml = "Date of birth is not a valid date."
            tb_ben_dob.CssClass = "form-control is-invalid"
            Return False
        End If
        If age < 21 Or age > 60 Then
            errmsg.InnerHtml = "Applicant's age should be from 21 to 60."
            tb_ben_dob.CssClass = "form-control is-invalid"
            Return False
        End If
        cmnd.CommandText = "sp_ben_otr_check"
        cmnd.Parameters.Clear()
        cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_BENEFICIARY"))
        cmnd.Parameters.AddWithValue("@imobno", tb_ben_mobno.Text)
        cmnd.Parameters.AddWithValue("@iaadhar", tb_ben_aadhar.Text)
        cmnd.Parameters.AddWithValue("@infsc", tb_ben_smartcard.Text)
        Dim adptr As New MySqlDataAdapter(cmnd)
        Dim dttbl As New DataTable
        adptr.Fill(dttbl)
        Dim chk_m, chk_a, chk_n As Integer
        chk_m = Val(dttbl.Rows(0).Item(0).ToString)
        chk_a = Val(dttbl.Rows(0).Item(1).ToString)
        chk_n = Val(dttbl.Rows(0).Item(2).ToString)
        If chk_m > 0 Then
            errmsg.InnerHtml = "Mobile Number exists already. (கைபேசி எண் ஏற்கனவே பதிவேற்றப்பட்டு உள்ளது). <br> Please enter your mobile phone properly. (உங்களுடைய கைபேசி எண்ணை சரியாக உள்ளிடவும்)."
            tb_ben_mobno.CssClass = "form-control is-invalid"
            Return False
        End If
        If chk_a > 0 Then
            errmsg.InnerHtml = "Aadhar Identity exists already.(ஆதார் எண் ஏற்கனவே பதிவேற்றப்பட்டு உள்ளது). <br> Please enter your aadhar identity number properly. (உங்களுடைய ஆதார் எண்ணை சரியாக உள்ளிடவும்)."
            tb_ben_aadhar.CssClass = "form-control is-invalid"
            Return False
        End If
        If chk_n > 0 Then
            errmsg.InnerHtml = "New Family Smart Card exists already. (புதிய குடும்ப மின்னனு அட்டை எண் ஏற்கனவே பதிவேற்றப்பட்டு உள்ளது). <br> Please enter your new family smart card number properly. (உங்களுடைய புதிய குடும்ப மின்னனு அட்டை எண்ணை சரியாக உள்ளிடவும்)."
            tb_ben_smartcard.CssClass = "form-control is-invalid"
            Return False
        End If
        Return True


    End Function
    Private Sub btn_step_prev_Click(sender As Object, e As EventArgs) Handles btn_step_prev.Click
        MultiView1.ActiveViewIndex = 0
    End Sub
    Private Sub btn_gen_otp_Click(sender As Object, e As EventArgs) Handles btn_gen_otp.Click
        Try
            If validate_data() = True Then

                Dim sal_val As String = dd_salutation.SelectedItem.Value.ToString
                Dim sal_text As String = dd_salutation.SelectedItem.Text.ToString
                Dim bname As String = tb_ben_name.Text.ToUpper.Trim()
                Dim dob As Date = DateTime.ParseExact(tb_ben_dob.Text, "yyyy-MM-dd", Nothing)
                Dim comm_val As String = dd_ben_caste_cat.SelectedItem.Value.ToString
                Dim comm_text As String = dd_ben_caste_cat.SelectedItem.Text.ToString
                Dim mobileno As String = tb_ben_mobno.Text
                Dim aadhar As String = tb_ben_aadhar.Text.Trim()
                Dim smartCard As String = tb_ben_smartcard.Text.Trim()
                Dim concatenated As String = String.Join("|", sal_val, bname, dob.ToString("dd-MM-yyyy"), comm_val, mobileno, aadhar, smartCard, sal_text, comm_text)
                Dim guidstr As String = Guid.NewGuid().ToString("N")
                Session("tagk") = bgr.NiotEncrypt(guidstr, bgr.enc_key("SESSION_VAL"))
                Session("tagv") = EncryptValue(concatenated, guidstr)
                Dim decrypted As String = DecryptValue(Session("tagv"), guidstr)
                Dim values() As String = decrypted.Split("|"c)
                Dim maskedAadhar As String = MaskValue(values(5))
                Dim maskedSmartCard As String = MaskValue(values(6))
                lbl_salutation.Text = values(7)
                lbl_ben_name.Text = values(1)
                lbl_dob.Text = values(2)
                lbl_age.Text = bgr.dob2age(dob)
                lbl_caste_cat.Text = values(8)
                lbl_mobno.Text = values(4)
                lbl_aadhar.Text = maskedAadhar
                lbl_smartcard.Text = maskedSmartCard
                Dim otp As String = bgr.generateotp(6)
                hf_otp.Value = bgr.NiotEncrypt(otp, bgr.enc_key("BENEFICIARY_MOBILE_OTP"))
                bgrsms.send_sms_otp(tb_ben_mobno.Text, lbl_ben_name.Text, otp)
                MultiView1.ActiveViewIndex = 2
                errmsg.Visible = False
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 103 : " + ex.Message
        End Try
    End Sub

    Private Sub btn_otp_verify_Click(sender As Object, e As EventArgs) Handles btn_otp_verify.Click
        Try
            Dim maxAttempts As Integer = 3
            Dim lockoutDurationMinutes As Integer = 10
            Dim failedAttempts As Integer = If(Session("FailedOTPAttempts"), 0)
            Dim lockoutEndTime As DateTime? = If(Session("OTPTimeoutEnd"), Nothing)
            If lockoutEndTime.HasValue AndAlso DateTime.Now < lockoutEndTime Then
                errmsg.Visible = True
                errmsg.InnerHtml = "Too many failed attempts. Please try again after " & lockoutEndTime.Value.ToString("hh:mm tt")
            Else
                If tb_mobile_otp.Text = bgr.NiotDecrypt(hf_otp.Value.ToString, bgr.enc_key("BENEFICIARY_MOBILE_OTP")) Then
                    Dim keystr As String = bgr.NiotDecrypt(Session("otrpk").ToString, bgr.enc_key("SESSION_VAL"))
                    Session("otrpa") = EncryptValue("REGBEN2", keystr)
                    Response.Redirect("REGBEN2")
                Else
                    failedAttempts += 1
                    Session("FailedOTPAttempts") = failedAttempts
                    errmsg.Visible = True
                    If failedAttempts >= maxAttempts Then
 Session("OTPTimeoutEnd") = DateTime.Now.AddMinutes(lockoutDurationMinutes)
 errmsg.InnerHtml = "Too many failed attempts. Please try again after " & DateTime.Now.AddMinutes(lockoutDurationMinutes).ToString("hh:mm tt")
                    Else
 errmsg.InnerHtml = "Invalid OTP. You have " & (maxAttempts - failedAttempts) & " attempts remaining."
                    End If
                    tb_mobile_otp.CssClass = "form-control is-invalid"
                    tb_mobile_otp.Focus()
                End If
            End If

        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 104 : " + ex.Message
        End Try
    End Sub

    Private Sub btn_otp_resend_Click(sender As Object, e As EventArgs) Handles btn_otp_resend.Click
        Try
            Dim maxAttempts As Integer = 2
            Dim lockoutDurationMinutes As Integer = 5
            Dim resendAttempts As Integer = If(Session("resendAttempts"), 0)
            If resendAttempts <= maxAttempts Then
                resendAttempts += 1
                Session("resendAttempts") = resendAttempts
                Dim otp As String
                otp = bgr.NiotDecrypt(hf_otp.Value.ToString, bgr.enc_key("BENEFICIARY_MOBILE_OTP"))
                bgrsms.send_sms_otp(lbl_mobno.Text, lbl_ben_name.Text, otp)
                errmsg.Visible = False
            Else
                errmsg.Visible = True
                errmsg.InnerHtml = "OTP Resent for 2 times. Further resending is not allowed."
            End If
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