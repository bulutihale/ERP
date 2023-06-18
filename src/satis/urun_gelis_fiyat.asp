<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
	stokID			=	Request("stokID")
    receteAdimID	=	Request("receteAdimID")

	
	modulAd 		=   "Admin"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
call logla("Ürün geliş fiyatları listele")

yetkiKontrol = yetkibul(modulAd)




	Response.Write "<div class=""text-right""><span data-dismiss=""modal"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
				

Response.Write "<div id=""urunGelisDIV"" class=""scroll-ekle3"">"



	if hata = "" and yetkiKontrol > 2 then

sorgu = ""
sorgu = sorgu & " SELECT t1.birimFiyat, t1.paraBirim, t3.miktar, t3.miktarBirim, t3.girisTarih, t3.lot, t4.cariAd"
sorgu = sorgu & " FROM  teklif.siparisKalem t1"
sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
sorgu = sorgu & " LEFT JOIN stok.stokHareket t3 ON t1.id = t3.siparisKalemID AND t3.silindi = 0"
sorgu = sorgu & " LEFT JOIN cari.cari t4 ON t3.cariID = t4.cariID"
sorgu = sorgu & " WHERE t2.firmaID = 5 AND t2.siparisTur = 'SA' AND t1.stokID = " & stokID
sorgu = sorgu & " ORDER BY t3.girisTarih DESC"
rs.open sorgu, sbsv5, 1, 3


	if rs.recordcount = 0 then
		Response.Write "Kayıt yok"
	else
		Response.Write "<table class=""table table-sm table-striped table-bordered table-hover"">"
			Response.Write "<thead class=""thead-dark fixed-top"" style=""position: sticky;box-shadow: 0 0 10px rgba(0, 0, 0, 0.9);>"
				Response.Write "<tr class=""text-center"">"
					Response.Write "<th class=""col-1"">Sıra</th>"
					Response.Write "<th class=""col-1"">Tedarikçi</th>"
					Response.Write "<th class=""col-4"">Geliş Tarih</th>"
					Response.Write "<th class=""col-1"">Miktar</th>"
					Response.Write "<th class=""col-1"">Fiyat</th>"
				Response.Write "</tr>"
			Response.Write "</thead>"
		Response.Write "<tbody>"
		


			for i = 1 to rs.recordcount
				birimFiyat		=	rs("birimFiyat")
				paraBirim		=	rs("paraBirim")
				miktar			=	rs("miktar")
				miktarBirim		=	rs("miktarBirim")
				girisTarih		=	rs("girisTarih")
				lot				=	rs("lot")
				cariAd			=	rs("cariAd")


		

				Response.Write "<tr>"
					Response.Write "<td class=""text-center bold"">" & i & "</td>"
					Response.Write "<td class=""text-left "">" & cariAd &"</td>"
					Response.Write "<td class=""text-left"">" & girisTarih & "</td>"
					Response.Write "<td class=""text-right"">" & miktar & " " & miktarBirim & "</td>"
					Response.Write "<td class=""text-right"">"
					Response.Write "<div class=""pointer"" onclick=""$('#subbirimMaliyet_"&receteAdimID&"').val($(this).attr('data-deger')).trigger('change')"" data-deger=""" & birimFiyat & """>" & birimFiyat & " " & paraBirim & "</div>" 
					Response.Write "</td>"
				Response.Write "</tr>"
			rs.movenext
			next
		

		Response.Write "</tbody>"
		Response.Write "</table>"




end if
end if

Response.Write "</div>"






%><!--#include virtual="/reg/rs.asp" -->









