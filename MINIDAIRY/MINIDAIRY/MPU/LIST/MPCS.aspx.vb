Imports MySql.Data.MySqlClient

Public Class MPCS
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
        bgrgv.fill_mpu(conn, gvMpcs, "list_mpcs", mpu_id + "," + dd_dist.SelectedValue.ToString)


    End Sub
    Private Sub dd_dist_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dd_dist.SelectedIndexChanged
        Try
            bgrgv.fill_mpu(conn, gvMpcs, "list_mpcs", mpu_id + "," + dd_dist.SelectedValue.ToString)
        Catch ex As Exception
            errmsg.InnerHtml = "Error 103 : " + ex.Message
            errmsg.Visible = True
        End Try

    End Sub
    Private Sub ClearForm()
        hfMpcsId.Value = "0"
        tbCode.Text = String.Empty
        tbFullEn.Text = String.Empty
        tbFullTa.Text = String.Empty
        tbShortEn.Text = String.Empty
        tbShortTa.Text = String.Empty
    End Sub
    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Try
            cmnd.CommandText = "sp_mpcs"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@p_key", bgr.enc_key("DB_MPU"))
            Select Case btnSave.Text
                Case "Add New MPCS"
                    cmnd.Parameters.AddWithValue("@p_mpcs_id", 0)
                Case "Update MPCS"
                    cmnd.Parameters.AddWithValue("@p_mpcs_id", Convert.ToInt32(hfMpcsId.Value.ToString))
            End Select
            cmnd.Parameters.AddWithValue("@p_dist_id", Convert.ToInt32(dd_dist.SelectedValue.ToString))
            cmnd.Parameters.AddWithValue("@p_mpu_id", Convert.ToInt32(mpu_id))
            cmnd.Parameters.AddWithValue("@p_mpcs_code", tbCode.Text.ToUpper)
            cmnd.Parameters.AddWithValue("@p_mpcs_name_full_en", tbFullEn.Text.ToUpper)
            cmnd.Parameters.AddWithValue("@p_mpcs_name_full_ta", tbFullTa.Text.ToUpper)
            cmnd.Parameters.AddWithValue("@p_mpcs_name_short_en", tbShortEn.Text)
            cmnd.Parameters.AddWithValue("@p_mpcs_name_short_ta", tbShortTa.Text)
            conn.Open()
            Dim result As String = cmnd.ExecuteScalar()
            conn.Close()
            If result = "SUCCESS" Then
                bgrgv.fill_mpu(conn, gvMpcs, "list_mpcs", mpu_id + "," + dd_dist.SelectedValue.ToString)
                errmsg.Visible = False
            Else
                errmsg.Visible = True
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 104 : " + ex.Message
        End Try
    End Sub
    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        ltl_modalhead.Text = "Add New Milk Producers Cooperative Society"
        btnSave.Text = "Add New MPCS"
        ClearForm()
        Dim script As String = "var myModal = new bootstrap.Modal(document.getElementById('mpcsModal')); myModal.show();"
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", script, True)

    End Sub
    Private Sub gvMpcs_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvMpcs.RowCommand
        Try
            Dim cmdstr As String = e.CommandName.ToString
            Dim rid As Integer = Convert.ToInt16(e.CommandArgument.ToString)
            Select Case cmdstr
                Case "EditRow"
                    hfMpcsId.Value = gvMpcs.DataKeys(rid).Values("mpcs_id").ToString()
                    tbCode.Text = gvMpcs.Rows(rid).Cells(1).Text
                    tbFullEn.Text = gvMpcs.Rows(rid).Cells(2).Text
                    tbShortEn.Text = gvMpcs.Rows(rid).Cells(3).Text
                    tbFullTa.Text = gvMpcs.Rows(rid).Cells(4).Text
                    tbShortTa.Text = gvMpcs.Rows(rid).Cells(5).Text
                    ltl_modalhead.Text = "Update Milk Producers Cooperative Society Details"
                    btnSave.Text = "Update MPCS"
                    Dim script As String = "var myModal = new bootstrap.Modal(document.getElementById('mpcsModal')); myModal.show();"
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", script, True)
                Case "DeleteRow"
            End Select
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 105 : " + ex.Message
        End Try
    End Sub

End Class