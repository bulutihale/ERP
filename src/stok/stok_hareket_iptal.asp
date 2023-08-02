<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	stokHareketID		=	Request.Form("stokHareketID")

	modulAd =   "Stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()



yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then

	call logla("stok hareket kaydı geri alınıyor stokHareketID: " & stokHareketID)

	sorgu = "SELECT ISNULL(t1.refHareketID,0) as refHareketID FROM stok.stokHareket t1 WHERE t1.stokHareketID = " & stokHareketID
	rs.open sorgu,sbsv5,1,3
		refHareketID	= rs("refHareketID")
	rs.close

	if stokHareketID = 0 then
		call toastrCagir("refHareketID yok işlem yapılmadı.","HATA","center","error","otomatik","")
		Response.End()
	else
		sorgu = "UPDATE stok.stokHareket SET silindi = 1 WHERE stokHareketID = " & stokHareketID
		rs.open sorgu,sbsv5,3,3
		sorgu = "UPDATE stok.stokHareket SET silindi = 1 WHERE stokHareketID = " & refHareketID
		rs.open sorgu,sbsv5,3,3
	end if

	else
	Response.Write "silinmedi"
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

