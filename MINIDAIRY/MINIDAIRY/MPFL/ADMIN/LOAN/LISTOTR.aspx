<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MPFL/ADMIN/ZMASTERMPFLADMIN.Master" CodeBehind="LISTOTR.aspx.vb" Inherits="MINIDAIRY.LISTOTR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
<style>
.grid-card { box-shadow: 0 6px 18px rgba(0,0,0,0.08); border-radius:6px; }
.modal-lg { --bs-modal-width: 900px; }
.section-title { background: #272a7d; color: #fff; text-align: left; padding: 2px 10px; font-weight: bold; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<div class="container py-4">
<div class="d-flex justify-content-between align-items-center mb-4">
<h4 class="mb-0">List of Files Under Processing in Union</h4>
</div>
<div id="errmsg" runat="server" class="alert alert-danger alert-dismissible"></div>
<div class="card grid-card">
<div class="table-responsive">

<asp:GridView ID="gvMpu" runat="server" AutoGenerateColumns="false" CssClass="table table-stried table-hover"
    EmptyDataText="No records found."   
     DataKeyNames="ben_id">
    <HeaderStyle CssClass="text-center" />
   
    <Columns>
        <asp:TemplateField HeaderText="S.No" ItemStyle-Width="60px"  HeaderStyle-CssClass="bg-primary text-white" >
            <ItemTemplate>
                <%# Container.DataItemIndex + 1 %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="ben_avinid" HeaderText="AAVIN ID" HeaderStyle-CssClass="bg-primary text-white"/>
        <asp:BoundField DataField="ben_name" HeaderText="APPLICANT NAME" HeaderStyle-CssClass="bg-primary text-white" />
        <asp:BoundField DataField="ben_aadhar" HeaderText="AADHAR NUMBER" HeaderStyle-CssClass="bg-primary text-white" />
        <asp:BoundField DataField="ben_mobile_no" HeaderText="MOBILE NUMBER" HeaderStyle-CssClass="bg-primary text-white" />
        <asp:BoundField DataField="ben_gender" HeaderText="GENDER" HeaderStyle-CssClass="bg-primary text-white" />
        <asp:BoundField DataField="adhar_dist" HeaderText="AADHAR DISTRICT" HeaderStyle-CssClass="bg-primary text-white" />
        <asp:BoundField DataField="present_dist" HeaderText="RESIDING DISTRICT" HeaderStyle-CssClass="bg-primary text-white" />
    </Columns>
</asp:GridView>

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
</asp:Content>
