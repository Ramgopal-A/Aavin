Public Class ZMASTERTA
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub btn_lang_Click(sender As Object, e As EventArgs) Handles btn_lang.Click
        Response.Redirect("~/")
    End Sub
End Class