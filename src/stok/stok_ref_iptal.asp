<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	stokRefID			=	Request.Form("stokRefID")

	modulAd =   "Stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()



yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then

	call logla("stok ref kaydı siliniyor stokRefID: " & stokRefID)


		sorgu = "UPDATE stok.stokRef SET silindi = 1 WHERE id = " & stokRefID
		rs.open sorgu,sbsv5,3,3


	else
	Response.Write "silinmedi"
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

