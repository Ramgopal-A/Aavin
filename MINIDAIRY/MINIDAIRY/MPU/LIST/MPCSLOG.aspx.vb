Imports MySql.Data.MySqlClient

Public Class MPCSLOG
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrgv As New bgrgv
    Dim bgrdb As New bgrdb
    Dim bgrdd As New bgrdd
    Dim bgrsms As New bgrsms
    Dim masterPage As New ZMASTERMPU
    Dim mpu_id As String
    Private Sub WebForm1_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            mpu_id = bgr.NiotDecrypt(Session("mpu_id"), bgr.NiotDecrypt(Session("u_key"), bgr.enc_key("SESSION_VAL")))
            conn.ConnectionString = bgrdb.conn_str("mini_diary")
            cmnd.Connection = conn
            cmnd.CommandType = CommandType.StoredProcedure
            bgrdd.fill_mpu(conn, dd_dist, "district", mpu_id, "")
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.InnerHtml = "Error 100 : " + ex.Message
            errmsg.Visible = True
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        bgrgv.fill_mpu(conn, gvMpcs, "list_mpcs", mpu_id + "," + dd_dist.SelectedValue.ToString + "," + bgr.enc_key("DB_MPCS"))


    End Sub
    Private Sub dd_dist_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dd_dist.SelectedIndexChanged
        Try
            bgrgv.fill_mpu(conn, gvMpcs, "list_mpcs", mpu_id + "," + dd_dist.SelectedValue.ToString + "," + bgr.enc_key("DB_MPCS"))
        Catch ex As Exception
            errmsg.InnerHtml = "Error 103 : " + ex.Message
            errmsg.Visible = True
        End Try

    End Sub
    Private Sub ClearForm()
        hfMpcsId.Value = "0"
        tbCode.Text = String.Empty
        tbFullEn.Text = String.Empty
    End Sub
    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Try
            cmnd.CommandText = "sp_log_update"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@icmd", "MPCS")
            cmnd.Parameters.AddWithValue("@ikey", bgr.enc_key("DB_MPCS"))
            cmnd.Parameters.AddWithValue("@iid", Convert.ToInt32(hfMpcsId.Value.ToString))
            cmnd.Parameters.AddWithValue("@iuid", tbTelID.Text)
            conn.Open()
            Dim result As String = cmnd.ExecuteScalar()
            conn.Close()
            If result = "SUCCESS" Then
                bgrgv.fill_mpu(conn, gvMpcs, "list_mpcs", mpu_id + "," + dd_dist.SelectedValue.ToString + "," + bgr.enc_key("DB_MPCS"))
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

            hfMpcsId.Value = gvMpcs.DataKeys(rid).Values("mpcs_id").ToString()
                    tbCode.Text = gvMpcs.Rows(rid).Cells(1).Text
                    tbFullEn.Text = gvMpcs.Rows(rid).Cells(2).Text
                    tbUname.Text = gvMpcs.Rows(rid).Cells(3).Text
                    tbTelID.Text = gvMpcs.Rows(rid).Cells(4).Text
            ltl_modalhead.Text = "Update MPCS Login Telegram ID"
            btnSave.Text = "Update Telegram ID"
            Dim script As String = "var myModal = new bootstrap.Modal(document.getElementById('mpcsModal')); myModal.show();"
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", script, True)

            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 105 : " + ex.Message
        End Try
    End Sub

End Class