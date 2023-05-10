<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	mobil				=	mobilkontrol()
	hata				=	""
	gorevID				=	Request.Form("gorevID")
	personelID			=	Request.Form("personelID")
	personelID2			=	Request.Form("personelID2")
	personelID3			=	Request.Form("personelID3")
	personeller			=	""
	call logla("Görev Atanıyor")
	call sessiontest()
	yetkiIT = yetkibul("IT")
	modulAd =   "ITAriza"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



if yetkiIT <= 3 then
	hata = "Bu alana girmek için yeterli yetkiniz bulunmamaktadır"
end if



'### MEVCUT PERSONELLERİ TEMİZLE
'### MEVCUT PERSONELLERİ TEMİZLE
	if hata = "" then
		sorgu = "Delete IT.arizaPersonel where gorevID = " & gorevID
		rs.Open sorgu, sbsv5, 3, 3
	end if
'### MEVCUT PERSONELLERİ TEMİZLE
'### MEVCUT PERSONELLERİ TEMİZLE



'### PERSONEL ADI
'### PERSONEL ADI
	if hata = "" then
		if personelID <> "" then
		sorgu = "Select Ad,ceptelefon from Personel.Personel where Id = " & personelID
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount = 1 then
			personelAD	=	rs("Ad")
			numara		=	rs("ceptelefon")
		end if
		rs.close
		end if
	end if
'### PERSONEL ADI
'### PERSONEL ADI



'### PERSONEL ADI2
'### PERSONEL ADI2
	if hata = "" then
		if personelID2 <> "" then
		sorgu = "Select Ad,ceptelefon from Personel.Personel where Id = " & personelID2
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount = 1 then
			personelAD2	=	rs("Ad")
			numara2		=	rs("ceptelefon")
		end if
		rs.close
		end if
	end if
'### PERSONEL ADI2
'### PERSONEL ADI2



'### PERSONEL ADI3
'### PERSONEL ADI3
	if hata = "" then
		if personelID3 <> "" then
		sorgu = "Select Ad,ceptelefon from Personel.Personel where Id = " & personelID3
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount = 1 then
			personelAD3	=	rs("Ad")
			numara3		=	rs("ceptelefon")
		end if
		rs.close
		end if
	end if
'### PERSONEL ADI3
'### PERSONEL ADI3




'### TEKİLLEŞTİR
'### TEKİLLEŞTİR
	if personelID2 = personelID3 then
		personelID3 = ""
	end if
	if personelID = personelID2 then
		personelID2 = ""
	end if
	if personelID = personelID3 then
		personelID3 = ""
	end if
'### TEKİLLEŞTİR
'### TEKİLLEŞTİR





'### GÖREV PERSONEL AYRINTILARI
'### GÖREV PERSONEL AYRINTILARI
	if hata = "" then
		sorgu = "Select top(1) personelID,gorevID,durum,personelAD from IT.arizaPersonel"
		rs.Open sorgu, sbsv5, 1, 3
		if personelID <> "" then
			rs.addnew
			rs("personelID")	=	personelID
			rs("personelAD")	=	personelAD
			rs("gorevID")		=	gorevID
			rs("durum")			=	"Okumadı"
			rs.update
			personeller			=	personelAD
			personellerID		=	personelID
		end if
		if personelID2 <> "" then
			rs.addnew
			rs("personelID")	=	personelID2
			rs("personelAD")	=	personelAD2
			rs("gorevID")		=	gorevID
			rs("durum")			=	"Okumadı"
			rs.update
			personeller			=	personeller & "/" & personelAD2
			personellerID		=	personellerID & "/" & personelID2
		end if
		if personelID3 <> "" then
			rs.addnew
			rs("personelID")	=	personelID3
			rs("personelAD")	=	personelAD3
			rs("gorevID")		=	gorevID
			rs("durum")			=	"Okumadı"
			rs.update
			personeller			=	personeller & "/" & personelAD3
			personellerID		=	personellerID & "/" & personelID3
		end if
		rs.close
	end if
'### GÖREV PERSONEL AYRINTILARI
'### GÖREV PERSONEL AYRINTILARI




'### GÖREV AYRINTILARI
'### GÖREV AYRINTILARI
	if hata = "" then
		if gorevID <> "" then
			if left(personeller,1) = "/" then
				personeller = right(personeller,len(personeller)-1)
			end if
			sorgu = "Select * from IT.ariza where arizaID = " & gorevID
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount = 1 then
				ad			=	rs("ad")
				icerik		=	rs("icerik")
				oncelik		=	rs("oncelik")
				rs("personelADTemp")	=	personeller
				rs("personelIDTemp")	=	personellerID
				rs.update
			end if
			rs.close
		end if
	end if
'### GÖREV AYRINTILARI
'### GÖREV AYRINTILARI




'### MESAJ HAZIRLIĞI
'### MESAJ HAZIRLIĞI
	hatamesaj = "Göreve Personel Atandı"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	if oncelik = 9 then
		mesaj = "Acil Görev:" & ad
	else
		mesaj = "Görev:" & ad
	end if
	if len(icerik) < 100 then
		mesaj = mesaj & " " & icerik
	end if
'### MESAJ HAZIRLIĞI
'### MESAJ HAZIRLIĞI



if int(kid) <> int(personelID) then
	SMSBildirim = False
end if


SMSBildirim = True


'### MESAJ GÖNDERİM
'### MESAJ GÖNDERİM
	if SMSBildirim = True then
		if numara <> "" then
			call smsgonder(sb_smsBaslik,"Yeni Görev Bildirimi",numara,mesaj)
		end if
		if numara2 <> "" then
			call smsgonder(sb_smsBaslik,"Yeni Görev Bildirimi",numara2,mesaj)
		end if
		if numara3 <> "" then
			call smsgonder(sb_smsBaslik,"Yeni Görev Bildirimi",numara3,mesaj)
		end if
	end if
'### MESAJ GÖNDERİM
'### MESAJ GÖNDERİM









call jsac("/it/ariza_liste.asp")


%>