Imports MySql.Data.MySqlClient

Public Class LOANAPP
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrdb As New bgrdb
    Dim bgrdd As New bgrdd
    Dim bgrsms As New bgrsms

    Private Function GetBenId() As String
        Dim ben_id As String = Session(bgr.NiotEncrypt("ben_id", bgr.enc_key("SESSION_VAR"))).ToString()
        Return bgr.NiotDecrypt(ben_id, bgr.enc_key("SESSION_VAL"))
    End Function

    Private Function GetCurrentLoanStatus(ByVal benid As String) As String
        Try
            Using localConn As New MySqlConnection(bgrdb.conn_str("mini_diary"))
                Using localCmd As New MySqlCommand("sp_gridview_ben", localConn)
                    localCmd.CommandType = CommandType.StoredProcedure
                    localCmd.Parameters.AddWithValue("@icmd", "ben_loan_application")
                    localCmd.Parameters.AddWithValue("@id1", benid)
                    localCmd.Parameters.AddWithValue("@id2", bgr.enc_key("DB_BENEFICIARY"))

                    Dim adptr As New MySqlDataAdapter(localCmd)
                    Dim dt As New DataTable()
                    adptr.Fill(dt)

                    If dt.Rows.Count > 0 AndAlso dt.Columns.Contains("status_en") AndAlso Not IsDBNull(dt.Rows(0)("status_en")) Then
                        Return Convert.ToString(dt.Rows(0)("status_en")).Trim()
                    End If
                End Using
            End Using
        Catch
            ' Fall back to session status if needed
        End Try

        Try
            If Session("otr_stat") IsNot Nothing Then
                Return Convert.ToString(Session("otr_stat")).Trim()
            End If
        Catch
        End Try

        Return ""
    End Function

    Private Function IsLoanEditingAllowed(ByVal statusEn As String) As Boolean
        Dim st As String = Convert.ToString(statusEn).Trim()
        Select Case st
            Case "",
                 "One Time Registration Completed",
                 "File Uploaded",
                 "Scheme Selected",
                 "Loan Data Submitted"
                Return True
            Case Else
                Return False
        End Select
    End Function

    Private Sub ApplyLoanEditLock(ByVal allowed As Boolean)
        dd_thayumanavar.Enabled = allowed
        dd_district.Enabled = allowed
        dd_union.Enabled = allowed
        dd_society.Enabled = allowed
        tb_membership_no.Enabled = allowed
        dd_year.Enabled = allowed
        dd_cow_count.Enabled = allowed
        tb_milk_qty.Enabled = allowed
        dd_cowshed.Enabled = allowed
        dd_landspace.Enabled = allowed
        tb_cnt1.Enabled = allowed
        tb_cnt2.Enabled = allowed
        tb_cnt3.Enabled = allowed
        tb_proj_amt.Enabled = allowed
        tb_loan_amt_req.Enabled = allowed
        btn_submit.Enabled = allowed
        btn_submit.Visible = allowed

        If Not allowed Then
            errmsg.Visible = True
            errmsg.InnerHtml = "Editing is locked because your Signed Application Letter has already been submitted. (கையொப்பமிட்ட விண்ணப்பக் கடிதம் சமர்ப்பிக்கப்பட்டதால் கடன் விவரங்களை மாற்ற இயலாது.)"
        End If
    End Sub

    Private Sub LOANAPP_Init(sender As Object, e As EventArgs) Handles Me.Init
        conn.ConnectionString = bgrdb.conn_str("mini_diary")
        cmnd.Connection = conn
        cmnd.CommandType = CommandType.StoredProcedure

        BindYears()
        BindCowCounts()
        BindYesNo(dd_cowshed)
        BindYesNo(dd_landspace)
        BindYesNo(dd_thayumanavar)

        Dim benid As String = GetBenId()
        bgrdd.fill_ben(conn, dd_district, "loan_district", benid, "")
        ConfigureSchemeRules(benid, Not IsPostBack)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not String.IsNullOrWhiteSpace(hf_scheme_type.Value) Then
            ConfigureSchemeRules(GetBenId(), False)
        End If
    End Sub

    Private Sub ConfigureSchemeRules(ByVal benid As String, ByVal populateExisting As Boolean)
        cmnd.CommandType = CommandType.StoredProcedure
        cmnd.CommandText = "sp_gridview_ben"
        cmnd.Parameters.Clear()
        cmnd.Parameters.AddWithValue("@icmd", "ben_loan_application")
        cmnd.Parameters.AddWithValue("@id1", benid)
        cmnd.Parameters.AddWithValue("@id2", bgr.enc_key("DB_BENEFICIARY"))

        Dim adptr As New MySqlDataAdapter(cmnd)
        Dim dt As New DataTable
        adptr.Fill(dt)

        Dim schemeType As String = "MINI"
        Dim bankInfo As String = ""
        Dim statusEn As String = ""
        If dt.Rows.Count > 0 Then
            Dim row As DataRow = dt.Rows(0)
            schemeType = Convert.ToString(row("scheme_type")).Trim().ToUpper()
            If dt.Columns.Contains("status_en") AndAlso Not IsDBNull(row("status_en")) Then
                statusEn = Convert.ToString(row("status_en")).Trim()
            End If
            If dt.Columns.Contains("selected_bank_name") AndAlso Not IsDBNull(row("selected_bank_name")) Then
                bankInfo = Convert.ToString(row("selected_bank_name"))
            End If

            If populateExisting AndAlso schemeType = "MEDIUM" Then
                If dt.Columns.Contains("proj_amt") AndAlso Not IsDBNull(row("proj_amt")) Then
                    tb_proj_amt.Text = Convert.ToString(row("proj_amt"))
                End If
                If dt.Columns.Contains("loan_amt_req") AndAlso Not IsDBNull(row("loan_amt_req")) Then
                    tb_loan_amt_req.Text = Convert.ToString(row("loan_amt_req"))
                End If
            End If
        Else
            statusEn = GetCurrentLoanStatus(benid)
        End If

        hf_scheme_type.Value = schemeType

        If schemeType = "MEDIUM" Then
            hf_required_cows.Value = "5"
            pnl_medium_loan_details.Visible = True
            ltl_page_title.Text = "MEDIUM DAIRY LOAN APPLICATION - நடுத்தர பால் பண்ணைக் கடன் விண்ணப்பம்"
            div_scheme_banner.Attributes("class") = "alert alert-success fw-semibold mb-3"
            ltl_scheme_banner.Text = "Selected Scheme: <strong>Medium Dairy Farm Scheme (Up to 5 Milch Animals)</strong> — Loan Sanctioned by <strong>Indian Overseas Bank (IOB)</strong> &amp; Credited to Registered Bank Account" &
                                     If(bankInfo <> "", " (" & bankInfo & ")", "") &
                                     " | Min. <strong>2</strong> existing milch cows &amp; Min. <strong>300 L/month</strong> milk supply required."
            ltl_cow_rule.Text = "Minimum <strong>2</strong> milch cows required for Medium Dairy (நடுத்தர பால் பண்ணைக்கு குறைந்தபட்சம் <strong>2</strong> கறவை மாடுகள் அவசியம்)"
            ltl_milk_rule.Text = "Minimum <strong>300 litres per month</strong> required for Medium Dairy (நடுத்தர பால் பண்ணைக்கு மாதத்திற்கு குறைந்தபட்சம் <strong>300 லிட்டர்</strong> அவசியம்)"
            ltl_cow_prompt.Text = "Number of cows/buffaloes proposed for loan (Up to <strong>5</strong>) <br /> கடனுக்காக முன்மொழியப்பட்ட பசுக்கள்/எருமைகள் எண்ணிக்கை (அதிகபட்சம் <strong>5</strong> வரை)"
            cv1.ErrorMessage = "The total number of cows and buffaloes must be between 1 and up to 5 for Medium Dairy Scheme. (நடுத்தர பால் பண்ணைத் திட்டத்திற்கு மொத்த எண்ணிக்கை 1 முதல் 5 வரை இருக்க வேண்டும்.)"
        Else
            hf_required_cows.Value = "4"
            pnl_medium_loan_details.Visible = False
            tb_proj_amt.Text = ""
            tb_loan_amt_req.Text = ""
            ltl_page_title.Text = "MINI DAIRY LOAN APPLICATION - சிறு பால் பண்ணைக் கடன் விண்ணப்பம்"
            div_scheme_banner.Attributes("class") = "alert alert-info fw-semibold mb-3"
            ltl_scheme_banner.Text = "Selected Scheme: <strong>Mini Dairy Farm Scheme (Up to 4 Milch Animals)</strong>"
            ltl_cow_rule.Text = "Select number of milch cows currently owned (தற்போது வைத்திருக்கும் கறவை மாடுகளின் எண்ணிக்கையைத் தேர்ந்தெடுக்கவும்)"
            ltl_milk_rule.Text = "Enter total milk supplied to society per month in litres (சங்கத்திற்கு மாதந்தோறும் வழங்கப்படும் மொத்த பால் அளவை லிட்டரில் உள்ளிடவும்)"
            ltl_cow_prompt.Text = "Number of cows/buffaloes proposed for loan (Up to <strong>4</strong>) <br /> கடனுக்காக முன்மொழியப்பட்ட பசுக்கள்/எருமைகள் எண்ணிக்கை (அதிகபட்சம் <strong>4</strong> வரை)"
            cv1.ErrorMessage = "The total number of cows and buffaloes must be between 1 and up to 4. (பசுக்கள் மற்றும் எருமைகளின் மொத்த எண்ணிக்கை 1 முதல் 4 வரை இருக்க வேண்டும்.)"
        End If

        Dim allowed As Boolean = IsLoanEditingAllowed(statusEn)
        If allowed Then
            errmsg.Visible = False
        End If
        ApplyLoanEditLock(allowed)
    End Sub

    Private Sub dd_district_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dd_district.SelectedIndexChanged
        bgrdd.fill_ben(conn, dd_union, "loan_mpu", dd_district.SelectedValue.ToString, "")
    End Sub

    Private Sub dd_union_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dd_union.SelectedIndexChanged
        bgrdd.fill_ben(conn, dd_society, "loan_mpcs", dd_union.SelectedValue.ToString, "")
    End Sub

    Private Sub BindYears()
        dd_year.Items.Clear()
        dd_year.Items.Add(New ListItem("-- Select Year (ஆண்டைத் தேர்ந்தெடுக்கவும்)--", "0"))
        For yr As Integer = 1960 To DateTime.Now.Year
            dd_year.Items.Add(New ListItem(yr.ToString(), yr.ToString()))
        Next
    End Sub

    Private Sub BindCowCounts()
        dd_cow_count.Items.Clear()
        dd_cow_count.Items.Add(New ListItem("-- Select Count (எண்ணைத் தேர்ந்தெடுக்கவும்) --", "0"))
        For i As Integer = 1 To 100
            dd_cow_count.Items.Add(New ListItem(i.ToString(), i.ToString()))
        Next
    End Sub

    Private Sub BindYesNo(ByVal ddl As DropDownList)
        ddl.Items.Clear()
        ddl.Items.Add(New ListItem("-- Select Option (விருப்பத்தைத் தேர்ந்தெடுக்கவும்) --", "0"))
        ddl.Items.Add(New ListItem("Yes (ஆம்)", "Yes"))
        ddl.Items.Add(New ListItem("No (இல்லை)", "No"))
    End Sub

    Private Sub btn_submit_Click(sender As Object, e As EventArgs) Handles btn_submit.Click
        Try
            Dim benid As String = GetBenId()
            Dim currentStatus As String = GetCurrentLoanStatus(benid)

            If Not IsLoanEditingAllowed(currentStatus) Then
                ApplyLoanEditLock(False)
                Exit Sub
            End If

            Dim schemeType As String = Convert.ToString(hf_scheme_type.Value).Trim().ToUpper()
            Dim maxCows As Integer = Convert.ToInt32(hf_required_cows.Value)
            Dim ownedCows As Integer = Convert.ToInt32(Val(dd_cow_count.SelectedValue))
            Dim monthlyMilkQty As Integer = Convert.ToInt32(Val(tb_milk_qty.Text))
            Dim projAmtParam As Object = DBNull.Value
            Dim loanAmtReqParam As Object = DBNull.Value

            If schemeType = "MEDIUM" Then
                If ownedCows < 2 Then
                    errmsg.Visible = True
                    errmsg.InnerHtml = "For Medium Dairy Farm Scheme, you must currently own at least 2 milch cows. (நடுத்தர பால் பண்ணைத் திட்டத்திற்கு தற்போது குறைந்தபட்சம் 2 கறவை மாடுகள் வைத்திருக்க வேண்டும்.)"
                    dd_cow_count.Focus()
                    Exit Sub
                End If

                If monthlyMilkQty < 300 Then
                    errmsg.Visible = True
                    errmsg.InnerHtml = "For Medium Dairy Farm Scheme, milk supplied to the society must be at least 300 litres per month. (நடுத்தர பால் பண்ணைத் திட்டத்திற்கு சங்கத்திற்கு மாதந்தோறும் குறைந்தபட்சம் 300 லிட்டர் பால் வழங்கியிருக்க வேண்டும்.)"
                    tb_milk_qty.Focus()
                    Exit Sub
                End If

                Dim projAmtVal As Decimal
                Dim loanAmtReqVal As Decimal
                Const maxLoanAmt As Decimal = 400000D

                If Not Decimal.TryParse(tb_proj_amt.Text.Trim(), projAmtVal) OrElse projAmtVal <= 0D Then
                    errmsg.Visible = True
                    errmsg.InnerHtml = "Please enter a valid Project Amount for the Medium Dairy Farm Scheme. (நடுத்தர பால் பண்ணைத் திட்டத்திற்கு சரியான திட்டத் தொகையை உள்ளிடவும்.)"
                    tb_proj_amt.Focus()
                    Exit Sub
                End If

                If Not Decimal.TryParse(tb_loan_amt_req.Text.Trim(), loanAmtReqVal) OrElse loanAmtReqVal <= 0D Then
                    errmsg.Visible = True
                    errmsg.InnerHtml = "Please enter a valid Requested Loan Amount for the Medium Dairy Farm Scheme. (நடுத்தர பால் பண்ணைத் திட்டத்திற்கு சரியான கோரப்படும் கடன் தொகையை உள்ளிடவும்.)"
                    tb_loan_amt_req.Focus()
                    Exit Sub
                End If

                If loanAmtReqVal > projAmtVal Then
                    errmsg.Visible = True
                    errmsg.InnerHtml = "Requested Loan Amount cannot exceed Project Amount. (கோரப்படும் கடன் தொகை திட்டத் தொகையை விட அதிகமாக இருக்கக் கூடாது.)"
                    tb_loan_amt_req.Focus()
                    Exit Sub
                End If

                If loanAmtReqVal > maxLoanAmt Then
                    errmsg.Visible = True
                    errmsg.InnerHtml = "Requested Loan Amount cannot exceed ₹4,00,000 (4 Lakhs). (கோரப்படும் கடன் தொகை ₹4,00,000-க்கு (4 லட்சம்) அதிகமாக இருக்கக் கூடாது.)"
                    tb_loan_amt_req.Focus()
                    Exit Sub
                End If

                projAmtParam = projAmtVal
                loanAmtReqParam = loanAmtReqVal
            End If

            Dim c1 As Integer = Convert.ToInt32(Val(tb_cnt1.Text))
            Dim c2 As Integer = Convert.ToInt32(Val(tb_cnt2.Text))
            Dim c3 As Integer = Convert.ToInt32(Val(tb_cnt3.Text))
            Dim totalAnimals As Integer = c1 + c2 + c3

            If totalAnimals < 1 OrElse totalAnimals > maxCows Then
                errmsg.Visible = True
                errmsg.InnerHtml = "The total number of cows and buffaloes must be between 1 and up to " & maxCows.ToString() & ". (பசுக்கள் மற்றும் எருமைகளின் மொத்த எண்ணிக்கை 1 முதல் " & maxCows.ToString() & " வரை இருக்க வேண்டும்.)"
                Exit Sub
            End If

            cmnd.CommandType = CommandType.StoredProcedure
            cmnd.CommandText = "sp_ben_loan_application"
            cmnd.Parameters.Clear()
            cmnd.Parameters.AddWithValue("@iben_id", Convert.ToInt32(benid))
            cmnd.Parameters.AddWithValue("@iben_thayumanavar", dd_thayumanavar.SelectedValue.ToString)
            cmnd.Parameters.AddWithValue("@ino_of_cows", Convert.ToInt16(ownedCows))
            cmnd.Parameters.AddWithValue("@impcs_member_no", tb_membership_no.Text)
            cmnd.Parameters.AddWithValue("@impcs_member_join_year", Convert.ToInt16(dd_year.SelectedValue.ToString))
            cmnd.Parameters.AddWithValue("@ihaving_no_of_cow", Convert.ToInt16(ownedCows))
            cmnd.Parameters.AddWithValue("@imilk_qty", Convert.ToInt16(monthlyMilkQty))
            cmnd.Parameters.AddWithValue("@ihas_cow_shed", dd_cowshed.SelectedValue.ToString)
            cmnd.Parameters.AddWithValue("@ihas_space_for_cow_shed", dd_landspace.SelectedValue.ToString)
            cmnd.Parameters.AddWithValue("@ino_of_hybrid_jersy_cows", Convert.ToInt16(c1))
            cmnd.Parameters.AddWithValue("@ino_of_hybrid_prussian_cows", Convert.ToInt16(c2))
            cmnd.Parameters.AddWithValue("@ino_of_buff", Convert.ToInt16(c3))
            cmnd.Parameters.AddWithValue("@iloan_dist_id", Convert.ToInt16(dd_district.SelectedValue.ToString))
            cmnd.Parameters.AddWithValue("@impcs_id", Convert.ToInt16(dd_society.SelectedValue.ToString))
            cmnd.Parameters.AddWithValue("@impu_id", Convert.ToInt16(dd_union.SelectedValue.ToString))
            cmnd.Parameters.AddWithValue("@iproj_amt", projAmtParam)
            cmnd.Parameters.AddWithValue("@iloan_amt_req", loanAmtReqParam)

            conn.Open()
            Dim str As String = Convert.ToString(cmnd.ExecuteScalar())

            If str = "SUCCESS" Then
                cmnd.CommandType = CommandType.Text
                cmnd.CommandText = "UPDATE tbl_ben_loan SET status_en = 'Loan Data Submitted', status_ta = 'கடன் விவரங்கள் சமர்ப்பிக்கப்பட்டன' WHERE ben_id = @ben_id"
                cmnd.Parameters.Clear()
                cmnd.Parameters.AddWithValue("@ben_id", Convert.ToInt32(benid))
                cmnd.ExecuteNonQuery()
            End If
            conn.Close()

            Select Case str
                Case "SUCCESS"
                    Session("otr_stat") = "Loan Data Submitted"
                    Response.Redirect("~/ONLINE/BEN", False)
                    Context.ApplicationInstance.CompleteRequest()
                Case "FAILURE"
                    errmsg.Visible = True
                    errmsg.InnerHtml = "Error submitting loan application."
                Case Else
                    errmsg.Visible = True
                    errmsg.InnerHtml = str
            End Select
        Catch ex As Exception
            If conn.State = ConnectionState.Open Then conn.Close()
            errmsg.Visible = True
            errmsg.InnerHtml = "Error: " & ex.Message
        End Try
    End Sub
End Class