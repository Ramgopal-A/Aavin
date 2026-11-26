Public Class ZMASTERBANK
    Inherits System.Web.UI.MasterPage
    Dim bgr As New bgr
    Public bank_id As String
    Private Sub ZMASTERMPU_Init(sender As Object, e As EventArgs) Handles Me.Init

        Try
            If Session("u_type") IsNot Nothing Then
                Dim u_key As String = bgr.NiotDecrypt(Session("u_key"), bgr.enc_key("SESSION_VAL"))
                If Session("u_type") = "BANK" And bgr.NiotDecrypt(Session(bgr.NiotEncrypt("auth", u_key)), u_key) = "BANK" Then
                    lbl_name.Text = Session("bank_name")
                    lbl_uname.Text = bgr.NiotDecrypt(Session("bank_un"), u_key)
                    bank_id = bgr.NiotDecrypt(Session("bank_id"), u_key)
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