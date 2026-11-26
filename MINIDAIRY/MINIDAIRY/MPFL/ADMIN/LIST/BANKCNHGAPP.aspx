<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MPFL/ADMIN/ZMASTERMPFLADMIN.Master" CodeBehind="BANKCNHGAPP.aspx.vb" Inherits="MINIDAIRY.BANKCNHGAPP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
    <link href="/ASSETS/CSS/loanviewprocess.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<div class="container py-4">
     

<div class="d-flex justify-content-between align-items-center mb-4">
<h4 class="mb-0 text-primary">
    <a href="/MPFL/ADMIN/" class="text-decoration-none">Home</a>
    <span class="px-3"><i class="fa fa-chevron-right"></i></span>
    List of Loan Applications Under Processing in Bank</h4>
</div>

<div id="errmsg" runat="server" class="alert alert-danger alert-dismissible"></div>

<div class="card grid-card p-3">
 
<div class="table-responsive">
<asp:MultiView ID="mvMain" runat="server">
<asp:View ID="View1" runat="server">
      <asp:ListView ID="lvRequests" runat="server">
                        <EmptyDataTemplate>
                            <div class="alert alert-warning shadow-sm rounded-3">
                                <i class="fa-solid fa-circle-info me-2"></i> No transfer requests found.
                            </div>
                        </EmptyDataTemplate>

                        <LayoutTemplate>
                            <div class="row g-4">
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                            </div>
                        </LayoutTemplate>

                        <ItemTemplate>
                            <div class="col-12 col-lg-6">
                                <div class="card card-fancy">
                                    <div class="card-header d-flex align-items-center justify-content-between">
                                        <div class="fw-bold">
                                            <i class="fa-solid fa-building-columns me-2"></i>
                                            <%# Eval("mpu_name") %>
                                        </div>
                                        <span class="badge bg-info text-dark rounded-pill">
                                            Pending
                                        </span>
                                    </div>

                                    <div class="card-body p-4">
                                        <asp:HiddenField ID="hfBenId" runat="server" Value='<%# Eval("ben_id") %>' />

                                        <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
                                            <span class="badge bg-primary rounded-pill">
                                                <i class="fa-solid fa-hashtag me-1"></i>
                                                <%# Eval("ben_avinid") %>
                                            </span>
                                            <span class="badge bg-dark rounded-pill">
                                                <i class="fa-solid fa-user me-1"></i>
                                                <%# Eval("ben_name") %>
                                            </span>
                                        </div>

                                        <div class="kv mb-2">
                                            <div class="d-flex justify-content-between">
                                                <div class="k">Loan Application Number</div>
                                                <div class="v text-end"><%# Eval("ben_avinid") %></div>
                                            </div>
                                        </div>

                                        <div class="kv mb-2">
                                            <div class="d-flex justify-content-between">
                                                <div class="k">Loan Applicant</div>
                                                <div class="v text-end"><%# Eval("ben_name") %></div>
                                            </div>
                                        </div>

                                        <div class="kv mb-2">
                                            <div class="d-flex justify-content-between">
                                                <div class="k">District</div>
                                                <div class="v text-end"><%# Eval("dist_name") %></div>
                                            </div>
                                        </div>

                                        <hr class="my-3" />

                                        <div class="kv mb-2">
                                            <div class="k mb-1">Bank to which the loan application is forwarded</div>
                                            <div class="v"><i class="fa-solid fa-arrow-right-to-bracket me-2 text-secondary"></i><%# Eval("old_bank_name") %></div>
                                        </div>

                                        <div class="kv mb-2">
                                            <div class="k mb-1">Bank to which the loan application to be transferred</div>
                                            <div class="v"><i class="fa-solid fa-arrow-right-arrow-left me-2 text-secondary"></i><%# Eval("new_bank_name") %></div>
                                        </div>

                                        <div class="kv">
                                            <div class="k mb-1">Reason</div>
                                            <div class="v text-muted"><%# Eval("old_new_reason") %></div>
                                        </div>
                                    </div>

                                    <div class="card-footer bg-white border-0 p-4 pt-0">
                                        <div class="d-grid d-md-flex gap-2">
                                            <asp:LinkButton ID="btnView" runat="server"
                                                CssClass="btn btn-outline-primary btn-wide"
                                                CommandName="VIEW"
                                                CommandArgument='<%# Eval("ben_id") %>'>
                                                <i class="fa-solid fa-file-lines me-2"></i>View Loan Application
                                            </asp:LinkButton>

                                            <asp:LinkButton ID="btnApprove" runat="server"
                                                CssClass="btn btn-success btn-wide"
                                                CommandName="APPROVE"
                                                CommandArgument='<%# Eval("ben_id") %>'
                                                OnClientClick="return confirm('Approve and transfer this loan application to the new bank?');">
                                                <i class="fa-solid fa-circle-check me-2"></i>Approve Transfer
                                            </asp:LinkButton>

                                            <asp:LinkButton ID="btnReject" runat="server"
                                                CssClass="btn btn-danger btn-wide"
                                                CommandName="REJECT"
                                                CommandArgument='<%# Eval("ben_id") %>'
                                                OnClientClick="return confirm('Reject this transfer request?');">
                                                <i class="fa-solid fa-circle-xmark me-2"></i>Reject Transfer
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
</asp:View>

<asp:View ID="View2" runat="server">
    <asp:Button ID="btn_back1" runat="server" Text="Go Back" CssClass="btn btn-sm btn-danger" />
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


      <asp:Panel ID="Panel3" runat="server" Visible='<%#If(Convert.ToString(Eval("mpu_status_en")) = "Recommended by Union and Forwarded to Bank", "true", "false")  %>'>
        
          <div class="alert alert-success text-center fw-bold">
                 <b><u>  <%# Eval("mpu_name") %> </u></b>
            <%# Eval("mpu_status_en") %>  <br /> <%# Eval("mpu_status_ta") %> <br />
              <b><u>  <%# Eval("bank_name") %> </u></b><br />
              <strong><u>Remarks : </u></strong>   <%# Eval("mpu_remarks") %>
          </div>
                
      </asp:Panel>
      <asp:Panel ID="Panel4" runat="server" Visible='<%#If(Convert.ToString(Eval("mpu_status_en")) = "Rejected by Union", "true", "false")  %>'>

          <div class="alert alert-danger text-center fw-bold">
              <b><u>  <%# Eval("mpu_name") %> </u></b> <br />
            <%# Eval("mpu_status_en") %>  <br /> <%# Eval("mpu_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong>   <%# Eval("mpu_remarks") %>
          </div>

      </asp:Panel>
      <asp:Panel ID="Panel5" runat="server" Visible='<%#If(Convert.ToString(Eval("bank_status_en")) = "Under Processing", "true", "false")  %>'>

          <div class="alert alert-info text-center fw-bold">
              <b><u>  <%# Eval("bank_name") %> </u></b> <br />
                 <%# Eval("bank_status_en") %>  <br /> <%# Eval("bank_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong>   <%# Eval("bank_remarks") %>
          </div>
      </asp:Panel>
      <asp:Panel ID="Panel6" runat="server" Visible='<%#If(Convert.ToString(Eval("bank_status_en")) = "Loan is Sanctioned by Bank", "true", "false")  %>'>

          <div class="alert alert-success text-center fw-bold">
              <b><u>  <%# Eval("bank_name") %> </u></b> <br />
                 <%# Eval("bank_status_en") %>  <br /> <%# Eval("bank_status_ta") %> <br /> <br />
              <strong><u>Remarks : </u></strong>   <%# Eval("bank_remarks") %>
          </div>
      </asp:Panel>

      <asp:Panel ID="Panel7" runat="server" Visible='<%#If(Convert.ToString(Eval("bank_status_en")) = "Rejected by Union", "true", "false")  %>'>
          <div class="alert alert-danger text-center fw-bold">
               <b><u>  <%# Eval("bank_name") %> </u></b>
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


<!-- Document Viewer Modal -->
<div class="modal fade" id="uploadPopup" tabindex="-1" aria-labelledby="uploadPopupLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered modal-fullscreen-sm-down">
    <div class="modal-content">
      <div class="modal-header bg-gradient-primary-to-secondary text-white">
        <h5 class="modal-title" id="uploadPopupLabel">
          Document – <asp:Literal ID="ltl_doc_type" runat="server" />
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- Toolbar -->
      <div class="px-3 pt-3">
        <div class="btn-toolbar gap-2 flex-wrap" role="toolbar" aria-label="Viewer toolbar">
          <div class="btn-group me-2" role="group" aria-label="Zoom">
            <button type="button" class="btn btn-outline-dark" id="btnReset"><i class="bi bi-arrow-repeat"></i> Reset</button>
            <button type="button" class="btn btn-outline-primary" id="btnZoomIn"><i class="bi bi-zoom-in"></i> Zoom In</button>
            <button type="button" class="btn btn-outline-primary" id="btnZoomOut"><i class="bi bi-zoom-out"></i> Zoom Out</button>
            <button type="button" class="btn btn-outline-secondary" id="btnFitWidth"><i class="bi bi-arrows-expand"></i> Fit Width</button>
            <button type="button" class="btn btn-outline-secondary" id="btnActualSize"><i class="bi bi-aspect-ratio"></i> 100%</button>
          </div>

          <div class="btn-group me-2" role="group" aria-label="Rotate">
            <button type="button" class="btn btn-outline-primary" id="btnRotateLeft"><i class="bi bi-arrow-counterclockwise"></i> Rotate Left</button>
            <button type="button" class="btn btn-outline-primary" id="btnRotateRight"><i class="bi bi-arrow-clockwise"></i> Rotate Right</button>
          </div>



          <div class="ms-auto small text-muted d-none d-sm-flex align-items-center">
            <span id="lblZoom">100%</span>
          </div>
        </div>
      </div>

      <div class="modal-body pt-2">
        <!-- Viewport -->
        <div id="viewerViewport" class="viewer-viewport">
          <!-- Image target -->
          <div id="transformTarget" class="transform-target">
            <asp:Image ID="img_doc" runat="server" CssClass="viewer-image" />
          </div>

          
          
        </div>
      </div>

      <div class="modal-footer">
        <small class="text-muted me-auto">Tip: Drag to pan when zoomed in. Use mouse wheel to zoom.</small>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

    <script>
    function pageLoad() {
        $('.select2').select2({
            dropdownParent: $('.container').first() // fix if inside modals or overflow containers
        });
    }
    </script>
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
    <script src="/ASSETS/JS/loandocviewer.js"></script>

</asp:Content>
