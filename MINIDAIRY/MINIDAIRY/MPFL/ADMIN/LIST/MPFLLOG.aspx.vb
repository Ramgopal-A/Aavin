Imports MySql.Data.MySqlClient

Public Class MPFLLOG
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrgv As New bgrgv
    Dim bgrdb As New bgrdb
    Dim bgrdd As New bgrdd
    Dim bgrsms As New bgrsms
    Dim masterPage As New ZMASTERMPU
    Dim mpfl_id As String
    Private Sub WebForm1_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            mpfl_id = bgr.NiotDecrypt(Session("mpfl_id"), bgr.NiotDecrypt(Session("u_key"), bgr.enc_key("SESSION_VAL")))
            conn.ConnectionString = bgrdb.conn_str("mini_diary")
            cmnd.Connection = conn
            cmnd.CommandType = CommandType.StoredProcedure
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.InnerHtml = "Error 100 : " + ex.Message
            errmsg.Visible = True
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        bgrgv.fill_mpfl(conn, gvMpcs, "mpfl", bgr.enc_key("DB_MPFL"))

    End Sub

    Private Sub ClearForm()
        hfMpcsId.Value = "0"
        tbFullEn.Text = String.Empty
        tbTelID.Text = String.Empty
    End Sub
    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Try
            cmnd.CommandText = "sp_mpfl"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_MPFL"))
            If btnSave.Text = "Add Telegram ID" Then
                cmnd.Parameters.AddWithValue("@impfl_id", 0)
                cmnd.Parameters.AddWithValue("@impfl_name", tbFullEn.Text)
            ElseIf btnSave.Text = "Update Telegram ID" Then
                cmnd.Parameters.AddWithValue("@impfl_id", Convert.ToInt32(hfMpcsId.Value.ToString))
                cmnd.Parameters.AddWithValue("@impfl_name", "")
            End If
            cmnd.Parameters.AddWithValue("@impfl_uid", tbTelID.Text)
            conn.Open()
            Dim result As String = cmnd.ExecuteScalar()
            conn.Close()
            If result = "SUCCESS" Then
                bgrgv.fill_mpfl(conn, gvMpcs, "mpfl", bgr.enc_key("DB_MPFL"))
                errmsg.Visible = False
            Else
                errmsg.Visible = True
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 104 : " + ex.Message
        End Try
    End Sub

    Private Sub gvMpcs_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvMpcs.RowCommand
        Try
            Dim cmdstr As String = e.CommandName.ToString
            Dim rid As Integer = Convert.ToInt16(e.CommandArgument.ToString)

            hfMpcsId.Value = gvMpcs.DataKeys(rid).Values("mpfl_id").ToString()
            tbFullEn.Text = gvMpcs.Rows(rid).Cells(1).Text.Replace("&nbsp;", "").Trim()
            tbTelID.Text = gvMpcs.Rows(rid).Cells(3).Text.Replace("&nbsp;", "").Trim()
            ltl_modalhead.Text = "Update MPFL Officer Telegram ID"
            btnSave.Text = "Update Telegram ID"
            Dim script As String = "var myModal = new bootstrap.Modal(document.getElementById('mpcsModal')); myModal.show();"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", script, True)

            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 105 : " + ex.Message
        End Try
    End Sub




    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        ltl_modalhead.Text = "Update Officer Login Telegram ID"
        btnSave.Text = "Add Telegram ID"
        Dim script As String = "var myModal = new bootstrap.Modal(document.getElementById('mpcsModal')); myModal.show();"
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", script, True)
    End Sub
End Class