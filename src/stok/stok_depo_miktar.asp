<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    gorevID 	=   Request.QueryString("gorevID")
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Stok Depo Miktarları Detay")

yetkiKontrol = yetkibul(modulAd)


            ' sorgu = "SELECT t1.stokKodu, t1.stokAd, stok.FN_stokSayGB(" & firmaID & ", t1.stokID, t2.depoID) as stokMiktarGB,"
			' sorgu = sorgu & " stok.FN_stokSayDepoLot(" & firmaID & ", t1.stokID, t2.depoID, t2.lot) as lotMiktar,"
			' sorgu = sorgu & " t3.depoAd, t2.lot, t2.miktarBirim, t6.cariAd, t2.lotSKT as lotSKT"
			' sorgu = sorgu & " FROM stok.stok t1"
			' sorgu = sorgu & " INNER JOIN stok.stokHareket t2 ON t1.stokID = t2.stokID"
			' sorgu = sorgu & " INNER JOIN stok.depo t3 ON t2.depoID = t3.id"
			' sorgu = sorgu & " LEFT JOIN teklif.siparisKalem t4 ON  t2.siparisKalemID = t4.id"
			' sorgu = sorgu & " LEFT JOIN teklif.siparis t5 ON t4.siparisID = t5.sipID"
  			' sorgu = sorgu & " LEFT JOIN cari.cari t6 ON t5.cariID = t6.cariID"
			' sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & gorevID & " AND t2.silindi = 0"
			' sorgu = sorgu & " AND stok.FN_stokSayDepo(" & firmaID & ", t1.stokID, t2.depoID) > 0"
			' sorgu = sorgu & " AND stok.FN_stokSayDepoLot(" & firmaID & ", t1.stokID, t2.depoID, t2.lot) > 0"
			' sorgu = sorgu & " GROUP BY t2.depoID, t1.stokKodu, t1.stokID, t3.depoAd, t1.stokAd, t2.lot, t2.miktarBirim, t4.siparisID, t6.cariAd,t2.lotSKT "



sorgu = "SELECT"
sorgu = sorgu & " t1.stokKodu,"
sorgu = sorgu & " t1.stokAd,"
sorgu = sorgu & " stok.FN_stokSayGB ( " & firmaID & ", t1.stokID, t2.depoID ) AS stokMiktarGB,"
sorgu = sorgu & " stok.FN_stokSayDepoLot ( " & firmaID & ", t1.stokID, t2.depoID, t2.lot ) AS lotMiktar,"
sorgu = sorgu & " t3.depoAd,"
sorgu = sorgu & " t2.lot,"
sorgu = sorgu & " t2.miktarBirim,"
'sorgu = sorgu & " t6.cariAd,"
sorgu = sorgu & " t2.lotSKT AS lotSKT"
sorgu = sorgu & " FROM"
sorgu = sorgu & " stok.stok t1"
sorgu = sorgu & " INNER JOIN stok.stokHareket t2 ON t1.stokID = t2.stokID"
sorgu = sorgu & " INNER JOIN stok.depo t3 ON t2.depoID = t3.id"
'sorgu = sorgu & " LEFT JOIN teklif.siparisKalem t4 ON t2.siparisKalemID = t4.id"
'sorgu = sorgu & " LEFT JOIN teklif.siparis t5 ON t4.siparisID = t5.sipID"
'sorgu = sorgu & " LEFT JOIN cari.cari t6 ON t5.cariID = t6.cariID"
sorgu = sorgu & " WHERE"
sorgu = sorgu & " t1.firmaID = " & firmaID & ""
sorgu = sorgu & " AND t1.stokID = " & gorevID & ""
sorgu = sorgu & " AND t2.silindi = 0"
sorgu = sorgu & " AND stok.FN_stokSayDepo ( " & firmaID & ", t1.stokID, t2.depoID ) > 0"
sorgu = sorgu & " AND stok.FN_stokSayDepoLot ( " & firmaID & ", t1.stokID, t2.depoID, t2.lot ) > 0"
sorgu = sorgu & " GROUP BY"
sorgu = sorgu & " t2.depoID,"
sorgu = sorgu & " t1.stokKodu,"
sorgu = sorgu & " t1.stokID,"
sorgu = sorgu & " t3.depoAd,"
sorgu = sorgu & " t1.stokAd,"
sorgu = sorgu & " t2.lot,"
sorgu = sorgu & " t2.miktarBirim,"
'sorgu = sorgu & " t4.siparisID,"
'sorgu = sorgu & " t6.cariAd,"
sorgu = sorgu & " t2.lotSKT"
	rs.open sorgu, sbsv5, 1, 3
'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 AND not rs.EOF then
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"


		stokKodu		=	rs("stokKodu")
		stokAd			=	rs("stokAd")

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col h3 text-info bold"">" & stokKodu & "</div>"
			Response.Write "<div class=""col h3 text-info text-right bold"">" & stokAd & "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-12 text-danger fontkucuk2"">**Depo giriş onayı bekleyen ürünler GÖSTERİLMEZ.</div>"
		Response.Write "</div>"

		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">LOT</th>"
		Response.Write "<th scope=""col"">LOT SKT</th>"
		Response.Write "<th scope=""col"" class=""text-center"">Lot Miktar</th>"
		' Response.Write "<th scope=""col"">Depo Miktar</th>"
		Response.Write "<th scope=""col"">Depo Ad</th>"
		Response.Write "<th scope=""col"">Müşteri Ad</th>"
		
		Response.Write "</tr></thead><tbody>"
					
				do until rs.EOF
					depoAd			=	rs("depoAd")
					lot				=	rs("lot")
					lotSKT			=	rs("lotSKT")
					lotMiktar		=	rs("lotMiktar")
					miktarBirim		=	rs("miktarBirim")
					'cariAd			=	rs("cariAd")
					Response.Write "<tr>"
						Response.Write "<td>" & lot & "</td>"
						Response.Write "<td>" & lotSKT & "</td>"
						Response.Write "<td class=""text-right"">" & lotMiktar & " " & miktarBirim & " </td>"
						Response.Write "<td>" & depoAd & "</td>"
						Response.Write "<td>" & cariAd & "</td>"
					Response.Write "</tr>"
					Response.Flush()
				rs.movenext
				loop
            rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
	elseif rs.EOF then
		Response.Write "Stokta bu ürün bulunmuyor."
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->









