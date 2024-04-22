<%
' SQL Server bağlantı dizesi
Dim connStr
connStr = "Provider=SQLOLEDB;Data Source='EVREN-ASUS\SQLEXPRESS';Initial Catalog='sbs_tio';User ID='sbs_bulutihale';Password='FVDFG@@!!wer3232';"

' SQL Server'dan binary veriyi alın
Dim objConn, objCmd, objRS
Set objConn = Server.CreateObject("ADODB.Connection")
Set objCmd = Server.CreateObject("ADODB.Command")
Set objRS = Server.CreateObject("ADODB.Recordset")

objConn.Open connStr
objCmd.ActiveConnection = objConn
objCmd.CommandText = "SELECT fileData FROM portal.binaryDepo"

objRS.Open objCmd, , 1, 1
If Not objRS.EOF Then
    ' Binary veriyi alın
    Dim binaryData
    binaryData = objRS.Fields("fileData").GetChunk(objRS.Fields("fileData").ActualSize)

    ' Binary veriyi bir dosyaya dönüştürme
    Dim filePath
    filePath = Server.MapPath("restored_file.pdf")

    Dim objStream
    Set objStream = Server.CreateObject("ADODB.Stream")
    objStream.Type = 1 ' adBinary
    objStream.Open
    objStream.Write binaryData

    ' dosyayı kaydetme
    objStream.SaveToFile filePath
    objStream.Close
    Set objStream = Nothing
End If

' Nesneleri temizle
objRS.Close
Set objRS = Nothing
'objCmd = Nothing
objConn.Close
Set objConn = Nothing

Response.Write "Binary veri dosyaya dönüştürüldü."
%>
