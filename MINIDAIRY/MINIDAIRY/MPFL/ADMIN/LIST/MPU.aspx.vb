Imports MySql.Data.MySqlClient

Public Class MPU
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
        bgrgv.fill_mpfl(conn, gvMpcs, "mpu", bgr.enc_key("DB_MPU"))
    End Sub

    Private Sub ClearForm()
        hfMpcsId.Value = "0"
        tbFullEn.Text = String.Empty
        tbFullTa.Text = String.Empty
        tbShortEn.Text = String.Empty
        tbShortTa.Text = String.Empty
    End Sub
    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Try
            cmnd.CommandText = "sp_mpu"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@p_key", bgr.enc_key("DB_MPU"))
            Select Case btnSave.Text
                Case "Add New MPU"
                    cmnd.Parameters.AddWithValue("@p_mpu_id", 0)
                Case "Update MPU"
                    cmnd.Parameters.AddWithValue("@p_mpu_id", Convert.ToInt32(hfMpcsId.Value.ToString))
            End Select
            cmnd.Parameters.AddWithValue("@p_mpu_name_full_en", tbFullEn.Text.ToUpper)
            cmnd.Parameters.AddWithValue("@p_mpu_name_full_ta", tbFullTa.Text.ToUpper)
            cmnd.Parameters.AddWithValue("@p_mpu_name_short_en", tbShortEn.Text)
            cmnd.Parameters.AddWithValue("@p_mpu_name_short_ta", tbShortTa.Text)
            conn.Open()
            Dim result As String = cmnd.ExecuteScalar()
            conn.Close()
            If result = "SUCCESS" Then
                bgrgv.fill_mpfl(conn, gvMpcs, "mpu", bgr.enc_key("DB_MPU"))
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
        ltl_modalhead.Text = "Add New Milk Producers Union"
        btnSave.Text = "Add New MPU"
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
                    hfMpcsId.Value = gvMpcs.DataKeys(rid).Values("mpu_id").ToString()
                    tbFullEn.Text = gvMpcs.Rows(rid).Cells(1).Text.Replace("&nbsp;", "").Trim()
                    tbShortEn.Text = gvMpcs.Rows(rid).Cells(2).Text.Replace("&nbsp;", "").Trim()
                    tbFullTa.Text = gvMpcs.Rows(rid).Cells(3).Text.Replace("&nbsp;", "").Trim()
                    tbShortTa.Text = gvMpcs.Rows(rid).Cells(4).Text.Replace("&nbsp;", "").Trim()
                    ltl_modalhead.Text = "Update Milk Producers Union Details"
                    btnSave.Text = "Update MPU"
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