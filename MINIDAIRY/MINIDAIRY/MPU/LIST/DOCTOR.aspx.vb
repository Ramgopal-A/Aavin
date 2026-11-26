Imports System
Imports System.Configuration
Imports System.Data
Imports System.Linq
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient
Public Class DOCTOR
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrdb As New bgrdb
    Dim bgrgv As New bgrgv
    Private ReadOnly IKey As String = bgr.enc_key("DB_DOCTOR")
    Private Const VIEW_LIST As Integer = 0
    Private Const VIEW_FORM As Integer = 1
    Dim mpu_id As String
    Private Sub DOCTOR_Init(sender As Object, e As EventArgs) Handles Me.Init
        conn.ConnectionString = bgrdb.conn_str("mini_diary")
        cmnd.Connection = conn
        cmnd.CommandType = CommandType.StoredProcedure
        mpu_id = bgr.NiotDecrypt(Session("mpu_id"), bgr.NiotDecrypt(Session("u_key"), bgr.enc_key("SESSION_VAL")))
        bgrgv.fill_mpu(conn, gvDoctors, "list_doctor", IKey + "," + mpu_id)
        lblCount.Text = gvDoctors.Rows.Count()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If IsPostBack Then
            hfToastMsg.Value = ""
            hfToastType.Value = ""
        Else
            bgrgv.fill_mpu(conn, gvDoctors, "list_doctor", IKey + "," + mpu_id)
            lblCount.Text = gvDoctors.Rows.Count()
            ShowView(VIEW_LIST)
        End If
    End Sub

    Private Sub ShowView(view As Integer)
        mvDoctor.ActiveViewIndex = view
        Dim s0 As String = If(view = 0, "step active", If(view > 0, "step done", "step"))
        Dim s1 As String = If(view = 1, "step active", "step")
        Dim q As String = """"
        litBreadcrumb.Text =
            "<span class=" & q & s0 & q & ">List of Doctors</span>" &
            "<span class=" & q & "sep" & q & ">&#8250;</span>" &
            "<span class=" & q & s1 & q & ">Doctor Form</span>"
    End Sub






    Protected Sub lbAddNew_Click(sender As Object, e As EventArgs)
        ClearForm()
        litFormTitle.Text = "&#43; Add Doctor"
        pnlPassword.Visible = False
        pnlUsername.Visible = False
        ShowView(VIEW_FORM)
    End Sub

    Protected Sub lbBackToList_Click(sender As Object, e As EventArgs)
        bgrgv.fill_mpu(conn, gvDoctors, "list_doctor", IKey + "," + mpu_id)
        ShowView(VIEW_LIST)
    End Sub

    Protected Sub gvDoctors_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim idStr As String = e.CommandArgument.ToString()
        Dim docId As Integer
        If Not Integer.TryParse(idStr, docId) OrElse docId <= 0 Then Return

        If e.CommandName = "EditRow" Then
            Dim dt As DataTable = ExecSP("SELECTONE", 0, docId, "", "", "", "", "")
            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)
                hfDoctorId.Value = dr("doc_id").ToString()
                txtDoctorName.Text = dr("doc_name").ToString()
                txtDesignation.Text = dr("doc_desg").ToString()
                txtMobile.Text = dr("doc_mobno").ToString()
                txtTelegramId.Text = dr("doc_uid").ToString()
                txtUsername.Text = dr("doc_uname").ToString()
                txtPassword.Text = ""
                litFormTitle.Text = "&#9998; Edit Doctor"
                pnlPassword.Visible = True
                pnlUsername.Visible = True
            End If
            ShowView(VIEW_FORM)
        ElseIf e.CommandName = "DeleteRow" Then
            Try
                ExecSP("DELETE", 0, docId, "", "", "", "", "")
                ShowMessage("Deleted successfully", True)
                bgrgv.fill_mpu(conn, gvDoctors, "list_doctor", IKey + "," + mpu_id)
                ShowView(VIEW_LIST)
            Catch ex As Exception
                ShowMessage("Cannot delete: " & ex.Message, False)
                ShowView(VIEW_LIST)
            End Try
        End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs)


        If String.IsNullOrWhiteSpace(txtDoctorName.Text) Then
            ShowMessage("Doctor name is required.", False)
            ShowView(VIEW_FORM)
            Return
        End If
        If Not String.IsNullOrWhiteSpace(txtMobile.Text) Then
            If txtMobile.Text.Trim().Length <> 10 OrElse
               Not txtMobile.Text.Trim().All(AddressOf Char.IsDigit) Then
                ShowMessage("Mobile must be exactly 10 digits.", False)
                ShowView(VIEW_FORM)
                Return
            End If
        End If

        Try
            Dim isNew As Boolean = (hfDoctorId.Value = "0")
            Dim action As String = If(isNew, "INSERT", "UPDATE")
            Dim docId As Integer = If(isNew, 0, CInt(hfDoctorId.Value))

            Dim dt As DataTable = ExecSP(
                action, Convert.ToInt16(mpu_id), docId,
                txtDoctorName.Text.Trim(),
                txtDesignation.Text.Trim(),
                txtMobile.Text.Trim(),
                txtTelegramId.Text.Trim(),
                txtPassword.Text.Trim()
            )
            If isNew AndAlso dt IsNot Nothing AndAlso dt.Rows.Count > 0 Then
                Dim newUname As String = dt.Rows(0)("new_doc_uname").ToString()
                Dim newPass As String = dt.Rows(0)("new_doc_pass").ToString()
                hfToastMsg.Value = "Doctor added successfully!<br><small>Username: <b>" & newUname & "</b> &nbsp;|&nbsp; Password: <b>" & newPass & "</b></small>"
                hfToastType.Value = "success"
            Else
                ShowMessage("Doctor saved successfully!", True)
            End If
            ClearForm()
            bgrgv.fill_mpu(conn, gvDoctors, "list_doctor", IKey + "," + mpu_id)
            lblCount.Text = gvDoctors.Rows.Count()
            ShowView(VIEW_LIST)
        Catch ex As MySqlException When ex.Number = 1062
            ShowMessage("Username conflict. Contact admin.", False)
            ShowView(VIEW_FORM)
        Catch ex As Exception
            ShowMessage("Error: " & ex.Message, False)
            ShowView(VIEW_FORM)
        End Try
    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs)
        ClearForm()
    End Sub

    Private Function ExecSP(
            action As String,
            mpuId As Integer,
            docId As Integer,
            docName As String,
            docDesg As String,
            docMob As String,
            docUID As String,
            docPass As String) As DataTable

        Dim dt As New DataTable()
        cmnd.CommandText = "sp_mpu_doctor"

        cmnd.CommandType = CommandType.StoredProcedure
                cmnd.Parameters.AddWithValue("p_action", action)
                cmnd.Parameters.AddWithValue("p_mpu_id", mpuId)
                cmnd.Parameters.AddWithValue("p_doc_id", docId)
                cmnd.Parameters.AddWithValue("p_doc_name", If(docName, ""))
                cmnd.Parameters.AddWithValue("p_doc_desg", If(docDesg, ""))
                cmnd.Parameters.AddWithValue("p_doc_mobno", If(docMob, ""))
                cmnd.Parameters.AddWithValue("p_doc_uid", If(docUID, ""))
                cmnd.Parameters.AddWithValue("p_doc_pass", If(docPass, ""))
                cmnd.Parameters.AddWithValue("p_ikey", IKey)

                Dim pResult As New MySqlParameter("p_result", MySqlDbType.Int32)
                pResult.Direction = ParameterDirection.Output
        cmnd.Parameters.Add(pResult)

        Dim pMsg As New MySqlParameter("p_message", MySqlDbType.VarChar)
                pMsg.Size = 255
                pMsg.Direction = ParameterDirection.Output
        cmnd.Parameters.Add(pMsg)

        conn.Open()
        Using da As New MySqlDataAdapter(cmnd)
            da.Fill(dt)
        End Using

        Dim res As Integer = Convert.ToInt32(cmnd.Parameters("p_result").Value)
        If res <> 0 Then
            Throw New Exception(cmnd.Parameters("p_message").Value.ToString())
        End If

        Return dt
    End Function

    Private Sub ClearForm()
        hfDoctorId.Value = "0"
        txtDoctorName.Text = ""
        txtDesignation.Text = ""
        txtMobile.Text = ""
        txtTelegramId.Text = ""
        txtUsername.Text = ""
        txtPassword.Text = ""
        litFormTitle.Text = "&#43; Add Doctor"
        pnlPassword.Visible = False
        pnlUsername.Visible = False
        txtPassword.Attributes("autocomplete") = "new-password"
    End Sub

    Private Sub ShowMessage(msg As String, success As Boolean)
        hfToastMsg.Value = msg
        hfToastType.Value = If(success, "success", "error")
    End Sub


End Class