Imports MySql.Data.MySqlClient
Public Class DIST
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
        bgrgv.fill_mpfl(conn, gvDist, "district", "")
    End Sub

    Private Sub ClearForm()
        hfMpcsId.Value = "0"
        tbFullEn.Text = String.Empty
    End Sub
    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Try
            cmnd.CommandText = "sp_dist"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@p_key", bgr.enc_key("DB_MPU"))
            Select Case btnSave.Text
                Case "Add New District"
                    cmnd.Parameters.AddWithValue("@p_mpu_id", 0)
                Case "Update District"
                    cmnd.Parameters.AddWithValue("@p_mpu_id", Convert.ToInt32(hfMpcsId.Value.ToString))
            End Select
            cmnd.Parameters.AddWithValue("@p_mpu_name_full_en", tbFullEn.Text.ToUpper)
            cmnd.Parameters.AddWithValue("@p_mpu_name_full_ta", tbFullTa.Text.ToUpper)
            conn.Open()
            Dim result As String = cmnd.ExecuteScalar()
            conn.Close()
            If result = "SUCCESS" Then
                bgrgv.fill_mpfl(conn, gvDist, "district", "")
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
        ltl_modalhead.Text = "Add New District"
        btnSave.Text = "Add New District"
        ClearForm()
        Dim script As String = "var myModal = new bootstrap.Modal(document.getElementById('mpcsModal')); myModal.show();"
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", script, True)

    End Sub
    Private Sub gvMpcs_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvDist.RowCommand
        Try
            Dim cmdstr As String = e.CommandName.ToString
            Dim rid As Integer = Convert.ToInt16(e.CommandArgument.ToString)
            Select Case cmdstr
                Case "EditRow"
                    hfMpcsId.Value = gvDist.DataKeys(rid).Values("dist_id").ToString()
                    tbFullEn.Text = gvDist.Rows(rid).Cells(1).Text.Replace("&nbsp;", "").Trim()
                    tbFullTa.Text = gvDist.Rows(rid).Cells(2).Text.Replace("&nbsp;", "").Trim()
                    ltl_modalhead.Text = "Update District Details"
                    btnSave.Text = "Update District"
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