<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()

	aramaad		=	trim(Request.Form("aramaad"))

    Response.Flush()

    modulAd =   "Satın Alma"
    modulID =   "88"
	yetkiKontrol	 =	yetkibul(modulAd)
'###### ANA TANIMLAMALAR






		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
					Response.Write "<div class=""h3"">Satınalma İhtiyaç Analizi</div>"
					Response.Write "<div class=""fontkucuk2 text-danger ml-3"">** Ürün kartında ""satınalma ile temin"" işaretli olmalıdır.</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"


'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-6 col-sm-12"">"
                Response.Write "<div class=""card scroll-ekle3"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
					
					
					sorgu = sorgu & " SELECT DISTINCT t1.stokID, t2.stokkodu, t2.stokAd, t1.isTur,"
					sorgu = sorgu & " [stok].[FN_stokSay] (" & firmaID & ", t1.stokID) as toplamStokMiktar"
					sorgu = sorgu & " FROM portal.ajanda t1"
					sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
					sorgu = sorgu & " WHERE t1.isTur = 'transfer' AND t1.tamamlandi = 0 AND t1.silindi = 0 AND t2.disaridanTemin = 1"
					sorgu = sorgu & " ORDER BY t2.stokAd"
					rs.open sorgu, sbsv5, 1, 3

					if rs.EOF then
						bilgi = translate("Seçtiğiniz kriterlerde kayıt bulunamadı","","")
						call yetkisizGiris(bilgi,"","")
					else
						Response.Write "<div class=""table-responsive"">"
						Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark"">"
							Response.Write "<tr>"
							Response.Write "<th scope=""col"">Ürün Kodu</th>"
							Response.Write "<th scope=""col"">Ürün Adı</th>"
							Response.Write "<th scope=""col"">Stok Genel Miktar</th>"
							Response.Write "<th scope=""col"">Planlanmış Miktar</th>"
							Response.Write "</tr>"
						Response.Write "</thead><tbody>"
							do until rs.EOF
								toplamStokMiktar	=	rs("toplamStokMiktar")
								isTur				=	rs("isTur")
								stokID				=	rs("stokID")
								stokID64	 		=	stokID
								stokID64			=	base64_encode_tr(stokID64)
								stokKodu			=	rs("stokKodu")
								stokAd				=	rs("stokAd")

								sorgu1 = "EXEC stok.SP_urunIhtiyacMiktarBul @stokID = "&stokID&", @firmaID= "&firmaID&", @isTur = '"&isTur&"'"
								fn1.open sorgu1, sbsv5, 1, 3			
									planMiktar	=	fn1(0)
								fn1.close

								if cdbl(toplamStokMiktar) - cdbl(planMiktar) < 0  then
									siparisUyari	=	" text-danger bold "
								else
									siparisUyari 	=	""
								end if
								Response.Write "<tr class=""pointer hoverGel"" onclick=""working('stokMiktarDIV',30,30); working('ihtiyacDIV',30,30);$('#stokMiktarDIV').load('/stok/stok_depo_miktar.asp?gorevID="&stokID64&"&listeTur="&isTur&"&ekran=satinalma');$('#ihtiyacDIV').load('/uretim/ihtiyac_analiz.asp?gorevID="&stokID64&"&listeTur="&isTur&"&ekran=satinalma')"">"
									Response.Write "<td>" & stokKodu & "</td>"
									Response.Write "<td>" & stokAd & "</td>"
									Response.Write "<td class=""text-right"">" & toplamStokMiktar & "</td>"
									Response.Write "<td class=""text-right"&siparisUyari&""">" & planMiktar & "</td>"
								Response.Write "</tr>"
								Response.Flush()
							rs.movenext
							loop
						Response.Write "</tbody>"
						Response.Write "</table>"
						Response.Write "</div>"
					end if
					rs.close
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""col-lg-6 col-sm-12"">"
                Response.Write "<div class=""card scroll-ekle3 h-100"">"
					Response.Write "<div class=""card-body"">"
					'####### stok miktarları bu DIV'e yuklensin
					'####### stok miktarları bu DIV'e yuklensin
						Response.Write "<div id=""stokMiktarDIV"" class=""card h-50 border border-danger"">"
							Response.Write "<div class=""card-body border"">"
							Response.Write "</div>"
						Response.Write "</div>"
					'####### stok miktarları bu DIV'e yuklensin
					'####### stok miktarları bu DIV'e yuklensin

					'####### ihtiyaçlar bu DIV'e yuklensin
					'####### ihtiyaçlar bu DIV'e yuklensin
						Response.Write "<div id=""ihtiyacDIV"" class=""card scroll-ekle3 mt-2 h-50 border border-dark"">"
							Response.Write "<div class=""card-body "">"
							Response.Write "</div>"
						Response.Write "</div>"
					'####### ihtiyaçlar bu DIV'e yuklensin
					'####### ihtiyaçlar bu DIV'e yuklensin
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	else
		hata = translate("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
		call yetkisizGiris(hata,"","")
	end if
'####### SONUÇ TABLOSU



%><!--#include virtual="/reg/rs.asp" -->

