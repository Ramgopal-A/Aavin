Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.IO
Imports System.Reflection
Imports MySql.Data.MySqlClient
Public Class OFFICER
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrdb As New bgrdb
    Dim captcha_str As String
    Dim u_key As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If hf_captcha.Value = "" Then
            GenerateCaptcha()
        End If
    End Sub
    Private Sub LOGMPU_Init(sender As Object, e As EventArgs) Handles Me.Init
        conn.ConnectionString = bgrdb.conn_str("mini_diary")
        cmnd.Connection = conn
        cmnd.CommandType = CommandType.StoredProcedure
        MultiView1.ActiveViewIndex = 0
        errmsg.Visible = False
    End Sub
    Private Sub ButtonSignIn_Click(sender As Object, e As EventArgs) Handles ButtonSignIn.Click
        Try
            Dim ukey As String = bgr.NiotDecrypt(Session("u_key"), bgr.enc_key("SESSION_VAL"))
            If tb_otp.Text = bgr.NiotDecrypt(HiddenFieldOTP.Value.ToString, ukey) Then
                Select Case Session("u_type")
                    Case "MPCS"
                        Response.Redirect("~/MPCS")
                    Case "MPU"
                        Response.Redirect("~/MPU")
                    Case "BANK"
                        Response.Redirect("~/BANK")
                    Case "ADMIN"
                        Response.Redirect("~/MPFL/ADMIN")
                    Case "DASH"
                        Response.Redirect("~/MPFL/DASHBOARD")
                    Case "BANK"
                        Response.Redirect("~/BANK")
                End Select
            Else
                errmsg.Visible = True
                errmsg.InnerHtml = "You have entered a wrong OTP. Check the OTP in Telegram app."
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 101 : " + ex.Message
        End Try
    End Sub
    Private Sub ButtonSendOTP_Click(sender As Object, e As EventArgs) Handles ButtonSendOTP.Click
        Try
            If tb_captcha.Text = bgr.NiotDecrypt(hf_captcha.Value.ToString, bgr.enc_key("SESSION_VAL")) Then
                cmnd.CommandText = "sp_login"
                cmnd.Parameters.Clear()
                Select Case dd_utype.SelectedValue.ToString
                    Case "MPFL"
                        cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_MPFL"))
                    Case "BANK"
                        cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_BANK"))
                    Case "MPU"
                        cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_MPU"))
                    Case "MPCS"
                        cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_MPCS"))
                End Select
                cmnd.Parameters.AddWithValue("@iutype", dd_utype.SelectedValue.ToString)
                cmnd.Parameters.AddWithValue("@iuname", tb_uname.Text)
                Dim adptr As New MySqlDataAdapter(cmnd)
                Dim dttbl As New DataTable
                adptr.Fill(dttbl)
                If dttbl.Rows(0).Item("u_stat").ToString <> "Success" Then
                    errmsg.Visible = True
                    errmsg.InnerHtml = dttbl.Rows(0).Item("u_stat").ToString
                    MultiView1.ActiveViewIndex = 0
                    tb_uname.Focus()
                Else
                    ReGenerateSessionId()
                    Session.Timeout = 30
                    tb_uname1.Text = tb_uname.Text
                    u_key = Guid.NewGuid().ToString().Replace("-", "").ToUpper().Substring(0, 24)
                    Dim otp As String = bgr.generateotp(6)
                    HiddenFieldOTP.Value = bgr.NiotEncrypt(otp, u_key)
                    Dim msgstr As String
                    Session.Timeout = 30
                    Session("enc_cap") = HiddenFieldOTP.Value
                    Select Case dd_utype.SelectedValue.ToString
                        Case "MPCS"
                            Session("u_key") = bgr.NiotEncrypt(u_key, bgr.enc_key("SESSION_VAL"))
                            Session("u_type") = dttbl.Rows(0).Item("u_type").ToString
                            Session("mpcs_un") = bgr.NiotEncrypt(tb_uname.Text, u_key)
                            Session("mpcs_id") = bgr.NiotEncrypt(dttbl.Rows(0).Item("u_id").ToString, u_key)
                            Session("mpcs_name") = dttbl.Rows(0).Item("u_name").ToString
                            Session(bgr.NiotEncrypt("auth", u_key)) = bgr.NiotEncrypt("MPCS", u_key)
                        Case "MPU"
                            Session("u_key") = bgr.NiotEncrypt(u_key, bgr.enc_key("SESSION_VAL"))
                            Session("u_type") = dttbl.Rows(0).Item("u_type").ToString
                            Session("mpu_un") = bgr.NiotEncrypt(tb_uname.Text, u_key)
                            Session("mpu_id") = bgr.NiotEncrypt(dttbl.Rows(0).Item("u_id").ToString, u_key)
                            Session("mpu_name") = dttbl.Rows(0).Item("u_name").ToString
                            Session(bgr.NiotEncrypt("auth", u_key)) = bgr.NiotEncrypt("MPU", u_key)
                        Case "MPFL"
                            Session("u_key") = bgr.NiotEncrypt(u_key, bgr.enc_key("SESSION_VAL"))
                            Session("u_type") = dttbl.Rows(0).Item("u_type").ToString
                            Session("mpfl_un") = bgr.NiotEncrypt(tb_uname.Text, u_key)
                            Session("mpfl_id") = bgr.NiotEncrypt(dttbl.Rows(0).Item("u_id").ToString, u_key)
                            Session("mpfl_name") = dttbl.Rows(0).Item("u_name").ToString
                            Session(bgr.NiotEncrypt("auth", u_key)) = bgr.NiotEncrypt("MPFL", u_key)
                        Case "BANK"
                            Session("u_key") = bgr.NiotEncrypt(u_key, bgr.enc_key("SESSION_VAL"))
                            Session("u_type") = dttbl.Rows(0).Item("u_type").ToString
                            Session("bank_un") = bgr.NiotEncrypt(tb_uname.Text, u_key)
                            Session("bank_id") = bgr.NiotEncrypt(dttbl.Rows(0).Item("u_id").ToString, u_key)
                            Session("bank_name") = dttbl.Rows(0).Item("u_name").ToString
                            Session(bgr.NiotEncrypt("auth", u_key)) = bgr.NiotEncrypt("BANK", u_key)
                    End Select
                    HiddenFieldcid.Value = dttbl.Rows(0).Item("tel_id").ToString
                    msgstr = "Dear " + dttbl.Rows(0).Item("u_name").ToString + "," + vbCrLf +
                          "Your Login OTP is " + otp + ". Please don't share this OTP to any one." + vbCrLf +
                          "TCMPFL."
                    bgr.send_telegram_msg(HiddenFieldcid.Value.ToString, msgstr)
                    MultiView1.ActiveViewIndex = 1
                    errmsg.Visible = False
                End If
            Else
                tb_captcha.Text = ""
                errmsg.Visible = True
                errmsg.InnerHtml = "Captcha did not match! Please try again."
                tb_captcha.Focus()
            End If


        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 100 : " + ex.Message
        End Try

    End Sub
    Private Sub Buttonresendotp_Click(sender As Object, e As EventArgs) Handles Buttonresendotp.Click
        Dim msgstr, otp As String
        otp = bgr.NiotDecrypt(HiddenFieldOTP.Value.ToString, u_key)
        msgstr = "Dear " + Session("mpu_name") + "," + vbCrLf +
  "Your Login OTP is " + otp + ". Please don't share this OTP to any one." + vbCrLf +
  "TABCEDCO."
        bgr.send_telegram_msg(HiddenFieldcid.Value.ToString, msgstr)
    End Sub
    Private Sub Buttoncancel_Click(sender As Object, e As EventArgs) Handles Buttoncancel.Click
        tb_uname.Text = tb_uname1.Text = ""
        MultiView1.ActiveViewIndex = 0
    End Sub
    Private Sub lbtn_captcha_ref_Click(sender As Object, e As EventArgs) Handles lbtn_captcha_ref.Click
        GenerateCaptcha()
    End Sub
    Private Sub GenerateCaptcha()
        captcha_str = bgr.generateotp(6)
        hf_captcha.Value = bgr.NiotEncrypt(captcha_str, bgr.enc_key("SESSION_VAL"))
        Dim captchaImage As Image = bgr.GenerateCaptchaImage(captcha_str)
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
            If field.Name.Equals("_store") Then
                store = CType(field.GetValue(ssm), SessionStateStoreProviderBase)
            End If
            If field.Name.Equals("_rqId") Then
                rqIdField = field
            End If
            If field.Name.Equals("_rqLockId") Then
                rqLockIdField = field
            End If
            If field.Name.Equals("_rqSessionStateNotFound") Then
                rqStateNotFoundField = field
            End If
            If field.Name.Equals("_rqItem") Then
                rqItem = CType(field.GetValue(ssm), SessionStateStoreData)
            End If
        Next
        Dim lockId As Object = rqLockIdField.GetValue(ssm)
        If lockId IsNot Nothing AndAlso oldId IsNot Nothing Then
            store.RemoveItem(Context, oldId, lockId, rqItem)
        End If
        rqStateNotFoundField.SetValue(ssm, True)
        rqIdField.SetValue(ssm, newId)
    End Sub


End Class