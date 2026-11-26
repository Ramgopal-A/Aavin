Imports System.IO
Imports MySql.Data.MySqlClient
Imports Newtonsoft.Json

Public Class LISTBANKPEND
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
            bgrgv.fill_mpfl(conn, gvMpu, "list_bank_pend", "")
            MultiView1.ActiveViewIndex = 0
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.InnerHtml = "Error 100 : " + ex.Message
            errmsg.Visible = True
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub gvMpu_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvMpu.RowCommand
        Try
            Dim rid As Integer = Convert.ToInt32(e.CommandArgument.ToString)
            Dim bankid, distid As String
            bankid = gvMpu.DataKeys(rid).Values("bank_id").ToString()
            distid = gvMpu.DataKeys(rid).Values("loan_dist_id").ToString()
            bgrgv.fill_mpfl(conn, gvBen, "list_bank_pend_ben", distid + "," + bankid + "," + bgr.enc_key("DB_BENEFICIARY"))
            MultiView1.ActiveViewIndex = 1
            errmsg.Visible = False
        Catch ex As Exception
            errmsg.Visible = True
            errmsg.InnerHtml = "Error 101 : " + ex.Message
        End Try
    End Sub
    Private Sub btn_back1_Click(sender As Object, e As EventArgs) Handles btn_back1.Click
        MultiView1.ActiveViewIndex = 0
    End Sub
    Private Sub btn_back2_Click(sender As Object, e As EventArgs) Handles btn_back2.Click
        MultiView1.ActiveViewIndex = 1
    End Sub
    Private Sub gvBen_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBen.RowCommand
        Try
            Dim rid As Integer = Convert.ToInt32(e.CommandArgument.ToString)
            hf_ben_id.Value = gvBen.DataKeys(rid).Values("ben_id").ToString()
            bgrlv.fill_mpfl(conn, lv_loan_app, "ben_details", hf_ben_id.Value + "," + bgr.enc_key("DB_BENEFICIARY"))
            MultiView1.ActiveViewIndex = 2
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