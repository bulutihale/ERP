<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	stokHareketID		=	Request.Form("stokHareketID")

	modulAd =   "Sterilizasyon"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()



yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then

	call logla("Sterilizasyon cihazından ürün çıkarıldı")

	sorgu = "UPDATE stok.stokHareket SET sterilCevrimID = 0 WHERE stokHareketID = " & stokHareketID
	rs.open sorgu,sbsv5,3,3
Response.Write "silindi"
	else
	Response.Write "silinmedi"
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

