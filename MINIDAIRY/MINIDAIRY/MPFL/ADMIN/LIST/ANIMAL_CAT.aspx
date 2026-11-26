<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MPFL/ADMIN/ZMASTERMPFLADMIN.Master" CodeBehind="ANIMAL_CAT.aspx.vb" Inherits="MINIDAIRY.ANIMAL_CAT" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
<style>
    .ac-form .form-label {
        font-size: 11px;
        font-weight: 700;
        letter-spacing: .04em;
        color: #6b7a99;
        margin-bottom: 4px;
        text-transform: uppercase;
    }
    .ac-form .form-control {
        font-size: 14px;
        padding: 10px 12px;
        border-radius: 8px;
        border: 1.5px solid #dde4f0;
        width: 100%;
    }
    .ac-form .form-control:focus {
        border-color: #4361ee;
        box-shadow: 0 0 0 3px rgba(67,97,238,.12);
        outline: none;
    }
    .ac-btn-row {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 16px;
    }
    .ac-btn-row .btn {
        flex: 1 1 130px;
        padding: 11px 18px;
        font-size: 14px;
        font-weight: 600;
        border-radius: 9px;
        min-width: 110px;
        min-height: 44px;
    }
    @media (max-width: 640px) {
        .ac-btn-row {
            position: fixed;
            bottom: 0; left: 0; right: 0;
            z-index: 1000;
            background: #fff;
            border-top: 2px solid #e2e8f4 !important;
            box-shadow: 0 -4px 16px rgba(67,97,238,.10);
            padding: 12px 16px !important;
            margin-top: 0 !important;
            border-radius: 0;
        }
        .ac-btn-row .btn { flex: 1 1 0; }
        .card-body { padding-bottom: 80px !important; }
    }
    .ac-table-wrap {
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }
    .ac-table-wrap .table {
        min-width: 360px;
        margin-bottom: 0;
        font-size: 13px;
    }
    .ac-table-wrap .table th {
        background: #f6f8ff;
        color: #4a5568;
        font-size: 11px;
        font-weight: 700;
        letter-spacing: .05em;
        text-transform: uppercase;
        border-bottom: 2px solid #e2e8f4;
        padding: 10px 12px;
        white-space: nowrap;
    }
    .ac-table-wrap .table td {
        padding: 10px 12px;
        vertical-align: middle;
        border-bottom: 1px solid #f0f3f9;
        white-space: nowrap;
    }
    .ac-table-wrap .table tr:last-child td { border-bottom: none; }
    .ac-table-wrap .table tr:hover td     { background: #f6f8ff; }
    .ac-table-wrap .btn-sm {
        padding: 6px 10px;
        font-size: 12px;
        font-weight: 600;
        border-radius: 7px;
        white-space: nowrap;
        min-height: 32px;
    }
    .ac-list-header {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: space-between;
        gap: 10px;
        margin-bottom: 14px;
    }
    .ac-list-header h6 { margin: 0; }
    .ac-breadcrumb {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 12px;
        font-weight: 600;
        color: #6b7a99;
        margin-bottom: 16px;
        flex-wrap: wrap;
    }
    .ac-breadcrumb .step {
        display: flex;
        align-items: center;
        gap: 6px;
        padding: 5px 12px;
        border-radius: 20px;
        background: #f0f3fa;
        color: #6b7a99;
        transition: background .15s, color .15s;
    }
    .ac-breadcrumb .step.active {
        background: #4361ee;
        color: #fff;
    }
    .ac-breadcrumb .step.done {
        background: #e6f9f0;
        color: #166534;
    }
    .ac-breadcrumb .sep {
        color: #c8d4e8;
        font-size: 14px;
    }
    .vec-icon {
        display: inline-block;
        vertical-align: middle;
        margin-right: 5px;
    }
    .vec-icon-white  { filter: brightness(0) invert(1); }
    .vec-icon-accent { filter: brightness(0) saturate(100%) invert(35%) sepia(90%) saturate(500%) hue-rotate(200deg); }
    .vec-icon-muted  { filter: brightness(0) saturate(0%) invert(50%); }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">
     <asp:Panel ID="pnlMsg" runat="server" Visible="false" CssClass="alert mb-3">
     <asp:Literal ID="litMsg" runat="server" />
 </asp:Panel>

 <asp:HiddenField ID="hfCategoryId" runat="server" Value="0" />

 <!-- BREADCRUMB -->
 <div class="ac-breadcrumb">
     <asp:Literal ID="litBreadcrumb" runat="server">
         <span class="step active">
             <img src="Vectors/list-solid.png" class="vec-icon vec-icon-white" style="width:12px;height:12px;" />
             Category List
         </span>
         <span class="sep">›</span>
         <span class="step">
             <img src="Vectors/tag-solid.png" class="vec-icon vec-icon-muted" style="width:12px;height:12px;" />
             Category Form
         </span>
     </asp:Literal>
 </div>

 <asp:MultiView ID="mvCategory" runat="server" ActiveViewIndex="0">

     <!-- VIEW 0 : CATEGORY LIST -->
     <asp:View ID="vwCategoryList" runat="server">

         <div class="ac-list-header">
             <h6 class="fw-bold text-muted">
                 <img src="Vectors/tag-solid.png" class="vec-icon vec-icon-muted" style="width:14px;height:14px;" />
                 Animal Categories
             </h6>
             <asp:LinkButton ID="lbAddNew" runat="server"
                 CssClass="btn btn-primary btn-sm"
                 OnClick="lbAddNew_Click" CausesValidation="False">
                 <img src="Vectors/plus-solid.png" class="vec-icon vec-icon-white" style="width:11px;height:11px;" />
                 Add Category
             </asp:LinkButton>
         </div>

         <div class="card">
             <div class="card-header">
                 <img src="Vectors/list-solid.png" class="vec-icon vec-icon-accent" style="width:14px;height:14px;" />
                 Category List
             </div>
             <div class="ac-table-wrap">
                 <asp:GridView ID="gvCategories" runat="server"
                     CssClass="table table-hover mb-0"
                     AutoGenerateColumns="False"
                     DataKeyNames="CategoryId"
                     GridLines="None"
                     OnRowCommand="gvCategories_RowCommand">
                     <Columns>
                         <asp:TemplateField HeaderText="S.No" ItemStyle-Width="50">
                             <ItemTemplate>
                                 <%# CType(Container, GridViewRow).RowIndex + 1 %>
                             </ItemTemplate>
                         </asp:TemplateField>

                         <asp:BoundField DataField="CategoryName" HeaderText="Category Name" />

                         <asp:TemplateField HeaderText="Actions" ItemStyle-Width="140">
                             <ItemTemplate>
                                 <asp:LinkButton ID="lbEdit" runat="server"
                                     CommandName="EditRow"
                                     CommandArgument='<%# Eval("CategoryId") %>'
                                     CssClass="btn btn-sm btn-warning me-1"
                                     CausesValidation="False">
                                     <img src="Vectors/pen-to-square-solid.png" class="vec-icon vec-icon-white" style="width:11px;height:11px;" /> Edit
                                 </asp:LinkButton>
                                 <asp:LinkButton ID="lbDel" runat="server"
                                     CommandName="DeleteRow"
                                     CommandArgument='<%# Eval("CategoryId") %>'
                                     CssClass="btn btn-sm btn-danger"
                                     CausesValidation="False"
                                     OnClientClick="return confirm('Delete this category?');">
                                      Remove
                                 </asp:LinkButton>
                             </ItemTemplate>
                         </asp:TemplateField>
                     </Columns>
                     <EmptyDataTemplate>
                         <div class="text-center text-muted py-4">No categories found. Add one using the button above.</div>
                     </EmptyDataTemplate>
                 </asp:GridView>
             </div>
         </div>

     </asp:View>

     <!-- VIEW 1 : ADD / EDIT FORM -->
     <asp:View ID="vwCategoryForm" runat="server">

         <div class="mb-3">
             <asp:LinkButton ID="lbBackToList" runat="server"
                 CssClass="btn btn-outline-secondary btn-sm"
                 OnClick="lbBackToList_Click" CausesValidation="False">
                 ← Back to List
             </asp:LinkButton>
         </div>

         <div class="card mb-4 ac-form">
             <div class="card-header">
                 <img src="Vectors/tag-solid.png" class="vec-icon vec-icon-accent" style="width:14px;height:14px;" />
                 <asp:Literal ID="litFormTitle" runat="server" Text="Add Animal Category" />
             </div>
             <div class="card-body">

                 <div class="row g-3">
                     <div class="col-12 col-sm-8 col-md-5">
                         <label class="form-label">
                             CATEGORY NAME <span class="text-danger">*</span>
                         </label>
                         <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control"
                             placeholder="e.g. Cow, Buffalo, Goat..." MaxLength="100" />
                         <asp:RequiredFieldValidator ID="rfvName" runat="server"
                             ControlToValidate="txtCategoryName"
                             ErrorMessage="Category name is required."
                             ValidationGroup="vgCategory"
                             CssClass="text-danger small d-block mt-1" Display="Dynamic" />
                     </div>
                 </div>

                 <div class="ac-btn-row">
                     <asp:Button ID="btnSave" runat="server" Text="Save Category"
                         CssClass="btn btn-primary" OnClick="btnSave_Click"
                         ValidationGroup="vgCategory" />
                     <asp:Button ID="btnClear" runat="server" Text="Clear"
                         CssClass="btn btn-outline-secondary" OnClick="btnClear_Click"
                         CausesValidation="False" />
                 </div>

             </div>
         </div>

     </asp:View>

 </asp:MultiView>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer_content_holder" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="script_content_holder" runat="server">
</asp:Content>
