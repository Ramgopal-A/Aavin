Public Class page_cropimage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub btnShow_Click(sender As Object, e As EventArgs)
        Dim base64 As String = ImageCropControl.CroppedImageBase64
        If Not String.IsNullOrEmpty(base64) Then
            imgCropped.ImageUrl = base64
        End If
    End Sub

End Class