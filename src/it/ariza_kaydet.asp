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
	yetkiIT = yetkibul("IT")
	modulAd =   "ITAriza"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


'### GELEN FORM BİLGİLERİ
'### GELEN FORM BİLGİLERİ
	ad			=	Request.Form("ad")
	durum		=	Request.Form("durum")
	icerik		=	Request.Form("icerik")
	musteriID	=	Request.Form("unvan")
	oncelik		=	Request.Form("oncelik")
	gorevID		=	Request.Form("gorevID")
	tur			=	Request.Form("tur")
	tarihServis	=	Request.Form("tarihServis")
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
'		if musteriID = "" then
'			hatamesaj = "Müşteri seçin"
'			call logla(hatamesaj)
'			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
'			Response.End()
'		end if
	end if
'### FORMU KONTROL ET
'### FORMU KONTROL ET



'### PERSONEL ADI
'### PERSONEL ADI
	if hata = "" then
		sorgu = "Select ad,ceptelefon from Personel.Personel where Id = " & kid
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount = 1 then
			personelAD	=	rs("ad")
			numara		=	rs("ceptelefon")
		end if
		rs.close
	end if
'### PERSONEL ADI
'### PERSONEL ADI





if gorevID = "" then
	sorgu = "Select top 1 * from IT.ariza"
	rs.Open sorgu, sbsv5, 1, 3
	rs.addnew
	rs("tarih")	=	now()
	rs("durum")	=	"Yeni"
	rs("olusturanID")	=	kid
	rs("olusturanAD")	=	personelAD
	islem		=	"Görev Eklendi"
else

	if isnumeric(gorevID) = False then
		gorevID = base64_decode_tr(gorevID)
	end if
	sorgu = "Select top 1 * from IT.ariza where arizaID = " & gorevID
	rs.Open sorgu, sbsv5, 1, 3
	islem		=	"Görev Güncellendi"
end if
	rs("ad")		=	ad
	rs("icerik")	=	icerik
	if musteriID <> "" then
		rs("musteriID")	=	musteriID
	end if
	if oncelik <> "" then
		rs("oncelik")	=	oncelik
	end if
	rs("firmaID")	=	firmaID
	rs("tur")		=	tur
	if tarihServis <> "" then
		rs("tarihServis") = tarihServis
	end if
	rs.update
rs.close




	hatamesaj = islem
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-success","","","","","")

	call jsgit("/it/ariza_liste")












%>