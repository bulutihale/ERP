<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    call sessiontest()
    kid		=	kidbul()

	modulAd 		=   "Fason" 

	'##### YETKİ BUL
	'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
	'##### YETKİ BUL
	'##### YETKİ BUL

	islem			=	Request("islem")
	cariID			=	Request("cariID")

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	if yetkiKontrol = 0 then
		call yetkisizGiris("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
	else

	sorgu = "SELECT t1.cariAd, t1.fasonDepoID FROM cari.cari t1"
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.fasonDepoKilit = 1 AND t1.cariID = " & cariID
	rs.open sorgu, sbsv5, 1, 3
		cariAd			=	rs("cariAd")
		fasonDepoID		=	rs("fasonDepoID")
	rs.close

	Response.Write "<div class=""card-header text-center"">"
		Response.Write "<div>" & cariAd & "</div>"
	Response.Write "</div>"

	Response.Write "<div class=""card-body"">"
		Response.Write "<div class=""container"">"

	sorgu = "SELECT t2.stokAd, t1.miktar, t1.miktarBirim"
	sorgu = sorgu & " FROM stok.stokHareket t1"
	sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
	sorgu = sorgu & " WHERE t1.silindi = 0  AND t1.depoID = " & fasonDepoID & " AND t1.stokHareketTuru = 'GB'"
	rs.open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
			for ti = 1 to rs.recordcount
				stokAd		=	rs("stokAd")
				miktar		=	rs("miktar")
				miktarBirim	=	rs("miktarBirim")
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-9"">" & stokAd & "</div>"
					Response.Write "<div class=""col-3"">" & miktar & " " & miktarBirim & "</div>"
				Response.Write "</div>"
			rs.movenext
			next
		end if
		Response.Write "</div>"
	Response.Write "</div>"

	rs.close




	end if
%>


<!--#include virtual="/reg/rs.asp" -->






