Imports System.IO
Imports MySql.Data.MySqlClient
Imports Newtonsoft.Json

Public Class LOANAPP1
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrgv As New bgrgv
    Dim bgrdb As New bgrdb
    Dim bgrlv As New bgrlv
    Dim bgrenc As New bgrenc

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim ben_id As String = Request.QueryString("bid")
        ben_id = bgrenc.qstr_decrypt(ben_id.Substring(6, 6))
        If ben_id <> "" Then
            conn.ConnectionString = bgrdb.conn_str("mini_diary")
            bgrlv.fill_mpfl(conn, lv_loan_app, "ben_details", ben_id + "," + bgr.enc_key("DB_BENEFICIARY"))
            doc_image(ben_id)
        End If

    End Sub

    Protected Sub doc_image(ByVal bid As String)
        Dim fp = Server.MapPath("~/UPLOAD/DOC/" + bgrenc.file_name_encrypt(bid) + ".json")
        Dim sr As StreamReader = New StreamReader(fp)
        Dim jsondata As String = sr.ReadToEnd()
        sr.Close()
        Dim dt As DataTable = JsonConvert.DeserializeObject(Of DataTable)(jsondata)
        img_adhar.ImageUrl = base64toimageurl(dt.Rows(Convert.ToInt32(0)).Item(1).ToString)
        img_pan.ImageUrl = base64toimageurl(dt.Rows(Convert.ToInt32(1)).Item(1).ToString)
        img_sfc.ImageUrl = base64toimageurl(dt.Rows(Convert.ToInt32(2)).Item(1).ToString)
        img_passbook.ImageUrl = base64toimageurl(dt.Rows(Convert.ToInt32(3)).Item(1).ToString)
        img_chitta.ImageUrl = base64toimageurl(dt.Rows(Convert.ToInt32(5)).Item(1).ToString)
        img_adangal.ImageUrl = base64toimageurl(dt.Rows(Convert.ToInt32(6)).Item(1).ToString)
        img_authltr.ImageUrl = base64toimageurl(dt.Rows(Convert.ToInt32(7)).Item(1).ToString)
        CType(lv_loan_app.Items(0).FindControl("img_photo"), Image).ImageUrl = base64toimageurl(dt.Rows(Convert.ToInt32(4)).Item(1).ToString)
        CType(lv_loan_app.Items(0).FindControl("img_qr"), Image).ImageUrl = bgr.generate_qrcode(bgr.NiotEncrypt(bid, bgr.enc_key("BENEFICIARY_FILE_NAME")), Server.MapPath("~/ASSETS/IMAGES/tab_logo.jpg"))
    End Sub
    Protected Function base64toimageurl(ByVal base64str As String) As String
        Return "data:image/jpeg;base64," & bgr.NiotDecrypt(base64str, bgr.enc_key("BENEFICIARY_FILE_DATA"))
    End Function

End Class