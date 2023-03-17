<!--#include virtual="/reg/rs.asp" --><%

	Response.Flush()
	kid						=	kidbul()
	arama					=	Request.Form("arama")
	dashSorgu				=	Request.Form("dashSorgu")
	t1						=	Request.Form("t1")
	t2						=	Request.Form("t2")
	call sessiontest()

sayfaKayitSayisi	=	100

	'##### request
	'##### request
		
		dosyaKayitTip = ""
		dosyaKayitTip	=	Session("gelenadres5")
		if dosyaKayitTip = "" then
			dosyaKayitTip	=	request.form("dosyaKayitTip")
		end if
		
		dosyaTipi = Session("gelenadres6")
		
		Select Case dashSorgu
			Case "kararGelen"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Kesinleşen İhale Kararı gelmiş olan dosyalar.</b></i>"
				aramaDash = " AND i.id IN(SELECT DISTINCT s.ihaleID FROM sozlesmeler s WHERE s.tarih_karar is not null AND s.tarih_sozlesme_teblig is null AND s.tarih_sozlesme is null) AND i.durum = 'normal'"
			Case "kararYok"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Kesinleşen İhale Kararı GELMEMİŞ olan dosyalar.</b></i>"
				aramaDash = " AND i.id NOT IN (SELECT ihaleID FROM sozlesmeler)"_
							&" AND i.musteriID = 1"_
							&" AND i.durum = 'normal'"_
							&" AND i.dosyaKayitTip = 'M'"
			Case "sozlesmeImza"
				aramaDash = " AND i.id IN(SELECT DISTINCT s.ihaleID FROM sozlesmeler s WHERE s.tarih_sozlesme_teblig is not null AND s.tarih_sozlesme is null)"_
							&" AND i.durum = 'normal'"
			Case "kodlama"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Kodlama yapılmamış ürün bulunan dosyalar.</b></i>"
				aramaDash = " AND i.girilecek = 'True' AND i.kodlamaBitti IS NULL AND i.id IN (SELECT ihaleID FROM ihale_urun iu WHERE iu.musteriID = " & musteriID & " AND iu.stoklarID = 0 OR iu.stoklarID IS NULL)"
			Case "sonTeslim"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Sözleşmedeki son teslim tarihine 30 gün ve az süre kalan dosyalar.</b></i>"
				aramaDash = " AND (i.id IN(SELECT DISTINCT s.ihaleID FROM sozlesmeler s WHERE DATEDIFF(day,getdate(),s.tarih_sozlesme_bitis) <= 30)"_
							&" OR i.id IN(SELECT DISTINCT s2.ihaleID FROM sozlesmeler s2 WHERE DATEDIFF(day,getdate(),s2.tarih_teslimat_bitis) <= 30))"_
							&" AND i.teslimatBitti <> 'bitti'"
			Case "mukayese"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Mukayese cetveli gelmemiş dosyalar.</b></i>"
				aramaDash = " AND i.mukayeseDurum = '0' AND i.dosyaKayitTip = 'M' AND i.mukayeseDurum NOT IN ('stok alımı','gelmeyecek','yaklasik','bayiYaklasik')"
			Case "gelecekTarih"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Alım tarihi gelmemiş dosyalar.</b></i>"
				aramaDash = " AND i.girilecek = 'True' AND DATEDIFF(day,getdate(),i.tarih_ihale) >= 0"
			Case "listeYuklu"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Liste yüklemesi yapılmış, ürün seçimi yapılmamış dosyalar.</b></i>"
				aramaDash = " AND i.girilecek = 'True' AND i.listeYuklendi = 'True' AND i.id NOT IN (SELECT iu.ihaleID FROM ihale_urun iu WHERE iu.musteriID = " & musteriID & ")"
			Case "urunYok"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Ürün tanımlaması yapılmamış dosyalar.</b></i>"
				aramaDash = " AND i.girilecek = 'True' AND i.id NOT IN (SELECT iu.ihaleID FROM ihale_urun iu WHERE iu.musteriID = " & musteriID & ")"
			Case "bekleyenDilekce"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Sonuçlanmamış dilekçesi olan dosyalar.</b></i>"
				aramaDash = " AND i.id IN (SELECT dd.ihaleID FROM dilekceDepo dd WHERE dd.sonucTarih is null)"
			Case "kargoYok"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Kargo teslimatı tamamlanmamış ihale dosyaları.</b></i>"
				aramaDash = "  AND i.id IN (SELECT k.ihaleID FROM kargo_icerik k WHERE k.teslimTarih is null AND k.musteriID = " & musteriID & ")"
			Case "teminatYok"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Teminat tanımlanmamış ihale dosyaları.</b></i>"
				aramaDash = "  AND i.girilecek = 'True' AND i.durum = 'normal'"_
								&" AND (i.ihaleTipi = 'acik' OR i.ihaleTipi = 'pazarlik')"_
								&" AND i.id NOT IN (SELECT t.ihaleID FROM teminat t WHERE t.musteriID = " & musteriID & ")"
			Case "UTSyok"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>ÜTS bildirimi yapılmamış ihale dosyaları.</b></i>"
				aramaDash = "  AND i.id IN (SELECT ihaleID FROM teslimat_lot tl WHERE tl.musteriID = " & musteriID & " AND tl.utsBildirim IS NULL AND tl.utsBildirim2 IS NULL)"
			Case "gorusme"
				filtreDash	=	" <i class=""fa fa-hand-o-right text-danger"" aria-hidden=""true""> <b>Görüşme yapılması gereken dosyalar.</b></i>"
				aramaDash = " AND i.id IN (SELECT g.ihaleID FROM gorusmeler g WHERE g.sonrakiAramaTarihi is not null AND g.sonrakiAramaID is null AND CONVERT(varchar,g.sonrakiAramaTarihi,23) <= CONVERT(varchar,getdate(),23) AND g.musteriID = " & musteriID & ")"
		End Select

	'##### /request
	'##### /request
	
	
'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"Dosya Listesi"
'##### YETKİ BUL
'##### YETKİ BUL


if arama <> "" then
	arama = sqlinj(arama)
end if


'##### SAYFA BUL
'##### SAYFA BUL
	page = Request.Form("page")
	if page = "" then
		page		=	1
		mevcutsayfa	=	1
	else
		mevcutsayfa	=	page
		mevcutsayfa	=	int(mevcutsayfa)
	end if
'##### /SAYFA BUL
'##### /SAYFA BUL


Response.Write "<div class=""row"">"
Response.Write "<div class=""col-lg-12"">"
Response.Write "<div class=""card"">"
Response.Write "<div class=""card-header""><i class=""fa fa-align-justify""></i> " & sayfaadi & filtreDash &"</div>"
Response.Write "<div class=""card-body"">"

Response.Write "<form action=""/teklif2/liste"" method=""post"" id=""paging"">"
Response.Write "<input type=""hidden"" name=""page"" value=""" & page & """ id=""page"" />"
Response.Write "<div class=""row"">"
Response.Write "<div class=""col-lg-8 col-md-8 col-sm-9 col-xs-6"">"
Response.Write "<div class=""input-group mb-3"">"
Response.Write "<input type=""hidden"" name=""dosyaKayitTip"" value=""" & dosyaKayitTip & """>"
Response.Write "<input type=""hidden"" name=""dashSorgu"" value=""" & dashSorgu & """>"
Response.Write "<input name=""arama"" value=""" & arama & """ type=""text"" class=""form-control"" placeholder=""'ad, kısa ad, il, ikn, bayi adı' girerek arama"" aria-label=""Sonuçları Filtreleyin"" aria-describedby=""basic-addon2"" onKeyUp=""$('#page').val('1');"">"
Response.Write "<div class=""input-group-append"">"
				call forminput("t1",t1,"","Başlangıç Tarihi Seçin","tarih","","","AutCompOff")
				call forminput("t2",t2,"","Bitiş Tarihi Seçin","tarih","","","AutCompOff")
Response.Write "<button class=""btn btn-outline-secondary bg-danger rounded"" type=""submit"">Filtrele</button>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</form>"

Response.Write "<div class=""col-lg-4 col-md-4 col-sm-3 col-xs-6 text-right"">"
Response.Write "<a href=""/teklif2/yeni"" class=""btn btn-success rounded"">Yeni Kayıt</a>"
Response.Write "</div>"
Response.Write "</div>"'row

Response.Write "<table class=""table table-responsive-sm table-bordered table-striped table-sm table-hover"">"

Response.Write "<thead><tr class="" text-center"">"
Response.Write "<th>Sorumlu</th>"
Response.Write "<th>Dosya No</th>"
Response.Write "<th>Tarih</th>"
Response.Write "<th>Konum</th>"
Response.Write "<th>Cari</th>"
Response.Write "<th>Alım</th>"
'Response.Write "<th>Durum/İKN</th>"
'Response.Write "<th></th>"
'Response.Write "<th>Durum</th>"
'Response.Write "<th></th>"
Response.Write "<th>İşlem</th>"
Response.Write "</tr></thead><tbody>"

if arama <> "" then
	arama = sqlinj(arama)
	sorgufiltre = " AND (i.dosyaNo like '%" & arama & "%' OR"_
				&" i.ihaleNo like '%" & arama & "%' OR"_
				&" f.adKisa like '%" & arama & "%' OR"_
				&" i.ad like '%" & arama & "%' OR"_
				&" c.ad like '%" & arama & "%' OR"_
				&" c.adKisa like '%" & arama & "%' OR"_
				&" i.yeniCariAd like '%" & arama & "%' OR"_
				&" iller.ad like '%" & arama & "%' OR"_
				&" i.ikn like '%" & arama & "%' OR"_
				&" c2.ad like '%" & arama & "%' OR"_
				&" c2.adKisa like '%" & arama & "%' OR"_
				&" i.tarih_ihale like '%" & arama & "%')"
end if

if aramaDash <> "" then
	sorgufiltre = sorgufiltre & aramaDash
end if

if dosyaKayitTip <> "" then
	sorguKayitTip = " AND i.dosyaKayitTip =  '" & dosyaKayitTip & "' "
else
	sorguKayitTip = ""
end if

if dosyaTipi = "dog_temin" then
	sorguihaleTipi = " AND i.ihaleTipi =  '" & dosyaTipi & "' "
else
	sorguihaleTipi = " AND i.ihaleTipi <>  'dog_temin' "
end if

if t1 <> "" then
	sorgufiltre = sorgufiltre & " AND CONVERT(varchar,i.tarih_ihale,104) >= '" & t1 & "'"
end if

if t2 <> "" then
	sorgufiltre = sorgufiltre & " AND CONVERT(varchar,i.tarih_ihale,104) <= '" & t2 & "'"
end if

sorgu = "Select count(i.id) from dosya.ihale i LEFT JOIN cari.cari c ON i.cariID = c.cariID"_
&" LEFT JOIN cari.cari c2 ON i.bayiKurumID = c2.cariID"_
&" LEFT JOIN portal.iller ON c.il = iller.ilID"_
&" LEFT JOIN portal.firma f ON i.firmaID = f.Id"_
&" WHERE i.firmaID = " & firmaID & sorgufiltre & sorguKayitTip & sorguihaleTipi
rs.open sorgu,sbsv5,1,3
	toplamkayitsayisi = rs(0)
rs.close




if mevcutsayfa = 1 then
	ilkkayit = 0
else
	ilkkayit = (mevcutsayfa-1) * sayfaKayitSayisi
end if

sorgu = "SELECT i.dosyaNo, i.ihaleNo, i.dosyaKayitTip, i.yeniCariVergiNo,"
sorgu = sorgu & " (select count(id) from dosya.gorusmeler g WHERE i.id = g.ihaleID) as gorusmeSayi,"
sorgu = sorgu & " (select count(id) from dosya.gorusmeler g WHERE i.id = g.ihaleID AND g.sonrakiAramaTarihi is not null AND g.sonrakiAramaID is null) as gorusulecekSayi,"
sorgu = sorgu & " f.teklifDosya, i.tarih_ihale, i.ilanTarih, i.bayiKurumID, i.durum, i.girilecek, i.ikn, i.id as ihaleID, i.teslimatBitti, k.ad as sorumlu,"
sorgu = sorgu & " CASE WHEN i.ihaleTipi = 'bayi' THEN 'firma' ELSE i.ihaleTipi END as ihaleTipi, c.cariAd AS cariAD, i.yeniCariAd,"
sorgu = sorgu & " IIF(i.girilecek='False','',IIF(i.mukayeseDurum='0','Bekleniyor',i.mukayeseDurum)) as MukD, i.dosyaIcerik,"
sorgu = sorgu & " c.il AS sehir, i.ad AS dosyaAD, f.Ad AS firmaAD, isnull(i.netsisDOVIZTIP,'TL') AS dosyaPB,"
sorgu = sorgu & " CASE WHEN i.ihaleTipi = 'bayi' THEN f.teklifDosya WHEN i.ihaleTipi = 'proforma' THEN f.proformaDosya END as teklifSablon"
sorgu = sorgu & " FROM dosya.ihale i"
sorgu = sorgu & " LEFT JOIN cari.cari c ON i.cariID = c.cariID"
sorgu = sorgu & " LEFT JOIN personel.personel k ON i.dosyaSorumlu = k.id"
sorgu = sorgu & " LEFT JOIN portal.firma f ON i.firmaID = f.id"
sorgu = sorgu & " WHERE i.firmaID = " & firmaID & sorgufiltre & sorguKayitTip & sorguihaleTipi & " order by i.ihaleNo ASC, i.tarih_ihale DESC OFFSET " & ilkkayit & " ROWS FETCH NEXT " & sayfaKayitSayisi & " ROWS ONLY"
rs.open sorgu,sbsv5,1,3

if rs.recordcount > 0 then
	for ri = 1 to rs.recordcount
	
	teslimatBitti	=	rs("teslimatBitti")
	teklifDosya		=	rs("teklifDosya")
	yeniCariVergiNo	=	rs("yeniCariVergiNo")
	ihaleID			=	rs("ihaleID")
	ihaleID64		=	ihaleID
	ihaleID64		=	base64_encode_tr(ihaleID64)
	sorumlu 		=	rs("sorumlu")
	dosyaNo			=	rs("dosyaNo")
	ihaleNo			=	rs("ihaleNo")
	cariAD			=	rs("cariAD")
	yeniCariAd		=	rs("yeniCariAd")
	dosyaKayitTip	=	rs("dosyaKayitTip")
	teklifSablon	=	rs("teklifSablon")
			a = instr(yeniCariAd,"<div>")
			if a > 0 then
				yeniCariAd = LEFT(yeniCariAd,a)
			end if
			
	if len(cariAd) = 0 OR isnull(cariAd) then
		teklifVerilen	=	"<span><i class=""fa fa-chain-broken text-danger""></i></span> " & yeniCariAd
	else
		teklifVerilen	=	cariAD
	end if
	
	

		Response.Write "<tr>"
			Response.Write "<td class=""align-middle"" style="""">" & sorumlu & "</td>"
			Response.Write "<td class=""align-middle text-center"" style="""">"
				Response.Write dosyaNo
				if not isnull(ihaleNo) then
					Response.Write "<hr class=""p-0 m-0"">"
					Response.Write "<i class=""text-info""><b>" & ihaleNo & "</b></i>"
				end if
			Response.Write "</td>"
			Response.Write "<td class=""align-middle text-center"" style="""">" & rs("tarih_ihale") & "</td>"
			Response.Write "<td class=""align-middle"" style="""">" & rs("sehir") & "</td>"
			Response.Write "<td class=""align-middle"" style="""">" & teklifVerilen & "<br>"
			Response.Write "<span class=""pull-right text-info"">" & rs("firmaAD") & "</span></td>"
			Response.Write "<td class=""align-middle pb-0 mb-0"" style="""">" & rs("dosyaAD")&"<br>"
			Response.Write "<span class=""pull-left fontkucuk2 text-info"">" & rs("dosyaIcerik") & "</span>"
			Response.Write "<div class=""text-right text-danger"">"
				Response.Write  rs("ihaleTipi")
			Response.Write "</div></td>"
			'Response.Write "<td class=""align-middle text-center"" style=""width:6%""></td>"
				'Response.Write "<td class=""align-middle text-left fontkucuk2"" style=""width:8%"">"
				'Response.Write "<b>Mukayese:</b> " & rs("MukD")
			'Response.Write "</td>"
			'classYaz = classbelirle2("align-middle text-center fontkucuk2 m-0 p-0", ihaleID, "dosya.ihale", "durumSorgu", "","")
			' Response.Write "<td class="""&classYaz&""" style=""width:6%"">"
			
			' 		Response.Write "<div id=""divGorusme_"&ihaleID64&""" class=""bg-secondary text-left fontkucuk2 col m-0 p-0 align-self-end bd-highlight"">"
			' 			Response.Write "<a class=""btn fontkucuk2 p-0 m-0"" onClick=""modalajaxfit('/gorusmeler/liste.asp?dosyaKayitTip="&dosyaKayitTip&"&ihaleID="&ihaleID64&"');"">"
			' 			Response.Write "Görüşmeler: "& rs("gorusulecekSayi") & "/" & rs("gorusmeSayi")
			' 		Response.Write "</a>"
			' 		Response.Write "</div>"
			
			
			' Response.Write "</td>"
			' Response.Write "<td class=""align-middle fontkucuk2"">"

			' 		'call idariItiraz(rs("tarih_ihale"),rs("ilanTarih"))
					
			' 	Response.Write "<br>"
				
			' 		'call teknikItiraz(rs("tarih_ihale"))
			' 	Response.Write "<br>"
			' 	'Response.Write "<a class=""btn fontkucuk2 p-0 m-0"" onClick=""modalajax('','/dilekce/dilekce_modal.asp?ihaleID="& ihaleID64 & "');""><i class=""p-0 m-0 fa fa-arrow-circle-o-right"" aria-hidden=""true""></i></a>"
					
			' Response.Write "</td>"
			Response.Write "<td class=""align-middle text-left"">"
				Response.Write "<a class=""btn btn-success rounded px-1 py-0"" href=""/teklif2/detay/" & ihaleID64 & """><i class=""fa fa-edit""></i></a>"
				
	'############## POPOVER ile işlemler listesi gösterimi
			Response.write "<a tabindex=""0"" role=""button"""
				Response.write " class=""btn btn-info rounded px-2 py-0 ml-1"""
				Response.write " data-toggle=""popover"""
				Response.write " title='İşlemler Listesi'"
				Response.write " data-content='"
					Response.Write "<div class=""hoverGel rounded""><a target="""" href=""/teklifSablon/" & teklifSablon & "/" & ihaleID64 & """><i class=""btn btn-info rounded px-1 py-0 fa fa-envelope""></i>&nbsp;Teklif ekranı</a></div>"
				Response.Write "<hr class=""m-1 p-0"">"
					if instr(yetki,",5,") = 0 then
						Response.Write "<div class=""hoverGel rounded""><a href=""/dosya/upload_liste/" & ihaleID64 & """><i class=""btn btn-success rounded px-1 py-0 fa fa-book""></i>&nbsp;İlişkili dosya yükle</a></div>"
					end if
				Response.Write "<hr class=""m-1 p-0"">"
					if instr(yetki,",4,") = 0 then
						Response.Write "<div class=""hoverGel rounded"" onclick=""silDosya("&ihaleID64&")""><i class=""btn btn-danger rounded px-1 py-0 fa fa-trash""></i>&nbsp;Dosya Sil</div>"
					end if
				Response.write "'>"
				Response.write "<i class=""fa fa-angle-double-right"" aria-hidden=""true""></i>"
				Response.write "</a>"
					dosyaSayi = dosyaSay("/temp/dosya/" & firmaID & "/teklifler/" & ihaleID64)
					if  int(dosyaSayi) > 0 then
						Response.Write "<a class=""btn btn-warning rounded px-2 ml-1 py-0"" onClick=""modalajax(&#39;/teklif2/teklif_liste_modal.asp?id="& ihaleID64 & "&#39;);""><i class=""fa fa-file-pdf-o""></i></a>"
					end if
	'############## /POPOVER ile işlemler listesi gösterimi
			Response.Write "</td>"
		Response.Write "</tr>"
	rs.movenext
	next
else
	Response.Write "Hiç Dosya tanımlanmamış"
end if
rs.close

Response.Write"</tbody>"
Response.Write "</table>"


'##### PAGING
'##### PAGING
	if toplamkayitsayisi > sayfaKayitSayisi then
		sayfasayisi = toplamkayitsayisi / sayfaKayitSayisi
	else
		sayfasayisi = 1
	end if
	pagingsayi	= int(sayfasayisi)
	if pagingsayi < sayfasayisi then
		pagingsayi = pagingsayi + 1
	end if
	if mevcutsayfa >= 10 then
		p1 = mevcutsayfa -5
	elseif pagingsayi < 10 then
		p1 = 1
	else
		p1 = 1
	end if
	Response.Write "<nav>"
	Response.Write "<ul class=""pagination"">"
	if mevcutsayfa > 1 and sayfasayisi > 1 then
		Response.Write "<li class=""page-item""><a class=""page-link"" onClick=""paging('1');"">İlk</a></li>"
		Response.Write "<li class=""page-item""><a class=""page-link"" onClick=""paging('" & mevcutsayfa-1 & "');"">Önceki</a></li>"
	end if
	if pagingsayi > 1 then
	di = 0
		for pi = p1 to pagingsayi
			di = di +1
			Response.Write "<li class=""page-item"
			if pi = mevcutsayfa then
				Response.Write " active"
			end if
			Response.Write """><a class=""page-link"" onClick=""paging('" & pi & "');"">" & pi & "</a></li>"
			if di = 10 then
				exit for
			end if
		next
	end if
	if mevcutsayfa < pagingsayi then
		Response.Write "<li class=""page-item""><a class=""page-link"" onClick=""paging('" & mevcutsayfa+1 & "');"">Sonraki</a></li>"
		Response.Write "<li class=""page-item""><a class=""page-link"" onClick=""paging('" & pagingsayi & "');"">Son</a></li>"
	end if
	Response.Write "</ul>"
	Response.Write "</nav>"
'##### PAGING
'##### PAGING


Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"

%>
<script>//kayıt sil
function silDosya(ihaleID64) {
	    
		
			swal({
			title: 'Dosya silinecek?',
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
						url :'/teklif2/sil_dosya.asp',
						data :{'id':ihaleID64,
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
											toastr.success('Kayıt silindi.','İşlem Yapıldı!');
										}
										else{
											toastr.options.positionClass = 'toast-bottom-right';
											toastr.error('Kayıt silinemedi.','İşlem Başarısız!');
										};
												$.get('/teklif2/liste/<%=id64%>/<%=dosyaKayitTip%>', function(data){
															var $data = $(data);
															$('.card-body').html($data.find('.card-body').html());
															$('#urunlerTablo').html($data.find('#urunlerTablo').html());
															$('#urunler2Tablo').html($data.find('#urunler2Tablo').html());
															$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
															$('#sozlesmeListe').html($data.find('#sozlesmeListe').html());
															$('#teminatTablo').html($data.find('#teminatTablo').html());
															$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
															$('#siparisTablo').html($data.find('#siparisTablo').html());
															$('#teslimatTablo').html($data.find('#teslimatTablo').html());
															$('.def-kapali').hide('slow');
												});//tablolar güncellendi
												
										}
					});//ajax işlemi sonu
					
			  }, //confirm buton yapılanlar
			  function(dismiss) {
				// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			  } //cancel buton yapılanlar		
			);//swal sonu
    }
    </script><!--silDosya ile dosya sil-->
	
	
	
	
<script>//tutarHesapla işlemleri

    $(document).on('click','.hesapla',function() {

		var hamID = $(this).attr('id');
		var divIsim = $(this).data('isim');
		$('.divDinamik').hide();
		
		arr 	= hamID.split('_');
		id 		= arr[1];

		
    $.ajax({
        type:'POST',
        url :'/dosya/tutar_hesapla.asp',
        data :{'id':id,
                	},
        beforeSend: function() {
				//$(this).closest('div').html("<img src='/image/working2.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc 		= sonuc.split('|');
						istirak		= 	sonucc[0];
						uhde		=	sonucc[1];
						bakiye		=	sonucc[2];
						karar		=	sonucc[3];
						sozlesme	=	sonucc[4];
						kikPayi		=	sonucc[5];
						PB			=	sonucc[6];
			$('#istirakTutar_'+id).html('<b>İştirak: </b>'+istirak+PB);
			$('#uhdeTutar_'+id).html('<b>Uhde: </b>'+uhde+PB);
			$('#bakiyeTutar_'+id).html('<b>Bakiye: </b>'+bakiye+PB);
			$('#kararPulu_'+id).html('<b>Karar: </b>'+karar+PB);
			$('#sozlesmePulu_'+id).html('<b>Sözleşme: </b>'+sozlesme+PB);
			if (kikPayi != '') {$('#kikPayi_'+id).html('<b>KİK: </b>'+kikPayi+PB)};
			$('#kararSozl_'+id).html('<b>karar+sözleşme</b>');
			$('.'+divIsim).show();
			}
    });
    });
    </script><!--tutarHesapla işlemleri-->
	
<script>//modal kapandığında içini boşalt
	$(document).on('hidden.bs.modal', function () {
     $('.modal-body').html('');
});

</script><!--modal kapandığında içini boşalt-->

