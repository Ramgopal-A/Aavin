<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="snap.aspx.vb" Inherits="MINIDAIRY.snap" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mobile Snapshot Capture</title>

    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body { background: #f6f8fb; }
        .cardx { border: 0; border-radius: 1rem; box-shadow: 0 12px 35px rgba(0,0,0,.08); }
        .soft-label { font-size: .85rem; color: #6c757d; }
        .video-wrap { border-radius: 1rem; overflow: hidden; background: #000; }
        video { width: 100%; height: auto; object-fit: cover; }
        .btn-pill { border-radius: 999px; }
        .mono { font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace; }
        .desktop-block {
            display: none;
            padding: 1.5rem;
            border-radius: 1rem;
            background: #fff3cd;
            border: 1px solid #ffe69c;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hf_img_base64" runat="server" />

        <div class="container py-4">
            <div class="row justify-content-center">
                <div class="col-12 col-md-10 col-lg-8">

                    <!-- Client-side desktop block message -->
                    <div id="clientDesktopBlock" class="desktop-block mb-3">
                        <div class="d-flex align-items-start gap-3">
                            <div class="fs-3">⚠️</div>
                            <div>
                                <div class="fw-bold">This page works only on Mobile / Tablet</div>
                                <div class="text-muted">Please open this page on a phone or tablet with camera access.</div>
                            </div>
                        </div>
                    </div>

                    <asp:Panel ID="pnlMain" runat="server" CssClass="card cardx">
                        <div class="card-body p-3 p-md-4">
                            <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mb-3">
                                <div>
                                    <div class="fw-bold fs-5">Camera Snapshot</div>
                                    <div class="text-muted small">Auto captures GPS + Date/Time and watermarks the image.</div>
                                </div>

                                <button type="button" class="btn btn-outline-secondary btn-sm btn-pill" onclick="refreshMeta()">
                                    Refresh GPS/Time
                                </button>
                            </div>

                            <!-- GPS + Date/Time -->
                            <div class="row g-3">
                                <div class="col-12 col-md-6">
                                    <div class="soft-label">Latitude</div>
                                    <asp:TextBox ID="txtLat" runat="server" CssClass="form-control mono" ReadOnly="true" />
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="soft-label">Longitude</div>
                                    <asp:TextBox ID="txtLon" runat="server" CssClass="form-control mono" ReadOnly="true" />
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="soft-label">Date</div>
                                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control mono" ReadOnly="true" />
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="soft-label">Time</div>
                                    <asp:TextBox ID="txtTime" runat="server" CssClass="form-control mono" ReadOnly="true" />
                                </div>
                            </div>

                            <hr class="my-4" />

                            <!-- Camera Preview -->
                            <div class="video-wrap mb-3">
                                <video id="video" autoplay playsinline></video>
                            </div>

                            <div class="d-grid gap-2 d-md-flex">
                                <button type="button" id="btnStart" class="btn btn-primary btn-pill px-4" onclick="startCamera()">
                                    Start Camera
                                </button>
                                <button type="button" id="btnSnap" class="btn btn-success btn-pill px-4" onclick="takeSnapshot()" disabled>
                                    Snapshot + Watermark
                                </button>
                            </div>

                            <div class="mt-3">
                                <div id="status" class="small text-muted"></div>
                            </div>

                            <!-- Hidden canvas used for watermarking -->
                            <canvas id="canvas" style="display:none;"></canvas>

                            <hr class="my-4" />

                            <!-- Result Image -->
                            <div class="fw-bold mb-2">Captured Image</div>
                            <asp:Image ID="imgPreview" runat="server" CssClass="img-fluid rounded-4 border bg-white" />
                        </div>
                    </asp:Panel>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            let streamRef = null;

            function isProbablyDesktop() {
                // Client-side block: if large viewport and no touch, assume desktop/laptop
                const large = Math.max(screen.width, screen.height) >= 1024;
                const hasTouch = ('ontouchstart' in window) || (navigator.maxTouchPoints && navigator.maxTouchPoints > 0);
                const ua = navigator.userAgent.toLowerCase();

                // If Windows/Mac/Linux and no touch => desktop
                const desktopOS = ua.includes('windows') || ua.includes('macintosh') || ua.includes('linux');
                if (desktopOS && !hasTouch) return true;

                // If very large and no touch => desktop
                if (large && !hasTouch) return true;

                return false;
            }

            function blockDesktopClientSide() {
                if (isProbablyDesktop()) {
                    document.getElementById('clientDesktopBlock').style.display = 'block';
                    const pnl = document.getElementById('<%= pnlMain.ClientID %>');
                    if (pnl) pnl.style.display = 'none';
                }
            }

            function setStatus(msg) {
                document.getElementById('status').innerText = msg || '';
            }

            function pad2(n) { return (n < 10 ? '0' : '') + n; }

            function refreshDateTime() {
                const now = new Date();
                const dateStr = now.getFullYear() + '-' + pad2(now.getMonth() + 1) + '-' + pad2(now.getDate());
                const timeStr = pad2(now.getHours()) + ':' + pad2(now.getMinutes()) + ':' + pad2(now.getSeconds());

                document.getElementById('<%= txtDate.ClientID %>').value = dateStr;
                document.getElementById('<%= txtTime.ClientID %>').value = timeStr;
            }

            function refreshGeo() {
                if (!navigator.geolocation) {
                    setStatus("Geolocation not supported in this browser.");
                    return;
                }

                setStatus("Fetching GPS location...");
                navigator.geolocation.getCurrentPosition(
                    (pos) => {
                        document.getElementById('<%= txtLat.ClientID %>').value = pos.coords.latitude.toFixed(6);
                        document.getElementById('<%= txtLon.ClientID %>').value = pos.coords.longitude.toFixed(6);
                        setStatus("GPS updated.");
                    },
                    (err) => {
                        setStatus("GPS error: " + err.message + ". Enable Location permission.");
                    },
                    { enableHighAccuracy: true, timeout: 15000, maximumAge: 0 }
                );
            }

            function refreshMeta() {
                refreshDateTime();
                refreshGeo();
            }

            async function startCamera() {
                try {
                    refreshMeta();

                    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
                        setStatus("Camera API not supported. Use Chrome/Safari on mobile.");
                        return;
                    }

                    setStatus("Starting camera...");
                    const constraints = {
                        video: {
                            facingMode: { ideal: "environment" }, // back camera preferred
                            width: { ideal: 1280 },
                            height: { ideal: 720 }
                        },
                        audio: false
                    };

                    streamRef = await navigator.mediaDevices.getUserMedia(constraints);
                    const video = document.getElementById('video');
                    video.srcObject = streamRef;

                    document.getElementById('btnSnap').disabled = false;
                    setStatus("Camera started. Ready to snap.");
                } catch (e) {
                    setStatus("Camera error: " + e.message + ". Allow Camera permission.");
                }
            }

            function drawWatermark(ctx, w, h, lines) {
                // Watermark box
                const padding = Math.max(14, Math.round(w * 0.02));
                const fontSize = Math.max(16, Math.round(w * 0.03));
                const lineHeight = Math.round(fontSize * 1.35);

                ctx.font = `600 ${fontSize}px ui-monospace, Menlo, Consolas, monospace`;
                ctx.textBaseline = "top";

                const maxLineWidth = Math.max(...lines.map(l => ctx.measureText(l).width));
                const boxW = maxLineWidth + padding * 2;
                const boxH = lineHeight * lines.length + padding * 2;

                const x = padding;
                const y = h - boxH - padding;

                // semi-transparent dark bg
                ctx.fillStyle = "rgba(0,0,0,0.55)";
                roundRect(ctx, x, y, boxW, boxH, Math.max(10, Math.round(w * 0.015)));
                ctx.fill();

                // white text + soft shadow
                ctx.fillStyle = "rgba(255,255,255,0.95)";
                ctx.shadowColor = "rgba(0,0,0,0.6)";
                ctx.shadowBlur = 6;

                let ty = y + padding;
                for (const line of lines) {
                    ctx.fillText(line, x + padding, ty);
                    ty += lineHeight;
                }

                // reset shadow
                ctx.shadowBlur = 0;
            }

            function roundRect(ctx, x, y, width, height, radius) {
                const r = Math.min(radius, width / 2, height / 2);
                ctx.beginPath();
                ctx.moveTo(x + r, y);
                ctx.arcTo(x + width, y, x + width, y + height, r);
                ctx.arcTo(x + width, y + height, x, y + height, r);
                ctx.arcTo(x, y + height, x, y, r);
                ctx.arcTo(x, y, x + width, y, r);
                ctx.closePath();
            }

            function takeSnapshot() {
                try {
                    refreshDateTime(); // ensure current time at click

                    const video = document.getElementById('video');
                    const canvas = document.getElementById('canvas');
                    const ctx = canvas.getContext('2d');

                    const w = video.videoWidth || 1280;
                    const h = video.videoHeight || 720;

                    canvas.width = w;
                    canvas.height = h;

                    // draw frame
                    ctx.drawImage(video, 0, 0, w, h);

                    // read meta
                    const lat = document.getElementById('<%= txtLat.ClientID %>').value || "NA";
                    const lon = document.getElementById('<%= txtLon.ClientID %>').value || "NA";
                    const date = document.getElementById('<%= txtDate.ClientID %>').value || "NA";
                    const time = document.getElementById('<%= txtTime.ClientID %>').value || "NA";

                    const lines = [
                        `Lat: ${lat}`,
                        `Lon: ${lon}`,
                        `Date: ${date}`,
                        `Time: ${time}`
                    ];

                    drawWatermark(ctx, w, h, lines);

                    // output to base64 (JPEG)
                    const dataUrl = canvas.toDataURL('image/jpeg', 0.92);

                    // Set ASP.NET Image and hidden field
                    document.getElementById('<%= imgPreview.ClientID %>').src = dataUrl;
                    document.getElementById('<%= hf_img_base64.ClientID %>').value = dataUrl;

                    setStatus("Snapshot captured with watermark.");
                } catch (e) {
                    setStatus("Snapshot error: " + e.message);
                }
            }

            // Stop camera on leaving page
            window.addEventListener('beforeunload', () => {
                if (streamRef) {
                    streamRef.getTracks().forEach(t => t.stop());
                    streamRef = null;
                }
            });

            // Init
            (function () {
                blockDesktopClientSide();
                refreshMeta();
                // keep time fresh every second
                setInterval(refreshDateTime, 1000);
            })();
        </script>
    </form>
</body>
</html>
