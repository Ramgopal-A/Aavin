<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ZMASTEREN.Master" CodeBehind="FORGETPASS.aspx.vb" Inherits="MINIDAIRY.FORGETPASS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head_place_holder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" >
<ContentTemplate>
<div class="bg-gradient-primary-to-secondary p-3 text-center">
   <p style="font-size:20px; color:#FFFFFF; font-weight:600; padding-bottom:5px;">
       Loan Applicant Password Reset Form
   </p> 

   <p style="font-size:18px; color:#FFFFFF; font-weight:600;">
        கடன் விண்ணப்பதாரர் கடவுச்சொல் மீட்டமைப்பு படிவம்
   </p>
</div>



<div class="container mt-5 mb-5">



<div class="card">
<div class="card-body">

<div id="errmsg" runat="server" class="alert alert-danger"></div>

    <asp:MultiView ID="MultiView1" runat="server">
    <asp:View ID="View1" runat="server">

           <asp:HiddenField ID="hf_otp" runat="server" />
           <asp:HiddenField ID="hf_ben_id" runat="server" />
                  <table class="table table-borderless lh-lg">
        <tr><td class="text-justify" style="text-align:justify;">
            The loan applicant those who have forgotten password are asked to submit your beneficiary ID (or) mobile number to get one time password in your registered mobile number to reset your password. <br />
            கடவுச் சொல்லை மறந்துவிட்ட கடன் விண்ணப்பதாரர்கள், கடவுச்சொல்லை மீட்டமைப்பதற்கான  பதிவுசெய்யப்பட்ட கைபேசியில்  ஒரு முறை கடவுச்சொல்லைப் பெற உங்கள் பயனாளி அடையாள எண்  (அல்லது) கைபேசி எண்ணைச் சமர்ப்பிக்குமாறு கேட்டுக் கொள்ளப்படுகிறார்கள்.
        </td>
        </tr>
        </table>
           <div class="mb-3">
           <label for="<%=tb_ben_det.ClientID%>" class="form-label">Beneficiary ID / Mobile Number (பயனாளி அடையாள எண் / கைபேசி எண்) <span class="form-mandatory">*</span></label>
           <asp:TextBox ID="tb_ben_det" CssClass="form-control" runat="server" Maxlength="10"  ValidationGroup="vg2" AutoCompleteType="Disabled" placeholder="Enter Beneficiary ID / Mobile Number. (பயனாளி அடையாள எண் / கைபேசி எண்ணை பதிவிடவும்.)"></asp:TextBox>
           <asp:RequiredFieldValidator ID="rfv5" runat="server" ControlToValidate="tb_ben_det" ValidationGroup="vg2" ErrorMessage="Mobile number is required (பயனாளியின் கைபேசி எண்ணை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
           </div>
        <div class="w-100 text-center">
           <div class="btn-group">
            <asp:Button ID="btn_bendetails" runat="server" Text="Submit  &#010; சமர்ப்பிக்கவும்" CssClass="btn btn-primary" ValidationGroup="vg2" />
           </div>
        </div>
    </asp:View>
    <asp:View ID="View2" runat="server">
        <table class="table table-bordered">
        <tr>
            <td style="width:200px;">Beneficiary ID</td>
            <td><asp:Label ID="lbl_ben_tabid" runat="server" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td style="width:200px;">Beneficiary Name</td>
            <td><asp:Label ID="lbl_ben_name" runat="server" Text="Label"></asp:Label></td>
        </tr>
        <tr>
            <td style="width:200px;">Mobile Number</td>
            <td><asp:Label ID="lbl_mob_no" runat="server" Text="Label"></asp:Label></td>
        </tr>
        </table>


        <asp:MultiView ID="MultiView2" runat="server">

        <asp:View ID="View3" runat="server">
            <table class="table table-borderless lh-lg">
            <tr><td class="text-justify" style="text-align:justify;">
            Click on <b>Send One Time Password</b> button to get one time password in the following mobile number. You are asked not to share the one time password to anyone. <br />
            பின்வரும் கைபேசியில் ஒரு முறை கடவுச்சொல்லைப் பெற <b>Send One Time Password</b> பொத்தானைக் கிளிக் செய்யவும். ஒரு முறை கடவுச்சொல்லை யாருடனும் பகிர வேண்டாம் என்று கேட்டுக் கொள்ளப்படுகிறீர்கள்.        </td>
            </tr>
            </table>
            <div class="w-100 text-center m-4">
            <div class="btn-group">
            <asp:Button ID="btn_gen_otp" runat="server" Text="Send One Time Password (OTP) &#010; ஒரு முறை கடவுச்சொல்லை அனுப்புக" CssClass="btn btn-primary" ValidationGroup="vg3" />
            </div>
            </div>
        </asp:View>
        <asp:View ID="View4" runat="server">
        <table class="table table-borderless lh-lg">
        <tr><td class="text-justify" style="text-align:justify;">
        Enter the one time password received in your mobile and click on <b>Verify OTP</b> button. If you have not received OTP, click on <b>Resend OTP</b>. You are advised not to share the one time password to anyone.  <br />
        உங்கள் கைபேசியில் பெறப்பட்ட ஒரு முறை கடவுச்சொல்லை உள்ளிட்டு <b>Verify OTP</b> பொத்தானைக் கிளிக் செய்யவும். நீங்கள் OTP பெறவில்லை என்றால், <b>Resend OTP</b> பொத்தானைக் கிளிக் செய்யவும். ஒரு முறை கடவுச்சொல்லை யாரிடமும் பகிர வேண்டாம் என அறிவுறுத்தப்பட்டுள்ளது.  </td>
        </tr>
        </table>
       <div class="mb-3">
       <label for="<%=tb_mobile_otp.ClientID%>" class="form-label">One time password (OTP) received via Mobile (கைப்பேசி மூலம் பெறப்பட்ட ஒரு முறை கடவுச்சொல்) <span class="form-mandatory">*</span></label>
       <asp:TextBox ID="tb_mobile_otp" CssClass="form-control" runat="server" MaxLength="6" AutoCompleteType="Disabled" placeholder="Enter one time password (ஒரு முறை கடவுச்சொல்லை உள்ளிடவும்)"></asp:TextBox>
       <asp:RequiredFieldValidator ID="rfv8" runat="server" ControlToValidate="tb_mobile_otp" ValidationGroup="vg4" ErrorMessage="OTP is required (ஒரு முறை கடவுச்சொல்லை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
       </div>
       <div class="w-100 text-center m-4">
             <div class="btn-group">
 <asp:Button ID="btn_otp_resend" runat="server" Text="Resend OTP &#010; மீண்டும் அனுப்பவும்" CssClass="btn btn-danger" /> 
 <asp:Button ID="btn_otp_verify" runat="server" Text="Verify OTP &#010; சரிபார்க்கவும்" CssClass="btn btn-success" ValidationGroup="vg4" />
              </div>
             </div>
        </asp:View>

       <asp:View ID="View5" runat="server">
                <table class="table table-borderless lh-lg">
        <tr><td class="text-justify" style="text-align:justify;">
         Enter new password to reset the forget old password and verify your new password by retyping it. You are advised not to share the password with anyone. <br />
         மறந்துவிட்ட பழைய கடவுச்சொல்லை மீட்டமைக்க புதிய கடவுச்சொல்லை உள்ளிடவும், அதை மீண்டும் தட்டச்சு செய்வதன் மூலம் உங்கள் புதிய கடவுச்சொல்லை சரிபார்க்கவும். கடவுச்சொல்லை யாருடனும் பகிர வேண்டாம் என அறிவுறுத்தப்பட்டுள்ளது.        </tr>
        </table>
         <div class="mb-3">
             <label for="<%=tb_pass.ClientID%>" class="form-label">Beneficiary Login password (பயனாளி உள்நுழைவுக்கான கடவுச்சொல்) <span class="form-mandatory">*</span></label>
             <asp:TextBox ID="tb_pass" CssClass="form-control" runat="server" TextMode="Password" ValidationGroup="vg5" AutoCompleteType="Disabled" MaxLength="15"></asp:TextBox>
             <asp:RequiredFieldValidator ID="rfv9" runat="server" ControlToValidate="tb_pass" ValidationGroup="vg5" ErrorMessage="Password is required (கடவுச்சொல்லை பதிவிடு)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
  <asp:RegularExpressionValidator 
                ID="rev_pass" 
                runat="server" 
                ControlToValidate="tb_pass"
                ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
                ErrorMessage="Password must be at least 8 characters long and contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character."
                ValidationGroup="vg5"
                ForeColor="Red" Display="Dynamic">
                </asp:RegularExpressionValidator>
             </div>
          <div class="mb-3">
              <label for="<%=tb_pass_repeat.ClientID%>" class="form-label">Retype Login password (கடவுச்சொல்லை மீண்டும் உள்ளிடுக.) <span class="form-mandatory">*</span></label>
              <asp:TextBox ID="tb_pass_repeat" CssClass="form-control" runat="server" TextMode="Password" ValidationGroup="vg5" AutoCompleteType="Disabled"  MaxLength="15"></asp:TextBox>
              <asp:RequiredFieldValidator ID="rfv10" runat="server" ControlToValidate="tb_pass_repeat" ValidationGroup="vg5" ErrorMessage="Password is required (கடவுச்சொல்லை மீண்டும் பதிவிடு)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
              <asp:CompareValidator id="val_pass" runat="server" ControlToCompare="tb_pass" ControlToValidate="tb_pass_repeat" ErrorMessage="Your passwords do not match up! (உங்கள் கடவுச்சொற்கள் பொருந்தவில்லை)"  Display="Dynamic" ForeColor="Red" ValidationGroup="vg5" />
          </div>

          <div class="w-100 text-center m-4">
            <asp:Button ID="btn_complete" runat="server" Text="Complete Registration (பதிவை நிறைவு செய்யவும்)" CssClass="btn btn-success" ValidationGroup="vg5" />
        </div>
        </asp:View>
        </asp:MultiView>


        </asp:View>
        <asp:View ID="View6" runat="server">
            <div class="card m-5 border-success">
                <div class="card-header bg-success text-center" style="color:#ffffff; line-height:40px; font-size:20px;">
                    <i class="fa fa-check-circle" style="font-size:50px;"></i>
                    <br />
                    Success !
                </div>
                <div class="card-body p-5" style="font-size:18px;">
                    <ul>
 <li>
		                    You have changed your Mini Dairy Scheme loan application web portal login password succeessfully. <br />
		                    உங்கள் சிறு பால் பண்ணை கடன் விண்ணப்பத்தின் இணையதள உள்நுழைவு கடவுச்சொல்லை மாற்றியுள்ளீர்கள்.
		                </li>
 <li>
		                    You can login by click the following link.<br/>
		                    பின்வரும் இணைப்பைக் கிளிக் செய்வதன் மூலம் நீங்கள் உள்நுழையலாம்.
  </li>
                    </ul>
                    <div class="w-100 text-center m-3">
 <asp:LinkButton ID="lbtn" runat="server" PostBackUrl="~/ONLINE" CssClass="btn btn-success rounded-bg-opacity-25 pl-3 pr-3">Go to sign-in page <br /> உள்நுழைவு பக்கத்திற்குச் செல்லவும் </asp:LinkButton>
                    </div>
                </div>
            </div>
        </asp:View>
    </asp:MultiView>

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
