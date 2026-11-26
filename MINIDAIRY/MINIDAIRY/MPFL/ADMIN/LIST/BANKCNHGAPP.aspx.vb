Imports MySql.Data.MySqlClient
Imports Newtonsoft.Json
Imports System.IO

Public Class BANKCNHGAPP
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrgv As New bgrgv
    Dim bgrdb As New bgrdb
    Dim bgrlv As New bgrlv
    Dim bgrenc As New bgrenc
    Dim masterPage As New ZMASTERMPU
    Dim mpfl_id As String
    Private Sub WebForm1_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            mpfl_id = bgr.NiotDecrypt(Session("mpfl_id"), bgr.NiotDecrypt(Session("u_key"), bgr.enc_key("SESSION_VAL")))
            conn.ConnectionString = bgrdb.conn_str("mini_diary")
            cmnd.Connection = conn
            cmnd.CommandType = CommandType.StoredProcedure
            bgrlv.fill_mpfl(conn, lvRequests, "list_bank_chng", bgr.enc_key("DB_BENEFICIARY"))
            mvMain.ActiveViewIndex = 0
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.InnerHtml = "Error 100 : " + ex.Message
            errmsg.Visible = True
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub lvRequests_ItemCommand(ByVal sender As Object, ByVal e As ListViewCommandEventArgs) Handles lvRequests.ItemCommand
        Try
            Dim benId As Integer = Convert.ToInt32(CType(e.Item.FindControl("hfBenId"), HiddenField).Value.ToString)
            Select Case e.CommandName.ToUpperInvariant()
                Case "VIEW"
                    hf_ben_id.Value = benId.ToString
                    bgrlv.fill_mpfl(conn, lv_loan_app, "ben_details", hf_ben_id.Value + "," + bgr.enc_key("DB_BENEFICIARY"))
                    mvMain.ActiveViewIndex = 1
                Case "APPROVE"
                    ExecuteStatusChange(benId, "Approved")
                Case "REJECT"
                    ExecuteStatusChange(benId, "Rejected")
            End Select
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Err 101 : " + ex.Message
        End Try

    End Sub

    Private Sub ExecuteStatusChange(ByVal benId As Integer, ByVal status As String)
        Try
            Using cmd As New MySqlCommand("sp_mpfl_bank_change_status", conn)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("iben_id", benId)
                cmd.Parameters.AddWithValue("istat", status)
                conn.Open()
                cmd.ExecuteNonQuery()
                conn.Close()
                mvMain.ActiveViewIndex = 0
                bgrlv.fill_mpfl(conn, lvRequests, "list_bank_chng", bgr.enc_key("DB_BENEFICIARY"))
            End Using
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Err 102 : " + ex.Message
        End Try
    End Sub

    Private Sub btn_back1_Click(sender As Object, e As EventArgs) Handles btn_back1.Click
        mvMain.ActiveViewIndex = 0
    End Sub
    Private Sub lv_loan_app_ItemCommand(sender As Object, e As ListViewCommandEventArgs) Handles lv_loan_app.ItemCommand
        Dim doc As String = e.CommandArgument.ToString
        Select Case doc
            Case "aadhar"
                ltl_doc_type.Text = "Aadahar Card"
                img_doc.ImageUrl = doc_image(hf_ben_id.Value, "0")
            Case "pan"
                ltl_doc_type.Text = "PAN Card"
                img_doc.ImageUrl = doc_image(hf_ben_id.Value, "1")
            Case "sfc"
                ltl_doc_type.Text = "Smart Family Card"
                img_doc.ImageUrl = doc_image(hf_ben_id.Value, "2")
            Case "bank"
                ltl_doc_type.Text = "Bank Passbook First Page"
                img_doc.ImageUrl = doc_image(hf_ben_id.Value, "3")
            Case "chitta"
                ltl_doc_type.Text = "Chitta / Lease Document Page 1"
                img_doc.ImageUrl = doc_image(hf_ben_id.Value, "5")
            Case "adangal"
                ltl_doc_type.Text = "Adangal / Lease Document Page 2"
                img_doc.ImageUrl = doc_image(hf_ben_id.Value, "6")
            Case "society"
                ltl_doc_type.Text = "Society Authorization Letter"
                img_doc.ImageUrl = doc_image(hf_ben_id.Value, "7")
        End Select
        Dim script As String = "var myModal = new bootstrap.Modal(document.getElementById('uploadPopup')); myModal.show();"
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", script, True)
    End Sub
    Private Sub lv_loan_app_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lv_loan_app.ItemDataBound
        CType(e.Item.FindControl("img_photo"), Image).ImageUrl = doc_image(hf_ben_id.Value, "4")
        CType(e.Item.FindControl("img_qr"), Image).ImageUrl = bgr.generate_qrcode(bgr.NiotEncrypt(hf_ben_id.Value, bgr.enc_key("BENEFICIARY_FILE_NAME")), Server.MapPath("~/ASSETS/IMAGES/tab_logo.jpg"))
    End Sub
    Protected Function doc_image(ByVal bid As String, ByVal did As String) As String
        Dim fp = Server.MapPath("~/UPLOAD/DOC/" + bgrenc.file_name_encrypt(bid) + ".json")
        Dim sr As StreamReader = New StreamReader(fp)
        Dim jsondata As String = sr.ReadToEnd()
        sr.Close()
        Dim dt As DataTable = JsonConvert.DeserializeObject(Of DataTable)(jsondata)
        Dim base64Str As String = dt.Rows(Convert.ToInt32(did)).Item(1).ToString
        Return "data:image/jpeg;base64," & bgr.NiotDecrypt(base64Str, bgr.enc_key("BENEFICIARY_FILE_DATA"))
    End Function

End Class