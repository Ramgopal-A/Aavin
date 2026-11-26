Imports MySql.Data.MySqlClient

Public Class _Default8
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrlv As New bgrlv
    Dim bgrdb As New bgrdb
    Dim bank_id As String
    Private Sub WebForm1_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            bank_id = bgr.NiotDecrypt(Session("bank_id"), bgr.NiotDecrypt(Session("u_key"), bgr.enc_key("SESSION_VAL")))
            conn.ConnectionString = bgrdb.conn_str("mini_diary")
            cmnd.Connection = conn
            cmnd.CommandType = CommandType.StoredProcedure
            bgrlv.fill_bank(conn, lv_dashboard, "dashboard", bank_id)
            bgrlv.fill_bank(conn, lv_dashboard_app, "dashboard_app_sanc", bank_id)
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.InnerHtml = "Error 100 : " + ex.Message
            errmsg.Visible = True
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

    End Sub

End Class