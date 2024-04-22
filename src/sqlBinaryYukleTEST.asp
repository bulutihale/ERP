<%
' dosyanın fiziksel yolunu belirtin
Dim filePath
filePath = Server.MapPath("test.pdf")

' SQL Server bağlantı dizesi
Dim connStr
connStr = "Provider=SQLOLEDB;Data Source='EVREN-ASUS\SQLEXPRESS';Initial Catalog='sbs_tio';User ID='sbs_bulutihale';Password='FVDFG@@!!wer3232';"

' dosyayı binary olarak okuma
Dim objStream
Set objStream = Server.CreateObject("ADODB.Stream")
objStream.Type = 1 ' adBinary
objStream.Open
objStream.LoadFromFile filePath

' SQL Server'a dosyayı binary olarak kaydetme
Dim objConn, objCmd
Set objConn = Server.CreateObject("ADODB.Connection")
objConn.Open connStr

Set objCmd = Server.CreateObject("ADODB.Command")
objCmd.ActiveConnection = objConn
objCmd.CommandText = "INSERT INTO portal.binaryDepo (fileData) VALUES (?)"
objCmd.Parameters.Append objCmd.CreateParameter("@fileData", 205, 1, -1, objStream.Read)

objCmd.Execute

' Nesneleri temizle
objStream.Close
Set objStream = Nothing

objConn.Close
Set objConn = Nothing

Response.Write "Dosya SQL Server'a binary olarak kaydedildi."
%>
