(function () {
    // Guard to avoid double-attaching endRequest
    if (window._docViewerHooked) return;
    window._docViewerHooked = true;

    function initDocViewer() {
        // Re-query elements (UpdatePanel may have replaced DOM)
        const modalEl = document.getElementById('uploadPopup');
        const viewport = document.getElementById('viewerViewport');
        const target = document.getElementById('transformTarget');
        const img = document.getElementById('<%= img_doc.ClientID %>');
        const pdf = document.getElementById('pdfFrame');
        const lblZoom = document.getElementById('lblZoom');

        // Buttons
        const btnIn = document.getElementById('btnZoomIn');
        const btnOut = document.getElementById('btnZoomOut');
        const btnFit = document.getElementById('btnFitWidth');
        const btn100 = document.getElementById('btnActualSize');
        const btnRL = document.getElementById('btnRotateLeft');
        const btnRR = document.getElementById('btnRotateRight');
        const btnRst = document.getElementById('btnReset');

        if (!modalEl || !viewport || !target) return; // not in DOM (e.g., another view)

        // Remove old listeners if we left any markers
        if (target._dv_unbind) { target._dv_unbind(); }

        // State
        let scale = 1, rotation = 0, offsetX = 0, offsetY = 0;
        let isPanning = false, startX = 0, startY = 0;

        const clampScale = s => Math.min(8, Math.max(0.1, s));
        const isPdf = () => pdf && pdf.style.display !== 'none';

        function applyTransform() {
            target.style.transform =
                `translate(calc(-50% + ${offsetX}px), calc(-50% + ${offsetY}px)) scale(${scale}) rotate(${rotation}deg)`;
            if (lblZoom) lblZoom.textContent = Math.round(scale * 100) + '%';
        }
        function fitWidth() {
            if (!img || !img.naturalWidth) { applyTransform(); return; }
            const rotated = (Math.abs(rotation / 90) % 2) === 1;
            const iw = rotated ? img.naturalHeight : img.naturalWidth;
            const ih = rotated ? img.naturalWidth : img.naturalHeight;
            const vpRect = viewport.getBoundingClientRect();
            const s = Math.min((vpRect.width * 0.95) / iw, (vpRect.height * 0.95) / ih);
            scale = clampScale(s); offsetX = 0; offsetY = 0; applyTransform();
        }
        function resetTransform(fit = true) {
            scale = 1; rotation = 0; offsetX = 0; offsetY = 0;
            fit ? fitWidth() : applyTransform();
        }

        // Handlers (bound once per init)
        const onZoomIn = () => { if (isPdf()) return; scale = clampScale(scale * 1.2); applyTransform(); };
        const onZoomOut = () => { if (isPdf()) return; scale = clampScale(scale / 1.2); applyTransform(); };
        const onFit = () => { if (isPdf()) return; fitWidth(); };
        const on100 = () => { if (isPdf()) return; scale = 1; offsetX = 0; offsetY = 0; applyTransform(); };
        const onRL = () => { if (isPdf()) return; rotation = (rotation - 90) % 360; fitWidth(); };
        const onRR = () => { if (isPdf()) return; rotation = (rotation + 90) % 360; fitWidth(); };
        const onRst = () => { if (isPdf()) return; resetTransform(true); };

        btnIn && btnIn.addEventListener('click', onZoomIn);
        btnOut && btnOut.addEventListener('click', onZoomOut);
        btnFit && btnFit.addEventListener('click', onFit);
        btn100 && btn100.addEventListener('click', on100);
        btnRL && btnRL.addEventListener('click', onRL);
        btnRR && btnRR.addEventListener('click', onRR);
        btnRst && btnRst.addEventListener('click', onRst);

        // Pan / wheel
        const startPan = (x, y) => { if (isPdf()) return; isPanning = true; target.classList.add('dragging'); startX = x - offsetX; startY = y - offsetY; };
        const movePan = (x, y) => { if (!isPanning) return; offsetX = x - startX; offsetY = y - startY; applyTransform(); };
        const endPan = () => { isPanning = false; target.classList.remove('dragging'); };

        const md = e => { if (isPdf()) return; startPan(e.clientX, e.clientY); };
        const mm = e => movePan(e.clientX, e.clientY);
        const mu = () => endPan();
        const ts = e => { if (isPdf()) return; if (e.touches.length === 1) { startPan(e.touches[0].clientX, e.touches[0].clientY); } };
        const tm = e => { if (isPanning && e.touches.length === 1) { movePan(e.touches[0].clientX, e.touches[0].clientY); e.preventDefault(); } };
        const te = () => endPan();
        const wh = e => {
            if (isPdf()) return;
            e.preventDefault();
            const factor = (e.deltaY < 0) ? 1.1 : 0.9;
            const prev = scale;
            scale = clampScale(scale * factor);
            const rect = viewport.getBoundingClientRect();
            const cx = e.clientX - rect.left - rect.width / 2 - offsetX;
            const cy = e.clientY - rect.top - rect.height / 2 - offsetY;
            offsetX -= cx * (scale / prev - 1);
            offsetY -= cy * (scale / prev - 1);
            applyTransform();
        };

        viewport.addEventListener('mousedown', md);
        window.addEventListener('mousemove', mm);
        window.addEventListener('mouseup', mu);
        viewport.addEventListener('touchstart', ts, { passive: false });
        viewport.addEventListener('touchmove', tm, { passive: false });
        viewport.addEventListener('touchend', te);
        viewport.addEventListener('wheel', wh, { passive: false });

        // Bootstrap modal events re-bound
        const shown = () => { if (!isPdf()) resetTransform(true); };
        const hidden = () => { rotation = 0; scale = 1; offsetX = offsetY = 0; applyTransform(); };
        modalEl?.addEventListener('shown.bs.modal', shown);
        modalEl?.addEventListener('hidden.bs.modal', hidden);

        // Clean-up function stored on element so the next init can unbind
        target._dv_unbind = function () {
            btnIn && btnIn.removeEventListener('click', onZoomIn);
            btnOut && btnOut.removeEventListener('click', onZoomOut);
            btnFit && btnFit.removeEventListener('click', onFit);
            btn100 && btn100.removeEventListener('click', on100);
            btnRL && btnRL.removeEventListener('click', onRL);
            btnRR && btnRR.removeEventListener('click', onRR);
            btnRst && btnRst.removeEventListener('click', onRst);

            viewport.removeEventListener('mousedown', md);
            window.removeEventListener('mousemove', mm);
            window.removeEventListener('mouseup', mu);
            viewport.removeEventListener('touchstart', ts);
            viewport.removeEventListener('touchmove', tm);
            viewport.removeEventListener('touchend', te);
            viewport.removeEventListener('wheel', wh);
            modalEl?.removeEventListener('shown.bs.modal', shown);
            modalEl?.removeEventListener('hidden.bs.modal', hidden);
        };

        // Optional: ensure proper stacking if UpdatePanel nests the modal
        // document.body.appendChild(modalEl); // uncomment if you see z-index/backdrop issues
    }

    // Run once on first load
    document.addEventListener('DOMContentLoaded', initDocViewer);

    // Re-run after every UpdatePanel partial postback
    if (window.Sys && Sys.WebForms && Sys.WebForms.PageRequestManager) {
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () { initDocViewer(); });
    }
})();
