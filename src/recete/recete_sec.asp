<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    call sessiontest()
    kid		=	kidbul()

	modulAd 		=   "Planlama" 

	'##### YETKİ BUL
	'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
	'##### YETKİ BUL
	'##### YETKİ BUL

	siparisKalemID			=	Request.QueryString("siparisKalemID")
	yer						=	Request.QueryString("yer")
	isTur					=	Request.QueryString("isTur")
	stokID					=	Request.QueryString("stokID")
	cariID					=	Request.QueryString("cariID")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()

call logla("Üretim planlaması için reçete seçimi siparisKalemID: " & siparisKalemID & "")


		'################### REÇETE ID BUL, cariye özel reçete var mı?
		'################### REÇETE ID BUL, cariye özel reçete var mı?
            sorgu = "SELECT"
			sorgu = sorgu & " t1.receteID, t1.receteAd, t1.stokID as mamulStokID, t2.stokKodu, t2.stokAd, t3.cariID, t3.cariKodu, t3.cariAd,"
			sorgu = sorgu &" CASE WHEN t1.ozelRecete = 1 THEN 'Cariye özel reçete' ELSE 'Standart Reçete' END as ozelRecete"
			sorgu = sorgu & " FROM recete.recete t1"
			sorgu = sorgu & " LEFT JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " LEFT JOIN cari.cari t3 ON t1.cariID = t3.cariID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.silindi = 0" 
		'######## cari için özel reçete varsa al
			sorgu1 = sorgu & " AND t2.stokID = " & stokID & " AND t3.cariID = " & cariID & " ORDER BY t3.cariAd"
		'######## cari için özel reçete varsa al
			rs.open sorgu1, sbsv5, 1, 3
				if rs.recordcount = 0 then
					rs.close
					sorgu2 = sorgu & " AND t2.stokID = " & stokID & " ORDER BY t3.cariAd"
					rs.open sorgu2, sbsv5, 1, 3
					if rs.recordcount = 0 then
						'rs.close
					end if
				end if
				Response.Write "<div class=""col-12 text-right"" data-dismiss=""modal""><i class=""mdi mdi-close-circle pointer""></i></div>" 
		Response.Write "<div id=""recetelerDIV"" class=""card mt-3"">"
			Response.Write "<div class=""row"">"
			Response.Write "</div>"
		Response.Write "<div class=""card-header text-white bg-info"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-lg-3 col-sm-6 text-left"">Reçeteler</div>" 
			Response.Write "</div>"
		Response.Write "</div>"
			if rs.recordcount > 0 then
			Response.Write "<div class=""card-body"">"
				for di = 1 to rs.recordcount
					mamulStokID		=	rs("mamulStokID")
					receteID		=	rs("receteID")
					receteAd		=	rs("receteAd")
					stokKodu		=	rs("stokKodu")
					stokAd			=	rs("stokAd")
					cariAd			=	rs("cariAd")
					ozelRecete		=	rs("ozelRecete")
					Response.Write "<div class=""row mt-2 border-warning border-bottom"">"
						Response.Write "<div class=""col-lg-6 col-sm-4"">" & receteAd &  "</div>"
						Response.Write "<div class=""col-lg-5 col-sm-4""><span class=""fontkucuk2"">" & cariAd & "</span></div>"
						'Response.Write "<div class=""col-lg-1 col-sm-4 pointer text-center"" onclick=""receteSec(" & receteID & ");"">"
							'Response.Write "<div class=""badge badge-pill pointer badge-success""><i class=""mdi mdi-arrow-right-bold""></i></div>"
						'Response.Write "</div>"
Response.Write "<div class=""btn btn-sm btn-info border rounded"" onclick=""modalajaxfit('/ajanda/ajanda.asp?yer=modal&isTur=uretimPlan&siparisKalemID=" & siparisKalemID & "&receteID="&receteID&"')"">SEÇ</div>"
					Response.Write "</div>"
				rs.movenext
				next
			Response.Write "</div>"
			else
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col bold"">Ürüne ait reçete kaydı yok</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row mt-4"">"
					Response.Write "<div class=""col bold text-danger"">Reçete olmadan planlama yapılamaz.</div>"
				Response.Write "</div>"
			end if
		Response.Write "</div>"
			rs.close

		'################### /REÇETE ID BUL, cariye özel reçete var mı?
		'################### /REÇETE ID BUL, cariye özel reçete var mı?



%><!--#include virtual="/reg/rs.asp" -->






