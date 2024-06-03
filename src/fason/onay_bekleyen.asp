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


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	if yetkiKontrol = 0 then
		call yetkisizGiris("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
	else


	sorgu = "SELECT "
	sorgu = sorgu & " DISTINCT "
	sorgu = sorgu & " t1.id as ajandaID, t3.fasonCariID, t4.cariAd as fasonCari, t7.cariAd as siparisVeren, t3.miktar, t5.mikBirim, t8.stokAd as mamulAd, t1.fasonAnaID"
	'sorgu = sorgu & " , t9.stokAd as bilesenAd"
	sorgu = sorgu & " FROM portal.ajanda t1"
	sorgu = sorgu & " INNER JOIN stok.stokHareket t2 ON t2.ajandaID IN (SELECT id FROM portal.ajanda WHERE bagliAjandaID = t1.id) AND t2.stokHareketTuru IN ('GB') AND t2.silindi = 0"
	sorgu = sorgu & " INNER JOIN fason.fasonAna t3 ON t1.fasonAnaID = t3.id AND t3.silindi = 0"
	sorgu = sorgu & " INNER JOIN cari.cari t4 ON t3.fasonCariID = t4.cariID"
	sorgu = sorgu & " INNER JOIN teklif.siparisKalem t5 ON t3.siparisKalemID = t5.id"
	sorgu = sorgu & " INNER JOIN teklif.siparis t6 ON t5.siparisID = t6.sipID"
	sorgu = sorgu & " INNER JOIN cari.cari t7 ON t6.cariID = t7.cariID"
	sorgu = sorgu & " INNER JOIN stok.stok t8 ON t5.stokID = t8.stokID"
	sorgu = sorgu & " INNER JOIN stok.stok t9 ON t2.stokID = t9.stokID"
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.fasonAnaID > 0"
	rs.open sorgu, sbsv5, 1, 3


	Response.Write "<div id=""divOnayListe"">"
	
			Response.Write "<div class=""row text-center bold border-bottom border-dark"">"
				Response.Write "<div class=""col-4"">Sipariş Cari</div>"
				Response.Write "<div class=""col-4"">Ürün</div>"
				Response.Write "<div class=""col-4"">Fason Cari</div>"
			Response.Write "</div>"
		if rs.EOF then
			Response.Write "<div class=""mt-3 text-danger bold"">Kayıt Yok</div>"
		else
			do until rs.EOF
				ajandaID			=	rs("ajandaID")
				siparisVeren		=	rs("siparisVeren")
				mamulAd				=	rs("mamulAd")
				fasonCari			=	rs("fasonCari")
				fasonCariID			=	rs("fasonCariID")
				fasonAnaID			=	rs("fasonAnaID")

				Response.Write "<div id=""div"&ajandaID&""""
				Response.Write " class=""row fontkucuk2 hoverGel mt-2 pointer onayBekleCls"""
				Response.Write " onclick=""butonRenk('div"&ajandaID&"','info','onayBekleCls');"
					Response.Write " working('DIV2','30px','30px');"
					Response.Write " $('#DIV2').load('/fason/fason_verilenIs.asp',{fasonAnaID:"&fasonAnaID&",cariID:"&fasonCariID&"});"
					Response.Write " working('DIV3','30px','30px');"
					Response.Write " $('#DIV3').load('/fason/urun_detay.asp',{fasonAnaID:"&fasonAnaID&"})"""
				Response.Write ">"
					Response.Write "<div class=""col-4"">" & siparisVeren & "</div>"
					Response.Write "<div class=""col-4"">" & mamulAd & "</div>"
					Response.Write "<div class=""col-4"">" & fasonCari & "</div>"
				Response.Write "</div>"
			rs.movenext
			loop
		end if
	Response.Write "</div>"
	

	rs.close




	end if
%><!--#include virtual="/reg/rs.asp" -->










