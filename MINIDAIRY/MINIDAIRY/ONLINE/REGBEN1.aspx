<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ZMASTEREN.Master" CodeBehind="REGBEN1.aspx.vb" Inherits="MINIDAIRY.REGBEN1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head_place_holder" runat="server">
<style>
    @media (max-width: 576px) {
        .btn-group {
            display: flex;
            flex-direction: column;
            width: 100%;
        }
        .btn-group .btn {
            width: 100%;
            margin-bottom: 5px;
        }
    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" >
<ContentTemplate>
<section class="bg-gradient-primary-to-secondary text-center text-white py-4">
  <h5 class="fw-bold display-7 mb-2">Loan Applicant One Time Registration - Step 1</h5>
  <h5 class="fw-bold">கடன் விண்ணப்பதாரர் ஒருமுறைப் பதிவு - Step 1</h5>
</section>
   
<div class="container mt-5 mb-5">


<div class="card">

<div class="card-body">


<div id="errmsg" runat="server" class="alert alert-danger"></div>

<asp:MultiView ID="MultiView1" runat="server">
    <asp:View ID="View0" runat="server">
        <div class="w-100 text-center">
          <p style="color:#00207d; font:bold 16px verdana; line-height:25px;">  GUIDELINES FOR USE OF ONE TIME REGISTRATION  FACILITY<br /> 
            ஒரு முறை பதிவு வசதியைப் பயன்படுத்துவதற்கான வழிகாட்டுதல்கள்</p>

        </div>
        <table class="table table-borderless lh-lg">
            <tr><td>1.</td><td class="text-justify" style="text-align:justify;">
            This web portal can be used only by Indian citizens residing in Tamil Nadu who are regular or associate milk pouring members of the Milk Producers Co-operative Societies. <br />
            இந்த இணைய தளத்தை தமிழ்நாட்டில் வசிக்கும் இந்திய குடிமக்களும் பால் உற்பத்தியாளர் கூட்டுறவு சங்கங்களின் வழக்கமான அல்லது இணை பால் வழங்கும் உறுப்பினர்களும் மட்டுமே பயன்படுத்த முடியும்.
            </td></tr>
            <tr><td>2.</td><td class="text-justify" style="text-align:justify;">
           The applicant should be above 21 years and below 60 years of age. Only one person from a family can submit a loan application. The applicant should currently maintain at least one milch animal and be producing milk.<br />
            விண்ணப்பதாரர் 21 வயதுக்கு மேற்பட்டவராகவும் 60 வயதுக்கு உட்பட்டவராகவும் இருக்க வேண்டும். ஒரு குடும்பத்தில் ஒருவர் மட்டுமே கடன் விண்ணப்பத்தை சமர்ப்பிக்க முடியும். விண்ணப்பதாரர் தற்போது குறைந்தது ஒரு கறவை மாட்டை பராமரித்து பால் உற்பத்தி செய்து கொண்டிருக்க வேண்டும்.
            </td></tr>
            <tr><td>3.</td><td class="text-justify" style="text-align:justify;">
            The one-time registration consists of two steps and must be completed within 30 minutes. Before starting the application process, the applicant should have the following information ready.<br />
            ஒருமுறை பதிவு செய்முறை இரண்டு படிகளாக நடைபெறும் மற்றும் 30 நிமிடங்களுக்குள் முடிக்கப்பட வேண்டும். விண்ணப்ப செயல்முறையை தொடங்கும் முன், விண்ணப்பதாரர் பின்வரும் தகவல்களை தயார் வைத்திருக்க வேண்டும்.
            </td></tr>
            <tr><td>4.</td><td class="text-justify" style="text-align:justify;">
            <strong>Step 1 : </strong>Applicant can start one time registration by clicking "Continue one time registration" button. Applicant should enter his/her name, date of birth, communal cateogry, mobile number, aadhar 
            number and new family smart card number. After submitting the data, beneficiary will receive 
            one time password (OTP) in his/her mobile as SMS. Applicant has to verify OTP and proceed to the final step.
             <br />
            <strong>படி 1: </strong>விண்ணப்பதாரர் "ஒரு முறை பதிவைத் தொடரவும்" பொத்தானை அழுத்துவதன் மூலம் ஒரு முறை பதிவைத் தொடங்கலாம். விண்ணப்பதாரர் தனது பெயர், பிறந்த தேதி, வகுப்பு, கைபேசி எண், ஆதார் எண் மற்றும் புதிய குடும்ப ஸ்மார்ட் கார்டு எண்ணை உள்ளிட வேண்டும். தரவைச் சமர்ப்பித்த பிறகு, பயனாளி தனது கைபேசியில் ஒரு முறை கடவுச்சொல்லை (OTP-ஐ) SMS ஆகப் பெறுவார். விண்ணப்பதாரர் OTP-ஐச் சரிபார்த்து இறுதிப் படிக்குச் செல்ல வேண்டும்.
            </td></tr>
            <tr><td>5.</td><td class="text-justify" style="text-align:justify;">
           <strong>Step 2: </strong>The applicant must enter personal details (PAN number and community certificate number), address as per Aadhaar, current address, and bank account details to complete the one-time registration process.
             <br />
            <strong>படி 2: </strong>விண்ணப்பதாரர் ஒரு முறை பதிவு செயல்முறையை முடிக்க தனிப்பட்ட விவரங்கள் (நிரந்தர கணக்கு எண் மற்றும் சமூக சான்றிதழ் எண் போன்றவை), ஆதார் படி முகவரி, தற்போதைய முகவரி மற்றும் வங்கி கணக்கு விவரங்களை உள்ளிட வேண்டும்.
            </td></tr>
        </table>
        <div class="w-bg-opacity-100 text-center">
            <asp:Button ID="btn_step1_next" runat="server" Text="Continue one time registration &#010; (ஒரு முறை பதிவைத் தொடரவும்)" CssClass="btn btn-primary" />
        </div>
        </asp:View>

         <asp:View ID="View1" runat="server">

         <asp:HiddenField ID="hf_otp" runat="server" />
           <div class="mb-3">
         <label for="<%=tb_ben_name.ClientID%>" class="form-label">Applicant's Name as per aadhar identity <br /> (ஆதார் அட்டையிலுள்ளது போல் விண்ணப்பதாரரின் பெயர்) <span class="form-mandatory">*</span></label>
          <div class="row m-0 p-0">
          <div class="col-sm-12 col-md-2 col-lg-2 m-0 p-0">
                <asp:DropDownList ID="dd_salutation" runat="server" CssClass="form-select" ValidationGroup="vg2">
                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Mr." Value="1"></asp:ListItem>
                    <asp:ListItem Text="Ms." Value="2"></asp:ListItem>
                    <asp:ListItem Text="Mrs." Value="3"></asp:ListItem>
                </asp:DropDownList>
           </div>
            <div class="col-sm-12 col-md-10 col-lg-10 m-0 p-0">
                <asp:TextBox ID="tb_ben_name" CssClass="form-control" runat="server" MaxLength="250" ValidationGroup="vg2" AutoCompleteType="Disabled" oninput="this.value = this.value.replace(/[^a-zA-Z\s]/g, '');" ></asp:TextBox>
            </div>
            </div>
            <asp:RequiredFieldValidator ID="rfv1" runat="server" InitialValue="0" ControlToValidate="dd_salutation" ValidationGroup="vg2" ErrorMessage="Select Salutation (திரு / திருவாளர் தேர்வு செய்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="tb_ben_name" ValidationGroup="vg2" ErrorMessage="Name is required (பெயரை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
           <div class="mb-3">
               <div class="row">
                   <div class="col-sm-12 col-md-6 col-md-6">
<label for="<%=tb_ben_dob.ClientID%>" class="form-label">Date of Birth <br /> (பிறந்த தேதி) <span class="form-mandatory">*</span></label>
<asp:TextBox ID="tb_ben_dob" CssClass="form-control" runat="server" placeholder="DD-MM-YYYY" ValidationGroup="vg2"  TextMode="Date"   AutoCompleteType="Disabled"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfv3" runat="server" ControlToValidate="tb_ben_dob" ValidationGroup="vg2" ErrorMessage="DOB is required (பிறந்த தேதியை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                   </div>
                   <div class="col-sm-12 col-md-6 col-md-6">
<label for="<%=dd_ben_caste_cat.ClientID%>" class="form-label">Communal Category <br /> (வகுப்பு) <span class="form-mandatory">*</span></label>
 <asp:DropDownList ID="dd_ben_caste_cat" runat="server" CssClass="form-select" ValidationGroup="vg2">
 </asp:DropDownList>
 <asp:RequiredFieldValidator ID="rfv4" runat="server" ControlToValidate="dd_ben_caste_cat" InitialValue="0" ValidationGroup="vg2" ErrorMessage="Select caste (வகுப்பை தேர்வு செய்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                   </div>
               </div>

           </div>


           <div class="mb-3">
           <label for="<%=tb_ben_mobno.ClientID%>" class="form-label">Applicant's Mobile Number <br /> (விண்ணப்பதாரரின் கைபேசி எண்) <span class="form-mandatory">*</span></label>
           <asp:TextBox ID="tb_ben_mobno" CssClass="form-control" runat="server" Maxlength="10" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..?)\../g, '$1');" ValidationGroup="vg2" AutoCompleteType="Disabled" ></asp:TextBox>
           <asp:RequiredFieldValidator ID="rfv5" runat="server" ControlToValidate="tb_ben_mobno" ValidationGroup="vg2" ErrorMessage="Mobile number is required (பயனாளியின் கைபேசி எண்ணை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
           <asp:RegularExpressionValidator ID="rev3" ControlToValidate="tb_ben_mobno" ValidationGroup="vg2"  ValidationExpression = "^[\s\S]{10,10}$" runat="server" ErrorMessage="Mobile number should be 10 digit. (10 இலக்க கைபேசி எண்ணை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator> 
           <asp:RegularExpressionValidator ID="rev31" ControlToValidate="tb_ben_mobno" ValidationGroup="vg2"  ValidationExpression = "^[6-9][0-9]*$$" runat="server" ErrorMessage="Mobile mumber should not start with 0 or 1 or 2 or 3 or 4 or 5" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator> 
           </div>

            <!-- Aadhar Number Entry -->
            <div class="mb-3">
                <div class="row">
                    <div class="col-sm-12 col-md-6 col-lg-6">
 <label class="form-label">Applicant's Aadhar Number <br /> (ஆதார் எண்) <span class="form-mandatory">*</span></label>
 <div class="input-group">
     <asp:TextBox ID="tb_ben_aadhar" runat="server" CssClass="form-control" MaxLength="12" TextMode="Password" oninput="this.value = this.value.replace(/[^0-9]/g, '')" AutoCompleteType="Disabled" ValidationGroup="vg2" oncopy="return false;"  oncut="return false;"  onpaste="return false;" oncontextmenu="return false;" />
     <button class="btn btn-outline-secondary" type="button" onclick="toggleVisibility('tb_ben_aadhar')">
         <i class="fa fa-eye" id="eye_tb_ben_aadhar"></i>
     </button>
 </div>
 <asp:RequiredFieldValidator ID="rfv6" runat="server" ControlToValidate="tb_ben_aadhar" ValidationGroup="vg2" ErrorMessage="Enter Aadhar number" Display="Dynamic" ForeColor="Red" />
 <asp:RegularExpressionValidator ID="rev1" runat="server" ControlToValidate="tb_ben_aadhar" ValidationExpression="^\d{12}$" ErrorMessage="Invalid Aadhar number" Display="Dynamic" ForeColor="Red" ValidationGroup="vg2" />
 <asp:RegularExpressionValidator ID="rev11" runat="server" ControlToValidate="tb_ben_aadhar" ValidationExpression="^[2-9][0-9]*$" ErrorMessage="Aadhar number Should not start with 0/1." Display="Dynamic" ForeColor="Red" ValidationGroup="vg2" />
                    </div>
                    <div class="col-sm-12 col-md-6 col-lg-6">
 <label class="form-label">Re-enter Aadhar Number <br /> (ஆதார் எண் மீண்டும் உள்ளிடவும்) <span class="form-mandatory">*</span></label>
 <asp:TextBox ID="tb_ben_aadhar_confirm" runat="server" CssClass="form-control" TextMode="Password" MaxLength="12" oninput="this.value = this.value.replace(/[^0-9]/g, '')" AutoCompleteType="Disabled" ValidationGroup="vg2" oncopy="return false;"  oncut="return false;"  onpaste="return false;" oncontextmenu="return false;" />
 <asp:RequiredFieldValidator ID="rfv6c" runat="server" ControlToValidate="tb_ben_aadhar_confirm" ValidationGroup="vg2" ErrorMessage="Re-enter Aadhar" Display="Dynamic" ForeColor="Red" />
 <asp:CompareValidator id="cv2" runat="server" ControlToCompare="tb_ben_aadhar" ControlToValidate="tb_ben_aadhar_confirm" ErrorMessage="Aadhar do not match up! (ஆதார் எண் பொருந்தவில்லை)"  Display="Dynamic" ForeColor="Red" ValidationGroup="vg2" />
                    </div>
                </div>
            </div>

            <!-- Smart Card Number Entry -->
            <div class="mb-3">
                <div class="row">
                    <div class="col-sm-12 col-md-6 col-lg-6">
 <label class="form-label">Smart Family Card Number <br /> (புதிய குடும்ப அட்டை எண்) <span class="form-mandatory">*</span></label>
 <asp:TextBox ID="tb_ben_smartcard" runat="server" CssClass="form-control" AutoCompleteType="Disabled" ValidationGroup="vg2"  />
 <asp:RequiredFieldValidator ID="rfv7" runat="server" ControlToValidate="tb_ben_smartcard" ValidationGroup="vg2" ErrorMessage="Enter Smart Card number" Display="Dynamic" ForeColor="Red" />
                    </div>
                    <div class="col-sm-12 col-md-6 col-lg-6">
 <label class="form-label">Re-enter Smart Family Card Number <br /> (புதிய குடும்ப அட்டை எண் மீண்டும் உள்ளிடவும்)  <span class="form-mandatory">*</span></label>
 <asp:TextBox ID="tb_ben_smartcard_confirm" runat="server" CssClass="form-control" AutoCompleteType="Disabled" ValidationGroup="vg2"  />
 <asp:RequiredFieldValidator ID="rfv7c" runat="server" ControlToValidate="tb_ben_smartcard_confirm" ValidationGroup="vg2" ErrorMessage="Re-enter Smart Card number" Display="Dynamic" ForeColor="Red" />
 <asp:CompareValidator id="cv3" runat="server" ControlToCompare="tb_ben_smartcard" ControlToValidate="tb_ben_smartcard_confirm" ErrorMessage="Smart Family Card No. do not match up! (குடும்ப அட்டை எண் பொருந்தவில்லை)"  Display="Dynamic" ForeColor="Red" ValidationGroup="vg2" />

                    </div>
                </div>
            </div>

            <div class="w-100 text-center mt-4 mb-4">
                <div class="btn-group gap-0 m-0 p-0">
                <asp:Button ID="btn_step_prev" runat="server" Text="Go Back &#010; (பின் செல்க)" CssClass="btn btn-danger m-0" />
                <asp:Button ID="btn_gen_otp" runat="server" Text="Send OTP to Mobile No. &#010; (ஒரு முறை கடவுச்சொல்லை கைபேசிக்கு அனுப்பவும்.)" CssClass="btn btn-success m-0" ValidationGroup="vg2" />
                </div>
            </div>


    


     </asp:View>

    <asp:View ID="View2" runat="server">
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-gradient-primary-to-secondary text-white fw-bold text-center px-3">
            Applicant Basic Details
        </div>
        <div class="card-body p-4">
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle text-center">
                    <thead class="table-light">
 <tr>
     <th>Name of the applicant <br /><small class="text-muted">விண்ணப்பதாரர் பெயர்</small></th>
     <th>Date of birth and age<br /><small class="text-muted">பிறந்த தேதி மற்றும் வயது</small></th>
     <th>Communal Category <br /><small class="text-muted">வகுப்பு</small></th>
 </tr>
                    </thead>
                    <tbody>
 <tr>
     <td class="fw-bold">
         <asp:Label ID="lbl_salutation" runat="server" CssClass="me-1 text-primary fw-semibold" />
         <asp:Label ID="lbl_ben_name" runat="server" CssClass="text-primary fw-semibold" />
     </td>
     <td class="fw-bold">
         <asp:Label ID="lbl_dob" runat="server" CssClass="me-1 text-primary fw-semibold" />
         (Age : <asp:Label ID="lbl_age" runat="server" CssClass="text-success fw-semibold" />)
     </td>
     <td class="fw-bold">
         <asp:Label ID="lbl_caste_cat" runat="server" CssClass="text-primary fw-semibold" />
     </td>
 </tr>
                    </tbody>
                </table>
            </div>

            <div class="table-responsive">
    <table class="table table-bordered table-hover align-middle text-center">
        <thead class="table-light">
            <tr>
                <th>Applicant's mobile Number <br /><small class="text-muted">விண்ணப்பதாரரின் கைபேசி எண்</small></th>
                <th>Applicant's aadhar Number <br /><small class="text-muted">விண்ணப்பதாரரின் ஆதார் எண்</small></th>
                <th>Applicant's new family smart card No. <br /><small class="text-muted">விண்ணப்பதாரரின் புதிய குடும்ப மின்னனு அட்டை எண்</small></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="fw-bold text-primary">
                    <asp:Label ID="lbl_mobno" runat="server" CssClass="fw-semibold" />
                </td>
                <td class="fw-bold text-danger">
                    <asp:Label ID="lbl_aadhar" runat="server" CssClass="fw-semibold" />
                </td>
                <td class="fw-bold text-danger">
                    <asp:Label ID="lbl_smartcard" runat="server" CssClass="fw-semibold" />
                </td>
            </tr>
        </tbody>
    </table>
</div>
        </div>
    </div>

    
    <div class="card shadow-lg rounded-4 border-0">
        <div class="card-body p-4">

            <div class="mb-3">
                <label for="<%=tb_mobile_otp.ClientID%>" class="form-label fw-bold">
                    <i class="bi bi-shield-lock-fill me-2"></i>One Time Password (OTP) received via Mobile
                    <br><small class="text-muted">(கைப்பேசி மூலம் பெறப்பட்ட ஒரு முறை கடவுச்சொல்)</small>
                    <span class="text-danger ms-1">*</span>
                </label>

                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fa fa-mobile-phone text-success"></i></span>
                    <asp:TextBox ID="tb_mobile_otp" runat="server" CssClass="form-control" MaxLength="6" AutoCompleteType="Disabled" oninput="this.value = this.value.replace(/[^A-Z0-9]/g, '')" ValidationGroup="vg4" ></asp:TextBox>
                </div>

                <asp:RequiredFieldValidator ID="rfv8" runat="server" ControlToValidate="tb_mobile_otp" ValidationGroup="vg4" 
                    ErrorMessage="OTP is required (ஒரு முறை கடவுச்சொல்லை உள்ளிடவும்)" Display="Dynamic" 
                    CssClass="text-danger"></asp:RequiredFieldValidator>
            </div>

            <div class="text-center mt-4">
                <div class="btn-group" role="group" aria-label="OTP Actions">
                    <asp:Button ID="btn_otp_resend" runat="server" Text="Resend OTP (மீண்டும் அனுப்பவும்)" CssClass="btn btn-primary px-4" />
                    <asp:Button ID="btn_otp_verify" runat="server" Text="Verify OTP (சரிபார்க்கவும்)" CssClass="btn btn-success px-4" ValidationGroup="vg4" />
                </div>
            </div>
        </div>
    </div>

    </asp:View>

</asp:MultiView>

</div>
</div>


    <script>
        function toggleVisibility(id) {
            const input = document.getElementById('<%= tb_ben_aadhar.ClientID %>');
              const icon = document.getElementById('eye_tb_ben_aadhar');
              if (input.type === "password") {
                  input.type = "text";
                  icon.classList.remove("fa-eye");
                  icon.classList.add("fa-eye-slash");
              } else {
                  input.type = "password";
                  icon.classList.remove("fa-eye-slash");
                  icon.classList.add("fa-eye");
              }
          }

    </script>

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
