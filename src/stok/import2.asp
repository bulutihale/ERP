<!--#include virtual="/reg/rs.asp" --><%

Server.ScriptTimeout = 1200

call sessiontest()
call temptemizle()
dosyavar = False


Response.Charset = "utf-8"

Response.Flush()

	Set Upload		=	Server.CreateObject("Persits.Upload")
	Upload.CodePage	=	65001
	Upload.SetMaxSize 10000000, True'10.000.000 byte = 10.000 kb = 10 mb
	Upload.Save
	Set dosya = Upload.Files("dosya")

	If Not Upload.Files("dosya") Is Nothing Then
		dosyavar = True
		dosya.SaveAs Server.MapPath("/temp/" & dosya.FileName)
		dosyaad		=	"/temp/" & dosya.FileName
		ExcelFile 	=	Server.Mappath(dosyaad)
	End if

	ay = Upload.Form("ay")

	set dosya = Nothing
	set Upload = Nothing


if dosyavar = True then
	Set ExcelConnection = Server.CreateObject("ADODB.Connection")
	ExcelConnection.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & ExcelFile & ";Extended Properties=""Excel 12.0 Xml;HDR=YES"";"
	Set rsx = Server.CreateObject("ADODB.Recordset")
	Set rsx2 = Server.CreateObject("ADOX.Catalog")
	rsx2.ActiveConnection = ExcelConnection

	For tnum = 0 To rsx2.Tables.count - 1
		Set tbl = rsx2.Tables(tnum)
		ilktabload = tbl.Name
		if instr(ilktabload,"Fatura") > 0 then
			exit for
		end if
	Next

	rsx.open "SELECT * FROM [" & ilktabload & "]",ExcelConnection
	
	sutunsayi = 0
	FOR EACH Field IN rsx.Fields
		sutunsayi = sutunsayi + 1
	NEXT



	'reset
	'sorgu = "Update fatura.gsm set fatura.gsm." & ay & " = '0' where fatura.gsm.operator = 'Vodafone'"
	'rs.open sorgu,sbsv5,3,3
	'reset





' 	di = 1
' 	do while not rsx.eof
' 		if rsx.eof then
' 			exit do
' 		end if
' 			numara	=	rsx.Fields(1).value
' 			tarife	=	rsx.Fields(2).value
' 			durum	=	rsx.Fields(3).value
' 			tanim	=	rsx.Fields(4).value
' 			tutar	=	rsx.Fields(5).value
' 			indirim	=	rsx.Fields(6).value
' 			kdv		=	rsx.Fields(7).value
' 			oiv		=	rsx.Fields(8).value
' 			toplam	=	tutar + indirim + kdv + oiv

' 			'## kaydet
' 			sorgu = "Select " & ay & "," & ay & "a,operator,firma,tarife from fatura.gsm where telefon = '" & numara & "'"
' 			rs.open sorgu,sbsv5,1,3
' 			if rs.recordcount = 0 then
' 				Response.Write "Sorun = Numara Yok : " & numara & vbcrlf
' 			elseif rs.recordcount > 1 then
' 				Response.Write "Sorun = Çoklu Kayıt : " & numara & vbcrlf
' 			else
' 				if durum = "CDR" then
' 					rs(ay & "a") = tutar + indirim + kdv + oiv
' 				end if
' 				if isnull(rs(ay)) = True then
' 					rs(ay) = 0
' 					rs.update
' 				end if
' 				rs(ay) = rs(ay) + toplam
' 				rs("operator") = "Vodafone"
' '				rs("firma")		=	"Ultra Emar"

' 				'tarife bul
' 				if rs("tarife") = "" or isnull(rs("tarife")) = True then
' 					if trim(tanim) = "Aylık Mobil Ses ve SMS" then
' 						rs("tarife") = tarife
' 					end if
' 				end if
' 				'tarife bul
' 				rs.update
' 			end if
' 			rs.close
			'## kaydet

	rsx.movenext
	di = di + 1
	loop
	rsx.close
























		hatamesaj = "Yükleme Bitti"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		call logla("Vodafone Kalem Kalem Excel Yüklemesi Bitti : " & ay)









end if

%>