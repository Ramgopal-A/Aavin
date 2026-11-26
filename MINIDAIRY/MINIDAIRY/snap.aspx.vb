Public Class snap
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsMobileOrTablet(Request.UserAgent) Then
            ' Server-side block (for desktops)
            pnlMain.Visible = False
            Response.Clear()
            Response.Write("<!doctype html><html><head><meta name='viewport' content='width=device-width, initial-scale=1' />" &
                              "<title>Mobile Only</title>" &
                              "<style>body{font-family:system-ui,Segoe UI,Arial;padding:24px;background:#f6f8fb}" &
                              ".box{max-width:680px;margin:auto;background:#fff3cd;border:1px solid #ffe69c;border-radius:16px;padding:18px}" &
                              ".t{font-weight:700;font-size:18px;margin-bottom:6px}.m{color:#444}</style></head>" &
                              "<body><div class='box'><div class='t'>This page works only on Mobile / Tablet</div>" &
                              "<div class='m'>Open this page on a phone or tablet to access camera and GPS.</div></div></body></html>")
            Response.End()
        End If
    End Sub

    Private Function IsMobileOrTablet(ByVal userAgent As String) As Boolean
        If String.IsNullOrEmpty(userAgent) Then Return False

        Dim ua As String = userAgent.ToLowerInvariant()

        ' Common mobile/tablet checks
        If ua.Contains("mobi") Then Return True
        If ua.Contains("android") Then Return True
        If ua.Contains("iphone") OrElse ua.Contains("ipod") Then Return True
        If ua.Contains("ipad") Then Return True
        If ua.Contains("windows phone") Then Return True

        ' Some tablets don't say "mobi"
        If ua.Contains("tablet") Then Return True

        Return False
    End Function

End Class