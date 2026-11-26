<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LOANAPP.aspx.vb" Inherits="MINIDAIRY.LOANAPP1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Loan Application Print</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style type="text/css">
        body {
            font-family: "Segoe UI", system-ui, -apple-system, BlinkMacSystemFont, "Helvetica Neue", Arial, sans-serif;
            background-color: #f5f7fa;
        }

        .print-container {
            max-width: 900px;
            margin: 20px auto;
        }

        .card-print {
            border-radius: 0.75rem;
            box-shadow: 0 0.5rem 1.5rem rgba(15, 23, 42, 0.15);
            border: 1px solid #e2e8f0;
        }

        .section-title {
            font-weight: 700;
            margin-top: 1.25rem;
            margin-bottom: 0.75rem;
            font-size: 1.05rem;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            color: #1f2937;
        }

        table.table-sm td,
        table.table-sm th {
            padding: 0.25rem 0.5rem !important;
        }

        /* Print settings */
        @page {
            size: A4 portrait;
            margin: 10mm;
        }

        @media print {
            body {
                background-color: #ffffff !important;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }

            .card-print {
                box-shadow: none !important;
                border: none !important;
            }

            .page-break {
                page-break-after: always;
            }

            .page-break-before {
                page-break-before: always;
            }

            .no-print {
                display: none !important;
            }
        }

        /* Document images (A4 fit) */
        .doc-page {
            width: 100%;
            min-height: 270mm;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .doc-image {
            max-width: 100%;
            max-height: 260mm;
            height: auto;
            object-fit: contain;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            box-shadow: 0 0.5rem 1.5rem rgba(15, 23, 42, 0.25);
        }

        .header-logo img {
            border-radius: 0.5rem;
        }
    </style>

    <script type="text/javascript">
        // Auto print when page is fully loaded
        window.addEventListener('load', function () {
            window.print();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" class="print-container">

        <!-- Main Loan Application (first A4 page, can extend to more if content is long) -->
        <div class="card card-print mb-4">
            <div class="card-body p-4">

                <asp:ListView ID="lv_loan_app" runat="server">
                    <ItemTemplate>

                        <table class="table table-borderless table-sm align-middle">
                            <tr>
                                <td class="text-start header-logo">
                                    <img src="/ASSETS/IMAGES/logo_avin.jpg" class="img-fluid" style="max-width:150px; max-height:150px;" />
                                </td>
                                <td class="text-center header-logo">
                                    <img src="/ASSETS/IMAGES/logo_tn.jpg" class="img-fluid" style="max-width:150px; max-height:150px;" /><br />
                                </td>
                                <td class="text-end">
                                    <asp:Image ID="img_qr" runat="server" CssClass="img-fluid rounded shadow" Style="max-width:150px; max-height:150px;" />
                                </td>
                            </tr>
                        </table>

                        <h3 class="text-center fw-bold mb-2"><u>பால் வளத்துறை</u></h3>

                        <h5 class="text-center fw-bold mb-3">
                            தமிழ்நாடு அரசின் சிறு பால் பண்ணைத் திட்டம்<br />
                            <small class="d-block">Member Registration / உறுப்பினர் பதிவு</small>
                            <small class="d-block mt-1">Member No : <%# Eval("ben_avinid") %></small>
                        </h5>

                        <div class="section-title">1. Personal Details</div>
                        <table class="table table-sm table-bordered">
                            <tr>
                                <td style="width:20px;">1.</td>
                                <td class="w-25 px-3">Name *</td>
                                <td class="px-3"><%# Eval("ben_name") %></td>
                                <td rowspan="4" style="width:200px;">
                                    <asp:Image ID="img_photo" runat="server" CssClass="img-fluid rounded shadow w-100 h-100" />
                                </td>
                            </tr>
                            <tr>
                                <td>2.</td>
                                <td class="px-3">Father / Husband Name</td>
                                <td class="px-3"><%# Eval("care_of") %>.<%# Eval("ben_fh_name") %></td>
                            </tr>
                            <tr>
                                <td>3.</td>
                                <td>Date of Birth (dd-mm-yyyy)</td>
                                <td><%# Eval("ben_dob", "{0:dd-MM-yyyy}") %></td>
                            </tr>
                            <tr>
                                <td>4.</td>
                                <td>Age </td>
                                <td><%# Eval("ben_age") %></td>
                            </tr>
                            <tr>
                                <td>5.</td>
                                <td>Gender </td>
                                <td colspan="2"><%# Eval("ben_gender") %></td>
                            </tr>
                            <tr>
                                <td>6.</td>
                                <td>Community </td>
                                <td colspan="2">
                                    <%# Eval("comm_name") %> <br />
                                    <%# Eval("caste_name") %> <br />
                                    Community Certificate No. : <%# Eval("community_cert") %>
                                </td>
                            </tr>
                            <tr>
                                <td>7.</td>
                                <td>Is the applicant a Destitute widow?</td>
                                <td colspan="2"><%# Eval("ben_widow") %></td>
                            </tr>
                            <tr>
                                <td>8.</td>
                                <td>Is the applicant a member of the Thayumanavar scheme?</td>
                                <td colspan="2"><%# Eval("ben_thayumanavar") %></td>
                            </tr>
                            <tr>
                                <td>9.</td>
                                <td>Mobile Number </td>
                                <td colspan="2"><%# Eval("ben_mobile_no") %></td>
                            </tr>
                            <tr>
                                <td>10.</td>
                                <td>Smart Family Card No.</td>
                                <td><%# Eval("ben_nfsc") %></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>11.</td>
                                <td>Aadhar Card No.</td>
                                <td><%# Eval("ben_aadhar") %></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>12.</td>
                                <td>PAN Card No *</td>
                                <td><%# Eval("ben_pan") %></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>13.</td>
                                <td>Address as in Aadhar</td>
                                <td colspan="2">
                                    <%# Eval("ben_addr") %><br />
                                    Village : <%# Eval("village") %><br />
                                    Taluk : <%# Eval("taluk") %><br />
                                    District : <%# Eval("district") %> - Pincode: <%# Eval("ben_pincode") %><br />
                                </td>
                            </tr>
                            <tr>
                                <td>14.</td>
                                <td>Present Address</td>
                                <td colspan="2">
                                    <%# Eval("ben_paddr") %><br />
                                    District : <%# Eval("pdistrict") %> - Pincode: <%# Eval("ben_ppincode") %><br />
                                </td>
                            </tr>
                        </table>

                        <div class="section-title">2. Member Based Society Details</div>
                        <table class="table table-bordered table-sm">
                            <tr>
                                <td>1.</td>
                                <td>District Union Name</td>
                                <td colspan="2"><%# Eval("mpu_name") %></td>
                            </tr>
                            <tr>
                                <td>2.</td>
                                <td>District Name</td>
                                <td colspan="2"><%# Eval("loan_district") %></td>
                            </tr>
                            <tr>
                                <td>3.</td>
                                <td>Milk Supplying Society Name</td>
                                <td colspan="2"><%# Eval("mpcs_name") %></td>
                            </tr>
                            <tr>
                                <td>4.</td>
                                <td>Member ID</td>
                                <td><%# Eval("mpcs_member_no") %></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>5.</td>
                                <td>Number of milch cows currently have</td>
                                <td colspan="2"><%# Eval("having_no_of_cow") %></td>
                            </tr>
                            <tr>
                                <td>6.</td>
                                <td>Quantity of Milk Supplied to Society (in Litres)</td>
                                <td colspan="2"><%# Eval("milk_qty") %> litres</td>
                            </tr>
                            <tr>
                                <td>7.</td>
                                <td>Do the applicant already has own cow shed?</td>
                                <td colspan="2"><%# Eval("has_cow_shed") %></td>
                            </tr>
                            <tr>
                                <td>8.</td>
                                <td>Do you have land space for setup cow shed?</td>
                                <td colspan="2"><%# Eval("has_space_for_cow_shed") %></td>
                            </tr>
                            <tr>
                                <td>9.</td>
                                <td>Cattle/buffalo breed to be selected for the farm</td>
                                <td colspan="2">
                                    <table class="table table-sm table-bordered mb-0">
                                        <tr>
                                            <td>Crossbred Jersy</td>
                                            <td>Crossbred Holstein Friesian</td>
                                            <td>Buffalo</td>
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
                                <td>
                                    Bank Name : <%# Eval("ben_bank_name") %><br />
                                    Branch Name : <%# Eval("ben_branch_name") %><br />
                                    Account Number : <%# Eval("ben_bank_acc_no") %><br />
                                    IFSC : <%# Eval("ben_ifsc") %><br />
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>12.</td>
                                <td>Chitta / Adangal / Lease Agreement</td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>

                        <!-- Panels as in your original code (status/remarks) -->
                        <asp:Panel ID="Panel1" runat="server" Visible='<%#If(Convert.ToString(Eval("mpcs_status_en")) = "Recommended by Society and Forwarded to Union", "true", "false")  %>'>
                            <table class="table table-bordered text-center align-middle table-sm">
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
                                        <td>Verified the Member Name as per the Society Record <br /> சங்க பதிவுகளின்படி உறுப்பினர் பெயர் சரிபார்க்கப்பட்டது</td>
                                        <td><%#Eval("mpcs_name_verified") %></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Verified the Membership Number as per the Society Record <br /> சங்க பதிவுகளின்படி உறுப்பினர் எண் சரிபார்க்கப்பட்டது</td>
                                        <td><%#Eval("mpcs_member_no_verified") %></td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Verified the Joining Year of the Member as per the Society Record <br /> சங்க பதிவுகளின்படி உறுப்பினர் சேர்ந்த ஆண்டு சரிபார்க்கப்பட்டது</td>
                                        <td><%#Eval("mpcs_join_year_verified") %></td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>Verified the Age of the Member as per the Society Record <br /> சங்க பதிவுகளின்படி உறுப்பினர் வயது சரிபார்க்கப்பட்டது</td>
                                        <td><%#Eval("mpcs_age_verified") %></td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>Verified the Quantity of Milk (in litres) Supplied as per the Society Record <br /> சங்க பதிவுகளின்படி விநியோகிக்கப்பட்ட பால் அளவு (லிட்டர்களில்) சரிபார்க்கப்பட்டது</td>
                                        <td><%#Eval("mpcs_milk_qty_verified") %></td>
                                    </tr>
                                </tbody>
                            </table>

                            <table class="table table-bordered table-sm">
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
                                        <b><%#Eval("ben_name") %></b> என்ற உறுப்பினருக்கு <b><%#Eval("ben_bank_name") %></b> என்ற வங்கியின் <b><%#Eval("ben_branch_name") %> (IFSC : <%#Eval("ben_ifsc") %>)</b> கிளையில் உள்ள <b><%#Eval("ben_bank_acc_no") %></b> வங்கி கணக்கிற்கு பால் பணம் பட்டுவாடா செய்யப்படுகிறது என சான்றளிக்கிறேன்.
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <b><%#Eval("ben_name") %></b> என்ற உறுப்பினருக்கு சிறிய அளவிலான பால் பண்ணைத் திட்டத்தின் கீழ் வங்கி கடன் வழங்க பரிந்துரை செய்கிறேன்.
                                    </td>
                                </tr>
                            </table>

                            <div class="alert alert-success text-center fw-bold">
                                <%# Eval("mpcs_status_en") %> <br />
                                <%# Eval("mpcs_status_ta") %> <br /><br />
                                <strong><u>Remarks : </u></strong> <%# Eval("mpcs_remarks") %>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel2" runat="server" Visible='<%#If(Convert.ToString(Eval("mpcs_status_en")) = "Rejected by Society", "true", "false")  %>'>
                            <div class="alert alert-danger text-center fw-bold">
                                <%# Eval("mpcs_status_en") %> <br />
                                <%# Eval("mpcs_status_ta") %> <br /><br />
                                <strong><u>Remarks : </u></strong> <%# Eval("mpcs_remarks") %>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel3" runat="server" Visible='<%#If(Convert.ToString(Eval("mpu_status_en")) = "Recommended by Union and Forwarded to Bank", "true", "false")  %>'>
                            <div class="alert alert-success text-center fw-bold">
                                <%# Eval("mpu_status_en") %> <br />
                                <%# Eval("mpu_status_ta") %> <br /><br />
                                <strong><u>Remarks : </u></strong> <%# Eval("mpu_remarks") %>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel4" runat="server" Visible='<%#If(Convert.ToString(Eval("mpu_status_en")) = "Rejected by Union", "true", "false")  %>'>
                            <div class="alert alert-danger text-center fw-bold">
                                <%# Eval("mpu_status_en") %> <br />
                                <%# Eval("mpu_status_ta") %> <br /><br />
                                <strong><u>Remarks : </u></strong> <%# Eval("mpu_remarks") %>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel5" runat="server" Visible='<%#If(Convert.ToString(Eval("bank_status_en")) = "Rejected by Union", "true", "false")  %>'>
                            <div class="alert alert-success text-center fw-bold">
                                <%# Eval("bank_status_en") %> <br />
                                <%# Eval("bank_status_ta") %> <br /><br />
                                <strong><u>Remarks : </u></strong> <%# Eval("bank_remarks") %>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel6" runat="server" Visible='<%#If(Convert.ToString(Eval("bank_status_en")) = "Rejected by Union", "true", "false")  %>'>
                            <div class="alert alert-danger text-center fw-bold">
                                <%# Eval("bank_status_en") %> <br />
                                <%# Eval("bank_status_ta") %> <br /><br />
                                <strong><u>Remarks : </u></strong> <%# Eval("bank_remarks") %>
                            </div>
                        </asp:Panel>

                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>

        <!-- Each supporting document image on its own A4 page -->
        <div class="page-break-before doc-page text-center">
            <asp:Image ID="img_adhar" runat="server" CssClass="doc-image" />
        </div>

        <div class="page-break doc-page text-center">
            <asp:Image ID="img_pan" runat="server" CssClass="doc-image" />
        </div>

        <div class="page-break doc-page text-center">
            <asp:Image ID="img_sfc" runat="server" CssClass="doc-image" />
        </div>

        <div class="page-break doc-page text-center">
            <asp:Image ID="img_chitta" runat="server" CssClass="doc-image" />
        </div>

        <div class="page-break doc-page text-center">
            <asp:Image ID="img_adangal" runat="server" CssClass="doc-image" />
        </div>

        <div class="page-break doc-page text-center">
            <asp:Image ID="img_authltr" runat="server" CssClass="doc-image" />
        </div>

        <div class="page-break doc-page text-center">
            <asp:Image ID="img_passbook" runat="server" CssClass="doc-image" />
        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
