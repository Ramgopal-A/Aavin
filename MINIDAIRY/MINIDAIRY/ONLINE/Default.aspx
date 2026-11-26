<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ZMASTEREN.Master" CodeBehind="Default.aspx.vb" Inherits="MINIDAIRY._Default1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head_place_holder" runat="server">
    <style>
  .bg-gradient-primary-to-secondary {
        background: linear-gradient(90deg,rgba(0, 119, 166, 1) 0%, rgba(0, 67, 138, 1) 50%, rgba(0, 119, 166, 1) 100%);
  }
  .bg-gradient-otr {
    background: radial-gradient(circle, #92d7ff 0%, #bdfffb 0%, #92d7ff 100%);
    color:#000000;
    font-size: 1.1rem;
    font-weight:500;
    line-height:1.6rem;
    text-align:justify;
  }
  .btn-otr {
    background-image: linear-gradient(to right, #003c9a 0%, #402877 50%, #002ee0 100%);
    padding:15px 30px;
    border-radius:40px;
    line-height:25px;
    background-size: 200% auto;
    font:bold 20px Arial;
    background-position: left top;
    border-color: transparent;
    color: #ffffff;
    transition: all 0.4s ease-in-out;
    animation: gradientMove 5s ease infinite;
  }
  .btn-otr:hover {
    background-position: right bottom;
    color: #fbffc7;
  }
  @keyframes gradientMove {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
  }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>

<!-- Header Section -->
<section class="bg-gradient-primary-to-secondary text-center text-white py-4">
  <h5 class="fw-bold display-7 mb-2">ONLINE LOAN APPLICATION PORTAL</h5>
  <h5 class="fw-bold">கடன் விண்ணப்ப வலைதளம்</h5>
</section>

<section class="container my-5">
   <div class="row">
       <!-- Left Section -->
       <div class="col-12 col-lg-8 mb-4 mb-lg-0">
             <div class="card h-100 border-0 shadow-sm bg-gradient-otr rounded-2">
                <div class="card-body p-4">
                  <p>
                      Indian citizens residing in Tamil Nadu who are regular or associate milk pouring members of the Milk Producers Co-operative Societies and who maintain at least one milch animal and produce milk must register using the One Time Registration facility to apply for a loan under the Dairy Farm Scheme. Click <strong>One Time Registration</strong> button to proceed.
                  </p>
                  <p>
                      தமிழ்நாட்டில் வசிக்கும் இந்திய குடிமக்களில் பால் உற்பத்தியாளர் கூட்டுறவு சங்கங்களின் வழக்கமான அல்லது இணை பால் வழங்கும் உறுப்பினர்களாகவும், குறைந்தது ஒரு கறவை மாட்டை பராமரித்து பால் உற்பத்தி செய்து வருவோரும், பால் பண்ணை திட்டத்தின் கீழ் கடனுக்கு விண்ணப்பிக்க ஒரு முறை பதிவு செய்ய வேண்டும். தொடர <strong>ஒரு முறை பதிவு</strong> என்பதைச் சொடுக்கவும்.
                  </p>
                  <div class="text-center">
                      <asp:Button ID="btn_otr" runat="server" Text="One Time Registration &#010; ஒரு முறை பதிவு" CssClass="btn btn-otr my-3" />
                  </div>
                  <p class="p-1 p-english">
                      If already registered, enter your registered mobile number, generate an OTP, and verify it to log in.
                  </p>
                  <p class="p-1 p-tamil">
                      இத்தளத்தில் ஏற்கனவே பதிவு செய்திருந்தால், பதிவுசெய்யப்பட்ட கைபேசி எண்ணை உள்ளிட்டு ஒரு முறை கடவுச்சொல்லை (OTP) பெற்று உள்நுழையவும்.
                  </p>
                </div>
             </div>
       </div>

       <!-- Right Section: Mobile OTP Login Card -->
       <div class="col-12 col-lg-4">
           <div class="card h-100 shadow-lg border-0 rounded-3">
               <div class="card-header text-center bg-gradient-primary-to-secondary text-white py-3">
                   <h6 class="mb-0">Loan Applicant OTP Login</h6>
                   <span>கடன் விண்ணப்பதாரர் OTP உள்நுழைவு</span>
               </div>
               <div class="card-body p-4">
                   <div id="errmsg" runat="server" class="alert alert-danger" visible="false"></div>
                   <div id="succmsg" runat="server" class="alert alert-success" visible="false"></div>

                   <asp:HiddenField ID="hf_otp" runat="server" />

                   <asp:MultiView ID="mv_login" runat="server" ActiveViewIndex="0">
                       <!-- STEP 1: Enter Mobile Number & Generate OTP -->
                       <asp:View ID="viewMobile" runat="server">
                           <div class="form-group mb-3">
                               <label for="<%=tb_ben_mobno.ClientID%>" class="form-label">Registered Mobile Number (கைபேசி எண்) <span class="text-danger">*</span></label>
                               <asp:TextBox ID="tb_ben_mobno" CssClass="form-control" runat="server" MaxLength="10"
                                   placeholder="10-digit Mobile Number" AutoCompleteType="Disabled"
                                   oninput="this.value = this.value.replace(/[^0-9]/g, '');"></asp:TextBox>
                               <asp:RequiredFieldValidator ID="rfv_mob" runat="server" ControlToValidate="tb_ben_mobno" ValidationGroup="vg1"
                                   ErrorMessage="Mobile number is required (கைபேசி எண்ணை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                               <asp:RegularExpressionValidator ID="rev_mob" runat="server" ControlToValidate="tb_ben_mobno" ValidationGroup="vg1"
                                   ValidationExpression="^[6-9][0-9]{9}$" ErrorMessage="Enter a valid 10-digit mobile number" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                           </div>

                           <div class="mb-3 text-center">
                               <asp:Image ID="imgCaptcha" runat="server" CssClass="img-captcha" />
                               <asp:LinkButton ID="lbtn_captcha_ref" runat="server" CssClass="btn btn-sm btn-light" CausesValidation="false"><i class="fa fa-refresh text-success"></i></asp:LinkButton>
                           </div>

                           <div class="form-group mb-3">
                               <label for="<%=tb_captcha.ClientID%>" class="form-label">Type Captcha word <span class="text-danger">*</span></label>
                               <asp:TextBox ID="tb_captcha" CssClass="form-control" runat="server" ValidationGroup="vg1"
                                   AutoCompleteType="Disabled" placeholder="Type the captcha word" MaxLength="6"></asp:TextBox>
                               <asp:RequiredFieldValidator ID="rfvc" runat="server" ControlToValidate="tb_captcha" ValidationGroup="vg1"
                                   ErrorMessage="Captcha is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                           </div>

                           <div class="mb-3">
                               <asp:Button ID="btn_gen_otp" runat="server" Text="Generate OTP (OTP பெறுக)" CssClass="btn btn-primary w-100 shadow-sm fw-bold" ValidationGroup="vg1" />
                           </div>
                       </asp:View>

                       <!-- STEP 2: Enter OTP & Sign In -->
                       <asp:View ID="viewOtp" runat="server">
                           <div class="alert alert-info py-2 small">
                               OTP sent to mobile number: <strong><asp:Label ID="lbl_masked_mob" runat="server"></asp:Label></strong>
                           </div>

                           <div class="form-group mb-3">
                               <label for="<%=tb_otp.ClientID%>" class="form-label">Enter 6-Digit OTP (OTP உள்ளிடவும்) <span class="text-danger">*</span></label>
                               <asp:TextBox ID="tb_otp" CssClass="form-control text-center fw-bold fs-5" runat="server" MaxLength="6"
                                   placeholder="Enter OTP" AutoCompleteType="Disabled"></asp:TextBox>
                               <asp:RequiredFieldValidator ID="rfv_otp" runat="server" ControlToValidate="tb_otp" ValidationGroup="vg2"
                                   ErrorMessage="OTP is required (ஒரு முறை கடவுச்சொல்லை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                           </div>

                           <div class="mb-3">
                               <asp:Button ID="btn_login" runat="server" Text="Verify & Sign In (உள்நுழைக)" CssClass="btn btn-success w-100 shadow-sm fw-bold" ValidationGroup="vg2" />
                           </div>

                           <div class="d-flex justify-content-between gap-2">
                               <asp:Button ID="btn_change_mob" runat="server" Text="Change Number" CssClass="btn btn-outline-secondary btn-sm w-50" CausesValidation="false" />
                               <asp:Button ID="btn_resend_otp" runat="server" Text="Resend OTP" CssClass="btn btn-outline-primary btn-sm w-50" CausesValidation="false" />
                           </div>
                       </asp:View>
                   </asp:MultiView>

               </div>
           </div>
       </div>
   </div>
</section>

</ContentTemplate>
</asp:UpdatePanel>

<asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
<ProgressTemplate>
    <div class="progress_modal">
        <div class="progress_center">
             <div class="loader">
                 <div class="loader-inner"><div class="loading one"></div></div>
                 <div class="loader-inner"><div class="loading two"></div></div>
                 <div class="loader-inner"><div class="loading three"></div></div>
                 <div class="loader-inner"><div class="loading four"></div></div>
             </div>
        </div>
    </div>
</ProgressTemplate>
</asp:UpdateProgress>
</asp:Content>