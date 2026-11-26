<%@ Page Title="File Upload" EnableEventValidation="true" Language="vb" AutoEventWireup="false" MasterPageFile="~/ONLINE/BEN/ZMASTERBEN.Master" CodeBehind="FILEUPLOAD.aspx.vb" Inherits="MINIDAIRY.FILEUPLOAD" %>
<%@ Register Src="~/CONTROLS/CropImageControl.ascx" TagPrefix="uc" TagName="CropImageControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">
<div class="container my-4">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4">
        <h4 class="fw-bold text-success mb-2 mb-md-0">Step 1: Applicant Document Upload (ஆவணங்கள் பதிவேற்றம்)</h4>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item active" aria-current="page">1. Document Upload</li>
                <li class="breadcrumb-item text-muted">2. Scheme &amp; Signed Letter</li>
                <li class="breadcrumb-item text-muted">3. Loan Application</li>
            </ol>
        </nav>
    </div>
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">

<div class="container my-4">
    <div id="errmsg" runat="server" class="alert alert-danger" visible="false"></div>

    <div id="div_lock_notice" runat="server" class="alert alert-secondary fw-semibold mb-3" visible="false">
        Editing and re-uploading documents are locked because your Signed Application Letter has already been submitted. You can still view your uploaded documents.
        <br />
        கையொப்பமிட்ட விண்ணப்பக் கடிதம் சமர்ப்பிக்கப்பட்டதால் ஆவணங்களை மாற்றவோ மீண்டும் பதிவேற்றவோ இயலாது. பதிவேற்றிய ஆவணங்களைப் பார்க்க மட்டுமே முடியும்.
    </div>

    <asp:MultiView ID="mvDocs" runat="server" ActiveViewIndex="0">

        <!-- ==================== VIEW 1 : DOCUMENT LIST ==================== -->
        <asp:View ID="viewList" runat="server">
            <asp:GridView ID="gvDocs" runat="server" AutoGenerateColumns="False"
                CssClass="table table-bordered table-striped table-hover text-center align-middle">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="S.No" ItemStyle-Width="5%" />
                    <asp:BoundField DataField="name" HeaderText="Document Name" ItemStyle-HorizontalAlign="Left" />
                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="10%">
                        <ItemTemplate>
                            <%# If(Convert.ToString(Eval("val")) <> "0", "<i class=""fa-solid fa-circle-check text-success status-icon""></i>", "<i class=""fa-solid fa-circle-xmark text-danger status-icon""></i>") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" ItemStyle-Width="25%">
                        <ItemTemplate>
                            <asp:Button ID="btnView" runat="server" CssClass="btn btn-sm btn-outline-info me-1"
                                Text="View" CommandName="ViewDoc" CommandArgument='<%# Eval("id") %>'
                                Visible='<%# Convert.ToString(Eval("val")) <> "0" %>' />
                            <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-sm btn-outline-warning me-1"
                                Text="Edit" CommandName="EditDoc" CommandArgument='<%# Eval("id") %>'
                                Visible='<%# Convert.ToString(Eval("val")) <> "0" AndAlso IsDocEditingAllowed() %>' />
                            <asp:Button ID="btnUpload" runat="server" CssClass="btn btn-sm btn-outline-success"
                                Text="Upload" CommandName="UploadDoc" CommandArgument='<%# Eval("id") %>'
                                Visible='<%# Convert.ToString(Eval("val")) = "0" AndAlso IsDocEditingAllowed() %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:View>

        <!-- ==================== VIEW 2 : UPLOAD/EDIT DOCUMENT ==================== -->
        <asp:View ID="viewUpload" runat="server">
            <div class="card shadow-sm">
                <div class="card-header bg-gradient-primary-to-secondary text-white d-flex justify-content-between align-items-center">
                    <span>Upload / Edit <asp:Literal ID="ltl_header" runat="server"></asp:Literal></span>
                    <asp:Button ID="btn_back" runat="server" Text="Go Back" CssClass="btn btn-sm btn-danger" />
                </div>
                <div class="card-body">
                    <uc:CropImageControl ID="ImageCropControl" runat="server" />
                </div>
            </div>
        </asp:View>

        <!-- ==================== VIEW 3 : VIEW DOCUMENT ==================== -->
        <asp:View ID="viewShow" runat="server">
            <div class="card shadow-sm">
                <div class="card-header bg-gradient-primary-to-secondary text-white">View <asp:Literal ID="ltl_header1" runat="server"></asp:Literal></div>
                <div class="card-body text-center">
                    <asp:HiddenField ID="hf_image_no" runat="server" />
                    <div class="text-center">
                        <asp:Image ID="imgDisplay" runat="server" CssClass="img-fluid rounded shadow" />
                    </div>
                </div>
            </div>
        </asp:View>
    </asp:MultiView>

    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div class="alert alert-warning mt-3">
                After uploading all 8 required documents (including your <strong>Society ID Card</strong>), the <strong>“Proceed to Scheme Selection”</strong> button will appear below so you can choose Mini or Medium Dairy Scheme and download your Application Letter.
                <br />
                தேவையான 8 ஆவணங்களையும் (<strong>சங்க அடையாள அட்டை</strong> உட்பட) பதிவேற்றிய பின் <strong>“திட்டத் தேர்விற்குத் தொடரவும்”</strong> என்ற பொத்தான் கீழே தோன்றும்.
            </div>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <div class="w-100 text-center mt-3">
                <asp:Button ID="btn_submit" runat="server"
                    Text="Proceed to Scheme Selection &#010; (திட்டத் தேர்விற்குத் தொடரவும்)"
                    CssClass="btn btn-success m-2 px-4 py-2 fw-bold" ValidationGroup="vg1" />
            </div>
        </asp:View>
    </asp:MultiView>

    <div class="modal fade" id="uploadPopup" tabindex="-1" aria-labelledby="uploadPopupLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-gradient-primary-to-secondary text-white">
                    <h5 class="modal-title" id="uploadPopupLabel">Document</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <asp:Image ID="img_doc" runat="server" CssClass="img-fluid rounded shadow" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

</div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="footer_content_holder" runat="server">
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="script_content_holder" runat="server">
</asp:Content>