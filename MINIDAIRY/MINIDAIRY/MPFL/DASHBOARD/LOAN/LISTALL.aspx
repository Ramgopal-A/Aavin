<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MPFL/DASHBOARD/ZMASTERMPFLDASH.Master" CodeBehind="LISTALL.aspx.vb" Inherits="MINIDAIRY.LISTALL2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
<style>
.grid-card { box-shadow: 0 6px 18px rgba(0,0,0,0.08); border-radius:6px; }
.modal-lg { --bs-modal-width: 900px; }
.section-title { background: #272a7d; color: #fff; text-align: left; padding: 2px 10px; font-weight: bold; }
.gv-btn-blue {
    width: 100%;
    height: 100%;
    background-color: transparent;
    border: 1px solid #081cc5;
    color: #081cc5;
    text-decoration: none;
    text-align: center;
    vertical-align: middle;
    display: inline-block;
    padding:4px 0px;
    transition: all 0.3s ease; 
}
.gv-btn-blue:hover {
    background-color: #081cc5;
    border: 1px solid #081cc5;
    color: #ffffff;
    text-decoration: none;
}
.gv-btn-red {
    width: 100%;
    height: 100%;
    background-color: transparent;
    border: 1px solid #d50e0e;
    color: #d50e0e;
    text-decoration: none;
    text-align: center;
    vertical-align: middle;
    display: inline-block;
    padding:4px 0px;
    transition: all 0.3s ease; 
}
.gv-btn-red:hover {
    background-color: #d50e0e;
    border: 1px solid #d50e0e;
    color: #ffffff;
    text-decoration: none;
}
.gv-btn-green {
    width: 100%;
    height: 100%;
    background-color: transparent;
    border: 1px solid #0fa532;
    color: #0fa532;
    text-decoration: none;
    text-align: center;
    vertical-align: middle;
    display: inline-block;
    padding:4px 0px;
    transition: all 0.3s ease; 
}
.gv-btn-green:hover {
    background-color: #0fa532;
    border: 1px solid #0fa532;
    color: #ffffff;
    text-decoration: none;
}
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

<div class="card grid-card p-3">
 
<div class="table-responsive">
<asp:MultiView ID="MultiView1" runat="server">
<asp:View ID="View1" runat="server">
    <asp:Button ID="btnExport" runat="server" Text="Export to Excel" CssClass="btn btn-primary btn-sm my-2" />

     <asp:GridView ID="gvMpu" runat="server" AutoGenerateColumns="false" CssClass="table table-stried table-hover"
         EmptyDataText="No records found."   
          DataKeyNames="mpu_id,loan_dist_id">
         <HeaderStyle CssClass="text-center" />
        
         <Columns>
             <asp:TemplateField HeaderText="S.No" ItemStyle-Width="60px"  HeaderStyle-CssClass="bg-primary text-white" >
                 <ItemTemplate>
                     <%# Container.DataItemIndex + 1 %>
                 </ItemTemplate>
             </asp:TemplateField>
             <asp:BoundField DataField="dist_name_en" HeaderText="District" HeaderStyle-CssClass="bg-primary text-white"/>
             <asp:BoundField DataField="mpu_name_short_en" HeaderText="Milk Producer Union" HeaderStyle-CssClass="bg-primary text-white" />
             <asp:BoundField DataField="tot_app" HeaderText="Total Applications" ItemStyle-HorizontalAlign="center" HeaderStyle-CssClass="bg-primary text-white"/>
            <asp:ButtonField DataTextField="mpu_pend" HeaderText="Pending at Union" CommandName="MPU" ControlStyle-CssClass="gv-btn-blue" HeaderStyle-CssClass="bg-primary text-white" />
            <asp:ButtonField DataTextField="mpu_rec" HeaderText="Recommended by Union" CommandName="MPU" ControlStyle-CssClass="gv-btn-green" HeaderStyle-CssClass="bg-primary text-white" />
            <asp:ButtonField DataTextField="mpu_rej" HeaderText="Rejected by Union" CommandName="MPU" ControlStyle-CssClass="gv-btn-red"  HeaderStyle-CssClass="bg-primary text-white"/>
            <asp:ButtonField DataTextField="bank_pend" HeaderText="Pending at Bank" CommandName="MPU" ControlStyle-CssClass="gv-btn-blue"  HeaderStyle-CssClass="bg-primary text-white"/>
            <asp:ButtonField DataTextField="bank_rec" HeaderText="Recommended by Bank" CommandName="MPU" ControlStyle-CssClass="gv-btn-green"  HeaderStyle-CssClass="bg-primary text-white"/>
            <asp:ButtonField DataTextField="bank_rej" HeaderText="Rejected by Bank" CommandName="MPU" ControlStyle-CssClass="gv-btn-red" HeaderStyle-CssClass="bg-primary text-white" />


         </Columns>
     </asp:GridView>
</asp:View>

<asp:View ID="View2" runat="server">
    <asp:Button ID="btn_back1" runat="server" Text="Go Back" CssClass="btn btn-sm btn-danger" />
     <asp:GridView ID="gvBen" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-hover"
         EmptyDataText="No records found."   
          DataKeyNames="ben_id">
         <HeaderStyle CssClass="text-center text-white bg-gradient-primary-to-secondary" />
         <RowStyle CssClass="text-center" />
         <Columns>
             <asp:TemplateField HeaderText="S.No" ItemStyle-Width="60px" HeaderStyle-HorizontalAlign="Center">
                 <ItemTemplate>
                     <%# Container.DataItemIndex + 1 %>
                 </ItemTemplate>
             </asp:TemplateField>
             <asp:BoundField DataField="ben_avinid" HeaderText="LOAN APPLICATION NO."/>
             <asp:BoundField DataField="ben_name" HeaderText="APPLICANT NAME" HeaderStyle-HorizontalAlign="Center"/>
             <asp:BoundField DataField="loan_district" HeaderText="DISTRICT" HeaderStyle-HorizontalAlign="Center"/>
             <asp:BoundField DataField="ben_gender" HeaderText="GENDER" HeaderStyle-HorizontalAlign="Center"/>
             <asp:BoundField DataField="ben_thayumanavar" HeaderText="THAYUMANAVAR SCHEME" HeaderStyle-HorizontalAlign="Center"/>

             <asp:TemplateField HeaderText="Actions" ItemStyle-Width="100px">
                 <ItemTemplate>
                     <div class="d-flex gap-2">
                    <asp:LinkButton ID="lnkEdit" runat="server" CommandName="EditRow" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-outline-primary w-100">View</asp:LinkButton>
                     </div>
                 </ItemTemplate>
             </asp:TemplateField>
         </Columns>
     </asp:GridView>
</asp:View>

<asp:View ID="View3" runat="server">
        <asp:Button ID="btn_back2" runat="server" Text="Go Back" CssClass="btn btn-sm btn-danger" />
    <asp:HiddenField ID="hf_ben_id" runat="server" />
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
    தமிழ்நாடு அரசின் சிறு பால் பண்ணைத் திட்டம்<br>
    <small>Member Registration / உறுப்பினர் பதிவு</small>
      <small>Member No : <%# Eval("ben_avinid") %></small>
  </h5>
  <div class="section-title">1.  Personal Details</div>
  <table class="table table-sm table-bordered">
    <tr>
      <td style="width:20px;">1.</td>
      <td class="w-25 px-3">Name *</td>
      <td class="px-3"><%# Eval("ben_name") %></td>
      <td rowspan="4" style="width:200px;"><asp:Image ID="img_photo" runat="server" CssClass="img-fluid rounded shadow w-100 h-100" /></td>
    </tr>
    <tr>
      <td>2.</td>
      <td class="px-3">Father / Husband Name</td>
      <td class="px-3"><%# Eval("care_of") %>.<%# Eval("ben_fh_name") %></td>
    </tr>
    <tr>
      <td>3.</td>
      <td>Date of Birth (dd-mm-yyyy) </td>
      <td><%# Eval("ben_dob", "{0:dd-MM-yyyy}") %></td>
    </tr>
    <tr>
      <td>4.</td><td>Age </td>
      <td><%# Eval("ben_age") %></td>
    </tr>
    <tr>
      <td>5.</td><td>Gender </td>
      <td colspan="2"><%# Eval("ben_gender") %></td>
    </tr>
    <tr>
      <td>6.</td><td>Community </td>
      <td colspan="2"><%# Eval("comm_name") %> <br /> <%# Eval("caste_name") %> <br />
          Community Certificate No. : <%# Eval("community_cert") %>
      </td>
      
    </tr>
    <tr>
      <td>7.</td><td> Is the applicant a Destitute widow? </td>
      <td colspan="2"><%# Eval("ben_widow") %></td>
    </tr>
    <tr>
      <td>8.</td><td>Is the applicant a member of the Thayumanavar scheme? </td>
      <td colspan="2"><%# Eval("ben_thayumanavar") %></td>
    </tr>
    <tr>
      <td>9.</td><td>Mobile Number </td>
      <td colspan="2"><%# Eval("ben_mobile_no") %></td>
    </tr>
    <tr>
      <td>10.</td><td> Smart Family Card No.</td>
      <td><%# Eval("ben_nfsc") %> 
         
      </td>
    <td> <asp:Button ID="btn_nfsc" runat="server" Text="View Smart Family Card" CommandArgument="sfc" CssClass="btn btn-sm btn-primary w-100" /></td>
    </tr>
    <tr>
      <td>11.</td><td>Aadhar Card No.</td>
      <td><%# Eval("ben_aadhar") %>  </td>
      <td> <asp:Button ID="btn_aadhar" runat="server" Text="View Aadhar" CommandArgument="aadhar" CssClass="btn btn-sm btn-primary w-100" /></td>
    </tr>
    <tr>
      <td>12.</td><td> PAN Card No *</td>
      <td><%# Eval("ben_pan") %></td>
        <td><asp:Button ID="btn_pan" runat="server" Text="View PAN" CommandArgument="pan" CssClass="btn btn-sm btn-primary w-100" /></td>
    </tr>
    <tr>
      <td>13.</td><td>Address as in Aadhar</td>
      <td colspan="2"><%# Eval("ben_addr") %><br />
          Village : <%# Eval("village") %><br />
          Taluk : <%# Eval("taluk") %><br />
          District : <%# Eval("district") %> - Pincode: <%# Eval("ben_pincode") %><br />
      </td>
    </tr>
       <td>14.</td><td>Present Address</td>
      <td colspan="2"><%# Eval("ben_paddr") %><br />
          District : <%# Eval("pdistrict") %> - Pincode: <%# Eval("ben_ppincode") %><br />
      </td>
    </tr>
</table>

  <div class="section-title">2. Member Based Society Details</div>
  <table class="table table-bordered">
    <tr>
      <td>1.</td><td>District Union Name</td>
      <td colspan="2"><%# Eval("mpu_name") %></td>
    </tr>
    <tr>
      <td>2.</td><td>District Name</td>
      <td colspan="2"><%# Eval("loan_district") %></td>
    </tr>
    <tr>
      <td>3.</td><td> Milk Supplying Society Name</td>
      <td colspan="2"><%# Eval("mpcs_name") %></td>
    </tr>
    <tr>
      <td>4.</td><td>Member ID</td>
      <td><%# Eval("mpcs_member_no") %></td>
      <td><asp:Button ID="btn_society" runat="server" Text="View Society Authorization Letter" CommandArgument="society" CssClass="btn btn-sm btn-primary w-100" /></td>
    </tr>
    <tr>
      <td>5.</td><td>Number of milch cows currently have</td>
      <td colspan="2"><%# Eval("having_no_of_cow") %></td>
    </tr>
    <tr>
      <td>6.</td><td>Quantity of Milk Supplied to Society (in Litres)</td>
      <td colspan="2"><%# Eval("milk_qty") %> litres</td>
    </tr>
    <tr>
      <td>7.</td>
      <td> Do the applicant already has own cow shed?</td>
      <td colspan="2"><%# Eval("has_cow_shed") %></td>
    </tr>
    <tr>
      <td>8.</td>
      <td> Do you have land space for setup cow shed?</td>
      <td colspan="2"><%# Eval("has_space_for_cow_shed") %></td>
    </tr>
     <tr>
      <td>9.</td><td>Cattle/buffalo breed to be selected for the farm</td>
      <td  colspan="2">
          <table class="table table-sm table-bordered">
              <tr>
                  <td>Crossbred Jersy</td>
                  <td> Crossbred Holstein Friesian</td>
                  <td> Buffalo</td>
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
      <td>Bank account where the member will receive payments for pouring milk</td>
      <td>Bank Name : <%# Eval("ben_bank_name") %><br /> 
          Branch Name : <%# Eval("ben_branch_name") %><br /> 
          Account Number : <%# Eval("ben_bank_acc_no") %><br /> 
          IFSC : <%# Eval("ben_ifsc") %> <br />
      </td>
        <td><asp:Button ID="btn_bank" runat="server" Text="View Bank Passbook First Page" CommandArgument="bank" CssClass="btn btn-sm btn-primary w-100" /></td>
    </tr>
    <tr>
      <td>12.</td>
      <td>Chitta / Adangal / Lease Agreement</td>
      <td>
          <asp:Button ID="btn_chitta" runat="server" Text="View Chitta / Lease Agreement Page 1" CommandArgument="chitta" CssClass="btn btn-sm btn-primary w-100" />
          </td>
        <td><asp:Button ID="btn_adangal" runat="server" Text="View Adangal / Lease Agreement Page 2" CommandArgument="adangal" CssClass="btn btn-sm btn-primary w-100"/></td>
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
</asp:View>
</asp:MultiView>

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
     <asp:PostBackTrigger ControlID="btnExport" />
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


