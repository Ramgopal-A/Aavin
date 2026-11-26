Public Class ZPROG
    Inherits System.Web.UI.Page
    Dim bgr As New bgr
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btn_bank_Click(sender As Object, e As EventArgs) Handles btn_bank.Click
        Dim u_keys As String = "ABCDEFGHIJKLMNOPQRSTUVWX"
        Session("u_type") = "BANK"
        Session("u_key") = bgr.NiotEncrypt(u_keys, bgr.enc_key("SESSION_VAL"))
        Session("bank_un") = bgr.NiotEncrypt("bank@aavin.net", u_keys)
        Session("bank_id") = bgr.NiotEncrypt(txt_id.Text, u_keys)
        Session("bank_name") = "Bank Name"
        Session(bgr.NiotEncrypt("auth", u_keys)) = bgr.NiotEncrypt("BANK", u_keys)
        Response.Redirect("~/BANK")
    End Sub

    Private Sub btn_mpcs_Click(sender As Object, e As EventArgs) Handles btn_mpcs.Click

    End Sub

    Private Sub btn_mpu_Click(sender As Object, e As EventArgs) Handles btn_mpu.Click
        Dim u_keys As String = "ABCDEFGHIJKLMNOPQRSTUVWX"
        Session("u_type") = "MPU"
        Session("u_key") = bgr.NiotEncrypt(u_keys, bgr.enc_key("SESSION_VAL"))
        Session("mpu_un") = bgr.NiotEncrypt("mpcs@aavin.net", u_keys)
        Session("mpu_id") = bgr.NiotEncrypt(txt_id.Text, u_keys)
        Session("mpu_name") = "Milk Producer Union"
        Session(bgr.NiotEncrypt("auth", u_keys)) = bgr.NiotEncrypt("MPU", u_keys)
        Response.Redirect("~/MPU")
    End Sub

    Private Sub btn_mpfl_Click(sender As Object, e As EventArgs) Handles btn_mpfl.Click
        Dim u_keys As String = "ABCDEFGHIJKLMNOPQRSTUVWX"
        Session("u_type") = "ADMIN"
        Session("u_key") = bgr.NiotEncrypt(u_keys, bgr.enc_key("SESSION_VAL"))
        Session("mpfl_un") = bgr.NiotEncrypt("mpfl@aavin.net", u_keys)
        Session("mpfl_id") = bgr.NiotEncrypt("1", u_keys)
        Session("mpfl_name") = "Milk Producer Federation Limited"
        Session(bgr.NiotEncrypt("auth", u_keys)) = bgr.NiotEncrypt("MPFL", u_keys)
        Response.Redirect("~/MPFL/ADMIN")
    End Sub
End Class