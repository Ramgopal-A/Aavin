<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MPU/ZMASTERMPU.Master" CodeBehind="APPLOAN.aspx.vb" Inherits="MINIDAIRY.APPLOAN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
<style>
  body { background: #f8f9fa; }
  .section-title { background: #272a7d; color: #fff; text-align: left; padding: 2px 10px; font-weight: bold; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" >
<ContentTemplate>

<div class="container my-4">

    <div id="errmsg" runat="server" class="alert alert-danger"></div>

    <div class="card">
        <div class="card-body">

    <asp:ListView ID="lv_loan_app" runat="server">
  <ItemTemplate>
<table class="table table-borderless table-sm">
    <tr>
        <td class="text-left"><img src="/ASSETS/IMAGES/logo_avin.jpg" Width="150px" Height="150px" /></td>
        <td class="text-center">
            <img src="/ASSETS/IMAGES/logo_tn.jpg" Width="150px" Height="150px" /> <br />
        </td>
        <td style="text-align:right;">
            <asp:Image ID="img_qr" runat="server" Width="150px" Height="150px" />
        </td>
    </tr>
</table>
                  <h3 class="text-center fw-bold mb-3"><u>பால் வளத்துறை</u></h3>

    <h5 class="text-center fw-bold mb-3">
    தமிழ்நாடு அரசின் சிறிய அளவிலான பால் வளப்பெண்கள் திட்டம்<br>
    <small>Member Registration / உறுப்பினர் பதிவு</small>
      <small>Member No : <%# Eval("ben_avinid") %></small>
  </h5>
  <div class="section-title">1. தனிப்பட்ட விவரங்கள் / Personal Details</div>
  <table class="table table-sm table-bordered">
    <tr>
      <td style="width:20px;">1.</td>
      <td class="w-25 px-3">உறுப்பினர் பெயர் / Name *</td>
      <td class="px-3"><%# Eval("ben_name") %></td>
      <td rowspan="4" style="width:200px;"><asp:Image ID="img_photo" runat="server" CssClass="img-fluid rounded shadow w-100 h-100" /></td>
    </tr>
    <tr>
      <td>2.</td>
      <td class="px-3">தந்தை / கணவர் பெயர் (Father / Husband Name)</td>
      <td class="px-3"><%# Eval("care_of") %>.<%# Eval("ben_fh_name") %></td>
    </tr>
    <tr>
      <td>3.</td>
      <td>பிறந்த தேதி / Date of Birth (dd-mm-yyyy) </td>
      <td><%# Eval("ben_dob", "{0:dd-MM-yyyy}") %></td>
    </tr>
    <tr>
      <td>4.</td>
      <td>வயது / Age *</td>
      <td><%# Eval("ben_age") %></td>
    </tr>
    <tr>
      <td>5.</td>
      <td>பாலினம் / Gender *</td>
      <td colspan="2"><%# Eval("ben_gender") %></td>
    </tr>
    <tr>
      <td>6.</td>
      <td>சமூகம் / Community *</td>
      <td colspan="2"><%# Eval("comm_name") %> <br /> <%# Eval("caste_name") %> <br />
          Community Certificate No. : <%# Eval("community_cert") %>
      </td>
      
    </tr>
    <tr>
      <td>7.</td>
      <td> ஆதரவற்ற விதவை? / Do you belong to Destitute widow? </td>
      <td colspan="2"><%# Eval("ben_widow") %></td>
    </tr>
    <tr>
      <td>8.</td>
      <td>தாயுமனவர் திட்டத்தில் உறுப்பினராக உள்ளீர்களா? / Are you a member of the Thayumanavar scheme? </td>
      <td colspan="2"><%# Eval("ben_thayumanavar") %></td>
    </tr>
    <tr>
      <td>9.</td>
      <td>கைபேசி எண் / Mobile Number </td>
      <td colspan="2"><%# Eval("ben_mobile_no") %></td>
    </tr>
    <tr>
      <td>10.</td>
      <td>ஸ்மார்ட் குடும்ப அட்டை எண். / Smart Family Card No.</td>
      <td><%# Eval("ben_nfsc") %> 
         
      </td>
    <td> <asp:Button ID="btn_nfsc" runat="server" Text="View Smart Family Card" CommandArgument="sfc" CssClass="btn btn-sm btn-primary w-100" /></td>
    </tr>
    <tr>
      <td>11.</td>
      <td>ஆதார் கார்டு எண் / Aadhar Card No.</td>
      <td><%# Eval("ben_aadhar") %>  </td>
      <td> <asp:Button ID="btn_aadhar" runat="server" Text="View Aadhar" CommandArgument="aadhar" CssClass="btn btn-sm btn-primary w-100" /></td>
    </tr>
    <tr>
      <td>12.</td>
      <td>பான் கார்டு எண் / PAN Card No *</td>
      <td><%# Eval("ben_pan") %></td>
        <td><asp:Button ID="btn_pan" runat="server" Text="View PAN" CommandArgument="pan" CssClass="btn btn-sm btn-primary w-100" /></td>
    </tr>
    <tr>
      <td>13.</td>
      <td>ஆதாரில் உள்ள முகவரி / Address as in Aadhar</td>
      <td colspan="2"><%# Eval("ben_addr") %><br />
          Village : <%# Eval("village") %><br />
          Taluk : <%# Eval("taluk") %><br />
          District : <%# Eval("district") %> - Pincode: <%# Eval("ben_pincode") %><br />
      </td>
    </tr>
       <td>14.</td>
      <td>தற்போதைய முகவரி / Present Address</td>
      <td colspan="2"><%# Eval("ben_paddr") %><br />
          District : <%# Eval("pdistrict") %> - Pincode: <%# Eval("ben_ppincode") %><br />
      </td>
    </tr>
</table>

  <div class="section-title">2. உறுப்பினர் சார்ந்த சங்கத்தின் விவரங்கள் / Member Based Society Details</div>
  <table class="table table-bordered">
    <tr>
      <td>1.</td>
      <td>மாவட்ட ஒன்றியத்தின் பெயர் <br /> District Union Name</td>
      <td><%# Eval("mpu_name") %></td>
    </tr>
    <tr>
      <td>2.</td>
      <td>மாவட்டத்தின் பெயர் / District Name</td>
      <td><%# Eval("loan_district") %></td>
    </tr>
    <tr>
      <td>3.</td>
      <td>பால் வழங்கும் சங்கத்தின் பெயர் <br /> Milk Supplying Society Name</td>
      <td><%# Eval("mpcs_name") %></td>
    </tr>
    <tr>
      <td>4.</td>
      <td>உறுப்பினர் எண் / Member ID</td>
      <td><%# Eval("mpcs_member_no") %>
                    <asp:Button ID="btn_society" runat="server" Text="View Society Membership Proof" CommandArgument="society" CssClass="btn btn-sm btn-primary" />

      </td>

    </tr>
    <tr>
      <td>5.</td>
      <td>தற்போது உள்ள கறவை மாடுகளின் எண்ணிக்கை <br /> Number of milch cows currently have</td>
      <td><%# Eval("having_no_of_cow") %></td>
    </tr>
    <tr>
      <td>6.</td>
      <td>தற்போது சங்கத்திற்கு வழங்கும் பாலின் அளவு (லிட்டரில்) <br /> Quantity of Milk Supplied to Society (in Litres)</td>
      <td><%# Eval("milk_qty") %> litres</td>
    </tr>
    <tr>
      <td>7.</td>
      <td>சொந்தமான மாட்டு கொட்டகை உள்ளதா? <br /> Do you already have your own cow shed?</td>
      <td><%# Eval("has_cow_shed") %></td>
    </tr>
    <tr>
      <td>8.</td>
      <td>மாட்டு கொட்டகை அமைக்க போதிய இடவசதி உண்டா? <br /> Do you have land space for setup cow shed?</td>
      <td><%# Eval("has_space_for_cow_shed") %></td>
    </tr>
     <tr>
      <td>9.</td>
      <td>பண்ணைக்கு தேர்வு செய்யவுள்ள மாட்டினம் / எருமையினம் <br /> Cattle/buffalo breed to be selected for the farm</td>
      <td>
          <table>
              <tr>
                  <td>கலப்பின ஜெர்சி <br />Hybrid Jersy</td>
                  <td> கலப்பின பிரஷ்யன் <br /> Hybrid Prussian</td>
                  <td> எருமை <br /> Buffalo</td>
              </tr>
              <tr>
                  <td><%# Eval("no_of_hybrid_jersy_cows") %></td>
                  <td><%# Eval("no_of_hybrid_prussian_cows") %></td>
                  <td><%# Eval("no_of_buff") %></td>
              </tr>
          </table>
      </td>
    </tr> 
    <tr>
      <td>10.</td>
      <td>உறுப்பினரின் பால் பணம் பட்டுவாடா   பெறும்  வங்கிக் கணக்கு <br /> Bank account where the member will receive payments for pouring milk</td>
      <td>Bank Name (வங்கி பெயர்) : <%# Eval("ben_bank_name") %><br /> 
          Branch Name (வங்கி பெயர்) : <%# Eval("ben_branch_name") %><br /> 
          Account Number (கணக்கு எண்) : <%# Eval("ben_bank_acc_no") %><br /> 
          IFSC எண் : <%# Eval("ben_ifsc") %> <br />
          <asp:Button ID="btn_bank" runat="server" Text="View Bank Passbook First Page" CommandArgument="bank" CssClass="btn btn-sm btn-primary" />

      </td>
    </tr>
    <tr>
      <td>12.</td>
      <td>Chitta சிட்டா / Adangal அடங்கல் / சான்றிதழ்கள்</td>
      <td>
          <asp:Button ID="btn_chitta" runat="server" Text="View Chitta" CommandArgument="patta" CssClass="btn btn-sm btn-primary" />
          <asp:Button ID="btn_adangal" runat="server" Text="View Adangal" CommandArgument="adangal" CssClass="btn btn-sm btn-primary"/></td>
    </tr>
  </table>


      <asp:Panel ID="Panel1" runat="server" Visible='<%#If(Convert.ToString(Eval("mpcs_status_en")) = "Recommended by Society and Forwarded to Union", "true", "false")  %>'>
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
              <td><%#Eval("mpcs_name_verified") %></td>
            </tr>
            <tr>
              <td>2</td>
              <td>Verified the Membership Number as per the Society Record <br> சங்க பதிவுகளின்படி உறுப்பினர் எண் சரிபார்க்கப்பட்டது</td>
              <td><%#Eval("mpcs_member_no_verified") %></td>
            </tr>
            <tr>
              <td>3</td>
              <td>Verified the Joining Year of the Member as per the Society Record <br> சங்க பதிவுகளின்படி உறுப்பினர் சேர்ந்த ஆண்டு சரிபார்க்கப்பட்டது</td>
              <td><%#Eval("mpcs_join_year_verified") %></td>
            </tr>
            <tr>
              <td>4</td>
              <td>Verified the Age of the Member as per the Society Record <br> சங்க பதிவுகளின்படி உறுப்பினர் வயது சரிபார்க்கப்பட்டது</td>
              <td><%#Eval("mpcs_age_verified") %></td>
            </tr>
            <tr>
              <td>5</td>
              <td>Verified the Quantity of Milk (in litres) Supplied as per the Society Record <br> சங்க பதிவுகளின்படி விநியோகிக்கப்பட்ட பால் அளவு (லிட்டர்களில்) சரிபார்க்கப்பட்டது</td>
              <td><%#Eval("mpcs_milk_qty_verified") %></td>
            </tr>
          </tbody>
        </table>

        <table class="table table-bordered">
            <tr>
              <td colspan="2">
               <b><%#Eval("ben_name") %></b> என்பவர் <b><%#Eval("mpcs_name") %></b> சங்கத்தில் <b><%#Eval("mpcs_member_no_of_years") %></b> ஆண்டுகளாக உறுப்பினராக உள்ளார் என சான்றளிக்கிறேன்.
              </td>
            </tr>
            <tr>
              <td colspan="2">
               <b><%#Eval("ben_name") %></b> என்ற உறுப்பினர் தொடர்ச்சியாக தாம் உற்பத்தி செய்து வரும் மோத்தப் பாலைவும் தரமாக சங்கத்திற்கு வழங்கி வருகிறார் என சான்றளிக்கிறேன்.
              </td>
            </tr>
            <tr>
              <td colspan="2">
              <b> <%#Eval("ben_name") %></b> என்ற உறுப்பினருக்கு <b><%#Eval("ben_bank_name") %></b>  என்ற வங்கியின் <b><%#Eval("ben_branch_name") %> (IFSC : <%#Eval("ben_ifsc") %>) </b>கிளையில் உள்ள <b> <%#Eval("ben_bank_acc_no") %> </b>வங்கி கணக்கிற்கு பால் பணம் பட்டுவாடா செய்யப்படுகிறது என சான்றளிக்கிறேன்.
              </td>
            </tr>
            <tr>
              <td colspan="2">
              <b>  <%#Eval("ben_name") %></b> என்ற உறுப்பினருக்கு சிறிய அளவிலான பால் பண்ணைத் திட்டத்தின் கீழ் வங்கி கடன் வழங்க பரிந்துரை செய்கிறேன்.
              </td>
            </tr>
          </table>

          <div class="alert alert-success text-center fw-bold">
            <%# Eval("mpcs_status_en") %>  <br /> <%# Eval("mpcs_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong>   <%# Eval("mpcs_remarks") %>
          </div>
        
      </asp:Panel>
      <asp:Panel ID="Panel2" runat="server" Visible='<%#If(Convert.ToString(Eval("mpcs_status_en")) = "Rejected by Society", "true", "false")  %>'>


          <div class="alert alert-danger text-center fw-bold">
            <%# Eval("mpcs_status_en") %>  <br /> <%# Eval("mpcs_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong>   <%# Eval("mpcs_remarks") %>
          </div>
      </asp:Panel>
      <asp:Panel ID="Panel3" runat="server" Visible='<%#If(Convert.ToString(Eval("mpu_status_en")) = "Recommended by Union and Forwarded to Bank", "true", "false")  %>'>

          <div class="alert alert-success text-center fw-bold">
            <%# Eval("mpu_status_en") %>  <br /> <%# Eval("mpu_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong>   <%# Eval("mpu_remarks") %>
          </div>

      </asp:Panel>
      <asp:Panel ID="Panel4" runat="server" Visible='<%#If(Convert.ToString(Eval("mpu_status_en")) = "Rejected by Union", "true", "false")  %>'>


          <div class="alert alert-danger text-center fw-bold">
            <%# Eval("mpu_status_en") %>  <br /> <%# Eval("mpu_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong>   <%# Eval("mpu_remarks") %>
          </div>

      </asp:Panel>
      <asp:Panel ID="Panel5" runat="server" Visible='<%#If(Convert.ToString(Eval("bank_status_en")) = "Rejected by Union", "true", "false")  %>'>

          <div class="alert alert-success text-center fw-bold">
                 <%# Eval("bank_status_en") %>  <br /> <%# Eval("bank_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong>   <%# Eval("bank_remarks") %>
          </div>

      </asp:Panel>

      <asp:Panel ID="Panel6" runat="server" Visible='<%#If(Convert.ToString(Eval("bank_status_en")) = "Rejected by Union", "true", "false")  %>'>

          <div class="alert alert-danger text-center fw-bold">
                 <%# Eval("bank_status_en") %>  <br /> <%# Eval("bank_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong>   <%# Eval("bank_remarks") %>
          </div>

      </asp:Panel>

        </ItemTemplate>
    </asp:ListView>


         </div>
    </div>




</div>

<div class="modal fade" id="uploadPopup" tabindex="-1" aria-labelledby="uploadPopupLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-gradient-primary-to-secondary text-white">
        <h5 class="modal-title" id="uploadPopupLabel">Document - <asp:Literal ID="ltl_doc_type" runat="server" ></asp:Literal></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <asp:Image ID="img_doc" runat="server" CssClass="img-fluid rounded shadow" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
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
</asp:Content>
