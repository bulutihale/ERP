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


	sorgu = "Select top 1 * from IT.ariza where arizaID = " & gorevID
	rs.Open sorgu, sbsv5, 1, 3
		rs("t1")		=	now()
		rs("durum")		=	"Başladı"
	rs.update
	rs.close


	hatamesaj = islem
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-success","","","","","")

	call jsgit("/it/ariza_liste")

%>