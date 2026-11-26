<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MPFL/ADMIN/ZMASTERMPFLADMIN.Master" CodeBehind="Default.aspx.vb" Inherits="MINIDAIRY._Default5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
                :root {
    --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --success-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    --info-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
}

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 1rem;
        }
        
        .dashboard-header {
            text-align: center;
            margin-bottom: 3rem;
            animation: fadeInDown 0.8s ease;
        }
        
        .dashboard-header h1 {
            color: white;
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        
        .dashboard-header p {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 1rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.8s ease;
            animation-fill-mode: both;
        }
        
        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }
        .stat-card:nth-child(5) { animation-delay: 0.5s; }
        .stat-card:nth-child(6) { animation-delay: 0.6s; }
        .stat-card:nth-child(7) { animation-delay: 0.7s; }
        .stat-card:nth-child(8) { animation-delay: 0.8s; }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--card-color-1), var(--card-color-2));
        }
        
        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }
        
        .stat-card.received { --card-color-1: #667eea; --card-color-2: #764ba2; }
        .stat-card.pending { --card-color-1: #f093fb; --card-color-2: #f5576c; }
        .stat-card.recommended { --card-color-1: #4facfe; --card-color-2: #00f2fe; }
        .stat-card.rejected { --card-color-1: #fa709a; --card-color-2: #fee140; }
        .stat-card.union-recommended { --card-color-1: #30cfd0; --card-color-2: #330867; }
        .stat-card.union-rejected { --card-color-1: #4d2b97; --card-color-2: #7132ae; }
        .stat-card.sanctioned { --card-color-1: #43e97b; --card-color-2: #38f9d7; }
        .stat-card.bank-rejected { --card-color-1: #fa709a; --card-color-2: #f9c74f; }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--card-color-1), var(--card-color-2));
            color: white;
            animation: pulse 2s infinite;
        }
        
        .stat-content h3 {
            font-size: 0.95rem;
            color: #64748b;
            font-weight: 600;
            margin-bottom: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .stat-number {
            height: 60px;
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--card-color-1), var(--card-color-2));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            vertical-align:central;
        }
        
        .stat-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .stat-link::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--card-color-1), var(--card-color-2));
            transition: width 0.3s ease;
        }
        
        .stat-link:hover::after {
            width: 100%;
        }
        
        .stat-link:hover {
            gap: 0.75rem;
            color: #764ba2;
        }
        
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }
        
        @keyframes countUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
 
        
        @media (max-width: 768px) {
            .dashboard-header h1 {
                font-size: 1.8rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .stat-number {
                font-size: 1.5rem;
            }
        }

             

        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
        }


        .chart-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

            .chart-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(0,0,0,0.3);
            }


        .chart-container {
            position: relative;
            height: 300px;
            margin: 20px 0;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 3px solid #667eea;
        }

        .progress-item {
            margin-bottom: 20px;
        }

        .progress-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }

        .progress {
            height: 25px;
            border-radius: 15px;
            overflow: visible;
            background: #e9ecef;
        }

        .progress-bar {
            border-radius: 15px;
            transition: width 2s ease;
            animation: slideIn 2s ease;
        }

        @keyframes slideIn {
            from {
                width: 0;
            }
        }

        .badge-custom {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .floating {
            animation: floating 3s ease-in-out infinite;
        }

        @keyframes floating {
            0%, 100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-10px);
            }
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }

            50% {
                opacity: 0.5;
            }
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" >
<ContentTemplate>

    <div class="container my-4" style="margin-bottom:60px;">
    <div id="errmsg" runat="server" class="alert alert-danger alert-dismissible"></div>

    <div class="dashboard-container">
        
        <asp:ListView ID="lv_dashboard" runat="server">
            <ItemTemplate>
      
        <div class="stats-grid">

            <div class="stat-card received">
                <div class="row">
                    <div class="col">
 <div class="stat-icon">
     <i class="fas fa-file-invoice"></i>
 </div>
                    </div>
                    <div class="col">
 <div class="stat-number" data-target="<%#Eval("c_otr") %>">0</div>
                    </div>
                </div>

                
                <div class="stat-content">
                    <h3>One Time Registration</h3>
                    
                    <a href="/MPFL/ADMIN/LOAN/LISTOTR" class="stat-link">
 View Details <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>


            <div class="stat-card received">
                <div class="row">
                    <div class="col">
 <div class="stat-icon">
     <i class="fas fa-file-invoice"></i>
 </div>
                    </div>
                    <div class="col">
 <div class="stat-number" data-target="<%#Eval("c_app") %>">0</div>
                    </div>
                </div>

                
                <div class="stat-content">
                    <h3>Loan Applications Received</h3>
                    
                    <a href="/MPFL/ADMIN/LOAN/LISTALL" class="stat-link">
 View Details <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
            

      <div class="stat-card pending">
      <div class="row">
        <div class="col">
            <div class="stat-icon">
                <i class="fas fa-clock"></i>
            </div>
        </div>
        <div class="col">
            <div class="stat-number" data-target="<%#Eval("c_mpu_pend") %>">0</div>
        </div>
    </div>

    <div class="stat-content">
        <h3>Pending at Union</h3>
        <a href="/MPFL/ADMIN/LOAN/LISTMPUPEND" class="stat-link">
            View Details <i class="fas fa-arrow-right"></i>
        </a>
    </div>
</div>
            
            <div class="stat-card union-recommended">
                <div class="row">
                    <div class="col">
 <div class="stat-icon">
     <i class="fas fa-check-double"></i>
 </div>
                    </div>
                    <div class="col">
     <div class="stat-number" data-target="<%#Eval("c_mpu_rec") %>">0</div>
                    </div>
                </div>
                <div class="stat-content">
                    <h3>Recommended by Union</h3>
                    <a href="/MPFL/ADMIN/LOAN/LISTMPUREC" class="stat-link">
 View Details <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
            
            <div class="stat-card union-rejected">
                <div class="row">
                    <div class="col">
 <div class="stat-icon">
     <i class="fas fa-ban"></i>
 </div>
                    </div>
                    <div class="col">
<div class="stat-number" data-target="<%# Eval("c_mpu_rej") %>">0</div>
                    </div>
                </div>
                <div class="stat-content">
                    <h3>Rejected by Union</h3>
                    <a href="/MPFL/ADMIN/LOAN/LISTMPUREJ" class="stat-link">
 View Details <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>


 <div class="stat-card pending">
      <div class="row">
        <div class="col">
            <div class="stat-icon">
                <i class="fas fa-clock"></i>
            </div>
        </div>
        <div class="col">
            <div class="stat-number" data-target="<%#Eval("c_bank_pend") %>">0</div>
        </div>
    </div>

    <div class="stat-content">
        <h3>Pending at Bank</h3>
        <a href="/MPFL/ADMIN/LOAN/LISTBANKPEND" class="stat-link">
            View Details <i class="fas fa-arrow-right"></i>
        </a>
    </div>
</div>

 <div class="stat-card pending">
      <div class="row">
        <div class="col">
            <div class="stat-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
        </div>
        <div class="col">
            <div class="stat-number" data-target="<%#Eval("c_bank_chng") %>">0</div>
        </div>
    </div>

    <div class="stat-content">
        <h3>Pending at Bank</h3>
        <a href="/MPFL/ADMIN/LIST/BANKCNHGAPP" class="stat-link">
            View Details <i class="fas fa-arrow-right"></i>
        </a>
    </div>
</div>
            
            <div class="stat-card sanctioned">
                <div class="row">
                    <div class="col">
 <div class="stat-icon">
     <i class="fas fa-check-circle"></i>
 </div>
                    </div>
                    <div class="col">
 <div class="stat-number" data-target="<%# Eval("c_bank_rec") %>">0</div>
                    </div>
                </div>
                <div class="stat-content">
                    <h3>Sanctioned by Bank</h3>
                    <a href="/MPFL/ADMIN/LOAN/LISTBANKREC" class="stat-link">
 View Details <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
            
            <div class="stat-card bank-rejected">
                <div class="row">
                    <div class="col">
 <div class="stat-icon">
     <i class="fas fa-exclamation-triangle"></i>
 </div>
                    </div>
                    <div class="col">
 <div class="stat-number" data-target="<%# Eval("c_bank_rej") %>">0</div>
                    </div>
                </div>
                <div class="stat-content">
                    <h3>Rejected by Bank</h3>
                    <a href="/MPFL/ADMIN/LOAN/LISTBANKREJ" class="stat-link">
 View Details <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>
        
        
            </ItemTemplate>
        </asp:ListView>


        <div class="row">
            <div class="col-lg-4 animate__animated animate__fadeInLeft animate__delay-1s">
                <div class="chart-card">
                    <h3 class="card-title">👥 Gender Distribution</h3>
                    <div class="chart-container">
                        <canvas id="genderChart"></canvas>
                    </div>
                    <div class="mt-4">
                        <div class="progress-item">
                            <div class="progress-label">
                                <span>Male</span>
                                <span id="malePercent">0%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" style="width: 0%; background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);" id="maleProgress"></div>
                            </div>
                        </div>
                        <div class="progress-item">
                            <div class="progress-label">
                                <span>Female</span>
                                <span id="femalePercent">0%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" style="width: 0%; background: linear-gradient(90deg, #f093fb 0%, #f5576c 100%);" id="femaleProgress"></div>
                            </div>
                        </div>
                        <div class="progress-item">
                            <div class="progress-label">
                                <span>Transgender</span>
                                <span id="transPercent">0%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" style="width: 0%; background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);" id="transProgress"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 animate__animated animate__fadeInUp animate__delay-1s">
                <div class="chart-card">
                    <h3 class="card-title">🏘️ Community Breakdown</h3>
                    <div class="chart-container">
                        <canvas id="communityChart"></canvas>
                    </div>
                    <div class="mt-4">
                        <div class="progress-item">
                            <div class="progress-label">
                                <span>Others</span>
                                <span id="otherPercent">0%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" style="width: 0%; background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);" id="otherProgress"></div>
                            </div>
                        </div>
                        <div class="progress-item">
                            <div class="progress-label">
                                <span>SC</span>
                                <span id="scPercent">0%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" style="width: 0%; background: linear-gradient(90deg, #f093fb 0%, #f5576c 100%);" id="scProgress"></div>
                            </div>
                        </div>
                        <div class="progress-item">
                            <div class="progress-label">
                                <span>ST</span>
                                <span id="stPercent">0%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" style="width: 0%; background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);" id="stProgress"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 animate__animated animate__fadeInRight animate__delay-1s">
                <div class="chart-card">
                    <h3 class="card-title">🎯 Thayumanavar Scheme </h3>
            
                
                            <div class="chart-container">
                                <canvas id="schemeChart"></canvas>
                            </div>
                
                
                            <div class="mt-4">
                                <div class="progress-item">
                                    <div class="progress-label">
                                        <span>✅ Enrolled in Scheme</span>
                                        <span id="yesPercent">0%</span>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 0%; background: linear-gradient(90deg, #11998e 0%, #38ef7d 100%);" id="yesProgress"></div>
                                    </div>
                                </div>
                                <div class="progress-item">
                                    <div class="progress-label">
                                        <span>❌ Not Enrolled</span>
                                        <span id="noPercent">0%</span>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 0%; background: linear-gradient(90deg, #ee0979 0%, #ff6a00 100%);" id="noProgress"></div>
                                    </div>
                                </div>
                            </div>

            
                        </div>
                    </div>
                </div>




    </div>




    

</div>
 <asp:ListView ID="lv_dashboard_app" runat="server">
     <ItemTemplate>
<script>
    // Sample Data
    const data = {
        gender: {
            male: <%#Eval("c_m")%>,
            female: <%#Eval("c_f")%>,
            transgender: <%#Eval("c_t")%>
        },
        community: {
            general: <%#Eval("c_gen")%>,
            bc: <%#Eval("c_bc")%>,
            mbc: <%#Eval("c_mbc")%>,
            dnc: <%#Eval("c_dnc")%>,
            sc: <%#Eval("c_sc")%>,
            st: <%#Eval("c_st")%>
        },
        scheme: {
            yes: <%#Eval("c_thay_yes")%>,
            no: <%#Eval("c_thay_no")%>
        }
    };

    // Calculate totals
    const totalGender = data.gender.male + data.gender.female + data.gender.transgender;
    const totalScheme = data.scheme.yes + data.scheme.no;
    const others = data.community.general + data.community.bc + data.community.mbc + data.community.dnc;



    // Update progress bars
    setTimeout(() => {
        const malePercent = (data.gender.male / totalGender * 100).toFixed(1);
        const femalePercent = (data.gender.female / totalGender * 100).toFixed(1);
        const transPercent = (data.gender.transgender / totalGender * 100).toFixed(1);



        document.getElementById('maleProgress').style.width = malePercent + '%';
        document.getElementById('malePercent').textContent = malePercent + '%';
        document.getElementById('femaleProgress').style.width = femalePercent + '%';
        document.getElementById('femalePercent').textContent = femalePercent + '%';
        document.getElementById('transProgress').style.width = transPercent + '%';
        document.getElementById('transPercent').textContent = transPercent + '%';

        const otherPercent = (others / totalGender * 100).toFixed(1);
        const scPercent = (data.community.sc / totalGender * 100).toFixed(1);
        const stPercent = (data.community.st / totalGender * 100).toFixed(1);

        document.getElementById('otherProgress').style.width = otherPercent + '%';
        document.getElementById('otherPercent').textContent = otherPercent + '%';
        document.getElementById('scProgress').style.width = scPercent + '%';
        document.getElementById('scPercent').textContent = scPercent + '%';
        document.getElementById('stProgress').style.width = stPercent + '%';
        document.getElementById('stPercent').textContent = stPercent + '%';

        const yesPercent = (data.scheme.yes / totalScheme * 100).toFixed(1);
        const noPercent = (data.scheme.no / totalScheme * 100).toFixed(1);

        document.getElementById('yesProgress').style.width = yesPercent + '%';
        document.getElementById('yesPercent').textContent = yesPercent + '%';
        document.getElementById('noProgress').style.width = noPercent + '%';
        document.getElementById('noPercent').textContent = noPercent + '%';
    }, 500);

    // Gender Chart
    const genderCtx = document.getElementById('genderChart').getContext('2d');
    new Chart(genderCtx, {
        type: 'doughnut',
        data: {
            labels: ['Male', 'Female', 'Transgender'],
            datasets: [{
                data: [data.gender.male, data.gender.female, data.gender.transgender],
                backgroundColor: [
                    'rgba(102, 126, 234, 0.8)',
                    'rgba(245, 87, 108, 0.8)',
                    'rgba(79, 172, 254, 0.8)'
                ],
                borderWidth: 3,
                borderColor: '#fff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: { font: { size: 14 }, padding: 15 }
                }
            }
        }
    });

    // Community Chart
    const communityCtx = document.getElementById('communityChart').getContext('2d');
    new Chart(communityCtx, {
        type: 'doughnut',
        data: {
            labels: ['General', 'BC', 'MBC', 'DNC', 'SC', 'ST'],
            datasets: [{
                label: 'Population',
                data: [data.community.general, data.community.bc, data.community.mbc,
                data.community.dnc, data.community.sc, data.community.st],
                backgroundColor: [
                    'rgba(102, 126, 234, 0.8)',
                    'rgba(118, 75, 162, 0.8)',
                    'rgba(245, 87, 108, 0.8)',
                    'rgba(254, 225, 64, 0.8)',
                    'rgba(79, 172, 254, 0.8)',
                    'rgba(56, 239, 125, 0.8)'
                ],
                borderWidth: 2,
                borderColor: '#fff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: { font: { size: 14 }, padding: 15 }
                }
            }
        }
    });

    // Scheme Chart
    const schemeCtx = document.getElementById('schemeChart').getContext('2d');
    new Chart(schemeCtx, {
        type: 'pie',
        data: {
            labels: ['Enrolled', 'Not Enrolled'],
            datasets: [{
                data: [data.scheme.yes, data.scheme.no],
                backgroundColor: [
                    'rgba(56, 239, 125, 0.8)',
                    'rgba(238, 9, 121, 0.8)'
                ],
                borderWidth: 3,
                borderColor: '#fff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: { font: { size: 14 }, padding: 15 }
                }
            }
        }
    });
</script>

                    </ItemTemplate>
       </asp:ListView>

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
        <script>
            // Animated counter function
            function animateCounter(element) {
                const target = parseInt(element.getAttribute('data-target'));
                const duration = 2000;
                const step = target / (duration / 16);
                let current = 0;

                const timer = setInterval(() => {
                    current += step;
                    if (current >= target) {
 element.textContent = target;
 clearInterval(timer);
                    } else {
 element.textContent = Math.floor(current);
                    }
                }, 16);
            }

            // Intersection Observer for triggering animations when in viewport
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
 const counters = entry.target.querySelectorAll('.stat-number');
 counters.forEach(counter => {
     if (counter.textContent === '0') {
         animateCounter(counter);
     }
 });
                    }
                });
            }, { threshold: 0.5 });

            // Observe all stat cards
            document.querySelectorAll('.stat-card').forEach(card => {
                observer.observe(card);
            });

        </script>
</asp:Content>

