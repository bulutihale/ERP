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
	sorgu = "Select raporAd,raporTuru from rapor.raporIndex where raporID = " & gorevID
	rs.open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
			raporAd = rs("raporAd")
			raporTuru = rs("raporTuru")
		end if
	rs.close
	'### RAPOR BİLGİLERİNİ AL
	'### RAPOR BİLGİLERİNİ AL
	if yetkiRapor = 0 then
		call yetkisizGiris("Bu Raporu Görme Yetkiniz Yok : " & raporAd,"","")
	else
		call logla("Rapor : " & raporAd)
		if yetkiKontrol > 0 then
			Response.Write "<div class=""container-fluid"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
					Response.Write "<div class=""card"">"
					Response.Write "<div class=""card-body"">"
					Response.Write "<div class=""row"">"
						if raporTuru = "htmltable" then
							Server.Execute "/rapor/genel_html.asp"
						elseif raporTuru = "datatable" then
							call dataTableYap("deneme","Durum,Firma Adı,Teklif Sayı,Teklif Türü,Tarih,Personel","/rapor/genel_json.asp","","","","","","","","","")
						end if
					Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "</div>"
		else
			call yetkisizGiris("Raporu Görme Yetkiniz Yok","","")
		end if
	end if
end if

%><!--#include virtual="/reg/rs.asp" -->