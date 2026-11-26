<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MPFL/ADMIN/ZMASTERMPFLADMIN.Master" CodeBehind="MPFLLOG.aspx.vb" Inherits="MINIDAIRY.MPFLLOG" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
<style>
.grid-card { box-shadow: 0 6px 18px rgba(0,0,0,0.08); border-radius:6px; }
.modal-lg { --bs-modal-width: 900px; }
</style>
 <script src="/ASSETS/CONTROLS/TAMILTB/tamiltextbox.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<div class="container py-4">
     

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="mb-0">Officer Management</h3>
               <div class="row">
                   <div class="col col-sm-12 col-md-3 col-lg-3">
                    <asp:Button ID="btnNew" runat="server" CssClass="btn btn-sm btn-primary" Text="New Officer" />
                   </div>
               </div>
            </div>

            <div id="errmsg" runat="server" class="alert alert-danger alert-dismissible"></div>

            <div class="card grid-card p-3">
 
 <div class="table-responsive">
     <asp:GridView ID="gvMpcs" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-hover"
         EmptyDataText="No records found."   
          DataKeyNames="mpfl_id">

         <Columns>
             <asp:TemplateField HeaderText="S.No" ItemStyle-Width="60px" HeaderStyle-HorizontalAlign="Center">
                 <ItemTemplate>
                     <%# Container.DataItemIndex + 1 %>
                 </ItemTemplate>
             </asp:TemplateField>
             <asp:BoundField DataField="mpfl_name" HeaderText="Name of the Officer" HeaderStyle-HorizontalAlign="Center"/>
             <asp:BoundField DataField="mpfl_uname" HeaderText="User Name" HeaderStyle-HorizontalAlign="Center"/>
             <asp:BoundField DataField="mpfl_uid" HeaderText="Telegram ID" HeaderStyle-HorizontalAlign="Center" />
             <asp:TemplateField HeaderText="Actions" ItemStyle-Width="160px">
                 <ItemTemplate>
                     <div class="d-flex gap-2">
  <asp:LinkButton ID="lnkEdit" runat="server" CommandName="EditRow" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-outline-primary">Update Telegram ID</asp:LinkButton>
                     </div>
                 </ItemTemplate>
             </asp:TemplateField>
         </Columns>
     </asp:GridView>
 </div>

            </div>
        </div>


                <div class="modal fade" id="mpcsModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
 <div class="modal-content">
     <div class="modal-header bg-gradient-primary-to-secondary text-center text-white">
         <h5 class="modal-title" id="modalTitle"><asp:Literal ID="ltl_modalhead" runat="server"></asp:Literal> </h5>
         <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
     </div>
     <div class="modal-body">
         <asp:HiddenField ID="hfMpcsId" runat="server" />
         <div class="row g-3">

             <div class="col col-sg-12 col-md-12 col-lg-12">
                 <label class="form-label">Name of the Officer</label>
                 <asp:TextBox ID="tbFullEn" runat="server" CssClass="form-control form-control-sm" ></asp:TextBox>
             </div>


             <div class="col col-sg-12 col-md-12 col-lg-12">
                 <label class="form-label">Login Telegram ID</label>
                 <asp:TextBox ID="tbTelID" runat="server" CssClass="form-control form-control-sm" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..?)\../g, '$1');"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="rfvShortTa" runat="server"
                     ControlToValidate="tbTelID"
                     ErrorMessage="Login Telegram ID is required."
                     CssClass="text-danger small"
                     Display="Dynamic"
                     ValidationGroup="vg1"></asp:RequiredFieldValidator>
             </div>

         </div>

         <asp:ValidationSummary ID="ValidationSummary1" runat="server"
             CssClass="alert alert-danger mt-3"
             HeaderText="Please correct the following errors:"
             DisplayMode="BulletList"
             ShowSummary="true"
             ValidationGroup="vg1" />



     </div>
     <div class="modal-footer">
         <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" ValidationGroup="vg1" data-bs-dismiss="modal"/>
         <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary" Text="Cancel" OnClientClick="$('#mpcsModal').modal('hide'); return false;" UseSubmitBehavior="false" />
     </div>
 </div>
                    </div>
                </div>
</ContentTemplate>
<Triggers>

</Triggers>
</asp:UpdatePanel>
<asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
<ProgressTemplate>
            <div class="progress_modal">
                <div class="progress_center">
                     <div class="loader">
 <div class="loader-inner">
     <div class="loading one"></div>
 </div>
 <div class="loader-inner">
     <div class="loading two"></div>
 </div>
 <div class="loader-inner">
     <div class="loading three"></div>
 </div>
 <div class="loader-inner">
     <div class="loading four"></div>
 </div>
                    </div>
                </div>
            </div>
</ProgressTemplate>
</asp:UpdateProgress>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer_content_holder" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="script_content_holder" runat="server">
        <script>
            // small helper to show bootstrap modal via server-side registered script
            function showMpcsModal() {
                var m = new bootstrap.Modal(document.getElementById('mpcsModal'));
                m.show();
            }
            function hideMpcsModal() {
                var m = bootstrap.Modal.getInstance(document.getElementById('mpcsModal'));
                if (m) m.hide();
            }
        </script>
</asp:Content>

