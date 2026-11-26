Public Class ZMASTERMPFLDASH
    Inherits System.Web.UI.MasterPage
    Dim bgr As New bgr
    Public mpu_id As String
    Private Sub ZMASTERMPU_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            'Dim u_keys As String = "ABCDEFGHIJKLMNOPQRSTUVWX"
            'Session("u_type") = "DASH"
            'Session("u_key") = bgr.NiotEncrypt(u_keys, bgr.enc_key("SESSION_VAL"))
            'Session("mpfl_un") = bgr.NiotEncrypt("mpfl@aavin.net", u_keys)
            'Session("mpfl_id") = bgr.NiotEncrypt("1", u_keys)
            'Session("mpfl_name") = "Milk Producer Federation Limited"
            'Session(bgr.NiotEncrypt("auth", u_keys)) = bgr.NiotEncrypt("MPU", u_keys)
            If Session("u_type") IsNot Nothing Then
                Dim u_key As String = bgr.NiotDecrypt(Session("u_key"), bgr.enc_key("SESSION_VAL"))
                If Session("u_type") = "DASH" And bgr.NiotDecrypt(Session(bgr.NiotEncrypt("auth", u_key)), u_key) = "MPFL" Then
                    lbl_name.Text = Session("mpfl_name")
                    lbl_uname.Text = bgr.NiotDecrypt(Session("mpfl_un"), u_key)
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