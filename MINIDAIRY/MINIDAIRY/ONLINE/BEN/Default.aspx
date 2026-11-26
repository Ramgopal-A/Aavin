<%@ Page Title="Select Dairy Scheme" Language="vb" AutoEventWireup="false" MasterPageFile="~/ONLINE/BEN/ZMASTERBEN.Master" CodeBehind="Default.aspx.vb" Inherits="MINIDAIRY.BenSchemeDefault" %><asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
    <style>
        .scheme-card { border: 2px solid #dee2e6; border-radius: 12px; transition: all 0.25s ease; }
        .scheme-card:hover { border-color: #0d6efd; box-shadow: 0 6px 20px rgba(13,110,253,0.12); }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">
    <div class="container my-4">
        <h4 class="fw-bold text-primary">
            <asp:Literal ID="ltl_page_heading" runat="server" Text="Step 3: Select Dairy Farm Scheme (பால் பண்ணைத் திட்டத்தைத் தேர்ந்தெடுக்கவும்)"></asp:Literal>
        </h4>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="container my-4">
                <div id="errmsg" runat="server" class="alert alert-danger" visible="false"></div>
                <div id="succmsg" runat="server" class="alert alert-success" visible="false"></div>

                <!-- PART A: Choose Scheme (Shown after File Upload, before Loan Application Form) -->
                <asp:Panel ID="pnl_scheme_select" runat="server" CssClass="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-gradient-primary-to-secondary text-white fw-bold">
                        Choose Your Dairy Scheme (பால் பண்ணைத் திட்டத்தைத் தேர்ந்தெடுக்கவும்)
                    </div>
                    <div class="card-body p-4">
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <div class="scheme-card p-3 h-100">
                                    <div class="form-check">
                                        <asp:RadioButton ID="rb_mini" runat="server" GroupName="SchemeGroup" AutoPostBack="true" Checked="true" CssClass="form-check-input" />
                                        <label class="form-check-label fw-bold text-primary fs-5" for="<%=rb_mini.ClientID%>">
                                            Mini Dairy Farm Scheme (சிறு பால் பண்ணைத் திட்டம்)
                                        </label>
                                    </div>
                                    <ul class="mt-2 mb-0 text-muted small">
                                        <li><strong>Unit Size:</strong> Up to <strong>4 Milch Animals</strong></li>
                                        <li><strong>Disbursement Account:</strong> Credited to your registered bank account.</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="scheme-card p-3 h-100">
                                    <div class="form-check">
                                        <asp:RadioButton ID="rb_medium" runat="server" GroupName="SchemeGroup" AutoPostBack="true" CssClass="form-check-input" />
                                        <label class="form-check-label fw-bold text-success fs-5" for="<%=rb_medium.ClientID%>">
                                            Medium Dairy Farm Scheme (நடுத்தர பால் பண்ணைத் திட்டம்)
                                        </label>
                                    </div>
                                    <ul class="mt-2 mb-0 text-muted small">
                                        <li><strong>Unit Size:</strong> Up to <strong>5 Milch Animals</strong></li>
                                        <li><strong>Loan Sanction &amp; Disbursement:</strong> Loan is sanctioned by <strong>Indian Overseas Bank (IOB)</strong> and deposited directly into the bank account you provided during registration.</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="alert alert-info py-2 small mb-3">
                            <strong>Registered Bank Account for Loan Disbursement:</strong>
                            <asp:Label ID="lbl_reg_bank_info" runat="server" CssClass="fw-semibold"></asp:Label>
                        </div>

                        <div class="text-center">
                            <asp:Button ID="btn_save_scheme" runat="server"
                                Text="Save Scheme & Proceed to Loan Application (திட்டத்தைச் சேமித்து விண்ணப்பப் படிவத்திற்குச் செல்லவும்)"
                                CssClass="btn btn-primary px-4 py-2 fw-bold" />
                        </div>
                    </div>
                </asp:Panel>

                <!-- PART B: Download, Print, Sign & Re-upload Application Letter (Shown after Loan Application Form) -->
                <asp:Panel ID="pnl_app_letter" runat="server" Visible="false" CssClass="card shadow-sm border-success mb-4">
                    <div class="card-header bg-success text-white fw-bold">
                        Step 5: Download, Sign &amp; Re-upload Application Letter (விண்ணப்பக் கடிதத்தைப் பதிவிறக்கி கையொப்பமிட்டு பதிவேற்றவும்)
                    </div>
                    <div class="card-body p-4">
                        <div class="alert alert-light border mb-3 small">
                            <strong>Selected Scheme:</strong> <asp:Label ID="lbl_selected_scheme_summary" runat="server" CssClass="fw-bold text-success"></asp:Label><br />
                            <strong>Registered Bank Account:</strong> <asp:Label ID="lbl_letter_bank_info" runat="server" CssClass="fw-semibold"></asp:Label>
                        </div>

                        <ol class="mb-4">
                            <li class="mb-2">
                                Click <strong>Download Application Letter</strong> below to download your pre-filled bilingual application letter.
                            </li>
                            <li class="mb-2">
                                Print the letter, affix your signature (and Society seal/signature if applicable), and scan or take a clear photo (JPG/JPEG/PNG/PDF, max 2 MB).
                            </li>
                            <li>
                                Upload the signed letter below to complete and submit your Loan Application.
                            </li>
                        </ol>

                        <div class="mb-4">
                            <asp:Button ID="btn_download_letter" runat="server"
                                Text="Download Application Letter (விண்ணப்பக் கடிதத்தைப் பதிவிறக்கவும்)"
                                CssClass="btn btn-outline-success fw-bold" CausesValidation="false" />
                        </div>

                        <div class="row g-3 align-items-end">
                            <div class="col-md-8">
                                <label class="form-label fw-semibold">
                                    Upload Signed Application Letter (கையொப்பமிட்ட விண்ணப்பக் கடிதத்தைப் பதிவேற்றவும்) <span class="text-danger">*</span>
                                </label>
                                <asp:FileUpload ID="fu_signed_letter" runat="server" CssClass="form-control" accept=".jpg,.jpeg,.png,.pdf" />
                            </div>
                            <div class="col-md-4">
                                <asp:Button ID="btn_upload_letter" runat="server"
                                    Text="Upload & Submit Application"
                                    CssClass="btn btn-success w-100 fw-bold" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btn_download_letter" />
            <asp:PostBackTrigger ControlID="btn_upload_letter" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer_content_holder" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="script_content_holder" runat="server">
</asp:Content>