<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	arama					=	Request.Form("arama")
	id64					=	Session("gelenadres5")
	gelenadres6				=	Session("gelenadres6")
	if gelenadres6 		= "" then
		sipVerenCari 	= 0
		faturaCari		= 0
	else
		sipVerenCari 	= gelenadres6
		faturaCari		= gelenadres6
	end if
	id						=	id64
	id						=	base64_decode_tr(id)
	modulID					=	id
	ayar_firmaBagimsizCari	=	1 
	call sessiontest()


'##### kidarr 
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#")
		musteriID			=	kidarr(0) 
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr


'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"Dosya Detay"
	yetki		=	yetkibul("","","")
'##### YETKİ BUL
'##### YETKİ BUL


		
		response.Flush()
	'##### ANA VERİ ÇEK
	'##### ANA VERİ ÇEK
		sorgu = "Select i.id, i.ad, i.ikn, i.teslimatKosul, i.odemeKosul, i.tarih_ihale, i.firmaID, i.cariID, i.durum, i.grupIhale, i.ihaleTipi, i.dosyaNo, i.dosyaSorumlu, i.odemeVade, i.teklifGecerlik, i.teslimatSure,"_
		&" i.mukayeseDurum, i.girilecek, i.ilanTarih, ISNULL(i.bayiDosyaTipi,'yok') as bayiDosyaTipi, i.bayiKurumID, i.yaklasikMalGoster, ISNULL(i.ihaleNo,0) as ihaleNo, i.eEksiltme,"_
		&" i.yerliOranGoster, i.kodlamaBitti, i.teklifNot, ISNULL(i.miktarArttirimi,0) as miktarArttirimi, i.dosyaKayitTip"_
		&" from ihale i WHERE i.musteriID = " & musteriID & " AND i.id = " & modulID
		rs.open sorgu,sbsv5,1,3
		
		sorgu = "SELECT tarih_karar FROM sozlesmeler WHERE ihaleID = " & rs("id")
		rs2.open sorgu,sbsv5,1,3
			if rs2.recordcount > 0 then
				kararTarih	=	rs2("tarih_karar")
			else
				kararTarih	= 	null	
			end if
		rs2.close
			
			ad 					=	rs("ad")
			cariID				=	rs("cariID")
			dosyaNo				=	rs("dosyaNo")
			ihaleNo				=	rs("ihaleNo")
			dosyaKayitTip		=	rs("dosyaKayitTip")
			ikn					=	rs("ikn")
			dosyaDurum			=	rs("durum")
			tarih_ihale			=	rs("tarih_ihale")
			ilanTarih			=	rs("ilanTarih")
			firmasec			=	rs("firmaID")
			carisec				=	rs("cariID")
			tip					=	rs("ihaleTipi")
			bayiKurumID			=	rs("bayiKurumID")
			kisimIhale 			= 	rs("grupIhale")
			eEksiltme			=	rs("eEksiltme")
			ihaleTipi			=	rs("ihaleTipi")
			mukayeseDurum		=	rs("mukayeseDurum")
			girilecek			=	rs("girilecek")
			yaklasikMalGoster	=	rs("yaklasikMalGoster")
			yerliOranGoster		=	rs("yerliOranGoster")
			kodlamaBitti		=	rs("kodlamaBitti")
			bayiDosyaTipi		=	rs("bayiDosyaTipi")
			dosyaSorumlu		=	rs("dosyaSorumlu")
			odemeVade			=	rs("odemeVade")
			teklifGecerlik		=	rs("teklifGecerlik")
			teslimatSure		=	rs("teslimatSure")
			teklifNot			=	rs("teklifNot")
			miktarArttirimi		=	rs("miktarArttirimi")
			teslimatKosul		=	rs("teslimatKosul")
			odemeKosul			=	rs("odemeKosul")
			rs.close
			
	'##### /ANA VERİ ÇEK
	'##### /ANA VERİ ÇEK
	
	'############ İHALE TARİHİNDEKİ KURLARI ÇEK
	'############ İHALE TARİHİNDEKİ KURLARI ÇEK
	
		if not isnull(tarih_ihale) then
			kurTarih	=	tarihsql(tarih_ihale)
			
			sorgu = "SELECT * FROM kurlar WHERE birimad = 'USD' AND tarih = " & "'" & kurTarih & "'"
			rs.open sorgu,sbsv5,1,3
			if not rs.EOF then
				USDkur	=	rs("kursat")
			end if
			rs.close
			
			sorgu = "SELECT * FROM kurlar WHERE birimad = 'EUR' AND tarih = " & "'" & kurTarih & "'"
			rs.open sorgu,sbsv5,1,3
			if not rs.EOF then
				EURkur	=	rs("kursat")
			end if
			rs.close
		else
			USDkur 	= 0
			EURkur	= 0
		end if
	
	'############ /İHALE TARİHİNDEKİ KURLARI ÇEK
	'############ /İHALE TARİHİNDEKİ KURLARI ÇEK
	





'##### TABLO
'##### TABLO

sorgu = "SELECT COALESCE(NULLIF(adKisa,''), ad) as cariAD FROM cariler WHERE id = " & cariID
rs.open sorgu,sbsv5,1,3
alimYapan 	=	rs("cariAD")
rs.close

Response.Write "<div class=""row"">"
Response.Write "<div class=""col-lg-12"">"
Response.Write "<div class=""card"">"
Response.Write "<div class=""card-header"" id=""sayfaAdi"">"
	Response.Write "<i class=""fa fa-align-justify""></i> " & sayfaadi &" <i class=""fa fa-hand-o-right"" aria-hidden=""true""></i> "
	Response.Write dosyaNo &" ("& ihaleNo & ") <i class=""fa fa-window-minimize"" aria-hidden=""true""></i> "
	Response.Write alimYapan & " <i class=""fa fa-window-minimize"" aria-hidden=""true""></i> "
	Response.Write tarih_ihale & "&nbsp;&nbsp;</i><i class=""fa fa-eur"" aria-hidden=""true""></i> = " & EURkur 
	Response.Write " &nbsp;&nbsp;<i class=""fa fa-usd"" aria-hidden=""true""></i> = " & USDkur
Response.Write "</div>"
Response.Write "<div class=""card-body row"">"


'##### SEKMELER
'##### SEKMELER
	Response.Write "<div class=""col-lg-12"">"
	Response.Write "<ul class=""nav nav-tabs"" role=""tablist"" id=""sekmeler"">"
	
	if instr(yetki,",16,") = 0 then'yetki_16
		Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(44);"" data-yardim=""44"">"
		Response.Write "<a class=""active nav-link fontkucuk"" data-toggle=""tab"" href=""#anaVeri"" role=""tab"" aria-controls=""anaVeri"">Ana Veri</a>"
		Response.Write "</li>"
	end if'yetki_16
	
	if instr(yetki,",17,") = 0 then'yetki_17
		Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(45);"" data-yardim=""45"">"
		Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#urunler"" role=""tab"" aria-controls=""urunler"">Ürünler</a>"
		Response.Write "</li>"
	end if'yetki_17
	
			Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(46);"" data-yardim=""46"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#isArttirim"" role=""tab"" aria-controls=""isArttirim"">İş Arttırımı</a>"
			Response.Write "</li>"
	
	if bayiDosyaTipi <> "stok" AND ihaletipi <> "yaklasik_mal" then
		if instr(yetki,",18,") = 0 then'yetki_18
			Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(46);"" data-yardim=""46"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#urunler2"" role=""tab"" aria-controls=""urunler2"">Ürünler -II-</a>"
			Response.Write "</li>"
		end if'yetki_18
	end if'bayiDosyaTipi
	
	if bayiDosyaTipi <> "stok" AND ihaletipi <> "yaklasik_mal" then
		if instr(yetki,",19,") = 0 then'yetki_19
			Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(47);"" data-yardim=""47"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#topluAlim"" role=""tab"" aria-controls=""topluAlim"">Toplu Alım</a>"
			Response.Write "</li>"
		end if'yetki_19
	end if'bayiDosyaTipi
	
	if bayiDosyaTipi <> "stok" AND ihaletipi <> "yaklasik_mal" then
		if instr(yetki,",20,") = 0 then'yetki_20
			Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(48);"" data-yardim=""48"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#rakipler"" role=""tab"" aria-controls=""rakipler"">Rakip/Uhde</a>"
			Response.Write "</li>"
		end if'yetki_20
	end if'bayiDosyaTipi
	
	if bayiDosyaTipi <> "stok" AND ihaletipi <> "yaklasik_mal" then
		if instr(yetki,",15,") = 0 then'yetki_15
			Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(49);"" data-yardim=""49"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#teminat"" role=""tab"" aria-controls=""teminat"">Teminat</a>"
			Response.Write "</li>"
		end if'yetki_15
	end if'bayiDosyaTipi
	
	if bayiDosyaTipi <> "stok" AND ihaletipi <> "yaklasik_mal" then
		if instr(yetki,",21,") = 0 then'yetki_21
			Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(50);"" data-yardim=""50"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#sozlesme"" role=""tab"" aria-controls=""sozlesme"">Karar/Sözleşme</a>"
			Response.Write "</li>"
		end if'yetki_21
	end if'bayiDosyaTipi
	
	if ihaletipi <> "yaklasik_mal" then
		if instr(yetki,",22,") = 0 then'yetki_22
			Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(51);"" data-yardim=""51"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#siparis"" role=""tab"" aria-controls=""siparis"">Sipariş</a>"
			Response.Write "</li>"
		end if'yetki_22
	end if'ihaletipi

	if ihaletipi <> "yaklasik_mal" then
		if instr(yetki,",23,") = 0 then'yetki_23
			Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(52);"" data-yardim=""52"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#teslimat"" role=""tab"" aria-controls=""teslimat"">Teslimat</a>"
			Response.Write "</li>"
		end if'yetki_23
	end if'ihaletipi
	
	if instr(yetki,",27,") = 0 then'yetki_27
		Response.Write "<li class=""nav-item"">"
		Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#uts"" role=""tab"" aria-controls=""uts"">ÜTS</a>"
		Response.Write "</li>"
	end if'yetki_27
	
	if instr(yetki,",24,") = 0 then'yetki_24
		Response.Write "<li class=""nav-item"" onMouseOver=""yardimYukle(53);"" data-yardim=""53"">"
		Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#teklif"" role=""tab"" aria-controls=""teklif"">Teklif</a>"
		Response.Write "</li>"
	end if'yetki_24
		
	Response.Write "</ul>"
'##### /SEKMELER
'##### /SEKMELER

	Response.Write "<div class=""tab-content"">"
'##### ANA VERİ
'##### ANA VERİ
	if instr(yetki,",16,") = 0 then'yetki_16
		
		Response.Write "<div class=""active tab-pane"" id=""anaVeri"" role=""tabpanel"">"
	Response.Write "<input type=""hidden"" name=""ihaleID"" value=" & id & " />"
	
		Response.Write "<div id=""anaVeriInput"" class="""">"
	
	Response.Write "<div class=""card-deck"">"
		Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-body"">"
				Response.Write "<label class=""badge"">Firmam Seçimi</label>"
					call formselectv2("firmasec",firmasec,"","","ajSave firmasec",iptalKontrol,"firmaID|"&id&"|ihale",firmalardegerler,"")
		
				Response.Write "<label class=""badge"">Cari Seçimi</label>"
				Response.Write "<div class=""fontkucuk2""><strong>Mevcut Cari :</strong>" & DosyaCariAd & "</div>"
				Response.Write "<div id=""cariDIV"">"
					call formselectv2("carisec",carisec,"","","ajSave carisec",iptalKontrol,"cariID|"&id&"|ihale",carilerdegerler,"")
				Response.Write "</div>"
				Response.Write "<label class=""badge"">Dosya Tipi</label>"
					call formselectv2("tip",tip,"","","ajSave",iptalKontrol,"ihaleTipi|"&id&"|ihale",dosyaTipDegerler,"")
				
			classYaz = classbelirle("mt-2",kisimIhale,ihaleTipi,"","sadeceBayi","","","","","","","","")
				Response.Write "<div class="""&classYaz&""">"
				Response.Write "<label class=""badge"">Alım Yapan Kurum Seçimi</label>"
				Response.Write "<div id=""cariDIV2"">"
					call formselectv2("bayiKurumID",bayiKurumID,"","","ajSave carisec",iptalKontrol,"bayiKurumID|"&id&"|ihale",carilerdegerler,"")
				Response.Write "</div>"
				Response.Write "</div>"
				
			classYaz = classbelirle("mt-2",kisimIhale,ihaleTipi,"","sadeceBayi","","","","","","","","")
				Response.Write "<div class="""&classYaz&""">"
				Response.Write "<label class=""badge"">Bayi Dosya Tipi</label>"
					call formselectv2("bayiDosyaTipi",bayiDosyaTipi,"","","ajSave",iptalKontrol,"bayiDosyaTipi|"&id&"|ihale",bayiDosyaTipiDegerler,"")
				Response.Write "</div>"
				
				Response.Write "<label class=""badge"">Dosya Sorumlusu</label>"
					call formselectv2("dosyaSorumlu",dosyaSorumlu,"","","ajSave","","dosyaSorumlu|"&id&"|ihale",kullanicilarDegerler,"")
				
				if dosyaKayitTip = "M" then
					Response.Write "<div id=""ihaleNoVer"" class=""mt-1"">"
					Response.Write "<label class=""badge"">İhale Dosya Numarası</label><br>"
						if ihaleNo = "0" then
							Response.Write "<button class=""btnIhaleNo btn btn-sm form-control btn-success rounded"">Dosyaya İhale Numarası Ver</button>"
						else
							Response.Write "<i class=""btn btnIhaleNo fa fa-trash text-danger""></i><strong>" & ihaleNo & "</strong>"
						end if
					Response.Write "</div>"
				end if
			Response.Write "</div>"'card-body
		Response.Write "</div>"'card
		
		
		Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-body"">"
			
			Response.Write "<label class=""badge"">Dosya Adı</label>"
				call forminput("ad",ad,"","Dosya Adı","ajSave","","ad|"&id&"|ihale","")
	
			Response.Write "<label class=""badge"">İhale Tarihi ve Saati</label>"
				call forminput("tarih_ihale",tarih_ihale,"","İhale Tarih","ajSave tarihSaat cell",iptalKontrol,"tarih_ihale|"&id&"|ihale","")
				
			Response.Write "<label class=""badge"">İhale İlan Tarihi</label>"
				call forminput("ilanTarih",ilanTarih,"","İhale İlan Tarihi","ajSave tarih cell",iptalKontrol,"ilanTarih|"&id&"|ihale","")
				
			Response.Write "<label class=""badge"">İKN</label>"
				call forminput("ikn",ikn,"","İKN","ajSave","","ikn|"&id&"|ihale","")
				
			Response.Write "<div class=""container row"">"
				Response.Write "<div class=""col-lg-3"">"
					Response.Write "<label class=""badge"">Ödeme Vadesi</label>"
					call forminput("odemeVade",odemeVade,"","(gün)","ajSave","","odemeVade|"&id&"|ihale","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-3"">"
					Response.Write "<label class=""badge"">Teklif Geçerlilik</label>"
					call forminput("teklifGecerlik",teklifGecerlik,"","Geçerlilik","ajSave","","teklifGecerlik|"&id&"|ihale","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-3"">"
					Response.Write "<label class=""badge"">Teslimat Süresi</label>"
					call forminput("teslimatSure",teslimatSure,"","Teslimat Süresi","ajSave","","teslimatSure|"&id&"|ihale","")
				Response.Write "</div>"
			Response.Write "</div>"
			
			Response.Write "<div class=""d-flex"">"
					Response.Write "<div class=""col-lg-6"">"
						Response.Write "<label class=""badge"">Ödeme Koşulları</label>"
						Response.Write "<textarea id=""odemeKosul|"&id&"|ihale"" class=""ajSave form-control fontkucuk2"" name=""odemeKosul"" cols=""50"" rows=""5"">" & odemeKosul & "</textarea>"
					Response.Write "</div>"
					
					Response.Write "<div class=""col-lg-6"">"
						Response.Write "<label class=""badge"">Teslimat Koşulları</label>"
						Response.Write "<textarea id=""teslimatKosul|"&id&"|ihale"" class=""ajSave form-control fontkucuk2"" name=""teslimatKosul"" cols=""50"" rows=""5"">" & teslimatKosul & "</textarea>"
					Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "</div>"'card-body
		Response.Write "</div>"'card
		
		Response.Write "<div class=""card"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""card-body col-lg-6"">"
			
			Response.Write "<label class=""badge"" onMouseOver=""yardimYukle();"" data-yardim="""">Dosya Durum</label>"
				call formselectv2("durum",dosyaDurum,"","","ajSave","","durum|"&id&"|ihale",dosyaDurumDegerler,"")
			
			Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(55);"" data-yardim=""55"">Mukayese Durum</label>"
				call formselectv2("mukayeseDurum",mukayeseDurum,"","","ajSave","","mukayeseDurum|"&id&"|ihale",mukayeseDurumDegerler,"")
			
			Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(56);"" data-yardim=""56"">Yaklaşık Maliyet Göster</label>"
			if yaklasikMalGoster = "True" then
				yaklasikMalGoster = 1
			else
				yaklasikMalGoster = 0
			end if
			yaklasikMalDegerler = "EVET=1|HAYIR=0"
				call formselectv2("yaklasikMalGoster",yaklasikMalGoster,"","","ajSave ","","yaklasikMalGoster|"&id&"|ihale",yaklasikMalDegerler,"")
				
			Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(57);"" data-yardim=""57"">Yerli Oran Göster</label>"
			if yerliOranGoster = "True" then
				yerliOranGoster = 1
			else
				yerliOranGoster = 0
			end if
			yerliOranDegerler = "EVET=1|HAYIR=0"
				call formselectv2("yerliOranGoster",yerliOranGoster,"","","ajSave ","","yerliOranGoster|"&id&"|ihale",yerliOranDegerler,"")
				
			Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(57);"" data-yardim=""57"">e-Eksiltme</label>"
			if eEksiltme = "True" then
				eEksiltme = 1
			else
				eEksiltme = 0
			end if
			eEksiltmeDegerler = "EVET=1|HAYIR=0"
				call formselectv2("eEksiltme",eEksiltme,"","","ajSave ","","eEksiltme|"&id&"|ihale",eEksiltmeDegerler,"")
				
			Response.Write "</div>"'card-body
			
			
			
			Response.Write "<div class=""card-body col-lg-6"">"
				Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(58);"" data-yardim=""58"">Teklif Verilecek</label>"
				if girilecek = "True" then
					girilecek = 1
				else
					girilecek = 0
				end if
				istirakDegerler = "EVET=1|HAYIR=0"
					call formselectv2("girilecek",girilecek,"","","ajSave ","","girilecek|"&id&"|ihale",istirakDegerler,"")
					
				Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(59);"" data-yardim=""59"">İş Arttırımı</label>"
				miktarArttirimiDegerler = "EVET=1|HAYIR=0"
					call formselectv2("miktarArttirimi",miktarArttirimi,"","","ajSave ","","miktarArttirimi|"&id&"|ihale",miktarArttirimiDegerler,"")
				
					Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(54);"" data-yardim=""54"">Kısım İhale</label>"
					if kisimIhale = "True" then
						grupIhale = 1
					else
						grupIhale = 0
					end if
					grupIhaleDegerler = "EVET=1|HAYIR=0"
						call formselectv2("grupIhale",grupIhale,"","","ajSave","","grupIhale|"&id&"|ihale",grupIhaleDegerler,"")

			Response.Write "</div>"'card-body
		Response.Write "</div>"'row


		Response.Write "</div>"'card
		
	Response.Write "</div>"'card-deck
	
		Response.Write "</div>"'anaVeriInput
		
		Response.Write "</div>"'tab-pane
	end if'yetki_16
'##### /ANA VERİ
'##### /ANA VERİ

'##### ÜRÜNLER
'##### ÜRÜNLER
	if instr(yetki,",17,") = 0 then'yetki_17
		Response.Write "<div class=""tab-pane"" id=""urunler"" role=""tabpanel"">"
		
		Response.Write "<div class=""urunlistediv d-none"" tabindex=""-1"">"
			Response.Write "<div id=""exceLoading""><img src='/image/working2.gif' width='40' height='40'/></div>"
		Response.Write "</div>"
	
	
	Response.Write "<form class=""ajaxform"" action=""/dosya/detay_kaydet.asp"">"
	Response.Write "<input type=""hidden"" name=""ihaleID"" value=" & id & " />"
	Response.Write "<input type=""hidden"" name=""cariID"" value=" & cariID & " />"
		
		Response.Write "<div id=""urunlerInput"" class="""">"
		
			Response.Write "<div class=""card-deck"">"
			Response.Write "<div class=""col-5"">"
			Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header""><h5>Ürün Tanımlama(Manuel)</h5></div>"
				Response.Write "<div class=""card-body"">"
			Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(61);"" data-yardim=""61"">Ürün Seçimi</label>"
				call formselectv2("urunsec",urunsec,"","","urunsec","","urunsec",stoklardegerler,"")
	
	Response.Write "<div class=""row"">"
		classYaz = classbelirle("col-lg-3",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
			Response.Write "<div class="""&classYaz&""">"
			Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(62);"" data-yardim=""62"">Kısım Numarası</label>"
				call forminput("grupNo",grupNo,"","Kısım Numarası","","","grupNo","")
			Response.Write "</div>"
	
			Response.Write "<div class=""col-lg-3"">"
			Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(63);"" data-yardim=""63"">Liste Sıra Numarası</label>"
				call forminput("siraNo",siraNo,"","Liste Sıra Numarası","","","siraNo","")
			Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12"">"
			Response.Write "<label class=""badge"" onMouseOver=""yardimYukle(64);"" data-yardim=""64"">Ürünün Listedeki Adı</label>"
			call forminput("urunAd",urunAd,"","Ürünün Listedeki Adı","","","urunAd","")
			Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-4"">"
			Response.Write "<label class=""badge"">Miktar</label>"
			call forminput("miktar",miktar,"","Miktar","","","miktar","")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-4"">"
			Response.Write "<label class=""badge"">Birim</label>"
			call forminput("birim",birim,"","Birim","","","birim","")
			Response.Write "</div>"
			
			Response.Write "<div class=""col-lg-4"">"
			Response.Write "<label class=""badge"">&nbsp;</label>"
			Response.Write "<button name=""urunler"" class=""kaydet btn-block btn-primary"" type=""submit"" onClick=""$('#tip').val('acik');"">kaydet</button>"
			Response.Write "</div>"
	Response.Write "</div>"
				Response.Write "</div>"'card-body
			Response.Write "</div>"'card
			Response.Write "</div>"'col
			
			Response.Write "<div class=""col-2"">"
			Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-header"" onMouseOver=""yardimYukle(65);"" data-yardim=""65""><h5>Ürün Tanımlama<br>(EXCEL YÜKLE)</h5></div>"
			Response.Write "<div class=""card-body"">"
				
			
			Response.Write "<label class=""badge"">&nbsp;</label>"
			Response.Write "<button class=""btn-block btn-primary"" type=""button"" onClick=""modalajax('','/dosya/excel_modal.asp?id=" & id & "')"">EXCEL YÜKLE</button>"
			call clearfix()
	
			Response.Write "<label class=""badge"">&nbsp;</label>"
			Response.Write "<div class=""urunlistebutton btn btn-danger"
			if dosyakontrol("/dosyalar/" & musteriID & "/urunlistesi/" & id & ".xlsx") = True then
			else
				Response.Write " d-none"
			end if
			Response.Write """ onClick=""$('.urunlistediv').removeClass('d-none').focus();$('.urunlistediv').load('/dosya/excel_goster.asp?id="&id64&"&f=" & "/dosyalar/" & musteriID & "/urunlistesi/" & id & ".xlsx');"">Ürün Listesini Göster</div>"
				
			Response.Write "</div>"'card-body
			Response.Write "</div>"'card
			Response.Write "</div>"'col
			Response.Write "</div>"
		
		Response.Write "</div>"'urunlerInput


		
	Response.Write "</form>"
			Response.Write "<table id=""urunlerTablo"" class=""table table-responsive table-bordered table-sm table-hover mt-3"">"
	
'##### tablo başlıklar	
			Response.Write "<thead><tr class=""text-center bg-gray-200 p-0"">"
			Response.Write "<th class=""align-middle"">"
			
			Response.Write "<label class=""switch switch-lg switch-text switch-success"" onMouseOver=""yardimYukle(60);"" data-yardim=""60"">"
				Response.Write "<input id=""urunlerSwitch"" type=""checkbox"" class=""switch-input hover"" checked=""checked"" onclick=""$('#urunlerInput').toggle('slow');"">"
				Response.Write "<span class=""switch-label"" data-on=""✓"" data-off=""X"">"
				Response.Write "</span>"
				Response.Write "<span class=""switch-handle""></span>"
			Response.Write "</label>"
			
			Response.Write "</th>"
			Response.Write "<th class=""align-middle"" onMouseOver=""yardimYukle(66);"" data-yardim=""66"">Notlar</th>"
		classYaz = classbelirle("align-middle w-5",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
			Response.Write "<th class="""&classYaz&""" onMouseOver=""yardimYukle(67);"" data-yardim=""67"">Kısım No</th>"
			Response.Write "<th class=""align-middle"" onMouseOver=""yardimYukle(68);"" data-yardim=""68"">Sıra No</th>"
			Response.Write "<th class=""align-middle"" onMouseOver=""yardimYukle(69);"" data-yardim=""69"">Ürün Ad</th>"
			Response.Write "<th class=""align-middle"" colspan=""2"">Miktar</th>"

		classYaz = classbelirle("align-middle","",ihaleTipi,"","","","","","",miktarArttirimi,"","","")
			Response.Write "<th class="""&classYaz&""" onMouseOver=""yardimYukle(70);"" data-yardim=""70"">Arttırım<hr class=""m-0 p-0"">Eksiltim</th>"

		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","","","",yaklasikMalGoster,"","","","","")
			Response.Write "<th class="""&classYaz&""" colspan=""2"" onMouseOver=""yardimYukle(71);"" data-yardim=""71"">Yaklaşık Maliyet</th>"
			
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","","","","",yerliOranGoster,"","","","")
			Response.Write "<th class="""&classYaz&""" onMouseOver=""yardimYukle(72);"" data-yardim=""72"">Yerli Oran</th>"
		if ihaleTipi <> "bayi" then
			Response.Write "<th class=""align-middle"" colspan=""2"">Fiyat</th>"
		end if
			Response.Write "<th class=""align-middle"" onMouseOver=""yardimYukle(73);"" data-yardim=""73"">Liste Fiyat</th>"
	
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","sadeceBayi","","","","","","","","")
			Response.Write "<th class="""&classYaz&""" onMouseOver=""yardimYukle(74);"" data-yardim=""74"">İskonto Oran</th>"
			Response.Write "<th class="""&classYaz&""" colspan=""2"" onMouseOver=""yardimYukle(75);"" data-yardim=""75"">Bayi Alış</th>"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","sadeceBayi","","","","","",bayiDosyaTipi,"","")
			Response.Write "<th class="""&classYaz&""" colspan=""2"" onMouseOver=""yardimYukle(76);"" data-yardim=""76"">Tavsiye Fiyat</th>"
			Response.Write "<th class="""&classYaz&""" onMouseOver=""yardimYukle(77);"" data-yardim=""77"">Bayi Marjı</th>"
	if instr(yetki,",14,") = 0 then'yetki_14
			Response.Write "<th class=""align-middle"" onMouseOver=""yardimYukle(78);"" data-yardim=""78"">Fiyat Onay</th>"
	end if'yetki_14
			Response.Write "</tr></thead><tbody>"
			
'##### /tablo başlıklar

			sorgu = "Select iu.yaklasikMaliyet, iu.yerliOran, iu.iptalSebep, iu.iptal, iu.uhde, iu.firmamFiyat, ISNULL(iu.pazarlik_ilkFiyat,0) as pazarlik_ilkFiyat, ISNULL(iu.firmamParaBirim,'TL') as firmamParaBirim,"_
			&" iu.iskontoOran, iu.bayiAlis, iu.tavsiyeFiyat, ISNULL(iu.tavsiyeBirim,'TL') as tavsiyeBirim, iu.grupNo, iu.siraNo, iu.fiyatOnay,"_
			&" iu.miktar, ISNULL(iu.miktar,0) as miktar, ISNULL(iu.arttirimMiktar,0) as arttirimMiktar, ISNULL(iu.eksiltimMiktar,0) as eksiltimMiktar, iu.birim, iu.stoklarID, ISNULL(iu.yaklasikMaliyetPB,'TL') as yaklasikMaliyetPB,"_
			&" iu.bayiMarj, ISNULL(iu.bayiAlisPB,'TL') as bayiAlisPB, iu.stoklarListeFiyat, iu.stoklarListeFiyatPB, stoklar.listeFiyat, stoklar.listeBirim, iu.listeFiyatTarih,"_
			&" iu.id as ihaleUrunID, iu.ad as urunAd, iu.kalemNot, iu.kalemNotTeklifEkle, stoklar.ad as stoklarAD, i.id as ihaleID, i.ihaleTipi"_
			&" from ihale_urun iu INNER JOIN ihale i ON iu.ihaleID = i.id"_
			&" LEFT JOIN stoklar ON iu.stoklarID = stoklar.id"_
			&" WHERE i.musteriID = " & musteriID & " and ihaleID = " & id & " order by grupNo ASC, siraNo ASC"
			rs.open sorgu,sbsv5,1,3
			for i = 1 to rs.recordcount
			
			Response.Write "<tr>"
				Response.Write "<td class=""align-middle text-center"">"
						Response.Write "<a id="""&rs("ihaleUrunID")&"|ihale_urun"&""" class=""btn ajSil pt-0 pb-0 pl-0"" role=""button""><i class=""fa fa-trash-o""></i></a>"
						Response.Write "<a id="""&rs("ihaleUrunID")&"|ihale_urun"" class=""btn ajUruniptal p-0"""
							if rs("iptal") = "False" then
								Response.Write " onclick=""modalajax('','/dosya/detay_modal_iptalSebep.asp?ihaleID=" & rs("ihaleID") & "&id=" & rs("ihaleUrunID") &  "');"""
							end if
						Response.Write " role=""button"" data-toggle=""tooltip"" data-placement=""top"" title=""Kalem iptal edilmişse""><i class=""fa fa-ban""></i></a>"
						
				Response.Write "</td>"
				
				Response.Write "<td class=""align-middle text-center"">"

					Response.Write "<i"
					if isnull(rs("kalemNot")) then
						Response.Write " class=""fa fa-plus-circle text-green btn"""
					elseif rs("kalemNotTeklifEkle") = 1 then
						Response.Write " class=""fa fa-exclamation-triangle text-info btn"""
					else
						Response.Write " class=""fa fa-exclamation-triangle text-red btn"""
					end if
				Response.Write " onClick=""modalajax('','/dosya/detay_modal_kalemNot.asp?ihaleID=" & rs("ihaleID") & "&id=" & rs("ihaleUrunID") &  "');""></i>"
				Response.Write "</td>"
'## grupNO				
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"gruptaVar","",rs("iptal"),rs("uhde"),"","","","","","")
				Response.Write "<td class="""&classYaz&""">"
					call forminput("grupNo",rs("grupNo"),"","","ajSave borderless text-center input30","","grupNo|"&rs("ihaleUrunID")&"|ihale_urun","") 
				Response.Write "</td>"
'## /grupNO

'## siraNO
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"","",rs("iptal"),rs("uhde"),"","","","","","")
				Response.Write "<td class="""&classYaz&""">"
					call forminput("siraNo",rs("siraNo"),"","","ajSave borderless text-center input30","","siraNo|"&rs("ihaleUrunID")&"|ihale_urun","")
				Response.Write "</td>"
'## /siraNO

'## urunAD
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","",rs("iptal"),"","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
					call forminput("urunAd",rs("urunAd"),"","","ajSave borderless input500","","urunAd|"&rs("ihaleUrunID")&"|ihale_urun","")
					
						if rs("stoklarID") > 0 then
							Response.Write "<a id="""&rs("ihaleUrunID")&"|ihale_urun"&"|stokKarsilik"" class=""btn ajSil text-muted "" role=""button""><i class=""fa fa-trash-o p-0 m-0""></i></a>"
						end if
						
						Response.Write "<span class=""stokKarsilik fontkucuk2 text-info btn"" onClick=""modalajaxfit('','/dosya/detay_modal_urun.asp?firmalarID=" & firmasec & "&ihaleID=" & rs("ihaleID") & "&id=" & rs("ihaleUrunID") & "&stoklarID=" & rs("stoklarID") & "');""><em id=""stoklarad"" class=""stoklarad" & rs("ihaleUrunID") & """>"
					if rs("stoklarID") = 0 OR isnull(rs("stoklarID")) then
						Response.Write "<i class=""fa fa-exclamation text-danger""> stok karşılığı seçilmemiş</i> <i class=""fa fa-exclamation text-danger""></i>"
					else
						Response.Write rs("stoklarAD")
					end if
					
					call clearfix()
					if not isnull(rs("iptalSebep")) then
						Response.Write "<span class=""text-warning""><b>"&rs("iptalSebep")&"</b></span>"
					end if
					
						Response.Write "</em></font>"
				Response.Write "</td>"
'## /urunAD

'## miktar
				Response.Write "<td class=""align-middle border-right-0 p-0"">"
					call forminput("miktar",formatnumber(rs("miktar"),0),"","","ajSave borderless text-right input50","","miktar|"&rs("ihaleUrunID")&"|ihale_urun","")
				Response.Write "</td>"
'## /miktar

'## birim
				Response.Write "<td class=""align-middle border-left-0 pl-1"">"
					call forminput("birim",rs("birim"),"","","ajSave borderless text-left input30","","birim|"&rs("ihaleUrunID")&"|ihale_urun","")
				Response.Write "</td>"
'## /birim

'## iş arttırım miktarı ve birimi
		classYaz = classbelirle("align-middle text-center border-right-0 p-0","",ihaleTipi,"","","","","","",miktarArttirimi,"","","")
				Response.Write "<td class="""&classYaz&""">"
					arttirMik 	=	rs("arttirimMiktar")
					eksiltMik 	=	rs("eksiltimMiktar")
					birim		=	rs("birim")
					if arttirMik = 0 AND eksiltMik = 0 then
						arttirMik	= ""
						eksiltMik	= ""
						birim		= ""
					elseif arttirMik > 0 AND eksiltMik = 0 then
						arttirMik	= 	"<span class=""text-success"">+"&formatnumber(arttirMik,0)&" "&birim&"</span>"
						eksiltMik	=	""
					elseif arttirMik = 0 AND eksiltMik > 0 then
						eksiltMik	= 	"<span class=""text-danger"">-"&formatnumber(eksiltMik,0)&" "&birim&"</span>"
						arttirMik	=	""
					elseif arttirMik > 0 AND eksiltMik > 0 then
						eksiltMik	= 	"<span class=""text-danger"">-"&formatnumber(eksiltMik,0)&" "&birim&"</span>"
						arttirMik	=	"<span class=""text-success"">+"&formatnumber(arttirMik,0)&" "&birim&"</span>"
					end if
					
					Response.Write arttirMik&"<hr class=""m-0 p-0"">"&eksiltMik
				Response.Write "</td>"
'## /iş arttırım miktarı

'## Yaklaşık Maliyet
		classYaz = classbelirle("align-middle text-right border-right-0 pr-0",kisimIhale,ihaleTipi,"","","","",yaklasikMalGoster,"","","","","")
				Response.Write "<td class="""&classYaz&""">"
					para_deger = para_basamak(rs("yaklasikMaliyet"))
					call forminput("yaklasikMaliyet",para_deger,"","","ajSave borderless para text-right input50","","yaklasikMaliyet|"&rs("ihaleUrunID")&"|ihale_urun","")
				Response.Write "</td>"
'## /Yaklaşık Maliyet

'## Yaklaşık Maliyet Birim
		classYaz = classbelirle("align-middle text-left border-left-0 pl-1",kisimIhale,ihaleTipi,"","","","",yaklasikMalGoster,"","","","","")
				Response.Write "<td class="""&classYaz&""">"
					call formselectv2("yaklasikMaliyetPB",rs("yaklasikMaliyetPB"),"","","ajSave btn p-0 okKaldir input30","","yaklasikMaliyetPB|"&rs("ihaleUrunID")&"|ihale_urun",paraBirimDegerler,"")
				Response.Write "</td>"
'## /Yaklaşık Maliyet Birim

'## Yerli Oran
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"","","","","",yerliOranGoster,"","","","")
				Response.Write "<td class="""&classYaz&""">"
					Response.Write "<div class=""input-group-prepend"">"
					call forminput("yerliOran",rs("yerliOran"),"","","ajSave borderless text-right input30","","yerliOran|"&rs("ihaleUrunID")&"|ihale_urun","")
						Response.Write "<div class=""input-group-text bg-transparent borderless"">&nbsp;%</div>"
					Response.Write "</div>"
				Response.Write "</td>"
'## /Yerli Oran

'## Fiyatım
		if ihaleTipi <> "bayi" then
				Response.Write "<td class=""align-middle border-right-0 p-0"">"
					para_deger = para_basamak(rs("firmamFiyat"))
					pazarlik_para_deger = para_basamak(rs("pazarlik_ilkFiyat"))
					
				Response.Write "<div class=""d-flex"">"
				if rs("ihaleTipi") = "pazarlik" then
					Response.Write "<span class=""rounded-circle bg-info text-center mr-1"">&nbsp;2&nbsp;</span>"
				end if
					call forminput("firmamFiyat",para_deger,"","","ajSave borderless para text-right p-0 input70","","firmamFiyat|"&rs("ihaleUrunID")&"|ihale_urun","")
				Response.Write "</div>"
				if rs("ihaleTipi") = "pazarlik" then
				call clearfix
				Response.Write "<div class=""d-flex"">"
					Response.Write "<span class=""rounded-circle bg-info text-center mr-1"">&nbsp;1&nbsp;</span>"
					call forminput("pazarlik_ilkFiyat",pazarlik_para_deger,"","","ajSave borderless para text-right p-0 input70","","pazarlik_ilkFiyat|"&rs("ihaleUrunID")&"|ihale_urun","")
				Response.Write "</div>"
				end if
				Response.Write "</td>"
				
				Response.Write "<td class=""align-middle border-left-0 p-0 pl-1"" style=""width:40px"">"
					call formselectv2("firmamParaBirim",rs("firmamParaBirim"),"","","ajSave btn p-0 okKaldir","","firmamParaBirim|"&rs("ihaleUrunID")&"|ihale_urun",paraBirimDegerler,"")
				if rs("ihaleTipi") = "pazarlik" then
					call formselectv2("firmamParaBirim",rs("firmamParaBirim"),"","","ajSave btn p-0 okKaldir","","firmamParaBirim|"&rs("ihaleUrunID")&"|ihale_urun",paraBirimDegerler,"")
				end if
				Response.Write "</td>"
		end if
'## /Fiyatım

'## Ürün liste fiyatı
				Response.Write "<td class=""text-right align-middle border-right-0 "">"
					para_deger = para_basamak(rs("stoklarListeFiyat"))
					response.Write para_deger&" "&rs("stoklarListeFiyatPB")
					call clearfix()
					if isdate(rs("listeFiyatTarih")) then
					Response.Write "<span class=""fontkucuk2"">("&formatdatetime(rs("listeFiyatTarih"),2)&")</span>"
					end if
				Response.Write "</td>"
'## /Ürün liste fiyatı

'## İskonto Oranı
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","sadeceBayi","","","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
					Response.Write "<div class=""input-group-prepend"">"
					call forminput("iskontoOran",rs("iskontoOran"),"","","ajSave borderless text-right input30","","iskontoOran|"&rs("ihaleUrunID")&"|ihale_urun","")
					if rs("iskontoOran") <> 0 then
						Response.Write "<div class=""input-group-text bg-transparent borderless""><strong>&nbsp;%</strong></div>"
					end if
					Response.Write "</div>"
				Response.Write "</td>"
'## /İskonto Oranı

'## Bayi Alış Fiyatı ve Para Birimi
		classYaz = classbelirle("align-middle border-right-0 p-0",kisimIhale,ihaleTipi,"","sadeceBayi","","","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
					para_deger = para_basamak(rs("bayiAlis"))
					call forminput("bayiAlis",para_deger,"","","ajSave borderless text-right input50","","bayiAlis|"&rs("ihaleUrunID")&"|ihale_urun","")
				Response.Write "</td>"
		classYaz = classbelirle("text-left align-middle border-left-0 p-0 pl-1",kisimIhale,ihaleTipi,"","sadeceBayi","","","","","","","","")
				Response.Write "<td class="""&classYaz&""" style=""width:40px"">"
					call formselectv2("bayiAlisPB",rs("bayiAlisPB"),"","","ajSave borderless okKaldir btn p-0","","bayiAlisPB|"&rs("ihaleUrunID")&"|ihale_urun",paraBirimDegerler,"")
				Response.Write "</td>"
'## /Bayi Alış Fiyatı ve Para Birimi

'## Tavsiye Fiyatı ve Para Birimi
		classYaz = classbelirle("align-middle border-right-0 p-0",kisimIhale,ihaleTipi,"","sadeceBayi","","","","","",bayiDosyaTipi,"","")
				Response.Write "<td class="""&classYaz&""">"
					para_deger = para_basamak(rs("tavsiyeFiyat"))
					call forminput("tavsiyeFiyat",para_deger,"","","ajSave borderless text-right p-0 input50","","tavsiyeFiyat|"&rs("ihaleUrunID")&"|ihale_urun","")
				Response.Write "</td>"
				
		classYaz = classbelirle("text-left align-middle border-left-0",kisimIhale,ihaleTipi,"","sadeceBayi","","","","","",bayiDosyaTipi,"","")
				Response.Write "<td class="""&classYaz&""" style=""width:40px"">"
					call formselectv2("tavsiyeBirim",rs("tavsiyeBirim"),"","","ajSave borderless okKaldir btn p-0","","tavsiyeBirim|"&rs("ihaleUrunID")&"|ihale_urun",paraBirimDegerler,"")
				Response.Write "</td>"
'## /Tavsiye Fiyatı ve Para Birimi

'## Bayi Kar Marjı
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","sadeceBayi","","","","","",bayiDosyaTipi,"","")
				Response.Write "<td class="""&classYaz&""">"
					Response.Write "<div class=""input-group-prepend"">"
					call forminput("bayiMarj",rs("bayiMarj"),"","","ajSave borderless text-right input30","","bayiMarj|"&rs("ihaleUrunID")&"|ihale_urun","")
					if rs("bayiMarj") <> 0 then
						Response.Write "<div class=""input-group-text bg-transparent borderless""><strong>&nbsp;%</strong></div>"
					end if
					Response.Write "</div>"
				Response.Write "</td>"
'## /Bayi Kar Marjı

	 if instr(yetki,",14,") = 0 then'yetki_14
			if rs("fiyatOnay") = "True" then
				y = "align-middle text-center bg-green"
			else
				y = "align-middle text-center"
			end if
				Response.Write "<td class="""&y&""">"
				Response.Write "<div>"
					Response.Write "<input type=""checkbox"" class=""ajSave chck30"""
					if rs("fiyatOnay") = "True" then
						Response.Write "checked "
						Response.Write "value=""False"""
					else
						Response.Write "value=""True"""
					end if
					Response.Write " id=""fiyatOnay|"&rs("ihaleUrunID")&"|ihale_urun"""
				Response.Write "</div>"
				Response.Write "</td>"
	end if''yetki_14		
			Response.Write "</tr>"
			rs.movenext
			next
	if instr(yetki,",13,") = 0 then'yetki_13
			Response.Write "<tr>"
				Response.Write "<td class=""align-middle"" colspan=""8"">"
					Response.Write "<div>"
					Response.Write "<input type=""checkbox"" class=""ajSave chck30"" value="""&now()&""" id=""kodlamaBitti|"&id&"|ihale"">"
					if isdate(kodlamaBitti) then
						Response.Write "<span class=""bg-success""> "&kodlamaBitti&" tarihinde ""Kodlama Bitti"" bilgisi iletildi. (Tekrar göndermek için tıklayınız.)</span>"
					else
						Response.Write " ""Kodlama Bitti"" bilgisi gönderilmedi."
					end if
					Response.Write "</div>"
				Response.Write "</td>"
			Response.Write "</tr>"
	end if''yetki_13		
			rs.close
			Response.Write "</tbody></table>"
		Response.Write "</div>"'tab-pane
	end if'yetki_17
'##### /ÜRÜNLER
'##### /ÜRÜNLER

'##### İŞ ARTTIRIMI
'##### İŞ ARTTIRIMI
		Response.Write "<div class=""tab-pane"" id=""isArttirim"" role=""tabpanel"">"
		
			Response.Write "<table id=""isArttirTablo"" class=""table table-responsive table-bordered table-sm mt-3 table-striped"">"
			
			Response.Write "<thead><tr class=""text-center bg-gray-200 p-0"">"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
			Response.Write "<th class="""&classYaz&""" style=""width:3%"" onMouseOver=""yardimYukle(79);"" data-yardim=""79"">Kısım No</th>"
			Response.Write "<th class=""align-middle"" style=""width:3%"" onMouseOver=""yardimYukle(80);"" data-yardim=""80"">Sıra No</th>"
			Response.Write "<th class=""align-middle"" style=""width:15%"" onMouseOver=""yardimYukle(85);"" data-yardim=""85"">Ürün Ad</th>"
			Response.Write "<th class=""align-middle"" style=""width:5%"">Miktar</th>"
			Response.Write "<th class=""align-middle"" style=""width:5%"">İş Arttırımı</th>"
			Response.Write "<th class=""align-middle"" style=""width:5%"">İş Eksiltimi</th>"
			Response.Write "<th class=""align-middle"" style=""width:40%"">"
			Response.Write "<div class=""text-center"">Kurumlar</div>"
			Response.Write "</th>"
			Response.Write "</tr></thead><tbody>"
	
			sorgu = "Select iu.yaklasikMaliyet, iu.yerliOran, iu.iptalSebep, iu.iptal, iu.firmamFiyat, iu.firmamParaBirim, iu.iskontoOran, iu.bayiAlis, iu.tavsiyeFiyat, iu.tavsiyeBirim, iu.uhde,"_
			&" iu.grupNo, iu.siraNo, ISNULL(iu.miktar,0) as miktar, iu.birim, iu.stoklarID, iu.yaklasikMaliyetPB, iu.firmamFiyatiptal,"_
			&" s.listeFiyat, s.listeBirim, marka.marka, fir.adKisa, fir.adUzun, ISNULL(iu.arttirimMiktar,0) as arttirimMiktar, ISNULL(iu.eksiltimMiktar,0) as eksiltimMiktar,"_
			&" iu.id as ihaleUrunID, iu.ad as urunAd, ihale.id as ihaleID, ihale.firmaID, s.ad as stoklarAD"_
			&" from ihale_urun iu INNER JOIN ihale ON iu.ihaleID = ihale.id"_
			&" LEFT JOIN stoklar s ON iu.stoklarID = s.id"_
			&" LEFT JOIN marka ON s.markaID = marka.id"_
			&" LEFT JOIN firmalar fir ON ihale.firmaID = fir.id"_
			&" WHERE ihale.musteriID = " & musteriID & " and ihale.id = " & id & " order by grupNo ASC, siraNo ASC"
			rs.open sorgu,sbsv5,1,3

			for i = 1 to rs.recordcount
			Response.Write "<tr>"
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"gruptaVar","",rs("iptal"),rs("uhde"),"","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("grupNo")
				Response.Write "</td>"
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"","",rs("iptal"),rs("uhde"),"","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("siraNo")
				Response.Write "</td>"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","",rs("iptal"),"","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("urunAd")
						Response.Write "<br><span class=""stokKarsilik fontkucuk2 text-info""><em>"
					if rs("stoklarID") = 0 OR isnull(rs("stoklarID")) then
						Response.Write "<i class=""fa fa-exclamation text-danger""> stok karşılığı seçilmemiş</i> <i class=""fa fa-exclamation text-danger""></i>"
					else
						Response.Write rs("stoklarAD")
					end if
					call clearfix()
					if not isnull(rs("iptalSebep")) then
						Response.Write "<span class=""text-warning""><b>"&rs("iptalSebep")&"</b></span>"
					end if
						Response.Write "</em></font>"
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right border-right-0 p-0"">"
				Response.Write formatnumber(rs("miktar"),0) &" "& rs("birim")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right"">"
					Response.Write formatnumber(rs("arttirimMiktar"),0) & " " & rs("birim")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right"">"
					Response.Write formatnumber(rs("eksiltimMiktar"),0) & " " & rs("birim")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
				
					Response.Write "<table id=""isArttirKurumlar"" class=""isArttir"">"
					
			Response.Write "<thead><tr class=""text-center fontkucuk2 bg-gray-200"">"
			Response.Write "<th class=""align-middle p-0"" style=""width:1%"">"
			Response.Write "</th>"
			Response.Write "<th class=""align-middle p-0"">kurum</th>"
			Response.Write "<th class=""align-middle p-0"">miktar</th>"
			Response.Write "<th class=""align-middle p-0"">İş Arttırım miktar</th>"
			Response.Write "<th class=""align-middle p-0"">İş Eksiltim miktar</th>"
			Response.Write "</tr></thead>"
			Response.Write "<tbody>"
			
			sorgu2 = "SELECT iut.ihaleID, ISNULL(iut.iutArttirimMiktar,0) as iutArttirimMiktar, ISNULL(iut.iutEksiltimMiktar,0) as iutEksiltimMiktar, ISNULL(iut.miktar,0) as miktar, i.musteriID, i.cariID, iut.id as iutID, iut.carilerID, COALESCE(NULLIF(c.adKisa,''), c.ad) as cariAD"_
			&" FROM ihale_urun_talep iut INNER JOIN ihale i ON iut.ihaleID = i.id"_
			&" INNER JOIN cariler c ON iut.carilerID = c.id WHERE iut.ihaleUrunID = " & rs("ihaleUrunID") & " AND i.musteriID = " & musteriID
			rs2.open sorgu2,sbsv5,1,3
			
				if rs2.recordcount > 0 then
				for z = 1 to rs2.recordcount
					Response.Write "<tr>"
				Response.Write "<td class=""align-middle text-center"">"
				Response.Write "</td>"
						Response.Write "<td class=""align-left"">" & rs2("cariAD") & "</td>"
					Response.Write "<td class=""align-middle text-right"">"
						Response.Write formatnumber(rs2("miktar"),0) & " " & rs("birim")
					Response.Write "</td>"
					
'## iş arttırım miktarı
				classYaz = classbelirle("align-middle text-center border-right-0 p-0","",ihaleTipi,"","","","","","",miktarArttirimi,"","","")
				Response.Write "<td class="""&classYaz&""">"
					arttirMik = rs2("iutArttirimMiktar")
					if arttirMik = 0 then
						arttirMik = ""
						arttirbirim	= ""
					else
						arttirMik	= 	formatnumber(rs2("iutArttirimMiktar"),0)
						arttirbirim	=	rs("birim")
					end if
					call forminput("arttirimMiktar",arttirMik,"","","ajSave borderless text-right input50","","iutArttirimMiktar|"&rs2("iutID")&"|ihale_urun_talep","")
					Response.Write "&nbsp;"&arttirbirim
				Response.Write "</td>"
'## /iş arttırım miktarı

'## iş eksiltim miktarı
				classYaz = classbelirle("align-middle text-center border-right-0 p-0","",ihaleTipi,"","","","","","",miktarArttirimi,"","","")
				Response.Write "<td class="""&classYaz&""">"
					eksiltMik = rs2("iutEksiltimMiktar")
					if eksiltMik = 0 OR isnull(eksiltMik) then
						eksiltMik = ""
						eksiltbirim	= ""
					else
						eksiltMik	= 	formatnumber(rs2("iutEksiltimMiktar"),0)
						eksiltbirim	=	rs("birim")
					end if
					call forminput("eksiltimMiktar",eksiltMik,"","","ajSave borderless text-right input50","","iutEksiltimMiktar|"&rs2("iutID")&"|ihale_urun_talep","")
					Response.Write "&nbsp;"&eksiltbirim
				Response.Write "</td>"
'## /iş eksiltim miktarı
					Response.Write "</tr>"
					
	
					rs2.movenext
					next
					end if
					rs2.close
					
					
					Response.Write "</tbody></table>"
				Response.Write "</td>"
			Response.Write "</tr>"
			rs.movenext
			next
			rs.close
			Response.Write "</tbody></table>"
		Response.Write "</div>"'tab-pane
'##### /İŞ ARTTIRIMI
'##### /İŞ ARTTIRIMI

'##### ÜRÜNLER - 2 - 
'##### ÜRÜNLER - 2 -
	if instr(yetki,",18,") = 0 then'yetki_18
		Response.Write "<div class=""tab-pane"" id=""urunler2"" role=""tabpanel"">"
			Response.Write "<table id=""urunler2Tablo"" class=""table table-responsive table-bordered table-sm table-hover mt-3"">"
			
			Response.Write "<thead><tr class=""text-center bg-gray-200 p-0"">"
			
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
			Response.Write "<th class="""&classYaz&""" onMouseOver=""yardimYukle(79);"" data-yardim=""79"">Kısım No</th>"
			Response.Write "<th class=""align-middle"" onMouseOver=""yardimYukle(80);"" data-yardim=""80"">Sıra No</th>"
			Response.Write "<th class=""align-middle"" onMouseOver=""yardimYukle(81);"" data-yardim=""81"">Ürün Ad</th>"
			Response.Write "<th class=""align-middle"" onMouseOver=""yardimYukle(82);"" data-yardim=""82"">Barkod/UBB</th>"
			Response.Write "<th class=""align-middle"" onMouseOver=""yardimYukle(83);"" data-yardim=""83"">Ürün Ekle</th>"
			Response.Write "<th class=""align-middle"">Miktar</th>"
			Response.Write "</tr></thead><tbody>"
	
			sorgu = "Select iu.yaklasikMaliyet, iu.yerliOran, iu.iptalSebep, iu.iptal, iu.uhde, iu.firmamFiyat, iu.firmamParaBirim, iu.iskontoOran, iu.bayiAlis, iu.tavsiyeFiyat, iu.tavsiyeBirim, iu.grupNo, iu.siraNo, iu.fiyatOnay,"_
			&" ISNULL(iu.miktar,0) as miktar, iu.birim, ISNULL(iu.stoklarID,0) as stoklarID, iu.yaklasikMaliyetPB, iu.bayiMarj, iu.bayiAlisPB, iu.stoklarListeFiyat, iu.stoklarListeFiyatPB, s.listeFiyat, s.listeBirim,"_
			&" iu.id as ihaleUrunID, iu.ad as urunAd, s.ad as stoklarAD, i.id as ihaleID"_
			&" from ihale_urun iu INNER JOIN ihale i ON iu.ihaleID = i.id"_
			&" LEFT JOIN stoklar s ON iu.stoklarID = s.id"_
			&" WHERE i.musteriID = " & musteriID & " and ihaleID = " & id & " order by grupNo ASC, siraNo ASC"
			rs.open sorgu,sbsv5,1,3
			for i = 1 to rs.recordcount
			
			Response.Write "<tr class="""">"
				
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"gruptaVar","",rs("iptal"),rs("uhde"),"","","","","","")
				Response.Write "<td class="""&classYaz&""">"
					Response.Write rs("grupNo")
				Response.Write "</td>"
				
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"","",rs("iptal"),rs("uhde"),"","","","","","")
				Response.Write "<td class="""&classYaz&""">"
					Response.Write rs("siraNo")
				Response.Write "</td>"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","",rs("iptal"),"","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
					Response.Write rs("urunAd")
					Response.Write "<br>"
						if rs("stoklarID") > 0 then
							Response.Write "<a id="""&rs("ihaleUrunID")&"|ihale_urun"&"|stokKarsilik"" class=""btn ajSil text-muted p-0 m-0"" role=""button""><i class=""fa fa-trash-o p-0 m-0""></i></a>"
						end if
					Response.Write "<span class=""stokKarsilik fontkucuk2 text-info btn p-0 m-0"" onClick=""modalajax('','/dosya/detay_modal_urun.asp?ihaleID=" & rs("ihaleID") & "&id=" & rs("ihaleUrunID") & "&stoklarID=" & rs("stoklarID") & "');""><em id=""stoklarad"" class=""stoklarad" & rs("ihaleUrunID") & """>"
						if rs("stoklarID") = 0 OR isnull(rs("stoklarID")) then
							Response.Write "<i class=""fa fa-exclamation text-danger""> stok karşılığı seçilmemiş</i> <i class=""fa fa-exclamation text-danger""></i>"
						else
							Response.Write rs("stoklarAD")
						end if
						
					call clearfix()
					if not isnull(rs("iptalSebep")) then
						Response.Write "<span class=""text-warning""><b>"&rs("iptalSebep")&"</b></span>"
					end if
					Response.Write "</em></span>"
	
					Response.Write "<div>"
					sorgu = "SELECT iue.id as iueID, s.ad as stokAD FROM ihale_urun_ek iue INNER JOIN stoklar s ON iue.stoklarID = s.id WHERE iue.musteriID = " & musteriID & " AND iue.ihaleID = " & id & " AND iue.ihaleUrunID = " & rs("ihaleUrunID")
					rs2.open sorgu,sbsv5,1,3
						if rs2.recordcount > 0 then
							for vi = 1 to rs2.recordcount
							Response.Write "<span class=""fontkucuk2 text-muted p-0 m-0"">"
								Response.Write "<a id="""&rs2("iueID")&"|ihale_urun_ek"&""" class=""btn ajSil p-0 m-0"" role=""button""><i class=""fa fa-trash-o p-0 m-0""></i></a>"
								Response.Write rs2("stokAD")
							Response.Write "</span>"
							Response.Write "<div class=""clearfix m-0 p-0""></div>"
							rs2.movenext
							next
						end if
					rs2.close
					
					Response.Write "</div>"
				Response.Write "</td>"
				
				Response.Write "<td class="""">"
					sorgu = "SELECT sb.barkod FROM stoklar_barkod sb"_
					&" WHERE sb.musteriID = " & musteriID & " AND sb.stoklarID = " & rs("stoklarID") & " OR"_
					&" sb.stoklarID IN (SELECT iue.stoklarID FROM ihale_urun_ek iue WHERE iue.ihaleUrunID = " & rs("ihaleUrunID") & ") ORDER BY sb.stoklarID DESC"
					rs2.open sorgu,sbsv5,1,3
						if rs2.recordcount > 0 then
							for p = 1 to rs2.recordcount
								Response.Write rs2("barkod")&"<br>"
							rs2.movenext
							next
						end if
					rs2.close
				Response.Write "</td>"
	
				Response.Write "<td class=""p-0"">"
					call formselectv2("urunSecEkle","","","","urunSecEkle ajEkUrun","","urunEkle|"&rs("ihaleUrunID"),stoklardegerler,"")
				Response.Write "</td>"
				
				Response.Write "<td class=""align-middle text-center"">"
					Response.Write formatnumber(rs("miktar"),0)&" "&rs("birim")
				Response.Write "</td>"
			Response.Write "</tr>"
			rs.movenext
			next
			rs.close
			Response.Write "</tbody></table>"
		Response.Write "</div>"'tab-pane
	end if'yetki_18
'##### /ÜRÜNLER - 2 -
'##### /ÜRÜNLER - 2 -

'##### TOPLU ALIM
'##### TOPLU ALIM
	if instr(yetki,",19,") = 0 then'yetki_19
		Response.Write "<div class=""tab-pane"" id=""topluAlim"" role=""tabpanel"">"
		
			Response.Write "<table id=""topluAlimTablo"" class=""table table-responsive table-bordered table-sm mt-3 table-striped"">"
			
			Response.Write "<thead><tr class=""text-center bg-gray-200 p-0"">"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
			Response.Write "<th class="""&classYaz&""" style=""width:3%"" onMouseOver=""yardimYukle(79);"" data-yardim=""79"">Kısım No</th>"
			Response.Write "<th class=""align-middle"" style=""width:3%"" onMouseOver=""yardimYukle(80);"" data-yardim=""80"">Sıra No</th>"
			Response.Write "<th class=""align-middle"" style=""width:15%"" onMouseOver=""yardimYukle(85);"" data-yardim=""85"">Ürün Ad</th>"
			Response.Write "<th class=""align-middle"" style=""width:5%"" colspan=""2"">Miktar</th>"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","","","",yaklasikMalGoster,"","","","","")
			Response.Write "<th class="""&classYaz&""" style=""width:5%"" colspan=""2"">Yaklaşık Maliyet</th>"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","","","","",yerliOranGoster,"","","","")
			Response.Write "<th class="""&classYaz&""" style=""width:3%"">Yerli Oran</th>"
			Response.Write "<th class=""align-middle"" style=""width:40%"">"
			Response.Write "<div class=""text-left""><a class="" p-0 m-0 btn"" onMouseOver=""yardimYukle(84);"" data-yardim=""84"" onclick=""$('.aktarKurum').slideToggle('slow');""><i class=""fa fa-angle-double-right""></i></a></div>"
			Response.Write "<div class=""text-center"">Kurumlar</div>"
			Response.Write "</th>"
			Response.Write "</tr></thead><tbody>"
	
			sorgu = "Select iu.yaklasikMaliyet, iu.yerliOran, iu.iptalSebep, iu.iptal, iu.firmamFiyat, iu.firmamParaBirim, iu.iskontoOran, iu.bayiAlis, iu.tavsiyeFiyat, iu.tavsiyeBirim, iu.uhde,"_
			&" iu.grupNo, iu.siraNo, ISNULL(iu.miktar,0) as miktar, iu.birim, iu.stoklarID, iu.yaklasikMaliyetPB, iu.firmamFiyatiptal,"_
			&" s.listeFiyat, s.listeBirim, marka.marka, fir.adKisa, fir.adUzun,"_
			&" iu.id as ihaleUrunID, iu.ad as urunAd, i.id as ihaleID, i.firmaID, s.ad as stoklarAD"_
			&" from ihale_urun iu INNER JOIN ihale i ON iu.ihaleID = i.id"_
			&" LEFT JOIN stoklar s ON iu.stoklarID = s.id"_
			&" LEFT JOIN marka ON s.markaID = marka.id"_
			&" LEFT JOIN firmalar fir ON i.firmaID = fir.id"_
			&" WHERE iu.uhde = 'True' AND i.musteriID = " & musteriID & " and i.id = " & id & " order by grupNo ASC, siraNo ASC"
			rs.open sorgu,sbsv5,1,3

			for i = 1 to rs.recordcount
			Response.Write "<tr>"
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"gruptaVar","",rs("iptal"),rs("uhde"),"","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("grupNo")
				Response.Write "</td>"
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"","",rs("iptal"),rs("uhde"),"","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("siraNo")
				Response.Write "</td>"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","",rs("iptal"),"","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("urunAd")
						Response.Write "<br><span class=""stokKarsilik fontkucuk2 text-info""><em>"
					if rs("stoklarID") = 0 OR isnull(rs("stoklarID")) then
						Response.Write "<i class=""fa fa-exclamation text-danger""> stok karşılığı seçilmemiş</i> <i class=""fa fa-exclamation text-danger""></i>"
					else
						Response.Write rs("stoklarAD")
					end if
					call clearfix()
					if not isnull(rs("iptalSebep")) then
						Response.Write "<span class=""text-warning""><b>"&rs("iptalSebep")&"</b></span>"
					end if
						Response.Write "</em></font>"
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right border-right-0 p-0"">"
				Response.Write formatnumber(rs("miktar"),0)
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-left border-left-0 p-0 pl-1"">"
				Response.Write rs("birim")
				Response.Write "</td>"
		classYaz = classbelirle("align-middle text-right border-right-0 p-0",kisimIhale,ihaleTipi,"","","","",yaklasikMalGoster,"","","","","")
				Response.Write "<td class="""&classYaz&""">"
					para_deger = para_basamak(rs("yaklasikMaliyet"))
				Response.Write para_deger
				Response.Write "</td>"
		classYaz = classbelirle("align-middle border-left-0 p-0 pl-1",kisimIhale,ihaleTipi,"","","","",yaklasikMalGoster,"","","","","")
				Response.Write "<td class="""&classYaz&""">"
					Response.Write rs("yaklasikMaliyetPB")
				Response.Write "</td>"
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"","","","","",yerliOranGoster,"","","","")
				Response.Write "<td class="""&classYaz&""">"
							Response.Write rs("yerliOran")
						if rs("yerliOran") > 0 then
							Response.Write " %"
						end if
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
				
					Response.Write "<table id=""topluAlimKurumlar"" class=""topluAlim"">"
					
			Response.Write "<thead><tr class=""text-center fontkucuk2 bg-gray-200"">"
			Response.Write "<th class=""align-middle p-0"" style=""width:1%"">"
	Response.Write "<span class=""fontkucuk2 text-danger btn p-0"" onClick=""modalajax('','/dosya/detay_modal_cari.asp?kayitTip=topluAlim&id=" & rs("ihaleUrunID") & "&ihaleID=" & rs("ihaleID") & "&firmamID=" & rs("firmaID") & "');""><em class=""rakipEkle"">kurum ekle</em></span>"
	Response.Write "<br>"
	Response.Write "<span class=""fontkucuk2 text-danger btn p-0"" onClick=""modalajaxfit('','/dosya/aktarim_modal_tarihce.asp?ihaleUrunID=" & rs("ihaleUrunID") & "&ihaleID=" & rs("ihaleID") & "');""><em class=""rakipEkle"">aktarım geçmişi</em></span>"
			Response.Write "</th>"
			Response.Write "<th class=""align-middle p-0"">kurum</th>"
			Response.Write "<th class=""align-middle p-0"" colspan=""2"">miktar</th>"
			Response.Write "<th class=""align-middle aktarKurum def-kapali p-0"">Aktarılacak Kurum</th>"
			Response.Write "<th class=""align-middle aktarKurum def-kapali p-0"">Aktarılacak miktar</th>"
			Response.Write "<th class=""align-middle aktarKurum def-kapali p-0""></th>"
			Response.Write "</tr></thead>"
			Response.Write "<tbody>"
			
			sorgu2 = "SELECT iut.ihaleID, (ISNULL(iut.miktar,0) + ISNULL(iut.iutArttirimMiktar,0) - ISNULL(iut.iutEksiltimMiktar,0)) as miktar, i.musteriID, i.cariID, iut.id as iutID, iut.carilerID, COALESCE(NULLIF(c.adKisa,''), c.ad) as cariAD"_
			&" FROM ihale_urun_talep iut INNER JOIN ihale i ON iut.ihaleID = i.id"_
			&" INNER JOIN cariler c ON iut.carilerID = c.id WHERE iut.ihaleUrunID = " & rs("ihaleUrunID") & " AND i.musteriID = " & musteriID
			rs2.open sorgu2,sbsv5,1,3
			
				if rs2.recordcount > 0 then
				for z = 1 to rs2.recordcount
					Response.Write "<tr>"
				Response.Write "<td class=""align-middle text-center"">"
					if rs2("carilerID") <> rs2("cariID") then
						Response.Write "<a id="""&rs2("iutID")&"|ihale_urun_talep"&""" class=""btn ajSil"" role=""button""><i class=""fa fa-trash-o""></i></a>"
					end if
				Response.Write "</td>"
						Response.Write "<td class=""align-left"">" & rs2("cariAD") & "</td>"
					Response.Write "<td class=""align-middle text-right"">"
						Response.Write formatnumber(rs2("miktar"),0) & " " & rs("birim")
					Response.Write "</td>"
					
		'##### DOSYADAKİ CARİLERİ ÇEK
		'##### DOSYADAKİ CARİLERİ ÇEK
					sorgu3 = "Select c.ad as cariAD, c.id as cariID from ihale_urun_talep iut INNER JOIN cariler c ON iut.carilerID = c.id WHERE iut.ihaleUrunID = " & rs("ihaleUrunID") & " AND iut.musteriID = " & musteriID
					rs3.open sorgu3,sbsv5,1,3
	
						degerler = "=|"
						for t = 1 to rs3.recordcount
							degerler = degerler & rs3("cariAD")
							degerler = degerler & "="
							degerler = degerler & rs3("cariID")
							degerler = degerler & "|"
						rs3.movenext
						next
						if degerler = "" then
						else
							degerler = left(degerler,len(degerler)-1)
						end if
					rs3.close
					Tcarilerdegerler = degerler
					
		'##### /DOSYADAKİ CARİLERİ ÇEK
		'##### /DOSYADAKİ CARİLERİ ÇEK
					Response.Write "<td class=""def-kapali aktarKurum p-0"">"
						Response.Write "<input type=""hidden"" name=""ihaleID"" value=""" & rs("ihaleID") & """ />"
						Response.Write "<input type=""hidden"" name=""ihaleUrunID"" value=""" & rs("ihaleUrunID") & """ />"
						
									call formselectv2("deger","","","","carisec"&rs2("iutID")&" btn btn-xs fontkucuk2","","degermodal"&rs2("iutID")&"",Tcarilerdegerler,"")
						
					Response.Write "</td>"
					Response.Write "<td class=""def-kapali aktarKurum"">"
						call forminput("miktar","","","Miktar","btn-sm","","miktar"&rs2("iutID")&"","")
					Response.Write "</td>"
					Response.Write "<td class=""def-kapali aktarKurum"">"
								Response.Write "<button class=""btn btn-sm form-control btn-success ajAktar rounded"" id="""&rs("ihaleID")&"|"&rs("ihaleUrunID")&"|"&rs2("iutID")&"|"&rs2("carilerID")&""">Aktar</button>"
					Response.Write "</td>"
					Response.Write "</tr>"
					
	
					rs2.movenext
					next
					end if
					rs2.close
					
					
					Response.Write "</tbody></table>"
				Response.Write "</td>"
			Response.Write "</tr>"
			rs.movenext
			next
			rs.close
			Response.Write "</tbody></table>"
		Response.Write "</div>"'tab-pane
	end if'yetki_19
'##### /TOPLU ALIM
'##### /TOPLU ALIM

'##### RAKİPLER
'##### RAKİPLER
	if instr(yetki,",20,") = 0 then'yetki_20
		Response.Write "<div class=""tab-pane"" id=""rakipler"" role=""tabpanel"">"
		
			Response.Write "<table id=""rakiplerTablo"" class=""table table-responsive table-bordered table-sm mt-3"">"
			
			Response.Write "<thead><tr class=""text-center bg-gray-200 p-0"">"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
			Response.Write "<th class="""&classYaz&""" style=""width:3%"" onMouseOver=""yardimYukle(79);"" data-yardim=""79"">Kısım No</th>"
			Response.Write "<th class=""align-middle"" style=""width:3%"" colspan=""2"" onMouseOver=""yardimYukle(80);"" data-yardim=""80"">Sıra No</th>"
			Response.Write "<th class=""align-middle"" style=""width:15%"" onMouseOver=""yardimYukle(85);"" data-yardim=""85"">Ürün Ad</th>"
			Response.Write "<th class=""align-middle"" style=""width:5%"" colspan=""2"">Miktar</th>"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","","","",yaklasikMalGoster,"","","","","")
			Response.Write "<th class="""&classYaz&""" style=""width:5%"" onMouseOver=""yardimYukle(71);"" data-yardim=""71"">Yaklaşık Maliyet</th>"
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","","","","",yerliOranGoster,"","","","")
			Response.Write "<th class="""&classYaz&""" style=""width:3%"" onMouseOver=""yardimYukle(72);"" data-yardim=""72"">Yerli Oran</th>"
			Response.Write "<th class=""align-middle"" style=""width:40%"">"
			
			
			
			Response.Write "<button class=""btn btn-primary pull-left p-0 rounded"" type=""button"" onClick=""modalajax('','/cari/yeni.asp?id=" & firmasec & "')"">Rakip Cari Ekle</button>"
			if isnull(kararTarih) then
				butonAD		=	"Mukayese Gönder"
				butonClass 	=	"bg-warning"
				mailTip		=	"mukayese"
			else
				butonAD		=	"Karar Gönder"
				butonClass 	=	"bg-danger"
				mailTip		=	"karar"
			end if
			Response.Write "<button class=""btn pull-left p-0 ml-2 " & butonClass & " rounded"" type=""button"" onClick=""modalajax('','/dosya/mailMukayeseAliciSec.asp?mailTip="&mailTip&"&ihaleID=" & id & "')"">" & butonAD & "</button>"
			call clearfix()
			Response.Write "<i class=""fa fa-question-circle fa-lg pull-left mt-1"" onMouseOver=""yardimYukle(86);"" data-yardim=""86"" aria-hidden=""true""></i>"
			Response.Write "Rakipler</th>"
			Response.Write "</tr></thead><tbody>"
	
			sorgu = "Select iu.yaklasikMaliyet, iu.iptal, iu.yerliOran,iu.iptalSebep, iu.firmamFiyat, iu.firmamParaBirim, iu.iskontoOran, iu.bayiAlis, iu.tavsiyeFiyat,"_
			&" iu.tavsiyeBirim, iu.firmamMarka, iu.uhde, COALESCE(NULLIF(fir.adKisa,''), fir.adUzun) as firmamAD, i.bayiKurumID, COALESCE(NULLIF(c.adKisa,''), c.ad) as bayiAD,"_
			&" iu.grupNo, iu.siraNo, ISNULL(iu.miktar,0) as miktar, iu.birim, iu.stoklarID, iu.yaklasikMaliyetPB, iu.firmamFiyatiptal, iu.firmamYerliMali,"_
			&" s.listeFiyat, s.listeBirim, s.ubbKod, m.marka, fir.adKisa, i.tarih_ihale, i.firmaID, i.ihaleTipi, ISNULL(iu.pazarlik_ilkFiyat,0) as pazarlik_ilkFiyat,s2.ubbKod as TMTubbKod,"_
			&" iu.id as ihaleUrunID, iu.ad as urunAd, i.id as ihaleID, s.ad as stoklarAD"_
			&" from ihale_urun iu INNER JOIN ihale i ON iu.ihaleID = i.id"_
			&" LEFT JOIN stoklar s ON iu.stoklarID = s.id"_
			&" LEFT JOIN (SELECT muhStokKod, ubbKod FROM stoklar WHERE firmalarID = 2) AS s2 ON s.muhStokKod = s2.muhStokKod"_
			&" LEFT JOIN marka m ON s.markaID = m.id"_
			&" LEFT JOIN firmalar fir ON i.firmaID = fir.id"_
			&" LEFT JOIN cariler c ON i.bayiKurumID = c.id"_
			&" WHERE i.musteriID = " & musteriID & " and ihaleID = " & id & " order by grupNo ASC, siraNo ASC"
			rs.open sorgu,sbsv5,1,3
			
			for i = 1 to rs.recordcount
			
			
			
			Response.Write "<tr>"
		classYaz = classbelirle("align-middle text-center p-0",kisimIhale,ihaleTipi,"gruptaVar","",rs("iptal"),rs("uhde"),"","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("grupNo")
				Response.Write "</td>"
		classYaz = classbelirle("align-middle text-center p-0 m-0",kisimIhale,ihaleTipi,"","",rs("iptal"),rs("uhde"),"","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("siraNo")

				Response.Write "</td>"
				Response.Write "<td class="""&classYaz&""">"
					Response.Write "<a id="""&rs("ihaleUrunID")&"|ihale_urun"" class=""btn ajUruniptal p-0"""
					if rs("iptal") = "False" then
						Response.Write " onclick=""modalajax('','/dosya/detay_modal_iptalSebep.asp?ihaleID=" & rs("ihaleID") & "&id=" & rs("ihaleUrunID") &  "');"""
					end if
					Response.Write " role=""button"" data-toggle=""tooltip"" data-placement=""top"" title=""Kalem iptal edilmişse""><i class=""fa fa-ban""></i></a>"
					Response.Write "</td>"
		classYaz = classbelirle("align-middle p-0",kisimIhale,ihaleTipi,"","",rs("iptal"),"","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("urunAd")
						Response.Write "<br><span class=""stokKarsilik fontkucuk2 text-info""><em>"
					if rs("stoklarID") = 0 OR isnull(rs("stoklarID")) then
						Response.Write "<i class=""fa fa-exclamation text-danger""> stok karşılığı seçilmemiş</i> <i class=""fa fa-exclamation text-danger""></i>"
					else
						Response.Write rs("stoklarAD")
					end if
					call clearfix()
					if not isnull(rs("iptalSebep")) then
						Response.Write "<span class=""text-warning""><b>"&rs("iptalSebep")&"</b></span>"
					end if
						Response.Write "</em></font>"
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right border-right-0 p-0"">"
				Response.Write formatnumber(rs("miktar"),0)
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-left border-left-0 p-0 pl-1"">"
				Response.Write rs("birim")
				Response.Write "</td>"
'######yaklaşık maliyet
		classYaz = classbelirle("align-middle text-right border-right-0 pr-0",kisimIhale,ihaleTipi,"","","","",yaklasikMalGoster,"","","","","")
		classYaz2 = classbelirle2(classYaz,rs("ihaleUrunID"),"ihale_urun","YMiptalkontrol","","")
				Response.Write "<td class="""&classYaz2&""">"
					para_deger = para_basamak(rs("yaklasikMaliyet"))
					call forminput("yaklasikMaliyet",para_deger,"","","ajSave borderless para text-right input50","","yaklasikMaliyet|"&rs("ihaleUrunID")&"|ihale_urun","")
					Response.Write "<div class=""text-left""> &nbsp;" & rs("yaklasikMaliyetPB") & "</div>"
					call clearfix
					Response.Write "<div data-iuID=""" & rs("ihaleUrunID") & """ class=""YMiptal pointer text-center""><i class=""fa fa-ban""></i></div>"
				Response.Write "</td>"
'######yaklaşık maliyet
		classYaz = classbelirle("align-middle text-center p-0",kisimIhale,ihaleTipi,"","","","","",yerliOranGoster,"","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("yerliOran")
				if rs("yerliOran") > 0 then
					Response.Write " %"
				end if
				Response.Write "</td>"
				Response.Write "<td class=""align-middle p-0"">"
				
					Response.Write "<table class=""rakipFiyat table container-fluid"">"
					
			Response.Write "<thead><tr class=""rakipBaslik text-center fontkucuk2 bg-gray-200 p-0 d-flex"">"
			Response.Write "<th class=""align-middle p0 col-1"">"
			Response.Write "</th>"
			Response.Write "<th class=""align-middle p-0 col-2"">firma</th>"
			Response.Write "<th class=""align-middle p-0 col-1"">marka</th>"
			Response.Write "<th class=""align-middle p-0 col-1"">UBB</th>"
		classYaz = classbelirle("align-middle p-0 col-1","",ihaleTipi,"gruptaVar","","","","",yerliOranGoster,"","","","")
			Response.Write "<td class="""&classYaz&""">yerli oran</th>"
			Response.Write "<th class=""align-middle p-0 col-2"">fiyat</th>"
			Response.Write "<th class=""align-middle p-0 col-1"">% fark</th>"
			Response.Write "<th class=""align-middle p-0 col-1"">USD</th>"
			Response.Write "<th class=""align-middle p-0 col-1"">EUR</th>"
			Response.Write "</tr></thead>"
			Response.Write "<tbody>"
	
					Response.Write "<tr class=""d-flex"">"
					Response.Write "<td class=""text-center p0 col-1"">"
	Response.Write "<span class=""fontkucuk2 text-danger btn"" onClick=""modalajax('','/dosya/detay_modal_cari.asp?kayitTip=rakipCari&id=" & rs("ihaleUrunID") & "&ihaleID=" & rs("ihaleID") & "&firmamID=" & rs("firmaID") & "');""><em class=""rakipEkle"">rakip ekle</em></span>"
						Response.Write "<br>"
						
						Response.Write "<a id="""&rs("ihaleUrunID")&"|ihale_urun|0|uhde"" class=""btn ajUhde p-0"" role=""button""><i class=""fa fa-check-circle-o""></i></a>"
						Response.Write "<a id="""&rs("ihaleUrunID")&"|ihale_urun|0|fiyatiptal"" class=""btn ajFiyatiptal p-0 pl-3"" role=""button""><i class=""fa fa-ban""></i></a>"
					Response.Write "</td>"
						Response.Write "<td class=""align-middle p-0 col-2"
						if rs("uhde") = "True" then
							Response.Write " bg-warning"
						elseif rs("firmamFiyatiptal") = "True" then
							Response.Write " bg-fiyatiptal"
						end if
						Response.Write """>"
						Response.Write "<span title="""&rs("firmamAD")&""">"&left(rs("firmamAD"),25)&"</span>"
						if len(rs("firmamAD")) > 25 then
							Response.Write "..."
						end if
						
						call clearfix()
						if rs("bayiKurumID") > 0 then
							response.Write "Bayi : "& rs("bayiAD")
						end if
						Response.Write "</td>"
					Response.Write "<td class=""text-center align-middle p-0 col-1"">"
						Response.Write rs("marka")
					Response.Write "</td>"
					Response.Write "<td class=""text-center align-middle p-0 col-1 fontkucuk2"">"
						Response.Write rs("TMTubbKod")
					Response.Write "</td>"
					
'####### Firmama ait yerli malı belgesi var mı
					sorgu = "SELECT SUM(CONVERT(INT, yerliMali)) as rakipYerli FROM fiyatlar WHERE musteriID = " & musteriID & " and ihaleID = " & id & " AND ihaleUrunID = " & rs("ihaleUrunID")
					rs2.open sorgu,sbsv5,1,3
					
					RakipYerliOranVar	= rs2("rakipYerli")
					rs2.close
		classYaz = classbelirle("align-middle text-center p-0 col-1","",ihaleTipi,"gruptaVar","","","","",yerliOranGoster,"","","","")
					Response.Write "<td class="""&classYaz&""">"
						if rs("firmamYerliMali") = "True" then
							firmamYerliMali = 1
						else
							firmamYerliMali = 0
						end if
	
						call formselectv2("firmamYerliMali",firmamYerliMali,"","","ajSave borderless text-center btn p-0 okKaldir","","firmamYerliMali|"&rs("ihaleUrunID")&"|ihale_urun",yerliMaliDegerler,"")
					Response.Write "</td>"
'####### /Firmama ait yerli malı belgesi var mı

'####### Firmam fiyat ve Yerli malı var ise yerli malı avantajı uygulaması
					Response.Write "<td class=""text-right align-middle border-right-0 p-0 col-2"">"
						YerliEkleFirmamFiyat	=	0
						classListe 				=	"text-right "
						if rs("yerliOran") > 0 AND RakipYerliOranVar > 0 AND rs("firmamYerliMali") = "False" then
							'classListe 			= 	classListe & " ustunuCiz"
							classListe 			= 	classListe & " text-danger font-weight-bold"
							YerliEkleFirmamFiyat =	rs("firmamFiyat") + (rs("firmamFiyat")*(rs("yerliOran")/100))
						end if
						firmamFiyat	=	para_basamak(rs("firmamFiyat"))
						pazarlik_ilkFiyat = para_basamak(rs("pazarlik_ilkFiyat"))

						Response.Write "<span class="""&classListe&""">"&firmamFiyat&" "& rs("firmamParaBirim") & "</span>"
						YerliEkleFirmamFiyat = para_basamak(YerliEkleFirmamFiyat)
						if rs("yerliOran") > 0 AND RakipYerliOranVar > 0 AND rs("firmamYerliMali") = "False" then
						call clearfix()
							Response.Write "<i class=""text-success fontkucuk2"">(" & firmamFiyat & "+%"&rs("yerliOran")&") "&YerliEkleFirmamFiyat & rs("firmamParaBirim")&"</i>"
						end if
						if rs("ihaleTipi") = "pazarlik" then
							call clearfix()
							Response.Write "<span class=""rounded-circle bg-info text-center mr-1"">&nbsp;1&nbsp;</span>"
							Response.Write "<span class="""&classListe&""">"&pazarlik_ilkFiyat&" "& rs("firmamParaBirim") & "</span>"
						end if
					Response.Write "</td>"
'####### /Firmam fiyat ve Yerli malı var ise yerli malı avantajı uygulaması
					
					' Response.Write "<td class=""align-middle border-left-0 p-0 pl-1 col-1"">"
					' Response.Write "</td>"
					Response.Write "<td class=""col-1"">"
					Response.Write "</td>"
					
					
					Response.Write "<td class=""text-center align-middle p-0 col-1"">"
					if USDkur > 0 then
						USDfiyat	=	para_basamak(rs("firmamFiyat")/USDkur) 
					else
						USDfiyat = "--"
					end if
						Response.Write USDfiyat
					Response.Write "</td>"
					Response.Write "<td class=""text-center align-middle p-0 col-1"">"
					if EURkur > 0 then
						EURfiyat	=	para_basamak(rs("firmamFiyat")/EURkur) 
					else
						EURfiyat = "--"
					end if
						Response.Write EURfiyat
					Response.Write "</td>"
					Response.Write "</tr>"
					
	
					sorgu2 = "SELECT fiy.id as fiyatID, fiy.fiyat, ISNULL(fiy.pazarlik_ilkFiyat,0) as pazarlikRakip_ilkFiyat, fiy.fiyatPB, fiy.ubb, COALESCE(NULLIF(c.adKisa,''),c.ad) as ad, fiy.marka, fiy.uhde, fiy.fiyatiptal, fiy.yerliMali"_
					&" FROM fiyatlar fiy INNER JOIN cariler c ON fiy.carilerID = c.id"_
					&" WHERE fiy.musteriID = " & musteriID & " and fiy.ihaleID = " & id & " AND fiy.ihaleUrunID = " & rs("ihaleUrunID") & ""
					rs2.open sorgu2,sbsv5,1,3
					
					sorgu3 = "SELECT * FROM fiyatlar WHERE musteriID = " & musteriID & " AND yerliMali = 'True' AND ihaleUrunID = " & rs("ihaleUrunID") & " AND ihaleID = " & id
					rs3.open sorgu3,sbsv5,1,3
					
					if rs3.recordcount > 0 then
						RakipYerliOranVar = 1
					else
						RakipYerliOranVar = 0
					end if
					rs3.close
					
					if rs2.recordcount > 0 then
					for z = 1 to rs2.recordcount
					
		'### rakip fiyatlar listele
		'### rakip fiyatlar listele
		
				Response.Write "<tr class=""d-flex"">"
					Response.Write "<td class=""text-center align-middle p-0 col-1"">"
						Response.Write "<div class=""btn-group"" role=""group"" aria-label=""First group"">"
						Response.Write "<a id="""&rs2("fiyatID")&"|fiyatlar"&""" class=""btn ajSil p-0"" role=""button""><i class=""fa fa-trash-o""></i></a>"
						Response.Write "<a id="""&rs2("fiyatID")&"|fiyatlar|"&rs("ihaleUrunID")&"|uhde"" class=""btn ajUhde p-0 pl-2 pr-2"" role=""button""><i class=""fa fa-check-circle-o""></i></a>"
						Response.Write "<a id="""&rs2("fiyatID")&"|fiyatlar|"&rs("ihaleUrunID")&"|fiyatiptal"" class=""btn ajFiyatiptal p-0"" role=""button""><i class=""fa fa-ban""></i></a>"
						Response.Write "</div>"
					Response.Write "</td>"
					Response.Write "<td class=""align-middle col-2"
						if rs2("uhde") = "True" then
							Response.Write " bg-warning"
						elseif rs2("fiyatiptal") = "True" then
							Response.Write " bg-fiyatiptal"
						end if
						Response.Write """>"
						Response.Write "<span title="""&rs2("ad")&""">"&left(rs2("ad"),15)&"</span>"
						if len(rs2("ad")) > 15 then
							Response.Write "..."
						end if
					Response.Write "</td>"
'####### rakip marka			
					Response.Write "<td class=""text-center align-middle  p-0 col-1"">"
							call forminput("marka",rs2("marka"),"","","ajSave borderless text-center","","marka|"&rs2("fiyatID")&"|fiyatlar","")
					Response.Write "</td>"
'####### /rakip marka

'####### rakip ubb
					Response.Write "<td class=""text-center align-middle  p-0 col-1"">"
							call forminput("ubb",rs2("ubb"),"","","ajSave borderless text-center","","ubb|"&rs2("fiyatID")&"|fiyatlar","")
					Response.Write "</td>"
'####### /rakip ubb

'####### rakip yerli belgesi var mı?
		classYaz = classbelirle("align-middle text-center p-0 col-1","",ihaleTipi,"gruptaVar","","","","",yerliOranGoster,"","","","")
						Response.Write "<td class="""&classYaz&""">"
						if rs2("yerliMali") = "True" then
							yerliMali = 1
						else
							yerliMali = 0
						end if
	
						call formselectv2("yerliMali",yerliMali,"","","ajSave borderless text-center btn p-0 okKaldir","","yerliMali|"&rs2("fiyatID")&"|fiyatlar",yerliMaliDegerler,"")
						Response.Write "</td>"
'####### /rakip yerli belgesi var mı?

'####### rakip fiyat
						Response.Write "<td class=""align-middle text-right border-right-0 p-0 col-2"">"
							classListe = "ajSave borderless text-right"
							YerliEkleFiyatRakip	=	0
							if rs2("fiyat") > 0 then
								if rs("yerliOran") > 0 AND (RakipYerliOranVar = 1 OR rs("firmamYerliMali") = "True") AND rs2("yerliMali") = "False" then
									'classListe 			= 	classListe & " ustunuCiz"
									classListe 			= 	classListe & " text-danger font-weight-bold"
									YerliEkleFiyatRakip =	rs2("fiyat") + (rs2("fiyat")*(rs("yerliOran")/100))
								end if
							end if
								fiyatRakip 				= 	para_basamak(rs2("fiyat"))
								pazarlikRakip_ilkFiyat	=	para_basamak(rs2("pazarlikRakip_ilkFiyat"))
								
								Response.Write "<div class=""d-flex"">"
									call forminput("fiyatRakip",fiyatRakip,"","",classListe,"","fiyat|"&rs2("fiyatID")&"|fiyatlar","")
									call formselectv2("fiyatRakipPB",rs2("fiyatPB"),"","","ajSave borderless text-left p-0 okKaldir input30","","fiyatPB|"&rs2("fiyatID")&"|fiyatlar",paraBirimDegerler,"")
								Response.Write "</div>"
								
								YerliEkleFiyatRakip	= para_basamak(YerliEkleFiyatRakip)
							if rs2("fiyat") > 0 then
								if rs("yerliOran") > 0 AND rs2("yerliMali") = "False" AND (RakipYerliOranVar = 1 OR rs("firmamYerliMali") = "True") then
									Response.Write "<div class=""text-success fontkucuk2 m-0 p-0"">(" & fiyatRakip & "+%" & rs("yerliOran")&") " & YerliEkleFiyatRakip & rs2("fiyatPB")&"</div>"
								end if
							end if
							if rs("ihaleTipi") = "pazarlik" then
								Response.Write "<div class=""d-flex"">"
									call forminput("fiyatRakip",pazarlikRakip_ilkFiyat,"","",classListe,"","pazarlik_ilkFiyat|"&rs2("fiyatID")&"|fiyatlar","")
									call formselectv2("fiyatRakipPB",rs2("fiyatPB"),"","","ajSave borderless text-left p-0 okKaldir input30","","fiyatPB|"&rs2("fiyatID")&"|fiyatlar",paraBirimDegerler,"")
								Response.Write "</div>"
							end if
						Response.Write "</td>"
'####### /rakip fiyat
						
					Response.Write "<td class=""text-center align-middle p-0 col-1"">"
					if rs2("fiyat") > 0 AND rs("firmamFiyat") > 0 then
					yuzdeOran = (rs2("fiyat") - rs("firmamFiyat")) / rs("firmamFiyat")
					else
					yuzdeOran = 0
					end if
					Response.Write formatPercent(yuzdeOran,2)
					Response.Write "</td>"
					
					Response.Write "<td class=""text-center align-middle p-0 col-1"">"
					if USDkur > 0 then
						rakipUSDfiyat	=	para_basamak(rs2("fiyat")/USDkur)
					else
						rakipUSDfiyat	= "--"
					end if
						Response.Write rakipUSDfiyat
					Response.Write "</td>"
					Response.Write "<td class=""text-center align-middle p-0 col-1"">"
					if EURkur > 0 then
						rakipEURfiyat	=	para_basamak(rs2("fiyat")/EURkur)
					else
						rakipEURfiyat	= "--"
					end if
						Response.Write rakipEURfiyat
					Response.Write "</td>"
					
					Response.Write "</tr>"
					rs2.movenext
					next
					end if
					rs2.close
					
					
					Response.Write "</tbody></table>"
				Response.Write "</td>"
			Response.Write "</tr>"
			rs.movenext
			next
			rs.close
			Response.Write "</tbody></table>"
		Response.Write "</div>"'tab-pane
	end if'yetki_20
'##### /RAKİPLER
'##### /RAKİPLER

'##### TEMİNAT
'##### TEMİNAT
	if instr(yetki,",15,") = 0 then'yetki_15
		Response.Write "<div class=""tab-pane"" id=""teminat"" role=""tabpanel"">"
		
	Response.Write "<form class=""ajaxform"" action=""/dosya/teminat_kaydet.asp"">"
	Response.Write "<input type=""hidden"" name=""ihaleID"" value=" & id & " />"
		
		Response.Write "<div id=""teminatInput"" class="""">"
		
		Response.Write "<div class=""container row"">"
		
			Response.Write "<div class=""col-lg-3"">"
			Response.Write "<label class=""badge"">Teminat Tür Seçimi</label>"
				call formselectv2("teminatTurSec","","","","teminatTurSec","","",teminatTurDegerler,"")
			Response.Write "</div>"
			
			Response.Write "<div class=""col-lg-2"">"
			Response.Write "<label class=""badge"">Banka/Nakit Seçimi</label>"
				call formselectv2("bankaNakitSec","","if($(this).val()==0){$('#divBankaSec').removeClass('d-none')};if($(this).val()==1){$('#divBankaSec').addClass('d-none');};","","bankaNakitSec p-0","","",bankaNakitDegerler,"")
			Response.Write "</div>"
			
			Response.Write "<div id=""divBankaSec"" class=""col-lg-5 d-none"">"
			Response.Write "<label class=""badge"">Banka Seçimi</label>"
				call formselectv2("bankasec","","","","bankasec p-0","","",bankalarDegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""container row"">"
			Response.Write "<div class=""col-lg-2 mt-2"">"
			Response.Write "<label class=""badge"">Teminat Tarihi</label>"
			call forminput("tarih_teminat",tarih_teminat,"","Teminat Tarihi","tarih","","tarih_teminat","AutCompOff")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-2 mt-2"">"
			Response.Write "<label class=""badge"">Geçerlilik Tarihi</label>"
			call forminput("tarih_exp",tarih_exp,"","Geçerlilik Tarihi","tarih","","tarih_exp","AutCompOff")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-2 mt-2"">"
			Response.Write "<label class=""badge"">Teminat Referans No</label>"
			call forminput("no",no,"","Referans No","","","no","")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-2 mt-2 p-0"">"
			Response.Write "<label class=""badge"">Tutar</label>"
			call forminput("tutar",tutar,"","Tutar","text-right border-right-0","","tutar","")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-1 mt-2 p-0"">"
			Response.Write "<label class=""badge"">Para Birimi</label>"
				call formselectv2("teminatPB","","","","border-left-0 p-0","","",paraBirimDegerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-2 mt-2"">"
			Response.Write "<label class=""badge"">İade Tarihi</label>"
			call forminput("tarih_iade",tarih_iade,"","İade Tarihi","tarih","","tarih_iade","AutCompOff")
			Response.Write "</div>"
		Response.Write "</div>"
				
				Response.Write "<div class=""col-lg-12 mt-3"">"
				Response.Write "<button name=""teminat"" class=""kaydet btn-block btn-primary"" type=""submit"" onClick=""$('#tip').val('teminat');"">kaydet</button>"
		Response.Write "</div>"'teminatInput
		Response.Write "</div>"
		
	Response.Write "</form>"
		
		
			Response.Write "<table id=""teminatTablo"" class=""table table-responsive table-bordered table-sm table-hover mt-3"">"
			
			Response.Write "<thead>"
			Response.Write "<tr class=""text-center bg-gray-200 p-0 align-middle""><th class=""align-middle p-0"">"
			Response.Write "<label class=""switch switch-lg switch-text switch-success"">"
				Response.Write "<input id=""teminatSwitch"" type=""checkbox"" class=""switch-input"" checked onclick=""$('#teminatInput').toggle('slow');"">"
				Response.Write "<span class=""switch-label"" data-on=""✓"" data-off=""X"">"
				Response.Write "</span>"
				Response.Write "<span class=""switch-handle""></span>"
			Response.Write "</label>"
			Response.Write "</th>"
			Response.Write "<th class=""align-middle w-5 p-0"">Teminat Tür</th>"
			Response.Write "<th class=""align-middle w-5 p-0"">Nakit/Banka</th>"
			Response.Write "<th class=""align-middle w-5 p-0"">Banka</th>"
			Response.Write "<th class=""align-middle w-25 p-0"">Teminat Tarih</th>"
			Response.Write "<th class=""align-middle w-5 p-0"">Geçerlilik Tarih</th>"
			Response.Write "<th class=""align-middle w-5 p-0"">Teminat No</th>"
			Response.Write "<th class=""align-middle w-5 p-0"" colspan=""2"">Tutar</th>"
			Response.Write "<th class=""align-middle w-5 p-0"">İade Tarih</th>"
			Response.Write "</tr></thead><tbody>"
	
			sorgu = "Select t.tur, t.tarih_exp, t.tarih_teminat, t.no, t.tutar, t.tarih_iade, t.teminatPB, t.bankalarID,"_
			&" t.id as teminatID, b.ad as bankalarAD, (CASE t.nakitTeminat WHEN 'True' THEN 1 WHEN 'False' THEN 0 END) as nakitTeminat"_ 
			&" from teminat t LEFT JOIN bankalar b ON t.bankalarID = b.id"_
			&" WHERE t.musteriID = " & musteriID & " and t.ihaleID = " & id & " order by t.id ASC"
			rs.open sorgu,sbsv5,1,3
	
			for i = 1 to rs.recordcount
			Response.Write "<tr>"
				Response.Write "<td class=""align-middle text-center"">"
						Response.Write "<a id="""&rs("teminatID")&"|teminat"&""" class=""btn ajSil"" role=""button""><i class=""fa fa-trash-o""></i></a>"
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
					call formselectv2("tur",rs("tur"),"","","ajSave borderless text-center","","tur|"&rs("teminatID")&"|teminat",teminatTurDegerler,"")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
					call formselectv2("bankaNakitSec",rs("nakitTeminat"),"","","ajSave borderless p-0","","nakitTeminat|"&rs("teminatID")&"|teminat",bankaNakitDegerler,"")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
					call formselectv2("bankalarAD",rs("bankalarID"),"","","ajSave borderless text-center","","bankalarID|"&rs("teminatID")&"|teminat",bankalarDegerler,"")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
					call forminput("tarih_teminat",rs("tarih_teminat"),"","","ajSave borderless tarih text-center cell","","tarih_teminat|"&rs("teminatID")&"|teminat","AutCompOff")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
					call forminput("tarih_exp",rs("tarih_exp"),"","","ajSave borderless tarih text-center cell","","tarih_exp|"&rs("teminatID")&"|teminat","AutCompOff")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
					call forminput("no",rs("no"),"","","ajSave borderless text-center","","no|"&rs("teminatID")&"|teminat","")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle border-right-0 p-0"">"
					paraDeger = para_basamak(rs("tutar"))
					call forminput("tutar",paraDeger,"","","ajSave borderless text-right","","tutar|"&rs("teminatID")&"|teminat","")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle border-left-0 p-0 pl-1"">"
					call formselectv2("teminatPB",rs("teminatPB"),"","","ajSave borderless text-left btn p-0 okKaldir","","teminatPB|"&rs("teminatID")&"|teminat",paraBirimDegerler,"")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
					call forminput("tarih_iade",rs("tarih_iade"),"","","ajSave borderless tarih text-center","","tarih_iade|"&rs("teminatID")&"|teminat","AutCompOff")
				Response.Write "</td>"
			Response.Write "</tr>"
			rs.movenext
			next
			rs.close
			Response.Write "</tbody></table>"
		Response.Write "</div>"'tab-pane
	end if'yetki_15
'##### /TEMİNAT
'##### /TEMİNAT

'##### KARAR-SÖZLEŞME
'##### KARAR-SÖZLEŞME
	if instr(yetki,",21,") = 0 then'yetki_21
			
		sorgu = "SELECT soz.id as sozlesmelerID, kacinciSozlesme, tarih_karar, kararPuluYatti, kararPuluTutar, tarih_sozlesme_teblig, tarih_sozlesme, tarih_sozlesme_bitis, tarih_teslimat_bitis FROM sozlesmeler soz WHERE musteriID = " & musteriID & " AND ihaleID = " & id & " order by kacinciSozlesme ASC"
		rs.open sorgu,sbsv5,1,3

		sozlesmeCheck = ""
		if rs.recordcount = 0 then 
			sozlesmeCheck	=	"checked=""checked"""
		end if
			
		Response.Write "<div class=""tab-pane"" id=""sozlesme"" role=""tabpanel"">"
	
		Response.Write "<div id=""sozlesmeInput"" class="""">"
	
			Response.Write "<div class=""container row text-center"">"
			
	
				Response.Write "<div class=""col-lg-10"">"
			
					Response.Write "<form class=""ajaxform"" action=""/dosya/sozlesme_kaydet.asp"">"
					Response.Write "<input type=""hidden"" name=""ihaleID"" value=" & id & " />"
					
			Response.Write "<div class=""row m-0 p-0"">"
						Response.Write "<div class=""card col-lg mt-2 mb-0 bg-secondary"">"
							Response.Write "<label class=""badge"">Karar Tarihi</label>"
							call forminput("tarih_karar","","","Karar Tarihi","tarih cell fontkucuk2 text-center cariNotlar","","tarih_karar","AutCompOff")
						Response.Write "</div>"
						Response.Write "<div class=""card col-lg mt-2 mb-0 bg-yellow"">"
							Response.Write "<label class=""badge"">Sözleşme Tebligat Tarihi</label>"
							call forminput("tarih_sozlesme_teblig","","","Sözleşme Tebligat","tarih cell fontkucuk2 text-center cariNotlar","","tarih_sozlesme_teblig","AutCompOff")
						Response.Write "</div>"
						Response.Write "<div class=""card col-lg mt-2 mb-0 bg-yellow"">"
							Response.Write "<label class=""badge"">Sözleşme İmza Tarihi</label>"
							call forminput("tarih_sozlesme","","","Sözleşme İmza","tarih cell fontkucuk2 text-center","","tarih_sozlesme","AutCompOff")
						Response.Write "</div>"
						Response.Write "<div class=""card col-lg mt-2 mb-0 bg-yellow"">"
							Response.Write "<label class=""badge"">Sözleşme Bitiş Tarihi</label>"
							call forminput("tarih_sozlesme_bitis","","","Sözleşme Bitiş","tarih cell fontkucuk2 text-center","","tarih_sozlesme_bitis","AutCompOff")
						Response.Write "</div>"
						Response.Write "<div class=""card col-lg mt-2 mb-0 bg-yellow"">"
							Response.Write "<label class=""badge"">Teslimat Son Tarihi</label>"
							call forminput("tarih_teslimat_bitis","","","Teslimat Son","tarih cell fontkucuk2 text-center","","tarih_teslimat_bitis","AutCompOff")
						Response.Write "</div>"
						Response.Write "<div class=""card col-lg mt-2 mb-0 bg-yellow text-center align-middle"">"
							Response.Write "<label class=""badge"">Tüm Ürünler</label>"
							Response.Write "<input name=""tekSozlesme"" class=""form-control chck30 text-center"""  & sozlesmeCheck & " type=""checkbox"" value=""evet"">"
						Response.Write "</div>"
						Response.Write "<div class=""col-lg-12"">"
							Response.Write "<button name=""teminat"" class=""kaydet btn-block btn-primary"" type=""submit"" onClick=""$('#tip').val('teminat');"">kaydet</button>"
						Response.Write "</div>"
				Response.Write "</div>"
					
					Response.Write "</form>"
				Response.Write "</div>"
			Response.Write "</div>"'container
			
	Response.Write "</div>"'sozlesmeInput

			Response.Write "<table id=""sozlesmeListe"" class=""table table-responsive table-bordered table-sm table-hover mt-3"">"
			Response.Write "<thead>"
			Response.Write "<tr class=""text-center bg-gray-200 p-0"">"
			Response.Write "<th class=""align-middle""></th>"
			Response.Write "<th class=""align-middle"">Sözleşme No</th>"
			Response.Write "<th class=""align-middle"">Karar Tarihi</th>"
			Response.Write "<th class=""align-middle"">Sözleşme Tebligat Tarihi</th>"
			Response.Write "<th class=""align-middle"">Sözleşme İmza Tarihi</th>"
			Response.Write "<th class=""align-middle"">Sözleşme Bitiş Tarihi</th>"
			Response.Write "<th class=""align-middle"">Teslimat Son Tarihi</th>"
			Response.Write "</tr></thead><tbody>"
			
			
	
	
			if rs.recordcount > 0 then
				for r = 1 to rs.recordcount
				
				sorgu = "SELECT SUM(kararPuluTutar) as topKararPulu FROM ihale_urun WHERE sozlesmelerID = " & rs("sozlesmelerID")
				rs2.open sorgu,sbsv5,1,3
					topKararPulu = rs2("topKararPulu")
				rs2.close
				
				Response.Write "<tr>"
				Response.Write "<td class=""align-middle text-center"">"
						Response.Write "<a id="""&rs("sozlesmelerID")&"|sozlesmeler"&""" class=""btn ajSil"" role=""button""><i class=""fa fa-trash-o""></i></a>"
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-center"">"
					Response.Write rs("kacinciSozlesme")
				Response.Write "</td>"
				
				Response.Write "<td class=""align-middle"">"
					call forminput("INPtarih_karar",rs("tarih_karar"),"","","ajSave borderless tarih text-center cell cariNotlar","","tarih_karar|"&rs("sozlesmelerID")&"|sozlesmeler","AutCompOff")
					
					if rs("kararPuluYatti") = "True" then
					Response.Write "<hr class=""pb-1 p-0 m-0"">"
					Response.Write "<div class=""d-flex flex-row"">"
						Response.Write "<div id=""kararPuluYatti|"&rs("sozlesmelerID")&"|sozlesmeler"" class=""col-lg-7 ajSave fontkucuk2 align-middle p-0""><input value=""0"" checked=""checked"" type=""checkbox"" id=""kararPuluYatti|"&rs("sozlesmelerID")&"|sozlesmeler"" class=""ajSave"">Karar Pulu Yattı</div>"
							call forminput("kararPuluTutar",para_basamak(rs("kararPuluTutar")),"","","ajSave borderless text-center cell input50 bg-info col-lg-12 fontkucuk2","","kararPuluTutar|"&rs("sozlesmelerID")&"|sozlesmeler","AutCompOff")
						Response.Write "<div class=""col-lg-4 m-0 p-0 fontkucuk2"">TL</div>"
					Response.Write "</div>"
					else
						Response.Write "<hr class=""p-0 m-0"">"
						Response.Write "<div class=""col-lg-12 fontkucuk2 align-middle btn p-0 m-0""><input value=""1"" type=""checkbox"" id=""kararPuluYatti|"&rs("sozlesmelerID")&"|sozlesmeler"" class=""ajSave""> Karar Pulu Yatmadı</div>"
					end if
					Response.Write "<hr class=""pb-1 p-0 m-0"">"
					Response.Write "<div class=""col-lg-12 fontkucuk2"">Karar Pulu: "&para_basamak(topKararPulu)&" TL"&"</div>"
				Response.Write "</td>"
				
				Response.Write "<td class=""align-middle"">"
					call forminput("INPtarih_sozlesme_teblig",rs("tarih_sozlesme_teblig"),"","","ajSave borderless tarih text-center cell cariNotlar","","tarih_sozlesme_teblig|"&rs("sozlesmelerID")&"|sozlesmeler","AutCompOff")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
					call forminput("INPtarih_sozlesme",rs("tarih_sozlesme"),"","giriş yok","ajSave borderless tarih text-center cell","","tarih_sozlesme|"&rs("sozlesmelerID")&"|sozlesmeler","AutCompOff")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
					call forminput("INPtarih_sozlesme_bitis",rs("tarih_sozlesme_bitis"),"","","ajSave borderless tarih text-center cell","","tarih_sozlesme_bitis|"&rs("sozlesmelerID")&"|sozlesmeler","AutCompOff")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
					call forminput("INPtarih_teslimat_bitis",rs("tarih_teslimat_bitis"),"","","ajSave borderless tarih text-center cell","","tarih_teslimat_bitis|"&rs("sozlesmelerID")&"|sozlesmeler","AutCompOff")
				Response.Write "</td>"
				Response.Write "</tr>"
				rs.movenext
				next
			end if
			rs.close
	
			Response.Write "</tbody></table>"
			
			
	
	
	
			Response.Write "<table id=""sozlesmeTablo"" class=""table table-responsive table-bordered table-sm table-hover mt-3"">"
			
			Response.Write "<thead>"
			Response.Write "<tr><td colspan=""10"">"
			Response.Write "<label class=""switch switch-lg switch-text switch-success"">"
				Response.Write "<input id=""sozlesmeSwitch"" type=""checkbox"" class=""switch-input"" checked onclick=""$('#sozlesmeInput').toggle('slow');"">"
				Response.Write "<span class=""switch-label"" data-on=""✓"" data-off=""X"">"
				Response.Write "</span>"
				Response.Write "<span class=""switch-handle""></span>"
			Response.Write "</label>"
			Response.Write "</td></tr>"
			Response.Write "<tr class=""text-center bg-gray-200 p-0"">"
			Response.Write "<th class=""align-middle"">Karar/Sözleşme</th>"
		classYaz = classbelirle("align-middle w-1",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
			Response.Write "<th class="""&classYaz&""">Kısım No</th>"
			Response.Write "<th class=""align-middle w-1"">Sıra No</th>"
			Response.Write "<th class=""align-middle w-25"">Ürün Ad</th>"
			Response.Write "<th class=""align-middle w-5"" colspan=""2"">Miktar</th>"
			Response.Write "<th class=""align-middle w-5"" colspan=""2"">Yaklaşık Maliyet</th>"
			Response.Write "<th class=""align-middle w-5"" colspan=""2"">Fiyat</th>"
			Response.Write "</tr></thead><tbody>"
			
			sorgu = "Select ihale.id as ihaleID, iu.yaklasikMaliyetPB,"_
			&" iu.stoklarID, iu.grupNo, iu.siraNo, iu.miktar, iu.birim, iu.yerliOran, iu.firmamFiyat, iu.firmamParaBirim, iu.yaklasikMaliyet, iu.sozlesmelerID as urunSozlesme,"_
			&" iu.id as ihaleUrunID, iu.ad as urunAd, stoklar.ad as stoklarAD, soz.id as sozlesmeTabloID"_
			&" from ihale_urun iu INNER JOIN ihale ON iu.ihaleID = ihale.id"_
			&" LEFT JOIN sozlesmeler soz ON iu.sozlesmelerID = soz.id"_
			&" LEFT JOIN stoklar ON iu.stoklarID = stoklar.id"_
			&" WHERE ihale.musteriID = " & musteriID & " AND ihale.id = " & id & " AND iu.uhde = 'True' order by iu.grupNo ASC, iu.siraNo ASC"
			rs.open sorgu,sbsv5,1,3
			for i = 1 to rs.recordcount
			Response.Write "<tr>"
				Response.Write "<td class=""align-middle"">"
				if isnull(rs("sozlesmeTabloID")) then
					sozlID = 0
				else
					sozlID = int(rs("sozlesmeTabloID"))
				end if
					call formselectv2("urunSozTarih",sozlID,"","","ajSave borderless text-center","","sozlesmelerID|"&rs("ihaleUrunID")&"|ihale_urun",sozlesmelerDegerler,"")
				Response.Write "</td>"
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("grupNo")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-center"">"
				Response.Write rs("siraNo")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle"">"
				Response.Write rs("urunAd")
						Response.Write "<br><span class=""stokKarsilik fontkucuk2 text-info""><em>"
					if rs("stoklarID") = 0 OR isnull(rs("stoklarID")) then
						Response.Write "<i class=""fa fa-exclamation text-danger""> stok karşılığı seçilmemiş</i> <i class=""fa fa-exclamation text-danger""></i>"
					else
						Response.Write rs("stoklarAD")
					end if
						Response.Write "</em></font>"
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right border-right-0 p-0"">"
				Response.Write rs("miktar")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-left border-left-0 p-0 pl-1"">"
				Response.Write rs("birim")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right border-right-0 p-0"">"
					para_deger = para_basamak(rs("yaklasikMaliyet"))
				Response.Write para_deger
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-left border-left-0 p-0 pl-1"">"
				Response.Write rs("yaklasikMaliyetPB")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right border-right-0 p-0"">"
					para_deger = para_basamak(rs("firmamFiyat"))
				Response.Write para_deger
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-left border-left-0 p-0 pl-1"">"
				Response.Write rs("firmamParaBirim")
				Response.Write "</td>"
			Response.Write "</tr>"
			rs.movenext
			next
			rs.close
			Response.Write "</tbody></table>"
		Response.Write "</div>"'tab-pane
	end if'yetki_21
'##### /KARAR-SÖZLEŞME
'##### /KARAR-SÖZLEŞME

'##### SİPARİŞ
'##### SİPARİŞ
	if instr(yetki,",22,") = 0 then'yetki_22
		Response.Write "<div class=""tab-pane"" id=""siparis"" role=""tabpanel"">"
		Response.Write "<form class=""ajaxform"" action=""/dosya/siparis_kaydet.asp"">"
		Response.Write "<input type=""hidden"" name=""ihaleID"" value=" & id & " />"
		Response.Write "<div id=""siparisInput"" class=""text-center"">"
		
		Response.Write "<div class=""container row"">"
		
			Response.Write "<div class=""col-lg-4"">"
			Response.Write "<label class=""badge"">Sipariş Veren Kurum Seçimi</label>"
				call formselectv2("siparisVeren","","","","ajSipVeren","","siparisVeren",dahilKurumDegerler,"")
			Response.Write "</div>"
			
			Response.Write "<div class=""col-lg-2"">"
			Response.Write "<label class=""badge"">Sipariş No</label>"
			'Response.Write "<input type=""text"" name=""sipNo"" class=""form-control"">"
				call forminput("sipNo",sipNo,"","Sipariş No","","","sipNo","AutCompOff")
			Response.Write "</div>"
			
			Response.Write "<div class=""col-lg-2"">"
			Response.Write "<label class=""badge"">Sipariş Tarihi</label>"
				call forminput("tarih_sip",tarih_sip,"","Sipariş Tarihi","tarih","","tarih_sip","AutCompOff")
			Response.Write "</div>"
			
			Response.Write "<div class=""col-lg-2"">"
			Response.Write "<label class=""badge"">Son Teslim Tarihi</label>"
				call forminput("tarih_son_teslim",tarih_son_teslim,"","Son Teslim Tarihi","tarih","","tarih_son_teslim","AutCompOff")
			Response.Write "</div>"
		Response.Write "</div>"
		
	
	
	
	
	
			Response.Write "<table id=""siparisUrunler"" class=""table table-responsive table-bordered table-sm table-hover mt-3"">"
			
			Response.Write "<thead>"
			Response.Write "<tr class=""text-center bg-gray-200 p-0"">"
			Response.Write "<th class=""align-middle"">Sipariş Miktar</th>"
		classYaz = classbelirle("align-middle w-1",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
			Response.Write "<th class="""&classYaz&""">Kısım No</th>"
			Response.Write "<th class=""align-middle"">Sıra No</th>"
			Response.Write "<th class=""align-middle"">Ürün Ad</th>"
			Response.Write "<th class=""align-middle"" colspan=""2"">Miktar</th>"
			Response.Write "<th class=""align-middle"" colspan=""2"">Fiyat</th>"
			Response.Write "</tr></thead><tbody>"
			
			sorgu = "Select ihale.id as ihaleID, iu.yaklasikMaliyetPB,"_
			&" iu.stoklarID, iu.grupNo, iu.siraNo, iu.miktar, iu.birim, iu.yerliOran, iu.firmamFiyat, iu.firmamParaBirim, iu.yaklasikMaliyet,"_
			&" iu.id as ihaleUrunID, iu.ad as urunAd, stoklar.ad as stoklarAD, iut.carilerID, iut.id as iutID, iut.miktar as iutMiktar"_
			&" from ihale_urun iu INNER JOIN ihale ON iu.ihaleID = ihale.id"_
			&" LEFT JOIN ihale_urun_talep iut ON iut.ihaleUrunID = iu.id"_
			&" LEFT JOIN sozlesmeler soz ON iu.sozlesmelerID = soz.id"_
			&" LEFT JOIN stoklar ON iu.stoklarID = stoklar.id"_
			&" WHERE ihale.musteriID = " & musteriID & " AND ihale.id = " & id & " AND iut.carilerID = " & sipVerenCari & " AND iu.uhde = 'True' order by iu.grupNo ASC, iu.siraNo ASC"
			rs.open sorgu,sbsv5,1,3
	
			for i = 1 to rs.recordcount
			
			Response.Write "<tr>"
				Response.Write "<td class=""align-middle text-center"">"
				call forminput("sipMiktar|"&rs("iutID"),"","","Miktar","text-right borderless input60 sipMiktarCl","","","")
				Response.Write "</td>"
				
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("grupNo")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-center"">"
				Response.Write rs("siraNo")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-left"">"
				Response.Write rs("urunAd")
						Response.Write "<br><span class=""stokKarsilik fontkucuk2 text-info""><em>"
					if rs("stoklarID") = 0 OR isnull(rs("stoklarID")) then
						Response.Write "<i class=""fa fa-exclamation text-danger""> stok karşılığı seçilmemiş</i> <i class=""fa fa-exclamation text-danger""></i>"
					else
						Response.Write rs("stoklarAD")
					end if
						Response.Write "</em></font>"
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right border-right-0 p-0"">"
				Response.Write rs("iutMiktar")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-left border-left-0 p-0 pl-1"">"
				Response.Write rs("birim")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right border-right-0 p-0"">"
					para_deger = para_basamak(rs("firmamFiyat"))
				Response.Write para_deger
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-left border-left-0 p-0 pl-1"">"
				Response.Write rs("firmamParaBirim")
				Response.Write "</td>"
			Response.Write "</tr>"
			rs.movenext
			next
			rs.close
			Response.Write "</tbody></table>"
	
	
	
				
				Response.Write "<div class=""col-lg-12 mt-3"">"
				Response.Write "<button class=""kaydet btn-block btn-primary"" type=""submit"">kaydet</button>"
				Response.Write "</div>"
		Response.Write "</div>"'siparisInput
		
	Response.Write "</form>"
		
		
			Response.Write "<table id=""siparisTablo"" class=""table table-responsive table-bordered table-sm table-hover mt-3"">"
			
			Response.Write "<thead>"
			Response.Write "<tr class=""text-center bg-gray-200 p-0 align-middle text-danger""><th class=""align-middle p-0"">"
			Response.Write "<label class=""switch switch-lg switch-text switch-success"">"
				Response.Write "<input id=""siparisSwitch"" type=""checkbox"" class=""switch-input"" checked onclick=""$('#siparisInput').toggle('slow');"">"
				Response.Write "<span class=""switch-label"" data-on=""✓"" data-off=""X"">"
				Response.Write "</span>"
				Response.Write "<span class=""switch-handle""></span>"
			Response.Write "</label>"
			Response.Write "</th>"
			Response.Write "<th class=""align-middle p-0"">Sipariş No</th>"
			Response.Write "<th class=""align-middle p-0"">Sipariş Veren</th>"
			Response.Write "<th class=""align-middle p-0"">Sipariş Tarihi</th>"
			Response.Write "<th class=""align-middle p-0"">Son Teslim Tarihi</th>"
			Response.Write "</tr></thead><tbody>"
			sorgu = "SELECT DISTINCT s.kacinciSiparis, s.sipNo, c.ad as sipVeren, s.tarih_sip, s.tarih_son_teslim FROM siparis s INNER JOIN cariler c ON s.siparisVerenCariID = c.id WHERE s.musteriID = " & musteriID & " AND s.ihaleID = " & id
			rs.open sorgu,sbsv5,1,3
				do until rs.EOF
					Response.Write "<thead><tr class=""font-weight-bold"">"
					Response.Write "<td class=""text-center p-0"">"
						Response.Write "<a id="""&id&"|siparis|"&rs("kacinciSiparis")&""" class=""btn ajSil"" role=""button""><i class=""fa fa-trash-o""></i></a>"
					Response.Write "</td>"
					Response.Write "<td class=""text-center"">"
					Response.Write rs("sipNo")
					Response.Write "</td>"
					Response.Write "<td>"
					Response.Write rs("sipVeren")
					Response.Write "</td>"
					Response.Write "<td class=""text-center"">"
					Response.Write rs("tarih_sip")
					Response.Write "</td>"
					Response.Write "<td class=""text-center"">"
					Response.Write rs("tarih_son_teslim")
					Response.Write "</td>"
					Response.Write "</tr></thead>"
					
					Response.Write "<thead><tr class=""p-0 font-weight-bold text-center text-danger font-italic fontkucuk2 align-middle bg-gray-200"">"
						Response.Write "<td class=""p-0"">"
		classYaz = classbelirle("",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
						Response.Write "<span class="""&classYaz&""">Kısım No</span>"
						Response.Write "</td>"
						Response.Write "<td class=""p-0"">"
						Response.Write "Sıra No"
						Response.Write "</td>"
						Response.Write "<td class=""p-0"">"
						Response.Write "Ürün Ad"
						Response.Write "</td>"
						Response.Write "<td class=""p-0"">"
						Response.Write "Fiyat"
						Response.Write "</td>"
						Response.Write "<td class=""p-0"">"
						Response.Write "Toplam Miktar"
						Response.Write "</td>"
						Response.Write "<td class=""p-0"">"
						Response.Write "Sipariş Miktar"
						Response.Write "</td>"
						Response.Write "<td class=""p-0"">"
						Response.Write "İptal Miktar"
						Response.Write "</td>"
						Response.Write "<td class=""p-0"">"
						Response.Write "Teslim Edilen"
						Response.Write "</td>"
						Response.Write "<td class=""p-0"">"
						Response.Write "Bakiye"
						Response.Write "</td>"
					Response.Write "</tr></thead>"
			sorgu = "SELECT s.ihaleUrunTalepID, iu.grupNo, iu.siraNo, iu.ad as urunAd, iu.firmamFiyat,"_
				&" iu.firmamParaBirim, s.miktar as sipMiktar, iu.birim, iut.miktar as topMiktar,"_
				&" s.teslimEdilen,iu.id as ihaleUrunID, ISNULL(s.iptalMiktar,0) as iptalMiktar"_
				&" FROM siparis s"_
				&" INNER JOIN ihale_urun_talep iut ON s.ihaleUrunTalepID = iut.id"_
				&" INNER JOIN ihale_urun iu ON iut.ihaleUrunID = iu.id"_
				&" WHERE s.musteriID = " & musteriID & ""_
				&" AND s.ihaleID = " & id & ""_
				&" AND s.kacinciSiparis = " & rs("kacinciSiparis") & ""_
				&" ORDER BY iu.grupNo, iu.siraNo"
			rs2.open sorgu,sbsv5,1,3
			bakiye = 0
				if rs2.recordcount > 0 then
					for i = 1 to rs2.recordcount
					Response.Write "<tr class=""sipmiktartr"">"
						Response.Write "<td class=""text-center"">"
		classYaz = classbelirle("",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
						Response.Write "<span class="""&classYaz&""">"&rs2("grupNo")&"</span>"
						Response.Write "</td>"
						Response.Write "<td class=""text-center"">"
						Response.Write rs2("siraNo")
						Response.Write "</td>"
						Response.Write "<td>"
						Response.Write rs2("urunAd")
						Response.Write "</td>"
						Response.Write "<td class=""text-right"">"
						para_deger = para_basamak(rs2("firmamFiyat"))
						Response.Write para_deger&" "&rs2("firmamParaBirim")
						Response.Write "</td>"
						Response.Write "<td class=""text-right"">"
						Response.Write rs2("TopMiktar")&" "&rs2("birim")
						Response.Write "</td>"
							bakiye = rs2("sipMiktar") - rs2("iptalMiktar") - rs2("teslimEdilen")
						Response.Write "<td class=""text-right""><span class=""sipmiktarlari"" data-ihaleUrunTalepID=""" & rs2("ihaleUrunTalepID") & "_" & rs2("ihaleUrunID") & """ data-kacinciSiparis=""" & rs("kacinciSiparis") & """ data-sipmiktar=""" & bakiye & """ data-urunad=""" & rs2("urunAd") & """>"
						Response.Write rs2("sipMiktar")&" "&rs2("birim")
						Response.Write "</span></td>"
						Response.Write "<td class=""text-right"">"
						Response.Write rs2("iptalMiktar")&" "&rs2("birim")
						Response.Write "</td>"
						Response.Write "<td class=""text-right"">"
						Response.Write rs2("teslimEdilen")&" "&rs2("birim")
						Response.Write "</td>"
						Response.Write "<td class=""text-right"">"
						if bakiye = 0 then
							response.Write "<span class=""bg-success"">tamamlandı</span>"
						else
							Response.Write bakiye&" "&rs2("birim")
						end if
						Response.Write "</td>"
					Response.Write "</tr>"
					rs2.movenext
					next
				end if
			rs2.close	
					rs.movenext
					Response.Write "<tr>"
						Response.Write "<td colspan=""8"" class=""bg-warning"">"
						Response.Write "</td>"
					Response.Write "</tr>"
				loop
			rs.close
			Response.Write "</tbody></table>"
		Response.Write "</div>"'tab-pane
	end if'yetki_22
'##### /SİPARİŞ
'##### /SİPARİŞ

'##### TESLİMAT
'##### TESLİMAT
	if instr(yetki,",23,") = 0 then'yetki_23
		Response.Write "<div class=""tab-pane"" id=""teslimat"" role=""tabpanel"">"
		Response.Write "<form class=""ajaxform"" action=""/dosya/teslimat_kaydet.asp"">"
		Response.Write "<input type=""hidden"" name=""ihaleID"" value=" & id & " />"
		Response.Write "<div id=""teslimatInput"" class=""text-center"">"
		
		Response.Write "<div class=""container row"">"
		
			Response.Write "<div class=""col-lg-4"">"
			Response.Write "<label class=""badge"">Telimat Yapılan Cari Seçimi</label>"
				call formselectv2("faturaCari","","","","ajTeslimatCari","","faturaCari",dahilKurumDegerler,"")
			Response.Write "</div>"
			
			Response.Write "<div id=""cariSipListe"" class=""col-lg-3"">"
			Response.Write "<label class=""badge"">Cariye Ait Siparişler</label>"
				call formselectv2("tesKacinciSiparis","","sipnomiktargetir(this.value)","","","","tesKacinciSiparis",siparislerDegerler,"")
			Response.Write "</div>"
	
			Response.Write "<div class=""col-lg-2"">"
			Response.Write "<label class=""badge"">Fatura No</label>"
				call forminput("faturaNo","","","Fatura No","faturaNo","","faturaNo","AutCompOff")
			Response.Write "</div>"
			
			Response.Write "<div class=""col-lg-2"">"
			Response.Write "<label class=""badge"">Fatura Tarihi</label>"
				call forminput("faturaTarih","","","Fatura Tarihi","tarih","","faturaTarih","AutCompOff")
			Response.Write "</div>"
			
		Response.Write "</div>"
	
			Response.Write "<table id=""teslimatUrunler"" class=""table table-responsive table-bordered table-sm table-hover mt-3"">"
			
			Response.Write "<thead>"
			Response.Write "<tr class=""text-center bg-gray-200 p-0"">"
			Response.Write "<th class=""align-middle"">Teslimat Miktar</th>"
		classYaz = classbelirle("align-middle w-1",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
			Response.Write "<th class="""&classYaz&""">Kısım No</th>"
			Response.Write "<th class=""align-middle"">Sıra No</th>"
			Response.Write "<th class=""align-middle"">Ürün Ad</th>"
			Response.Write "<th class=""align-middle"" colspan=""2"">Miktar</th>"
			Response.Write "<th class=""align-middle"" colspan=""2"">Fiyat</th>"
			Response.Write "</tr></thead><tbody>"
			
			sorgu = "Select ihale.id as ihaleID, iu.yaklasikMaliyetPB,"_
			&" iu.stoklarID, iu.grupNo, iu.siraNo,"_
			&" (ISNULL(iu.miktar,0) + ISNULL(iu.arttirimMiktar,0) - ISNULL(iu.eksiltimMiktar,0)) as miktar,"_
			&" iu.birim, iu.yerliOran, iu.firmamFiyat, iu.firmamParaBirim, iu.yaklasikMaliyet,"_
			&" iu.id as ihaleUrunID, iu.ad as urunAd, stoklar.ad as stoklarAD, iut.carilerID, iut.id as iutID, iut.miktar as iutMiktar"_
			&" from ihale_urun iu INNER JOIN ihale ON iu.ihaleID = ihale.id"_
			&" LEFT JOIN ihale_urun_talep iut ON iut.ihaleUrunID = iu.id"_
			&" LEFT JOIN sozlesmeler soz ON iu.sozlesmelerID = soz.id"_
			&" LEFT JOIN stoklar ON iu.stoklarID = stoklar.id"_
			&" WHERE ihale.musteriID = " & musteriID & " AND ihale.id = " & id & " AND iut.carilerID = " & faturaCari & " AND iu.uhde = 'True' order by iu.grupNo ASC, iu.siraNo ASC"
			rs.open sorgu,sbsv5,1,3
	
			for i = 1 to rs.recordcount
			
			
			Response.Write "<tr>"
				Response.Write "<td class=""align-middle text-center"">"
				call forminput("fatMiktar|"&rs("iutID")&"|"&rs("ihaleUrunID"),"","","Miktar","text-right borderless input60 ajCariSiparisler sip" & rs("iutID") & "_" & rs("ihaleUrunID"),"","","")
				Response.Write "</td>"
				
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
				Response.Write rs("grupNo")
				Response.Write "</td>"
				
				Response.Write "<td class=""align-middle text-center"">"
				Response.Write rs("siraNo")
				Response.Write "</td>"
				
				Response.Write "<td class=""align-middle text-left"">"
				Response.Write rs("urunAd")
						Response.Write "<br><span class=""stokKarsilik fontkucuk2 text-info""><em>"
					if rs("stoklarID") = 0 OR isnull(rs("stoklarID")) then
						Response.Write "<i class=""fa fa-exclamation text-danger""> stok karşılığı seçilmemiş</i> <i class=""fa fa-exclamation text-danger""></i>"
					else
						Response.Write rs("stoklarAD")
					end if
						Response.Write "</em></font>"
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right border-right-0 p-0"">"
				Response.Write rs("iutMiktar")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-left border-left-0 p-0 pl-1"">"
				Response.Write rs("birim")
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-right border-right-0 p-0"">"
					para_deger = para_basamak(rs("firmamFiyat"))
				Response.Write para_deger
				Response.Write "</td>"
				Response.Write "<td class=""align-middle text-left border-left-0 p-0 pl-1"">"
				Response.Write rs("firmamParaBirim")
				Response.Write "</td>"
			Response.Write "</tr>"
			rs.movenext
			next
			rs.close
			Response.Write "</tbody></table>"
	
	
	
				
				Response.Write "<div class=""col-lg-12 mt-3"">"
				Response.Write "<button class=""kaydet btn-block btn-primary"" type=""submit"">kaydet</button>"
				Response.Write "</div>"
		Response.Write "</div>"'teslimatInput
		
	Response.Write "</form>"
		
		
			Response.Write "<table id=""teslimatTablo"" class=""table table-responsive table-bordered table-sm table-hover mt-3"">"
			
			Response.Write "<thead>"
			Response.Write "<tr class=""text-center bg-gray-200 p-0 align-middle text-danger""><th class=""align-middle p-0"">"
			Response.Write "<label class=""switch switch-lg switch-text switch-success"">"
				Response.Write "<input id=""teslimatSwitch"" type=""checkbox"" class=""switch-input"" checked onclick=""$('#teslimatInput').toggle('slow');"">"
				Response.Write "<span class=""switch-label"" data-on=""✓"" data-off=""X"">"
				Response.Write "</span>"
				Response.Write "<span class=""switch-handle""></span>"
			Response.Write "</label>"
			Response.Write "</th>"
		classYaz = classbelirle("align-middle p-0",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
			Response.Write "<th class="""&classYaz&""">Kısım No</th>"
			Response.Write "<th class=""align-middle p-0"">Sıra No</th>"
			Response.Write "<th class=""align-middle p-0"">Ürün Ad</th>"
			Response.Write "<th class=""align-middle p-0"">Fiyat</th>"
			Response.Write "<th class=""align-middle p-0"">Toplam Miktar</th>"
			Response.Write "<th class=""align-middle p-0"">İş Artış</th>"
			Response.Write "<th class=""align-middle p-0"">İş Eksiliş</th>"
			Response.Write "<th class=""align-middle p-0"">Teslim Edilen</th>"
			Response.Write "<th class=""align-middle p-0"">Kalan</th>"
			
			Response.Write "</tr></thead><tbody>"
			
			
			sorgu = "SELECT iu.id as iuID, iu.grupNo, iu.siraNo, iu.ad as urunAd, iu.firmamFiyat, iu.firmamParaBirim,"_
			&" ISNULL(iu.miktar,0) as miktar, ISNULL(iu.arttirimMiktar,0) as arttirimMiktar, ISNULL(iu.eksiltimMiktar,0) as eksiltimMiktar, iu.birim"_
			&" FROM ihale_urun iu WHERE iu.uhde = 'True' AND iu.musteriID = " & musteriID & " AND iu.ihaleID = " & id & " order by iu.grupNo ASC, iu.siraNo ASC"
			rs.open sorgu,sbsv5,1,3
			
			for i = 1 to rs.recordcount
			
			sorgu = "SELECT ISNULL(SUM(miktar),0) as topTesEdilen FROM teslimat WHERE musteriID = " & musteriID & " AND ihaleID = " & id & " AND ihaleUrunID = " & rs("iuID")
			rs2.open sorgu,sbsv5,1,3
			
	'####### ürünler başlangıcı
			
				Response.Write "<thead><tr class=""font-weight-bold"">"
				Response.Write "<td class=""text-center"">"
				Response.Write "<a href=""#"" onclick=""$('.tr"&rs("iuID")&"').slideToggle();$('#sp"&rs("iuID")&"').toggleClass('fa-plus fa-minus');""><span id=""sp"&rs("iuID")&""" class=""fa fa-plus""></span></a>"
				Response.Write "</td>"
		classYaz = classbelirle("text-center",kisimIhale,ihaleTipi,"gruptaVar","","","","","","","","","")
				Response.Write "<td class="""&classYaz&""">"
					Response.Write rs("grupNo")
				Response.Write "</td>"
				Response.Write "<td class=""text-center"">"
					Response.Write rs("siraNo")
				Response.Write "</td>"
				Response.Write "<td>"
					Response.Write rs("urunAd")
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				para_deger = para_basamak(rs("firmamFiyat"))
					Response.Write para_deger&" "&rs("firmamParaBirim")
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
					Response.Write formatnumber(rs("miktar"),0)&" "&rs("birim")
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
					Response.Write formatnumber(rs("arttirimMiktar"),0)&" "&rs("birim")
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
					Response.Write formatnumber(rs("eksiltimMiktar"),0)&" "&rs("birim")
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
					if rs2("topTesEdilen") > 0 then
						Response.Write formatnumber(rs2("topTesEdilen"),0)&" "&rs("birim")
					else
						Response.Write "--"
					end if
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
	
				kalan_miktar = (rs("miktar") + rs("arttirimMiktar")) - (rs2("topTesEdilen") + rs("eksiltimMiktar"))
				
					if kalan_miktar > 0 then
						Response.Write formatnumber(kalan_miktar,0)&" "&rs("birim")
					elseif kalan_miktar = 0 then
						Response.Write "<span class=""bg-success"">tamamlandı</span>"
					else
						Response.Write "--"
					end if
			rs2.close
				Response.Write "</td>"
				Response.Write "</tr></thead>"
	'####### /ürünler sonu
	
	'####### kurumlar başlangıcı
	
			sorgu = "SELECT c.ad as cariAD,"_
			&" (ISNULL(iut.miktar,0) + ISNULL(iut.iutArttirimMiktar,0) - ISNULL(iut.iutEksiltimMiktar,0)) as iutMiktar,"_
			&" isnull(iut.iutArttirimMiktar,0) as iutArttirimMiktar, isnull(iut.iutEksiltimMiktar,0) as iutEksiltimMiktar, iut.id as iutID, iut.carilerID FROM ihale_urun_talep iut"_
			&" INNER JOIN cariler c ON iut.carilerID = c.id WHERE iut.musteriID = " & musteriID & " AND iut.ihaleUrunID = " & rs("iuID")
			rs2.open sorgu,sbsv5,1,3
				for iz = 1 to rs2.recordcount
				
			sorgu = "SELECT SUM(miktar) as cariTopTesEdilen FROM teslimat WHERE musteriID = " & musteriID & " AND ihaleID = " & id & " AND ihaleUruntalepID = " & rs2("iutID") & " AND ihaleUrunID = " & rs("iuID")
			rs3.open sorgu,sbsv5,1,3
			
			cariToplamTeslimEdilen = rs3("cariTopTesEdilen")
			rs3.close
					Response.Write "<tr class=""def-kapali fontkucuk font-italic tr"&rs("iuID")&""">"
					Response.Write "<td>"
					Response.Write "</td>"
					Response.Write "<td class=""text-center"">"
				Response.Write "<a id=""fatPlus"&rs2("iutID")&""" href=""#"" onclick=""$('.fattr"&rs2("iutID")&"').slideToggle();$('#sp2"&rs2("iutID")&"').toggleClass('fa-plus fa-minus');""><span id=""sp2"&rs2("iutID")&""" class=""fa fa-plus""></span></a>"
					'Response.Write "</td>"
					'Response.Write "<td>"
					Response.Write "</td>"
					Response.Write "<td class=""text-right"">"
					Response.Write rs2("cariAD")
					Response.Write "</td>"
					Response.Write "<td>"
					Response.Write "</td>"
					Response.Write "<td class=""text-right"">"
					Response.Write rs2("iutMiktar")&" "&rs("birim")
					Response.Write "</td>"
					Response.Write "<td class=""text-right"">"
					Response.Write rs2("iutArttirimMiktar")&" "&rs("birim")
					Response.Write "</td>"
					Response.Write "<td class=""text-right"">"
					Response.Write rs2("iutEksiltimMiktar")&" "&rs("birim")
					Response.Write "</td>"
					Response.Write "<td class=""text-right"">"
					if isnull(cariToplamTeslimEdilen) OR cariToplamTeslimEdilen = 0 then
						Response.Write "--"
					else
						Response.Write cariToplamTeslimEdilen&" "&rs("birim")
					end if
					Response.Write "</td>"
					Response.Write "<td class=""text-center"">"
					kurumKalan = rs2("iutMiktar")  - cariToplamTeslimEdilen
					
					if kurumKalan > 0 then
						Response.Write kurumKalan
					elseif kurumKalan = 0 then
						Response.Write "<span class=""bg-success"">tamamlandı</span>"
					else
						Response.Write "<span class=""bg-danger"">"&kurumKalan&"</span>"
					end if
					Response.Write "</td>"
					Response.Write "</tr>"
	'####### /kurumlar sonu
	
	'####### faturalar başlangıcı
	
			sorgu = "SELECT t.faturaNo, t.faturaTarih, t.miktar, t.ihaleUrunTalepID, t.kacinciFatura, t.kacinciSiparis, kayitYontem FROM teslimat t WHERE t.carilerID = " & rs2("carilerID") & " AND t.ihaleUrunID = " & rs("iuID") & " AND t.musteriID = " & musteriID & " AND t.ihaleID = " & id
			rs3.open sorgu,sbsv5,1,3
				for ie = 1 to rs3.recordcount
					Response.Write "<tr class=""def-kapali fontkucuk2 fattr"&rs3("ihaleUrunTalepID")&""">"
					Response.Write "<td></td>"
					Response.Write "<td class=""text-center p-0"">"
					Response.Write "<a id="""&id&"|teslimat|"&rs3("kacinciFatura")&"|"&rs3("kacinciSiparis")&""" class=""btn ajSil"" role=""button""><i class=""fa fa-trash-o""></i></a>"
					Response.Write "</td>"
					Response.Write "<td></td>"
					Response.Write "<td class=""text-right"">"
					Response.Write rs3("faturaNo")&"<code>("&rs3("kayitYontem")&")</code> - "&rs3("faturaTarih")
					Response.Write "</td>"
					Response.Write "<td class=""text-left"" colspan=""2"">"
					Response.Write rs3("miktar")&" "&rs("birim")
					Response.Write "</td>"
					Response.Write "</tr>"
	'####### /faturalar sonu
	
				rs3.movenext
				next
				if rs3.recordcount = 0 then
					Response.Write "<scr" & "ipt>$('#fatPlus"&rs2("iutID")&"').hide();</scr" & "ipt>"
				end if
				rs3.close
				rs2.movenext
				next
				rs2.close
			rs.movenext
			next
			rs.close
			
			
			Response.Write "</tbody></table>"
		Response.Write "</div>"'tab-pane
	end if'yetki_23
'##### /TESLİMAT
'##### /TESLİMAT

'##### ÜTS İŞLEMLERİ
'##### ÜTS İŞLEMLERİ
		
		Response.Write "<div class=""tab-pane"" id=""uts"" role=""tabpanel"">"
	
		Response.Write "<div id=""utsInput"" class="""">"
	
	Response.Write "<div class=""card-deck"">"
		Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-body"">"
			
		sorgu = "SELECT DISTINCT t.faturaNo, t.faturaTarih, COALESCE(NULLIF(c.adKisa,''),c.ad) as cariAD, c.id as musteriCariID FROM teslimat t"_
		&" INNER JOIN cariler c ON t.carilerID = c.id"_
		&" WHERE t.ihaleID = " & id
		rs.open sorgu,sbsv5,1,3
		
			do until rs.EOF
					
			sorgu = "SELECT i.firmaID, t.TMTfaturaNo, t.TMTfaturaTarih, tl.id as tLotID, iu.ad as urunAD, tl.miktar, iu.grupNo, iu.siraNo, tl.lot, tl.utsBildirim, tl.utsBildirim2, s2.ubbKod as TMTubb, s2.id as TMTstokID FROM teslimat_lot tl"_
			&" LEFT JOIN ihale i ON tl.ihaleID = i.id"_
			&" INNER JOIN teslimat t ON tl.teslimatID = t.id"_
			&" INNER JOIN ihale_urun iu ON t.ihaleUrunID = iu.id"_
			&" LEFT JOIN stoklar s1 ON iu.stoklarID = s1.id"_
			&" LEFT JOIN (SELECT muhStokKod, ubbKod, id FROM stoklar WHERE firmalarID = 2) AS s2 ON s1.muhStokKod = s2.muhStokKod"_
			&" WHERE t.faturaNo = '" & rs("faturaNo") & "'"
			rs2.open sorgu,sbsv5,1,3

			
			if rs2.recordcount > 0 then
				Response.Write "<table class=""table-sm table-hover table-striped fontkucuk"">"
					Response.Write "<thead>"
					Response.Write "<tr class=""text-center"">"
					Response.Write "<th>Fatura No</th>"
					Response.Write "<th>Tarih</th>"
					Response.Write "<th>Cari</th>"
					Response.Write "</tr>"
					Response.Write "</thead>"
					
					Response.Write "<tr>"
					Response.Write "<td>" & rs("faturaNo") & "</td>"
					Response.Write "<td>" & rs("faturaTarih") & "</td>"
					Response.Write "<td>" & rs("cariAD") & "</td>"
					Response.Write "</tr>"
				Response.Write "</table>"

				Response.Write "<table class=""table-sm table-hover table-striped fontkucuk2"">"
					Response.Write "<thead>"
					Response.Write "<tr class=""text-center"">"
					Response.Write "<th>Sıra No</th>"
					Response.Write "<th>Ürün</th>"
					Response.Write "<th>Miktar</th>"
					Response.Write "<th>TMT UBB</th>"
					Response.Write "<th>LOT No</th>"
					Response.Write "<th>ÜTS</th>"
					Response.Write "<th></th>"
					Response.Write "</tr>"
					Response.Write "</thead>"
			end if

			for j = 1 to rs2.recordcount
			
			if rs2("grupNo") > 0 then
				gSiraNo	=	rs2("grupNo") & " - " & rs2("SiraNo")
			else
				gSiraNo = rs2("SiraNo")
			end if
			
			Response.Write "<input type=""hidden"" id=""tLotID"" value=""" & rs2("tLotID") & """>"
			Response.Write "<input type=""hidden"" id=""lotNo_"&rs2("tLotID")&""" value=""" & rs2("lot") & """>"
			Response.Write "<input type=""hidden"" id=""TMTubb_"&rs2("tLotID")&""" value=""" & rs2("TMTubb") & """>"
			Response.Write "<input type=""hidden"" id=""miktar_"&rs2("tLotID")&""" value=""" & rs2("miktar") & """>"
					Response.Write "<tr>"
					Response.Write "<td>" & gSiraNo & "</td>"
					Response.Write "<td>" & rs2("urunAD") & "</td>"
					Response.Write "<td class=""text-right"">" & rs2("miktar") & "</i></td>"
					Response.Write "<td>" & rs2("TMTubb") & "</td>"
					Response.Write "<td>" & rs2("lot") & "</td>"
					Response.Write "<td>"
					if rs2("utsBildirim") = "False" OR isnull(rs2("utsBildirim")) then
						utsButonAD 		= 	"üts bildirimi"
						utsButonClass	=	" btn-primary "
					else
						utsButonAD 		= 	"üts OK"
						utsButonClass	=	" btn-success "
					end if
					
					if rs2("utsBildirim2") = "M" then
						Response.Write "<span class=""btn btn-sm rounded pull-right m-0 p-0 bg-success"">Manuel OK</btn>"
					elseif rs2("utsBildirim2") = "B" then
						Response.Write "<span class=""btn btn-sm rounded pull-right m-0 p-0 bg-warning"">Yapılmayacak</btn>"
					else
						Response.Write "<span class=""btn "&utsButonClass&" btn-sm rounded pull-right m-0 p-0"" onClick=""modalajaxfit('','/uts/utsTest.asp?TMTfaturaTarih=" & rs2("TMTfaturaTarih") & "&TMTfaturaNo=" & rs2("TMTfaturaNo") & "&tLotID=" & rs2("tLotID") & "&TMTstokID=" & rs2("TMTstokID") & "&musteriCariID=" & rs("musteriCariID") &"&fatTarih=" & rs("faturaTarih") & "&faturaNo=" & rs("faturaNo") & "&satanFirmam=" & rs2("firmaID") & "&miktar=" & rs2("miktar") & "&lot=" & rs2("lot") & "');"">" & utsButonAD & "</span>"
					end if
					Response.Write "</td>"
					
					Response.Write "<td>"
					Response.Write "<div id=""utsCHCKdiv"">"
						if rs2("utsBildirim") = "False" OR isnull(rs2("utsBildirim")) then
						manuelchck		=	""
						bildirimYokchck	=	""
						inputManuelVal	=	"M"
						inputByokVal	=	"B"
							if rs2("utsBildirim2") = "M" then
								manuelchck 		= 	"checked"
								inputManuelVal	=	null
							elseif rs2("utsBildirim2") = "B" then
								bildirimYokchck 	= 	"checked"
								inputByokVal		=	null
							end if
							Response.Write "<input id=""utsBildirim2|"&rs2("tLotID")&"|teslimat_lot"" class=""ajSave"" value="""&inputManuelVal&""" type=""checkbox"" "&manuelchck&">"
							Response.Write "<input id=""utsBildirim2|"&rs2("tLotID")&"|teslimat_lot"" class=""ajSave"" value="""&inputByokVal&""" type=""checkbox"" "&bildirimYokchck&">"
						end if
					Response.Write "</div>"	
					Response.Write "</td>"
					
					Response.Write "</tr>"
			rs2.movenext
			next
				Response.Write "</table>"
				Response.Write "<hr>"
			rs2.close
			
			rs.movenext
			loop
		rs.close
		
			Response.Write "</div>"'card-body
		Response.Write "</div>"'card
		
		
		' Response.Write "<div class=""card"">"
			' Response.Write "<div class=""card-body"">"
			

			
			' Response.Write "</div>"'card-body
		' Response.Write "</div>"'card
		
	Response.Write "</div>"'card-deck
	
		Response.Write "</div>"'utsInput
		
		Response.Write "</div>"'tab-pane

'##### /ÜTS İŞLEMLERİ
'##### /ÜTS İŞLEMLERİ

'##### TEKLİF
'##### TEKLİF
	if instr(yetki,",24,") = 0 then'yetki_24
			
		Response.Write "<div class=""tab-pane"" id=""teklif"" role=""tabpanel"">"
	
	
			Response.Write "<div class=""container row text-center"">"
			
				Response.Write "<div class=""col-lg-10"">"
			
					Response.Write "<form action=""/dosya/hucre_kaydet.asp"" method=""post"" class=""ajaxform"">"
					Response.Write "<input type=""hidden"" name=""alan"" value=""teklifNot"" />"
					Response.Write "<input type=""hidden"" name=""id"" value=""" & id & """ />"
					Response.Write "<input type=""hidden"" name=""tablo"" value=""ihale"" />"
					
						Response.Write "<div class=""container-fluid row text-left"">"
							Response.Write "<div class=""col-lg-12"">"
							Response.Write "<label class=""badge"">Teklif Dip Notları</label>"
							Response.Write "<textarea class=""form-control"" name=""deger"" rows=""5"" id=""teklifNot"" placeholder=""Örnek : * KDV Hariçtir."">" & teklifNot & "</textarea>"
							Response.Write "</div>"
					
					
							Response.Write "<div class=""col-lg-12"">"
							Response.Write "<button type=""submit"" class=""btn form-control btn-success"" onClick=""modalkapat();"">Kaydet</button>"
								call clearfix()
							Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</form>"
					
				Response.Write "</div>"
			Response.Write "</div>"'container
			
			
		Response.Write "</div>"'tab-pane
	end if'yetki_24
'##### /TEKLİF
'##### /TEKLİF


Response.Write "</div>"

Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"

'##### /TABLO
'##### /TABLO




Response.Write "<scr" & "ipt>"
Response.Write "$(document).ready(function() {"
Response.Write "$('.modalUrunsec').select2({theme: 'bootstrap',placeholder: 'Liste Kalemi stok karşılığı seçimi yapınız.',allowClear: true,width: '100%'});"
Response.Write "$('.urunSecEkle').select2({theme: 'bootstrap',placeholder: 'Eklenecek ürünü seçiniz.',allowClear: true,width: '100%'});"
Response.Write "$('#markasec').select2({theme: 'bootstrap',placeholder: 'Marka seçimi yapınız.',allowClear: true,width: '100%'});"
Response.Write "$('#select2-3').select2({theme: 'bootstrap',placeholder: 'Alım Yapan Kurumu Seçiniz.',allowClear: true,width: '100%'});"
Response.Write "$('.teminatTurSec').select2({theme: 'bootstrap',placeholder: 'Tür seçiniz.',allowClear: true,width: '100%'});"
Response.Write "$('.bankaNakitSec').select2({theme: 'bootstrap',placeholder: 'Seçiniz.',allowClear: true,width: '100%'});"
Response.Write "$('.bankasec').select2({theme: 'bootstrap',placeholder: 'Banka/Nakit Teminat seçimi yapınız.',allowClear: true,width: '100%'});"
'Response.Write "$('.carisec').select2({theme: 'bootstrap',placeholder: 'Cari seçimi yapınız.',allowClear: true,width: '100%'});"
Response.Write "$('.firmasec').select2({theme: 'bootstrap',placeholder: 'Firmam seçimi yapınız.',allowClear: true,width: '100%'});"
Response.Write "$('#siparisVeren').select2({theme: 'bootstrap',placeholder: 'Sipariş veren kurum seçiniz',allowClear: true,width: '100%'});"
Response.Write "$('#faturaCari').select2({theme: 'bootstrap',placeholder: 'Fatura kesilen kurum seçiniz',allowClear: true,width: '100%'});"
'Response.Write "$('#cariSipListe').select2({theme: 'bootstrap',placeholder: 'Cariye ait siparişler.',allowClear: true});"
Response.Write "});"

Response.Write "jQuery(document).ajaxSuccess(function(){"
Response.Write "$('.modalUrunsec').select2({theme: 'bootstrap',placeholder: 'İhale Kalemi stok karşılığı seçimi yapınız.',allowClear: true,width: '100%'});"
Response.Write "$('.urunSecEkle').select2({theme: 'bootstrap',placeholder: 'Eklenecek ürünü seçiniz.',allowClear: true,width: '100%'});"
'Response.Write "$('.def-kapali').hide('slow');"
Response.Write "if($('#sozlesmeInput').is(':visible')){$('#sozlesmeSwitch').prop('checked', false);}"
Response.Write "if($('#urunlerInput').is(':visible')){$('#urunlerSwitch').prop('checked', false);}"
Response.Write "if($('#siparisInput').is(':visible')){$('#siparisSwitch').prop('checked', false);}"
Response.Write "if($('#teslimatInput').is(':visible')){$('#teslimatSwitch').prop('checked', false);}"
Response.Write "if($('#teminatInput').is(':visible')){$('#teminatSwitch').prop('checked', false);}"
Response.Write "});"

Response.Write "</scr" & "ipt>"
	Response.Write "<scr" & "ipt type=""text/javascript"">"
			Response.Write "function sipnomiktargetir(sipno){"
			Response.Write "$('.ajCariSiparisler').val('');"
				Response.Write "$('.sipmiktartr .sipmiktarlari').each(function (index, value) {"
					Response.Write "var kacinciSiparis = $(this).attr('data-kacinciSiparis');"
					Response.Write "var sipmiktar = $(this).attr('data-sipmiktar');"
					Response.Write "var urunad = $(this).attr('data-urunad');"
					Response.Write "var ihaleUrunTalepID = $(this).attr('data-ihaleUrunTalepID');"
					Response.Write "if(sipno==kacinciSiparis){"
					Response.Write "$('.sip'+ihaleUrunTalepID).val(sipmiktar);"
					Response.Write "}"
				Response.Write "});"
			Response.Write "}"
	Response.Write "</scr" & "ipt>"
%>

<script>//ajSave kayıt işlemleri

    $(document).on('change','.ajSave',function() {
<% if instr(yetki,",3,") = 0 then %>

		var hamID = $(this).attr('id');
		$(this).closest('div').html("<img src='/image/working2.gif' width='20' height='20'/>");

		arr 	= hamID.split('|');
		alan 	= arr[0];
		id 		= arr[1];
		tablo 	= arr[2];
		
    $.ajax({
        type:'POST',
        url :'/dosya/hucre_kaydet.asp',
        data :{'alan':alan,'id':id,'tablo':tablo,'modulID':<%=modulID%>,'deger':$(this).val(),
                	},
        beforeSend: function() {
				$(this).closest('div').html("<img src='/image/working2.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];

						if(p_sonuc == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.success('Değişiklik kayıt edildi.','İşlem Yapıldı!');
						}
						else if(p_sonuc == "cariID"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.success('Değişiklik kayıt edildi.','İşlem Yapıldı!');
							location.reload();
						}
						else if(p_sonuc == "teklif_verilmeyecek"){
							toastr.options.positionClass = 'toast-bottom-center';
							toastr.options.closeButton = true;
							toastr.options.timeOut = 0;
							toastr.options.extendedTimeOut = 0;
							toastr.options.onclick = function() { modalajax('','/dosya/girilmeyecek_modal.asp?id=<%=id64%>'); }
							toastr.warning('Teklif verilmeme sebebi girişi için tıklayınız.','İşlem Yapıldı!');
						}
						else if(p_sonuc == "emailBos"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.error('- Bu epostayı alma yetkisine sahip kullanıcı yok.<br>veya<br>- Tanımlı eposta adresi yok.','Eposta gönderilmedi!');
						}
						else if(p_sonuc == "firmaUrun"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.error('- Ürünlerin stok karşılıkları seçilmiş, Firma değişikliği yapılamaz.<br>- Stok karşılıklarını silerek tekrar deneyiniz.','Firma değiştirilmedi!');
						}
						else if(p_sonuc == "topluAlim"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.error('- Toplu Alım sekmesinde kurumlar tanımlı, Firma değişikliği yapılamaz.<br>- Toplu Alım kurumlarını silerek tekrar deneyiniz.','Firma değiştirilmedi!');
						}
						else{
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.error('Kayıt yapılmadı.','İşlem Başarısız!');
						};
								$.get('/dosya/detay/<%=id64%>', function(data){
											var $data = $(data);
											$('#anaVeri').html($data.find('#anaVeri').html());
											$('#sayfaAdi').html($data.find('#sayfaAdi').html());
											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#urunler2Tablo').html($data.find('#urunler2Tablo').html());
											$('#urunlerInput').html($data.find('#urunlerInput').html());
											$('#sozlesmeListe').html($data.find('#sozlesmeListe').html());
											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
											$('#isArttirim').html($data.find('#isArttirim').html());
											$('#siparisInput').html($data.find('#siparisInput').html());
											$('#siparisTablo').html($data.find('#siparisTablo').html());
											$('#teslimatTablo').html($data.find('#teslimatTablo').html());
											$('#teminatTablo').html($data.find('#teminatTablo').html());
											$('#uts').html($data.find('#uts').html());
											//$('.gruptaYok').hide();
											$('.def-kapali').hide('slow');
								});//tablolar güncellendi
								
							
			}
    });
	<% 
	else
		response.Write "toastr.options.positionClass = 'toast-bottom-right';toastr.info('Kayıt yapma yetkisi tanımlanmamış.','Yetki yok!');"
	end if 'yetki%>
    });
</script><!--ajSave kayıt işlemleri-->

<script>

    $(document).on('click','.cariNotlar',function() {
		var cariID	=	<%=carisec%>
		var ihaleID	=	<%=id%>
		modalajaxfit('','/dosya/detay_modal_cariNotlar.asp?ihaleID='+ihaleID+'&cariID='+cariID);
		$('#modal-dialogfit').attr('tabindex','-1');
	});
	
</script><!--sözleşmeler sekmesinde karar ve sözleşme tarihi bölümlerine tıklandığında cari notlar modal gelsin-->

<script>//kayıt sil

    $(document).on('click','.ajSil',function() {
<% if instr(yetki,",4,") = 0 then %>
		var hamID = $(this).attr('id');

		arr 	= hamID.split('|');
		id	 	= arr[0];
		tablo	= arr[1];
		deger1	= arr[2];//sipariş silmede kacinciSiparis degeri alır -- teslimat faturası silmede kaçıncı fatura değeri alır -- stok karşılık silmede "stokKarsilik" gelir.
		deger2	= arr[3];//teslimat faturası silmede "kacinciSiparis" degeri alır, sipariş bağlantılı teslimatta sipariş işlemleri için.
		
			swal({
			title: 'Kayıt silinecek?',
			type: 'warning',
			showCancelButton: true,
			  confirmButtonColor: '#DD6B55',
			  confirmButtonText: 'sil',
			  cancelButtonText: 'hayır'
			}).then(
			  function(result) {
				// handle Confirm button click
				// result is an optional parameter, needed for modals with input
		
					$.ajax({
						type:'POST',
						url :'/dosya/sil.asp',
						data :{'id':id,
								'tablo':tablo,
								'deger1':deger1,
								'deger2':deger2,
								'modulID':<%=modulID%>,
									},
						beforeSend: function() {
				
							//$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
						  },
								success: function(sonuc) {
										//alert(sonuc);
										sonucc = sonuc.split('|');
										p_sonuc = sonucc[0];
										
										if(p_sonuc == "ok"){
											toastr.options.positionClass = 'toast-bottom-right';
											toastr.options.progressBar = true;
											toastr.success('Kayıt silindi.','İşlem Yapıldı!');
										}
										else if(p_sonuc == "teslimatVar"){
											toastr.options.positionClass = 'toast-bottom-right';
											toastr.options.progressBar = true;
											toastr.info('Teslimat kaydı var. Önce teslimat kayıtları silinmeli','İşlem Başarısız!');
										}
										else if(p_sonuc == "siparisVar"){
											toastr.options.positionClass = 'toast-bottom-right';
											toastr.options.progressBar = true;
											toastr.info('Cariye ait SİPARİŞ kaydı var, önce sipariş kaydı silinmeli.','İşlem Başarısız!');
										}
										else{
											toastr.options.positionClass = 'toast-bottom-right';
											toastr.options.progressBar = true;
											toastr.error('Kayıt silinemedi.','İşlem Başarısız!');
										};
												$.get('/dosya/detay/<%=id64%>', function(data){
															var $data = $(data);
															$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
															$('#urunlerTablo').html($data.find('#urunlerTablo').html());
															$('#urunler2Tablo').html($data.find('#urunler2Tablo').html());
															$('#sozlesmeInput').html($data.find('#sozlesmeInput').html());
															$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
															$('#sozlesmeListe').html($data.find('#sozlesmeListe').html());
															$('#teminatTablo').html($data.find('#teminatTablo').html());
															$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
															$('#siparisTablo').html($data.find('#siparisTablo').html());
															$('#teslimatTablo').html($data.find('#teslimatTablo').html());
															$('#isArttirim').html($data.find('#isArttirim').html());
															$('.def-kapali').hide('slow');
												});//tablolar güncellendi
												
										}
					});//ajax işlemi sonu
					
			  }, //confirm buton yapılanlar
			  function(dismiss) {
				// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			  } //cancel buton yapılanlar		
			);//swal sonu
	<% 
	else
		response.Write "toastr.options.positionClass = 'toast-bottom-right';toastr.info('Silme yetkisi tanımlanmamış.','Yetki yok!');"
	end if 'yetki%>
    });
    </script><!--ajSil kayıt sil-->
	
	
	
	
	
<script>//yaklaşık maliyet aşım sebepli kalem iptal

    $(document).on('click','.YMiptal',function() {
<% if instr(yetki,",3,") = 0 then %>
		var iuID = $(this).attr('data-iuID');
		
		var baslik = 'Kalem yaklaşık maliyet aşımı sebepli iptal edildi mi?'
		if($(this).closest('td').hasClass('bg-warning')){
			var baslik = 'Yaklaşık Maliyet iptal işlemi geri alınsın mı?'
		}
		
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
		
					$.ajax({
						type:'POST',
						url :'/dosya/hucre_kaydet.asp',
						data :{'id':iuID,
								'tablo':'ihale_urun',
								'alan':'YMiptal',
									},
						beforeSend: function() {
				
							//$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
						  },
								success: function(sonuc) {
										//alert(sonuc);
										sonucc = sonuc.split('|');
										p_sonuc = sonucc[0];
										
										if(p_sonuc == "ok"){
											toastr.options.positionClass = 'toast-bottom-right';
											toastr.options.progressBar = true;
											toastr.success('Yaklaşık Maliyet sebepli ürün iptal.','İşlem Yapıldı!');
										}
										else{
											toastr.options.positionClass = 'toast-bottom-right';
											toastr.options.progressBar = true;
											toastr.error('İşlem Yapılamadı.','İşlem Başarısız!');
										};
												$.get('/dosya/detay/<%=id64%>', function(data){
															var $data = $(data);
															$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
															$('#urunlerTablo').html($data.find('#urunlerTablo').html());
															$('#urunler2Tablo').html($data.find('#urunler2Tablo').html());
															$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
															$('#isArttirim').html($data.find('#isArttirim').html());
															$('.def-kapali').hide('slow');
												});//tablolar güncellendi
												
										}
					});//ajax işlemi sonu
					
			  }, //confirm buton yapılanlar
			  function(dismiss) {
				// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			  } //cancel buton yapılanlar		
			);//swal sonu
	<% 
	else
		response.Write "toastr.options.positionClass = 'toast-bottom-right';toastr.info('Silme yetkisi tanımlanmamış.','Yetki yok!');"
	end if 'yetki%>
    });
    </script><!--yaklaşık maliyet aşım sebepli kalem iptal-->
	
<script>//uhde işlemleri

    $(document).on('click','.ajUhde',function() {

		var hamID = $(this).attr('id');

		arr 		= hamID.split('|');
		id 			= arr[0];
		tablo 		= arr[1];
		ihaleUrunID	= arr[2];
		islem		= arr[3];
		
    $.ajax({
        type:'POST',
        url :'/dosya/uhde_kaydet.asp',
        data :{'id':id,
				'tablo':tablo,
				'ihaleUrunID':ihaleUrunID,
				'islem':islem,
				'modulID':<%=modulID%>,
                	},
        beforeSend: function() {

            //$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						
						if(p_sonuc == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.success('Uhde kaydı başarılı.','İşlem Yapıldı!');
						}
						else if(p_sonuc == "uruniptal"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.info('Kalem iptal edilmiş, uhde kaydı yapılamaz','İşlem Yapılmadı!');
						}
						else{
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.error('Kayıt yapılmadı.','İşlem Başarısız!');
						};
								$.get('/dosya/detay/<%=id64%>', function(data){
											var $data = $(data);
											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
											$('#sozlesmeInput').html($data.find('#sozlesmeInput').html());
											$('#siparisInput').html($data.find('#siparisInput').html());
											$('#teslimatTablo').html($data.find('#teslimatTablo').html());
											$('#isArttirim').html($data.find('#isArttirim').html());
								});//tablolar güncellendi
								
						}
    });
    });
    </script><!--uhde işlemleri-->

<script>//fiyatiptal işlemleri

    $(document).on('click','.ajFiyatiptal',function() {

		var hamID = $(this).attr('id');

		arr 		= hamID.split('|');
		id 			= arr[0];
		tablo 		= arr[1];
		ihaleUrunID	= arr[2];
		islem		= arr[3];
		
    $.ajax({
        type:'POST',
        url :'/dosya/fiyatiptal_kaydet.asp',
        data :{'id':id,
				'tablo':tablo,
				'ihaleUrunID':ihaleUrunID,
				'islem':islem,
				'modulID':<%=modulID%>,
                	},
        beforeSend: function() {

            //$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						
						if(p_sonuc == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.success('Fiyat İptal kaydı başarılı.','İşlem Yapıldı!');
						}
						else{
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.error('Kayıt yapılmadı.','İşlem Başarısız!');
						};
								$.get('/dosya/detay/<%=id64%>', function(data){
											var $data = $(data);
											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
											$('#isArttirim').html($data.find('#isArttirim').html());
								});//tablolar güncellendi
								
						}
    });
    });
    </script><!--fiyatiptal işlemleri-->
	
<script>//Uruniptal işlemleri

    $(document).on('click','.ajUruniptal',function() {

		var hamID = $(this).attr('id');

		arr 		= hamID.split('|');
		id 			= arr[0];
		tablo 		= arr[1];
		
    $.ajax({
        type:'POST',
        url :'/dosya/uruniptal_kaydet.asp',
        data :{'id':id,
				'tablo':tablo,
				'modulID':<%=modulID%>,
                	},
        beforeSend: function() {

            //$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						
						if(p_sonuc == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.success('Kayıt başarılı.','İşlem Yapıldı!');
						}
						else{
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.error('Kayıt yapılmadı.','İşlem Başarısız!');
						};
								$.get('/dosya/detay/<%=id64%>', function(data){
											var $data = $(data);
											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
											$('#siparisUrunler').html($data.find('#siparisUrunler').html());
											$('#isArttirim').html($data.find('#isArttirim').html());
								});//tablolar güncellendi
								
						}
    });
    });
    </script><!--Urun iptal işlemleri-->
	
<script>//Dosyaya ihale no ver/sil

    $(document).on('click','.btnIhaleNo',function() {

		var ihaleID = <%=id%>


    $.ajax({
        type:'POST',
        url :'/dosya/dosyaNoVerSil.asp',
        data :{'ihaleID':ihaleID,
                	},
        beforeSend: function() {

            //$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						
						if(p_sonuc == "noVer"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.success('İhale Numarsı Tanımlandı.','İşlem Yapıldı!');
						}
						else if(p_sonuc == "noAl"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.warning('İhale Numarası Silindi.','İşlem Yapıldı!');
						};
								$.get('/dosya/detay/<%=id64%>', function(data){
											var $data = $(data);
											$('#ihaleNoVer').html($data.find('#ihaleNoVer').html());
								});//tablolar güncellendi
						}
    });
    });
    </script><!--Dosyaya ihale no ver/sil-->
	
<script>//miktar aktarım işlemleri

    $(document).on('click','.ajAktar',function() {

		var hamID = $(this).attr('id');

		arr 		= hamID.split('|');
		ihaleID 	= arr[0];
		ihaleUrunID	= arr[1];
		iutID	 	= arr[2];
		carilerID	= arr[3]
		
		var cariID = $('#degermodal'+iutID).val();
		var miktar = $('#miktar'+iutID).val();

    $.ajax({
        type:'POST',
        url :'/dosya/urun_aktar.asp',
        data :{'ihaleID':ihaleID,
				'ihaleUrunID':ihaleUrunID,
				'alanCariID':cariID,
				'iutID':iutID,
				'miktar':miktar,
				'verenCariID':carilerID,
                	},
        beforeSend: function() {

            //$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						
						if(p_sonuc == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.success('Ürün değişikliği kayıt edildi.','İşlem Yapıldı!');
						}
						else if(p_sonuc == "ayniKurum"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.error('Aynı kuruma aktarım yapılamaz.','İşlem Başarısız!');
						}
						else if(p_sonuc == "miktarYanlis"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.error('Miktar yanlış.','İşlem Başarısız!');
						};
								$.get('/dosya/detay/<%=id64%>', function(data){
											var $data = $(data);
											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
											$('#teslimatTablo').html($data.find('#teslimatTablo').html());
											$('#isArttirim').html($data.find('#isArttirim').html());
								});//tablolar güncellendi
								
						}
    });
    });
    </script><!--miktar aktarım işlemleri-->
	
<script>
	
	$(document).on('click','.urunKaydet', function() {
		
		var chckID = $(this).attr('id');
	
	$.ajax({
		type: 'POST',
		url: '/dosya/liste_kaydet.asp',
		
		data: {'ihaleID':'<%=id64%>','veri':$('#veri'+chckID).val(),
		},
		
//		beforeSend: function() {
//			$('#div_urun_sec<%=urun_satir%>').html("<img src='image/loading__.gif' width='20' height='20'/>");
//		  },
				  
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						
						if(p_sonuc == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.success('Ürün kayıt edildi.','İşlem Yapıldı!');
						}
						else if(p_sonuc == "kayitli"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.info('Ürün zaten kayıtlı.','İşlem yapılmadı!');
						}
						else{
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.error('Kayıt yapılmadı.','İşlem Başarısız!');
						};
								$.get('/dosya/detay/<%=id64%>', function(data){
											var $data = $(data);
											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#urunler2Tablo').html($data.find('#urunler2Tablo').html());
											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
											$('#isArttirim').html($data.find('#isArttirim').html());
								});//tablolar güncellendi
								
						}
	});
	});
</script><!--excel listeden ürün kayıt işlemleri-->

<script>//ajEkUrun kayıt işlemleri

    $(document).on('change','.ajEkUrun',function() {

		var hamID = $(this).attr('id');

		arr 		= hamID.split('|');
		ihaleUrunID = arr[1];

		
    $.ajax({
        type:'POST',
        url :'/dosya/ek_urun_kaydet.asp',
        data :{'ihaleID':<%=id%>,'modulID':<%=modulID%>,'ihaleUrunID':ihaleUrunID,'stoklarID':$(this).val(),
                	},
        beforeSend: function() {

            //$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						
						if(p_sonuc == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.success('Değişiklik kayıt edildi.','İşlem Yapıldı!');
						}
						else if(p_sonuc == "mevcut"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.info('Kayıt yapılmadı.','Ürün zaten kayıtlı!');
						}
						else if(p_sonuc == "onceStokSec"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.info('Önce Stok Karşılığını seçiniz.','Kayıt yapılmadı!');
						}
						else{
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.error('Kayıt yapılmadı.','İşlem Başarısız!');
						};
								$.get('/dosya/detay/<%=id64%>', function(data){
											var $data = $(data);
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#urunler2Tablo').html($data.find('#urunler2Tablo').html());
											//$('.gruptaYok').hide();
											$('.def-kapali').hide('slow');
								});//tablolar güncellendi
								
							
			}
    });
    });
    </script><!--ajEkUrun kayıt işlemleri-->

<script>
    $(document).on('change','#urunsec',function() {
		if($('#urunAd').val() == ""){
			$('#urunAd').val($('#urunsec option:selected').text());
		}
	});
</script>

<script>
	
	$(document).on('change','.ajSipVeren', function() {
		
		var sipCariID = $(this).val();
		
		$('#siparisUrunler').html("<img src='/image/working2.gif' width='70' height='70'/>");

		toastr.options.positionClass = 'toast-bottom-right';
		toastr.info('','Ürünler yükleniyor.');

		$.get('/dosya/detay/<%=id64%>/'+sipCariID, function(data){
					var $data = $(data);
					$('#siparisUrunler').html($data.find('#siparisUrunler').html());
		});//tablolar güncellendi
		
	});
</script><!--sipariş sekmesi cari select değişikliği-->

<script>
	
	$(document).on('change','.ajTeslimatCari', function() {
		
		var tesCariID = $(this).val();
		
		$('#teslimatUrunler').html("<img src='/image/working2.gif' width='70' height='70'/>");

		toastr.options.positionClass = 'toast-bottom-right';
		toastr.info('','Ürünler yükleniyor.');

		$.get('/dosya/detay/<%=id64%>/'+tesCariID, function(data){
					var $data = $(data);
					$('#teslimatUrunler').html($data.find('#teslimatUrunler').html());
					$('#cariSipListe').html($data.find('#cariSipListe').html());
		});//tablolar güncellendi
		
	});
</script><!--teslimat sekmesi cari select değişikliği-->

<script>
	$(document).ready(function() {
		$('#urunlerInput').toggle('slow');
		$('#sozlesmeInput').toggle('slow');
		$('#teminatInput').toggle('slow');
		$('#siparisInput').toggle('slow');
		$('#teslimatInput').toggle('slow');
		$('.def-kapali').hide('slow');
	});

</script>

<script><!--firmam değişirse cariler select'i sil yeniden yükle-->

    $(document).on('change','.firmasec',function() {

	//$("#cariDIV").load("detay.asp .cariDIV>*");
	//$("#cariDIV2").load("detay.asp .cariDIV2>*");
	
	$(".carisec").select2('destroy');
	//$('#cariDIV').html("<img src='/image/working2.gif' width='20' height='20'/>");
	});
	
</script>


<script>
    $(document).on('mouseenter','#urunsec',function() {
		var firmaID = $('.firmasec').val();
	
		
$("#urunsec").select2({	

  ajax: {
    url: "/dosya/JSON_urunler.asp",
    dataType: 'json',
    delay: 250,
    data: function (params) {
      return {
		firmaid: firmaID,
        q: params.term, // search term
        page: params.page
      };
    },
    processResults: function (data, params) {
      // parse the results into the format expected by Select2
      // since we are using custom formatting functions we do not need to
      // alter the remote JSON data, except to indicate that infinite
      // scrolling can be used
      params.page = params.page || 1;

      return {
        results: data.items,
//        pagination: {
//          more: (params.page * 30) < data.total_count
//        }
      };
    },
    cache: true
  },
  width: '100%',
  minimumInputLength: 3,
  theme: 'bootstrap',
  placeholder: 'Liste Kalemi stok karşılığı seçimi yapınız.',
  allowClear: true,
  closeOnSelect: true,
});	
       });
</script>

<script><!--cariler select2 ajax load-->
    $(document).on('mouseenter','.carisec',function() {
			var firmaID = $('.firmasec').val();

	
		$(".carisec").select2({	
		
		  ajax: {
			url: "/dosya/JSON_cariler.asp",
			dataType: 'json',
			delay: 250,
			data: function (params) {
			  return {
				firmaid: firmaID,
				q: params.term, // search term
				page: params.page
			  };
			},
			processResults: function (data, params) {
			  // parse the results into the format expected by Select2
			  // since we are using custom formatting functions we do not need to
			  // alter the remote JSON data, except to indicate that infinite
			  // scrolling can be used
			  
			  params.page = params.page || 1;
		
			  return {
				results: data.items,
		//        pagination: {
		//          more: (params.page * 30) < data.total_count
		//        }
			  };
			},
			cache: true
		  },
		  width: '100%',
		  minimumInputLength: 3,
		  theme: 'bootstrap',
		  placeholder: 'Cari seçimi yapınız.',
		  allowClear: true
		});	
       });
</script><!--cariler select2 ajax load-->

<script>//LOT'a ait üretim tarihi bul
    $('.urTarihGetir').on('click', function() {

		var tLotID		= $('#tLotID').val();
		var lotNo		= $('#lotNo_'+tLotID).val();
					$.ajax({
						type:'POST',
						url :'/uts/lotUretimTar.asp',
						data :{'lotNo':lotNo,
									},
						beforeSend: function() {
				
							//$('#uretimTarih').html("<img src='/image/working2.gif' width='20' height='20'/>");
						  },
								success: function(sonuc) {
										//alert(sonuc);
										if (sonuc == 'tarihYok'){
										$('#uretimTarih_'+tLotID).val('');
										$('#uretimTarih_'+tLotID).css({'background-color':'#FFFFFF','color':'#000000','font-weight':'normal'});
										swal('Kayıtlı üretim tarihi bulunamadı.','Üretim tarihi girişini el ile yapınız.');
										}
										if (sonuc != 'tarihYok'){
										$('#uretimTarih_'+tLotID).css({'background-color':'#5f9ea0','color':'#FFFFFF','font-weight':'bold'});
										$('#uretimTarih_'+tLotID).val(sonuc);
										}
									}
					});//ajax işlemi sonu
    });
</script><!--LOT'a ait üretim tarihi bul-->

<script>
	$(document).ready(function() {
		
    $('a[data-toggle="tab"]').on('click', function(e) {
        window.sessionStorage.setItem('activeTab', $(e.target).attr('href'));
    });
	
    var activeTab = window.sessionStorage.getItem('activeTab');
    
	if (activeTab) {
        $('#sekmeler a[href="' + activeTab + '"]').tab('show');
       // window.sessionStorage.removeItem("activeTab")
		};
    });

</script><!--activeTab sessionStorage-->


<script>//modal kapandığında içini boşalt
	$(document).on('hidden.bs.modal', function () {
     $('.modal-body').html('');
});

</script><!--modal kapandığında içini boşalt-->

<script>//urunlistediv excel'den ürün seçimi penceresi dışına tıklandığında kapansın checkbox'a tıklandığında kapanmasın
	$(document).mouseup(function (e) {
	
		 if (!$('.urunlistebutton').is(e.target) && !$(".urunlistediv").is(e.target) && $(".urunlistediv").has(e.target).length == 0) {
			 $(".urunlistediv").addClass('d-none');
		 }
	 });
 </script><!--urunlistediv excel'den ürün seçimi penceresi dışına tıklandığında kapansın checkbox'a tıklandığında kapanmasın-->


