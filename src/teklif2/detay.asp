<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	arama					=	Request.Form("arama")
	id64					=	Session("sayfa5")
	gelenadres6				=	Session("sayfa6")
	
	if gelenadres6 		= "" then
		sipVerenCari 	= 0
		faturaCari		= 0
	else
		sipVerenCari 	= gelenadres6
		faturaCari		= gelenadres6
	end if
	id						=	id64
	id						=	base64_decode_tr(id)
	ihaleID					=	id
	
	'entProgDB	=	entProgDBbul(id)


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    modulID =   "109"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


'##### YETKİ BUL
'##### YETKİ BUL
	sorgu			=	""
	sayfaadi		=	"Dosya Detay"
	yetkiKontrol 	=	yetkibul(modulAd)



'##### YETKİ BUL
'##### YETKİ BUL

if yetkiKontrol  >= 3 then
		
		response.Flush()
	'##### ANA VERİ ÇEK
	'##### ANA VERİ ÇEK
		sorgu = "Select i.id, i.ad, i.ikn, i.teslimatKosul, i.odemeKosul, i.tarih_ihale, i.firmaID, ISNULL(i.cariID,0) as cariID, i.durum, i.sipDurum, i.grupIhale, i.ihaleTipi,"
		sorgu = sorgu & " i.dosyaNo, i.dosyaSorumlu, i.odemeVade, i.teklifGecerlik, i.teslimatSure, i.yeniCariVergiNo, i.satirKDV, i.catKodGoster, i.mustKodGoster,"
		sorgu = sorgu & " i.mukayeseDurum, i.girilecek, i.ilanTarih, ISNULL(i.bayiDosyaTipi,'yok') as bayiDosyaTipi, i.bayiKurumID, i.yaklasikMalGoster, i.epostaGovde,"
		sorgu = sorgu & " ISNULL(i.ihaleNo,0) as ihaleNo, i.eEksiltme, i.yerliOranGoster, i.kodlamaBitti, i.teklifNot, ISNULL(i.miktarArttirimi,0) as miktarArttirimi,"
		sorgu = sorgu & " i.dosyaKayitTip, i.teklifKase, i.teklifAntet, i.teklifKDV, i.altTopGoster, f.dogTeminDosya, i.yeniCariAd, i.bankalar, i.teklifEposta, i.epostaGovde,"
		sorgu = sorgu & " k.pdfKaynakDosya as teklifSablon, k.landscapeDeger, i.teklifMusteriOnay, i.ekMaliyet1, i.ekMaliyet1Deger, i.ekMaliyet1Birim,"
		sorgu = sorgu & " i.ekMaliyet2, i.ekMaliyet2Deger, i.ekMaliyet2Birim"
		sorgu = sorgu & " FROM teklifv2.ihale i"
		sorgu = sorgu & " LEFT JOIN portal.firma f ON i.firmaID = f.id"
		sorgu = sorgu & " LEFT JOIN kalite.form k ON i.pdfSablon = k.pdfKaynakDosya"
		sorgu = sorgu & " WHERE i.firmaID = " & firmaID & " AND i.id = " & ihaleID
		rs.open sorgu,sbsv5,1,3
		
			
			ad 					=	rs("ad")
			cariID				=	rs("cariID")
			dosyaNo				=	rs("dosyaNo")
			ihaleNo				=	rs("ihaleNo")
			dosyaKayitTip		=	rs("dosyaKayitTip")
			ikn					=	rs("ikn")
			dosyaDurum			=	rs("durum")
			sipDurum			=	rs("sipDurum")
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
			teklifKase			=	rs("teklifKase")
			teklifAntet			=	rs("teklifAntet")
			teklifSablon		=	rs("teklifSablon")
			teklifKDV			=	rs("teklifKDV")
			satirKDV			=	rs("satirKDV")
			teklifMusteriOnay	=	rs("teklifMusteriOnay")
			ekMaliyet1			=	rs("ekMaliyet1")
			ekMaliyet1Deger		=	rs("ekMaliyet1Deger")
			ekMaliyet1Birim		=	rs("ekMaliyet1Birim")
			ekMaliyet2			=	rs("ekMaliyet2")
			ekMaliyet2Deger		=	rs("ekMaliyet2Deger")
			ekMaliyet2Birim		=	rs("ekMaliyet2Birim")
			altTopGoster		=	rs("altTopGoster")
			epostaGovde			=	rs("epostaGovde")
			bankalar			=	rs("bankalar")
			teklifEposta		=	rs("teklifEposta")
			catKodGoster		=	rs("catKodGoster")
			mustKodGoster		=	rs("mustKodGoster")
			landscapeDeger		=	rs("landscapeDeger")
			yeniCariVergiNo		=	rs("yeniCariVergiNo")
			yeniCariAd			=	rs("yeniCariAd")
			a = instr(yeniCariAd,"<div>")
			if a > 0 then
				yeniCariAd = LEFT(yeniCariAd,a)
			end if
			rs.close
			
	'##### /ANA VERİ ÇEK
	'##### /ANA VERİ ÇEK
	
	'############ İHALE TARİHİNDEKİ KURLARI ÇEK
	'############ İHALE TARİHİNDEKİ KURLARI ÇEK

	
		if not isnull(tarih_ihale) then
			

			USDkur	=	dovizBulTarih("usdtry", tarih_ihale)
			EURkur	=	dovizBulTarih("eurtry", tarih_ihale)
			
			' sorgu = "SELECT usdtry, eurtry FROM portal.doviz WHERE tarih = " & "'" & kurTarih & "'"
			' rs.open sorgu,sbsv5,1,3
			' 	if not rs.EOF then
			' 		USDkur	=	rs("usdtry")
			' 		EURkur	=	rs("eurtry")
			' 	end if
			' rs.close			
		else
			USDkur 	= 0
			EURkur	= 0
		end if
	
	'############ /İHALE TARİHİNDEKİ KURLARI ÇEK
	'############ /İHALE TARİHİNDEKİ KURLARI ÇEK
	
	'##### CARİLERİ ÇEK
	'##### CARİLERİ ÇEK
			if isnull(cariSec) OR cariSec = 0 then
				DosyaCariAd	= "<code>Kayıtlı olmayan bir cariye teklif verilmiş.</code> "
			else
				sorgu = "Select c.cariID, cariAd, c.firmaID, c.email FROM cari.cari c WHERE c.firmaID = " & firmaID & " AND c.cariID = " & carisec
				rs.open sorgu,sbsv5,1,3
				if rs("firmaID") <> firmasec then
					DosyaCariAd = "<code>seçili cari bu firmaya ait değil!!Mutlaka tekrar seçilmeli.</code> "&rs("cariAd")
				else
					DosyaCariAd = rs("cariAd")
					cariEmail	= rs("email")
				end if
				rs.close
			end if
	'##### /CARİLERİ ÇEK
	'##### /CARİLERİ ÇEK
	
	'##### FİRMALARIMI ÇEK
	'##### FİRMALARIMI ÇEK
				sorgu = "Select id, ad as firmaAD from portal.firma WHERE id = " & firmaID
				rs.open sorgu,sbsv5,1,3
					degerler = "=|"
					do while not rs.eof
						degerler = degerler & rs("firmaAD")
						degerler = degerler & "="
						degerler = degerler & rs("id")
						degerler = degerler & "|"
					rs.movenext
					loop
					if degerler = "" then
					else
						degerler = left(degerler,len(degerler)-1)
					end if
				rs.close
				firmalardegerler = degerler
	'##### /FİRMALARIMI ÇEK
	'##### /FİRMALARIMI ÇEK

	'##### TEKLİF ŞABLONLARINI ÇEK
	'##### TEKLİF ŞABLONLARINI ÇEK
		sorgu = "SELECT formID, pdfKaynakDosya FROM kalite.form WHERE firmaID = " & firmaID & " AND formAd = 'Teklif'"
		rs.open sorgu,sbsv5,1,3
			degerler = "=|"
			do while not rs.eof
				degerler = degerler & rs("pdfKaynakDosya")
				degerler = degerler & "="
				degerler = degerler & rs("formID")
				degerler = degerler & "|"
			rs.movenext
			loop
			if degerler = "" then
			else
				degerler = left(degerler,len(degerler)-1)
			end if
		rs.close
		teklifSablonDegerler = degerler
	
	'##### /TEKLİF ŞABLONLARINI ÇEK
	'##### /TEKLİF ŞABLONLARINI ÇEK



	'##### KULLANICILARI ÇEK
	'##### KULLANICILARI ÇEK
			sorgu = "select k.ad, k.id from personel.personel k where k.firmaID = " & firmaID & " order by k.ad asc"
				rs.open sorgu,sbsv5,1,3
					degerler = "=|"
					do while not rs.eof
						degerler = degerler & rs("ad")
						degerler = degerler & "="
						degerler = degerler & rs("id")
						degerler = degerler & "|"
					rs.movenext
					loop
					if degerler = "" then
					else
						degerler = left(degerler,len(degerler)-1)
					end if
				rs.close
				kullanicilarDegerler = degerler
	'##### /KULLANICILARI ÇEK
	'##### /KULLANICILARI ÇEK
	
	
	
	
	
	'##### DOSYA TİPLERİNİ SELECT İÇİN HAZIRLA
	'##### DOSYA TİPLERİNİ SELECT İÇİN HAZIRLA

				dosyaTipDegerler = "=|Doğrudan Temin=dog_temin|Özel Hastane=ozel_hast|FirmaBayi=bayi|İhracat Proforma=proforma"
				
	'##### /DOSYA TİPLERİNİ SELECT İÇİN HAZIRLA
	'##### /DOSYA TİPLERİNİ SELECT İÇİN HAZIRLA
	
	
	'##### PARA BİRİMLERİ SELECT İÇİN HAZIRLA
	'##### PARA BİRİMLERİ SELECT İÇİN HAZIRLA
	
				paraBirimDegerler = "=|TL=TL|EUR=EUR|USD=USD|GBP=GBP"
				
	'##### /PARA BİRİMLERİ SELECT İÇİN HAZIRLA
	'##### /PARA BİRİMLERİ SELECT İÇİN HAZIRLA
	
	
	'##### SAYFA YÖNÜ SELECT İÇİN HAZIRLA
	'##### SAYFA YÖNÜ SELECT İÇİN HAZIRLA

				sayfaYonDegerler = "=|Dikey=0|Yatay=1"
				
	'##### SAYFA YÖNÜ SELECT İÇİN HAZIRLA
	'##### SAYFA YÖNÜ SELECT İÇİN HAZIRLA

	'##### YERLİ MALI DEĞERLER SELECT İÇİN HAZIRLA
	'##### YERLİ MALI DEĞERLER SELECT İÇİN HAZIRLA

				yerliMaliDegerler = "=|HAYIR=0|EVET=1"
				
	'##### /YERLİ MALI DEĞERLER SELECT İÇİN HAZIRLA
	'##### /YERLİ MALI DEĞERLER SELECT İÇİN HAZIRLA

	'##### MUKAYESE DURUM DEĞERLER SELECT İÇİN HAZIRLA
	'##### MUKAYESE DURUM DEĞERLER SELECT İÇİN HAZIRLA

				mukayeseDurumDegerler = "BEKLENİYOR=0|GELDİ=geldi|GELMEYECEK=gelmeyecek"
				
	'##### /MUKAYESE DURUM DEĞERLER SELECT İÇİN HAZIRLA
	'##### /MUKAYESE DURUM DEĞERLER SELECT İÇİN HAZIRLA
	
	'##### BAYİ DOSYA TİPİ SELECT İÇİN HAZIRLA
	'##### BAYİ DOSYA TİPİ SELECT İÇİN HAZIRLA

				bayiDosyaTipiDegerler = "=|İhale Fiyatı=ihaleFiyati|Özel Hastane=ozelHast|Stok=stok|Doğrudan Temin=dogTemin|Yaklaşık Maliyet=bayiYaklasik"
				
	'##### /BAYİ DOSYA TİPİ SELECT İÇİN HAZIRLA
	'##### /BAYİ DOSYA TİPİ SELECT İÇİN HAZIRLA
	
	'##### DOSYA DURUM SELECT İÇİN HAZIRLA
	'##### DOSYA DURUM SELECT İÇİN HAZIRLA

				dosyaDurumDegerler = "=|Normal=normal|Uhdemizde Ürün Kalmadı=urunKalmadi"
				
	'##### /DOSYA DURUM SELECT İÇİN HAZIRLA
	'##### /DOSYA DURUM SELECT İÇİN HAZIRLA
	
	'##### SİPARİŞ DURUM SELECT İÇİN HAZIRLA
	'##### SİPARİŞ DURUM SELECT İÇİN HAZIRLA

				sipDurumDegerler = "=|BEKLENİYOR=BEKLENİYOR|GELDİ=GELDİ"
				
	'##### /SİPARİŞ DURUM SELECT İÇİN HAZIRLA
	'##### /SİPARİŞ DURUM SELECT İÇİN HAZIRLA
	
	

'####### dosyaya ihaleNo tanımlanmış ise yetkisi olmayan belirli alanları değiştiremesin.
'####### dosyaya ihaleNo tanımlanmış ise yetkisi olmayan belirli alanları değiştiremesin.
	userYetki	=	instr(yetki,",12,")	'eğer 1 döndürürse yetki yok demektir.
	iptalKontrol = ""
	if not isnull(ihaleNo) AND  userYetki = 1 then
		iptalKontrol	=	"disabled"
	end if
'####### dosyaya ihaleNo tanımlanmış ise yetkisi olmayan belirli alanları değiştiremesin.

'##### TABLO
'##### TABLO
			if isnull(cariSec) OR cariSec = 0 then
				alimYapan	= "<code>" & yeniCariAd & "</code> "
			else
				sorgu = "SELECT cariID, cariAD FROM cari.cari WHERE cariID = " & cariID
				rs.open sorgu,sbsv5,1,3
				alimYapan 	=	rs("cariAD")
				cariID		=	rs("cariID")
				defDeger 	= cariID&"###"&alimYapan
				rs.close
			end if
Response.Write "<div class=""row"">"
Response.Write "<div class=""col-lg-12"">"
Response.Write "<div class=""card"">"
Response.Write "<div class=""card-header"" id=""sayfaAdi"">"
	'Response.Write "<a class=""btn btn-info rounded px-1 py-0"" target="""" href=""/teklifSablon/" & teklifSablon & "/" & id64 & """><i class=""fa fa-envelope""></i></a>"
	Response.Write sayfaadi &" <i class=""fa fa-hand-o-right"" aria-hidden=""true""></i> "
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
	
		Response.Write "<li class=""nav-item"">"
		Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#anaVeri"" role=""tab"" aria-controls=""anaVeri"">Ana Veri</a>"
		Response.Write "</li>"
	
		Response.Write "<li class=""nav-item"">"
		Response.Write "<a class=""active nav-link fontkucuk"" data-toggle=""tab"" href=""#urunler"" role=""tab"" aria-controls=""urunler"">Ürünler</a>"
		Response.Write "</li>"
			
		Response.Write "<li class=""nav-item"">"
		Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#teklif"" role=""tab"" aria-controls=""teklif"">Teklif Ayarları</a>"
		Response.Write "</li>"
		
		Response.Write "<li class=""nav-item"" id=""onizlemeTAB"">"
		if teklifSablon <> "" then
			Response.Write "<a class=""nav-link fontkucuk"" href=""/teklifSablon/" & teklifSablon & "/" & id64 & """>"
		else
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#onizlemeDIV"" role=""tab"" aria-controls=""onizlemeDIV"">"
		end if
			Response.Write "Teklif Önizleme</a>"
		Response.Write "</li>"

	Response.Write "</ul>"
'##### /SEKMELER
'##### /SEKMELER

	Response.Write "<div class=""tab-content"">"
'##### ANA VERİ
'##### ANA VERİ
		
	Response.Write "<div class=""tab-pane"" id=""anaVeri"" role=""tabpanel"">"
		Response.Write "<input type=""hidden"" name=""ihaleID"" value=" & id & " />"	
		Response.Write "<div id=""anaVeriInput"" class="""">"
	
	Response.Write "<div class=""card-deck"">"
		Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-body"">"

			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-12"">"
					Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Firmam Seçimi</div>"
						call formselectv2("firmasec",firmasec,"ajSave('firmaID','teklifv2.ihale',"&id&",$(this).val())","","firmasec",iptalKontrol,"",firmalardegerler,"")		
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col"">"
					Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Cari Seçimi</div>"
					Response.Write "<div class=""fontkucuk2""><strong>Mevcut Cari :</strong>" & DosyaCariAd & "</div>"
					Response.Write "<div id=""cariDIV"">"
						call formselectv2("cariID","","ajSave('cariID','teklifv2.ihale',"&id&",$(this).val())","","formSelect2 cariID pb-2","","","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3"" ")			
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col"">"
					Response.Write "<div class=""btn btn-sm btn-info rounded mt-2"" onclick=""ajSave('cariID','teklifv2.ihale',"&id&",null)"">yeni cari</div>"
				Response.Write "</div>"
			Response.Write "</div>"
			if isnull(cariID) OR cariID = 0 OR cariID = "" then
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-12"">"
						Response.Write "<div class=""badge badge-info rounded-left mt-2"">Yeni Cari Vergi No</div>"
						Response.Write "<input onchange=""ajSave('yeniCariVergiNo','teklifv2.ihale',"&id&",$(this).val())"" class=""col-12 form-control"" type=""text"" value=""" & yeniCariVergiNo & """>"
					Response.Write "</div>"
				Response.Write "</div>"

				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col"">"
						Response.Write "<div class=""badge badge-info rounded-left mt-2"">Yeni Cari Ad</div><br>"
						Response.Write "<input onchange=""ajSave('yeniCariAd','teklifv2.ihale',"&id&",$(this).val())"" class=""col-12 form-control"" type=""text"" value=""" & yeniCariAd & """>"
					Response.Write "</div>"
				Response.Write "</div>"
			end if
				Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Dosya Tipi</div>"
					call formselectv2("tip",tip,"ajSave('tip','teklifv2.ihale',"&id&",$(this).val())","","",iptalKontrol,"",dosyaTipDegerler,"")
				
				'Response.Write "<div class="""&classYaz&""">"
				'Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Dosya Tipi</div>"
					'call formselectv2("bayiDosyaTipi",bayiDosyaTipi,"ajSave('bayiDosyaTipi','teklifv2.ihale',"&id&",$(this).val())","","",iptalKontrol,"",bayiDosyaTipiDegerler,"")
				'Response.Write "</div>"
				
				Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Dosya Sorumlusu</div>"
					call formselectv2("dosyaSorumlu",dosyaSorumlu,"ajSave('dosyaSorumlu','teklifv2.ihale',"&id&",$(this).val())","","","","",kullanicilarDegerler,"")
				
				' if dosyaKayitTip = "M" then
				' 	Response.Write "<div id=""ihaleNoVer"" class=""mt-1"">"
				' 	Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Dosya Numarası</div><br>"
				' 		if ihaleNo = "0" then
				' 			Response.Write "<button class=""btnIhaleNo btn btn-sm form-control btn-success rounded"">Dosyaya Numara Ver</button>"
				' 		else
				' 			Response.Write "<i class=""btn btnIhaleNo fa fa-trash text-danger""></i><strong>" & ihaleNo & "</strong>"
				' 		end if
				' 	Response.Write "</div>"
				' end if
			Response.Write "</div>"'card-body
		Response.Write "</div>"'card
		
		
		Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-body"">"
			
			Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Dosya Adı</div>"
				call forminput("ad",ad,"","Dosya Adı","","","","onChange=""ajSave('ad','teklifv2.ihale',"&id&",$(this).val())""")
	
			Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Alım Tarihi ve Saati</div>"
				call forminput("tarih_ihale",tarih_ihale,"ajSave('tarih_ihale','teklifv2.ihale',"&id&",$(this).val())","İhale Tarih"," tarih cell",iptalKontrol,"","")
				
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-lg-4"">"
					Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Ödeme Vadesi</div>"
					call forminput("odemeVade",odemeVade,"","(gün)","ajSave","","","onChange=""ajSave('odemeVade','teklifv2.ihale',"&id&",$(this).val())""")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-4"">"
					Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teklif Geçerlilik</div>"
					call forminput("teklifGecerlik",teklifGecerlik,"","Geçerlilik","","","","onChange=""ajSave('teklifGecerlik','teklifv2.ihale',"&id&",$(this).val())""")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-4"">"
					Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teslimat Süresi</div>"
					call forminput("teslimatSure",teslimatSure,"","Teslimat Süresi","","","","onChange=""ajSave('teslimatSure','teklifv2.ihale',"&id&",$(this).val())""")
				Response.Write "</div>"
			Response.Write "</div>"
			
			' Response.Write "<div class=""row"">"
			' 		Response.Write "<div class=""col-12"">"
			' 			Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Ödeme Koşulları</div>"
			' 			Response.Write "<textarea id="""" onchange=""ajSave('odemeKosul','teklifv2.ihale',"&id&",$(this).val())"" class=""form-control fontkucuk2"" name=""odemeKosul"" cols=""50"" rows=""5"">" & odemeKosul & "</textarea>"
			' 		Response.Write "</div>"
			' Response.Write "</div>"
			' Response.Write "<div class=""row"">"
			' 		Response.Write "<div class=""col-12"">"
			' 			Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teslimat Koşulları</div>"
			' 			Response.Write "<textarea onchange=""ajSave('teslimatKosul','teklifv2.ihale',"&id&",$(this).val())"" class=""form-control fontkucuk2"" name=""teslimatKosul"" cols=""50"" rows=""5"">" & teslimatKosul & "</textarea>"
			' 		Response.Write "</div>"
			' Response.Write "</div>"

			Response.Write "</div>"'card-body
		Response.Write "</div>"'card
		
		Response.Write "<div class=""card"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""card-body col-lg-6"">"
			
			Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Dosya Durum</div>"
				call formselectv2("durum",dosyaDurum,"ajSave('durum','teklifv2.ihale',"&id&",$(this).val())","","","","",dosyaDurumDegerler,"")
				
			Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Sipariş Durum</div>"
				call formselectv2("sipDurum",sipDurum,"ajSave('sipDurum','teklifv2.ihale',"&id&",$(this).val())","","","","",sipDurumDegerler,"")
			
			' Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Mukayese Durum</div>"
			' 	call formselectv2("mukayeseDurum",mukayeseDurum,"ajSave('sipDurum','teklifv2.ihale',"&id&",$(this).val())","","","","",mukayeseDurumDegerler,"")
			
				
			Response.Write "</div>"'card-body
			
			
			
			Response.Write "<div class=""card-body col-lg-6"">"

			Response.Write "</div>"'card-body
		Response.Write "</div>"'row


		Response.Write "</div>"'card
		
	Response.Write "</div>"'card-deck
	
		Response.Write "</div>"'anaVeriInput
		
		Response.Write "</div>"'tab-pane
'##### /ANA VERİ
'##### /ANA VERİ

'##### ÜRÜNLER
'##### ÜRÜNLER
		Response.Write "<div class=""active tab-pane"" id=""urunler"" role=""tabpanel"">"
		
		Response.Write "<div class=""urunlistediv d-none"" tabindex=""-1"">"
			Response.Write "<div id=""exceLoading""><img src='/image/working2.gif' width='40' height='40'/></div>"
		Response.Write "</div>"
	
	
	Response.Write "<form class=""ajaxform"" action=""/teklif2/detay_kaydet.asp"">"
		Response.Write "<input type=""hidden"" name=""ihaleID"" value=" & id & " />"
		Response.Write "<input type=""hidden"" name=""cariID"" value=" & cariID & " />"
		
	Response.Write "<div id=""urunlerInput"" class=""border border-dark"">"
		
			Response.Write "<div class=""card-deck"">"
			Response.Write "<div class=""col-lg-12 col-md-6 col-sm-6"">"
			Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header""><h5>Ürün Tanımlama</h5></div>"
				Response.Write "<div class=""card-body"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-2"">"
				Response.Write "<div class=""badge badge-secondary rounded-left mt-2""> Sıra Numarası</div>" 
					call forminput("siraNo",siraNo,"numara(this,false,false)","Sıra No","bold text-center","autocompleteOFF","siraNo","")
				Response.Write "</div>"
			Response.Write "<div class=""col-lg-5"">"
			if ihaleTipi = "proforma" then
				stokSart = "english"
			else
				stokSart = ""
			end if
				Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Ürün Seçimi</div>" 
				call formselectv2("urunSec","","","","formSelect2 urunSec border","","urunSec","","data-holderyazi=""Stok Adı"" data-sart="""&stokSart&""" data-sartozel=""t1.stokTuru=1"" data-jsondosya=""JSON_stoklar"" data-miniput=""3"" onchange=""stokRefCagir('" & cariID & "',$(this).val())""")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-5"">"
				Response.Write "<div class=""badge badge-secondary rounded-left mt-2""> Ürünün Teklifte Görünecek  Adı</div>" 
				call forminput("urunAd",urunAd,"","Ürünün Listedeki Adı","","autocompleteOFF","urunAd","")
			Response.Write "</div>"
		Response.Write "</div>"


		Response.Write "<div class=""row mt-2"">"
			Response.Write "<div class=""col-lg-2"">"
				Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Miktar</div>" 
				call forminput("miktar",miktar,"numara(this,false,false)","Miktar","","autocompleteOFF","miktar","")
			Response.Write "</div>"

			Response.Write "<div class=""col-lg-2"">"
				Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Birim</div>" 
				call forminput("birim",birim,"","Birim","","","birim","")
			Response.Write "</div>"

			Response.Write "<div class=""col-lg-2"">"
				Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Fiyat</div>" 
				call forminput("firmamFiyat","","numara(this,true,false)","","para text-right bold","","firmamFiyat","")
			Response.Write "</div>"

			Response.Write "<div class=""col-lg-1"">"
				Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Para Birim</div>" 
				call formselectv2("firmamParaBirim","","","","btn p-0 bold","","firmamParaBirim",paraBirimDegerler,"")
			Response.Write "</div>"

			Response.Write "<div class=""col-lg-1"">"
			Response.Write "<div class=""badge mt-2"">&nbsp;</div>"
			Response.Write "<button name=""urunler"" class=""kaydet btn-block btn-primary rounded"" type=""submit"" onClick=""$('#tip').val('acik');"">kaydet</button>"
			Response.Write "</div>"
		Response.Write "</div>"
				Response.Write "</div>"'card-body
			Response.Write "</div>"'card
			Response.Write "</div>"'col
			
			Response.Write "</div>"
		
	Response.Write "</div>"'urunlerInput

	Response.Write "</form>"
			Response.Write "<table id=""urunlerTablo"" class=""table table-responsive table-bordered table-sm table-hover mt-3 border border-dark"">"
	
'##### tablo başlıklar	
				Response.Write "<thead class=""thead-dark"">"
					Response.Write "<tr class=""text-center bg-gray-200 p-0"">"
					Response.Write "<th class=""align-middle text-center"">"
						' Response.Write "<div class=""row text-center"">"
						' 	Response.Write "<div class=""col-1"">"
						' 		Response.Write "<div id=""urunlerSwitch"" class=""btn btn-sm btn-warning"" onclick=""$('#urunlerInput').toggle('slow');"">A/K</div>"
						' 	Response.Write "</div>"
						' Response.Write "</div>"
						Response.Write "<div class=""row text-center"">"
							Response.Write "<div class=""col-2 mt-1"">"
								Response.Write "<div id=""siparisButton"" class=""btn btn-sm btn-warning "" onclick=""topluSiparisKaydet();"">Sipariş</div>"
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</th>"
					Response.Write "<th class=""align-middle"">Notlar</th>"
					Response.Write "<th class=""align-middle"">Sıra No</th>"
					Response.Write "<th class=""align-middle"">Ürün Ad</th>"
					Response.Write "<th class=""align-middle"" colspan=""2"">Miktar</th>"
					Response.Write "<th class=""align-middle"">İskonto</th>"
					Response.Write "<th class=""align-middle"" colspan=""2"">Fiyat</th>"
					Response.Write "<th class=""align-middle"">Fiyat Onay</th>"
					Response.Write "</tr>"
				Response.Write "</thead>"
				Response.Write "<tbody>"
			
'##### /tablo başlıklar

			sorgu = "Select iu.yaklasikMaliyet, iu.yerliOran, iu.iptalSebep, iu.iptal, iu.uhde, iu.firmamFiyat, ISNULL(iu.pazarlik_ilkFiyat,0) as pazarlik_ilkFiyat, ISNULL(iu.firmamParaBirim,'TL') as firmamParaBirim,"_
			&" iu.iskontoOran, iu.bayiAlis, iu.tavsiyeFiyat, ISNULL(iu.tavsiyeBirim,'TL') as tavsiyeBirim, iu.grupNo, iu.siraNo, iu.fiyatOnay,"_
			&" iu.miktar, ISNULL(iu.miktar,0) as miktar, ISNULL(iu.arttirimMiktar,0) as arttirimMiktar, ISNULL(iu.eksiltimMiktar,0) as eksiltimMiktar, iu.birim, iu.stoklarID, ISNULL(iu.yaklasikMaliyetPB,'TL') as yaklasikMaliyetPB,"_
			&" iu.bayiMarj, ISNULL(iu.bayiAlisPB,'TL') as bayiAlisPB, iu.stoklarListeFiyat, iu.stoklarListeFiyatPB, iu.listeFiyatTarih, iu.iskontoOran,"_
			&" iu.id as ihaleUrunID, iu.ad as urunAd, iu.kalemNot, iu.kalemNotTeklifEkle, s.stokAd as stoklarAD, i.id as ihaleID, i.ihaleTipi, i.firmaID,"_
			&" r.cariUrunRef, r.cariUrunAd, t5.id as sipTempID, [stok].[FN_anaBirimIDBul](iu.stoklarID) as anaBirimID "_
			&" FROM teklifv2.ihale_urun iu"_
			&" INNER JOIN teklifv2.ihale i ON iu.ihaleID = i.id"_
			&" LEFT JOIN stok.stok s ON iu.stoklarID = s.stokID"_
			&" LEFT JOIN stok.stokRef r ON iu.stoklarID = r.stokID AND r.cariID = " & cariID & ""_
			&" LEFT JOIN teklif.siparisKalemTemp t5 ON t5.iuID = iu.ID"_
			&" WHERE i.firmaID = " & firmaID & " and ihaleID = " & id & " order by grupNo ASC, siraNo ASC"
			rs.open sorgu,sbsv5,1,3
				sonSiraKontrol = 0
			for i = 1 to rs.recordcount
				anaBirimID		=	rs("anaBirimID")
				firmaID			=	rs("firmaID")
				stoklarID		=	rs("stoklarID")
				bayiAlis		=	rs("bayiAlis")
				stoklarAD		=	rs("stoklarAD")
				ihaleUrunID		=	rs("ihaleUrunID")
				siraNo			=	rs("siraNo")
				if i = rs.recordcount then
					sonSiraKontrol	=	siraNo
				end if
				urunAd			=	rs("urunAd")
				fiyatOnay		=	rs("fiyatOnay")
				iskontoOran		=	rs("iskontoOran")
				cariUrunRef		=	rs("cariUrunRef")
				cariUrunAd		=	rs("cariUrunAd")
				uhde			=	rs("uhde")
				sipTempID		=	rs("sipTempID")
				miktar			=	rs("miktar")

				sorgu = "SELECT id as sipKalemID FROM teklif.siparisKalem WHERE iuID = " & ihaleUrunID
				rs1.open sorgu,sbsv5,1,3
					if rs1.recordcount > 0 then
						sipKalemID	=	rs1("sipKalemID")
						sipClass = " bg-success "
					else
						sipClass 		=	""
					end if
				rs1.close

				if not isnull(sipTempID) then
					sipClass 		=	" bg-info "
					sipYaziliMsg	=	"Ürün, sipariş TEMP listesinde kayıtlı."
				elseif not isnull(sipKalemID) then
					'sipYaziliMsg	=	"Ürün, sipariş olarak kayıt edilmiş."
				else
					sipClass 		=	""
				end if

	Response.Write "<tr class=""urunSatir"" data-iuid=""" & ihaleUrunID & """ data-anabirimid=""" & anaBirimID & """ data-miktar=""" & miktar & """>"
		Response.Write "<td width=""5%"" class=""align-middle text-center "&sipClass&""">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col"">"
				if fiyatOnay = True then
				Response.Write "<div class=""pointer"" onclick=""swal('fiyat onaylanmış kalem silinemez.','','error')""><i class=""fa fa-trash-o""></i></div>"
				else
				Response.Write "<a id="""&rs("ihaleUrunID")&"|ihale_urun"&""" class=""btn ajSil pt-0 pb-0 pl-0"" role=""button""><i class=""fa fa-trash-o""></i></a>"
				end if
			Response.Write "</div>"
			Response.Write "<div class=""col"">"
				Response.Write "<span class=""icon cart-put pointer"""
				if yetkiKontrol > 8 then
					'if not isnull(sipTempID) OR not isnull(sipKalemID) then
					if not isnull(sipTempID) then
						Response.Write " onclick=""swal('" & sipYaziliMsg & "','','info')"""
					else
						Response.Write " onclick=""modalajax('/teklif2/sipYaz_modal.asp?iuID="&ihaleUrunID&"&ihaleID="&ihaleID&"')"""
					end if
				else
					Response.Write " onclick=""swal('sipariş yazmak için yetkiniz yok.','','error')"""
				end if
				Response.Write "></span>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</td>"
		
		Response.Write "<td  width=""5%"" class=""align-middle text-center"">"
			Response.Write "<i"
			if isnull(rs("kalemNot")) then
				Response.Write " class=""fa fa-plus-circle text-green btn"""
			elseif rs("kalemNotTeklifEkle") = 1 then
				Response.Write " class=""fa fa-exclamation-triangle text-info btn"""
			else
				Response.Write " class=""fa fa-exclamation-triangle text-red btn"""
			end if
		if fiyatOnay = False OR isnull(fiyatOnay) then
			Response.Write " onClick=""modalajax('/teklif2/detay_modal_kalemNot.asp?ihaleID=" & rs("ihaleID") & "&id=" & rs("ihaleUrunID") &  "');""></i>"
		else
			Response.Write " onClick=""swal('fiyat onaylanmış kalemde değişiklik yapılamaz','','error')""></i>"
		end if
		Response.Write "</td>"

'## siraNO
		classYaz = classbelirle("align-middle text-center",kisimIhale,ihaleTipi,"","",rs("iptal"),rs("uhde"),"","","","","","")
		Response.Write "<td width=""5%"" class="""&classYaz&""">"
			call forminput("siraNo",siraNo,"",""," borderless text-center","","","onChange=""ajSave('siraNo','teklifv2.ihale_urun',"&ihaleUrunID&",$(this).val())""")
		Response.Write "</td>"
'## /siraNO

'## urunAD
		classYaz = classbelirle("align-middle",kisimIhale,ihaleTipi,"","",rs("iptal"),"","","","","","","")
		Response.Write "<td width=""40%"" class="""&classYaz&""">"
			'call forminput("urunAd",urunAd,"","","borderless mt-4","","kalemAd"&ihaleUrunID&"","onChange=""ajSave('urunAd','teklifv2.ihale_urun',"&ihaleUrunID&",$(this).val())""")
			call forminput("urunAd",urunAd,"","","borderless mt-4","","kalemAd"&ihaleUrunID&"","onChange=""ajSave('ad','teklifv2.ihale_urun',"&ihaleUrunID&",$(this).val())""")
			if stoklarID > 0 then
				Response.Write "<a id="""&rs("ihaleUrunID")&"|ihale_urun"&"|stokKarsilik"" class=""btn ajSil text-muted "" role=""button""><i class=""fa fa-trash-o p-0 m-0""></i></a>"
			end if
				
				Response.Write "<span class=""stokKarsilik fontkucuk2 text-info btn"" onClick=""modalajaxfit('/teklif2/detay_modal_urun.asp?firmalarID=" & firmasec & "&ihaleID=" & rs("ihaleID") & "&id=" & rs("ihaleUrunID") & "&stoklarID=" & stoklarID & "&stokSart=" & stokSart & "');""><em id=""stoklarad"" class=""stoklarad" & rs("ihaleUrunID") & """>"
			if stoklarID = 0 OR isnull(stoklarID) then
				Response.Write "<i class=""fa fa-exclamation text-danger""> stok karşılığı seçilmemiş</i> <i class=""fa fa-exclamation text-danger""></i>"
			else
					Response.Write "<div class=""m-0 fontkucuk2 text-info"" onclick=""$('#kalemAd"&ihaleUrunID&"').val('" & rs("stoklarAD") & "');$('#kalemAd"&ihaleUrunID&"').trigger('change')"">"
						Response.Write "<i class=""icon arrow-up pointer""></i>" & rs("stoklarAD")
					Response.Write "</div>"
				'Response.Write rs("stoklarAD")
			end if
			Response.Write "</em></span>"
			'##### müşteriye ait stok kodu ve stok adı
				if not isnull(cariUrunRef) then
					Response.Write "<div class=""m-0 fontkucuk2 text-danger"" onclick=""$('#kalemAd"&ihaleUrunID&"').val('" & cariUrunRef & " - " & cariUrunAd & "');$('#kalemAd"&ihaleUrunID&"').trigger('change')"">"
						Response.Write "<i class=""icon arrow-up pointer""></i><span class=""bold"">Cari Ref: </span>" & cariUrunRef & " <-> " & cariUrunAd
					Response.Write "</div>"
				end if
			'##### /müşteriye ait stok kodu ve stok adı
			if not isnull(rs("iptalSebep")) then
				Response.Write "<span class=""text-warning""><b>"&rs("iptalSebep")&"</b></span>"
			end if
			
		Response.Write "</td>"
'## /urunAD

'## miktar
		Response.Write "<td width=""7%"" class=""align-middle border-right-0 p-0"">"
			call forminput("miktar",formatnumber(miktar,0),"","","borderless text-right input50","","","onChange=""ajSave('miktar','teklifv2.ihale_urun',"&ihaleUrunID&",$(this).val())""")
		Response.Write "</td>"
'## /miktar

'## birim
		Response.Write "<td width=""7%"" class=""align-middle border-left-0 pl-1"">"
			call forminput("birim",rs("birim"),"this.select();","","borderless text-left input30","","","onChange=""ajSave('birim','teklifv2.ihale_urun',"&ihaleUrunID&",$(this).val())""")
		Response.Write "</td>"
'## /birim

'## iskonto
		Response.Write "<td width=""3%"" class=""align-middle border-right-0 p-0"">"
			call forminput("iskontoOran",iskontoOran,"","%","borderless text-right p-0 bold text-center","","","onChange=""ajSave('iskontoOran','teklifv2.ihale_urun',"&ihaleUrunID&",$(this).val())""")
		Response.Write "</td>"
'## /iskonto

'## Fiyatım
		Response.Write "<td width=""10%"" class=""align-middle border-right-0 p-0"">"
			para_deger = para_basamak(rs("firmamFiyat"))
			
			call forminput("firmamFiyat",para_deger,"","","borderless para text-right p-0 ","","","onChange=""ajSave('firmamFiyat','teklifv2.ihale_urun',"&ihaleUrunID&",$(this).val())""")
		Response.Write "</td>"
		
		Response.Write "<td width=""10%"" class=""align-middle border-left-0 p-0 pl-1"">"
			call formselectv2("firmamParaBirim",rs("firmamParaBirim"),"","","btn p-0 okKaldir","","",paraBirimDegerler,"onChange=""ajSave('firmamParaBirim','teklifv2.ihale_urun',"&ihaleUrunID&",$(this).val())""")
		Response.Write "</td>"
'## /Fiyatım

			if fiyatOnay = True then
				y 				= 	" align-middle text-center bg-success "
				fiyatOnayDeger	=	0
				chckValue		=	" checked "
			else
				y 				= 	" align-middle text-center "
				fiyatOnayDeger	=	1
				chckValue		=	""
			end if
				Response.Write "<td class="""&y&""">"
					Response.Write "<div>"
					if yetkiKontrol >= 5 then
						Response.Write "<input type=""checkbox"" class=""chck30"" " & chckValue & " onInput=""ajSave('fiyatOnay','teklifv2.ihale_urun',"&ihaleUrunID&","&fiyatOnayDeger&")"" onClick=""this.select();"">"
					else
						Response.Write "<span class=""icon world-delete pointer"" onclick=""swal('fiyat onay yetkisi yok.','')""></span>"
					end if
					Response.Write "</div>"
				Response.Write "</td>"

			Response.Write "</tr>"
			rs.movenext
			next
			rs.close
			Response.Write "</tbody></table>"
		Response.Write "</div>"'tab-pane

'##### /ÜRÜNLER
'##### /ÜRÜNLER



'##### TEKLİF AYARLARI
'##### TEKLİF AYARLARI
	
	if teklifKase = True then
		teklifKaseDurum = 	0
		chckDurum		=	" checked"
	else
		teklifKaseDurum = 1
		chckDurum		=	""
	end if
	
	if teklifAntet = True then
		teklifAntetDurum = 	0
		chckDurum2		=	" checked"
	else
		teklifAntetDurum = 1
		chckDurum2		=	""
	end if
	
	if teklifIban = True then
		teklifIbanDurum = 	0
		chckDurum3		=	" checked"
	else
		teklifIbanDurum = 1
		chckDurum3		=	""
	end if
	
	if teklifKDV = True then
		teklifKdvDurum = 	0
		chckDurum4		=	" checked"
	else
		teklifKdvDurum = 1
		chckDurum4		=	""
	end if

	if satirKDV = True then
		satirKdvDurum = 	0
		chckDurum6		=	" checked"
	else
		satirKdvDurum = 1
		chckDurum6		=	""
	end if
	
	
	if altTopGoster = True then
		altTopGosterDurum = 	0
		chckDurum5		=	" checked"
	else
		altTopGosterDurum = 1
		chckDurum5		=	""
	end if
	
	if catKodGoster = True then
		catKodDurum = 	0
		chckDurum7		=	" checked"
	else
		catKodDurum = 1
		chckDurum7		=	""
	end if

	if mustKodGoster = True then
		mustKodDurum = 	0
		chckDurum8		=	" checked"
	else
		mustKodDurum = 1
		chckDurum8		=	""
	end if

	if teklifMusteriOnay = True then
		teklifMusteriDurum = 	0
		chckDurum9		=	" checked"
	else
		teklifMusteriDurum = 1
		chckDurum9		=	""
	end if

	if ekMaliyet1 = True then
		ekMaliyet1Durum = 	0
		chckDurum10		=	" checked"
	else
		ekMaliyet1Durum = 1
		chckDurum10		=	""
	end if

	if ekMaliyet2 = True then
		ekMaliyet2Durum = 	0
		chckDurum11		=	" checked"
	else
		ekMaliyet2Durum = 1
		chckDurum11		=	""
	end if

	
		Response.Write "<div class=""tab-pane"" id=""teklif"" role=""tabpanel"">"
	
	
			Response.Write "<div class=""row text-center"">"
			
				Response.Write "<div class=""col-lg-5"">"
					Response.Write "<form action=""/teklif2/hucre_kaydet.asp"" method=""post"" class=""ajaxform"">"
						Response.Write "<input type=""hidden"" name=""alan"" value=""teklifNot"" />"
						Response.Write "<input type=""hidden"" name=""ihaleID"" value=""" & id & """ />"
						Response.Write "<input type=""hidden"" name=""ihaleID64"" value=""" & id64 & """ />"
						Response.Write "<input type=""hidden"" name=""tablo"" value=""teklifv2.ihale"" />"
						
						Response.Write "<div class=""container-fluid row text-left"">"
							Response.Write "<div class=""col-lg-12"">"
							Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teklif Dip Notları</div>"
							'teklifNot = replace(teklifNot,chr(10),"<br>")
							'Response.Write teklifNot
							Response.Write "<textarea class=""form-control"" name=""deger"" rows=""25"" id=""teklifNot"" placeholder=""Örnek : * KDV Hariçtir."">" & teklifNot & "</textarea>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-12"">"
							Response.Write "<button type=""submit"" class=""btn form-control btn-success"" onClick=""modalkapat();"">Kaydet</button>"
								call clearfix()
							Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</form>"
				Response.Write "</div>"
				
				Response.Write "<div class=""col-lg-7"">"

Response.Write "<div class=""card text-center"">"
	Response.Write "<div class=""card-header"">"
		Response.Write "<ul class=""nav nav-tabs card-header-tabs"" role=""tablist"" id=""sekmeler"">"
		
			Response.Write "<li class=""nav-item"">"
			Response.Write "<a class=""active nav-link fontkucuk"" data-toggle=""tab"" href=""#antet"" role=""tab"" aria-controls=""antet"">Genel</a>"
			Response.Write "</li>"

			Response.Write "<li class=""nav-item"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#vade"" role=""tab"" aria-controls=""vade"">Kur - Vade</a>"
			Response.Write "</li>"
		
			Response.Write "<li class=""nav-item"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#kosullar"" role=""tab"" aria-controls=""kosullar"">Koşullar</a>"
			Response.Write "</li>"
		
			Response.Write "<li class=""nav-item"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#bankalar"" role=""tab"" aria-controls=""banka"">Bankalar</a>"
			Response.Write "</li>"

			Response.Write "<li class=""nav-item"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#ekBilgi"" role=""tab"" aria-controls=""ekBilgi"">Ek Bilgi</a>"
			Response.Write "</li>"

			Response.Write "<li class=""nav-item"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#eposta"" role=""tab"" aria-controls=""eposta"">E-posta</a>"
			Response.Write "</li>"

			Response.Write "<li class=""nav-item"">"
			Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#sablon"" role=""tab"" aria-controls=""sablon"">PDF Şablon</a>"
			Response.Write "</li>"
			
		Response.Write "</ul>"
	Response.Write "</div>"
	Response.Write "<div class=""card-body"">"
		Response.Write "<div class=""tab-content"">"

		'######### ANTET - KAŞE
		'######### ANTET - KAŞE
			Response.Write "<div class=""active tab-pane"" id=""antet"" role=""tabpanel"">"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-1 text-left"">"
						Response.Write "<input type=""checkbox"" oninput=""ajSave('teklifAntet','teklifv2.ihale',"&id&"," & teklifAntetDurum & ");"" class="" chck30 form-control"" " & chckDurum2 & ">"
					Response.Write "</div>"
					Response.Write "<div class=""col-2 text-left"">"
						Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teklifte Antet olsun</div>"
					Response.Write "</div>"	
				Response.Write "</div>"

				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-1 text-left"">"
						Response.Write "<input type=""checkbox"" oninput=""ajSave('teklifKase','teklifv2.ihale',"&id&"," & teklifKaseDurum & ")"" class=""chck30 form-control"" " & chckDurum & ">"
					Response.Write "</div>"
					Response.Write "<div class=""col-2 text-left"">"
						Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teklifte Kaşe olsun</div>"
					Response.Write "</div>"						
				Response.Write "</div>"

				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-1 text-left"">"
						Response.Write "<input type=""checkbox"" oninput=""ajSave('altTopGoster','teklifv2.ihale',"&id&"," & altTopGosterDurum & ")"" class=""chck30 form-control"" " & chckDurum5 & ">"
					Response.Write "</div>"
					Response.Write "<div class=""col-2 text-left"">"
						Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teklifte Alt Toplam olsun</div>"
					Response.Write "</div>"						
				Response.Write "</div>"

				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-1 text-left"">"
						Response.Write "<input type=""checkbox"" oninput=""ajSave('teklifKdv','teklifv2.ihale',"&id&"," & teklifKdvDurum & ")"" class=""chck30 form-control"" " & chckDurum4 & ">"
					Response.Write "</div>"
					Response.Write "<div class=""col-2 text-left"">"
						Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teklifte KDV olsun</div>"
					Response.Write "</div>"						
				Response.Write "</div>"

				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-1 text-left"">"
						Response.Write "<input type=""checkbox"" oninput=""ajSave('teklifMusteriOnay','teklifv2.ihale',"&id&"," & teklifMusteriDurum & ")"" class=""chck30 form-control"" " & chckDurum9 & ">"
					Response.Write "</div>"
					Response.Write "<div class=""col-2 text-left"">"
						Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teklifte müşteri onayı talep tablosu olsun</div>"
					Response.Write "</div>"						
				Response.Write "</div>"

			Response.Write "</div>"
		'######### ANTET - KAŞE
		'######### ANTET - KAŞE

		'######### KUR - VADE
		'######### KUR - VADE
			Response.Write "<div class=""tab-pane"" id=""vade"" role=""tabpanel"">"
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#vade0').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""vade0"" class=""form-control col-12"" value=""- Kur Tarih: " & tarih_ihale & " / 1 USD = " & USDkur & " TL.&#10; &#13;"">"
				Response.Write "</div>"
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#vade1').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""vade1"" class=""form-control col-12"" value=""- Kur Tarih: " & tarih_ihale & " / 1 EUR = " & EURkur & " TL.&#10; &#13;"">"
				Response.Write "</div>"
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#vade2').val());""></i></span>"
					Response.Write "</div>"
					if isnull(odemeVade) OR odemeVade = "" then odemeVade = "[girilmemiş]"
						Response.Write "<input id=""vade2"" class=""form-control col-12"" value=""- Ödeme " & odemeVade & " gündür.&#10; &#13;"">"
				Response.Write "</div>"
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#vade3').val());""></i></span>"
					Response.Write "</div>"
					if isnull(teklifGecerlik) OR teklifGecerlik = "" then teklifGecerlik = "[girilmemiş]"
						Response.Write "<input id=""vade3"" class=""form-control col-12"" value=""- Teklif geçerlilik süresi " & teklifGecerlik & " gündür.&#10; &#13;"">"
				Response.Write "</div>"
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#vade4').val());""></i></span>"
					Response.Write "</div>"
					if isnull(teslimatSure) OR teslimatSure = "" then teslimatSure = "[girilmemiş]"
						Response.Write "<input id=""vade4"" class=""form-control col-12"" value=""- Teslimat süresi " & teslimatSure & " gündür.&#10; &#13;"">"
				Response.Write "</div>"
			Response.Write "</div>"
		'######### KUR - VADE
		'######### KUR - VADE

		'######### KOŞULLAR
		'######### KOŞULLAR
			Response.Write "<div class=""tab-pane"" id=""kosullar"" role=""tabpanel"">"
			if ihaleTipi <> "proforma" then
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+$('#yazi0').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""yazi0"" class=""form-control col-12"" value=""- Teklif edilen fiyata KDV dahil değildir.&#10; &#13;"">"
				Response.Write "</div>"
				
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#yazi1').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""yazi1"" class=""form-control col-12"" value=""- Kargo alıcı firmaya aittir.&#10; &#13;"">"
				Response.Write "</div>"
				
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#yazi2').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""yazi2"" class=""form-control col-12"" value=""- Satış fiyatlarımız hammadde alımı ve döviz kuruna göre değişiklik gösterebilir, bu durumda tarafınıza yeni bir teklif düzenlenir.&#10; &#13;"">"
				Response.Write "</div>"
				
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#yazi3').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""yazi3"" class=""form-control col-12"" value=""- Ödeme peşindir.&#10; &#13;"">"
				Response.Write "</div>"
				
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#yazi4').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""yazi4"" class=""form-control col-12"" value=""- Teslim tarihiniz ödemeye müteakip belirlenir.&#10; &#13;"">"
				Response.Write "</div>"
				
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#yazi5').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""yazi5"" class=""form-control col-12"" value="""">"
				Response.Write "</div>"
				
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#yazi6').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""yazi6"" class=""form-control col-12"" value="""">"
				Response.Write "</div>"
				
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#yazi7').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""yazi7"" class=""form-control col-12"" value="""">"
				Response.Write "</div>"
			elseif ihaleTipi = "proforma" then
				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#pr0').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""pr0"" class=""form-control col-12"" value=""- All our products conform to international standarts.&#10; &#13;"">"
				Response.Write "</div>"

				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#pr1').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""pr1"" class=""form-control col-12"" value=""- All of our prices are valid for 45 days.&#10; &#13;"">"
				Response.Write "</div>"

				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#pr2').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""pr2"" class=""form-control col-12"" value=""- Indicated delivery date is valid if the prepayment is made within 7 days. Please ask for updated delivery date in case of delayed payment.&#10; &#13;"">"
				Response.Write "</div>"

				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#pr3').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""pr3"" class=""form-control col-12"" value=""- We suggest an insurance to be made for your shipment. Un insured shipments are at importers risk.&#10; &#13;"">"
				Response.Write "</div>"

				Response.Write "<div class=""input-group mb-3"">"
					Response.Write "<div class=""input-group-prepend"">"
						Response.Write "<span class=""input-group-text pointer p-0""><i class=""fa fa-2x fa-arrow-left"" onclick=""$('#teklifNot').val($('#teklifNot').val()+'\n'+$('#pr4').val());""></i></span>"
					Response.Write "</div>"
						Response.Write "<input id=""pr4"" class=""form-control col-12"" value=""- The bank charges are not included in our prices. Any bank transfer costs will be demanded in case of short payment.&#10; &#13;"">"
				Response.Write "</div>"
			end if
			Response.Write "</div>"
		'######### KOŞULLAR
		'######### KOŞULLAR

		'######### BANKALAR
		'######### BANKALAR
			Response.Write "<div class=""tab-pane"" id=""bankalar"" role=""tabpanel"">"
				
				sorgu = "SELECT * FROM portal.bankalar WHERE firmaID = " & firmaID
				rs.open sorgu,sbsv5,1,3
					if rs.recordcount > 0 then
						for ti = 1 to rs.recordcount
						
						bankaKontrol	=	instr(bankalar,","&rs("bankalarID")&",")
						if bankaKontrol > 0 then
							bankaChck = " checked "
						else
							bankaChck = ""
						end if

							Response.Write "<div class=""row mt-2"">"
								Response.Write "<div class=""col-1 text-left"">"
									Response.Write "<input type=""checkbox"" " & bankaChck & " oninput=""cokluIDkaydet('bankalar','teklifv2.ihale',"&id&"," & rs("bankalarID") & ")"" class=""chck30 form-control"">"
								Response.Write "</div>"
								Response.Write "<div class=""col-2 text-left"">"
									Response.Write "<div class=""badge badge-warning rounded-left mt-2"">" & rs("hesapAd") & "</div>"
								Response.Write "</div>"						
							Response.Write "</div>"
						rs.movenext
						next
					end if
				rs.close
			Response.Write "</div>"
		'######### BANKALAR
		'######### BANKALAR

		'######### EK BİLGİ
		'######### EK BİLGİ
			Response.Write "<div class=""tab-pane"" id=""ekBilgi"" role=""tabpanel"">"
				'###### İHRACAT PROFORMA için SÜTUN AYARLARI
				if ihaleTipi = "proforma" then
					Response.Write "<div class=""row"">"
						Response.Write "<div class=""col-1 text-left"">"
							Response.Write "<input type=""checkbox"" oninput=""ajSave('catKodGoster','teklifv2.ihale',"&id&"," & catKodDurum & ");"" class="" chck30 form-control"" " & chckDurum7 & ">"
						Response.Write "</div>"
						Response.Write "<div class=""col-2 text-left"">"
							Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teklifte katalog kodu sütunu göster.</div>"
						Response.Write "</div>"	
					Response.Write "</div>"
					Response.Write "<div class=""row mt-2"">"
						Response.Write "<div class=""col-1 text-left"">"
							Response.Write "<input type=""checkbox"" oninput=""ajSave('mustKodGoster','teklifv2.ihale',"&id&"," & mustKodDurum & ");"" class="" chck30 form-control"" " & chckDurum8 & ">"
						Response.Write "</div>"
						Response.Write "<div class=""col-2 text-left"">"
							Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Teklifte ""CUST. Code"" sütunu göster.</div>"
						Response.Write "</div>"	
					Response.Write "</div>"
				else
					Response.Write "<div class=""row mt-2"">"
						Response.Write "<div class=""col-1 text-left"">"
							Response.Write "<input type=""checkbox"" oninput=""ajSave('satirKdv','teklifv2.ihale',"&id&"," & satirKdvDurum & ")"" class=""chck30 form-control"" " & chckDurum6 & ">"
						Response.Write "</div>"
						Response.Write "<div class=""col-2 text-left"">"
							Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Ürün satırında KDV oranı kolonunu göster.</div>"
						Response.Write "</div>"						
					Response.Write "</div>"
				end if
				'###### İHRACAT PROFORMA için SÜTUN AYARLARI
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-1 text-left"">"
						Response.Write "<input type=""checkbox"" oninput=""ajSave('ekMaliyet1','teklifv2.ihale',"&id&"," & ekMaliyet1Durum & ")"" class=""chck30 form-control"" " & chckDurum10 & ">"
					Response.Write "</div>"
					Response.Write "<div class=""col-2 text-left"">"
						Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">" & sb_ekMaliyet1 & "</div>"
					Response.Write "</div>"
					call forminput("ekMaliyet1Deger",ekMaliyet1Deger,"","Tutar","bold text-right","","","onChange=""ajSave('ekMaliyet1Deger','teklifv2.ihale',"&id&",$(this).val())""")
					call formselectv2("ekMaliyet1Birim",ekMaliyet1Birim,"","","btn p-0 okKaldir","","",paraBirimDegerler,"onChange=""ajSave('ekMaliyet1Birim','teklifv2.ihale',"&id&",$(this).val())""")
				Response.Write "</div>"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-1 text-left"">"
						Response.Write "<input type=""checkbox"" oninput=""ajSave('ekMaliyet2','teklifv2.ihale',"&id&"," & ekMaliyet2Durum & ")"" class=""chck30 form-control"" " & chckDurum11 & ">"
					Response.Write "</div>"
					Response.Write "<div class=""col-2 text-left"">"
						Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">" & sb_ekMaliyet2 & "</div>"
					Response.Write "</div>"
					call forminput("ekMaliyet2Deger",ekMaliyet2Deger,"","Tutar","bold text-right","","","onChange=""ajSave('ekMaliyet2Deger','teklifv2.ihale',"&id&",$(this).val())""")
					call formselectv2("ekMaliyet2Birim",ekMaliyet2Birim,"","","btn p-0 okKaldir","","",paraBirimDegerler,"onChange=""ajSave('ekMaliyet2Birim','teklifv2.ihale',"&id&",$(this).val())""")
				Response.Write "</div>"
			Response.Write "</div>"
		'######### /EK BİLGİ
		'######### /EK BİLGİ
		
		'######### e-posta
		'######### e-posta
			Response.Write "<div class=""tab-pane"" id=""eposta"" role=""tabpanel"">"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""input-group mb-3"">"
						Response.Write "<div class=""input-group-prepend"">"
							Response.Write "<span class=""input-group-text pointer p-0""><i class=""icon email-go""></i></span>"
						Response.Write "</div>"
						if isnull(teklifEposta) OR teklifEposta = "" then teklifEposta = cariEmail
							Response.Write "<input id=""epostaAdres"" onchange=""ajSave('teklifEposta','teklifv2.ihale',"&id&",$(this).val())"" class=""form-control col-12"" value="""&teklifEposta&""" autocomplete=""off""  placeholder=""e-posta adresi"" data-toggle=""tooltip"" title=""Teklif için kayıt edilmiş e-posta adresi yok ise cari kartta kayıtlı olan e-posta adresi otomatik olarak getirilir."">"
					Response.Write "</div>"
				Response.Write "</div>"

				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">e-posta içeriği</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row"">"
					Response.Write "<div id=""cariBilgi"" style=""height:120px; padding:10px;"" class=""col-8 border border-dark text-left"" contenteditable=""true"" onblur=""ajSaveBlur('epostaGovde', "&id&", 'teklifv2.ihale', 'epostaGovde', '', $(this).html(),'','','')"" >" & epostaGovde & "</div>"
				Response.Write "</div>"

			Response.Write "</div>"
		'######### /e-posta
		'######### /e-posta

		'######### ŞABLON
		'######### ŞABLON
			Response.Write "<div class=""tab-pane"" id=""sablon"" role=""tabpanel"">"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col text-left"">"
						Response.Write "<div class=""badge badge-secondary rounded-left mt-4"">Teklif Şablonu</div>"
						call formselectv2("teklifSablon",teklifSablon,"ajSave('pdfSablon','teklifv2.ihale',"&id&",$(this).find('option:selected').text())","","teklifSablon border border-info","","",teklifSablonDegerler,"")		
						Response.Write "<div id=""seciliSablonDIV"" class=""bold mt-2"">Seçili Şablon: <span class=""bold text-danger"">" & teklifSablon & "</span></div>"
				Response.Write "</div>"
			Response.Write "</div>"
		'######### /ŞABLON
		'######### /ŞABLON

		Response.Write "</div>"
	Response.Write "</div>"
Response.Write "</div>"







					
					
				Response.Write "</div>"
			Response.Write "</div>"'container
			
			
		Response.Write "</div>"'tab-pane
'##### /TEKLİF AYARLARI
'##### /TEKLİF AYARLARI
	Response.Write "</div>"

'##### TEKLİF ÖNİZLEME
'##### TEKLİF ÖNİZLEME
		Response.Write "<div class=""tab-pane"" id=""onizlemeDIV"" role=""tabpanel"">"
			Response.Write "<div class=""mt-3 bg-warning bold h3 col-5 rounded"">Şablon seçilmemiş.</div>"
			Response.Write "<div class=""mt-3 ml-3 col-5 rounded bold"">* Teklif Ayarları sekmesinden ""PDF Şablon"" seçimi yapınız.</div>"
		Response.Write "</div>"'tab-pane
'##### /TEKLİF ÖNİZLEME
'##### /TEKLİF ÖNİZLEME


Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
'Response.Write "</div>"

'##### /TABLO
'##### /TABLO

	else
		call yetkisizGiris("","","")
	end if

%>

<script>//ajSave kayıt işlemleri

    //$(document).on('change','.ajSave',function() {
function ajSave(alan, tablo, tabloID, deger){


	$(this).closest('div').html("<img src='/arayuz/working2.gif' width='10' height='10'/>");

		
    $.ajax({
        type:'POST',
        url :'/teklif2/hucre_kaydet.asp',
        data :{'alan':alan,'ihaleID':tabloID,'tablo':tablo,'deger':deger,
                	},
        beforeSend: function() {
				$(this).closest('div').html("<img src='/arayuz/working2.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						m_sonuc = sonucc[1];

						if(p_sonuc == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.success('Değişiklik kayıt edildi.','İşlem Yapıldı!');
						}
						else{
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.error(m_sonuc);
						};
												$.get('/teklif2/detay/<%=id64%>', function(data){
															var $data = $(data);
															
															$('#anaVeriInput').html($data.find('#anaVeriInput').html());
															$('#urunlerTablo').html($data.find('#urunlerTablo').html());
															$('#seciliSablonDIV').html($data.find('#seciliSablonDIV').html());
															//$('#sayfaAdi').html($data.find('#sayfaAdi').html());
															$('#onizlemeTAB').html($data.find('#onizlemeTAB').html());
															$('#ekBilgi').html($data.find('#ekBilgi').html());
												});//tablolar güncellendi
							
			}
    });
    };


function cokluIDkaydet(alan, tablo, tabloID, deger){


	$(this).closest('div').html("<img src='/arayuz/working2.gif' width='10' height='10'/>");

		
    $.ajax({
        type:'POST',
        url :'/teklif2/teklif_banka_kaydet.asp',
        data :{'alan':alan,'tabloID':tabloID,'tablo':tablo,'deger':deger,
                	},
        beforeSend: function() {
				$(this).closest('div').html("<img src='/arayuz/working2.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						m_sonuc = sonucc[1];

						if(p_sonuc == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.success('Değişiklik kayıt edildi.','İşlem Yapıldı!');
						}
						else{
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.error(m_sonuc);
						};
												$.get('/teklif2/detay/<%=id64%>', function(data){
															var $data = $(data);
															
															$('#anaVeriInput').html($data.find('#anaVeriInput').html());
															$('#urunlerTablo').html($data.find('#urunlerTablo').html());
															$('.def-kapali').hide('slow');
												});//tablolar güncellendi
							
			}
    });
    };


</script>


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
						url :'/teklif2/sil.asp',
						data :{'id':id,
								'tablo':tablo,
								'deger1':deger1,
								'deger2':deger2,
								'modulID':<%=ihaleID%>,
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
												$.get('/teklif2/detay/<%=id64%>', function(data){
															var $data = $(data);
															$('#urunlerTablo').html($data.find('#urunlerTablo').html());
															$('.def-kapali').hide('slow');
												});//tablolar güncellendi
												
												sonSiraBul(<%=sonSiraKontrol%>);

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
	end if 'yetki
	%>
    });
    </script><!--ajSil kayıt sil-->
	


<script>

		//son sıra numarasını al yeni ürün için sıra no hesapla
			function sonSiraBul(sonSiraKontrol){
				var sonSira = sonSiraKontrol
				if(sonSira == 0){sonSira = 1}else{sonSira++}
					$('#siraNo').val(sonSira);
			}
		//son sıra numarasını al yeni ürün için sıra no hesapla

	$(document).ready(function() {

				sonSiraBul(<%=sonSiraKontrol%>)




		$(document).on('change','#urunSec',function() {
			if($('#urunAd').val() == ""){
				$('#urunAd').val($('#urunSec option:selected').text());
			}
		});


		$('.cariID').trigger('mouseenter');

		$('.def-kapali').hide('slow');









		
    $('a[data-toggle="tab"]').on('click', function(e) {
        window.sessionStorage.setItem('activeTab', $(e.target).attr('href'));
    });
	
    var activeTab = window.sessionStorage.getItem('activeTab');
    
	if (activeTab) {
        $('#sekmeler a[href="' + activeTab + '"]').tab('show');
       // window.sessionStorage.removeItem("activeTab")
		};


//activeTab sessionStorage-->


//modal kapandığında içini boşalt
	$(document).on('hidden.bs.modal', function () {
     $('.modal-body').html('');
});

//modal kapandığında içini boşalt--> 




//Dosyaya ihale no ver/sil

    $(document).on('click','.btnIhaleNo',function() {

		var ihaleID = <%=id%>


    $.ajax({
        type:'POST',
        url :'/teklif2/dosyaNoVerSil.asp',
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





});

function stokRefCagir(cariID, stokID){
    $.ajax({
        type:'POST',
        url :'/teklif2/stok_ref_cagir.asp',
        data :{'cariID':cariID,'stokID':stokID,
                	},
        beforeSend: function() {
				$(this).closest('div').html("<img src='/arayuz/working2.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						m_sonuc = sonucc[1];
				if(p_sonuc.length > 0){
						swal('','Müşteriye ait fiyat bilgisi var <br><br>' + p_sonuc + ' ' + m_sonuc)
						$('#firmamFiyat').val(p_sonuc);
						$('#firmamParaBirim').val(m_sonuc).trigger('change');
					}
			}
    });
    };


	//tüm ürünleri sipariş TEMP tablosuna kaydet
		function topluSiparisKaydet(){

	  swal({
		title: "Teklifteki ürünlerin tamamı sipariş TEMP tablosuna yazılsın mı?",
		type: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#DD6B55',
		confirmButtonText: 'evet',
		cancelButtonText: 'hayır'
	  }).then(function(result) {
		// handle Confirm button click
		// result is an optional parameter, needed for modals with input

			$('.urunSatir').each(function(){
				var iuID		=	$(this).attr('data-iuid');
				var anaBirimID	=	$(this).attr('data-anabirimid');
				var miktar		=	$(this).attr('data-miktar');

				$.post('/teklif2/sipYazKaydet.asp',{
					iuID:iuID,
					birimID:anaBirimID,
					sipMiktar:miktar
				},function(cevap){
					cevapArr = cevap.split("|");
						if(cevapArr[0] == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.success(cevapArr[1],'İşlem Yapıldı!');
						}
						else{
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.error(cevapArr[1],'Ürün zaten TEMP tablosuna kayıtlı!');
						};
					
				});
			})
	  }).catch(function(dismiss) {
		// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
	  });
			
		}











</script>

