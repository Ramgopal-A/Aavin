<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ONLINE/BEN/ZMASTERBEN.Master" CodeBehind="LOANAPP.aspx.vb" Inherits="MINIDAIRY.LOANAPP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">
<div class="container my-4">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4">
        <h5 class="fw-bold text-primary mb-2 mb-md-0">
            <asp:Literal ID="ltl_page_title" runat="server" Text="LOAN APPLICATION - கடன் விண்ணப்பம்"></asp:Literal>
        </h5>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="/ONLINE/BEN" class="text-decoration-none text-primary fw-semibold">Dashboard</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">Loan Application</li>
            </ol>
        </nav>
    </div>
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>

<asp:HiddenField ID="hf_required_cows" runat="server" Value="4" />
<asp:HiddenField ID="hf_scheme_type" runat="server" Value="MINI" />

<div class="container my-4">

    <div id="errmsg" runat="server" class="alert alert-danger" visible="false"></div>

    <!-- Active Scheme Banner -->
    <div id="div_scheme_banner" runat="server" class="alert alert-info fw-semibold mb-3">
        <asp:Literal ID="ltl_scheme_banner" runat="server"></asp:Literal>
    </div>

<div class="card">

    <div class="card-header bg-gradient-primary-to-secondary text-white">
        Loan Application Form
    </div>

    <div class="card-body">

<div class="mb-3">
    <label for="<%=dd_thayumanavar.ClientID%>" class="form-label">
        Are you a member under Thayumanavar scheme? <br /> (நீங்கள் தாயுமானவர் திட்டத்தின் கீழ் உறுப்பினரா?)
        <span class="form-mandatory">*</span>
    </label>
    <asp:DropDownList ID="dd_thayumanavar" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1"></asp:DropDownList>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="dd_thayumanavar" InitialValue="0"
        ValidationGroup="vg1" ErrorMessage="Select Option (விருப்பத்தைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
</div>

<div class="mb-3">
    <label for="<%=dd_district.ClientID%>" class="form-label">
        District where the Dairy Farm is to be started <br /> (பால் பண்ணை தொடங்க உள்ள மாவட்டம்)
        <span class="form-mandatory">*</span>
    </label>
    <asp:DropDownList ID="dd_district" runat="server" CssClass="form-select form-select-sm select2" ValidationGroup="vg1" AutoPostBack="true"></asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfv_d" runat="server" ControlToValidate="dd_district" InitialValue="0"
        ValidationGroup="vg1" ErrorMessage="Select District (மாவட்டத்தைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
</div>

<div class="mb-3">
    <label for="<%=dd_union.ClientID%>" class="form-label">
        Milk Producers’ Union <br /> (பால் உற்பத்தியாளர்கள் கூட்டுறவு ஒன்றியம்)
        <span class="form-mandatory">*</span>
    </label>
    <asp:DropDownList ID="dd_union" runat="server" CssClass="form-select form-select-sm select2" ValidationGroup="vg1" AutoPostBack="true"></asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfv_u" runat="server" ControlToValidate="dd_union" InitialValue="0"
        ValidationGroup="vg1" ErrorMessage="Select Union (ஒன்றியத்தைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
</div>

<div class="mb-3">
    <label for="<%=dd_society.ClientID%>" class="form-label">
        Milk Producers’ Co-operative Society <br /> (பால் உற்பத்தியாளர்கள் கூட்டுறவு சங்கம்)
        <span class="form-mandatory">*</span>
    </label>
    <asp:DropDownList ID="dd_society" runat="server" CssClass="form-select form-select-sm select2" ValidationGroup="vg1"></asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfv_s" runat="server" ControlToValidate="dd_society" InitialValue="0"
        ValidationGroup="vg1" ErrorMessage="Select Society (கூட்டுறவு சங்கத்தைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
</div>

<div class="mb-3">
    <label for="<%=tb_membership_no.ClientID%>" class="form-label">
        Society Membership Number <br /> (சங்க உறுப்பினர் எண்)
        <span class="form-mandatory">*</span>
    </label>
    <asp:TextBox ID="tb_membership_no" runat="server" CssClass="form-control form-control-sm" MaxLength="20" ValidationGroup="vg1"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfv_mno" runat="server" ControlToValidate="tb_membership_no"
        ValidationGroup="vg1" ErrorMessage="Enter Membership Number (உறுப்பினர் எண் உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
</div>

<div class="mb-3">
    <label for="<%=dd_year.ClientID%>" class="form-label">
        Year of Joining the Society <br /> (சங்கத்தில் சேர்ந்த ஆண்டு)
        <span class="form-mandatory">*</span>
    </label>
    <asp:DropDownList ID="dd_year" runat="server" CssClass="form-select form-select-sm select2" ValidationGroup="vg1"></asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfv_y" runat="server" ControlToValidate="dd_year" InitialValue="0"
        ValidationGroup="vg1" ErrorMessage="Select Year (ஆண்டைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
</div>

<div class="mb-3">
    <label for="<%=dd_cow_count.ClientID%>" class="form-label">
        Number of Milch Cows Currently Owned <br /> (தற்போது வைத்திருக்கும் கறவை மாடுகளின் எண்ணிக்கை)
        <span class="form-mandatory">*</span>
        <span class="d-block small text-muted">
            <asp:Literal ID="ltl_cow_rule" runat="server"></asp:Literal>
        </span>
    </label>
    <asp:DropDownList ID="dd_cow_count" runat="server" CssClass="form-select form-select-sm select2" ValidationGroup="vg1"></asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfv_c" runat="server" ControlToValidate="dd_cow_count" InitialValue="0"
        ValidationGroup="vg1" ErrorMessage="Select Cow Count (மாட்டு எண்ணிக்கையைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
</div>

<div class="mb-3">
    <label for="<%=tb_milk_qty.ClientID%>" class="form-label">
        Quantity of Milk Supplied to the Society per Month (in litres) <br /> (சங்கத்துக்கு மாதந்தோறும் வழங்கப்படும் பால் அளவு - லிட்டர்)
        <span class="form-mandatory">*</span>
        <span class="d-block small text-muted">
            <asp:Literal ID="ltl_milk_rule" runat="server" Text="Enter total milk supplied per month in litres (மாதத்திற்கு வழங்கப்படும் மொத்த பால் அளவை லிட்டரில் உள்ளிடவும்)"></asp:Literal>
        </span>
    </label>
    <asp:TextBox ID="tb_milk_qty" runat="server" CssClass="form-control form-control-sm" MaxLength="6" ValidationGroup="vg1" oninput="this.value = this.value.replace(/[^0-9]/g, '');"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfv_mq" runat="server" ControlToValidate="tb_milk_qty"
        ValidationGroup="vg1" ErrorMessage="Enter Monthly Milk Quantity (மாத பால் அளவு உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
</div>

<div class="mb-3">
    <label for="<%=dd_cowshed.ClientID%>" class="form-label">
        Do you already have your own cow shed? <br /> (தங்களுக்கு சொந்தமான மாட்டு கொட்டகை உள்ளதா?)
        <span class="form-mandatory">*</span>
    </label>
    <asp:DropDownList ID="dd_cowshed" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1"></asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfv_cs" runat="server" ControlToValidate="dd_cowshed" InitialValue="0"
        ValidationGroup="vg1" ErrorMessage="Select Option (விருப்பத்தைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
</div>

<div class="mb-3">
    <label for="<%=dd_landspace.ClientID%>" class="form-label">
        Do you have land space for set up cow shed? <br /> (மாட்டு கொட்டகை அமைக்க நிலப்பரப்பு உங்களிடம் உள்ளதா?)
        <span class="form-mandatory">*</span>
    </label>
    <asp:DropDownList ID="dd_landspace" runat="server" CssClass="form-select form-select-sm" ValidationGroup="vg1"></asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfv_ls" runat="server" ControlToValidate="dd_landspace" InitialValue="0"
        ValidationGroup="vg1" ErrorMessage="Select Option (விருப்பத்தைத் தேர்ந்தெடுக்கவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
</div>

<div class="mb-3">
    <div class="row">
        <div class="col col-sm-12 col-md-12 col-lg-12 fw-semibold mb-2">
            <asp:Literal ID="ltl_cow_prompt" runat="server"
                Text="Number of cows/buffaloes proposed for loan (Up to <strong>4</strong>) <br /> கடனுக்காக முன்மொழியப்பட்ட பசுக்கள்/எருமைகள் எண்ணிக்கை (அதிகபட்சம் <strong>4</strong> வரை)">
            </asp:Literal>
        </div>
        <div class="col col-sm-12 col-md-4 col-lg-4">
             <label for="<%=tb_cnt1.ClientID%>" class="form-label">
                Crossbred Jersy (கலப்பின ஜெர்சி) <span class="form-mandatory">*</span>
            </label>
            <asp:TextBox ID="tb_cnt1" runat="server" CssClass="form-control form-control-sm" Text="0" MaxLength="1" ValidationGroup="vg1" oninput="this.value = this.value.replace(/[^0-9]/g, '');"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tb_cnt1"
                ValidationGroup="vg1" ErrorMessage="Enter Count (எண்ணிக்கையை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
       <div class="col col-sm-12 col-md-4 col-lg-4">
             <label for="<%=tb_cnt2.ClientID%>" class="form-label">
                 Crossbred Holstein Friesian (கலப்பின ஹோல்ஸ்டீன் ப்ரிசியன்) <span class="form-mandatory">*</span>
            </label>
            <asp:TextBox ID="tb_cnt2" runat="server" CssClass="form-control form-control-sm" Text="0" MaxLength="1" ValidationGroup="vg1" oninput="this.value = this.value.replace(/[^0-9]/g, '');"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tb_cnt2"
                ValidationGroup="vg1" ErrorMessage="Enter Count (எண்ணிக்கையை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="col col-sm-12 col-md-4 col-lg-4">
             <label for="<%=tb_cnt3.ClientID%>" class="form-label">
                 Buffalo (எருமை) <span class="form-mandatory">*</span>
            </label>
            <asp:TextBox ID="tb_cnt3" runat="server" CssClass="form-control form-control-sm" Text="0" MaxLength="1" ValidationGroup="vg1" oninput="this.value = this.value.replace(/[^0-9]/g, '');"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tb_cnt3"
                ValidationGroup="vg1" ErrorMessage="Enter Count (எண்ணிக்கையை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="col col-sm-12 col-md-12 col-lg-12 mt-1">
            <asp:CustomValidator ID="cv1" runat="server" ControlToValidate="tb_cnt3"
                ValidationGroup="vg1" ForeColor="Red" Display="Dynamic" ClientValidationFunction="validateTotalCow"
                ErrorMessage="The total number of cows and buffaloes must be between 1 and up to 4. (பசுக்கள் மற்றும் எருமைகளின் மொத்த எண்ணிக்கை 1 முதல் 4 வரை இருக்க வேண்டும்.)">
            </asp:CustomValidator>
        </div>
    </div>
</div>

<asp:Panel ID="pnl_medium_loan_details" runat="server" Visible="false" CssClass="border rounded p-3 mb-3 bg-light">
    <div class="fw-bold text-primary mb-2">
        Medium Dairy Scheme Financial Details / நடுத்தர பால் பண்ணைத் திட்ட நிதி விவரங்கள்
    </div>
    <div class="row g-3">
        <div class="col-md-6">
            <label for="<%=tb_proj_amt.ClientID%>" class="form-label">
                Project Amount (₹) / திட்ட மதிப்பீடு தொகை
                <span class="form-mandatory">*</span>
            </label>
            <asp:TextBox ID="tb_proj_amt" runat="server" CssClass="form-control form-control-sm" MaxLength="12" ValidationGroup="vg1"
                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                placeholder="Enter Project Amount (திட்டத் தொகையை உள்ளிடவும்)"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfv_proj_amt" runat="server" ControlToValidate="tb_proj_amt"
                ValidationGroup="vg1" ErrorMessage="Enter Project Amount (திட்டத் தொகையை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="col-md-6">
            <label for="<%=tb_loan_amt_req.ClientID%>" class="form-label">
                Requested Loan Amount (₹) / கோரப்படும் கடன் தொகை
                <span class="form-mandatory">*</span>
            </label>
            <asp:TextBox ID="tb_loan_amt_req" runat="server" CssClass="form-control form-control-sm" MaxLength="12" ValidationGroup="vg1"
                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                placeholder="Enter Requested Loan Amount (கோரப்படும் கடன் தொகையை உள்ளிடவும்)"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfv_loan_amt_req" runat="server" ControlToValidate="tb_loan_amt_req"
                ValidationGroup="vg1" ErrorMessage="Enter Requested Loan Amount (கோரப்படும் கடன் தொகையை உள்ளிடவும்)" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        <div class="col-12">
            <asp:CustomValidator ID="cv_loan_amt" runat="server" ControlToValidate="tb_loan_amt_req"
                ValidationGroup="vg1" ForeColor="Red" Display="Dynamic" ClientValidationFunction="validateMediumAmounts"
                ErrorMessage="Enter valid positive amounts; Requested Loan Amount cannot exceed Project Amount or ₹4,00,000 (4 Lakhs). (சரியான தொகையை உள்ளிடவும்; கோரப்படும் கடன் தொகை திட்டத் தொகையை விடவோ ₹4,00,000-க்கு விடவோ அதிகமாக இருக்கக் கூடாது.)">
            </asp:CustomValidator>
        </div>
    </div>
</asp:Panel>

        <div class="w-100 text-center">
            <asp:Button ID="btn_submit" runat="server" Text="Submit Loan Application &#010; (கடன் விண்ணப்பத்தை சமர்ப்பிக்கவும்)" CssClass="btn btn-success" ValidationGroup="vg1" />
        </div>

   </div>
</div>

</div>

<script type="text/javascript">
    // @ts-nocheck
    function pageLoad() {
        if (window.jQuery && window.jQuery.fn && window.jQuery.fn.select2) {
            window.jQuery('.select2').select2({
                dropdownParent: window.jQuery('.container').first()
            });
        }
    }

    function validateTotalCow(sender, args) {
        var reqInput = document.getElementById('<%= hf_required_cows.ClientID %>');
        var maxCount = reqInput ? (parseInt(reqInput.value, 10) || 4) : 4;

        var tb1 = document.getElementById('<%= tb_cnt1.ClientID %>');
        var tb2 = document.getElementById('<%= tb_cnt2.ClientID %>');
        var tb3 = document.getElementById('<%= tb_cnt3.ClientID %>');

        var v1 = parseInt(tb1.value, 10) || 0;
        var v2 = parseInt(tb2.value, 10) || 0;
        var v3 = parseInt(tb3.value, 10) || 0;

        var total = v1 + v2 + v3;
        args.IsValid = (total >= 1 && total <= maxCount);
    }

    function validateMediumAmounts(sender, args) {
        var projEl = document.getElementById('<%= tb_proj_amt.ClientID %>');
    var loanEl = document.getElementById('<%= tb_loan_amt_req.ClientID %>');

    if (!projEl || !loanEl) {
        args.IsValid = true;
        return;
    }

    var projAmt = parseFloat(projEl.value);
    var loanAmt = parseFloat(loanEl.value);
    var maxLoanAmt = 400000;

    args.IsValid = (
        !isNaN(projAmt) && projAmt > 0 &&
        !isNaN(loanAmt) && loanAmt > 0 &&
        loanAmt <= projAmt &&
        loanAmt <= maxLoanAmt
    );
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
</asp:Content>