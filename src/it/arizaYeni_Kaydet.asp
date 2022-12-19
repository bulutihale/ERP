<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	mobil				=	mobilkontrol()
	hata				=	""
	call sessiontest()
	yetkiIT				=	yetkibul("IT")
	modulAd 			=   "ITAriza"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'### GELEN FORM BİLGİLERİ
'### GELEN FORM BİLGİLERİ
	ad			=	Request.Form("ad")
	icerik		=	Request.Form("icerik")
	personelID	=	Request.Form("personelID")
	olusturanID	=	Request.Form("olusturanID")
	oncelik		=	Request.Form("oncelik")
	etiketID	=	Request.Form("etiketID")
	' if personelID = "" then
	' 	personelID = kid
	' end if
'### GELEN FORM BİLGİLERİ
'### GELEN FORM BİLGİLERİ

'### FORMU KONTROL ET
'### FORMU KONTROL ET
	if gorevID = "" then
		if ad = "" then
			hatamesaj = "Göreve bir ad yazın"
			call logla(hatamesaj)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
			Response.End()
		end if
	end if
	if gorevID = "" then
		if len(ad) > 50 then
			hatamesaj = "Girdiğiniz başlık çok uzun. Ayrıntı kısmını kullanın."
			call logla(hatamesaj)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
			Response.End()
		end if
	end if
'### FORMU KONTROL ET
'### FORMU KONTROL ET


'### PERSONEL ADI - KAYDI OLUŞTURAN
'### PERSONEL ADI
	if hata = "" then
		if olusturanID <> "" then
			sorgu = "Select ad,ceptelefon from Personel.Personel where Id = " & olusturanID
		else
			sorgu = "Select ad,ceptelefon from Personel.Personel where Id = " & kid
		end if
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount = 1 then
			personelAD	=	rs("ad")
'			numara		=	rs("ceptelefon")
		end if
		rs.close
	end if
'### PERSONEL ADI
'### PERSONEL ADI



'### PERSONEL ADI TEMP
'### PERSONEL ADI TEMP
	if personelID <> "" then
		if olusturanID <> "" then
			sorgu = "Select ad,ceptelefon from Personel.Personel where id = " & olusturanID
		else
			sorgu = "Select ad,ceptelefon from Personel.Personel where id = " & personelID
			
		end if
		' Response.Write sorgu
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount = 1 then
			personelADTemp	=	rs("ad")
			personelnumara	=	rs("ceptelefon")
		end if
		rs.close
	end if
'### PERSONEL ADI TEMP
'### PERSONEL ADI TEMP



if olusturanID <> "" then
		sorgu = "Select ad,ceptelefon from Personel.Personel where id = " & personelID
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount = 1 then
			personelADTemp	=	rs("ad")
			personelnumara	=	rs("ceptelefon")
		end if
		rs.close
end if












'### PERSONEL YETKİ BİLGİLERİ
'### PERSONEL YETKİ BİLGİLERİ
	' sorgu = "Select * from Personel.Yetki where kid = " & personelID
	' rs.Open sorgu, sbsv5, 1, 3
	' if rs.recordcount = 1 then
	' 	SMSBildirim		=	rs("SMSBildirim")
	' 	PersonelIslem	=	rs("PersonelIslem")
	' end if
	' rs.close
'### PERSONEL YETKİ BİLGİLERİ
'### PERSONEL YETKİ BİLGİLERİ


'### GÖREV KAYDET
'### GÖREV KAYDET
	sorgu = "Select top 1 * from IT.ariza"
	rs.Open sorgu, sbsv5, 1, 3
	rs.addnew
	rs("tarih")			=	now()
	rs("durum")			=	"Yeni"
	if olusturanID <> "" then
		rs("olusturanID")	=	olusturanID
	else
		rs("olusturanID")	=	kid
	end if
	rs("olusturanAD")	=	personelAD
	' islem				=	"Görev Eklendi"
	rs("ad")			=	ad
	rs("icerik")		=	icerik
'	rs("musteriID")		=	musteriID
	rs("firmaID")		=	firmaID
	if personelID <> "" then
	rs("personelADTemp")=	personelADTemp
	rs("personelIDTemp")=	personelID
	end if
	if oncelik <> "" then
		rs("oncelik")	=	oncelik
	end if
	if sb_etiketEklenebilsin = true then
		rs("etiketID") = etiketID
	end if


	rs.update
	arizaID =	rs("arizaID")
	gorevID	=	rs("arizaID")
	rs.close
'### GÖREV KAYDET
'### GÖREV KAYDET




'### GÖREV PERSONEL AYRINTILARI
'### GÖREV PERSONEL AYRINTILARI
	if personelID <> "" then
		sorgu = "Select top(1) personelID,gorevID,durum,personelAD from IT.arizaPersonel"
		rs.Open sorgu, sbsv5, 1, 3
		if personelID <> "" then
			rs.addnew
			rs("personelID")	=	personelID
			rs("personelAD")	=	personelADTemp
			rs("gorevID")		=	gorevID
			rs("durum")			=	"Okumadı"
			rs.update
		end if
	end if
'### GÖREV PERSONEL AYRINTILARI
'### GÖREV PERSONEL AYRINTILARI



'### MESAJ HAZIRLIĞI
'### MESAJ HAZIRLIĞI
	if personelID <> "" then
		hatamesaj = "Personele Görev Verildi"
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","2000","","")
		if oncelik = 9 then
			mesaj = "Acil Görev:" & ad
		else
			mesaj = "Görev:" & ad
		end if
		if len(icerik) < 100 then
			mesaj = mesaj & " " & icerik
		end if
	end if
'### MESAJ HAZIRLIĞI
'### MESAJ HAZIRLIĞI


SMSBildirim = True

if personelID <> "" then
	if SMSBildirim = True then
		if int(kid) <> int(personelID) then
			if personelnumara <> "" then
				call smsgonder(sb_smsBaslik,"Yeni Görev Bildirimi",personelnumara,mesaj)
			end if
		end if
	end if
end if


	call modalkapat()

	hatamesaj = "Kayıt Oluşturuldu. Takip no : " & arizaID
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")


	if yetkiIT > 3 then
		call jsac("/it/ariza_liste.asp")
	end if


' if PersonelIslem = True then
' 	call jsgit("/IT/liste?aramapersonelID=" & personelID)
' else
' 	call jsgit("/gorev/liste")
' end if

%><!--#include virtual="/reg/rs.asp" -->