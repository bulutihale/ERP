<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	siparisKalemID		=	Request.Form("siparisKalemID")

	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Üretim başlat")


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 6 then

	
	sorgu = "UPDATE stok.stokHareket SET stokHareketTipi = 'U' WHERE siparisKalemID = " & siparisKalemID & " AND stokHareketTuru = 'G'"
	rs.open sorgu,sbsv5,1,3

	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

