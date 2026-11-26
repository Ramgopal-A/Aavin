Imports Mysqlx.Expect.Open.Types.Condition.Types

Public Class ZMASTERMPU
    Inherits System.Web.UI.MasterPage
    Dim bgr As New bgr
    Public mpu_id As String
    Private Sub ZMASTERMPU_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            'Dim u_keys As String = "ABCDEFGHIJKLMNOPQRSTUVWX"
            'Session("u_type") = "MPU"
            'Session("u_key") = bgr.NiotEncrypt(u_keys, bgr.enc_key("SESSION_VAL"))
            'Session("mpu_un") = bgr.NiotEncrypt("mpcs@aavin.net", u_keys)
            'Session("mpu_id") = bgr.NiotEncrypt("26", u_keys)
            'Session("mpu_name") = "Milk Producer Union"
            'Session(bgr.NiotEncrypt("auth", u_keys)) = bgr.NiotEncrypt("MPU", u_keys)
            If Session("u_type") IsNot Nothing Then
                Dim u_key As String = bgr.NiotDecrypt(Session("u_key"), bgr.enc_key("SESSION_VAL"))
                If Session("u_type") = "MPU" And bgr.NiotDecrypt(Session(bgr.NiotEncrypt("auth", u_key)), u_key) = "MPU" Then
                    lbl_name.Text = Session("mpu_name")
                    lbl_uname.Text = bgr.NiotDecrypt(Session("mpu_un"), u_key)
                    mpu_id = bgr.NiotDecrypt(Session("mpu_id"), u_key)
                Else
                    Response.Redirect("~/ONLINE/OFFICER")
                End If
            Else
                Response.Redirect("~/ONLINE/OFFICER")
            End If
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("u_type") IsNot Nothing Then

        Else
            Response.Redirect("~/ONLINE/OFFICER")
        End If
    End Sub

    Private Sub lbtn_logout_Click(sender As Object, e As EventArgs) Handles lbtn_logout.Click
        Session.Clear()
        Session.Abandon()
        Response.Redirect("~/ONLINE/OFFICER")
    End Sub
End Class