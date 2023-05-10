<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	stokHareketID		=	Request.Form("stokHareketID")

	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Üretim için seçilen Lot siliniyor")


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then

	sorgu = "SELECT refHareketID FROM stok.stokHareket WHERE stokHareketID = " & stokHareketID & ""
	rs.open sorgu,sbsv5,1,3
		refHareketID	=	rs("refHareketID")
	rs.close
	
	sorgu = "UPDATE stok.stokHareket SET silindi = 1 WHERE stokHareketID IN ("&stokHareketID&","&refHareketID&")"
	rs.open sorgu,sbsv5,1,3

	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

