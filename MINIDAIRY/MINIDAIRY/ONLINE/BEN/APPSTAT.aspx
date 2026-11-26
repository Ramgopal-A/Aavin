<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ONLINE/BEN/ZMASTERBEN.Master" CodeBehind="APPSTAT.aspx.vb" Inherits="MINIDAIRY.APPSTAT" %>
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

    <div id="errmsg" runat="server" class="alert alert-danger" visible="false"></div>

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
    <%# If(Convert.ToString(Eval("scheme_type")).ToUpper() = "MEDIUM", "தமிழ்நாடு அரசின் நடுத்தர பால் பண்ணைத் திட்டம் (Medium Dairy Farm Scheme)", "தமிழ்நாடு அரசின் சிறு பால் பண்ணைத் திட்டம் (Mini Dairy Farm Scheme)") %><br>
    <small>Member Registration / உறுப்பினர் பதிவு</small>
      <small>Member No : <%# Eval("ben_avinid") %></small>
  </h5>

  <!-- Application Tracking & Milk Pouring QR Summary -->
  <div class="row g-3 mb-3">
    <div class="col-md-8">
      <div class="border rounded p-3 bg-white h-100">
        <div class="fw-bold text-primary mb-2">Application &amp; Loan Tracking / விண்ணப்பம் மற்றும் கடன் நிலை கண்காணிப்பு</div>
        <div class="row small g-2">
          <div class="col-sm-6">
            <strong>Current Status:</strong> <%# Eval("status_en") %><br />
            <span class="text-muted"><%# Eval("status_ta") %></span>
          </div>
          <div class="col-sm-6">
            <strong>Bank Status:</strong> <%# Eval("bank_status_en") %><br />
            <span class="text-muted"><%# Eval("bank_status_ta") %></span>
          </div>
          <div class="col-sm-6">
            <strong>Sanction Details:</strong>
            <%# GetLoanDetailText(Container.DataItem, "sanctioned_amount", "Pending / நிலுவையில் உள்ளது", "₹ ") %>
          </div>
          <div class="col-sm-6">
            <strong>Disbursement Details:</strong>
            <%# GetLoanDetailText(Container.DataItem, "disbursed_amount", "Pending / நிலுவையில் உள்ளது", "₹ ") %>
          </div>
          <div class="col-sm-6">
            <strong>Repayment Details:</strong>
            <%# GetLoanDetailText(Container.DataItem, "repayment_details", "Applicable post-disbursement / கடன் வழங்கப்பட்ட பின்") %>
          </div>
          <div class="col-sm-6">
            <strong>Subsidy Details:</strong>
            <%# GetLoanDetailText(Container.DataItem, "subsidy_details", "As per scheme norms / திட்ட விதிமுறைப்படி") %>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="border rounded p-3 bg-light text-center h-100">
        <div class="fw-bold text-success small mb-1">Milk Pouring Society QR Code</div>
        <div class="text-muted small mb-2">பால் ஊற்றும் போது சங்கத்தில் காட்டவும்</div>
        <asp:Image ID="img_milk_qr" runat="server" Width="130px" Height="130px" CssClass="img-thumbnail bg-white mb-2" />
        <div class="small fw-semibold">ID: <%# Eval("ben_avinid") %></div>
        <div class="small text-muted">MPCS: <%# Eval("mpcs_member_no") %> | <%# Eval("scheme_type") %></div>
      </div>
    </div>
  </div>

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
      <td><%# Eval("ben_nfsc") %></td>
      <td><asp:Button ID="btn_nfsc" runat="server" Text="View Smart Family Card" CommandArgument="sfc" CssClass="btn btn-sm btn-primary w-100" /></td>
    </tr>
    <tr>
      <td>11.</td>
      <td>ஆதார் கார்டு எண் / Aadhar Card No.</td>
      <td><%# Eval("ben_aadhar") %></td>
      <td><asp:Button ID="btn_aadhar" runat="server" Text="View Aadhar" CommandArgument="aadhar" CssClass="btn btn-sm btn-primary w-100" /></td>
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
    <tr>
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
      <td>0.</td>
      <td>தேர்ந்தெடுக்கப்பட்ட திட்டம் <br /> Selected Scheme</td>
      <td><strong><%# If(Convert.ToString(Eval("scheme_type")).ToUpper() = "MEDIUM", "MEDIUM DAIRY", "MINI DAIRY ") %></strong></td>
    </tr>
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
          <asp:Button ID="btn_society" runat="server" Text="View Society ID Card" CommandArgument="society" CssClass="btn btn-sm btn-primary ms-2" />
      </td>
    </tr>
    <tr>
      <td>5.</td>
      <td>தற்போது உள்ள கறவை மாடுகளின் எண்ணிக்கை <br /> Number of milch cows currently have</td>
      <td><%# Eval("having_no_of_cow") %></td>
    </tr>
    <tr>
      <td>6.</td>
      <td>தற்போது சங்கத்திற்கு மாதந்தோறும் வழங்கும் பாலின் அளவு (லிட்டரில்) <br /> Quantity of Milk Supplied to Society per Month (in Litres)</td>
      <td><%# Eval("milk_qty") %> litres / month</td>
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
                  <td>கலப்பின ஜெர்சி <br />Crossbred Jersy</td>
                  <td>கலப்பின பிரஷ்யன் <br />Crossbred Holstein Friesian</td>
                  <td>எருமை <br />Buffalo</td>
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
      <td>உறுப்பினரின் பால் பணம் பட்டுவாடா பெறும் வங்கிக் கணக்கு <br /> Bank account where the member will receive payments for pouring milk</td>
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
          <asp:Button ID="btn_chitta" runat="server" Text="View Chitta" CommandArgument="chitta" CssClass="btn btn-sm btn-primary" />
          <asp:Button ID="btn_adangal" runat="server" Text="View Adangal" CommandArgument="adangal" CssClass="btn btn-sm btn-primary"/>
      </td>
    </tr>
    <tr>
      <td>13.</td>
      <td>கையொப்பமிட்ட விண்ணப்பக் கடிதம் <br /> Signed Application Letter</td>
      <td>
          <asp:Button ID="btn_signed_letter" runat="server" Text="View Signed Application Letter" CommandArgument="signed_letter" CssClass="btn btn-sm btn-primary" />
      </td>
    </tr>
  </table>

      <asp:Panel ID="Panel3" runat="server" Visible='<%# If(Convert.ToString(Eval("mpu_status_en")) = "Recommended by Union and Forwarded to Bank", "true", "false") %>'>
          <div class="alert alert-success text-center fw-bold">
              <b><u><%# Eval("mpu_name") %></u></b><br />
              <%# Eval("mpu_status_en") %> <br /> <%# Eval("mpu_status_ta") %> <br />
              <b><u><%# Eval("selected_bank_name") %></u></b><br />
              <strong><u>Remarks : </u></strong> <%# Eval("mpu_remarks") %>
          </div>
      </asp:Panel>

      <asp:Panel ID="Panel4" runat="server" Visible='<%# If(Convert.ToString(Eval("mpu_status_en")) = "Rejected by Union", "true", "false") %>'>
          <div class="alert alert-danger text-center fw-bold">
              <b><u><%# Eval("mpu_name") %></u></b> <br />
              <%# Eval("mpu_status_en") %> <br /> <%# Eval("mpu_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong> <%# Eval("mpu_remarks") %>
          </div>
      </asp:Panel>

      <asp:Panel ID="Panel5" runat="server" Visible='<%# If(Convert.ToString(Eval("bank_status_en")) = "Under Processing", "true", "false") %>'>
          <div class="alert alert-info text-center fw-bold">
              <b><u><%# Eval("selected_bank_name") %></u></b> <br />
              <%# Eval("bank_status_en") %> <br /> <%# Eval("bank_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong> <%# Eval("bank_remarks") %>
          </div>
      </asp:Panel>

      <asp:Panel ID="Panel6" runat="server" Visible='<%# If(Convert.ToString(Eval("bank_status_en")) = "Loan is Sanctioned by Bank", "true", "false") %>'>
          <div class="alert alert-success text-center fw-bold">
              <b><u><%# Eval("selected_bank_name") %></u></b> <br />
              <%# Eval("bank_status_en") %> <br /> <%# Eval("bank_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong> <%# Eval("bank_remarks") %>
          </div>
      </asp:Panel>

      <asp:Panel ID="Panel8" runat="server" Visible='<%# If(Convert.ToString(Eval("bank_status_en")) = "Loan is Disbursed by Bank", "true", "false") %>'>
          <div class="alert alert-primary text-center fw-bold">
              <b><u><%# Eval("selected_bank_name") %></u></b> <br />
              <%# Eval("bank_status_en") %> <br /> <%# Eval("bank_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong> <%# Eval("bank_remarks") %>
          </div>
      </asp:Panel>

      <asp:Panel ID="Panel7" runat="server" Visible='<%# If(Convert.ToString(Eval("bank_status_en")) = "Rejected by Bank", "true", "false") %>'>
          <div class="alert alert-danger text-center fw-bold">
              <b><u><%# Eval("selected_bank_name") %></u></b><br />
              <%# Eval("bank_status_en") %> <br /> <%# Eval("bank_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong> <%# Eval("bank_remarks") %>
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
          <iframe id="pdf_doc" runat="server" visible="false" style="width:100%;height:70vh;border:0;"></iframe>
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
<asp:Content ID="Content4" ContentPlaceHolderID="footer_content_holder" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="script_content_holder" runat="server">
</asp:Content>