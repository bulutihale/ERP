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
	call logla("Görev Kaydediliyor")
	modulAd =   "ITAriza"
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








'### PERSONEL ADI
'### PERSONEL ADI
		sorgu = "Select Ad,ceptelefon from Personel.Personel where Id = " & kid
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount = 1 then
			personelAD	=	rs("Ad")
		end if
		rs.close
'### PERSONEL ADI
'### PERSONEL ADI



'### PERSONEL ATANMAMIŞSA, SEN ATA
'### PERSONEL ATANMAMIŞSA, SEN ATA
		sorgu = "Select top(1) personelID,gorevID,durum,personelAD from IT.arizaPersonel where gorevID = " & gorevID
		rs.Open sorgu, sbsv5, 1, 3
		if rs.recordcount = 0 then
			rs.addnew
			rs("personelID")	=	kid
			rs("personelAD")	=	personelAD
			rs("gorevID")		=	gorevID
			rs("durum")			=	"Tamamladı"
			rs.update
		end if
		rs.close
'### PERSONEL ATANMAMIŞSA, SEN ATA
'### PERSONEL ATANMAMIŞSA, SEN ATA








'### GÖREVİ GÜNCELLE
'### GÖREVİ GÜNCELLE
	sorgu = "Select top 1 * from IT.ariza where arizaID = " & gorevID
	rs.Open sorgu, sbsv5, 1, 3
		if isnull(rs("t1")) = True then
			rs("t1")	=	now()
		end if
		rs("t2")		=	now()
		rs("durum")		=	"Bitti"
		rs("personelADTemp")	=	personelAD
		rs("personelIDTemp")	=	kid
	rs.update
	rs.close
'### GÖREVİ GÜNCELLE
'### GÖREVİ GÜNCELLE










	hatamesaj = "Görev Hızlı Tamamla butonu ile tamamlandı"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-success","","","","","")

	call jsgit("/it/ariza_liste")

%>