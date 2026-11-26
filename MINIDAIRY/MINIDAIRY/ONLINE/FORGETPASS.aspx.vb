Imports MySql.Data.MySqlClient

Public Class FORGETPASS
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrsms As New bgrsms
    Dim bgrdb As New bgrdb

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub FORGETPASSIND_Init(sender As Object, e As EventArgs) Handles Me.Init
        conn.ConnectionString = bgrdb.conn_str("mini_diary")
        cmnd.Connection = conn
        cmnd.CommandType = CommandType.StoredProcedure
        errmsg.Visible = False
        MultiView1.ActiveViewIndex = 0
        MultiView2.ActiveViewIndex = -1
    End Sub


    Private Sub btn_bendetails_Click(sender As Object, e As EventArgs) Handles btn_bendetails.Click
        Try
            cmnd.CommandText = "sp_ben_forgetpass"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@icmd", "S")
            cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_BENEFICIARY"))
            cmnd.Parameters.AddWithValue("@iuname", tb_ben_det.Text)
            cmnd.Parameters.AddWithValue("@iben_pword", "")
            Dim adptr As New MySqlDataAdapter(cmnd)
            Dim dttbl As New DataTable
            adptr.Fill(dttbl)
            If dttbl.Rows.Count > 0 Then
                errmsg.Visible = False
                lbl_ben_tabid.Text = dttbl.Rows(0).Item("oben_tabid").ToString
                lbl_ben_name.Text = dttbl.Rows(0).Item("oben_name").ToString
                lbl_mob_no.Text = dttbl.Rows(0).Item("oben_mobile_no").ToString
                hf_ben_id.Value = bgr.NiotEncrypt(dttbl.Rows(0).Item("ben_id").ToString, bgr.enc_key("FORGETPASS"))
                MultiView1.ActiveViewIndex = 1
                MultiView2.ActiveViewIndex = 0
            Else
                errmsg.Visible = True
                errmsg.InnerHtml = "You will get a OTP if you are a beneficiary. <br> நீங்கள் பயனாளியாக இருந்தால் OTP கிடைக்கும்."
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 101:" + ex.Message
        End Try
    End Sub

    Private Sub btn_gen_otp_Click(sender As Object, e As EventArgs) Handles btn_gen_otp.Click
        Try
            Dim otp As String = bgr.generateotp(6)
            hf_otp.Value = bgr.NiotEncrypt(otp, bgr.enc_key("BENEFICIARY_MOBILE_OTP"))
            bgrsms.send_sms_otp(lbl_mob_no.Text, lbl_ben_name.Text, otp)
            MultiView2.ActiveViewIndex = 1
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "btn_gen_otp_clk : " + ex.Message
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
                bgrsms.send_sms_otp(lbl_mob_no.Text, lbl_ben_name.Text, otp)
                errmsg.Visible = False
            Else
                errmsg.Visible = True
                errmsg.InnerHtml = "OTP Resent for 2 times. Further resending is not allowed."
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "btn_otp_resend" + ex.Message
        End Try
    End Sub
    Private Sub btn_complete_Click(sender As Object, e As EventArgs) Handles btn_complete.Click
        Try
            Dim uname As String = bgr.NiotDecrypt(hf_ben_id.Value.ToString, bgr.enc_key("FORGETPASS"))
            cmnd.CommandText = "sp_ben_forgetpass"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@icmd", "U")
            cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_BENEFICIARY"))
            cmnd.Parameters.AddWithValue("@iuname", uname)
            cmnd.Parameters.AddWithValue("@iben_pword", tb_pass.Text)
            conn.Open()
            cmnd.ExecuteNonQuery()
            conn.Close()
            errmsg.Visible = False
            MultiView1.ActiveViewIndex = 2
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 101:" + ex.Message
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
                Return
            End If
            If tb_mobile_otp.Text = bgr.NiotDecrypt(hf_otp.Value.ToString, bgr.enc_key("BENEFICIARY_MOBILE_OTP")) Then
                MultiView2.ActiveViewIndex = 2
                errmsg.Visible = False
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
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "btn_otp_verify" + ex.Message
        End Try
    End Sub

End Class