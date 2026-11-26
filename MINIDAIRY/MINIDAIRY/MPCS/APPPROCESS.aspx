<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MPCS/ZMASTERMPCS.Master" CodeBehind="APPPROCESS.aspx.vb" Inherits="MINIDAIRY.APPPROCESS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">

<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" >
<ContentTemplate>
<div class="container my-4">



    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server"></asp:View>
        <asp:View ID="View2" runat="server">
        <div class="mb-3">
            <label for="<%=dd_verify_name.ClientID%>" class="form-label">
                Verified the Member Name as per the Society Record <br />
                (சங்க பதிவுகளின்படி உறுப்பினர் பெயர் சரிபார்க்கப்பட்டது)
                <span class="form-mandatory">*</span>
            </label>
            <asp:DropDownList ID="dd_verify_name" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfv_verify_name" runat="server" ControlToValidate="dd_verify_name" InitialValue="0"
                ValidationGroup="vg1" ErrorMessage="Select Yes/No (ஆம் / இல்லை தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>

        <div class="mb-3">
            <label for="<%=dd_verify_number.ClientID%>" class="form-label">
                Verified the Membership Number as per the Society Record <br />
                (சங்க பதிவுகளின்படி உறுப்பினர் எண் சரிபார்க்கப்பட்டது)
                <span class="form-mandatory">*</span>
            </label>
            <asp:DropDownList ID="dd_verify_number" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfv_verify_number" runat="server" ControlToValidate="dd_verify_number" InitialValue="0"
                ValidationGroup="vg1" ErrorMessage="Select Yes/No (ஆம் / இல்லை தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>

        <div class="mb-3">
            <label for="<%=dd_verify_year.ClientID%>" class="form-label">
                Verified the Joining Year of the Member as per the Society Record <br />
                (சங்க பதிவுகளின்படி உறுப்பினர் சேர்ந்த ஆண்டு சரிபார்க்கப்பட்டது)
                <span class="form-mandatory">*</span>
            </label>
            <asp:DropDownList ID="dd_verify_year" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfv_verify_year" runat="server" ControlToValidate="dd_verify_year" InitialValue="0"
                ValidationGroup="vg1" ErrorMessage="Select Yes/No (ஆம் / இல்லை தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>

        <div class="mb-3">
            <label for="<%=dd_verify_age.ClientID%>" class="form-label">
                Verified the Age of the Member as per the Society Record <br />
                (சங்க பதிவுகளின்படி உறுப்பினர் வயது சரிபார்க்கப்பட்டது)
                <span class="form-mandatory">*</span>
            </label>
            <asp:DropDownList ID="dd_verify_age" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfv_verify_age" runat="server" ControlToValidate="dd_verify_age" InitialValue="0"
                ValidationGroup="vg1" ErrorMessage="Select Yes/No (ஆம் / இல்லை தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>

        <div class="mb-3">
            <label for="<%=dd_verify_milk.ClientID%>" class="form-label">
                Verified the Quantity of Milk (in litres) Supplied as per the Society Record <br />
                (சங்க பதிவுகளின்படி விநியோகிக்கப்பட்ட பால் அளவு (லிட்டர்களில்) சரிபார்க்கப்பட்டது)
                <span class="form-mandatory">*</span>
            </label>
            <asp:DropDownList ID="dd_verify_milk" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfv_verify_milk" runat="server" ControlToValidate="dd_verify_milk" InitialValue="0"
                ValidationGroup="vg1" ErrorMessage="Select Yes/No (ஆம் / இல்லை தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        </asp:View>
        <asp:View ID="View3" runat="server">
<table class="table table-bordered text-center align-middle">
  <thead class="table-info">
    <tr>
      <th style="width:5%;">S.No</th>
      <th style="width:65%;">Description / விளக்கம்</th>
      <th style="width:30%;">Verification (Yes / No)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>Verified the Member Name as per the Society Record <br> சங்க பதிவுகளின்படி உறுப்பினர் பெயர் சரிபார்க்கப்பட்டது</td>
      <td></td>
    </tr>
    <tr>
      <td>2</td>
      <td>Verified the Membership Number as per the Society Record <br> சங்க பதிவுகளின்படி உறுப்பினர் எண் சரிபார்க்கப்பட்டது</td>
      <td></td>
    </tr>
    <tr>
      <td>3</td>
      <td>Verified the Joining Year of the Member as per the Society Record <br> சங்க பதிவுகளின்படி உறுப்பினர் சேர்ந்த ஆண்டு சரிபார்க்கப்பட்டது</td>
      <td></td>
    </tr>
    <tr>
      <td>4</td>
      <td>Verified the Age of the Member as per the Society Record <br> சங்க பதிவுகளின்படி உறுப்பினர் வயது சரிபார்க்கப்பட்டது</td>
      <td></td>
    </tr>
    <tr>
      <td>5</td>
      <td>Verified the Quantity of Milk (in litres) Supplied as per the Society Record <br> சங்க பதிவுகளின்படி விநியோகிக்கப்பட்ட பால் அளவு (லிட்டர்களில்) சரிபார்க்கப்பட்டது</td>
      <td></td>
    </tr>
  </tbody>
</table>
        </asp:View>

    </asp:MultiView>


        
          

       
          <table class="table table-bordered">
            <tr>
              <td colspan="2">
                ___________ என்பவர் ____________________ சங்கத்தில் உறுப்பிராக ______ ஆண்டுகளாக உறுப்பினராக உள்ளார் என சான்றளிக்கிறேன்.
              </td>
            </tr>
            <tr>
              <td colspan="2">
                _____________ என்ற உறுப்பினர் தொழில்செய்யாக தாம் உறுப்பினர் செய்து வரும் மோத்தப் பாலைவும் தரமாக சங்கத்திற்கு வழங்கி வருகிறார் என சான்றளிக்கிறேன்.
              </td>
            </tr>
            <tr>
              <td colspan="2">
                ________ என்ற உறுப்பினருக்கு ________ வங்கியின் ____________ இலையில் உள்ள வங்கி கணக்கிற்கு பால் பணம் பட்டுவாடா செய்யப்படுகிறது என சான்றளிக்கிறேன்.
              </td>
            </tr>
            <tr>
              <td colspan="2">
                ________ என்ற உறுப்பினருக்கு ________ என்ற திட்டத்தின் கீழ் வங்கி கடன் பெறும் வழங்க பரிந்துரையாக செய்கிறேன்.
              </td>
            </tr>
          </table>


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
