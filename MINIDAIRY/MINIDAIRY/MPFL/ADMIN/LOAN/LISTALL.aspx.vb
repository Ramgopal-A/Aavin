Imports MySql.Data.MySqlClient
Imports Newtonsoft.Json
Imports System.IO

Public Class LISTALL
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
            bgrgv.fill_mpfl(conn, gvMpu, "list_mpu_all", "")
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
            Dim mpuid, distid As String
            mpuid = gvMpu.DataKeys(rid).Values("mpu_id").ToString()
            distid = gvMpu.DataKeys(rid).Values("loan_dist_id").ToString()
            bgrgv.fill_mpfl(conn, gvBen, "list_mpu_all_ben", distid + "," + mpuid + "," + bgr.enc_key("DB_BENEFICIARY"))
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

    Protected Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        ' Convert ButtonFields to plain text so Excel shows numbers instead of buttons
        For Each row As GridViewRow In gvMpu.Rows
            If row.RowType = DataControlRowType.DataRow Then
                For i As Integer = 0 To row.Cells.Count - 1
                    If row.Cells(i).Controls.Count > 0 Then
                        Dim btn As IButtonControl = TryCast(row.Cells(i).Controls(0), IButtonControl)
                        If btn IsNot Nothing Then
                            row.Cells(i).Text = btn.Text
                        End If
                    End If
                    ' Prevent Excel auto-formatting issues
                    row.Cells(i).Attributes.Add("class", "text")
                Next
            End If
        Next

        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition",
                           "attachment;filename=MPU_Status_" & DateTime.Now.ToString("yyyyMMddHHmmss") & ".xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        gvMpu.GridLines = GridLines.Both
        gvMpu.HeaderStyle.BackColor = Drawing.Color.LightGray
        gvMpu.RenderControl(hw)
        Dim style As String = "<style> .text { mso-number-format:\@; } </style>"
        Response.Write(style)
        Response.Output.Write(sw.ToString())
        Response.Flush()
        Response.End()
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Required override to allow rendering of controls to an HttpResponse
        ' Do not remove; required to avoid runtime error:
        ' "Control 'gvMpu' of type 'GridView' must be placed inside a form tag with runat=server."
    End Sub

End Class