<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ZMASTEREN.Master" CodeBehind="REGCOMP.aspx.vb" Inherits="MINIDAIRY.REGCOMP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head_place_holder" runat="server">
        <link href="/ASSETS/CSS/website_regform.css" rel="stylesheet" />
        <style>
        .tbd-card {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .tbd-header {
            background-color: #064bb6;
            color: white;
            padding: 20px;
            text-align: center;
            font-weight: bold;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }
        .table th {
            width: 40%;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" >
<ContentTemplate>
<section class="bg-gradient-primary-to-secondary text-center text-white py-4">
  <h5 class="fw-bold display-7 mb-2">Loan Applicant One Time Registration</h5>
  <h5 class="fw-bold">கடன் விண்ணப்பதாரர் ஒருமுறைப் பதிவு</h5>
</section>
<div class="container mt-5 mb-5">

    <div class="card m-5 border-success">
        <div class="card-header bg-success text-center" style="color:#ffffff; line-height:40px; font-size:20px;">
            <i class="fa fa-check-circle" style="font-size:50px;"></i>
            <br />
            Success !
        </div>
        <div class="card-body p-5" style="font-size:18px;">
            <table class="table table-borderless">
            <tr>
                <td><label class="font-weight-bold" style="font-size: 1.5rem;">Your Aavin Unique ID</label></td>
                <td>:</td>
                <td><asp:Label ID="lblUniqueId" runat="server" CssClass="font-weight-bold" style="font-size: 1.5rem;"></asp:Label></td>
            </tr>
            </table>
            <ul>
                <li>One time registration is completed successfully. 
                    <br />ஒரு முறை பதிவு வெற்றிகரமாக நிறைவடைந்தது.</li>
                <li>You can login by click the following link.
                    <br />பின்வரும் இணைப்பைக் கிளிக் செய்வதன் மூலம் நீங்கள் உள்நுழையலாம்.</ப>
                </li>
                <li>Use your mobile number / Aavin Mini Diary unique ID / Aadhar Number and password to sign-in.
                    <br />உங்கள் கைபேசி எண் / ஆவின் சிறிய பால் பண்ணை தனித்துவ எண் / ஆதார் எண் மற்றும் கடவுச்சொல்லைப் பயன்படுத்தி உள்நுழைவும்.
                </li>
            </ul>
             
            <div class="w-100 text-center m-3">
                <asp:Button ID="btn_click" runat="server" Text="Go to sign-in page. &#010; உள்நுழைவு பக்கத்திற்குச் செல்லவும்." CssClass="btn btn-success rounded-bg-opacity-25 pl-3 pr-3" />
               
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
