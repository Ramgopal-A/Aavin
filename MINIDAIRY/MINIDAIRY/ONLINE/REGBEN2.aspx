<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ZMASTEREN.Master" CodeBehind="REGBEN2.aspx.vb" Inherits="MINIDAIRY.REGBEN2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head_place_holder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>

<section class="bg-gradient-primary-to-secondary text-center text-white py-4">
  <h5 class="fw-bold display-7 mb-2">Loan Applicant One Time Registration - Step 2</h5>
  <h5 class="fw-bold">கடன் விண்ணப்பதாரர் ஒருமுறைப் பதிவு - Step 2</h5>
</section>

<div class="container mt-5 mb-5">

<div id="errmsg" runat="server" class="alert alert-danger"></div>

        <div class="card shadow-sm border-0 mb-4 p-0">
        <div class="card-header bg-gradient-primary-to-secondary text-white fw-bold fs-5 text-center px-3">
            Applicant Basic Details (விண்ணப்பதாரரின் அடிப்படை விவரங்கள்)
        </div>
        <div class="card-body p-0">
            <div class="table-responsive m-0">
                <table class="table table-bordered table-hover align-middle text-center m-0">
                    <tbody>
 <tr class="bg-light">
     <td>Name of the applicant <br /><small class="text-muted">விண்ணப்பதாரர் பெயர்</small></td>
     <td>Date of birth and age<br /><small class="text-muted">பிறந்த தேதி மற்றும் வயது</small></td>
     <td>Communal Category <br /><small class="text-muted">வகுப்பு</small></td>
 </tr>
 <tr>
     <td class="fw-bold">
         <asp:Label ID="lbl_salutation" runat="server" CssClass="me-1 text-primary fw-semibold" />
         <asp:Label ID="lbl_ben_name" runat="server" CssClass="text-primary fw-semibold" />
     </td>
     <td class="fw-bold">
         <asp:Label ID="lbl_dob" runat="server" CssClass="me-1 text-primary fw-semibold" /> 
        (Age : <asp:Label ID="lbl_age" runat="server" CssClass="text-success fw-semibold" /> )
     </td>
     <td class="fw-bold">
         <asp:Label ID="lbl_caste_cat" runat="server" CssClass="text-primary fw-semibold" />
     </td>
 </tr>
 <tr>
     <td>Applicant's mobile Number <br /><small class="text-muted">விண்ணப்பதாரரின் கைபேசி எண்</small></td>
     <td>Applicant's aadhar Number <br /><small class="text-muted">விண்ணப்பதாரரின் ஆதார் எண்</small></td>
     <td>Applicant's new family smart card No. <br /><small class="text-muted">விண்ணப்பதாரரின் புதிய குடும்ப மின்னனு அட்டை எண்</small></td>
 </tr>
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

        <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-gradient-primary-to-secondary text-white text-center fw-bold px-3">
            Applicant Personal Details (விண்ணப்பதாரரின் தனிப்பட்ட விவரங்கள்)
        </div>
        <div class="card-body p-4">
            <div class="mb-3">
             <label for="<%=tb_ben_fh_name.ClientID%>" class="form-label">Father's / Husband's Name <br /> (தகப்பனார் / கணவர் பெயர்) <span class="form-mandatory">*</span></label>
              <div class="row">
              <div class="col-sm-12 col-md-1 col-lg-1">
                    <asp:DropDownList ID="dd_care_of" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1">
 <asp:ListItem Text="Select" Value="0"></asp:ListItem>
 <asp:ListItem Text="S/o" Value="1"></asp:ListItem>
 <asp:ListItem Text="D/o" Value="2"></asp:ListItem>
 <asp:ListItem Text="W/o" Value="3"></asp:ListItem>
                    </asp:DropDownList>
               </div>
                <div class="col-sm-12 col-md-11 col-lg-11">
                    <asp:TextBox ID="tb_ben_fh_name" CssClass="form-control form-control-sm" runat="server" MaxLength="250" ValidationGroup="vg1"></asp:TextBox>
                </div>
                </div>
                <asp:RequiredFieldValidator ID="rfv1" runat="server" InitialValue="0" ControlToValidate="dd_care_of" ValidationGroup="vg1" ErrorMessage="Select Care taker (பெயரை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="tb_ben_fh_name" ValidationGroup="vg1" ErrorMessage="Name is required (பெயரை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>

            <div class="mb-3">
                <div class="row">
                 <div class="col-sm-12 col-md-3 col-lg-3">
                     <label for="<%=dd_ben_gen.ClientID%>" class="form-label">Gender<br /> (பாலினம்) <span class="form-mandatory">*</span></label>
                    <asp:DropDownList ID="dd_ben_gen" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1">
 <asp:ListItem Text="Select Gender" Value="0"></asp:ListItem>
 <asp:ListItem Text="Male - ஆண்" Value="1"></asp:ListItem>
 <asp:ListItem Text="Female - பெண்" Value="2"></asp:ListItem>
 <asp:ListItem Text="Transgender - திருநங்கை" Value="3"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfv3" runat="server" ControlToValidate="dd_ben_gen" InitialValue="0" ValidationGroup="vg1" ErrorMessage="Select Gender (பாலினத்தை தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>  
                 </div>
                <div class="col-sm-12 col-md-3 col-lg-3">
                    <label for="<%=dd_ben_rel.ClientID%>" class="form-label">Religion<br /> (மதம்) <span class="form-mandatory">*</span></label>
                    <asp:DropDownList ID="dd_ben_rel" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1">
 <asp:ListItem Text="Select Religion" Value="0"></asp:ListItem>
 <asp:ListItem Text="Hindu - இந்து" Value="1"></asp:ListItem>
 <asp:ListItem Text="Christian - கிறிஸ்துவர்" Value="2"></asp:ListItem>
 <asp:ListItem Text="Muslim - இஸ்லாமியர்" Value="3"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfv4" runat="server" ControlToValidate="dd_ben_rel" InitialValue="0" ValidationGroup="vg1" ErrorMessage="Select Religion (மதத்தைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 </div>
                 <div class="col-sm-12 col-md-6 col-lg-6">
                  <label for="<%=dd_ben_caste.ClientID%>" class="form-label">Caste <br /> (சாதி உட்பிரிவு) <span class="form-mandatory">*</span></label>
                  <asp:DropDownList ID="dd_ben_caste" runat="server" CssClass="form-select form-select-sm select2" ValidationGroup="vg1"></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="rfv5" runat="server" InitialValue="0" ControlToValidate="dd_ben_caste" ValidationGroup="vg1" ErrorMessage="Select Caste (சாதி உட்பிரிவு தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 </div>
                </div>
            </div>

            <div class="mb-3">
              <div class="row">
                 <div class="col-sm-12 col-md-4 col-lg-4">
                    <label for="<%=tb_ben_comm_cer_no.ClientID%>" class="form-label">Community Certificate Number <br />(சாதிச் சான்றிதழ் எண்) <span class="form-mandatory">*</span></label>
                    <asp:TextBox ID="tb_ben_comm_cer_no" CssClass="form-control form-control-sm" runat="server" MaxLength="20" AutoCompleteType="Disabled" ValidationGroup="vg1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv6" runat="server" ControlToValidate="tb_ben_comm_cer_no" ValidationGroup="vg1" ErrorMessage="Community certificate number is required (சமூகச் சான்றிதழ் எண் உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                 <div class="col-sm-12 col-md-4 col-lg-4">
                    <label for="<%=tb_ben_pan.ClientID%>" class="form-label">Permanent Account Number<br /> (நிரந்தர கணக்கு எண்) <span class="form-mandatory">*</span></label>
                    <asp:TextBox ID="tb_ben_pan" CssClass="form-control form-control-sm" runat="server" MaxLength="20" AutoCompleteType="Disabled" ValidationGroup="vg1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv8" runat="server" ControlToValidate="tb_ben_pan" ValidationGroup="vg1" ErrorMessage="PAN no. is required (நிரந்தர கணக்கு எண் உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 </div>
                <div class="col-sm-12 col-md-4 col-lg-4">
                   <label for="<%=dd_ben_disability.ClientID%>" class="form-label">Are you Destitute Widow? <br /> (ஆதரவற்ற விதவையா?) <span class="form-mandatory">*</span></label>
                   <asp:DropDownList ID="dd_ben_disability" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1">
<asp:ListItem Text="Select" Value="0"></asp:ListItem>
<asp:ListItem Text="Yes - ஆம்" Value="1"></asp:ListItem>
<asp:ListItem Text="No - இல்லை" Value="2"></asp:ListItem>
                   </asp:DropDownList>
                   <asp:RequiredFieldValidator ID="rfv7" runat="server" ControlToValidate="dd_ben_disability" InitialValue="0" ValidationGroup="vg1" ErrorMessage="Select Destitute Widow (தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
              </div>
            </div>
        </div>
        </div>

        <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-gradient-primary-to-secondary text-center text-white fw-bold px-3">
           Address as per Aadhar (ஆதார்படி முகவரி விவரங்கள்)
        </div>
        <div class="card-body p-4">
            <div class="mb-3">
                <div class="row">
                  <div class="col-sm-12 col-md-12 col-lg-12">
                     <label for="<%=tb_ben_addr.ClientID%>" class="form-label">Address (முகவரி) </label>
                     <asp:TextBox ID="tb_ben_addr" CssClass="form-control form-control-sm" runat="server" MaxLength="250" AutoCompleteType="Disabled" ValidationGroup="vg1"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfv13" runat="server" ControlToValidate="tb_ben_addr" ValidationGroup="vg1" ErrorMessage="Address should not be blank (முகவரி காலியாக இருக்கக்கூடாது.)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>  
                  </div>
                </div>
            </div>

            <div class="mb-3">
                <div class="row">
                 <div class="col-sm-12 col-md-6 col-lg-3">
                     <label for="<%=dd_ben_district.ClientID%>" class="form-label">District (மாவட்டம்) <span class="form-mandatory">*</span></label>
                     <asp:DropDownList ID="dd_ben_district" runat="server" AutoPostBack="true" CssClass="form-select form-select-sm select2" ValidationGroup="vg1"></asp:DropDownList>
                     <asp:RequiredFieldValidator ID="rfv14" runat="server" ControlToValidate="dd_ben_district" InitialValue="0" ValidationGroup="vg1" ErrorMessage="Select District (மாவட்டத்தைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>  
                 </div>
                 <div class="col-sm-12 col-md-6 col-lg-3">
                      <label for="<%=dd_ben_taluk.ClientID%>" class="form-label">Taluk (தாலுக்கா) <span class="form-mandatory">*</span></label>
                      <asp:DropDownList ID="dd_ben_taluk" runat="server" CssClass="form-select form-select-sm select2" ValidationGroup="vg1"></asp:DropDownList>
                      <asp:RequiredFieldValidator ID="rfv15" runat="server" ControlToValidate="dd_ben_taluk" InitialValue="0" ValidationGroup="vg1" ErrorMessage="Select Taluk (தாலுக்காவை தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator> 
                 </div>
                  <div class="col-sm-12 col-md-6 col-lg-3">
                     <label for="<%=dd_ben_village.ClientID%>" class="form-label">Village (கிராமம்) <span class="form-mandatory">*</span></label>
                     <asp:DropDownList ID="dd_ben_village" runat="server" CssClass="form-select select2" ValidationGroup="vg1"></asp:DropDownList>
                     <asp:RequiredFieldValidator ID="rfv16" runat="server" ControlToValidate="dd_ben_village" InitialValue="0" ValidationGroup="vg1" ErrorMessage="Select Village / Town (கிராமம் / நகரத்தைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator> 
                 </div>
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <label for="<%=tb_ben_pincode.ClientID%>" class="form-label">Pincode (அஞ்சல் குறியீடு) <span class="form-mandatory">*</span></label>
                    <asp:TextBox ID="tb_ben_pincode" CssClass="form-control form-control-sm" runat="server" MaxLength="6" AutoCompleteType="Disabled" ValidationGroup="vg1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv17" runat="server" ControlToValidate="tb_ben_pincode" ValidationGroup="vg1" ErrorMessage="Pincode is required (அஞ்சல் குறியீடு எண் உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator> 
                </div>  
                </div>
            </div>
        </div>
        </div>

         <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-gradient-primary-to-secondary text-white fw-bold px-3">
           Present Address (தற்போதைய முகவரி)
        </div>
        <div class="card-body p-4">
              <div class="mb-3">
                <div class="row"> 
                    <div class="col-sm-12 col-md-12 col-lg-12">
 <label class="switch">    
   <asp:CheckBox ID="cb_address" runat="server" AutoPostBack="true" CssClass="form-check" />
   <span class="slider round"></span>
 </label>
 <label id="lbl" class="form-label">Select if present address is same as in aadhar (ஆதாரிலுள்ள முகவரியில் இருந்தால் இதை தேர்வு செய்யவும்.)</label>
                    </div>
             </div>
            </div>
            <div class="mb-3">
              <label for="<%=tb_ben_paddr.ClientID%>" class="form-label">Address (முகவரி) </label>
              <asp:TextBox ID="tb_ben_paddr" CssClass="form-control form-control-sm" runat="server" MaxLength="250" AutoCompleteType="Disabled" ValidationGroup="vg1"></asp:TextBox>
              <asp:RequiredFieldValidator ID="rfv18" runat="server" ControlToValidate="tb_ben_paddr" ValidationGroup="vg1" ErrorMessage="Address should not be blank (முகவரி காலியாக இருக்கக்கூடாது.)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>  
            </div>
            <div class="mb-3">
                <div class="row">
                 <div class="col-sm-12 col-md-6 col-lg-6">
                     <label for="<%=dd_ben_pdistrict.ClientID%>" class="form-label">District (மாவட்டம்) <span class="form-mandatory">*</span></label>
                     <asp:DropDownList ID="dd_ben_pdistrict" runat="server" AutoPostBack="true" CssClass="form-select select2" ValidationGroup="vg1"></asp:DropDownList>
                     <asp:RequiredFieldValidator ID="rfv181" runat="server" ControlToValidate="dd_ben_pdistrict" InitialValue="0" ValidationGroup="vg1" ErrorMessage="Select District (மாவட்டத்தைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>  
                 </div>
                 <div class="col-sm-12 col-md-6 col-lg-6">
                    <label for="<%=tb_ben_ppincode.ClientID%>" class="form-label">Pincode (அஞ்சல் குறியீடு எண்) <span class="form-mandatory">*</span></label>
                    <asp:TextBox ID="tb_ben_ppincode" CssClass="form-control form-control-sm" runat="server" MaxLength="6" AutoCompleteType="Disabled" ValidationGroup="vg1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv182" runat="server" ControlToValidate="tb_ben_ppincode" ValidationGroup="vg1" ErrorMessage="Pincode is required (அஞ்சல் குறியீடு எண் உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator> 
                </div>           
                </div>
            </div>
        </div>
        </div>   

        <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-gradient-primary-to-secondary text-white fw-bold px-3">
           Bank account where the member receives payment (உறுப்பினரின் பால் பணம் பட்டுவாடா பெறும் வங்கிக் கணக்கு)
        </div>
        <div class="card-body p-4">
            <div class="mb-3">
                <div class="row">
                 <div class="col-sm-12 col-md-6 col-lg-6">
                <label for="<%=tb_bank_acc_no.ClientID%>" class="form-label">Bank Account Number<br /> (வங்கி கணக்கு எண்) <span class="form-mandatory">*</span></label>
                <asp:TextBox ID="tb_bank_acc_no" CssClass="form-control form-control-sm" runat="server" MaxLength="20" AutoCompleteType="Disabled" ValidationGroup="vg1"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfv19" runat="server" ControlToValidate="tb_bank_acc_no" ValidationGroup="vg1" ErrorMessage="Account no. is required (வங்கி கணக்கு எண்ணை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 </div>
                 <div class="col-sm-12 col-md-6 col-lg-6">
                    <label for="<%=tb_bank_name.ClientID%>" class="form-label">Name of the Bank<br /> (வங்கியின் பெயர்) <span class="form-mandatory">*</span></label>
                    <asp:TextBox ID="tb_bank_name" CssClass="form-control form-control-sm" runat="server" MaxLength="100" AutoCompleteType="Disabled" ValidationGroup="vg1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv20" runat="server" ControlToValidate="tb_bank_name" ValidationGroup="vg1" ErrorMessage="Bank name is required (வங்கியின் பெயரை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 </div>
                </div>
            </div>
           <div class="mb-3">
            <div class="row">
                 <div class="col-sm-12 col-md-6 col-lg-6">
                     <label for="<%=tb_bank_branch.ClientID%>" class="form-label">Branch Name<br /> (கிளையின் பெயர்) <span class="form-mandatory">*</span></label>
                     <asp:TextBox ID="tb_bank_branch" CssClass="form-control form-control-sm" runat="server" MaxLength="100" AutoCompleteType="Disabled" ValidationGroup="vg1"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfv21" runat="server" ControlToValidate="tb_bank_branch" ValidationGroup="vg1" ErrorMessage="Branch name is required (கிளையின் பெயரை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 </div>
                <div class="col-sm-12 col-md-6 col-lg-6">
                   <label for="<%=tb_bank_ifsc.ClientID%>" class="form-label">IFSC Code<br /> (IFSC குறியீடு) - If IFSC is not avaiable enter 'NA'<span class="form-mandatory">*</span></label>
                   <asp:TextBox ID="tb_bank_ifsc" CssClass="form-control form-control-sm" runat="server" MaxLength="15" AutoCompleteType="Disabled" ValidationGroup="vg1"></asp:TextBox>
                   <asp:RequiredFieldValidator ID="rfv22" runat="server" ControlToValidate="tb_bank_ifsc" ValidationGroup="vg1" ErrorMessage="IFSC code is required (வங்கி குறியீடு உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 </div>
            </div>
           </div>
        </div>
        </div> 

       <div class="row"> 
                <div class="col-sm-12 col-md-1 col-lg-1">  
                      <asp:CheckBox ID="ckbox_ackw" runat="server" ValidationGroup="vg1" CssClass="checkbox"/>
                </div>
                <div class="col-sm-12 col-md-11 col-lg-11">
                    <label id="lbl_acknw" class="form-label"> I certify that, All the above information entered by me are true to the best of my knowledge. <br />
                நான் உள்ளீடு செய்த மேற்கூறிய தகவல்கள் அனைத்தும் நான் அறிந்த வரையில் உண்மையானவை என்று சான்று அளிக்கிறேன். 
                </label><br />
                </div>
       </div>

       <div class="w-100 text-center m-2 pb-5">
                <div class="btn-group">
                <asp:Button ID="btn_submit" runat="server" Text="Submit to complete one time registration &#010; (ஒரு முறை பதிவை முடிக்க சமர்ப்பிக்கவும்.)" CssClass="btn btn-success m-2 px-4 py-2" ValidationGroup="vg1" />
                </div>
       </div>

</div>

<script type="text/javascript">
// @ts-nocheck
window.pageLoad = function () {
    if (window.jQuery && window.jQuery.fn && window.jQuery.fn.select2) {
        window.jQuery('.select2').select2({
            dropdownParent: window.jQuery('.container').first()
        });
    }
};
</script>

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