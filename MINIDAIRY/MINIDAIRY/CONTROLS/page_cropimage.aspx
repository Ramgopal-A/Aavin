<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="page_cropimage.aspx.vb" Inherits="MINIDAIRY.page_cropimage" %>
<%@ Register Src="~/CONTROLS/CropImageControl.ascx" TagPrefix="uc" TagName="CropImageControl" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
<uc:CropImageControl ID="ImageCropControl" runat="server" />
<asp:Button ID="btnShow" runat="server" Text="Show Cropped" CssClass="btn btn-success" OnClick="btnShow_Click" />
<asp:Image ID="imgCropped" runat="server" />
    </form>
</body>
</html>
