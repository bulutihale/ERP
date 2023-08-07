<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    ID				=	Request.QueryString("ID")
    kid64			=	ID
    opener  		=   Request.Form("opener")
    gorevID 		=   Request.QueryString("gorevID")
	gorevID64		=	gorevID
	gorevID			=	base64_decode_tr(gorevID64)
	siparisKalemID	=	Request.QueryString("siparisKalemID")
	modulAd 		=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Stok Depo Miktarları Detay")

yetkiKontrol = yetkibul(modulAd)




	sorgu = "SELECT"
	sorgu = sorgu & " t1.stokKodu, t1.stokAd"
	sorgu = sorgu & " FROM stok.stok t1"
	sorgu = sorgu & " WHERE"
	sorgu = sorgu & " t1.firmaID = " & firmaID & ""
	sorgu = sorgu & " AND t1.stokID = " & gorevID & ""
	sorgu = sorgu & " AND t1.silindi = 0"
	rs.open sorgu, sbsv5, 1, 3



		Response.Write "<div class=""text-right""><span  data-dismiss=""modal"" class=""mdi mdi-close-circle pointer d-none""></span></div>"


		stokKodu		=	rs("stokKodu")
		stokAd			=	rs("stokAd")

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col h3 text-info bold"">" & stokKodu & "</div>"
			Response.Write "<div class=""col h3 text-info text-right bold"">" & stokAd & "</div>"
		Response.Write "</div>"
	rs.close

Response.Flush()
	if hata = "" and yetkiKontrol > 2 then
'############## depo girişi bekleyenler
	sorgu = "SELECT t1.stokKodu, t1.stokAd,"
	sorgu = sorgu & " t2.miktar,"
	sorgu = sorgu & " t3.depoAd, t2.lot, t2.miktarBirim, t2.lotSKT"
	sorgu = sorgu & " FROM stok.stok t1"
	sorgu = sorgu & " INNER JOIN stok.stokHareket t2 ON t1.stokID = t2.stokID"
	sorgu = sorgu & " INNER JOIN stok.depo t3 ON t2.depoID = t3.id"
	sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & gorevID & " AND t2.silindi = 0"
	sorgu = sorgu & " AND stokHareketTuru = 'GB'"
	rs.open sorgu, sbsv5, 1, 3
	
	if rs.recordcount > 0 then

		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm table-danger""><thead class=""thead-danger""><tr class=""text-center fontkucuk2"">"
		Response.Write "<th >LOT</th>"
		Response.Write "<th >LOT SKT</th>"
		Response.Write "<th  class=""text-center"">Lot Miktar</th>"
		Response.Write "<th >Depo Ad</th>"
		Response.Write "</tr></thead><tbody>"
	
		for zi = 1 to rs.recordcount
			depoAd			=	rs("depoAd")
			lot				=	rs("lot")
			lotSKT			=	rs("lotSKT")
			miktar			=	rs("miktar")
			miktarBirim		=	rs("miktarBirim")

					Response.Write "<tr>"
						Response.Write "<td>" & lot & "</td>"
						Response.Write "<td>" & lotSKT & "</td>"
						Response.Write "<td class=""text-right"">" & miktar & " " & miktarBirim & " </td>"
						Response.Write "<td>" & depoAd & "<span class=""fontkucuk2 text-success""> (giriş bekliyor)</span></td>"
					Response.Write "</tr>"
		rs.movenext
		next
		Response.Write "</tbody>"
		Response.Write "</table>"
	end if
	rs.close
'############## /depo girişi bekleyenler


Response.Write "<hr>"

		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark text-center"">"
		Response.Write "<tr>"
			Response.Write "<th >Depo</th>"
			Response.Write "<th >Depo Miktarı</th>"
		Response.Write "</tr>"
		Response.Write "</thead><tbody>"

		sorgu = "SELECT t1.id as depoID, t1.depoAd, stok.FN_stokSayDepo (" & firmaID & ", " & gorevID & ", t1.id) as depoMiktar,"
		sorgu = sorgu & " [stok].[FN_anaBirimADBul] (" & gorevID & ", 'kAd') as anaBirim"
		sorgu = sorgu & " FROM stok.depo t1"
		sorgu = sorgu & " WHERE stok.FN_stokSayDepo (" & firmaID & ", " & gorevID & ", t1.id) <> 0"
		rs.open sorgu, sbsv5, 1, 3
			for di = 1 to rs.recordcount

				depoID				=	rs("depoID")
				depoAd				=	rs("depoAd")
				depoMiktar			=	rs("depoMiktar")
				anaBirim			=	rs("anaBirim")
				Response.Write "<tr class=""bold"">"
					Response.Write "<td>"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col"">" & depoAd & "</div>"
							Response.Write "<div class=""col text-right""><span class=""pointer"" title=""Depodaki LOT detayları."" onclick=""lotMiktarGetir('lotDetayDIV_"&depoID&"'," & gorevID & "," & depoID & ")""><i class=""icon css-go""></i></span></div>"
						Response.Write "</div>"
					Response.Write "</td>"
					Response.Write "<td class=""text-right"">" & OndalikKontrol(depoMiktar) & " " & anaBirim & "</td>"
					Response.Write "</td>"
				Response.Write "</tr>"
				Response.Write "<tr>"
					Response.Write "<td class=""text-right"" colspan=""2"">"
						Response.Write "<div class=""text-right"" id=""lotDetayDIV_"&depoID&"""></div>"
					Response.Write "</td>"
				Response.Write "</tr>"


			rs.movenext
			next
		rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
	elseif rs.EOF then
		Response.Write "Stokta bu ürün bulunmuyor."
	end if






%><!--#include virtual="/reg/rs.asp" -->



	<script>
		function lotMiktarGetir(divID, stokID, depoID){
		
			working(divID,'40px','40px')
			$('#'+divID).load('/stok/lot_miktar_detay.asp',{stokID:stokID, depoID:depoID});
		}

	</script>





