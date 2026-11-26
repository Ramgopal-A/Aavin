<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ZMASTEREN.Master" CodeBehind="OFFICER.aspx.vb" Inherits="MINIDAIRY.OFFICER" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head_place_holder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" >
<ContentTemplate>
<section class="bg-gradient-blue text-center text-white py-4">
  <h4 class="fw-bold display-7 mb-2">Officer Login</h4>
</section>

    <div class="container pt-5 pb-5">
    <div class="row g-4 justify-content-center">

        <div class="col-lg-8 col-md-6 col-sm-12">
            <div class="card h-100 shadow-sm border-1">
                <img src="/ASSETS/IMAGES/avinillam.jpg" class="card-img card-img-top" />
                <div class="card-body vertical-align-center">
                    <div class="row g-4 align-items-center">
 <!-- QR Code -->
 <div class="col-lg-4 text-center">
     <img src="/ASSETS/IMAGES/off_log_qr.jpg" alt="Telegram Bot QR Code" class="img-fluid rounded" />
 </div>
 <!-- Instructions -->
 <div class="col-lg-8">
     <h5 class="fw-bold mb-3">Instructions</h5>
     <ul class="ps-3 mb-2">
         <li>Open your <strong>Telegram</strong> app on your mobile device.</li>
         <li>Use the "Scan QR Code" feature from the Telegram menu.</li>
         <li>Scan the QR code displayed here.</li>
         <li>Interact with our Telegram bot for further instructions.</li>
     </ul>
     <p class="text-muted mb-0">If you don’t have the Telegram app, download it from your device's app store.</p>
 </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column: Sign-In MultiView -->
        <div class="col-lg-4 col-md-6 col-sm-12">
            <div class="card shadow-sm border-1">
                <div class="card-header bg-gradient-primary-to-secondary text-white fw-semibold">Sign In</div>
                <div class="card-body">

                    <!-- Error Message -->
                    <div id="errmsg" runat="server" class="alert alert-danger" role="alert"></div>

                    <!-- MultiView Sign-In Flow -->
                    <asp:MultiView ID="MultiView1" runat="server">

 <!-- View 1: Enter Username -->
 <asp:View ID="View1" runat="server">
     <div class="mb-3">
         <label for="<%=tb_uname.ClientID%>" class="form-label">
             Username <span class="text-danger">*</span>
         </label>
         <asp:TextBox ID="tb_uname" runat="server" CssClass="form-control" ValidationGroup="vg1" />
         <asp:RequiredFieldValidator ID="rfv11" runat="server" ControlToValidate="tb_uname"
             ValidationGroup="vg1" ErrorMessage="Username is required." CssClass="text-danger" Display="Dynamic" />
     </div>
     <div class="mb-3">
         <label for="<%=dd_utype.ClientID%>" class="form-label">
             User Type <span class="text-danger">*</span>
         </label>
         <asp:DropDownList ID="dd_utype" runat="server" CssClass="form-select">
             <asp:ListItem Text="Select Officer" Value="0"></asp:ListItem>
             <asp:ListItem Text="Milk Producer Cooperative Society" Value="MPCS"></asp:ListItem>
             <asp:ListItem Text="Milk Producer Union" Value="MPU"></asp:ListItem>
             <asp:ListItem Text="Bankers" Value="BANK"></asp:ListItem>
             <asp:ListItem Text="Milk Producer's Federation Limited" Value="MPFL"></asp:ListItem>
         </asp:DropDownList>
         <asp:RequiredFieldValidator ID="rfv12" runat="server" ControlToValidate="dd_utype" 
             InitialValue="0" ValidationGroup="vg1" ErrorMessage="User Type is required." CssClass="text-danger" Display="Dynamic" />
     </div>
     <div class="mb-3 text-center">
         <asp:Image ID="imgCaptcha" runat="server" CssClass="img-captcha" />
         <asp:LinkButton ID="lbtn_captcha_ref" runat="server" CssClass="btn btn-sm btn-light"><i class="fa fa-refresh text-primary"></i></asp:LinkButton>
         <asp:HiddenField ID="hf_captcha" runat="server" />
     </div>
     <div class="mb-3">
        <label for="<%=tb_captcha.ClientID%>" class="form-label">Type Captcha word<span class="form-mandatory">*</span></label>
        <asp:TextBox ID="tb_captcha" CssClass="form-control" runat="server"  ValidationGroup="vg1" AutoCompleteType="Disabled" placeholder="Type the captcha word" MaxLength="6"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvc" runat="server" ControlToValidate="tb_captcha" ValidationGroup="vg1" ErrorMessage="Captcha is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
     </div>

     <asp:HiddenField ID="HiddenFieldOTP" runat="server" />
     <asp:HiddenField ID="HiddenFieldcid" runat="server" />

     <div class="text-center mt-3">
         <asp:Button ID="ButtonSendOTP" runat="server" Text="Send OTP"
             CssClass="btn btn-primary w-100" ValidationGroup="vg1" />
     </div>
 </asp:View>

 <!-- View 2: OTP Entry -->
 <asp:View ID="View2" runat="server">
     <div class="mb-3">
         <label for="<%=tb_uname1.ClientID%>" class="form-label">
             Username <span class="text-danger">*</span>
         </label>
         <asp:TextBox ID="tb_uname1" runat="server" CssClass="form-control" ReadOnly="true" ValidationGroup="vg2" />
     </div>

     <div class="mb-3">
         <label for="<%=tb_otp.ClientID%>" class="form-label">
             One Time Password (OTP) <span class="text-danger">*</span>
         </label>
         <asp:TextBox ID="tb_otp" runat="server" CssClass="form-control" ValidationGroup="vg2" />
         <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="tb_otp"
             ErrorMessage="OTP is required." CssClass="text-danger" ValidationGroup="vg2" />
     </div>

     <div class="row my-3">
         <div class="col col-12 w-100">
              <asp:Button ID="ButtonSignIn" runat="server" Text="Sign In" CssClass="btn btn-success w-100" ValidationGroup="vg2" />
         </div>
        

         <div class="col col-12 btn-group w-100 mt-3">
             <asp:Button ID="Buttoncancel" runat="server" Text="Cancel" CssClass="btn btn-outline-danger m-0" />
             <asp:Button ID="Buttonresendotp" runat="server" Text="Resend OTP" CssClass="btn btn-outline-primary m-0" />
         </div>
     </div>
 </asp:View>

                    </asp:MultiView>
                </div>
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
