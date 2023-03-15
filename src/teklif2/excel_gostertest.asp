<!--#include virtual="/reg/rs.asp" --><%

Server.ScriptTimeout = 1200

Response.Charset = "utf-8"

Response.Flush()

f = Request.QueryString("f")
ExcelFile = Server.Mappath(f)

	Set ExcelConnection = Server.CreateObject("ADODB.Connection")
	ExcelConnection.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & ExcelFile & ";Extended Properties=""Excel 12.0 Xml;HDR=YES"";"
	Set rsx = Server.CreateObject("ADODB.Recordset")
	Set rsx2 = Server.CreateObject("ADOX.Catalog")
	rsx2.ActiveConnection = ExcelConnection
	Response.Write "<div class=""text-info"">Excel dosyasında bulunan sayfa sayısı : " & rsx2.Tables.count & "</div>"

	For tnum = 0 To rsx2.Tables.count - 1
		Set tbl = rsx2.Tables(tnum)
		ilktabload = tbl.Name
		Response.Write "<div class=""text-info"">İşlem yapılan sayfa adı : " & ilktabload & "</div>"
		exit for
	Next


'	rsx.open "SELECT * FROM [" & ilktabload & "]",ExcelConnection
	rsx.open "SELECT * FROM [A1:D2000]",ExcelConnection

	sutunsayi = 0
	FOR EACH Field IN rsx.Fields
		sutunsayi = sutunsayi + 1
	NEXT
	Response.Write "<div class=""text-info"">Bulunan sütun sayısı : " & sutunsayi & "</div>"

	di = 1
	do while not rsx.eof
		if rsx.eof then
			exit do
		end if
		if di = 1 then
			for ai = 0 to sutunsayi-1
				if rsx(ai).Name = "Sıra" then
					ssira = ai
				end if
				if rsx(ai).Name = "Cinsi" then
					scinsi = ai
				end if
				if rsx(ai).Name = "Miktarı" then
					smiktari = ai
				end if
				if rsx(ai).Name = "Birim" then
					sbirim = ai
				end if
				if rsx(ai).Name = "Açıklama" then
					saciklama = ai
				end if
			next
			rsx.movenext
		end if
	di = di + 1
	rsx.movenext
	loop

Response.Write smiktari		


%>