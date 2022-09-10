<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	hata				=	""
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


if saat >= 15 then
'	if weekday(date()) <> 1 then	'pazar
		'günlük rapor girmesi gereken personelleri al
		'günlük rapor girmesi gereken personelleri al
			sorgu = "" & vbcrlf
			sorgu = sorgu & "Select" & vbcrlf
			sorgu = sorgu & "distinct" & vbcrlf
			sorgu = sorgu & "Personel.Personel.Telefon" & vbcrlf
			sorgu = sorgu & ",Personel.GunlukFaaliyet.tarih as gunlukFaaliyetTarih" & vbcrlf
			sorgu = sorgu & ",Bildirim.SMSArsiv.tarih as SMSArsivTarih" & vbcrlf
			sorgu = sorgu & "from Personel.Personel" & vbcrlf
			sorgu = sorgu & "INNER JOIN Personel.Yetki on Personel.Yetki.kid = Personel.Personel.Id" & vbcrlf
			sorgu = sorgu & "LEFT JOIN Bildirim.SMSArsiv on Bildirim.SMSArsiv.numara = Personel.Personel.Telefon and Bildirim.SMSArsiv.baslik like '%Günlük Faaliyet Hat_rlatma%' and Bildirim.SMSArsiv.tarih >= '" & tarihsql(date()) & "'" & vbcrlf
			sorgu = sorgu & "LEFT JOIN Personel.GunlukFaaliyet on Personel.GunlukFaaliyet.personelID = Personel.Personel.Id and Personel.GunlukFaaliyet.tarih >= '" & tarihsql(date()) & "'" & vbcrlf
			sorgu = sorgu & "where Personel.Yetki.gunlukFaaliyetGir = 'True'" & vbcrlf
			rs.open sorgu,sbsv5,1,3
			do while not rs.eof
				personelnumara		=	rs("Telefon")
				gunlukFaaliyetTarih	=	rs("gunlukFaaliyetTarih")
				SMSArsivTarih		=	rs("SMSArsivTarih")
				if isnull(SMSArsivTarih) = True then
					mesaj			=	"Merhaba, bu gün günlük faaliyet raporu girmeyi unuttunuz. Lütfen http://servis.cimax.com.tr adresinden giriş yapar mısınız?"
					'###### FİRMAYI BUL
					'###### FİRMAYI BUL
						sorgu = "Select SMSBaslik from Firma.Firma where url = '" & site & "'"
						rs2.Open sorgu, sbsv5, 1, 3
						if rs2.recordcount = 1 then
							SMSBaslik		=	rs2("SMSBaslik")
						end if
						rs2.close
					'###### FİRMAYI BUL
					'###### FİRMAYI BUL
					call smsgonder(SMSBaslik,"Günlük Faaliyet Hatırlatma",personelnumara,mesaj)
				end if
			rs.movenext
			loop
			rs.close
		'günlük rapor girmesi gereken personelleri al
		'günlük rapor girmesi gereken personelleri al

'	end if
end if


%><!--#include virtual="/reg/rs.asp" -->