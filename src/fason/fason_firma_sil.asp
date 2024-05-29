<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	fasonAnaID			=	Request.Form("fasonAnaID")

	modulAd =   "Fason"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	'if hata = "" and yetkiKontrol > 0 then

	sorgu = "SELECT silindi, siparisKalemID, miktar as silinenMiktar FROM fason.fasonAna WHERE id = " & fasonAnaID & " AND silindi = 0"
	rs.open sorgu,sbsv5,1,3
		siparisKalemID	=	rs("siparisKalemID")
		silinenMiktar	=	rs("silinenMiktar")
		rs("silindi")	=	1
	rs.update
	rs.close
	
	sorgu = "SELECT miktarFason, miktar, sipMiktar FROM teklif.siparisKalem WHERE id = " & siparisKalemID
	rs.open sorgu,sbsv5,1,3

		yeniMiktar			=	rs("miktar") + silinenMiktar
		yeniMiktarFason		=	rs("sipMiktar") - yeniMiktar
		rs("miktar")		=	yeniMiktar
		if yeniMiktarFason = 0 then yeniMiktarFason = null
		rs("miktarFason")	=	yeniMiktarFason
		rs.update
	rs.close


	'else
		'call yetkisizGiris("","","")
		'hata = 1
	'end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

