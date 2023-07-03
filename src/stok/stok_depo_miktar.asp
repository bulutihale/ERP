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
sorgu = sorgu & " t1.stokKodu,"
sorgu = sorgu & " t1.stokAd,"
sorgu = sorgu & " stok.FN_stokSayGB2 ( " & firmaID & ", t1.stokID ) AS stokMiktarGB,"
sorgu = sorgu & " stok.FN_stokSayDepoLot ( " & firmaID & ", t1.stokID, t2.depoID, t2.lot ) AS lotMiktar,"
sorgu = sorgu & " t3.depoAd, t3.depoKategori, t2.depoID,"
sorgu = sorgu & " t2.lot,"
sorgu = sorgu & " t2.miktarBirim,"
sorgu = sorgu & " t6.cariAd,"
sorgu = sorgu & " t2.lotSKT AS lotSKT"
sorgu = sorgu & " FROM stok.stok t1"
sorgu = sorgu & " INNER JOIN stok.stokHareket t2 ON t1.stokID = t2.stokID"
sorgu = sorgu & " INNER JOIN stok.depo t3 ON t2.depoID = t3.id"
sorgu = sorgu & " LEFT JOIN teklif.siparisKalem t4 ON t2.siparisKalemID = t4.id"
sorgu = sorgu & " LEFT JOIN teklif.siparis t5 ON t4.siparisID = t5.sipID"
sorgu = sorgu & " LEFT JOIN cari.cari t6 ON t5.cariID = t6.cariID"
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
sorgu = sorgu & " t3.depoAd, t3.depoKategori,"
sorgu = sorgu & " t1.stokAd,"
sorgu = sorgu & " t2.lot,"
sorgu = sorgu & " t2.miktarBirim,"
sorgu = sorgu & " t4.siparisID,"
sorgu = sorgu & " t6.cariAd,"
sorgu = sorgu & " t2.lotSKT"
	rs.open sorgu, sbsv5, 1, 3
'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 AND not rs.EOF then
		Response.Write "<div class=""text-right""><span  data-dismiss=""modal"" class=""mdi mdi-close-circle pointer d-none""></span></div>"


		stokKodu		=	rs("stokKodu")
		stokAd			=	rs("stokAd")

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col h3 text-info bold"">" & stokKodu & "</div>"
			Response.Write "<div class=""col h3 text-info text-right bold"">" & stokAd & "</div>"
		Response.Write "</div>"

'############## depo girişi bekleyenler
	sorgu = "SELECT t1.stokKodu, t1.stokAd,"
	sorgu = sorgu & " t2.miktar,"
	sorgu = sorgu & " t3.depoAd, t2.lot, t2.miktarBirim, t2.lotSKT"
	sorgu = sorgu & " FROM stok.stok t1"
	sorgu = sorgu & " INNER JOIN stok.stokHareket t2 ON t1.stokID = t2.stokID"
	sorgu = sorgu & " INNER JOIN stok.depo t3 ON t2.depoID = t3.id"
	sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & gorevID & " AND t2.silindi = 0"
	sorgu = sorgu & " AND stokHareketTuru = 'GB'"
	rs1.open sorgu, sbsv5, 1, 3
	
	if rs1.recordcount > 0 then

		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm table-danger""><thead class=""thead-danger""><tr class=""text-center fontkucuk2"">"
		Response.Write "<th >LOT</th>"
		Response.Write "<th >LOT SKT</th>"
		Response.Write "<th  class=""text-center"">Lot Miktar</th>"
		Response.Write "<th >Depo Ad</th>"
		Response.Write "</tr></thead><tbody>"
	
		for zi = 1 to rs1.recordcount
			depoAd			=	rs1("depoAd")
			lot				=	rs1("lot")
			lotSKT			=	rs1("lotSKT")
			miktar			=	rs1("miktar")
			miktarBirim		=	rs1("miktarBirim")

					Response.Write "<tr>"
						Response.Write "<td>" & lot & "</td>"
						Response.Write "<td>" & lotSKT & "</td>"
						Response.Write "<td class=""text-right"">" & miktar & " " & miktarBirim & " </td>"
						Response.Write "<td>" & depoAd & "<span class=""fontkucuk2 text-success""> (giriş bekliyor)</span></td>"
					Response.Write "</tr>"
		rs1.movenext
		next
		Response.Write "</tbody>"
		Response.Write "</table>"
	end if
	rs1.close
'############## /depo girişi bekleyenler


Response.Write "<hr>"

		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark text-center""><tr>"
		Response.Write "<th >LOT</th>"
		Response.Write "<th >LOT SKT</th>"
		Response.Write "<th  class=""text-center"">Lot Miktar</th>"
		' Response.Write "<th >Depo Miktar</th>"
		Response.Write "<th >Depo Ad</th>"
		Response.Write "<th >Müşteri Ad</th>"
		Response.Write "<th >Sevk</th>"
		
		Response.Write "</tr></thead><tbody>"
				di = 0
				do until rs.EOF
					di = di + 1
					depoAd			=	rs("depoAd")
					depoID			=	rs("depoID")
					depoKategori	=	rs("depoKategori")
					lot				=	rs("lot")
					lotSKT			=	rs("lotSKT")
					lotMiktar		=	rs("lotMiktar")
					miktarBirim		=	rs("miktarBirim")
					cariAd			=	rs("cariAd")
					Response.Write "<tr>"
						Response.Write "<td>" & lot & "</td>"
						Response.Write "<td>" & lotSKT & "</td>"
						Response.Write "<td class=""text-right"">" & lotMiktar & " " & miktarBirim & " </td>"
						Response.Write "<td>" & depoAd & "</td>"
						Response.Write "<td>" & cariAd & "</td>"
						Response.Write "<td class=""text-center"">"
						if depoKategori = "satis" AND siparisKalemID <> "" then
							Response.Write "<div class=""row container text-center"">"
								Response.Write "<div class=""col-10"">"
									call forminput("sevkMiktar","","","","bold text-center","autocompleteOFF","sevkMiktar_" & di & "","")
								Response.Write "</div>"
								Response.Write "<div class=""col-2 "">"
									Response.Write "<div class=""text-center bg-success btn"" onclick=""$.post('/satis/sevk_miktar_kaydet.asp',{sevkMiktar:$('#sevkMiktar_" & di & "').val(),siparisKalemID:'"&siparisKalemID&"',depoID:"&depoID&",lot:'"&lot&"'},function(){$('#ortaalan').load('/satis/siparis_liste.asp');modalkapat()})""><i class=""icon bullet-go""></i></div>"
								Response.Write "</div>"
							Response.Write "</div>"
						else
							Response.Write "<div class=""pointer"" onclick=""swal('sadece satış kategorisindeki depolardan sevk yapılabilir.','','warning')""><i class=""icon exclamation""></i></div>"
						end if
						Response.Write "</td>"
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









