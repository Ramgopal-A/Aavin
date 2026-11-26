Imports System.Security.Cryptography

Public Class REGCOMP
    Inherits System.Web.UI.Page
    Dim bgr As New bgr
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If IsNothing(Session("otrpk")) Then
                Response.Redirect("~/ONLINE")
            Else
                Dim keystr As String = bgr.NiotDecrypt(Session("otrpk").ToString, bgr.enc_key("SESSION_VAL"))
                If DecryptValue(Session("otrpa").ToString, keystr) = "REGCOMP" Then
                    Me.Master.FindControl("btn_lang").Visible = False
                    lblUniqueId.Text = DecryptValue(Session("tabid").ToString, keystr)
                Else
                    Response.Redirect("~/ONLINE")
                End If
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub btn_click_Click(sender As Object, e As EventArgs) Handles btn_click.Click
        Try
            Response.Redirect("~/ONLINE")
        Catch ex As Exception

        End Try
    End Sub
    Private Function EncryptValue(ByVal plainText As String, ByVal key As String) As String
        Dim aes As New System.Security.Cryptography.AesCryptoServiceProvider()
        aes.KeySize = 128
        aes.BlockSize = 128
        aes.Mode = System.Security.Cryptography.CipherMode.CBC
        aes.Padding = System.Security.Cryptography.PaddingMode.PKCS7
        Dim keyBytes As Byte() = System.Text.Encoding.UTF8.GetBytes(key.Substring(0, 16))
        aes.Key = keyBytes
        aes.GenerateIV()
        Dim iv As Byte() = aes.IV
        Dim encryptor As System.Security.Cryptography.ICryptoTransform = aes.CreateEncryptor()
        Dim plainBytes As Byte() = System.Text.Encoding.UTF8.GetBytes(plainText)
        Dim encryptedBytes As Byte() = encryptor.TransformFinalBlock(plainBytes, 0, plainBytes.Length)
        Dim resultBytes As Byte() = iv.Concat(encryptedBytes).ToArray()
        Return Convert.ToBase64String(resultBytes)
    End Function
    Private Function DecryptValue(ByVal base64Encrypted As String, ByVal key As String) As String
        Dim fullCipher As Byte() = Convert.FromBase64String(base64Encrypted)
        Dim iv As Byte() = fullCipher.Take(16).ToArray()
        Dim cipher As Byte() = fullCipher.Skip(16).ToArray()

        Using aes As New AesCryptoServiceProvider()
            aes.KeySize = 128
            aes.BlockSize = 128
            aes.Key = Encoding.UTF8.GetBytes(key.Substring(0, 16))
            aes.IV = iv
            aes.Padding = PaddingMode.PKCS7
            aes.Mode = CipherMode.CBC

            Using decryptor As ICryptoTransform = aes.CreateDecryptor()
                Dim decryptedBytes As Byte() = decryptor.TransformFinalBlock(cipher, 0, cipher.Length)
                Return Encoding.UTF8.GetString(decryptedBytes)
            End Using
        End Using
    End Function

End Class