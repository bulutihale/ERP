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

	Response.Write "<div>"
	Response.Write "<div id=""divGelenUrunAna"">"

		sorgu = "SELECT t3.stokAd as mamulAd, t1.miktar as fasonMamulMiktar, t2.mikBirim as fasonMamulBirim, t4.cariAd as fasonCari, t1.fasonCariID"
		sorgu = sorgu & " FROM fason.fasonAna t1"
		sorgu = sorgu & " INNER JOIN teklif.siparisKalem t2 ON t1.siparisKalemID = t2.id"
		sorgu = sorgu & " INNER JOIN stok.stok t3 ON t2.stokID = t3.stokID"
		sorgu = sorgu & " INNER JOIN cari.cari t4 ON t1.fasonCariID = t4.cariID"
		sorgu = sorgu & " WHERE t1.id = " & fasonAnaID
		rs.open sorgu, sbsv5, 1, 3
		'Response.Write sorgu
		if rs.recordcount = 0 then
			Response.Write "kayıt yok"
		else
			mamulAd				=	rs("mamulAd")
			fasonMamulMiktar	=	rs("fasonMamulMiktar")
			fasonMamulBirim		=	rs("fasonMamulBirim")
			fasonCari			=	rs("fasonCari")
			fasonCariID			=	rs("fasonCariID")

			Response.Write "<div class=""h3 text-center bold mb-3 border-bottom border-dark"">Fason Üreticiden Gelen Mamul Girişi</div>"
			
			Response.Write "<div class=""container"">"
				Response.Write "<input id=""fasonAnaID"" type=""hidden"" value=""" & fasonAnaID & """>"

				Response.Write "<div class=""row bold text-left"">"
					Response.Write "<div class=""col-3"">Fason Üretici:</div>"
					Response.Write "<div class=""col-9"">" & fasonCari& "</div>"
				Response.Write "</div>"
				
				Response.Write "<hr class=""bg-danger"">"

				Response.Write "<div class=""row bold text-center"">"
					Response.Write "<div class=""col""><u>Mamul Adı</u></div>"
					Response.Write "<div class=""col""><u>Sipariş Miktar</u></div>"
				Response.Write "</div>"
				Response.Write "<div class=""row  mt-2"">"
					Response.Write "<div class=""col"">" & mamulAd & "</div>"
					Response.Write "<div class=""col text-right"">" & fasonMamulMiktar & " " & fasonMamulBirim & "</div>"
				Response.Write "</div>"

				Response.Write "<hr class="""">"
				
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-3 text-right mt-2"">"
						Response.Write "Geliş Tarihi"
					Response.Write "</div>"
					Response.Write "<div class=""col-3 text-left"">"
						Response.Write "<input id=""gelisTarih"" type=""text"" class=""form-control tarih bold text-center"">"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-3 text-right mt-3"">"
						Response.Write "Gelen Miktar"
					Response.Write "</div>"
					Response.Write "<div class=""col-3 text-left mt-2"">"
						Response.Write "<input id=""gelenMiktar"" type=""text"" class=""form-control bold text-center"">"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-3 text-right mt-3"">"
						Response.Write "LOT"
					Response.Write "</div>"
					Response.Write "<div class=""col-3 text-left mt-2"">"
						Response.Write "<input id=""gelenLot"" type=""text"" class=""form-control bold text-center"">"
					Response.Write "</div>"
					Response.Write "<div class=""col-3 text-right mt-3"">"
						Response.Write "LOT SKT"
					Response.Write "</div>"
					Response.Write "<div class=""col-3 text-left mt-2"">"
						Response.Write "<input id=""gelenLotSKT"" type=""text"" class=""form-control bold text-center tarih"">"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-3 text-right mt-3"">"
						Response.Write "Açıklama"
					Response.Write "</div>"
					Response.Write "<div class=""col-9 text-left mt-2"">"
						Response.Write "<input id=""gelenUrunAciklama"" type=""text"" class=""form-control bold text-left"">"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-3 text-right mt-3"">"
					Response.Write "</div>"
					Response.Write "<div class=""col-9 text-left mt-2"">"
						Response.Write "<div class=""btn btn-info rounded"" onclick=""gelenUrunKayit()"">KAYDET</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		end if
		rs.close

		Response.Write "<hr class=""bg-danger"">"

		Response.Write "<div class=""h3 text-center bold mb-3 border-bottom border-dark"">Gelen Mamul Kayıtları</div>"


		sorgu = "SELECT t1.girisTarih, t1.miktar, t1.miktarBirim, t1.lot, t1.aciklama"
		sorgu = sorgu & " FROM stok.stokHareket t1"
		sorgu = sorgu & " WHERE t1.fasonAnaID = " & fasonAnaID & " AND t1.stokHareketTuru = 'G' AND t1.cariID = " & fasonCariID
		rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				Response.Write "<div class=""container"">"
					Response.Write "<div class=""row text-center bold"">"
						Response.Write "<div class=""col""><u>Fason Firma</u></div>"
						Response.Write "<div class=""col""><u>Geliş Tarihi</u></div>"
						Response.Write "<div class=""col text-right""><u>Miktar</u></div>"
						Response.Write "<div class=""col""><u>LOT</u></div>"
						Response.Write "<div class=""col""><u>Açıklama</u></div>"
					Response.Write "</div>"
				for yi = 1 to rs.recordcount
					girisTarih		=	rs("girisTarih")
					miktar			=	rs("miktar")
					miktarBirim		=	rs("miktarBirim")
					lot				=	rs("lot")
					aciklama		=	rs("aciklama")
						Response.Write "<div class=""row fontkucuk mt-2"">"
							Response.Write "<div class=""col"">" & fasonCari & "</div>"
							Response.Write "<div class=""col text-center"">" & girisTarih & "</div>"
							Response.Write "<div class=""col text-right"">" & miktar & " " & miktarBirim & "</div>"
							Response.Write "<div class=""col text-center"">" & lot & "</div>"
							Response.Write "<div class=""col"">" & aciklama & "</div>"
						Response.Write "</div>"
				rs.movenext
				next
				Response.Write "</div>"
			end if
		rs.close
	Response.Write "</div>"
	Response.Write "</div>"
	end if
%><!--#include virtual="/reg/rs.asp" -->










