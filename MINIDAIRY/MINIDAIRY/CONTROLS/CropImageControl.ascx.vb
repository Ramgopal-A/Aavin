Imports Newtonsoft.Json
Imports System.IO
Imports System.Collections
Imports System.Drawing
Imports System.Drawing.Imaging
Imports Newtonsoft.Json.Linq
Public Class CropImageControl
    Inherits System.Web.UI.UserControl
    Dim bgr As New bgr
    Public Event On_File_upload(ByVal status As String)
    Public ReadOnly Property CroppedImageBase64 As String
        Get
            Return hfBase64Image.Value
        End Get
    End Property

    Public ReadOnly Property status As String
        Get
            Return hf_status.Value
        End Get
    End Property

    Public WriteOnly Property file_name As String
        Set(value As String)
            hf_filename.Value = value
        End Set
    End Property

    Public WriteOnly Property doc_no As String
        Set(value As String)
            hf_doc_no.Value = value
        End Set
    End Property

    Private Sub btn_save_Click(sender As Object, e As EventArgs) Handles btn_save.Click
        Dim base64String As String = hfBase64Image.Value
        Dim fp = hf_filename.Value
        Dim sr As StreamReader = New StreamReader(fp)
        Dim jsondata As String = sr.ReadToEnd()
        sr.Close()
        If Not String.IsNullOrEmpty(base64String) Then
            base64String = base64String.Replace("data:image/png;base64,", "")
            Dim imageBytes As Byte() = Convert.FromBase64String(base64String)
            Dim originalImage As Image
            Using ms As New MemoryStream(imageBytes)
                originalImage = Image.FromStream(ms)
            End Using
            'Check size and compress if needed
            Dim compressedBytes As Byte() = CompressImageToTargetSize(originalImage, 100 * 1024)
            Dim compressedBase64 As String = Convert.ToBase64String(compressedBytes)
            Dim dttbl As New DataTable
            dttbl = JsonConvert.DeserializeObject(Of DataTable)(jsondata)
            dttbl.Rows(Val(hf_doc_no.Value.ToString))(1) = bgr.NiotEncrypt(compressedBase64, bgr.enc_key("BENEFICIARY_FILE_DATA"))
            dttbl.AcceptChanges()
            Session("jsonstr") = JsonConvert.SerializeObject(dttbl)
            Dim sw As StreamWriter = New StreamWriter(fp, False)
            sw.Write(Session("jsonstr"))
            sw.Close()
            RaiseEvent On_File_upload("Success")
        Else
            RaiseEvent On_File_upload("Failure")
        End If

    End Sub

    Private Sub btn_cancel_Click(sender As Object, e As EventArgs) Handles btn_cancel.Click
        RaiseEvent On_File_upload("Cancel")
    End Sub

    Private Function CompressImageToTargetSize(img As Image, targetSize As Long) As Byte()
        Dim quality As Long = 100
        Dim compressedBytes As Byte()
        Do
            Using ms As New MemoryStream()
                Dim encoderParams As New EncoderParameters(1)
                encoderParams.Param(0) = New EncoderParameter(Encoder.Quality, quality)
                Dim jpegCodec As ImageCodecInfo = ImageCodecInfo.GetImageDecoders().FirstOrDefault(Function(codec) codec.FormatID = ImageFormat.Jpeg.Guid)
                img.Save(ms, jpegCodec, encoderParams)
                compressedBytes = ms.ToArray()
            End Using
            If compressedBytes.Length <= targetSize OrElse quality <= 10 Then
                Exit Do
            Else
                quality -= 10
            End If
        Loop
        Return compressedBytes
    End Function


End Class