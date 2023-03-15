<!--#include virtual="/reg/rs.asp" --><%

Server.ScriptTimeout = 1200

dosyavar = False

'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#") 
		musteriID	=	kidarr(0)
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr

Response.Charset = "utf-8"

Response.Flush()

	sorgu = "SELECT raporGonderenMail, SMTPserver, SMTPsifre FROM musteriler WHERE id = " & musteriID
	rs.open sorgu,sbsv5,1,3
	
		raporGonderenMail	=	rs("raporGonderenMail")
		SMTPserver			=	rs("SMTPserver")
		SMTPsifre			=	rs("SMTPsifre")
	
	rs.close

if klasorkontrol("/dosyalar/" & musteriID) = True then
else
	call klasorolustur("/dosyalar/" & musteriID)
end if
if klasorkontrol("/dosyalar/" & musteriID & "/urunlistesi") = True then
else
	call klasorolustur("/dosyalar/" & musteriID & "/urunlistesi")
end if





	Set Upload		=	Server.CreateObject("Persits.Upload")
	Upload.CodePage	=	65001
	Upload.SetMaxSize 10000000, True'10.000.000 byte = 10.000 kb = 10 mb
	Upload.Save
	Set dosya = Upload.Files("dosya")
	id 			= 	Upload.Form("id")

'##### seçilen dosya içerikleri alınıyor
	iceriksec	=	Upload.Form("iceriksec")
	icerikArr	=	""
	For Each Item in Upload.Form 
  		If Item.Name = "iceriksec" Then 
			icerikArr = icerikArr&","&Item.Value
		end if
	Next
	
	if icerikArr = "" then
	else
		icerikArr = right(icerikArr,len(icerikArr)-1)
	end if

'##### /seçilen dosya içerikleri alınıyor

	if Upload.Files("dosya") Is Nothing Then
		response.Write "<script>$(document).ready(function() {toastr.options.positionClass = 'toast-bottom-right';toastr.warning('Dosya Seçilmemiş','İşlem Yapılmadı!');});</script>"
		response.End()
	end if


	If Not Upload.Files("dosya") Is Nothing Then
		dosyavar = True
		dosya.SaveAs Server.MapPath("/dosyalar/" & musteriID & "/urunlistesi/" & id & ".xlsx")
		dosyaad = "/dosyalar/" & musteriID & "/urunlistesi/" & id & ".xlsx"
	End if

	set dosya = Nothing
	set Upload = Nothing

if dosyavar = True then
	call modalkapat()
	call jsrunajax("$('.urunlistebutton').removeClass('d-none');")
	sorgu = "SELECT id, listeYuklendi FROM ihale WHERE id = " & id
	rs.open sorgu,sbsv5,1,3
	rs("listeYuklendi") = 1
	rs.update
	rs.close
	'call jsrunajax("$('.urunlistediv').removeClass('d-none');$('.urunlistediv').load('/dosya/excel_goster.asp?f=" & "/dosyalar/" & musteriID & "/urunlistesi/" & id & ".xlsx');")
end if


'############### liste yüklendi mail gönderiliyor

'####### ANAHTAR KELİME
'####### ANAHTAR KELİME

kolon_ad = "cinsi"

sorgu = "SELECT anahtarKelime FROM anahtar_kelime WHERE musteriID = " & musteriID
rs.open sorgu,sbsv5,1,3

if rs.recordcount > 0 then
	for i = 1 to rs.recordcount
		if i = 1 then
			anahtar_sorgu = "WHERE " & kolon_ad & " LIKE '%"&rs("anahtarKelime")&"%'"
		else
			anahtar_sorgu = anahtar_sorgu&" OR "&kolon_ad&" LIKE '%"&rs("anahtarKelime")&"%'"
		end if
	rs.movenext
	next
else
	anahtar_sorgu = "WHERE " & kolon_ad & " LIKE null"
end if
rs.close

'####### /ANAHTAR KELİME
'####### /ANAHTAR KELİME

	Set ExcelConnection = Server.CreateObject("ADODB.Connection")
	ExcelConnection.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.Mappath(dosyaad) & ";Extended Properties=""Excel 12.0 Xml;HDR=YES"";"
	Set rsx = Server.CreateObject("ADODB.Recordset")
	Set rsx2 = Server.CreateObject("ADOX.Catalog")
	rsx2.ActiveConnection = ExcelConnection

	rsx.open "SELECT * FROM [" & rsx2.Tables(0).Name & "] "&anahtar_sorgu&"",ExcelConnection
	
'####### /EXCEL DOSYA İŞLEM
'####### /EXCEL DOSYA İŞLEM


sorgu = "SELECT i.id, i.dosyaIcerik, i.dosyaNo, i.ikn, i.tarih_ihale, iller.ad as ilAD, fir.adKisa, COALESCE(NULLIF(c.adKisa,''), c.ad) as fiyatVerilenCari,"_
&" COALESCE(NULLIF(c1.adKisa,''), c1.ad) as alimYapanCari, k.ad as dosyaSorumlu FROM ihale i"_
&" INNER JOIN cariler c ON i.cariID = c.id"_
&" LEFT JOIN cariler c1 ON i.bayiKurumID = c1.id"_
&" LEFT JOIN kullanicilar k ON i.dosyaSorumlu = k.id"_
&" INNER JOIN iller ON c.il = iller.id"_
&" INNER JOIN firmalar fir ON i.firmaID = fir.id"_
&" WHERE i.musteriID = " & musteriID & " AND i.id = " & id
rs.open sorgu,sbsv5,1,3

mailbaslik = rs("fiyatVerilenCari")&" için liste yüklendi"


		mailicerik = "<table border = '1'>"
		
		
	mailicerik = mailicerik&"<tr><td><b>Dosya No:</b></td><td>" & rs("dosyaNo") & "</td></tr>"
	mailicerik = mailicerik&"<tr><td><b>İKN:</b></td><td>" & rs("ikn") & "</td></tr>"
	mailicerik = mailicerik&"<tr><td><b>İhale Tarihi:</b></td><td>" & rs("tarih_ihale") & "</td></tr>"
	mailicerik = mailicerik&"<tr><td><b>Fiyat Verilen:</b></td><td>" & rs("fiyatVerilenCari") & "</td></tr>"
	mailicerik = mailicerik&"<tr><td><b>İl:</b></td><td>" & rs("ilAD") & "</td></tr>"
	mailicerik = mailicerik&"<tr><td><b>Alım Yapan:</b></td><td>" & rs("alimYapanCari") & "</td></tr>"
	mailicerik = mailicerik&"<tr><td><b>Ticari Müdür:</b></td><td>" & rs("dosyaSorumlu") & "</td></tr>"
	mailicerik = mailicerik&"<tr><td><b>İçerik:</b></td><td>" & icerikArr & "</td></tr>"
	mailicerik = mailicerik&"<tr><td></td><td>Liste yüklemesi yapıldı.</td></tr>"
	
	rs("dosyaIcerik") = icerikArr
	rs.update
		
rs.close
		
		mailicerik = mailicerik&"<tr><td bgcolor = '#85D14E' colspan = '4'>Anahtar kelimeler ile eşleşen ihale kalemleri</td></tr>"
			while not rsx.eof
				mailicerik = mailicerik&"<tr>"
					for each Field in rsx.Fields
						mailicerik = mailicerik&"<td>"&Field.value&"</td>"
					next
				mailicerik = mailicerik&"</tr>"
			rsx.movenext
			wend
		mailicerik = mailicerik&"</table>"
		


'mailTipNo = ",1," 'mail_gonderimTip tablosundaki Excel Liste yüklendi değeri. Kullanıcı tablosunda bu değer olan kullanıcılara mail gönder

	mailTipNo 	= 	",1,"
	mailBaslik	=	mailbaslik
	call mailGonder(mailTipNo, mailBaslik, mailicerik,"","","",id,"")
'############### liste yüklendi mail gönderiliyor

		response.Write "<script>$(document).ready(function() {toastr.options.positionClass = 'toast-bottom-right';toastr.success('Liste yükleme işlemi tamamlandı','İşlem Tamam!');});</script>"

%>




















