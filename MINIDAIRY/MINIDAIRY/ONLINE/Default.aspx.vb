Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.IO
Imports System.Reflection
Imports System.Security.Cryptography
Imports MySql.Data.MySqlClient

Public Class _Default1
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrdb As New bgrdb
    Dim bgrsms As New bgrsms

    Private Sub _Default14_Init(sender As Object, e As EventArgs) Handles Me.Init
        conn.ConnectionString = bgrdb.conn_str("mini_diary")
        cmnd.Connection = conn
        cmnd.CommandType = CommandType.StoredProcedure
        Me.Master.FindControl("btn_lang").Visible = False
        errmsg.Visible = False
        succmsg.Visible = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            mv_login.ActiveViewIndex = 0
            GenerateCaptcha()
        End If
    End Sub

    Private Sub btn_gen_otp_Click(sender As Object, e As EventArgs) Handles btn_gen_otp.Click
        Try
            errmsg.Attributes("class") = "alert alert-danger"
            errmsg.Visible = False
            succmsg.Visible = False

            If Session("CaptchaText") Is Nothing OrElse tb_captcha.Text.Trim() <> Session("CaptchaText").ToString() Then
                errmsg.Visible = True
                errmsg.InnerHtml = "Captcha did not match! Please try again."
                tb_captcha.Text = ""
                GenerateCaptcha()
                Exit Sub
            End If

            cmnd.CommandText = "sp_ben_otp_login"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_BENEFICIARY"))
            cmnd.Parameters.AddWithValue("@imobno", tb_ben_mobno.Text.Trim())
            cmnd.Parameters.AddWithValue("@iip_address", Request.ServerVariables("REMOTE_ADDR"))
            cmnd.Parameters.AddWithValue("@idevice_info", Request.UserAgent())
            cmnd.Parameters.AddWithValue("@isession_id", Session.SessionID)

            Dim adptr As New MySqlDataAdapter(cmnd)
            Dim dttbl As New DataTable
            adptr.Fill(dttbl)

            If dttbl.Rows.Count = 0 Then
                errmsg.Attributes("class") = "alert alert-warning"
                errmsg.Visible = True
                errmsg.InnerHtml = "<strong>Mobile number not registered!</strong><br/>" &
                                   "Please complete <strong>One Time Registration</strong> before logging in.<br/>" &
                                   "<hr class='my-2'/>" &
                                   "<strong>இந்த கைபேசி எண் பதிவு செய்யப்படவில்லை!</strong><br/>" &
                                   "உள்நுழைவதற்கு முன் <strong>ஒரு முறை பதிவு (One Time Registration)</strong> செய்யவும்."
                tb_captcha.Text = ""
                GenerateCaptcha()
                Exit Sub
            End If

            Dim benId As String = dttbl.Rows(0)("ben_id").ToString()
            Dim benName As String = dttbl.Rows(0)("oben_name").ToString()
            Dim mobNo As String = dttbl.Rows(0)("oben_mobile_no").ToString()
            Dim otrStat As String = dttbl.Rows(0)("otr_status").ToString()

            ViewState("PendingBenId") = benId
            ViewState("PendingBenName") = benName
            ViewState("PendingMobNo") = mobNo
            ViewState("PendingOtrStat") = otrStat
            ViewState("LoginOtpAttempts") = 0
            ViewState("LoginOtpResends") = 0

            Dim otp As String = bgr.generateotp(6)
            hf_otp.Value = bgr.NiotEncrypt(otp, bgr.enc_key("BENEFICIARY_MOBILE_OTP"))
            bgrsms.send_sms_otp(mobNo, benName, otp)

            lbl_masked_mob.Text = If(mobNo.Length = 10, "******" & mobNo.Substring(6), mobNo)
            tb_otp.Text = ""
            mv_login.ActiveViewIndex = 1
            succmsg.Visible = True
            succmsg.InnerHtml = "OTP has been sent to your registered mobile number."
        Catch ex As Exception
            errmsg.Attributes("class") = "alert alert-danger"
            errmsg.Visible = True
            errmsg.InnerHtml = "Unable to process your request right now. Please try again later."
            GenerateCaptcha()
        End Try
    End Sub

    Private Sub btn_login_Click(sender As Object, e As EventArgs) Handles btn_login.Click
        Try
            errmsg.Visible = False
            succmsg.Visible = False

            Dim attempts As Integer = Convert.ToInt32(If(ViewState("LoginOtpAttempts"), 0))
            If attempts >= 3 Then
                errmsg.Visible = True
                errmsg.InnerHtml = "Too many invalid OTP attempts. Please click Change Number and try again."
                Exit Sub
            End If

            Dim expectedOtp As String = bgr.NiotDecrypt(hf_otp.Value, bgr.enc_key("BENEFICIARY_MOBILE_OTP"))
            If tb_otp.Text.Trim() = expectedOtp Then
                Dim benId As String = Convert.ToString(ViewState("PendingBenId"))
                Dim benName As String = Convert.ToString(ViewState("PendingBenName"))
                Dim otrStat As String = Convert.ToString(ViewState("PendingOtrStat"))

                ReGenerateSessionId()
                Session.Timeout = 30
                Session("loggedin") = "BEN"
                Session("enc_cap") = bgr.NiotEncrypt(expectedOtp, bgr.enc_key("SESSION_VAL"))
                Session(bgr.NiotEncrypt("ben_id", bgr.enc_key("SESSION_VAR"))) = bgr.NiotEncrypt(benId, bgr.enc_key("SESSION_VAL"))
                Session(bgr.NiotEncrypt("ben_name", bgr.enc_key("SESSION_VAR"))) = bgr.NiotEncrypt(benName, bgr.enc_key("SESSION_VAL"))
                Session(bgr.NiotEncrypt("page_auth", bgr.enc_key("SESSION_VAR"))) = bgr.NiotEncrypt("BEN_OTR_REG_STEP1", bgr.enc_key("SESSION_VAL"))
                Session(bgr.NiotEncrypt("otr_auth", bgr.enc_key("SESSION_VAR"))) = bgr.NiotEncrypt("BEN_OTR", bgr.enc_key("SESSION_VAL"))
                Session("otr_stat") = otrStat

                Response.Redirect("~/ONLINE/BEN", False)
                Context.ApplicationInstance.CompleteRequest()
            Else
                attempts += 1
                ViewState("LoginOtpAttempts") = attempts
                errmsg.Visible = True
                errmsg.InnerHtml = "Invalid OTP. Remaining attempts: " & (3 - attempts).ToString()
                tb_otp.Focus()
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 1002 : " + ex.Message
        End Try
    End Sub

    Private Sub btn_resend_otp_Click(sender As Object, e As EventArgs) Handles btn_resend_otp.Click
        Try
            errmsg.Visible = False
            Dim resends As Integer = Convert.ToInt32(If(ViewState("LoginOtpResends"), 0))
            If resends >= 2 Then
                errmsg.Visible = True
                errmsg.InnerHtml = "OTP already resent 2 times. Please click Change Number to restart."
                Exit Sub
            End If

            resends += 1
            ViewState("LoginOtpResends") = resends

            Dim mobNo As String = Convert.ToString(ViewState("PendingMobNo"))
            Dim benName As String = Convert.ToString(ViewState("PendingBenName"))
            Dim otp As String = bgr.NiotDecrypt(hf_otp.Value, bgr.enc_key("BENEFICIARY_MOBILE_OTP"))
            bgrsms.send_sms_otp(mobNo, benName, otp)

            succmsg.Visible = True
            succmsg.InnerHtml = "OTP resent to your registered mobile number."
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 1003 : " + ex.Message
        End Try
    End Sub

    Private Sub btn_change_mob_Click(sender As Object, e As EventArgs) Handles btn_change_mob.Click
        errmsg.Visible = False
        succmsg.Visible = False
        tb_otp.Text = ""
        tb_captcha.Text = ""
        GenerateCaptcha()
        mv_login.ActiveViewIndex = 0
    End Sub

    Private Sub btn_otr_Click(sender As Object, e As EventArgs) Handles btn_otr.Click
        Dim keystr As String = Guid.NewGuid().ToString("N").ToString
        Session("otrpk") = bgr.NiotEncrypt(keystr, bgr.enc_key("SESSION_VAL"))
        Session("otrpa") = EncryptValue("REGBEN1", keystr)
        Session.Timeout = 60
        Response.Redirect("REGBEN1")
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

    Private Sub lbtn_captcha_ref_Click(sender As Object, e As EventArgs) Handles lbtn_captcha_ref.Click
        GenerateCaptcha()
    End Sub

    Private Sub GenerateCaptcha()
        Dim captchaText As String = bgr.generateotp(6)
        Session("CaptchaText") = captchaText

        Dim captchaImage As Image = bgr.GenerateCaptchaImage(captchaText)
        Dim ms As New MemoryStream()
        captchaImage.Save(ms, ImageFormat.Png)

        imgCaptcha.ImageUrl = "data:image/png;base64," & Convert.ToBase64String(ms.ToArray())
    End Sub

    Protected Sub ReGenerateSessionId()
        Dim manager As New SessionIDManager()
        Dim oldId As String = manager.GetSessionID(Context)
        Dim newId As String = manager.CreateSessionID(Context)
        Dim isAdd As Boolean = False
        Dim isRedir As Boolean = False

        manager.RemoveSessionID(Context)
        manager.SaveSessionID(Context, newId, isRedir, isAdd)

        Dim ctx As HttpApplication = CType(HttpContext.Current.ApplicationInstance, HttpApplication)
        Dim mods As HttpModuleCollection = ctx.Modules
        Dim ssm As SessionStateModule = CType(mods.Get("Session"), SessionStateModule)

        Dim fields As FieldInfo() = ssm.GetType().GetFields(BindingFlags.NonPublic Or BindingFlags.Instance)
        Dim store As SessionStateStoreProviderBase = Nothing
        Dim rqIdField As FieldInfo = Nothing
        Dim rqLockIdField As FieldInfo = Nothing
        Dim rqStateNotFoundField As FieldInfo = Nothing
        Dim rqItem As SessionStateStoreData = Nothing

        For Each field As FieldInfo In fields
            If field.Name.Equals("_store") Then store = CType(field.GetValue(ssm), SessionStateStoreProviderBase)
            If field.Name.Equals("_rqId") Then rqIdField = field
            If field.Name.Equals("_rqLockId") Then rqLockIdField = field
            If field.Name.Equals("_rqSessionStateNotFound") Then rqStateNotFoundField = field
            If field.Name.Equals("_rqItem") Then rqItem = CType(field.GetValue(ssm), SessionStateStoreData)
        Next

        Dim lockId As Object = rqLockIdField.GetValue(ssm)
        If lockId IsNot Nothing AndAlso oldId IsNot Nothing Then
            store.RemoveItem(Context, oldId, lockId, rqItem)
        End If

        rqStateNotFoundField.SetValue(ssm, True)
        rqIdField.SetValue(ssm, newId)
    End Sub
End Class