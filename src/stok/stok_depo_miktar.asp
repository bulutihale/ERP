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


            sorgu = "SELECT t1.stokKodu, t1.stokAd, stok.stokSayDepo(t1.stokID, t2.depoID) as stokMiktar,"
			sorgu = sorgu & " stok.stokSayDepoLot(t1.stokID, t2.depoID, t2.lot) as lotMiktar, t3.depoAd, t2.lot, t2.miktarBirim"
			sorgu = sorgu & " FROM stok.stok t1"
			sorgu = sorgu & " INNER JOIN stok.stokHareket t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " INNER JOIN stok.depo t3 ON t2.depoID = t3.id"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & gorevID & " AND t2.silindi = 0"
			sorgu = sorgu & " AND stok.stokSayDepo(t1.stokID, t2.depoID) > 0"
			sorgu = sorgu & " AND stok.stokSayDepoLot(t1.stokID, t2.depoID, t2.lot) > 0"
			sorgu = sorgu & " GROUP BY t2.depoID, t1.stokKodu, t1.stokID, t3.depoAd, t1.stokAd, t2.lot, t2.miktarBirim"
			rs.open sorgu, sbsv5, 1, 3
	'response.Write sorgu

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">Kod</th>"
		Response.Write "<th scope=""col"">Ürün Adı</th>"
		Response.Write "<th scope=""col"">LOT</th>"
		Response.Write "<th scope=""col"">Lot Miktar</th>"
		Response.Write "<th scope=""col"">Depo Miktar</th>"
		Response.Write "<th scope=""col"">Depo Ad</th>"
		Response.Write "</tr></thead><tbody>"
		
				do until rs.EOF
					stokKodu		=	rs("stokKodu")
					stokAd			=	rs("stokAd")
					depoAd			=	rs("depoAd")
					lot				=	rs("lot")
					lotMiktar		=	rs("lotMiktar")
					stokMiktar		=	rs("stokMiktar")
					miktarBirim		=	rs("miktarBirim")
					Response.Write "<tr>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>" & stokAd & "</td>"
						Response.Write "<td>" & lot & "</td>"
						Response.Write "<td class=""text-right"">" & lotMiktar & " " & miktarBirim & " </td>"
						Response.Write "<td class=""text-right"">" & stokMiktar & " " & miktarBirim & " </td>"
						Response.Write "<td>" & depoAd & "</td>"
					Response.Write "</tr>"
					Response.Flush()
				rs.movenext
				loop
            rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->









