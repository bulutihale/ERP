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


            sorgu = "SELECT t1.stokKodu, t1.stokAd, stok.FN_stokSayGB(" & firmaID & ", t1.stokID, t2.depoID) as stokMiktarGB,"
			sorgu = sorgu & " stok.FN_stokSayDepoLot(" & firmaID & ", t1.stokID, t2.depoID, t2.lot) as lotMiktar,"
			sorgu = sorgu & " t3.depoAd, t2.lot, t2.miktarBirim"
			sorgu = sorgu & " FROM stok.stok t1"
			sorgu = sorgu & " INNER JOIN stok.stokHareket t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " INNER JOIN stok.depo t3 ON t2.depoID = t3.id"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & gorevID & " AND t2.silindi = 0"
			sorgu = sorgu & " AND stok.FN_stokSayDepo(" & firmaID & ", t1.stokID, t2.depoID) > 0"
			sorgu = sorgu & " AND stok.FN_stokSayDepoLot(" & firmaID & ", t1.stokID, t2.depoID, t2.lot) > 0"
			sorgu = sorgu & " GROUP BY t2.depoID, t1.stokKodu, t1.stokID, t3.depoAd, t1.stokAd, t2.lot, t2.miktarBirim"
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
		Response.Write "<th scope=""col"" class=""text-center"">Lot Miktar</th>"
		' Response.Write "<th scope=""col"">Depo Miktar</th>"
		Response.Write "<th scope=""col"">Depo Ad</th>"
		Response.Write "</tr></thead><tbody>"
					
				do until rs.EOF
					depoAd			=	rs("depoAd")
					lot				=	rs("lot")
					lotMiktar		=	rs("lotMiktar")
					miktarBirim		=	rs("miktarBirim")
					Response.Write "<tr>"
						Response.Write "<td>" & lot & "</td>"
						Response.Write "<td class=""text-right"">" & lotMiktar & " " & miktarBirim & " </td>"
						Response.Write "<td>" & depoAd & "</td>"
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









