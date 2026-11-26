<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MPCS/ZMASTERMPCS.Master" CodeBehind="Default.aspx.vb" Inherits="MINIDAIRY._Default4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
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
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" >
<ContentTemplate>

    <div class="container my-4">

    <div class="dashboard-container">
        
        
        <div class="stats-grid">
            <div class="stat-card received">
                <div class="row">
                    <div class="col">
 <div class="stat-icon">
     <i class="fas fa-file-invoice"></i>
 </div>
                    </div>
                    <div class="col">
 <div class="stat-number" data-target="247">0</div>
                    </div>
                </div>

                
                <div class="stat-content">
                    <h3>Loan Applications Received</h3>
                    
                    <a href="#/applications/received" class="stat-link">
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
 <div class="stat-number" data-target="42">0</div>
                    </div>
                </div>

                <div class="stat-content">
                    <h3>Pending at Society</h3>
                    <a href="#/applications/pending-society" class="stat-link">
 View Details <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
            
            <div class="stat-card recommended">
                  <div class="row">
                    <div class="col">
 <div class="stat-icon">
     <i class="fas fa-thumbs-up"></i>
 </div>
                    </div>
                    <div class="col">
 <div class="stat-number" data-target="189">0</div>
                    </div>
                </div>

                <div class="stat-content">
                    <h3>Recommended by Society</h3>
                    <a href="#/applications/recommended-society" class="stat-link">
 View Details <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
            
            <div class="stat-card rejected">
                <div class="row">
                    <div class="col">
 <div class="stat-icon">
     <i class="fas fa-times-circle"></i>
 </div>
                    </div>
                    <div class="col">
 <div class="stat-number" data-target="16">0</div>
                    </div>
                </div>
                <div class="stat-content">
                    <h3>Rejected by Society</h3>
                    <a href="#/applications/rejected-society" class="stat-link">
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
     <div class="stat-number" data-target="156">0</div>
                    </div>
                </div>
                <div class="stat-content">
                    <h3>Recommended by Union</h3>
                    <a href="#/applications/recommended-union" class="stat-link">
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
<div class="stat-number" data-target="33">0</div>
                    </div>
                </div>
                <div class="stat-content">
                    <h3>Rejected by Union</h3>
                    <a href="#/applications/rejected-union" class="stat-link">
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
 <div class="stat-number" data-target="128">0</div>
                    </div>
                </div>
                <div class="stat-content">
                    <h3>Sanctioned by Bank</h3>
                    <a href="#/applications/sanctioned-bank" class="stat-link">
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
 <div class="stat-number" data-target="28">0</div>
                    </div>
                </div>
                <div class="stat-content">
                    <h3>Rejected by Bank</h3>
                    <a href="#/applications/rejected-bank" class="stat-link">
 View Details <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
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

            // Add click event for links (in real application, these would navigate to actual pages)
            document.querySelectorAll('.stat-link').forEach(link => {
                link.addEventListener('click', (e) => {
                    e.preventDefault();
                    const href = link.getAttribute('href');
                    console.log('Navigating to:', href);
                    alert('In a real application, this would navigate to: ' + href);
                });
            });
        </script>
</asp:Content>
