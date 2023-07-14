<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
    receteAdimID		=	Request("receteAdimID")
	receteID			=	Request("receteID")
	islem				=	Request("islem")
	if receteID = "" then
		receteID = Request.Form("receteID")
	end if
	stokID				=	Request.Form("stokID")
    receteISlemTipiID  	=	Request.Form("receteISlemTipiID")
    modulAd =   "Reçete"
    modulID =   "97"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Yeni Reçete Adım Ekleme Ekranı Girişi")

yetkiKontrol = yetkibul(modulAd)

			if stokID <> "" then
				sorgu = "SELECT stok.FN_anaBirimADBul(" & stokID & ",'uAd') as anaBirimAD, stok.FN_anaBirimADBul(" & stokID & ",'kAd') as anaBirimADkisa"
				rs.open sorgu, sbsv5, 1, 3
					anaBirimAD			=	rs("anaBirimAD")
					anaBirimADkisa		=	rs("anaBirimADkisa")
				rs.close	
			end if


if receteAdimID <> "" then
            sorgu = "SELECT t1.stokID, t1.miktar, t1.isGucuSayi, t1.miktarBirim, t1.fire, t1.fireBirim, t4.uzunBirim, t1.sira, t1.altReceteID, t1.en, t1.boy, t1.enBoyBirim,"
			sorgu = sorgu & " t1.stokKontroluYap, t1.receteIslemTipiID, t2.ad, t2.islemTur, t1.onHazirlikTur,  t1.onHazirlikDeger, t5.receteAd as altReceteAd,  t6.uzunBirim as ebUzunBirim,"
			sorgu = sorgu & " stok.FN_anaBirimIDBul(t1.stokID) as anaBirimID, stok.FN_anaBirimADBul(t1.stokID,'uAd') as anaBirimAD, t1.etiketeEkle, t1.etiketAd, t7.receteAd as anaReceteAd, t8.stokAd as esasStokAd,"
			sorgu = sorgu & " stok.FN_anaBirimADBul(t1.stokID,'kAd') as anaBirimADkisa, t1.islemAciklama"
			sorgu = sorgu & " FROM recete.receteAdim t1"
			sorgu = sorgu & " INNER JOIN recete.receteIslemTipi t2 ON t1.receteISlemTipiID = t2.receteISlemTipiID"
			sorgu = sorgu & " LEFT JOIN portal.birimler t4 ON t1.miktarBirim = t4.kisaBirim"
			sorgu = sorgu & " LEFT JOIN recete.recete t5 ON t1.altReceteID = t5.receteID"
			sorgu = sorgu & " LEFT JOIN portal.birimler t6 ON t1.enBoyBirim = t6.kisaBirim"
			sorgu = sorgu & " INNER JOIN recete.recete t7 ON t1.receteID = t7.receteID"
			sorgu = sorgu & " INNER JOIN stok.stok t8 ON t8.stokID = t7.stokID"
			sorgu = sorgu & " WHERE t1.receteAdimID = " & receteAdimID & " and t1.silindi = 0"
			rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				esasStokAd			=	rs("esasStokAd")
				anaReceteAd			=	rs("anaReceteAd")
				islemTur			=	rs("islemTur")
                stokID				=  	rs("stokID")
				anaBirimID			=	rs("anaBirimID")
				anaBirimAD			=	rs("anaBirimAD")
				anaBirimADkisa		=	rs("anaBirimADkisa")
                miktar				=  	rs("miktar")
				miktarBirim			=	rs("miktarBirim")
				islemAciklama		=	rs("islemAciklama")
				fire				=	rs("fire")
				fireBirim			=	rs("fireBirim")
				isGucuSayi			=	rs("isGucuSayi")
				uzunBirim			=	rs("uzunBirim")
				sira				=	rs("sira")
				altReceteID			=	rs("altReceteID")
				altReceteAd			=	rs("altReceteAd")	
				stokKontroluYap		=	rs("stokKontroluYap")
				enUzunluk			=	rs("en")
				boy					=	rs("boy")
				enBoyBirim			=	rs("enBoyBirim")
				ebUzunBirim			=	rs("ebUzunBirim")
				etiketeEkle			=	rs("etiketeEkle")
				etiketAd			=	rs("etiketAd")
				onHazirlikTur		=	rs("onHazirlikTur")
				if onHazirlikTur = "" OR isnull(onHazirlikTur) then
					onHazirlikTur = "Saat"
				end if
				onHazirlikDeger		=	rs("onHazirlikDeger")
				dbReceteIslemTipiID	=	rs("receteIslemTipiID")
				receteIslemAd		=	rs("ad")
				defDeger			=	dbReceteIslemTipiID & "###" & receteIslemAd
				defDeger3			=	miktarBirim & "###" & uzunBirim
				defDeger4			=	fireBirim & "###" & uzunBirim
				defDeger5			=	altReceteID & "###" & altReceteAd
				defDeger6			=	enBoyBirim & "###" & ebUzunBirim
			end if
            rs.close
			
end if

if stokID <> "" then
	sorgu = "SELECT stokID, stokAd, stokKodu, stok.FN_anaBirimADBul(stokID,'uAd') as anaBirimAD FROM stok.stok WHERE stokID = " & stokID
	rs.open sorgu, sbsv5, 1, 3
		anaBirimAD			=	rs("anaBirimAD")
		stokKodu			=	rs("stokKodu")
		stokAd				=  	rs("stokAd")
		defDeger2			=	stokID & "###" & stokKodu & " - " & stokAd
	rs.close
end if

'################ Yeni adım kayıt ediliyorsa seçilen işleme göre inputları göster
'################ Yeni adım kayıt ediliyorsa seçilen işleme göre inputları göster

	if receteISlemTipiID <> "" then
		sorgu = "SELECT t1.islemTur, t1.ad FROM recete.receteIslemTipi t1 WHERE receteISlemTipiID = " & receteISlemTipiID
		rs.open sorgu, sbsv5, 1, 3
			islemTur		=	rs("islemTur")
			receteIslemAd	=	rs("ad")
			defDeger		=	receteISlemTipiID & "###" & receteIslemAd
		rs.close
	else
		receteIslemTipiID = dbReceteIslemTipiID
	end if	
'################ Yeni adım kayıt ediliyorsa seçilen işleme göre inputları göster
'################ Yeni adım kayıt ediliyorsa seçilen işleme göre inputları göster

			chckDurum		=	chckKontrol(etiketeEkle,1)

			etiketisimClass	=	" d-none "
			if etiketeEkle = 1 then
				etiketisimClass = ""
			end if


			if islemTur = "stok" then
				stokClass		=	""
				fireRow			=	" "
				miktarYazi		=	"Miktar"
				fireYazi		=	"Fire"
				mPlaceHolder	=	"Miktar"
				altReceteRow	=	" d-none "
				kisiRow			=	" d-none "
				etiketDurum		=	" "
			elseif islemTur = "zaman" then
				fireRow			=	" d-none "
				stokClass		=	" d-none "
				miktarYazi		=	"Süre"
				mPlaceHolder	=	"İşlem Süresi"
				altReceteRow	=	" d-none "
				etiketDurum		=	" d-none "
			elseif isnull(islemTur) OR islemTur = "" then
				 stokRow		=	" d-none "
				 fireRow		=	" d-none "
				 miktarRow		=	" d-none "
				 altReceteRow	=	" d-none "
				 kisiRow		=	" d-none "
				etiketDurum		=	" d-none "
			end if

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol >= 5 then
	Response.Write "<div id=""adimYeniUStDIV"">"
	
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<div class=""h5""><span class=""rounded bg-warning"">Üretilecek Ana Ürün:</span> " & esasStokAd & "</div>"
		Response.Write "<form action=""/recete/recete_adim_ekle.asp"" method=""post"" class=""ajaxform"">"
			call formhidden("islem",islem,"","","","autocompleteOFF","islem","")
			call formhidden("receteID",receteID,"","","","autocompleteOFF","receteID","")
			call formhidden("receteAdimID",receteAdimID,"","","","autocompleteOFF","receteAdimID","")
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-12"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">İşlem Tipi</div>"
								if islem = "edit" then
									Response.Write "<div class=""ml-4 bold text-danger"">" & receteIslemAd & "</div>"
									call formhidden("receteIslemTipiID",receteIslemTipiID,"","","","autocompleteOFF","receteIslemTipiID","")
								else
									call formselectv2("receteIslemTipiID","","","","formSelect2 receteIslemTipiID border inpReset","","receteIslemTipiID","","data-holderyazi=""İşlem Tipi"" data-jsondosya=""JSON_receteIslemTipi"" data-miniput=""0"" data-defdeger="""&defDeger&"""")
								end if
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2"&kisiRow&""">"
							Response.Write "<div class=""col-12"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">İşlem Açıklaması</div>"
								call forminput("islemAciklama",islemAciklama,"","","inpReset","autocompleteOFF","islemAciklama","")
							Response.Write "</div>"
						Response.Write "</div>"
						'#### STOK - YARI MAMÜL
						Response.Write "<div class=""row mt-2" & stokRow & """>"
							Response.Write "<div class=""col-12" & stokClass & """>"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Hammadde / Yarı Mamul</div>"
								call formselectv2("stokID","","anaBirimKontrol($(this).val(),$(this).attr('id'))","","formSelect2 stokID border","","stokID","","data-holderyazi=""Stok Adı"" data-jsondosya=""JSON_stoklar"" data-miniput=""3"" data-defdeger="""&defDeger2&"""")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2" & miktarRow & """>"
							Response.Write "<div class=""col-3" & stokClass & """>"
								Response.Write "<div class=""badge badge-secondary rounded-left"">En Uzunluğu</div>"
								call forminput("enUzunluk",enUzunluk,"numara(this,true,false)","","inpReset","autocompleteOFF","enUzunluk","")
							Response.Write "</div>"
							Response.Write "<div class=""col-3" & stokClass & """>"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Boy Uzunluğu</div>"
								call forminput("boy",boy,"numara(this,true,false)","","inpReset","autocompleteOFF","boy","")
							Response.Write "</div>"
							Response.Write "<div class=""col-6" & stokClass & """>"
								Response.Write "<div class=""badge badge-secondary rounded-left"">En - Boy Birim</div>"
								call formselectv2("enBoyBirim","","","","formSelect2 enBoyBirim border inpReset","","enBoyBirim","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-defdeger="""&defDeger6&"""")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2" & miktarRow & """>"
							Response.Write "<div class=""col-lg-3 col-sm-4"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">" & miktarYazi & "</div><span class=""pointer text-info" & stokClass & """ onclick=""swal('','Üretilen ürünün hammaddesinden kullanılacak olan miktarı belirtir. Ana birim cinsinden girilmesi şarttır!')""><i class=""mdi mdi-information""></i></span>"
								call forminput("miktar",miktar,"numara(this,true,false);alanHesap('enUzunluk','boy','enBoyBirim','miktarBirim','miktar')",mPlaceHolder,"inpReset","autocompleteOFF","miktar","")
							Response.Write "</div>"
							if islemTur = "zaman" then
								Response.Write "<div class=""col-lg-3 col-sm-4"">"
									Response.Write "<div class=""badge badge-secondary rounded-left"">Birim</div>"
									call formselectv2("miktarBirim","","","","formSelect2 miktarBirim border inpReset","","birimSec","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-defdeger="""&defDeger3&"""")
								Response.Write "</div>"
							else
								Response.Write "<div class=""col-lg-3 col-sm-4 text-center" & stokClass & """>"
									Response.Write "<div class=""badge badge-secondary rounded"">Ana Birim</div><span class=""pointer text-info"" onclick=""swal('','Ürünün stok kartında tanımlanır ve ürün hareket gördükten sonra değiştirilemez!')""><i class=""mdi mdi-information""></i></span>"
									Response.Write "<div class=""mt-2 bold text-danger"">" & anaBirimAD & "</div>"
									call formhidden("miktarBirim",anaBirimADkisa,"","","","autocompleteOFF","miktarBirim","")
								Response.Write "</div>"
							end if
						'Response.Write "<div class=""row" & fireRow & """>"
							Response.Write "<div class=""col-2" & stokClass & """>"
								Response.Write "<div class=""badge badge-secondary rounded-left"">" & fireYazi & "</div>"
								call forminput("fire",fire,"numara(this,true,false)",fireYazi,"inpReset","autocompleteOFF","fire","")
							Response.Write "</div>"
							' Response.Write "<div class=""col-6"">"
							' 	Response.Write "<div class=""badge badge-secondary rounded-left"">Fire Birim</div>"
							' 	call formselectv2("fireBirim","","","","formSelect2 fireBirim border inpReset","","fireBirimSec","","data-holderyazi=""Fire Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-defdeger="""&defDeger4&"""")
							' Response.Write "</div>"
						'Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div id=""altReceteDIV"" class=""row mt-2" & stokRow & """>"
							Response.Write "<div class=""col-12" & stokClass & """>"
								Response.Write "<div class=""badge badge-warning rounded"">Alt Reçete</div><span class=""pointer text-info"" onclick=""swal('','Üstte seçilerek reçeteye eklenen ürünün bizim tarafımızdan üretildiği durumlarda seçilir. Alt Reçete\'nin seçilmesi, üretilmesi için planlama modülünde gerekli kayıtların oluşturulmasını sağlar.<br><br>Alt reçete varsa açılır menüde sadece o reçete görüntülenecektir.')""><i class=""mdi mdi-information""></i></span>"
								call formselectv2("altReceteID","","","","formSelect2 altReceteID border","","altReceteID","","data-holderyazi=""Alt Reçete"" data-jsondosya=""JSON_recete"" data-miniput=""0"" data-sart="""& stokID & """ data-defdeger="""&defDeger5&"""")
							Response.Write "</div>"
						Response.Write "</div>"

						Response.Write "<div id=""etiketDurumDIV"" class=""bg-warning rounded mt-2 "&etiketDurum&""">"
							Response.Write "<div class=""row"">"	
								Response.Write "<div class=""col-lg-3 my-1 rounded"">"
									Response.Write "<div class=""badge badge-secondary rounded-left"">Son ürün etiketine ekle</div>"
									Response.Write "<div class=""text-left"">"
										Response.Write "<input type=""checkbox"" name=""etiketeEkle"" value=""1"" class=""chck30 form-control"" " & chckDurum & " onclick=""$('#DIVetiketAd').toggleClass('d-none');"">"
									Response.Write "</div>"
								Response.Write "</div>"
								Response.Write "<div id=""DIVetiketAd"" class=""col-lg-9" & etiketisimClass & " my-1"">"
									Response.Write "<div class=""badge badge-secondary rounded-left"">Etikette Görünen Ad</div>"
										call forminput("etiketAd",etiketAd,"","","etiketAd pb-2","","etiketAd","")
								Response.Write "</div>"
							Response.Write "</div>"
						Response.Write "</div>"


						'#### STOK - YARI MAMÜL
						
						'#### KİŞİ SAYISI
						Response.Write "<div class=""row mt-2" & kisiRow & """>"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">İşgücü Sayı</div>"
								call forminput("isGucuSayi",isGucuSayi,"numara(this,true,false)","Kişi sayı","inpReset","autocompleteOFF","isGucuSayi","")
							Response.Write "</div>"
						Response.Write "</div>"
						'#### KİŞİ SAYISI

						Response.Write "<div class=""row mt-2"&stokClass&""">"
							Response.Write "<div class=""col-6 my-1"">"
								Response.Write "<span class=""badge badge-secondary rounded-left"">Ön Hazırlık Süre</span>"
								call formselectv2("onHazirlikDeger",onHazirlikDeger,"","","onHazirlikDeger","","onHazirlikDeger",sayiDegerler,"")
							Response.Write "</div>"
							Response.Write "<div class=""col-6 my-1"&stokClass&""">"
								Response.Write "<span class=""badge badge-secondary rounded-left"">Ön Hazırlık Birim</span>"
								call formselectv2("onHazirlikTur",onHazirlikTur,"","","onHazirlikTur","","onHazirlikTur",hazTurDegerler,"")
							Response.Write "</div>"						
						Response.Write "</div>"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-sm-3 my-1"">"
								Response.Write "<span class=""badge badge-secondary rounded-left"">Kullanım Dışı</span>"
								call formselectv2("silindi",int(silindi),"","","silindi","","silindi",HEDegerler,"")
							Response.Write "</div>"
						Response.Write "</div>"

						
						'#### BAŞKA REÇETE ÇAĞIR
						Response.Write "<div class=""row mt-2"&altReceteRow&""">"
							Response.Write "<div class=""col-12"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Alt Reçete Adı</div>"
								call formselectv2("altReceteID","","","","formSelect2 altReceteID border","","altReceteID","","data-holderyazi=""Reçete Adı"" data-jsondosya=""JSON_recete"" data-miniput=""0""")
							Response.Write "</div>"
						Response.Write "</div>"
						'#### BAŞKA REÇETE ÇAĞIR
					if islem = "gor" then
						butonDurum = " d-none "
					else
						butonDurum = ""
					end if
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-auto mt-4""><button type=""submit"" class=""btn btn-primary"&butonDurum&""">KAYDET</button></div>"
						Response.Write "</div>"
		Response.Write "</form>"
	Response.Write "</div>"	
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU



%><!--#include virtual="/reg/rs.asp" -->



<script>
//'//ANCHOR - select2 seçili gelsin data-defdeger 

	$(document).ready(function() {
		$('#receteIslemTipiID, #stokID, #birimSec, #enBoyBirim, #fireBirimSec, #altReceteID').trigger('mouseenter');
		
		
		$('#receteIslemTipiID, #stokID').on('change',function() {
		//$('#receteIslemTipiID').on('change',function() {
			//alert($('#receteIslemTipiID').val());
			$('#adimYeniUStDIV').load('/recete/recete_adim_yeni.asp', {receteISlemTipiID:$('#receteIslemTipiID').val(), receteID:$('#receteID').val(), stokID:$('#stokID').val(),receteAdimID:$('#receteAdimID').val(),islem:$('#islem').val()})
		})
		

	});
	
	

</script>








