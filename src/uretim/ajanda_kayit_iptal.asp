<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	ajandaID			=	Request.Form("ajandaID")


	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Ajanda kaydı iptal ediliyor ajandaID: " & ajandaID) 


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then

	sorgu = "UPDATE portal.ajanda SET silindi = 1 WHERE id = " & ajandaID & " AND baslangicZaman is null AND tamamlandi = 0"
	rs.open sorgu, sbsv5, 3, 3

	sorgu = "UPDATE portal.ajanda SET silindi = 1 WHERE bagliAjandaID = " & ajandaID & " AND baslangicZaman is null AND tamamlandi = 0"
	rs.open sorgu, sbsv5, 3, 3

	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

