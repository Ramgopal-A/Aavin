<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LoanStatus.ascx.vb" Inherits="MINIDAIRY.LoanStatus" %>


<style>


    .container {
        background: white;
        padding: 40px 30px;
        border-radius: 20px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        max-width: 1200px;
        width: 100%;
        margin: auto;
    }

    .process-flow {
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: relative;
        flex-wrap: wrap;
        gap: 20px;
    }

    .step {
        display: flex;
        flex-direction: column;
        align-items: center;
        position: relative;
        flex: 1;
        min-width: 120px;
        transition: all 0.3s ease;
    }

    .step-header {
        text-align: center;
        margin-bottom: 20px;
        min-height: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .step-title { font-size: 16px; font-weight: bold; line-height: 1.3; }

    .circle {
        width:60px; height: 60px;
        border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        font-size: 30px; font-weight: bold; color: white;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        position: relative; transition: all 0.3s ease;
    }

    .arrow {
        position: absolute;
        right: -40px;
        top: 50%;
        transform: translateY(-50%);
        width: 0; height: 0;
        border-top: 15px solid transparent;
        border-bottom: 15px solid transparent;
        border-left: 25px solid #0284c7;
        z-index: 1;
    }

    .step:last-child .arrow { display: none; }

    .step-description {
        margin-top: 20px;
        text-align: center;
        font-size: 16px;
        font-weight: 600;
        line-height: 1.4;
        min-height: 50px;
        display: flex; align-items: center; justify-content: center;
    }

    .connector-line {
        position: absolute;
        height: 3px;
        background: #0284c7;
        top: 50%;
        left: 60px;
        right: 60px;
        z-index: 0;
    }

    /* Default Colors */
    .step-default .circle, .arrow { background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); }
    .step-default .step-title, .step-default .step-description { color: #0284c7; }

    /* Active (Green) */
    .step-active .circle, .arrow { background: linear-gradient(135deg, #10b981 0%, #059669 100%); }
    .step-active .step-title, .step-active .step-description { color: #10b981; }

    /* Rejected (Red) */
    .step-rejected .circle, .arrow  { background: linear-gradient(135deg, #e53935 0%, #b71c1c 100%); }
    .step-rejected .step-title, .step-rejected .step-description { color: #e53935; }

    @media (max-width: 768px) {
        .process-flow { flex-direction: column; gap: 60px; }
        .arrow { left: 50%; top: auto; bottom: -50px; transform: translateX(-50%) rotate(90deg); }
    }
</style>

<div class="container">
    <div class="process-flow">

        <div id="step1" runat="server" class="step step-default">
            <div class="step-header">
                <div class="step-title">Applicant</div>
            </div>
            <div class="circle">1</div>
            <div id="arrow1" runat="server" class="arrow"></div>
            <div id="desc1" runat="server" class="step-description">Loan Application Submitted</div>
        </div>

        <div id="step2" runat="server" class="step step-default">
            <div class="step-header">
                <div class="step-title">Milk Producer<br>Cooperative Society</div>
            </div>
            <div class="circle">2</div>
            <div id="arrow2" runat="server" class="arrow"></div>
            <div id="desc2" runat="server" class="step-description">Under Processing</div>
        </div>

        <div id="step3" runat="server" class="step step-default">
            <div class="step-header">
                <div class="step-title">Milk Producer<br>Union</div>
            </div>
            <div class="circle">3</div>
            <div id="arrow3" runat="server" class="arrow"></div>
            <div id="desc3" runat="server" class="step-description"></div>
        </div>

        <div id="step4" runat="server" class="step step-default">
            <div class="step-header">
                <div class="step-title">Bank</div>
            </div>
            <div class="circle">4</div>
            <div id="desc4" runat="server" class="step-description"></div>
        </div>

    </div>
</div>
