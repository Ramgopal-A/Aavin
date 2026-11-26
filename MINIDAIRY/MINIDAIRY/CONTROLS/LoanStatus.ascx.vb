Imports System
Imports System.Web.UI
Public Class LoanStatus
    Inherits System.Web.UI.UserControl

    Public WriteOnly Property StatusText As String
        Set(value As String)
            UpdateStatus(value)
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load


    End Sub


    Public Sub UpdateStatus(status As String)
        ResetSteps()

        Select Case status.Trim()
            Case "Loan Application Submitted"
                ActivateStep(step1, desc1, "Loan Application Submitted")
                desc2.InnerHtml = "Under Processing"

            Case "Recommended by Society and Forwarded to Union"
                ActivateStep(step1, desc1, "Loan Application Submitted")
                ActivateStepArrow(step2, desc2, arrow1, "Recommended and Forwarded to MPU")

            Case "Rejected by Society"
                ActivateStep(step1, desc1, "Loan Application Submitted")
                RejectStepArrow(step2, desc2, arrow2, "Rejected by Society")
                RejectStepArrow(step3, desc3, arrow3, "Not Applicable")
                RejectStep(step4, desc4, "Not Applicable")
            Case "Recommended by Union and Forwarded to Bank"
                ActivateStep(step1, desc1, "Loan Application Submitted")
                ActivateStep(step2, desc2, "Recommended and Forwarded to MPU")
                ActivateStep(step3, desc3, "Recommended by Union and Forwarded to MPU")

            Case "Rejected by Union"
                ActivateStep(step1, desc1, "Loan Application Submitted")
                ActivateStep(step2, desc2, "Recommended and Forwarded to MPU")
                RejectStepArrow(step3, desc3, arrow3, "Rejected by Union")
                RejectStep(step4, desc4, "Not Applicable")

            Case "Loan is Sanctioned by Bank"
                ActivateStep(step1, desc1, "Loan Application Submitted")
                ActivateStep(step2, desc2, "Recommended and Forwarded to MPU")
                ActivateStep(step3, desc3, "Recommended by Union and Forwarded to MPU")
                ActivateStep(step4, desc4, "Loan is Sanctioned by Bank")

            Case "Rejected by Bank"
                ActivateStep(step1, desc1, "Loan Application Submitted")
                ActivateStep(step2, desc2, "Recommended and Forwarded to MPU")
                ActivateStep(step3, desc3, "Recommended by Union and Forwarded to MPU")
                RejectStep(step4, desc4, "Rejected by Bank")
        End Select
    End Sub

    Private Sub ResetSteps()
        step1.Attributes("class") = "step step-default"
        step2.Attributes("class") = "step step-default"
        step3.Attributes("class") = "step step-default"
        step4.Attributes("class") = "step step-default"
        desc1.InnerHtml = ""
        desc2.InnerHtml = ""
        desc3.InnerHtml = ""
        desc4.InnerHtml = ""
    End Sub

    Private Sub ActivateStep(stepctrl As HtmlGenericControl, desc As HtmlGenericControl, text As String)
        stepctrl.Attributes("class") = "step step-active"
        desc.InnerHtml = text
    End Sub

    Private Sub RejectStep(stepctrl As HtmlGenericControl, desc As HtmlGenericControl, text As String)
        stepctrl.Attributes("class") = "step step-rejected"
        desc.InnerHtml = text
    End Sub

    Private Sub ActivateStepArrow(stepctrl As HtmlGenericControl, desc As HtmlGenericControl, arrow As HtmlGenericControl, text As String)
        stepctrl.Attributes("class") = "step step-active"

        desc.InnerHtml = text
    End Sub

    Private Sub RejectStepArrow(stepctrl As HtmlGenericControl, desc As HtmlGenericControl, arrow As HtmlGenericControl, text As String)
        stepctrl.Attributes("class") = "step step-rejected"

        desc.InnerHtml = text
    End Sub
End Class

