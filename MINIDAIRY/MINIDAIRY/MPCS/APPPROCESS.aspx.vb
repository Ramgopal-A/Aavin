Imports MySql.Data.MySqlClient

Public Class APPPROCESS
    Inherits System.Web.UI.Page
    Dim conn As New MySqlConnection
    Dim cmnd As New MySqlCommand
    Dim bgr As New bgr
    Dim bgrdb As New bgrdb


    Private Sub APPPROCESS_Init(sender As Object, e As EventArgs) Handles Me.Init
        conn.ConnectionString = bgrdb.conn_str("mini_diary")
        cmnd.Connection = conn
        cmnd.CommandType = CommandType.StoredProcedure
        BindYesNo(dd_verify_name)
        BindYesNo(dd_verify_number)
        BindYesNo(dd_verify_year)
        BindYesNo(dd_verify_age)
        BindYesNo(dd_verify_milk)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub BindYesNo(ByVal ddl As DropDownList)
        ddl.Items.Clear()
        ddl.Items.Add(New ListItem("-- Select Option --", "0"))
        ddl.Items.Add(New ListItem("Yes (ஆம்)", "Yes"))
        ddl.Items.Add(New ListItem("No (இல்லை)", "No"))
    End Sub
End Class