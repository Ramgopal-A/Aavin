<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/ZMASTEREN.Master" CodeBehind="Default.aspx.vb" Inherits="MINIDAIRY._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head_place_holder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Hero Section with Carousel -->
    <section class="hero-section" id="home" data-aos="fade-in">
        <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="5000">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"></button>
            </div>
            
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="hero-slide" style="background: linear-gradient(135deg, rgba(30, 64, 175, 0.9), rgba(59, 130, 246, 0.9))">
 <div class="container">
     <div class="hero-content text-center">
         <h1 class="hero-title" data-aos="fade-up" data-aos-delay="200">Mini Dairy Scheme</h1>
         <p class="hero-subtitle" data-aos="fade-up" data-aos-delay="400">
             Empowering Milk Producers with Financial Support and Technical Guidance
         </p>
         <a href="#application" class="cta-button" data-aos="fade-up" data-aos-delay="600">
             Apply Now <i class="fas fa-arrow-right ms-2"></i>
         </a>
     </div>
 </div>
                    </div>
                </div>
                
                <!-- Slide 2 -->
                <div class="carousel-item">
                    <div class="hero-slide" style="background: linear-gradient(135deg, rgba(5, 150, 105, 0.9), rgba(16, 185, 129, 0.9))">
 <div class="container">
     <div class="hero-content text-center">
         <h1 class="hero-title" data-aos="fade-up" data-aos-delay="200">Bank Loan Facilities</h1>
         <p class="hero-subtitle" data-aos="fade-up" data-aos-delay="400">
             Get financial assistance with interest subsidy for sustainable dairy farming
         </p>
         <a href="#eligibility" class="cta-button" data-aos="fade-up" data-aos-delay="600">
             Check Eligibility <i class="fas fa-user-check ms-2"></i>
         </a>
     </div>
 </div>
                    </div>
                </div>
                
                <!-- Slide 3 -->
                <div class="carousel-item">
                    <div class="hero-slide" style="background: linear-gradient(135deg, rgba(245, 158, 11, 0.9), rgba(251, 191, 36, 0.9))">
 <div class="container">
     <div class="hero-content text-center">
         <h1 class="hero-title" data-aos="fade-up" data-aos-delay="200">Technical Support</h1>
         <p class="hero-subtitle" data-aos="fade-up" data-aos-delay="400">
             Comprehensive training, insurance, and monitoring for your dairy farm
         </p>
         <a href="#support" class="cta-button" data-aos="fade-up" data-aos-delay="600">
             Learn More <i class="fas fa-graduation-cap ms-2"></i>
         </a>
     </div>
 </div>
                    </div>
                </div>
            </div>
            
            <!-- Carousel Controls -->
            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>
    </section>

    <!-- Implementation Section -->
    <section class="section" id="about" style="background: var(--bg-light);">
        <div class="container">
            <h2 class="section-title" data-aos="fade-up">Scheme Implementation</h2>
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="feature-card" data-aos="fade-up" data-aos-delay="200">
 <div class="text-center">
     <div class="feature-icon">
         <i class="fas fa-users"></i>
     </div>
     <h3 class="feature-title">27 Milk Producers Co-operative Unions</h3>
     <p class="lead">This scheme is implemented for milk producers who are members of 27 Milk Producers Co-operative Unions, by providing bank loan facilities with interest subsidy for sustainable dairy farming.</p>
 </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Statistics Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-6">
                    <div class="stat-item" data-aos="fade-up" data-aos-delay="100">
 <div class="stat-number">₹ 2.7 Lakhs</div>
 <div class="stat-label">Maximum Loan Amount</div>
                    </div>
                </div>
                <div class="col-md-4 col-6">
                    <div class="stat-item" data-aos="fade-up" data-aos-delay="300">
 <div class="stat-number">4</div>
 <div class="stat-label">Cows/Heifers per Beneficiary</div>
                    </div>
                </div>
                <div class="col-md-4 col-6">
                    <div class="stat-item" data-aos="fade-up" data-aos-delay="400">
 <div class="stat-number">3</div>
 <div class="stat-label">Years Insurance Coverage</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Eligibility Section -->
    <section class="section" id="eligibility">
        <div class="container">
            <h2 class="section-title" data-aos="fade-up">Eligibility of Beneficiaries</h2>
            <div class="eligibility-grid">
                <div class="eligibility-card" data-aos="fade-up" data-aos-delay="100">
                    <h4><i class="fas fa-user-check text-success me-2"></i> Membership</h4>
                    <p>Regular or associate pouring members of Milk Producers Co-operative Societies</p>
                </div>
                <div class="eligibility-card" data-aos="fade-up" data-aos-delay="200">
                    <h4><i class="fas fa-calendar-alt text-primary me-2"></i> Age Criteria</h4>
                    <p>Beneficiaries should be between 21 to 60 years old</p>
                </div>
                <div class="eligibility-card" data-aos="fade-up" data-aos-delay="300">
                    <h4><i class="fas fa-seedling text-success me-2"></i> Thayumanavar Priority</h4>
                    <p>Priority for the milk pouring members registered under Thayumanavar Scheme</p>
                </div>
                <div class="eligibility-card" data-aos="fade-up" data-aos-delay="300">
                    <h4><i class="fas fa-seedling text-success me-2"></i> Land Ownership</h4>
                    <p>Priority for those owning or leasing minimum 0.50 acres of land</p>
                </div>
                <div class="eligibility-card" data-aos="fade-up" data-aos-delay="400">
                    <h4><i class="fas fa-venus text-info me-2"></i> Women Priority</h4>
                    <p>30% of beneficiaries should be women milk producers</p>
                </div>
                <div class="eligibility-card" data-aos="fade-up" data-aos-delay="400">
                    <h4><i class="fas fa-venus text-info me-2"></i> Scheduled Caste Priority</h4>
                    <p>18% of beneficiaries should be Scheduled Caste</p>
                </div>
                <div class="eligibility-card" data-aos="fade-up" data-aos-delay="400">
                    <h4><i class="fas fa-venus text-info me-2"></i> Scheduled Tribe Priority</h4>
                    <p>1% of beneficiaries should be Scheduled Tribe</p>
                </div>

                <div class="eligibility-card" data-aos="fade-up" data-aos-delay="500">
                    <h4><i class="fas fa-cow text-warning me-2"></i> Existing Animals</h4>
                    <p>Must maintain at least one milch animal and produce milk</p>
                </div>
                <div class="eligibility-card" data-aos="fade-up" data-aos-delay="600">
                    <h4><i class="fas fa-university text-primary me-2"></i> Bank Account</h4>
                    <p>Must have account in society's bank for milk payment transfers</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Application Process -->
    <section class="section" style="background: var(--bg-light);" id="application">
        <div class="container">
            <h2 class="section-title" data-aos="fade-up">Application Process</h2>
            <div class="process-timeline">
                <div class="timeline-item" data-aos="fade-right" data-aos-delay="100">
                    <div class="timeline-number">1</div>
                    <div class="timeline-content">
 <h4>Online Application</h4>
 <p>Submit your application through the dedicated online portal for the Mini Dairy Farm Scheme. Get assistance from Veterinary Doctor, Milk Society Secretary, or Extension Officer if needed.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-left" data-aos-delay="200">
                    <div class="timeline-number">2</div>
                    <div class="timeline-content">
 <h4>Document Submission</h4>
 <p>Upload required documents including Aadhaar Card, PAN Card, Family Card, Bank Passbook,Applicant's Passport Size Photos, Chitta & Adangal, and Society membership proof.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-right" data-aos-delay="300">
                    <div class="timeline-number">3</div>
                    <div class="timeline-content">
 <h4>Application Scrutiny</h4>
 <p>Applications are scrutinized by designated committee members and forwarded to banks through the online portal. SMS notifications for status updates.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-left" data-aos-delay="400">
                    <div class="timeline-number">4</div>
                    <div class="timeline-content">
 <h4>Loan Approval</h4>
 <p>Bank processes the loan application and disburses funds. Sign tripartite agreement with bank and Milk Society Secretary for loan recovery.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Required Documents -->
    <section class="section" id="documents">
        <div class="container">
            <h2 class="section-title" data-aos="fade-up">Required Documents</h2>
            <div class="row">
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="document-card" data-aos="fade-up" data-aos-delay="100">
 <div class="document-icon"><i class="fas fa-id-card"></i></div>
 <h5>Aadhaar Card</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="document-card" data-aos="fade-up" data-aos-delay="200">
 <div class="document-icon"><i class="fas fa-credit-card"></i></div>
 <h5>PAN Card</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="document-card" data-aos="fade-up" data-aos-delay="300">
 <div class="document-icon"><i class="fas fa-users"></i></div>
 <h5>Family Card</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="document-card" data-aos="fade-up" data-aos-delay="400">
 <div class="document-icon"><i class="fas fa-book"></i></div>
 <h5>Bank Passbook</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="document-card" data-aos="fade-up" data-aos-delay="500">
 <div class="document-icon"><i class="fas fa-camera"></i></div>
 <h5>Passport Photos</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="document-card" data-aos="fade-up" data-aos-delay="600">
 <div class="document-icon"><i class="fas fa-map"></i></div>
 <h5>Chitta & Adangal (or) Lease Agreement (2 Pages)</h5>
                    </div>
                </div>
                <div class="col-lg-6 col-md-8 col-sm-12 mb-4">
                    <div class="document-card" data-aos="fade-up" data-aos-delay="700">
 <div class="document-icon"><i class="fas fa-certificate"></i></div>
 <h5>Society Authorization Letter</h5>
  </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Support Services -->
    <section class="section" style="background: var(--bg-light);">
        <div class="container">
            <h2 class="section-title" data-aos="fade-up">Additional Support Provided</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="feature-card" data-aos="fade-up" data-aos-delay="100">
 <div class="feature-icon"><i class="fas fa-shield-alt"></i></div>
 <h4 class="feature-title">Cattle Insurance</h4>
 <p>Comprehensive insurance coverage for newly purchased animals for three years to protect your investment.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card" data-aos="fade-up" data-aos-delay="200">
 <div class="feature-icon"><i class="fas fa-seedling"></i></div>
 <h4 class="feature-title">Fodder Supply</h4>
 <p>Supply of quality fodder seeds and materials to ensure proper nutrition for your cattle.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card" data-aos="fade-up" data-aos-delay="300">
 <div class="feature-icon"><i class="fas fa-graduation-cap"></i></div>
 <h4 class="feature-title">Technical Training</h4>
 <p>Expert training on dairy farm management and cattle maintenance for optimal productivity.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Monitoring Section -->
    <section class="section">
        <div class="container">
            <h2 class="section-title" data-aos="fade-up">Monitoring & Support</h2>
            <div class="row">
                <div class="col-lg-6 mb-4">
                    <div class="feature-card" data-aos="fade-up" data-aos-delay="100">
 <h4 class="feature-title"><i class="fas fa-users text-primary me-2"></i> Monitoring Committee</h4>
 <ul class="list-unstyled mt-3">
     <li><i class="fas fa-check-circle text-success me-2"></i> Society Secretary</li>
     <li><i class="fas fa-check-circle text-success me-2"></i> Extension Officer</li>
     <li><i class="fas fa-check-circle text-success me-2"></i> Union Veterinary Doctor</li>
     <li><i class="fas fa-check-circle text-success me-2"></i> Dairy Supervisor/Inspector</li>
     <li><i class="fas fa-check-circle text-success me-2"></i> Chief Inspector (Milk)</li>
 </ul>
                    </div>
                </div>
                <div class="col-lg-6 mb-4">
                    <div class="feature-card" data-aos="fade-up" data-aos-delay="200">
 <h4 class="feature-title"><i class="fas fa-calendar text-success me-2"></i> Regular Inspections</h4>
 <p class="mt-3">The monitoring committee visits each beneficiary at least twice a month to:</p>
 <ul class="list-unstyled mt-3">
     <li><i class="fas fa-eye text-info me-2"></i> Inspect animals and facilities</li>
     <li><i class="fas fa-clipboard text-info me-2"></i> Update records in system</li>
     <li><i class="fas fa-tags text-info me-2"></i> Ensure proper animal tagging</li>
     <li><i class="fas fa-chart-line text-info me-2"></i> Monitor milk production</li>
 </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
