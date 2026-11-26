Imports MySql.Data.MySqlClient
Imports Newtonsoft.Json
Imports System.IO

Public Class APPLOAN
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrdb As New bgrdb
    Dim bgrlv As New bgrlv
    Dim bgrenc As New bgrenc
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub APPSTAT_Init(sender As Object, e As EventArgs) Handles Me.Init
        conn.ConnectionString = bgrdb.conn_str("mini_diary")
        cmnd.Connection = conn
        cmnd.CommandType = CommandType.StoredProcedure
        Dim benid As String = Session("app_id")

        bgrlv.fill_ben(conn, lv_loan_app, "ben_loan_application", benid, bgr.enc_key("DB_BENEFICIARY"))
        errmsg.Visible = False
    End Sub

    Private Sub lv_loan_app_ItemCommand(sender As Object, e As ListViewCommandEventArgs) Handles lv_loan_app.ItemCommand
        Dim benid As String = Session("app_id")
        Dim doc As String = e.CommandArgument.ToString
        Select Case doc
            Case "aadhar"
                ltl_doc_type.Text = "Aadahar Card"
                img_doc.ImageUrl = doc_image(benid, "0")
            Case "pan"
                ltl_doc_type.Text = "PAN Card"
                img_doc.ImageUrl = doc_image(benid, "1")
            Case "sfc"
                ltl_doc_type.Text = "Smart Family Card"
                img_doc.ImageUrl = doc_image(benid, "2")
            Case "chitta"
                ltl_doc_type.Text = "Chitta"
                img_doc.ImageUrl = doc_image(benid, "5")
            Case "adangal"
                ltl_doc_type.Text = "Adangal"
                img_doc.ImageUrl = doc_image(benid, "6")
            Case "bank"
                ltl_doc_type.Text = "Bank Passbook First Page"
                img_doc.ImageUrl = doc_image(benid, "3")
            Case "society"
                ltl_doc_type.Text = "Society Membership Proof"
                img_doc.ImageUrl = doc_image(benid, "7")
        End Select
        Dim script As String = "var myModal = new bootstrap.Modal(document.getElementById('uploadPopup')); myModal.show();"
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", script, True)

    End Sub
    Private Sub lv_loan_app_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lv_loan_app.ItemDataBound
        Dim ben_id As String = Session(bgr.NiotEncrypt("ben_id", bgr.enc_key("SESSION_VAR")))
        Dim benid As String = bgr.NiotDecrypt(ben_id, bgr.enc_key("SESSION_VAL"))
        CType(e.Item.FindControl("img_photo"), Image).ImageUrl = doc_image(benid, "4")
        CType(e.Item.FindControl("img_qr"), Image).ImageUrl = bgr.generate_qrcode(bgr.NiotEncrypt(ben_id, bgr.enc_key("BENEFICIARY_FILE_NAME")), Server.MapPath("~/ASSETS/IMAGES/tab_logo.jpg"))
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