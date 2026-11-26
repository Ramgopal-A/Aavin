Imports System.Collections.Generic
Imports System.Web
Imports System.Web.Routing
Imports Microsoft.AspNet.FriendlyUrls
Imports System.Web.SessionState
Imports System.Net
Imports Microsoft.AspNet.FriendlyUrls.Resolvers
Imports System.IO

Public Class Global_asax
    Inherits System.Web.HttpApplication
    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ServicePointManager.SecurityProtocol = (SecurityProtocolType.Tls12) And Not (SecurityProtocolType.Tls And SecurityProtocolType.Tls11)
        RegisterRoutes(RouteTable.Routes)
        RouteTable.Routes.MapPageRoute(
    "SymbolWithQueryRoute",
    "symbol/{symbolType}/{*parameters}",
    "~/Default.aspx"
    )
    End Sub
    Private Shared Sub RegisterRoutes(routes As RouteCollection)
        Dim settings = New FriendlyUrlSettings()
        settings.AutoRedirectMode = RedirectMode.Permanent
        routes.EnableFriendlyUrls(settings, New WebMethodFriendlyUrlResolver())
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        If Request.IsSecureConnection Then
            Response.Cookies("ASP.NET_SessionId").Secure = True
        End If
    End Sub

    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)

        Response.Headers.Add("X-Frame-Options", "SAMEORIGIN")
        Response.Headers.Add("X-XSS-Protection", "1; mode=block")
        Response.Headers.Add("X-Content-Type-Options", "nosniff")
        Response.Headers.Add("Referrer-Policy", "no-referrer-when-downgrade")
        Response.Headers.Add("Strict-Transport-Security", "max-age=31536000; includeSubDomains")
        'Response.Headers.Add("Content-Security-Policy", "default-src 'self'; img-src 'self' data:; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline';")
        Response.Headers.Add("Permissions-Policy", "geolocation=(self), microphone=()")
    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires upon attempting to authenticate the use
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        'Dim ex As Exception = Server.GetLastError
        'Response.Redirect("~/ERRORPAGE.aspx?errmsg=" + ex.Message)
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session ends
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application ends
    End Sub

End Class



Public Class WebMethodFriendlyUrlResolver
    Inherits WebFormsFriendlyUrlResolver

    Public Overrides Function ConvertToFriendlyUrl(ByVal path As String) As String
        If HttpContext.Current.Request.PathInfo <> String.Empty Then
            Return path
        Else
            Return MyBase.ConvertToFriendlyUrl(path)
        End If
    End Function
End Class