<!--#include virtual="/reg/rs.asp" --><%


'###### FİLTRELER
'###### FİLTRELER
		
	cariID			=	Request.Form("cariID")
	stokID			=	Request.Form("stokID")
	t1				=	Request.Form("t1")
	t2				=	Request.Form("t2")
	t3				=	Request.Form("t3")
	t4				=	Request.Form("t4")
	siparisNo		=	Request.Form("siparisNo")
	listeTur		=	session("sayfa5")
	if listeTur = "" then
		listeTur	=	Request.Form("listeTur")
	end if

	if listeTur = "uretimPlan" then
		sayfaBaslik	=	"Üretim Listesi"
		sayfaLink	=	"<div class=""col-4""><span class=""bg-info rounded""><a href=""/uretim/uretilenListe/uretimPlan"">Üretim Listesi</a></span></div>"
	elseif listeTur = "kesimPlan" then
		sayfaBaslik	=	"Kesim İşleri Listesi"
		sayfaLink	=	"<div class=""col-4""><span class=""bg-info rounded""><a href=""/uretim/uretilenListe/kesimPlan"">Kesim Listesi</a></span></div>"
		sayfaLink	=	sayfaLink & "<div class=""col-8 text-right""><button class=""btn btn-info rounded"" onclick=""modalajaxfit('/uretim/manuel_isemri_base.asp?listeTur="&listeTur&"&stokID="&stokID&"')"">Yeni Kesim İşi</button></div>"
	elseif listeTur = "transfer" then
		sayfaBaslik	=	"Depolararası transfer edilecek ürünler listesi"
		sayfaLink	=	"<div class=""col-4""><span class=""bg-info rounded""><a href=""/uretim/uretilenListe/transfer"">Transfer Listesi</a></span></div>"
	end if
    modulAd 		=   "Üretim"
	
	'####### varsayılan tarih sınırları
		if t1 = "" then t1 = date() - 60 end if
		if t2 = "" then t2 = date() end if
		t2 = t2+1
	'####### /varsayılan tarih sınırları
	

'###### FİLTRELER
'###### FİLTRELER

	yetkiKontrol	 = yetkibul(modulAd)

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU

call logla("Üretim İşleri Listelendi")

Response.Write "<div class=""card rounded-top"">"
Response.Write "<div class=""card-header h5"">"
Response.Write "<div class=""row"">"
	Response.Write sayfaLink
Response.Write "</div>"
Response.Write "</div>"

Response.Write "<div class=""card-body"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-1 pointer"" onclick=""modalajax('/uretim/filtre.asp?listeTur="&listeTur&"')""><i class=""mdi mdi-filter table-success rounded""></i></div>"
			Response.Write "<div class=""col-6 h4"">" & sayfaBaslik & "</div>"
		Response.Write "</div>"
		Response.Write "<div id=""listeTablo"" class=""table-responsive mt-3"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr class=""text-center"">"
		Response.Write "<th class=""col-1"" >Sipariş Tarih</th>"
		Response.Write "<th class=""col-3"" >Sipariş Cari</th>"
		Response.Write "<th class=""col-1"" >Üretim Başlangıcı</th>"
		Response.Write "<th class=""col-1"" >Üretim Bitişi</th>"
		Response.Write "<th class=""col-3"" >Ürün Adı</th>"
		Response.Write "<th class=""col-1"">Miktar</th>"
		Response.Write "<th class=""col-1"" ></th>"
		Response.Write "</tr></thead><tbody>"

		
            sorgu = "SELECT"
			sorgu = sorgu & " DATEFROMPARTS(t1.hangiYil, t1.hangiAy, t1.hangiGun) as planTarih, t1.baslangicZaman, t1.bitisZaman, t2.stokID, t2.stokKodu, t2.stokAd, "
			sorgu = sorgu & " t1.id as ajandaID, t1.tamamlandi, t1.receteAdimID, t1.manuelPlan,"
			sorgu = sorgu & " ISNULL([stok].[FN_siparisMiktarBul] (t1.id , "&firmaID&"),t1.miktar) as sipMiktar,"
			sorgu = sorgu & " ISNULL([stok].[FN_receteMiktarBul] (t1.id),1) as bilesenMiktar,"
			sorgu = sorgu & " [stok].[FN_anaBirimADBul] ( t2.stokID, 'kAd') as miktarBirim,"
			sorgu = sorgu & " ISNULL(portal.FN_sipariscariAdbul("&firmaID&", t1.id),N'<span class=""font-italic bold text-info"">Manuel İstem</span>') as siparisCariAd,"
			sorgu = sorgu & " t1.icerik, t1.tarih"
			sorgu = sorgu & " FROM portal.ajanda t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			'sorgu = sorgu & " LEFT JOIN recete.recete t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID
			sorgu = sorgu & " AND t1.isTur = '" & listeTur & "'" 
			if stokID <> "" then
				sorgu = sorgu & " AND t2.stokID = " & stokID & ""
			end if
			if t3 <> "" then
				sorgu = sorgu & " AND t1.baslangicZaman >= '" & tarihsql(t3) &"'"	
			end if
			if t4 <> "" then
				sorgu = sorgu & " AND t1.baslangicZaman <= '" & tarihsql(t4) &"'"	
			end if
			'sorgu = sorgu & " AND (t1.bitisZaman is null OR (CONVERT(varchar,t1.bitisZaman,103) >= '" & tarihsql(t1) &"' AND CONVERT(varchar, t1.bitisZaman, 103) <= '" & tarihsql(t2) &"'))"
			sorgu = sorgu & " AND (t1.bitisZaman is null OR (t1.bitisZaman >= '" & tarihsql(t1) &"' AND t1.bitisZaman <= '" & tarihsql(t2) &"'))"
			sorgu = sorgu & " AND t1.silindi = 0"
			sorgu = sorgu & " ORDER BY DATEFROMPARTS(t1.hangiYil, t1.hangiAy, t1.hangiGun) DESC"
			rs.open sorgu, sbsv5, 1, 3

			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					dbKayitTarih		=	rs("tarih")
					manuelPlan			=	rs("manuelPlan")
					if manuelPlan = True then
						manuelPlan = "evet"
					else
						manuelPlan = "hayir"
					end if
					stokID				=	rs("stokID")
					stokID64	 		=	stokID
					stokID64			=	base64_encode_tr(stokID64)
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					icerik				=	rs("icerik")
					sipMiktar			=	rs("sipMiktar")
					bilesenMiktar		=	rs("bilesenMiktar")
					bilesenToplamMiktar	=	bilesenMiktar * sipMiktar
					miktarBirim			=	rs("miktarBirim")
					siparisCariAd		=	rs("siparisCariAd")
					planTarih			=	tarihtr(rs("planTarih"))
					baslangicZaman		=	rs("baslangicZaman")
					bitisZaman			=	rs("bitisZaman")
					tamamlandi			=	rs("tamamlandi")
					if tamamlandi = 1 then
						trClass= " table-success "
					else
						trClass = ""
					end if
					ajandaID			=	rs("ajandaID")
					ajandaID64			=	ajandaID
					ajandaID64			=	base64_encode_tr(ajandaID64)
					receteAdimID		=	rs("receteAdimID")
					receteAdimID64		=	receteAdimID
					receteAdimID64		=	base64_encode_tr(receteAdimID64)



					Response.Write "<tr id=""tr_"&ajandaID&""" class="""&trClass&""">"
						Response.Write "<td class=""text-center pointer"" data-toggle=""popoverModal"" title=""veritabanı kayıt tarihi: "&dbKayitTarih&""">" & planTarih & "</td>"
						Response.Write "<td class=""text-left"">" & siparisCariAd & "</td>"
						Response.Write "<td class=""text-center"">" & baslangicZaman & "</td>"
						Response.Write "<td class=""text-center"">" & bitisZaman & "</td>"
						Response.Write "<td>"
							Response.Write "<div class="""">" & stokKodu & " - " & stokAd & "</div>"
							Response.Write "<div class=""mt-2 ml-3 font-italic fontkucuk2"">" & icerik & "</div>"
						Response.Write "</td>"
						Response.Write "<td class=""text-right"">" & bilesenToplamMiktar & " " & miktarBirim &"</td>"
						Response.Write "<td class=""text-center"">"
						'Response.Write "<div class=""container-flex"">"
							Response.Write "<div class=""row container"">"
							Response.Write "<div class=""col-4"">"
								Response.Write "<div title=""Depolara göre stok sayıları"" class=""badge badge-pill badge-warning pointer mr-2"""
									Response.Write " onClick=""modalajax('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "');"">"
									Response.Write "<i class=""mdi mdi-numeric-9-plus-box-multiple-outline""></i>"
								Response.Write "</div>"
							Response.Write "</div>"


							Response.Write "<div class=""col-4"">"
								'if listeTur = "transfer" then
									Response.Write "<div title=""İhtiyaç analizi"" class=""badge badge-pill badge-secondary pointer mr-2"""
										Response.Write " onClick=""modalajaxfit('/uretim/ihtiyac_analiz.asp?gorevID=" & stokID64 & "&listeTur="&listeTur&"');"">"
										Response.Write "<i class=""fa fa-book""></i>"
									Response.Write "</div>"
								'end if
							Response.Write "</div>"

							Response.Write "<div class=""col-4"">"
									Response.Write "<div class=""badge badge-pill badge-success pointer mr-2"""
										if listeTur = "transfer" then
											if tamamlandi = 0 then
												Response.Write " onclick=""modalajax('/depo/depo_transfer.asp?listeTur="&listeTur&"&receteAdimID="&receteAdimID64&"&ajandaID=" & ajandaID64 & "&stokID=" & stokID64 & "')"""
											else
												Response.Write " onclick=""swal('','Transfer işlemi yapılmış.')"""
											end if
										else
											Response.Write " onclick=""window.location.href = '/uretim/uretim/"&listeTur&"++"&ajandaID64&"++"&manuelPlan&"'"" class=""badge badge-pill badge-success pointer mr-2"""
										end if
									Response.Write "><i class=""mdi mdi-arrow-right-bold""></i>"
									Response.Write "</div>"
							Response.Write "</div>"
								'Response.Write "</div>"
							Response.Write "</div>"
						'Response.Write "</div>"
						Response.Write "</td>"
					Response.Write "</tr>"

					Response.Flush()
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"
	Response.Write "</div>"'card-body
	Response.Write "</div>"'card
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU







%>












