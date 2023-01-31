<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
	gelenVeriHam	=	Session("sayfa5")
	gelenVeri		=	split(gelenVeriHam,"++")
	isTur			=	gelenVeri(0)
	gorevID64		=	gelenVeri(1)
	gorevID			=	gorevID64
	gorevID			=	base64_decode_tr(gorevID)
	ajandaID		=	gorevID
	ajandaID64		=	gorevID64
	secilenDepoID	=	Request.QueryString("secilenDepoID")
	surecDepoID		=	Request.QueryString("surecDepoID")
	if secilenDepoID = "" or isnull(secilenDepoID) then
		secilenDepoID = 0
	end if
	if surecDepoID = "" or isnull(surecDepoID) then
		surecDepoID = 0
	end if
	secilenReceteID	=	Request.QueryString("secilenReceteID")
	if secilenReceteID = "" then
		secilenReceteID = 0
	end if
	modulAd =   "Üretim"
	if isTur = "uretimPlan" then
		sayfaBaslik	=	"Üretim Süreç Kontrolü"
		class1		=	" bg-info "
	elseif isTur = "kesimPlan" then
		sayfaBaslik	=	"Kesimhane Süreç Kontrolü"
		class1		=	" bg-warning "
	end if
	
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Üretim Kontrolü Ekranı")


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then


		Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-header text-white"&class1&""">"
				Response.Write "<span class=""h4 text-dark"">" &sayfaBaslik & "</span>"
				Response.Write "<span id=""receteBtn"" onclick=""$('#recetelerDIV').show('slow')"" class=""d-none ml-4 text-warning pointer mdi mdi-receipt"" title=""Reçeteleri göster""></span>"
			Response.Write "</div>"
			
			Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-lg-6 col-md-12 col-sm-12"">"

						if isTur = "uretimPlan" then


							sorgu = "SELECT t4.cariID, t3.stokID, t4.cariAd, t3.stokKodu, t3.stokAd, t1.miktar, t1.mikBirim, t5.siparisKalemID, t5.tamamlandi, t5.baslangicZaman,"
							sorgu = sorgu & " t5.bitisZaman, t5.depoKategori"
							sorgu = sorgu & " FROM portal.ajanda t5"
							sorgu = sorgu & " INNER JOIN teklif.siparisKalem t1 ON t1.id = t5.siparisKalemID"
							sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
							sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
							sorgu = sorgu & " INNER JOIN cari.cari t4 ON t2.cariID = t4.cariID"
							sorgu = sorgu & " WHERE t5.id = " & gorevID
							rs.Open sorgu, sbsv5, 1, 3
								cariID				=	rs("cariID")
								cariAd				=	rs("cariAd")
								stokID				=	rs("stokID")
								stokKodu			=	rs("stokKodu")
								stokAd				=	rs("stokAd")
								sipMiktar			=	rs("miktar")
								uretilenMiktar		=	sipMiktar
								mikBirim			=	rs("mikBirim")
								siparisKalemID		=	rs("siparisKalemID")
								tamamlandi			=	rs("tamamlandi")
								baslangicZaman		=	rs("baslangicZaman")
								bitisZaman			=	rs("bitisZaman")
								teminDepoKategori	=	rs("depoKategori")
								receteMiktar 		= 	1 'uretimPlan işinde alt reçete miktarına ihtiyaç olmadığı için 1 tanımlandı, kesimPlan işinde lazım.
							rs.close
							urtBtnYaz		=	"ÜRETİME BAŞLA"
							urtBtnClass		=	" bg-success "
							Response.Write "<div class=""row"">"
								Response.Write "<div class=""col-lg-3 col-sm-3 bold"">Sipariş Veren</div>"
								Response.Write "<div class=""col-lg-9 col-sm-9"">" & cariAd & "</div>"
							Response.Write "</div>"
							Response.Write "<div class=""row mt-2"">"
								Response.Write "<div class=""col-lg-3 col-sm-3 bold"">Miktar</div>"
								Response.Write "<div class=""col-lg-9 col-sm-9"">" & sipMiktar & " " & mikBirim & "</div>"
							Response.Write "</div>"

						elseif isTur = "kesimPlan" then


							sorgu = "SELECT t2.stokID, t3.stokKodu, t3.stokAd, t4.icerik, t1.miktar as receteMiktar, portal.siparisKalemIDbul("&firmaID&", t4.id) as siparisKalemID,"
							sorgu = sorgu & " (SELECT miktar FROM teklif.siparisKalem"
								sorgu = sorgu & " WHERE id = (SELECT siparisKalemID FROM portal.ajanda WHERE id = t4.bagliAjandaID)) as siparisMiktar, t4.tamamlandi, t4.baslangicZaman,"
							sorgu = sorgu & " t4.bitisZaman, t4.depoKategori"
							sorgu = sorgu & " FROM portal.ajanda t4"
							sorgu = sorgu & " INNER JOIN recete.receteAdim t1 ON t4.receteAdimID = t1.receteAdimID"
							sorgu = sorgu & " INNER JOIN recete.recete t2 ON t1.altReceteID = t2.receteID"
							sorgu = sorgu & " INNER JOIN stok.stok t3 ON t2.stokID = t3.stokID"
							sorgu = sorgu & " WHERE t4.id = " & gorevID
							rs.Open sorgu, sbsv5, 1, 3
								icerik				=	rs("icerik")
								stokID				=	rs("stokID")
								stokKodu			=	rs("stokKodu")
								stokAd				=	rs("stokAd")
								sipMiktar			=	rs("siparisMiktar")
								receteMiktar		=	rs("receteMiktar")
								uretilenMiktar		=	receteMiktar * sipMiktar
								siparisKalemID		=	rs("siparisKalemID")
								tamamlandi			=	rs("tamamlandi")
								baslangicZaman		=	rs("baslangicZaman")
								bitisZaman			=	rs("bitisZaman")
								teminDepoKategori	=	rs("depoKategori")
								cariID				=	0
							rs.close
							urtBtnYaz	=	"KESİME BAŞLA"
							urtBtnClass	=	" bg-warning "
						Response.Write "<div class=""row mt-2"">"
							'Response.Write "<div class=""col-lg-2 col-sm-3 bold"">Stok Kodu</div>"
							Response.Write "<div class=""col-lg-12 col-sm-9"">" & icerik & "</div>"
						Response.Write "</div>"
						end if

						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-3 col-sm-3 bold"">Stok Kodu</div>"
							Response.Write "<div class=""col-lg-9 col-sm-9"">" & stokKodu & "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-3 col-sm-3 bold"">Ürün</div>"
							Response.Write "<div class=""col-lg-9 col-sm-9"">" & stokAd & "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-3 col-sm-3 bold"">Temin Depo</div>"
							Response.Write "<div class=""col-9"">"
								call formselectv2("teminDepoID","","receteSec();","","formSelect2 depoSec border","","teminDepoID","","data-holderyazi=""Yarı mamul temini yapılacak depo seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-sart=""('"&teminDepoKategori&"')""")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-3 col-sm-3 bold"">Başlayacak Olan Süreç</div>"
							Response.Write "<div class=""col-9"">"
								call formselectv2("surecDepoID","","receteSec();","","formSelect2 depoSec border","","surecDepoID","","data-holderyazi=""Başlayacak olan süreç seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-sartOzel=""t1.depoTuru =2""")
							Response.Write "</div>"
						Response.Write "</div>"
						if isTur = "kesimPlan" then
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-3 col-sm-3 bold"">Teçhizat</div>"
							Response.Write "<div class=""col-9"">"
								call formselectv2("techizatSec","","","","formSelect2 techizatSec border","","techizatID","","data-holderyazi=""İşlem yapılacak teçhizat seçimi"" data-jsondosya=""JSON_techizat"" data-miniput=""0"" data-sart=""('"&teminDepoKategori&"')""")
							Response.Write "</div>"
						Response.Write "</div>"
						end if
					Response.Write "</div>"

			'#### üretim son ürün etiketi vs.
			'#### üretim son ürün etiketi vs.
					Response.Write "<div id=""linklerDIV"" class=""col-lg-2 col-md-4 col-sm-4 border"">"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""p-1 col-12"">"
								if secilenReceteID > 0 AND isTur = "uretimPlan" then
									Response.Write "<a"
									if not isnull(baslangicZaman) then
										Response.Write " target=""_blank"" href=""/uretim/etiketSonUrun.asp?receteID=" & secilenReceteID & """"
									else
										Response.Write " onclick=""swal('','Üretim başlamadan ürüne ait LOT belirlenmez ve son ürün etiketi oluşturulamaz.','error')"""
									end if
								Response.Write "href=""#""><i class=""mdi mdi-label-outline""></i>Son Ürün Etiketi</a>"
								end if
							Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</div>"
			'#### /üretim son ürün etiketi vs.
			'#### /üretim son ürün etiketi vs.

			'#### üretim veya kesim BAŞLAT BUTONU
			'#### üretim veya kesim BAŞLAT BUTONU
					Response.Write "<div class=""col-lg-2 col-md-4 col-sm-4"">"
						Response.Write "<div id=""btnDIV"" class=""row h-100 d-none"">"
							if not isnull(baslangicZaman) then
								Response.Write "<div class=""h3 bold text-center text-danger mt-5 col-lg-12 col-md-12 col-sm-12"">İşlem Başlangıcı:<br> " & baslangicZaman & "</div>"
							elseif tamamlandi = 0 AND isnull(baslangicZaman) then
								Response.Write "<button"
								Response.Write " class=""shadow h-100 border-0 rounded " & urtBtnClass & " col-lg-12 col-sm-6 bold"""
									if yetkiKontrol > 6 then
										Response.Write " onclick=""uretimBasla(" & siparisKalemID & "," & ajandaID & ",'islemBasla')"""
									else
										Response.Write " onclick=""swal('YETKİ YOK','Üretim başlatmak için yetkiniz yeterli değil!')"""
									end if
								Response.Write ">" & urtBtnYaz & "</button>"
							end if
						Response.Write "</div>"
					Response.Write "</div>"
			'#### /üretim veya kesim BAŞLAT BUTONU
			'#### /üretim veya kesim BAŞLAT BUTONU

			'#### üretim veya kesim BİTİR BUTONU
			'#### üretim veya kesim BİTİR BUTONU
					Response.Write "<div class=""col-lg-2 col-md-4 col-sm-4"">"
						Response.Write "<div id=""btnDIV2"" class=""row h-100 d-none"">"

							if not isnull(bitisZaman) then
								Response.Write "<div class=""h3 bold text-center text-danger mt-5 col-lg-12 col-sm-12"">İşlem Sonu:<br> " & bitisZaman & "</div>"
							elseif tamamlandi = 0 AND isnull(bitisZaman) AND not isnull(baslangicZaman) then
								Response.Write "<button"
								Response.Write " class=""shadow h-100 border-0 rounded " & urtBtnClass & " col-lg-12 col-md-12 col-sm-12 bold"""
								if yetkiKontrol > 6 then
									if isTur = "kesimPlan" then
										Response.Write " onclick=""uretimBasla(" & siparisKalemID & "," & ajandaID & ",'islemBitir'," & uretilenMiktar & ")"""
									elseif isTur = "uretimPlan" then
										Response.Write " onclick=""alert();"""
									end if
								else
									Response.Write " onclick=""swal('YETKİ YOK','Üretim başlatmak için yetkiniz yeterli değil!')"""
								end if
									Response.Write ">BİTİR</button>"
							end if
						Response.Write "</div>"
					Response.Write "</div>"
			'#### /üretim veya kesim BİTİR BUTONU
			'#### /üretim veya kesim BİTİR BUTONU
				Response.Write "</div>"
			Response.Write "</div>"




		Response.Write "</div>"

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
			sorgu1 = sorgu & " AND t2.stokID = " & stokID & " AND t3.cariID = " & cariID & ""
		'######## cari için özel reçete varsa al
			rs.open sorgu1, sbsv5, 1, 3
				if rs.recordcount = 0 then
					rs.close
					sorgu2 = sorgu & " AND t2.stokID = " & stokID & ""
					rs.open sorgu2, sbsv5, 1, 3
					if rs.recordcount = 0 then
						'rs.close
					end if
				end if
		Response.Write "<div id=""recetelerDIV"" class=""card mt-3"">"
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
					ozelRecete		=	rs("ozelRecete")
					Response.Write "<div class=""row mt-2"">"
						Response.Write "<div class=""col-lg-2 col-sm-4"">" & receteAd &  "</div>"
						Response.Write "<div class=""col-lg-2 col-sm-4"">" & ozelRecete &  "</div>"
						Response.Write "<div class=""col-lg-1 col-sm-4 pointer text-center"" onclick=""receteSec(" & receteID & ");"">"
							Response.Write "<div class=""badge badge-pill pointer badge-success""><i class=""mdi mdi-arrow-right-bold""></i></div>"
						Response.Write "</div>"
					Response.Write "</div>"
				rs.movenext
				next
			Response.Write "</div>"
			else
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col bold"">Ürüne ait reçete kaydı yok</div>"
				Response.Write "</div>"
			end if
		Response.Write "</div>"
			rs.close

		'################### /REÇETE ID BUL, cariye özel reçete var mı?
		'################### /REÇETE ID BUL, cariye özel reçete var mı?
	Response.Write "<div id=""receteAdim"" class=""text-center"">"
	
	call formhidden("receteID",secilenReceteID,"","","","","receteID","")
	
	if secilenReceteID > 0 then

		'################### REÇETE ADIM BİLGİLERİ
		'################### REÇETE ADIM BİLGİLERİ
					Response.Write "<div class=""card mt-3"">"
						Response.Write "<div class=""card-header text-white bg-info"">"
							Response.Write "<div class=""row"">"
								Response.Write "<div class=""col-lg-3 col-sm-6 text-left"">Reçete Adımları</div>"
							Response.Write "</div>"
						Response.Write "</div>"
						
						'Response.Write "<div class=""card-body""><div class=""row"">"
					sorgu = ""
					sorgu = sorgu & " SELECT stok.FN_stokSayDepo(" & firmaID & ",  t1.stokID, " & secilenDepoID & ") as hazirMiktar,"
					sorgu = sorgu & " stok.FN_stokSayGB(" & firmaID & ",  t1.stokID, " & secilenDepoID & ") as GBmiktar,"
					sorgu = sorgu & " t1.receteAdimID, t1.islemAciklama,"
					sorgu = sorgu & " t2.ad,"
					sorgu = sorgu & " t1.stokID,"
					sorgu = sorgu & " t3.stokAd,"
					sorgu = sorgu & " t3.stokKodu,"
					sorgu = sorgu & " t1.isGucuSayi,"
					sorgu = sorgu & " t1.miktar,"
					sorgu = sorgu & " t1.miktarBirim,"
					sorgu = sorgu & " t1.sira,"
					sorgu = sorgu & " t1.altReceteID,"
					sorgu = sorgu & " t4.receteAd,"
					sorgu = sorgu & " t1.stokKontroluYap"
					sorgu = sorgu & " FROM recete.receteAdim t1"
					sorgu = sorgu & " INNER JOIN recete.receteIslemTipi t2 ON t2.receteIslemTipiID =  t1.receteIslemTipiID"
					sorgu = sorgu & " LEFT JOIN stok.stok t3 ON  t3.stokID =  t1.stokID"
					sorgu = sorgu & " LEFT JOIN recete.recete t4 ON  t4.receteID =  t1.altReceteID"
					sorgu = sorgu & " WHERE t1.receteID = " & secilenReceteID
					sorgu = sorgu & " AND t1.silindi = 0"
					sorgu = sorgu & " ORDER BY t1.sira ASC"					
					rs.open sorgu, sbsv5, 1, 3


					if rs.recordcount = 0 then
						Response.Write "Reçete Adımları Bulunamadı"
					else
						Response.Write "<div class="" mt-3"">"
						Response.Write "<table class=""table table-sm table-striped table-bordered table-hover""><thead class=""thead-dark""><tr class=""text-center"">"
							Response.Write "<th class=""col-1"" scope=""col"">İşlem Tipi</th>"
							Response.Write "<th class=""col-4"" scope=""col"">Stok Adı</th>"
							Response.Write "<th class=""col-1"" scope=""col"">Birim Miktar</th>"
							Response.Write "<th class=""col-1"" scope=""col"">İhtiyaç Miktar</th>"
							Response.Write "<th class=""col-2"" scope=""col"">Temin Depo Miktar</th>"
							Response.Write "<th class=""col-1"" scope=""col"">İşgücü Sayı</th>"
							Response.Write "<th class=""col-2"" scope=""col"">LOT Seçimi</th>"
						Response.Write "</tr></thead><tbody>"
							for i = 1 to rs.recordcount
								stokID			=	rs("stokID")
								stokID64		=	stokID
								stokID64		=	base64_encode_tr(stokID64)
								miktar			=	rs("miktar")
								miktarBirim		=	rs("miktarBirim")
								GBmiktar		=	rs("GBmiktar")
								stokAd			=	rs("stokAd")
								stokKodu		=	rs("stokKodu")
								hazirMiktar		=	rs("hazirMiktar")
								islemAciklama	=	rs("islemAciklama")
								receteAdimID	=	rs("receteAdimID")
								receteAdimID64	=	receteAdimID
								receteAdimID64	=	base64_encode_tr(receteAdimID64)
							if not isnull(stokID) then

								ihtiyacMiktar	=	cdbl(miktar) * cdbl(sipMiktar) * cdbl(receteMiktar)
								trClass 		=	" bg-warning "
								GBmiktarYaz		=	""
								If secilenDepoID > 0 Then
									hazirMiktarYaz		=	"<div class=""text-dark bold"" title=""Hazır miktar"">Hazır: " & hazirMiktar & " " & miktarBirim & "</div>"
									if GBmiktar > 0 then
										GBmiktarYaz		=	"<div class=""text-dark bg-light rounded mt-2 bold pointer"" onclick=""window.location.href = '/depo/bekleyen_liste/uretim'"" title=""Giriş bekleyen miktar"">Bekleyen: " & GBmiktar & "</div>"
									end if
								Else
									hazirMiktarYaz		=	"depo seçilmedi" 
								End if
							else
								GBmiktarYaz		=	""
								ihtiyacMiktar	=	""
								trClass 		=	""
								hazirMiktarYaz		=	"-"
							end if

								Response.Write "<tr class=""" & trClass & """>"
									Response.Write "<td class=""text-left"">" & rs("ad") & "</td>"
									Response.Write "<td class=""text-left"">"
										Response.Write "<div>" & stokKodu & " - " & stokAd & "</div>"
										Response.Write "<div class=""fonkucuk2 font-italic text-info pl-3"">" & islemAciklama & "</div>"
									Response.Write "</td>"
									Response.Write "<td class=""text-right"">" & miktar & " " & miktarBirim & "</td>"
									Response.Write "<td class=""text-right"">" & ihtiyacMiktar & " " & miktarBirim & "</td>"
									Response.Write "<td class=""text-right"">"
										Response.Write "<div class=""row"">"
										Response.Write "<div class=""col-4 text-left"" onclick=""modalajax('/depo/depo_transfer.asp?listeTur="&isTur&"&receteAdimID="&receteAdimID64&"&ajandaID=" & ajandaID64 & "&stokID=" & stokID64 & "&secilenDepoID="&secilenDepoID&"&surecDepoID="&surecDepoID&"')"">"
											Response.Write "<span class=""pointer bold btn btn-sm btn-info p-0 m-0"" title=""ürün talebi oluşturmak için tıklayınız."">talep</span>"
										Response.Write "</div>"
										Response.Write "<div class=""col-8"">"
										Response.Write hazirMiktarYaz & GBmiktarYaz
										Response.Write "</div>"
										Response.Write "</div>"
									Response.Write "</td>"
									Response.Write "<td class=""text-right"">" & rs("isGucuSayi") & "</td>"
									Response.Write "<td class=""text-center"">"
									if not isnull(stokID) then
										sorgu = "SELECT t1.stokHareketID, t1.lot, t1.miktar, t1.miktarBirim, t1.stokHareketTipi"
										sorgu = sorgu & " FROM stok.stokHareket t1"
										sorgu = sorgu & " INNER JOIN stok.depo t2 ON t1.depoID = t2.id"
										sorgu = sorgu & " WHERE t1.siparisKalemID = " & siparisKalemID & ""
										sorgu = sorgu & " AND t1.ajandaID = " & ajandaID & ""
										sorgu = sorgu & " AND t1.stokID = " & stokID & ""
										sorgu = sorgu & " AND t1.stokHareketTuru = 'G' AND stokHareketTipi IN ('T','U') AND t1.silindi = 0 AND t2.surecSonuDepoID = " & secilenDepoID
										rs1.open sorgu, sbsv5, 1, 3

										toplamLotMiktar	=	0

										if rs1.recordcount > 0 then


											for ti = 1 to rs1.recordcount
												stokHareketID		=	rs1("stokHareketID")
												lot					=	rs1("lot")
												miktar				=	rs1("miktar")
												miktarBirim			=	rs1("miktarBirim")
												stokHAreketTipi		=	rs1("stokHAreketTipi")
												toplamLotMiktar		=	toplamLotMiktar + miktar
												Response.Write "<div class=""row"">"
													Response.Write "<div class=""col-lg-1 col-md-1 col-sm-1"""
													if stokHareketTipi = "T" then
														Response.Write " onclick=""lotSil("&stokHareketID&","&secilenDepoID&","&secilenReceteID&","&surecDepoID&")"""
														cl1 = " text-danger "
													elseif stokHareketTipi = "U" then
														Response.Write " onclick=""swal('','Üretim başlatılmış, LOT girişleri silinemez.');"""
														cl1 = " text-secondary "
													end if
													Response.Write ">"
														Response.Write "<i class=""mdi mdi-minus-circle " & cl1 & " pointer""></i>"
													Response.Write "</div>"
													Response.Write "<div class=""col-lg-10 col-md-10 col-sm-10 text-left"">"
														Response.Write lot & " - " & miktar & " " & miktarBirim
													Response.Write "</div>"
												Response.Write "</div>" 
											rs1.movenext
											next
										end if
										rs1.close
										Response.Write "<span class=""pointer"""
										if cdbl(toplamLotMiktar) >= cdbl(ihtiyacMiktar) then
											Response.Write " onclick=""swal('Yeterli seçim yapıldı.','')"""
											btnRenk			=	" btn-secondary "
											miktarKontrol	=	1
										elseif not isnull(baslangicZaman) then
											Response.Write " onclick=""swal('','Üretim başlatılmış, LOT eklenemez.')"""
											btnRenk	=	" btn-secondary "
											miktarKontrol	=	0
										else
											Response.Write " onclick=""modalajaxfit('/uretim/uretimLotSec.asp?ihtiyacMiktar="&ihtiyacMiktar&"&isTur="&isTur&"&gorevID="&gorevID64&"&stokID="&stokID&"&secilenReceteID="&secilenReceteID&"&secilenDepoID="&secilenDepoID&"&surecDepoID="&surecDepoID&"');"""
											btnRenk	=	" btn-success "
											miktarKontrol	=	0
										end if
										Response.Write ">"
											Response.Write "<div class=""btn btn-sm btn-pill "&btnRenk&" miktarKontrol"" data-miktarkontrol=""" & miktarKontrol & """>LOT Seç</div>"
										Response.Write "</span>"
									end if
									Response.Write "</td>" 
								Response.Write "</tr>"
							rs.movenext
							next
						Response.Write "</tbody>"
						Response.Write "</table>"
						'Response.Write "</div>"
					end if
					rs.close
			Response.Write "</div></div></div>"
		'################### REÇETE ADIM BİLGİLERİ
		'################### REÇETE ADIM BİLGİLERİ
	end if
	Response.Write "</div>"


	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

<script>
	function receteSec(receteID) {

		if(receteID == undefined){var receteID = $('#receteID').val();};
		teminDepoID	=	$('#teminDepoID').val();
		surecDepoID	=	$('#surecDepoID').val();

		if(teminDepoID == null){var teminDepoID = 0};
		if(surecDepoID == null){var surecDepoID = 0};

			working('receteAdim',80,80);
			if(receteID > 0){
				$('#recetelerDIV').hide('slow');
			}
			if(teminDepoID == 0 && receteID == undefined){
				swal('','Temin Depo ve Reçete Seçimi Yapınız.')
					}
			else if(teminDepoID == 0){swal('','Temin Depo Seçimi Yapınız.')
					}
			else if(receteID == 0){swal('','Reçete Seçimi Yapınız.')
					}
			else{
				$('#btnDIV, #btnDIV2').removeClass('d-none');
				}
				
				
			$('#receteBtn').removeClass('d-none');
			$('#receteAdim').load('/uretim/uretim.asp?secilenReceteID='+receteID+'&secilenDepoID='+teminDepoID+'&surecDepoID='+surecDepoID+' #receteAdim > *')	
			$('#linklerDIV').load('/uretim/uretim.asp?secilenReceteID='+receteID+'&secilenDepoID='+teminDepoID+'&surecDepoID='+surecDepoID+' #linklerDIV > *')	
	}

	function uretimBasla(siparisKalemID, ajandaID, islemDurum, uretilenMiktar){
		gi = 0
		$('.miktarKontrol').each(function(){
			var kontrolDeger = $(this).attr('data-miktarkontrol')
			
			if(kontrolDeger == 0){gi = ++gi};
		});

		if(gi > 0){
			swal('','Miktarı yetersiz reçete bileşeni var, eksik miktar tamamlanmadan üretim başlatılamaz');
			return false;
			}

		teminDepoID		=	$('#teminDepoID').val();
		secilenReceteID	=	$('#receteID').val();
		if(islemDurum == 'islemBasla')
			{var baslik = 'İşlem başlatılsın mı?'}
		else
			{var baslik = 'İşlem bitirilsin mi?'};

	//	alert(secilenReceteID)
		swal({
			title: baslik,
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'evet',
			cancelButtonText: 'hayır'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			
				$('#ajax').load('/uretim/uretimBaslat.asp', {ajandaID:ajandaID, siparisKalemID:siparisKalemID, islemDurum:islemDurum, uretilenMiktar:uretilenMiktar,teminDepoID:teminDepoID});
				$('#receteAdim').load('/uretim/uretim.asp?secilenReceteID='+secilenReceteID+'&secilenDepoID='+teminDepoID+' #receteAdim > *');
				$('#btnDIV').load('/uretim/uretim.asp?secilenReceteID='+secilenReceteID+'&secilenDepoID='+teminDepoID+' #btnDIV > *');
				$('#btnDIV2').load('/uretim/uretim.asp?secilenReceteID='+secilenReceteID+'&secilenDepoID='+teminDepoID+' #btnDIV2 > *');
				$('#btnDIV').removeClass('d-none');
				$('#btnDIV2').removeClass('d-none');
			}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}



	function lotSil(stokHareketID,secilenDepoID,secilenReceteID,surecDepoID){
	//	alert(secilenReceteID)
		swal({
			title: 'LOT kaydı silinsin mi?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'evet',
			cancelButtonText: 'hayır'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			
				$('#ajax').load('/uretim/uretimLotSil.asp', {stokHareketID:stokHareketID}, function(){
					$('#receteAdim').load('/uretim/uretim.asp?secilenReceteID='+secilenReceteID+'&secilenDepoID='+secilenDepoID+'&surecDepoID='+surecDepoID+' #receteAdim > *')	
				});
			}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}

	function etiketGoster() {

		var receteID = $('#receteID').val();
		
		if(receteID == 0){swal('','Reçete seçimi yapılmamış.'); return false};

		modalajax('/uretim/etiketSonUrun.asp?receteID='+receteID);

	}



</script>