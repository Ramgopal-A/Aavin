<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MPU/ZMASTERMPU.Master" CodeBehind="DOCTOR.aspx.vb" Inherits="MINIDAIRY.DOCTOR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="header_content_holder" runat="server">
    <style>
    /* ── Base ── */
    :root {
        --blue:      #2e6fc4;
        --blue-dk:   #1e4d8c;
        --blue-lt:   #e6f1fb;
        --blue-pale: #f0f6ff;
        --border:    #c9d9ed;
        --text:      #1a2a3a;
        --muted:     #6b7a99;
        --danger:    #c0392b;
        --success:   #166534;
        --warn-bg:   #fff8e1;
    }

    /* ── Breadcrumb ── */
    .doc-breadcrumb {
        display: flex; align-items: center; gap: 6px;
        font-size: 12px; font-weight: 600; margin-bottom: 18px; flex-wrap: wrap;
    }
    .doc-breadcrumb .step {
        display: flex; align-items: center; gap: 5px;
        padding: 5px 14px; border-radius: 20px;
        background: #f0f3fa; color: var(--muted);
        transition: background .15s, color .15s;
    }
    .doc-breadcrumb .step.active { background: var(--blue); color: #fff; }
    .doc-breadcrumb .step.done   { background: #e6f9f0; color: var(--success); }
    .doc-breadcrumb .sep         { color: #c8d4e8; font-size: 14px; }

    /* ── Form card ── */
    .doc-form-card .card-body { padding: 16px; }
    .doc-form-card .form-label {
        font-size: 11px; font-weight: 700; letter-spacing: .05em;
        color: var(--muted); margin-bottom: 4px; text-transform: uppercase;
    }
    .doc-form-card .form-control,
    .doc-form-card .form-select {
        font-size: 14px; padding: 10px 12px;
        border-radius: 8px; border: 1.5px solid var(--border);
        width: 100%; color: var(--text); background: #fff;
        transition: border-color .2s, box-shadow .2s;
    }
    .doc-form-card .form-control:focus,
    .doc-form-card .form-select:focus {
        border-color: var(--blue);
        box-shadow: 0 0 0 3px rgba(46,111,196,.12); outline: none;
    }

    /* auto-username readonly badge */
    .uname-wrap { position: relative; }
    .uname-wrap .form-control[readonly] {
        background: var(--blue-pale); color: var(--blue-dk);
        font-weight: 600; letter-spacing: .02em;
    }
    .uname-badge {
        position: absolute; right: 10px; top: 50%;
        transform: translateY(-50%);
        font-size: 10px; font-weight: 700; background: var(--blue-lt);
        color: var(--blue-dk); padding: 2px 7px; border-radius: 20px;
        pointer-events: none;
    }

    /* pass hint */
    .pass-hint {
        font-size: 11px; color: var(--muted);
        background: var(--warn-bg); border-radius: 6px;
        padding: 6px 10px; margin-top: 6px;
        display: flex; align-items: center; gap: 6px;
    }

    /* validation */
    .val-msg { display: none; font-size: 11px; color: var(--danger); margin-top: 4px; }
    .field-invalid .form-control,
    .field-invalid .form-select  { border-color: var(--danger) !important; box-shadow: 0 0 0 3px rgba(192,57,43,.10) !important; }
    .field-invalid .val-msg      { display: block; }

    /* ── Button row ── */
    .doc-btn-row {
        display: flex; flex-wrap: wrap; gap: 10px; margin-top: 18px;
    }
    .doc-btn-row .btn {
        flex: 1 1 140px; padding: 11px 18px;
        font-size: 14px; font-weight: 600;
        border-radius: 9px; min-width: 120px; min-height: 44px;
    }
    @media (max-width: 640px) {
        .doc-btn-row {
            position: fixed; bottom: 0; left: 0; right: 0; z-index: 1000;
            background: #fff; border-top: 2px solid #e2e8f4;
            box-shadow: 0 -4px 16px rgba(46,111,196,.10);
            padding: 12px 16px; margin-top: 0; border-radius: 0;
        }
        .doc-form-card .card-body { padding-bottom: 80px; }
    }

    /* ── Grid / Table ── */
    .doc-list-header {
        display: flex; flex-wrap: wrap; align-items: center;
        justify-content: space-between; gap: 10px; margin-bottom: 14px;
    }
    .doc-list-header h6 { margin: 0; }

    .scroll-hint {
        display: none; font-size: 11px; color: var(--muted);
        padding: 6px 14px 0; text-align: right;
    }
    @media (max-width: 575px) { .scroll-hint { display: block; } }

    .doc-table-wrap {
        overflow-x: auto; -webkit-overflow-scrolling: touch;
        border-radius: 0 0 12px 12px;
    }
    .doc-table-wrap .table         { min-width: 640px; margin-bottom: 0; font-size: 13px; }
    .doc-table-wrap .table th {
        background: #f6f8ff; color: #4a5568;
        font-size: 11px; font-weight: 700; letter-spacing: .05em;
        text-transform: uppercase; border-bottom: 2px solid var(--border);
        padding: 10px 12px; white-space: nowrap;
    }
    .doc-table-wrap .table td {
        padding: 10px 12px; vertical-align: middle;
        border-bottom: 1px solid #f0f3f9; white-space: nowrap;
    }
    .doc-table-wrap .table tr:last-child td { border-bottom: none; }
    .doc-table-wrap .table tr:hover  td    { background: var(--blue-pale); }
    .doc-table-wrap .btn-sm {
        padding: 5px 10px; font-size: 12px; font-weight: 600;
        border-radius: 7px; white-space: nowrap; min-height: 32px;
    }


    /* status dot */
    .dot-active { display:inline-block;width:8px;height:8px;border-radius:50%;background:#22c55e;margin-right:5px; }

    /* Stat card */
    .doc-stat-card {
        display: inline-flex; flex-direction: column;
        align-items: center; justify-content: center;
        background: linear-gradient(135deg, #2e6fc4, #5b9bd5);
        color: #fff; border-radius: 10px;
        padding: 14px 40px; margin-bottom: 16px;
        min-width: 140px; box-shadow: 0 3px 12px rgba(46,111,196,.28);
    }
    .doc-stat-num { font-size: 2rem; font-weight: 700; line-height: 1; }
    .doc-stat-lbl { font-size: .8rem; opacity: .9; margin-top: 3px; font-weight: 500; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="top_content_holder" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main_content_holder" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
 <div class="container py-4">   

    <asp:HiddenField ID="hfToastMsg"   runat="server" Value="" EnableViewState="false" />
    <asp:HiddenField ID="hfToastType"  runat="server" Value="" EnableViewState="false" />



    <div id="docToast" style="display:none;position:fixed;top:24px;left:50%;
         transform:translateX(-50%) translateY(-20px);z-index:9999;
         min-width:300px;max-width:440px;background:#fff;border-radius:12px;
         box-shadow:0 8px 36px rgba(0,0,0,.16);
         padding:0;overflow:hidden;opacity:0;
         transition:opacity .35s ease, transform .35s ease;">
        <div id="docToastBar" style="height:4px;width:100%;transition:width linear;"></div>
        <div style="display:flex;align-items:flex-start;gap:12px;padding:14px 16px;">
            <div id="docToastIcon" style="width:34px;height:34px;border-radius:9px;
                 display:flex;align-items:center;justify-content:center;
                 flex-shrink:0;font-size:17px;font-weight:700;"></div>
            <div style="flex:1;min-width:0;">
                <div id="docToastTitle" style="font-weight:700;font-size:13px;color:#1e293b;line-height:1.3;"></div>
                <div id="docToastMsg"   style="font-size:12px;color:#64748b;margin-top:3px;line-height:1.5;"></div>
            </div>
            <button onclick="hideDocToast()" style="background:none;border:none;cursor:pointer;
                    color:#94a3b8;font-size:20px;line-height:1;padding:0 0 0 4px;flex-shrink:0;
                    transition:color .15s;" onmouseover="this.style.color='#475569'"
                    onmouseout="this.style.color='#94a3b8'">&times;</button>
        </div>
    </div>

    <asp:HiddenField ID="hfDoctorId" runat="server" Value="0" />

    <div class="doc-breadcrumb">
        <asp:Literal ID="litBreadcrumb" runat="server">
            <span class="step active">&#9776;&nbsp;Doctor List</span>
            <span class="sep">›</span>
            <span class="step">&#43;&nbsp;Doctor Form</span>
        </asp:Literal>
    </div>

    <asp:MultiView ID="mvDoctor" runat="server" ActiveViewIndex="0">

        <asp:View ID="vwDoctorList" runat="server">
            <!-- Toolbar -->
            <div class="doc-list-header">
                <h6 class="fw-bold text-muted">Doctors</h6>
                <div class="d-flex gap-2 align-items-center flex-wrap">

                    <asp:LinkButton ID="lbAddNew" runat="server"
                        CssClass="btn btn-primary btn-sm"
                        OnClick="lbAddNew_Click" CausesValidation="False">
                        &#43; Add Doctor
                    </asp:LinkButton>
                </div>
            </div>

            <!-- Stat Card — single -->
            <div class="doc-stat-card">
                <div class="doc-stat-num"><asp:Label ID="lblCount" runat="server" Text="0" /></div>
                <div class="doc-stat-lbl">Doctors</div>
            </div>

            <div class="card">
                <div class="card-header">Doctor List</div>
                <div class="scroll-hint">&#8596; Scroll to see all columns</div>
                <div class="doc-table-wrap">
                    <asp:GridView ID="gvDoctors" runat="server"
                        CssClass="table table-hover mb-0"
                        AutoGenerateColumns="False" DataKeyNames="doc_id"
                        GridLines="None" OnRowCommand="gvDoctors_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="#" ItemStyle-Width="40">
                                <ItemTemplate><%# CType(Container, GridViewRow).RowIndex + 1 %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="doc_name"  HeaderText="Name"        />
                            <asp:BoundField DataField="doc_desg"  HeaderText="Designation" />
                            <asp:BoundField DataField="doc_mobno" HeaderText="Mobile"      />
                            <asp:BoundField DataField="doc_uname" HeaderText="Username"    />
                            <asp:TemplateField HeaderText="Status" ItemStyle-Width="70">
                                <ItemTemplate>
                                    <span class="dot-active"></span>Active
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions" ItemStyle-Width="150">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbEdit" runat="server"
                                        CommandName="EditRow"
                                        CommandArgument='<%# Eval("doc_id") %>'
                                        CssClass="btn btn-sm btn-warning me-1"
                                        CausesValidation="False">
                                        &#9998; Edit
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lbDel" runat="server"
                                        CommandName="DeleteRow"
                                        CommandArgument='<%# Eval("doc_id") %>'
                                        CssClass="btn btn-sm btn-danger"
                                        CausesValidation="False"
                                        OnClientClick="return confirm('Delete this doctor?');">
                                        &#128465;
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center text-muted py-4">
                                No doctors found. Add one using the button above.
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </asp:View>


        <asp:View ID="vwDoctorForm" runat="server">
            <div class="mb-3">
                <asp:LinkButton ID="lbBackToList" runat="server"
                    CssClass="btn btn-outline-secondary btn-sm"
                    OnClick="lbBackToList_Click" CausesValidation="False">
                    &#8592; Back to List
                </asp:LinkButton>
            </div>

            <div class="card mb-4 doc-form-card">
                <div class="card-header">
                    <asp:Literal ID="litFormTitle" runat="server" Text="&#43; Add Doctor" />
                </div>
                <div class="card-body">
                    <div class="row g-3">


                        <!-- Doctor Name -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label">Full Name <span class="text-danger">*</span></label>
                            <div id="fldName" class="field-wrap">
                                <asp:TextBox ID="txtDoctorName" runat="server"
                                    CssClass="form-control"
                                    placeholder="Doctor full name" MaxLength="150" />
                                <span class="val-msg">Name is required.</span>
                            </div>
                        </div>

                        <!-- Designation -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label">Designation</label>
                            <asp:TextBox ID="txtDesignation" runat="server"
                                CssClass="form-control"
                                placeholder="e.g. Veterinarian" MaxLength="100" />
                        </div>

                        <!-- Mobile -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label">Mobile No</label>
                            <div id="fldMobile" class="field-wrap">
                                <asp:TextBox ID="txtMobile" runat="server"
                                    CssClass="form-control"
                                    placeholder="10-digit number" MaxLength="10" />
                                <span class="val-msg">Enter valid 10-digit mobile.</span>
                            </div>
                        </div>

                        <!-- Telegram ID -->
                        <div class="col-12 col-sm-6 col-md-4">
                            <label class="form-label">Telegram ID</label>
                            <asp:TextBox ID="txtTelegramId" runat="server"
                                CssClass="form-control"
                                placeholder="Telegram user ID" MaxLength="250" />
                        </div>

                        <!-- Auto Username (edit only — hidden on add) -->
                        <asp:Panel ID="pnlUsername" runat="server" CssClass="col-12 col-sm-6 col-md-4" Visible="false">
                            <label class="form-label">Username</label>
                            <div class="uname-wrap">
                                <asp:TextBox ID="txtUsername" runat="server"
                                    CssClass="form-control"
                                    ReadOnly="true"
                                    placeholder="Auto-generated after save" />
                                <span class="uname-badge">AUTO</span>
                            </div>
                            <div style="font-size:11px;color:#6b7a99;margin-top:4px;">
                                Format: doc00001@ams.in
                            </div>
                        </asp:Panel>

                        <!-- Password (edit only) -->
                        <asp:Panel ID="pnlPassword" runat="server" CssClass="col-12 col-sm-6 col-md-4">
                            <label class="form-label">
                                Password
                                <small class="text-muted fw-normal">(blank = keep existing)</small>
                            </label>
                            <asp:TextBox ID="txtPassword" runat="server"
                                CssClass="form-control"
                                TextMode="Password"
                                placeholder="Leave blank to keep" MaxLength="100" />
                            <div class="pass-hint">
                                &#128273; Auto-generated 6-char password on new doctor.
                            </div>
                        </asp:Panel>

                    </div>

                    <div class="doc-btn-row">
                        <asp:Button ID="btnSave" runat="server" Text="Save Doctor"
                            CssClass="btn btn-primary"
                            OnClick="btnSave_Click"
                            CausesValidation="False"
                            OnClientClick="return docValidate();" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear"
                            CssClass="btn btn-outline-secondary"
                            OnClick="btnClear_Click"
                            CausesValidation="False"
                            OnClientClick="docClearForm(); return false;" />
                    </div>
                </div>
            </div>
        </asp:View>

    </asp:MultiView>
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

    (function () {
        var toast = document.getElementById('docToast');
        var bar = document.getElementById('docToastBar');
        var iconEl = document.getElementById('docToastIcon');
        var titleEl = document.getElementById('docToastTitle');
        var msgEl = document.getElementById('docToastMsg');
        var hfMsg = document.getElementById('<%= hfToastMsg.ClientID %>');
        var hfType = document.getElementById('<%= hfToastType.ClientID %>');
        var timer, barTimer;

        window.hideDocToast = function () {
            if (!toast) return;
            toast.style.opacity = '0';
            toast.style.transform = 'translateX(-50%) translateY(-20px)';
            clearTimeout(timer);
            clearInterval(barTimer);
            setTimeout(function () { toast.style.display = 'none'; }, 360);
        };

        function showToast(msg, type, duration) {
            if (!toast || !msg) return;
            duration = duration || 4000;

            /* config by type */
            var cfg = {
                success: { bg: '#dcfce7', color: '#16a34a', bar: '#22c55e', icon: '&#10003;', title: 'Success' },
                error: { bg: '#fee2e2', color: '#dc2626', bar: '#ef4444', icon: '&#33;', title: 'Error' },
                info: { bg: '#dbeafe', color: '#1d4ed8', bar: '#3b82f6', icon: '&#8505;', title: 'Info' }
            }[type] || { bg: '#f1f5f9', color: '#475569', bar: '#94a3b8', icon: '&#8226;', title: 'Notice' };

            iconEl.innerHTML = cfg.icon;
            iconEl.style.background = cfg.bg;
            iconEl.style.color = cfg.color;
            /* If msg has <br>, first part = title, rest = body */
            if (msg.indexOf('<br>') !== -1) {
                var parts = msg.split('<br>');
                titleEl.innerHTML = parts[0];
                msgEl.innerHTML = parts.slice(1).join('<br>');
            } else {
                titleEl.textContent = cfg.title;
                msgEl.innerHTML = msg;
            }

            /* progress bar */
            bar.style.background = cfg.bar;
            bar.style.width = '100%';
            bar.style.transition = 'none';
            toast.style.display = 'block';

            requestAnimationFrame(function () {
                requestAnimationFrame(function () {
                    toast.style.opacity = '1';
                    toast.style.transform = 'translateX(-50%) translateY(0)';
                    bar.style.transition = 'width ' + duration + 'ms linear';
                    bar.style.width = '0%';
                });
            });

            clearTimeout(timer);
            timer = setTimeout(hideDocToast, duration);

            /* clear hf so it doesn't re-trigger on postback */
            if (hfMsg) hfMsg.value = '';
            if (hfType) hfType.value = '';
        }

        /* auto-trigger on page load if hf has value */
        Sys.Application.add_load(function () {
            if (!hfMsg || !hfType) return;

            var m = hfMsg.value;
            var t = hfType.value;

            if (m && t) {
                var dur = (t === 'info') ? 8000 : 4000;
                showToast(m, t, dur);
            }
        });

        window.showDocToast = showToast;
    })();

    function docValidate() {
        var ok = true;


        var nameBox = document.getElementById('<%= txtDoctorName.ClientID %>');
        var nameFld = document.getElementById('fldName');
        if (!nameBox || nameBox.value.trim() === '') {
            nameFld.classList.add('field-invalid'); ok = false;
        } else { nameFld.classList.remove('field-invalid'); }

        var mobBox = document.getElementById('<%= txtMobile.ClientID %>');
        var mobFld = document.getElementById('fldMobile');
        if (mobBox && mobBox.value.trim() !== '') {
            if (!/^\d{10}$/.test(mobBox.value.trim())) {
                mobFld.classList.add('field-invalid'); ok = false;
            } else { mobFld.classList.remove('field-invalid'); }
        } else { mobFld.classList.remove('field-invalid'); }

        return ok;
    }

    function docClearForm() {
        ['<%= txtDoctorName.ClientID %>',
         '<%= txtDesignation.ClientID %>',
         '<%= txtMobile.ClientID %>',
         '<%= txtTelegramId.ClientID %>',
         '<%= txtPassword.ClientID %>'].forEach(function (id) {
            var el = document.getElementById(id); if (el) el.value = '';
        });
        var un = document.getElementById('<%= txtUsername.ClientID %>');
        if (un) un.value = '';
        ['fldName', 'fldMPU', 'fldMobile'].forEach(function (f) {
            var el = document.getElementById(f);
            if (el) el.classList.remove('field-invalid');
        });
    }

    (function () {
        function clearOnInput(inputId, fldId) {
            var el = document.getElementById(inputId); if (!el) return;
            el.addEventListener('input', function () {
                if (el.value.trim() !== '')
                    document.getElementById(fldId).classList.remove('field-invalid');
            });
        }
        clearOnInput('<%= txtDoctorName.ClientID %>', 'fldName');
        clearOnInput('<%= txtMobile.ClientID %>', 'fldMobile');
    })();
</script>
</asp:Content>
