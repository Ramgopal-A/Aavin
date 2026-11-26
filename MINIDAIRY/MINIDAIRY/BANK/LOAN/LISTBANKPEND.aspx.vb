Imports MySql.Data.MySqlClient
Imports Newtonsoft.Json
Imports System.IO

Public Class LISTBANKPEND3
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrgv As New bgrgv
    Dim bgrdb As New bgrdb
    Dim bgrlv As New bgrlv
    Dim bgrdd As New bgrdd
    Dim bgrenc As New bgrenc
    Dim masterPage As New ZMASTERMPU
    Dim bank_id As String
    Private Sub WebForm1_Init(sender As Object, e As EventArgs) Handles Me.Init
        Try
            bank_id = bgr.NiotDecrypt(Session("bank_id"), bgr.NiotDecrypt(Session("u_key"), bgr.enc_key("SESSION_VAL")))
            conn.ConnectionString = bgrdb.conn_str("mini_diary")
            cmnd.Connection = conn
            cmnd.CommandType = CommandType.StoredProcedure
            bgrgv.fill_bank(conn, gvBen, "list_bank_pend_ben", bank_id + "," + bgr.enc_key("DB_BENEFICIARY"))
            MultiView1.ActiveViewIndex = 0
            pnl_jrcs.Visible = False
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.InnerHtml = "Error 100 : " + ex.Message
            errmsg.Visible = True
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Private Sub btn_back1_Click(sender As Object, e As EventArgs) Handles btn_back1.Click
        MultiView1.ActiveViewIndex = 0
    End Sub
    Private Sub gvBen_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBen.RowCommand
        Try
            Dim rid As Integer = Convert.ToInt32(e.CommandArgument.ToString)
            hf_ben_id.Value = gvBen.DataKeys(rid).Values("ben_id").ToString()
            bgrlv.fill_bank(conn, lv_loan_app, "ben_details", hf_ben_id.Value + "," + bgr.enc_key("DB_BENEFICIARY"))
            MultiView1.ActiveViewIndex = 1
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 101 : " + ex.Message
        End Try
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
                ltl_doc_type.Text = "Chitta"
                img_doc.ImageUrl = doc_image(hf_ben_id.Value, "5")
            Case "adangal"
                ltl_doc_type.Text = "Adangal"
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
        tb_bank_name.Text = CType(e.Item.FindControl("lbl_bank_name"), Label).Text
        tb_bank_branch.Text = CType(e.Item.FindControl("lbl_brnch_name"), Label).Text
        tb_loan_accno.Text = CType(e.Item.FindControl("lbl_acc_no"), Label).Text
        tb_bank_ifsc.Text = CType(e.Item.FindControl("lbl_ifsc"), Label).Text
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
    Private Sub dd_status_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dd_status.SelectedIndexChanged
        If dd_status.SelectedValue.ToString = "Loan is Sanctioned by Bank" Then
            pnl_jrcs.Visible = True
        Else
            pnl_jrcs.Visible = False
        End If
    End Sub

    Private Sub btn_submit_Click(sender As Object, e As EventArgs) Handles btn_submit.Click
        Try
            cmnd.CommandText = "sp_bank_loanprocess"
            cmnd.CommandType = CommandType.StoredProcedure
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@iben_id", Convert.ToInt32(hf_ben_id.Value))
            cmnd.Parameters.AddWithValue("@ibank_status_en", dd_status.SelectedValue.ToString())
            cmnd.Parameters.AddWithValue("@ibank_remarks", tb_remarks.Text.Trim())
            cmnd.Parameters.AddWithValue("@ibank_utr", tb_utr.Text.Trim())
            If dd_status.SelectedValue = "Loan is Sanctioned by Bank" Then
                Dim sanc_dt As Date = Date.ParseExact(tb_sanc_dt.Text, "yyyy-MM-dd", Nothing)
                cmnd.Parameters.AddWithValue("@ibank_sanc_dt", sanc_dt)
                cmnd.Parameters.AddWithValue("@ibank_sanc_amt", Convert.ToInt32(tb_sanc_amt.Text))
                cmnd.Parameters.AddWithValue("@ibank_emi", Convert.ToInt32(tb_emi.Text))
                cmnd.Parameters.AddWithValue("@ibank_int", Convert.ToDouble(tb_int_rate.Text))
                cmnd.Parameters.AddWithValue("@ibank_period", Convert.ToInt32(tb_period.Text))
                cmnd.Parameters.AddWithValue("@ibank_loan_accno", tb_loan_accno.Text.Trim())
                cmnd.Parameters.AddWithValue("@ibank_loan_bank_name", tb_bank_name.Text.Trim())
                cmnd.Parameters.AddWithValue("@ibank_loan_bank_branch", tb_bank_branch.Text.Trim())
                cmnd.Parameters.AddWithValue("@ibank_loan_bank_ifsc", tb_bank_ifsc.Text.Trim())
            Else
                cmnd.Parameters.AddWithValue("@ibank_sanc_dt", DBNull.Value)
                cmnd.Parameters.AddWithValue("@ibank_sanc_amt", 0)
                cmnd.Parameters.AddWithValue("@ibank_emi", 0)
                cmnd.Parameters.AddWithValue("@ibank_int", 0)
                cmnd.Parameters.AddWithValue("@ibank_period", 0)
                cmnd.Parameters.AddWithValue("@ibank_loan_accno", "NA")
                cmnd.Parameters.AddWithValue("@ibank_loan_bank_name", "NA")
                cmnd.Parameters.AddWithValue("@ibank_loan_bank_branch", "NA")
                cmnd.Parameters.AddWithValue("@ibank_loan_bank_ifsc", "NA")
            End If
            conn.Open()
            cmnd.ExecuteNonQuery()
            conn.Close()
            bgrgv.fill_bank(conn, gvBen, "list_bank_pend_ben", bank_id + "," + bgr.enc_key("DB_BENEFICIARY"))
            MultiView1.ActiveViewIndex = 0
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "ben_fill() : " + ex.Message + tb_sanc_dt.Text
        End Try
    End Sub

End Class