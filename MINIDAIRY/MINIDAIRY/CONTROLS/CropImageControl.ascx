<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CropImageControl.ascx.vb" Inherits="MINIDAIRY.CropImageControl" %>


<link href="/ASSETS/CONTROLS/CROPPER/cropper.min.css" rel="stylesheet" />
<script src="/ASSETS/CONTROLS/CROPPER/cropper.min.js"></script>

<!-- Source Selection -->
<div id="sourceSelection" class="mb-3">
    <label>Select Image Source:</label>
    <div>
        <button type="button" class="btn btn-outline-primary me-2" onclick="selectSource('file')">File Upload</button>
        <button type="button" class="btn btn-outline-primary" onclick="selectSource('camera')">Camera</button>
    </div>
</div>

<!-- File Upload -->
<div id="fileSection" class="mb-3" style="display:none;">
    <input type="file" id="fileInput" accept="image/*" class="form-control" />
</div>

<!-- Camera Input -->
<div id="cameraSection" class="mb-3" style="display:none;">
    <div class="w-100 text-center mt-2">
        <div class="btn-group">
        <button type="button" class="btn btn-primary btn-sm m-0" onclick="captureFromCamera()">Capture</button>
        <button type="button" class="btn btn-outline-primary btn-sm m-0" onclick="switchCamera()">Switch Camera</button>
        </div>
    </div>

    <video id="cameraPreview" autoplay playsinline style="width: 100%; border: 1px solid #ccc;"></video>
</div>

<!-- Crop Section -->
<div id="cropSection" style="display:none;">
    <div class="w-100 mb-3 text-center">
        <div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
     <div class="btn-group me-2" role="group" aria-label="First group">
        <button type="button" class="btn btn-sm btn-primary m-0" onclick="rotateLeft()" ><i class="fa fa-rotate-right"></i></button>
        <button type="button" class="btn btn-sm btn-primary m-0" onclick="rotateRight()"><i class="fa fa-rotate-left"></i></button>
        <button type="button" class="btn btn-sm btn-primary m-0" onclick="zoomIn()" >+</button>
        <button type="button" class="btn btn-sm btn-primary m-0" onclick="zoomOut()">-</button>

     </div>
        <div class="btn-group me-2" role="group" aria-label="Second group">
                <asp:Button ID="btn_save" runat="server" Text="Save" CssClass="btn btn-sm btn-success m-0"  />
                <asp:Button ID="btn_cancel" runat="server" Text="Cancel" CssClass="btn btn-sm btn-danger m-0" />
        </div>
        </div>
    </div>

    <div class="mb-3">
        <img id="imageToCrop" style="max-width: 100%; height: auto; display: block;" />
    </div>


</div>

<asp:HiddenField ID="hfBase64Image" runat="server" />
<asp:HiddenField ID="hf_filename" runat="server" />
<asp:HiddenField ID="hf_status" runat="server" />
<asp:HiddenField ID="hf_doc_no" runat="server" />

<script>
    var cropper;
    var image = document.getElementById('imageToCrop');
    var video = document.getElementById('cameraPreview');
    var stream = null;
    var usingFrontCamera = true;

    function selectSource(type) {
        document.getElementById('sourceSelection').style.display = 'none';
        document.getElementById('cropSection').style.display = 'none';
        document.getElementById('fileSection').style.display = (type === 'file') ? 'block' : 'none';
        document.getElementById('cameraSection').style.display = (type === 'camera') ? 'block' : 'none';

        if (type === 'camera') startCamera();
        else stopCamera();
    }

    function startCamera() {
        stopCamera(); // Stop if already running
        const constraints = {
            video: {
                facingMode: usingFrontCamera ? "user" : "environment"
            }
        };
        navigator.mediaDevices.getUserMedia(constraints)
            .then(function (s) {
                stream = s;
                video.srcObject = stream;
            })
            .catch(function (err) {
                alert("Camera not accessible.");
            });
    }

    function switchCamera() {
        usingFrontCamera = !usingFrontCamera;
        startCamera();
    }

    function stopCamera() {
        if (stream) {
            stream.getTracks().forEach(track => track.stop());
            stream = null;
        }
    }

    function resetAll() {
        if (cropper) cropper.destroy();
        stopCamera();
        image.style.display = 'none';
        document.getElementById('fileInput').value = '';
        document.getElementById('fileSection').style.display = 'none';
        document.getElementById('cameraSection').style.display = 'none';
        document.getElementById('cropSection').style.display = 'none';
        document.getElementById('sourceSelection').style.display = 'block';
        document.getElementById('<%= hfBase64Image.ClientID %>').value = '';
    }

    function captureFromCamera() {
        var canvas = document.createElement('canvas');
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;
        canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
        var dataUrl = canvas.toDataURL('image/png');
        loadImageToCropper(dataUrl);
    }

    document.getElementById('fileInput').addEventListener('change', function (e) {
        var reader = new FileReader();
        reader.onload = function (event) {
            loadImageToCropper(event.target.result);
        };
        reader.readAsDataURL(e.target.files[0]);
    });

    function loadImageToCropper(src) {
        image.src = src;
        image.style.display = 'block';

        if (cropper) cropper.destroy();

        cropper = new Cropper(image, {
            aspectRatio: NaN,
            viewMode: 1,
            autoCropArea: 1,
            responsive: true,
            crop: function () {
                updateCroppedImage();
            }
        });

        // Hide source sections and show crop controls
        stopCamera();
        document.getElementById('fileSection').style.display = 'none';
        document.getElementById('cameraSection').style.display = 'none';
        document.getElementById('cropSection').style.display = 'block';
    }

    function updateCroppedImage() {
        if (cropper) {
            var croppedCanvas = cropper.getCroppedCanvas();
            if (croppedCanvas) {
                var croppedBase64 = croppedCanvas.toDataURL('image/png');
                document.getElementById('<%= hfBase64Image.ClientID %>').value = croppedBase64;
            }
        }
    }

    function rotateLeft() {
        if (cropper) {
            cropper.rotate(-90);
            updateCroppedImage();
        }
    }

    function rotateRight() {
        if (cropper) {
            cropper.rotate(90);
            updateCroppedImage();
        }
    }

    function zoomIn() {
        if (cropper) {
            cropper.zoom(0.1);
            updateCroppedImage();
        }
    }

    function zoomOut() {
        if (cropper) {
            cropper.zoom(-0.1);
            updateCroppedImage();
        }
    }

    window.addEventListener('beforeunload', stopCamera);
</script>
