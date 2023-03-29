<!--#include virtual="/reg/rs.asp" -->
<%

Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
Response.CodePage = 65001
Response.CharSet = "UTF-8"

Response.Write "<meta http-equiv=""Content-Type"" content=""text/html;charset=UTF-8"" />"


Response.Write "<style>"

Response.Write ".style1 { background-color:#D3D3D3;}"
Response.Write ".b-left { border-left:1px black solid;}"
Response.Write ".b-right { border-right:1px black solid;}"
Response.Write ".b-top { border-top:1px black solid;}"
Response.Write ".b-bottom { border-bottom:1px black solid;}"
Response.Write ".b-all { border-bottom:1px black solid;border-top:1px black solid;border-right:1px black solid;border-left:1px black solid;}"
Response.Write "page {background: white;display: block;margin: auto auto;margin-bottom: 0.5cm;box-shadow: 0 0 0.5cm rgba(0,0,0,0.5);padding:0 1cm 0 0.5cm;height: 29.7cm;width: 21cm; background-color:#FFFFFF;}"

Response.Write "@media print {@page {size:A4 portrait;background: white;}body{visibility:hidden;}.section-to-print{visibility: visible;}}"
Response.Write "</style>"



	pdf 					=	request.QueryString("pdf")
	id						=	request.QueryString("ihaleid")
	musteriID				=	request.QueryString("musteriID")
	
	if pdf = "" then
			Response.Flush()
			kid						=	kidbul()
			arama					=	Request.Form("arama")
			id64					=	Session("sayfa5")
			'id64					=	request.QueryString("ihaleid")
			id						=	id64
			id						=	base64_decode_tr(id)
			call sessiontest()
		
	end if


sorgu = "SELECT i.ad as ihaleAD, i.grupIhale, i.ihaleTipi, f.Ad as firmamAdUzun, f.adres as firmamAdres, f.telefon as firmamTel, f.ilce, f.sehir, c1.il as ilAd,"_
&" c2.cariAd as kurumCariAD, c1.adres as teklifCariAdres, i.tarih_ihale, i.dosyaNo, i.ikn, i.bayiDosyaTipi, i.teklifRevNo, i.teklifKase, i.teklifAntet, f.iletisimEposta, f.webSite,"_
&" f.kasePath, f.kaseWidth, f.kaseHeight, f.firmaTanimlayiciNo, f.vergiDairesi, f.vergiNo, i.teklifIban, i.teklifKDV, i.altTopGoster, i.satirKDV,"_
&" CASE WHEN i.cariID is null OR LEN(i.yeniCariAd ) > 0 THEN i.yeniCariAd ELSE CONCAT(c1.cariAd COLLATE DATABASE_DEFAULT,'<br>',c1.adres,'<br>',c1.ilce,' / ',c1.il) END as teklifCariAD,"_
&" i.teklifMusteriOnay, f.antetPath"_
&" FROM dosya.ihale i"_
&" LEFT JOIN cari.cari c1 ON i.cariID = c1.cariID"_
&" LEFT JOIN cari.cari c2 ON i.bayiKurumID = c2.cariID"_
&" LEFT JOIN portal.firma f ON i.firmaID = f.Id"_
&" WHERE i.firmaID = " & firmaID & " AND i.id = " & id
rs.open sorgu,sbsv5,1,3

'####### VERİLERİ ÇEK
'####### VERİLERİ ÇEK
	teklifCariAD		=	rs("teklifCariAD")
	teklifCariAdres		=	rs("teklifCariAdres")
	kurumCariAD			=	rs("kurumCariAD")
	tarih_ihale			=	rs("tarih_ihale")
	dosyaNo				=	rs("dosyaNo")
	ikn					=	rs("ikn")
	ihaleAD				= 	rs("ihaleAD")
	grupIhale			=	rs("grupIhale")
	ihaleTipi			=	rs("ihaleTipi")
	bayiDosyaTipi		=	rs("bayiDosyaTipi")
	teklifRevNo			=	rs("teklifRevNo")
	firmamAdUzun		=	rs("firmamAdUzun")
	firmamAdres			=	rs("firmamAdres")
	firmamilce			=	rs("ilce")
	firmamil			=	rs("ilAd")
	firmamTel			=	rs("firmamTel")
	webSite				=	rs("webSite")
	firmaEposta			=	rs("iletisimEposta")
	teklifAntet			=	rs("teklifAntet")
	teklifKase			=	rs("teklifKase")
	kasePath			=	rs("kasePath")
	kaseWidth			=	rs("kaseWidth")
	kaseHeight			=	rs("kaseHeight")
	antetPath			=	rs("antetPath")
	satirKDV			=	rs("satirKDV")
	teklifMusteriOnay	=	rs("teklifMusteriOnay")
	firmaTanimlayiciNo	=	rs("firmaTanimlayiciNo")
	vergiDairesi		=	rs("vergiDairesi")
	vergiNo				=	rs("vergiNo")
	teklifIban			=	rs("teklifIban")
	teklifKDV			=	rs("teklifKDV")
	altTopGoster		=	rs("altTopGoster")
	rs.close
	
	
	sorgu = "SELECT COUNT(CASE iu.fiyatOnay WHEN 'True' THEN 1 ELSE NULL END) as fiyatOnaySayi,"_
	&" COUNT(iu.id) as iuToplamKayit, SUM(ISNULL(iu.iskontoOran,0)) as iskontoKontrol"_
	&" FROM dosya.ihale_urun iu WHERE iu.ihaleID = " & id
	rs.open sorgu,sbsv5,1,3
	
	
	if rs("fiyatOnaySayi") = rs("iuToplamKayit") then
		fiyatOnay = "OK"
	else
		fiyatOnay = ""
	end if
	iskontoKontrol	=	rs("iskontoKontrol")
	rs.close
	
	turuncuRenk	=	"color:#EB9E21;"
	
	
'####### /VERİLERİ ÇEK
'####### /VERİLERİ ÇEK

Response.Write "<page size=""A4"" class=""section-to-print"">"
Response.Write "<table border=""0"" style=""width:100%;font-family:calibri;border-collapse:collapse;"">"
	Response.Write "<tr>"
		Response.Write "<td>"
		if teklifAntet = True then
			Response.Write "<img id=""imageLogo"" src=""" & antetPath & """ width=""170"" height=""auto"">"
		end if
		Response.Write "</td>"
		Response.Write "</td>"
	Response.Write "</tr>"
Response.Write "</table>"
	Response.Write "<br>"
Response.Write "<table border=""0"" style=""width:100%;font-family:calibri;border-collapse:collapse;"">"
	Response.Write "<tr>"
		Response.Write "<td style=""width:50%;"" class=""b-all"">"
			Response.Write "<div id=""cariBilgi"" style=""height:120px; padding:10px;"""
			Response.Write " contenteditable=""true"" onblur=""ajSaveBlur('cariBilgi', "&id&", 'dosya.ihale', 'yeniCariAd', '', $(this).html(),'','','')"" >" & teklifCariAD & "</div>"
		Response.Write "</td>"
		Response.Write "<td style=""padding-top:20px;padding-right:10px;text-align:right;vertical-align:top;"">"
		Response.Write "<b>Tarih: </b>"&formatdatetime(tarih_ihale,2) & "<br>"
		Response.Write "<b>Teklif No: </b>" & dosyaNo
		Response.Write "</td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
		Response.Write "<td>"
		'Response.Write ikn&" "&ihaleAD
		Response.Write "</td>"
		Response.Write "<td style=""text-align:right;"">"

		Response.Write "<div class=""row text-right"">"
			if fiyatOnay = "OK" then
				Response.Write "<div class=""col-10"">"
					Response.Write "<a class=""text-left pointer"" href=""/teklif2/teklif_firma_pdf/"&id64&"|mailYok""><i class=""fa fa-file-pdf-o"" title=""PDF oluştur. Sadece kendi hesabına e-posta yolla.""></i></a>"
				Response.Write "</div>"
				Response.Write "<div class=""col-1"">"
				'Response.Write "&nbsp;&nbsp;&nbsp;&nbsp;"
				'Response.Write "<a class=""text-left"" href=""/teklif2/teklif_firma_pdf/"&id64&"|mailVar""><i class=""fa fa-at"" title=""PDF oluştur. Bayi kayıtlı E-posta adreslerine otomatik olarak yolla.""></i></a>"
					Response.Write "<div id=""teklifMailGonder"" class=""text-left pointer"" onclick=""teklifPDFmail('"&id64&"','mailVar',$(this).attr('id'))"">"
						Response.Write "<i class=""fa fa-at"" title=""PDF oluştur. Bayi kayıtlı E-posta adreslerine otomatik olarak yolla.""></i>"
					Response.Write "</div>"
				Response.Write "</div>"
				'Response.Write "&nbsp;&nbsp;"
			end if
				Response.Write "<div class=""col-1"">"
					Response.Write "Rev."&teklifRevNo
				Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</td>"
	Response.Write "</tr>"
Response.Write "</table>"

'###################### ÜST YAZI
'###################### ÜST YAZI
	Response.Write "<div style=""text-align:center; font-size:20px;font-family:calibri""><b>TEKLİF</b></div>"
	Response.Write "<div style=""text-align:justify; font-size:12px; font-family:calibri"">"
		onYazi = "<p>Ürünlerimiz ile ilgili fiyat teklifimizi değerlendirdiğiniz için teşekkür ederiz. Teklifimizin en iyi fiyat ve kalite dengesini yansıttığına inanıyoruz."
		onYazi = onYazi & " Herhangi bir sorunuz varsa lütfen bize ulaşmaktan çekinmeyin."
		onYazi = onYazi & " Teklifimizin olumlu karşılanacağını temmeni eder çalışmalarınızda kolaylıklar dileriz.</p>"
		Response.Write onYazi
	Response.Write "</div>"
	Response.Write "<div style=""text-align:right; margin-top:0px;margin-right:60px"">"
		if teklifKase = True then
			Response.Write "<img id=""imageLogo"" src=""" & kasePath & """ width=""90"" height=""auto"">"
		end if
	Response.Write "</div>"
'###################### /ÜST YAZI
'###################### /ÜST YAZI

Response.Write "<table class=""table-responsive-sm container-fluid table-bordered"" border=""1"" style=""width:100%;border-collapse:collapse;font-family:calibri;margin-top:10px"">"
Response.Write "<thead><tr style=""font-size:x-small;"" class=""text-center fontkucuk2 style1"">"
	if grupIhale = "True" then
		Response.Write "<th class=""bg-secondary"">"
		Response.Write "Kısım No"
		Response.Write "</th>"
	end if
Response.Write "<th class=""bg-secondary"">Sıra</th>"	
Response.Write "<th class=""bg-secondary"">Ürün Kodu</th>"
Response.Write "<th class=""bg-secondary"">Ürün & Hizmet Tanımı</th>"
if satirKDV = True then
Response.Write "<th class=""bg-secondary"">KDV</th>"
end if
Response.Write "<th class=""bg-secondary"">Miktar</th>"
Response.Write "<th class=""bg-secondary"">Birim Fiyat</th>"
Response.Write "<th class=""bg-secondary"">Brüt Tutar</th>"
	
	if iskontoKontrol > 0 then
		Response.Write "<th class=""bg-secondary"">İskonto</th>"
		Response.Write "<th class=""bg-secondary"">İsk. Tutar</th>"
		Response.Write "<th class=""bg-secondary"">Net Tutar</th>"
	end if

Response.Write "</tr></thead>"


sorgu = "SELECT COUNT(CASE iu.firmamParaBirim WHEN 'TL' THEN 1 ELSE NULL END) as TLsayi,"_
&" COUNT(CASE iu.firmamParaBirim WHEN 'EUR' THEN 1 ELSE NULL END) as EURsayi,"_
&" COUNT(CASE iu.firmamParaBirim WHEN 'USD' THEN 1 ELSE NULL END) as USDsayi,"_
&" COUNT(CASE WHEN iu.bayiAlisPB is NULL THEN 1 ELSE NULL END) as bayiBrYok,"_
&" COUNT(CASE WHEN iu.firmamParaBirim is NULL THEN 1 ELSE NULL END) as brYok,"_
&" COUNT(CASE iu.tavsiyeBirim WHEN 'TL' THEN 1 ELSE NULL END) as TLsayiTavs,"_
&" COUNT(CASE iu.tavsiyeBirim WHEN 'EUR' THEN 1 ELSE NULL END) as EURsayiTavs,"_
&" COUNT(CASE iu.tavsiyeBirim WHEN 'USD' THEN 1 ELSE NULL END) as USDsayiTavs,"_
&" COUNT(iu.id) as toplamKayit"_
&" FROM dosya.ihale_urun iu WHERE iu.ihaleID = " & id
rs.open sorgu,sbsv5,1,3

birimYok	=	rs("brYok")
TLsayi		=	rs("TLsayi")
EURsayi		=	rs("EURsayi")
USDsayi		=	rs("USDsayi")
TLsayiTavs	=	rs("TLsayiTavs")
EURsayiTavs	=	rs("EURsayiTavs")
USDsayiTavs	=	rs("USDsayiTavs")
toplamKayit	=	rs("toplamKayit")

if TLsayi = toplamKayit then
	paraBirim	=	"TL"
	paraBirimC	=	"kuruş"
elseif EURsayi = toplamKayit then
	paraBirim	=	"EUR"
	paraBirimC	=	"cent"
elseif USDsayi = toplamKayit then
	paraBirim	=	"USD"
	paraBirimC	=	"cent"
else
	paraBirim = "mix"
end if

if TLsayiTavs = toplamKayit then
	TavsParaBirim = "TL"
elseif EURsayiTavs = toplamKayit then
	TavsParaBirim = "EUR"
elseif USDsayiTavs = toplamKayit then
	TavsParaBirim = "USD"
else
	TavsParaBirim = "tavsiyeMix"
end if
rs.close

if birimYok > 0 then
		response.Write "<script>$(document).ready(function() {toastr.options.positionClass = 'toast-bottom-right';toastr.error('Para Birimi tanımlanmamış kalem(ler) var.','Eksik Bilgi!');});</script>"
end if

sorgu = "SELECT iu.id as ihaleUrunID, iu.grupNo, iu.siraNo, iu.ad as iuAD, iu.miktar, iu.birim, iu.stoklarListeFiyat, iu.stoklarListeFiyatPB,"
sorgu = sorgu &" ISNULL(iu.iskontoOran,0) as iskontoOran, iu.bayiAlis, iu.bayiAlisPB, iu.tavsiyeFiyat, iu.tavsiyeBirim, ISNULL(iu.stoklarID,0) as stoklarID,"
sorgu = sorgu &" (iu.firmamFiyat * iu.miktar) - (((iu.firmamFiyat * iu.miktar)*ISNULL(iu.iskontoOran,0))/100) as iskontoSonraTutar,"
sorgu = sorgu &" ((iu.firmamFiyat * iu.miktar)*ISNULL(iu.iskontoOran,0))/100 as iskontoTutar,"
sorgu = sorgu &" tavsiyeFiyat * iu.miktar as tavsiyeTutar, iu.firmamFiyat, iu.firmamParaBirim,"
sorgu = sorgu &" iu.firmamFiyat * iu.miktar as firmamTutar, iu.stoklarListeFiyat * iu.miktar as listeTutar,"
sorgu = sorgu &" ISNULL(bayiAlis,0) * iu.miktar as bayiTutar, s.katalogKodu, ISNULL(s.stokBarcode,'') as ubbKod, s.stokKodu, s.kdv"
sorgu = sorgu &" FROM dosya.ihale_urun iu"
sorgu = sorgu &" LEFT JOIN stok.stok s ON iu.stoklarID = s.stokID"
sorgu = sorgu &" WHERE iu.ihaleID = " & id & " ORDER BY iu.grupNo ASC, iu.siraNo ASC"
rs.open sorgu,sbsv5,1,3

toplam_tavsiye_tutar 	= 	0
toplam_alis_tutar 		= 	0
toplam_iskonto_tutar	= 	0
toplam_firmam_tutar		=	0

for i = 1 to rs.recordcount
	stokKodu			=	rs("stokKodu")
	kdv					=	rs("kdv")
	siraNo				=	rs("siraNo")
	ubbKod				=	rs("ubbKod")
	iskontoOran			=	rs("iskontoOran")
	iskontoSonraTutar	=	para_basamak(rs("iskontoSonraTutar"))
	iskontoTutar		=	para_basamak(rs("iskontoTutar"))
	firmamFiyat			=	para_basamak(rs("firmamFiyat"))
	firmamTutar			=	para_basamak(rs("firmamTutar"))
	firmamParaBirim		=	rs("firmamParaBirim")
	
	Response.Write "<tbody style=""font-size:x-small;"" class=""fontkucuk2""><tr>"
if grupIhale = "True" then
	Response.Write "<td style=""text-align:center;"" class=""text-center"">"
	Response.Write rs("grupNo")
	Response.Write "</td>"
end if
	Response.Write "<td style=""text-align:center;"" class=""text-center"">" & siraNo & "</td>"
	Response.Write "<td style=""text-align:center;"" class=""text-center"">" & stokKodu & "</td>"
	Response.Write "<td>"
		Response.Write rs("iuAD") & "<br>"
		if len(ubbKod) > 0 then
			Response.Write "UBB: " & ubbKod
		end if
		if len(sutKodu) > 0 then
			Response.Write "<br>" & sutKodu
		end if
	Response.Write "</td>"
	if satirKDV = True then
		Response.Write "<td style=""text-align:center;"" class=""text-center"">" & kdv & "</td>"
	end if
	Response.Write "<td style=""text-align:right;"" class=""text-right"">"
	Response.Write formatnumber(rs("miktar"),0)&" "&rs("birim")
	Response.Write "</td>"
	Response.Write "<td style=""text-align:right;"" class=""text-right"">"
		Response.Write firmamFiyat & " " & firmamParaBirim
	Response.Write "</td>"
	
	Response.Write "<td style=""text-align:right;"" class=""text-right"">"
		Response.Write firmamTutar & " " & firmamParaBirim
	toplam_firmam_tutar = toplam_firmam_tutar + firmamTutar
	Response.Write "</td>"
	if iskontoKontrol > 0 then
		Response.Write "<td style=""text-align:center;"" class="""">"
		if iskontoOran > 0 then
			Response.Write "%" & iskontoOran
		else
			Response.Write "&nbsp;"
		end if
		Response.Write "</td>"
		Response.Write "<td style=""text-align:right;"" class="""">"
			if iskontoTutar > 0 then
				Response.Write iskontoTutar & " " & firmamParaBirim
			else
				Response.Write "&nbsp;"
			end if
		Response.Write "</td>"
		Response.Write "<td style=""text-align:right;"" class="""">"
			Response.Write iskontoSonraTutar & " " & firmamParaBirim
		Response.Write "</td>"
		toplam_iskonto_tutar = toplam_iskonto_tutar + iskontoTutar
	end if
	Response.Write "</tr>"
rs.movenext
next
rs.close
Response.Write "</tbody></table>"
Response.Write "<br>"

	sorgu = "SELECT s.kdv, SUM(iu.miktar*(iu.firmamFiyat-((ISNULL(iu.iskontoOran,0)/100)*iu.firmamFiyat))) as kdvToplam "_
		&" FROM dosya.ihale_urun iu"_
		&" INNER JOIN stok.stok s ON iu.stoklarID = s.stokID"_
		&" WHERE ihaleID = "& id &""_
		&" GROUP BY kdv"_
		&" ORDER BY s.kdv"
		rs.open sorgu,sbsv5,1,3

				kdvHesap = 0
			do until rs.EOF
				kdvOran 		=	rs("kdv")
				kdvToplam		=	rs("kdvToplam")
				kdvHesap		=	(kdvToplam) * (kdvOran/100)
				toplamKdvHesap	=	toplamKdvHesap + kdvHesap

				kdvSatir = kdvSatir & "<tr style=""text-align:right;"" class=""text-right d-flex"">"
				kdvSatir = kdvSatir & "<td style=""width:60%"">&nbsp;</td>"
				kdvSatir = kdvSatir & "<td style=""text-align:right;width:20%"" class=""b-all"">"
				kdvSatir = kdvSatir & "KDV " & kdvOran & "%"
				kdvSatir = kdvSatir & "</td>"
				kdvSatir = kdvSatir & "<td style=""text-align:right;width:20%"" class=""b-top b-right b-bottom"">"
				para_deger = para_basamak(kdvHesap)
				kdvSatir = kdvSatir & para_deger & " " & paraBirim
				kdvSatir = kdvSatir & "</td>"
				kdvSatir = kdvSatir & "</tr>"
			rs.movenext
			loop
		rs.close
if paraBirim <> "mix" AND altTopGoster = "True" then'tüm kalemlerin para birimi aynı ise toplamlar gösterilsin.
	Response.Write "<table border=""0"" style=""width:100%;font-family:calibri;font-size:11px"">"
		Response.Write "<tr style=""text-align:right;"" class=""text-right d-flex"">"
			Response.Write "<td style=""width:60%"">&nbsp;</td>"
			Response.Write "<td style=""text-align:right;width:20%;"" class=""b-all"">Brüt Tutar</td>"
			Response.Write "<td style=""width:20%"" class=""b-top b-right b-bottom"">"
				para_deger = para_basamak(toplam_firmam_tutar)
				Response.Write para_deger & " " & paraBirim
			Response.Write "</td>"
		Response.Write "</tr>"
	if iskontoKontrol > 0 then
		Response.Write "<tr style=""text-align:right;"" class=""text-right d-flex"">"
			Response.Write "<td style=""width:60%"">&nbsp;</td>"
			Response.Write "<td style=""text-align:right;width:20%;"" class=""b-all"">Toplam İskonto</td>"
			Response.Write "<td style=""width:20%"" class=""b-top b-right b-bottom"">"
				pisk = para_basamak(toplam_iskonto_tutar)
				Response.Write "(-" & pisk & " " & paraBirim & ")"
			Response.Write "</td>"
		Response.Write "</tr>"
	end if
	if teklifKDV = true then
		Response.Write kdvSatir
	else
		toplamKdvHesap = 0
	end if
		Response.Write "<tr style=""text-align:right;"" class=""text-right d-flex"">"
		Response.Write "<td style=""width:60%"">&nbsp;</td>"
		Response.Write "<td style=""text-align:right;width:20%"" class=""b-all"">"
		Response.Write "Genel Toplam"
		Response.Write "</td>"
		Response.Write "<td style=""text-align:right;width:20%"" class=""b-top b-right b-bottom"">"
		firmam_genel_toplam = toplam_firmam_tutar - toplam_iskonto_tutar + toplamKdvHesap
		para_deger = para_basamak(firmam_genel_toplam)
		Response.Write para_deger&" "&paraBirim
		Response.Write "</td>"
		Response.Write "</tr>"
		Response.Write "<tr style=""text-align:right;"" class=""text-right d-flex"">"
		Response.Write "<td style=""text-align:right;"" colspan=""2"" class=""text-right col-12"">"
			'call sayiyiYaziyaCevir(firmam_genel_toplam,2,paraBirim,paraBirimC,"#","","","")
		Response.Write "</td>"
		Response.Write "</tr>"
	Response.Write "</table>"
end if'tüm kalemlerin para birimi aynı ise toplamlar gösterilsin.


'################# TEKLİF ALT BİLGİLERİ
'################# TEKLİF ALT BİLGİLERİ
	sorgu = "SELECT REPLACE(REPLACE(teklifNot,CHAR(13),'<br>'),CHAR(10),'<br>') as teklifNot,"
	sorgu = sorgu & " odemeVade, teklifGecerlik, teslimatSure, bankalar"
	sorgu = sorgu & " FROM dosya.ihale WHERE id = " & id
	rs.open sorgu,sbsv5,1,3

				
		bankalar		=	rs("bankalar")
		if LEN(bankalar) > 1 then
			bankalar 		= 	LEFT(bankalar,(LEN(bankalar)-1))
			bankalar 		= 	RIGHT(bankalar,(LEN(bankalar)-1))
		else
			bankalar = 0
		end if
		teklifNot		=	rs("teklifNot")
		odemeVade		=	rs("odemeVade")
		teklifGecerlik	=	rs("teklifGecerlik")
		teslimatSure	=	rs("teslimatSure")

	rs.close

		USDkur		=	dovizBulTarih("usdtry", tarih_ihale)

	sorgu = "SELECT iu.grupNo, iu.siraNo, iu.kalemNot, iu.kalemNotTeklifEkle FROM dosya.ihale_urun iu WHERE iu.ihaleID = " & id & " ORDER BY iu.grupNo ASC, iu.siraNo ASC"
	rs.open sorgu,sbsv5,1,3

			Response.Write "<table style=""font-family:calibri; font-size:12px;"">"
				Response.Write "<tr>"
				Response.Write "<td style=""width:70%"">"
					Response.Write "<b><u>AÇIKLAMA</u></b>"

				Response.Write teklifNot & "<br>"
				
				for t = 1 to rs.recordcount
					if len(rs("kalemNot")) > 0 AND rs("kalemNotTeklifEkle") = 1 then
						if rs("grupNo") > 0 then
							Response.Write "<b>Kısım "&rs("grupNo") &" - Sıra "& rs("siraNo")&":</b>"
						else
							Response.Write "<b> - Sıra No "&rs("siraNo")&" için:</b>"
						end if
					Response.Write " "&rs("kalemNot")&"<br>"
					end if
				rs.movenext
				next
				rs.close
				Response.Write "</td>"
				Response.Write "</tr>"
			Response.Write "</table>"
'################# /TEKLİF ALT BİLGİLERİ
'################# /TEKLİF ALT BİLGİLERİ

'################## banka bilgileri tablosu
'################## banka bilgileri tablosu
	sorgu = "SELECT * FROM portal.bankalar WHERE bankalarID IN ("&bankalar&")"
	rs.open sorgu,sbsv5,1,3
	if rs.recordcount > 0 then
	Response.Write "<div style=""font-size: 11px;margin-top:5px;"">"
		Response.Write "<table style=""font-family:calibri; font-size:12px;"" width=""100%"" border=""1"" cellspacing=""1"" cellpadding=""1"">"
			Response.Write "<thead>"
				Response.Write "<tr style=""text-align:center;"">"
					Response.Write "<th>Banka Adı</th>"
					Response.Write "<th>IBAN</th>"
					Response.Write "<th>SWIFT</th>"
					Response.Write "<th>Döviz Tür</th>"
				Response.Write "</tr>"
			Response.Write "</thead>"
			Response.Write "<tbody>"
			for zi = 1 to rs.recordcount
			bankaAd		=	rs("bankaAd")
			iban		=	rs("iban")
			swiftKod	=	rs("swiftKod")
			dovizTur	=	rs("paraBirim")
				Response.Write "<tr style=""text-align:center;"">"
					Response.Write "<td style=""border: 1px solid #000;"">"&bankaAd&"</td>"
					Response.Write "<td style=""border: 1px solid #000;"">"&iban&"</td>"
					Response.Write "<td style=""border: 1px solid #000;"">"&swiftKod&"</td>"
					Response.Write "<td style=""border: 1px solid #000;"">"&dovizTur&"</td>"
				Response.Write "</tr>"
			rs.movenext
			next
			Response.Write "</tbody>"
		Response.Write "</table>"
	Response.Write "</div>"
	end if
'################## /banka bilgileri tablosu
'################## /banka bilgileri tablosu
	Response.Write "<br>"

'######### müşteri onay tablosu
'######### müşteri onay tablosu
	if teklifMusteriOnay = True then
	Response.Write "<div style=""font-size: 11px;"">"
		Response.Write "<table width=""100%"" border=""0"" cellspacing=""1"" cellpadding=""1"">"
			Response.Write "<tbody>"
				Response.Write "<tr>"
					Response.Write "<td align=""center"" style=""border: 1px solid #000;""><strong>Fatura Bilgileriniz</strong></td>"
					Response.Write "<td align=""center"" style=""border: 1px solid #000;""><strong>Teslimat Adresi</strong></td>"
					Response.Write "<td align=""center"" style=""border: 1px solid #000;""><strong>Onay<br>"
					Response.Write "</strong>Yetkili İmza ve Kaşe</td>"
				Response.Write "</tr>"
				Response.Write "<tr>"
					Response.Write "<td height=""80"" style=""border: 1px solid #000;"">&nbsp;</td>"
					Response.Write "<td height=""80"" style=""border: 1px solid #000;"">&nbsp;</td>"
					Response.Write "<td height=""80"" style=""border: 1px solid #000;"">&nbsp;</td>"
				Response.Write "</tr>"
			Response.Write "</tbody>"
		Response.Write "</table>"
	Response.Write "</div>"
	end if
'######### müşteri onay tablosu
'######### müşteri onay tablosu




if fiyatOnay <> "OK" then
	Response.Write "<div class=""text-danger""><h3>Onaylanmamış fiyat var, PDF oluşturulamaz!</h3></div>"
end if

Response.Write "</page>"


%>













