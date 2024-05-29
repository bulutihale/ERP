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

	fasonAnaID			=	Request("fasonAnaID")

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	if yetkiKontrol = 0 then
		call yetkisizGiris("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
	else

	sorgu = "SELECT t4.stokAd as mamulAd, t5.stokAd as bilesenAd, t6.miktar as gidenMiktar, t6.miktarBirim, t2.miktar as fasonMamulMiktar, t3.mikBirim as fasonMamulBirim"
	sorgu = sorgu & " FROM fason.fasonDetay t1"
	sorgu = sorgu & " INNER JOIN fason.fasonAna t2 ON t1.fasonAnaID = t2.id"
	sorgu = sorgu & " INNER JOIN teklif.siparisKalem t3 ON t2.siparisKalemID = t3.id"
	sorgu = sorgu & " INNER JOIN stok.stok t4 ON t3.stokID = t4.stokID"
	sorgu = sorgu & " INNER JOIN stok.stok t5 ON t1.stokID = t5.stokID"
	sorgu = sorgu & " INNER JOIN stok.stokHareket t6 ON t1.gidisStokHareketID = t6.stokHareketID"
	sorgu = sorgu & " WHERE t1.fasonAnaID = " & fasonAnaID
	rs.open sorgu, sbsv5, 1, 3
	'Response.Write sorgu
	if rs.recordcount = 0 then
		Response.Write "kayıt yok"
	else
		mamulAd				=	rs("mamulAd")
		fasonMamulMiktar	=	rs("fasonMamulMiktar")
		fasonMamulBirim		=	rs("fasonMamulBirim")

		Response.Write "<div class=""container"">"

			Response.Write "<div class=""row bold text-center"">"
				Response.Write "<div class=""col""><u>Mamul Adı</u></div>"
				Response.Write "<div class=""col""><u>Sipariş Miktar</u></div>"
				Response.Write "<div class=""col""><u>Gelen Miktar</u></div>"
			Response.Write "</div>"
			Response.Write "<div class=""row  mt-2"">"
				Response.Write "<div class=""col"">" & mamulAd & "</div>"
				Response.Write "<div class=""col text-right"">" & fasonMamulMiktar & " " & fasonMamulBirim & "</div>"
				Response.Write "<div class=""col text-center"">"
					Response.Write "<div class=""btn btn-warning rounded"" onclick=""modalajax('/fason/modal_gelen_mamul.asp?fasonAnaID=" & fasonAnaID & "')"">Gelen Ürün</div>"
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<hr class=""bg-danger"">"

			Response.Write "<div class=""row bold text-center"">"
				Response.Write "<div class=""col""><u>Bileşen Adı</u></div>"
				Response.Write "<div class=""col""><u>Giden Miktar</u></div>"
			Response.Write "</div>"
			for zi = 1 to rs.recordcount
				bilesenAd		=	rs("bilesenAd")
				gidenMiktar		=	rs("gidenMiktar")
				miktarBirim		=	rs("miktarBirim")
			Response.Write "<div class=""row fontkucuk mt-2"">"
				Response.Write "<div class=""col"">"
					Response.Write bilesenAd
				Response.Write "</div>"
				Response.Write "<div class=""col text-right"">"
					Response.Write gidenMiktar & " " & miktarBirim
				Response.Write "</div>"
			Response.Write "</div>"
			rs.movenext
			next
		Response.Write "</div>"
	end if
	rs.close
	end if
%><!--#include virtual="/reg/rs.asp" -->










