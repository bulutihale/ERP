<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    call sessiontest()
    kid		=	kidbul()

	modulAd 		=   "Fason" 

	    Response.Write "<style>"
    	Response.Write "th {"
           ' Response.Write "height: 30px;"
            Response.Write "padding: 5px;"
			Response.Write "font-size: 12px;"
        Response.Write "}"
    	Response.Write "td {"
           ' Response.Write "height: 30px;"
            Response.Write "padding: 5px;"
			Response.Write "font-size: 10px;"
        Response.Write "}"
    Response.Write "</style>"


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




	sorgu = "SELECT t4.stokKodu as bilesenStokKodu, t4.stokAd as bilesenAd, t5.stokKodu as mamulStokKodu, t5.stokAd as mamulAd,"
	sorgu = sorgu & " t3.miktar as mamulMiktar, t6.mikBirim as mamulBirim, t1.miktar as bilesenMiktar, t1.miktarBirim as bilesenBirim,"
	sorgu = sorgu & " t7.cariAd as fasonUreticiAd, t9.cariAd as siparisVerenCari"
	sorgu = sorgu & " FROM stok.stokhareket t1"
	sorgu = sorgu & " INNER JOIN portal.ajanda t2 ON t1.ajandaID = t2.id"
	sorgu = sorgu & " INNER JOIN portal.ajanda t3 ON t2.bagliAjandaID = t3.id"
	sorgu = sorgu & " INNER JOIN stok.stok t4 ON t2.stokID = t4.stokID"
	sorgu = sorgu & " INNER JOIN stok.stok t5 ON t3.stokID = t5.stokID"
	sorgu = sorgu & " INNER JOIN teklif.siparisKalem t6 ON t3.siparisKalemID = t6.id"
	sorgu = sorgu & " INNER JOIN cari.cari t7 ON t1.depoID = t7.fasonDepoID"
	sorgu = sorgu & " INNER JOIN teklif.siparis t8 ON t6.siparisID = t8.sipID"
	sorgu = sorgu & " INNER JOIN cari.cari t9 ON t8.cariID = t9.cariID"
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.stokHareketTuru = 'GB' AND t3.isTur = 'fason'"
	sorgu = sorgu & " ORDER BY t7.cariAd"
	rs.open sorgu, sbsv5, 1, 3
		if rs.recordcount = 0 then
			Response.Write "kayıt yok"
		else

			mailBaslik	=	""
			mailBaslik	=	"Fason üreticiye gidecek ürünler için onay talebi."

			mailicerik	=	""
			mailicerik 	=	mailicerik & "<table style=""width:100%;border-collapse:collapse;"" border=""1"">"

			mailicerik	=	mailicerik & "<tr>"
				mailicerik	=	mailicerik & "<thead>"
					mailicerik	=	mailicerik & "<th style=""text-align:center"">Bileşen</th>"
					mailicerik	=	mailicerik & "<th style=""text-align:center"">Bileşen Miktar</th>"
					mailicerik	=	mailicerik & "<th style=""text-align:center"">Ana Mamul</th>"
					mailicerik	=	mailicerik & "<th style=""text-align:center"">Mamul Miktar</th>"
					mailicerik	=	mailicerik & "<th style=""text-align:center"">Fason Üretici</th>"
					mailicerik	=	mailicerik & "<th style=""text-align:center"">Sipariş Veren</th>"
				mailicerik	=	mailicerik & "</thead>"
			mailicerik	=	mailicerik & "</tr>"
			
			for yi = 1 to rs.recordcount
				bilesenStokKodu			=	rs("bilesenStokKodu")
				bilesenAd				=	rs("bilesenAd")
				mamulStokKodu			=	rs("mamulStokKodu")
				mamulAd					=	rs("mamulAd")
				mamulMiktar				=	rs("mamulMiktar")
				mamulBirim				=	rs("mamulBirim")
				bilesenMiktar			=	rs("bilesenMiktar")
				bilesenBirim			=	rs("bilesenBirim")
				fasonUreticiAd			=	rs("fasonUreticiAd")
				siparisVerenCari		=	rs("siparisVerenCari")

			mailicerik	=	mailicerik & "<tr>"
				mailicerik	=	mailicerik & "<td>" & bilesenStokKodu & " - " & bilesenAd & "</td>"
				mailicerik	=	mailicerik & "<td style=""text-align:right;"">" & bilesenMiktar & " " & bilesenBirim &"</td>"
				mailicerik	=	mailicerik & "<td>" & mamulStokKodu & " - " & mamulAd & "</td>"
				mailicerik	=	mailicerik & "<td style=""text-align:right;"">" & mamulMiktar & " " & mamulBirim &"</td>"
				mailicerik	=	mailicerik & "<td>" & fasonUreticiAd &"</td>"
				mailicerik	=	mailicerik & "<td>" & siparisVerenCari &"</td>"
			mailicerik	=	mailicerik & "</tr>"

			rs.movenext
			next
		end if
	rs.close
		mailicerik	=	mailicerik & "</table>"
	call mailGonderCDO(mailBaslik, mailicerik, "", "", 16)

Response.Write "mail gitti"
'Response.Write mailicerik

	end if
%><!--#include virtual="/reg/rs.asp" -->










