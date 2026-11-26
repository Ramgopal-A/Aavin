Imports MySql.Data.MySqlClient

Public Class BANK
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
            bgrdd.fill_mpfl(conn, dd_dist, "district", "", "")
            errmsg.Visible = False

        Catch ex As Exception
            errmsg.InnerHtml = "Error 100 : " + ex.Message
            errmsg.Visible = True
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        bgrgv.fill_mpfl(conn, gvMpcs, "bank", dd_dist.SelectedValue.ToString + "," + dd_bank_type.SelectedValue.ToString + "," + bgr.enc_key("DB_BANK"))
    End Sub

    Private Sub dd_dist_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dd_dist.SelectedIndexChanged
        Try
            bgrgv.fill_mpfl(conn, gvMpcs, "bank", dd_dist.SelectedValue.ToString + "," + dd_bank_type.SelectedValue.ToString + "," + bgr.enc_key("DB_BANK"))
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.InnerHtml = "Error 100 : " + ex.Message
            errmsg.Visible = True
        End Try
    End Sub

    Private Sub dd_bank_type_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dd_bank_type.SelectedIndexChanged
        Try
            bgrgv.fill_mpfl(conn, gvMpcs, "bank", dd_dist.SelectedValue.ToString + "," + dd_bank_type.SelectedValue.ToString + "," + bgr.enc_key("DB_BANK"))
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.InnerHtml = "Error 100 : " + ex.Message
            errmsg.Visible = True
        End Try
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
            cmnd.CommandText = "sp_bank"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@p_key", bgr.enc_key("DB_BANK"))
            Select Case btnSave.Text
                Case "Add New BANK"
                    cmnd.Parameters.AddWithValue("@p_bank_id", 0)
                Case "Update BANK"
                    cmnd.Parameters.AddWithValue("@p_bank_id", Convert.ToInt16(hfMpcsId.Value))
            End Select

            cmnd.Parameters.AddWithValue("@p_dist_id", Convert.ToInt16(dd_dist.SelectedValue.ToString))
            cmnd.Parameters.AddWithValue("@p_bank_type", dd_bank_type.SelectedValue.ToString)
            cmnd.Parameters.AddWithValue("@p_bank_name_full_en", Clean(tbFullEn.Text).ToUpper)
            cmnd.Parameters.AddWithValue("@p_bank_name_full_ta", Clean(tbFullTa.Text))
            cmnd.Parameters.AddWithValue("@p_bank_name_short_en", Clean(tbShortEn.Text).ToUpper)
            cmnd.Parameters.AddWithValue("@p_bank_name_short_ta", Clean(tbShortTa.Text))
            conn.Open()
            Dim result As String = cmnd.ExecuteScalar()
            conn.Close()
            If result = "SUCCESS" Then
                bgrgv.fill_mpfl(conn, gvMpcs, "bank", dd_dist.SelectedValue.ToString + "," + dd_bank_type.SelectedValue.ToString + "," + bgr.enc_key("DB_BANK"))
                errmsg.Visible = False
            Else
                errmsg.Visible = True
            End If
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 104 : " + ex.Message
        End Try
    End Sub

    Private Function Clean(txt As String) As String
        If String.IsNullOrWhiteSpace(txt) Then Return ""
        Return txt.Trim().TrimEnd(","c)
    End Function
    Private Sub btnNew_Click(sender As Object, e As EventArgs) Handles btnNew.Click
        ltl_modalhead.Text = "Add New Bank"
        btnSave.Text = "Add New BANK"
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
                    hfMpcsId.Value = gvMpcs.DataKeys(rid)("bank_id").ToString()
                    tbFullEn.Text = gvMpcs.Rows(rid).Cells(1).Text.Replace("&nbsp;", "").Trim()
                    tbShortEn.Text = gvMpcs.Rows(rid).Cells(2).Text.Replace("&nbsp;", "").Trim()
                    tbFullTa.Text = gvMpcs.Rows(rid).Cells(3).Text.Replace("&nbsp;", "").Trim()
                    tbShortTa.Text = gvMpcs.Rows(rid).Cells(4).Text.Replace("&nbsp;", "").Trim()
                    ltl_modalhead.Text = "Update Bank Details"
                    btnSave.Text = "Update BANK"
                    Dim script As String = "var myModal = new bootstrap.Modal(document.getElementById('mpcsModal')); myModal.show();"
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", script, True)
                Case "DeleteRow"
            End Select
            errmsg.Visible = True
            errmsg.InnerHtml = hfMpcsId.Value
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 105 : " + ex.Message
        End Try
    End Sub


End Class