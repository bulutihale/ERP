<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
	' cariID			=	Request.Form("cariID")
	' gorevID			=	Request.QueryString("gorevID")
    kid				=	kidbul()
    modulAd 		=   "Raporlar"
	yetkiKontrol    =	yetkibul(modulAd)
	yetkiRapor		=	0
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET
	if hata = "" then
		if gorevID = "" then
			gorevID64 = Session("sayfa5")
			if gorevID64 = "" then
			else
				gorevID		=	gorevID64
				gorevID		=	base64_decode_tr(gorevID)
				if isnumeric(gorevID) = False then
					gorevID		=	""
				end if
			end if
		else
			if isnumeric(gorevID) = False then
				gorevID		=	base64_decode_tr(gorevID)
			end if
			gorevID		=	int(gorevID)
			gorevID64	=	gorevID
			gorevID64	=	base64_encode_tr(gorevID64)
		end if
	end if
'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET

if gorevID = "" then
    call yetkisizGiris("Ulaşmaya Çalıştığınız Rapor Bulunamadı","","")
else
	'### YETKİ KONTROLÜ YAP
	'### YETKİ KONTROLÜ YAP
	sorgu = "Select count(*) from rapor.raporYetki where raporID = " & gorevID & " and kid = " & kid
	rs.open sorgu, sbsv5, 1, 3
		yetkiRapor = rs(0)
	rs.close
	'### YETKİ KONTROLÜ YAP
	'### YETKİ KONTROLÜ YAP
	'### RAPOR BİLGİLERİNİ AL
	'### RAPOR BİLGİLERİNİ AL
	sorgu = "Select raporAd,raporTuru,raporSQL from rapor.raporIndex where raporID = " & gorevID
	rs.open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
			raporAd = rs("raporAd")
			raporTuru = rs("raporTuru")
			raporSQL    =   rs("raporSQL")
		end if
	rs.close
	'### RAPOR BİLGİLERİNİ AL
	'### RAPOR BİLGİLERİNİ AL
	if yetkiRapor = 0 then
		call yetkisizGiris("Bu Raporu Görme Yetkiniz Yok : " & raporAd,"","")
	else
		call logla("Rapor : " & raporAd)
		if yetkiKontrol > 0 then
			if raporTuru = "htmltable" then
				Server.Execute "/rapor/genel_html.asp"
			elseif raporTuru = "datatable" then
				'##### BAŞLIKLARI BUL
				'##### BAŞLIKLARI BUL
					raporBasliklar = raporSQL
					raporBasliklar = Replace(raporBasliklar,"select ","")
					raporBasliklar1 = instr(raporBasliklar," from ")
					raporBasliklar = left(raporBasliklar,raporBasliklar1)
					raporBasliklarArr = Split(raporBasliklar,",")
					for ri = 0 to ubound(raporBasliklarArr)
						if instr(raporBasliklarArr(ri)," as ") > 0 then
							baslikArr = Split(raporBasliklarArr(ri)," as ")
							baslik = baslikArr(1)
							baslik = Replace(baslik,"'","")
						else
							baslik = raporBasliklarArr(ri)
						end if
						basliklar = basliklar & "," & baslik
					next
					basliklar = right(basliklar,len(basliklar)-1)
				'##### BAŞLIKLARI BUL
				'##### BAŞLIKLARI BUL

						Response.Write basliklar

				call dataTableYap("deneme","Firma Adı,Teklif Sayı,Teklif Türü,Tarih,Personel","/rapor/genel_json.asp?id=" & gorevID64,"","","","","","","","","")
			end if
		else
			call yetkisizGiris("Raporu Görme Yetkiniz Yok","","")
		end if
	end if
end if

%><!--#include virtual="/reg/rs.asp" -->