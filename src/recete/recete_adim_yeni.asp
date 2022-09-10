<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
    receteAdimID		=	Request.QueryString("receteAdimID")
	receteID			=	Request.QueryString("receteID")
	if receteID = "" then
		receteID = Request.Form("receteID")
	end if
    receteISlemTipiID  	=	Request.Form("receteISlemTipiID")
	modulAd 			=   "Reçete"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Yeni Reçete Adım Ekleme Ekranı Girişi")

yetkiKontrol = yetkibul(modulAd)

if receteAdimID <> "" then
            sorgu = "SELECT t1.stokID, t3.stokAd, t1.miktar, t1.isGucuSayi, t1.miktarBirim, t1.fire, t1.fireBirim, t4.uzunBirim, t1.sira, t1.altReceteID, t1.stokKontroluYap, t1.receteIslemTipiID, t2.ad, t2.islemTur"
			sorgu = sorgu & " FROM recete.receteAdim t1"
			sorgu = sorgu & " INNER JOIN recete.receteIslemTipi t2 ON t1.receteISlemTipiID = t2.receteISlemTipiID"
			sorgu = sorgu & " LEFT JOIN stok.stok t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " LEFT JOIN portal.birimler t4 ON t1.miktarBirim = t4.kisaBirim"
			sorgu = sorgu & " WHERE t1.receteAdimID = " & receteAdimID & " and t1.silindi = 0"
			rs.open sorgu, sbsv5, 1, 3
				islemTur			=	rs("islemTur")
                stokID				=  	rs("stokID")
				stokAd				=  	rs("stokAd")
                miktar				=  	rs("miktar")
				miktarBirim			=	rs("miktarBirim")
				fire				=	rs("fire")
				fireBirim			=	rs("fireBirim")
				isGucuSayi			=	rs("isGucuSayi")
				uzunBirim			=	rs("uzunBirim")
				sira				=	rs("sira")
				altReceteID			=	rs("altReceteID")
				stokKontroluYap		=	rs("stokKontroluYap")
				receteIslemTipiID	=	rs("receteIslemTipiID")
				receteIslemAd		=	rs("ad")
				defDeger1			=	receteIslemTipiID&"###"&receteIslemAd
				defDeger2			=	stokID&"###"&stokAd
				defDeger3			=	miktarBirim&"###"&uzunBirim
				defDeger4			=	fireBirim&"###"&uzunBirim
            rs.close
			
end if

'################ Yeni adım kayıt ediliyorsa seçilen işleme göre inputları göster
'################ Yeni adım kayıt ediliyorsa seçilen işleme göre inputları göster

	if receteISlemTipiID <> "" then
		sorgu = "SELECT t1.islemTur, t1.ad FROM recete.receteIslemTipi t1 WHERE receteISlemTipiID = " & receteISlemTipiID
		rs.open sorgu, sbsv5, 1, 3
			islemTur	=	rs("islemTur")
			islemAd		=	rs("ad")
			defDeger	=	receteISlemTipiID&"###"&islemAd
		rs.close
	end if	
'################ Yeni adım kayıt ediliyorsa seçilen işleme göre inputları göster
'################ Yeni adım kayıt ediliyorsa seçilen işleme göre inputları göster

			if islemTur = "stok" then
				stokClass		=	""
				fireRow			=	" "
				miktarYazi		=	"Miktar"
				fireYazi		=	"Fire"
				mPlaceHolder	=	"Miktar"
				altReceteRow	=	" d-none "
				 kisiRow		=	" d-none "
			elseif islemTur = "zaman" then
				fireRow			=	" d-none "
				stokClass		=	" d-none "
				miktarYazi		=	"Süre"
				mPlaceHolder	=	"İşlem Süresi"
				altReceteRow	=	" d-none "
			elseif isnull(islemTur) OR islemTur = "" then
				 stokRow		=	" d-none "
				 fireRow		=	" d-none "
				 miktarRow		=	" d-none "
				 altReceteRow	=	" d-none "
				 kisiRow		=	" d-none "
			end if

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol >= 5 then
	Response.Write "<div id=""adimYeniUStDIV"">"
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/recete/recete_adim_ekle.asp"" method=""post"" class=""ajaxform"">"
			call formhidden("receteID",receteID,"","","","autocompleteOFF","receteID","")
			call formhidden("receteAdimID",receteAdimID,"","","","autocompleteOFF","receteAdimID","")
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-12"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">İşlem Tipi</div>"
								call formselectv2("receteIslemTipiID","","","","formSelect2 receteIslemTipiID border inpReset","","receteIslemTipiID","","data-holderyazi=""İşlem Tipi"" data-jsondosya=""JSON_receteIslemTipi"" data-miniput=""0"" data-defdeger="""&defDeger&"""")
							Response.Write "</div>"
						Response.Write "</div>"


						'#### STOK - YARI MAMÜL
						Response.Write "<div class=""row mt-2" & stokRow & """>"
							Response.Write "<div class=""col-12" & stokClass & """>"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Stok</div>"
								call formselectv2("stokID","","","","formSelect2 stokID border","","stokID","","data-holderyazi=""Stok Adı"" data-jsondosya=""JSON_stoklar"" data-miniput=""3"" data-defdeger="""&defDeger2&"""")
							Response.Write "</div>"
						Response.Write "</div>"

						Response.Write "<div class=""row mt-2" & miktarRow & """>"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">" & miktarYazi & "</div>"
								call forminput("miktar",miktar,"numara(this,true,false)",mPlaceHolder,"inpReset","autocompleteOFF","miktar","")
							Response.Write "</div>"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Birim</div>"
								call formselectv2("miktarBirim","","","","formSelect2 miktarBirim border inpReset","","birimSec","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-defdeger="""&defDeger3&"""")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2" & fireRow & """>"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">" & fireYazi & "</div>"
								call forminput("fire",fire,"numara(this,true,false)",fireYazi,"inpReset","autocompleteOFF","fire","")
							Response.Write "</div>"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Fire Birim</div>"
								call formselectv2("fireBirim","","","","formSelect2 fireBirim border inpReset","","fireBirimSec","","data-holderyazi=""Fire Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-defdeger="""&defDeger4&"""")
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
						
						'#### BAŞKA REÇETE ÇAĞIR
						Response.Write "<div class=""row mt-2"&altReceteRow&""">"
							Response.Write "<div class=""col-12"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Alt Reçete Adı</div>"
								call formselectv2("altReceteID","","","","formSelect2 altReceteID border","","altReceteID","","data-holderyazi=""Reçete Adı"" data-jsondosya=""JSON_recete"" data-miniput=""0""")
							Response.Write "</div>"
						Response.Write "</div>"
						'#### BAŞKA REÇETE ÇAĞIR

						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-auto mt-4""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
						Response.Write "</div>"
		Response.Write "</form>"
	Response.Write "</div>"	
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU



%><!--#include virtual="/reg/rs.asp" -->




<script>
	$(document).ready(function() {
		$('#receteIslemTipiID, #stokID, #birimSec, #fireBirimSec, #altReceteID').trigger('mouseenter');
		
		
		$('#receteIslemTipiID').on('change',function() {
			$('#adimYeniUStDIV').load('/recete/recete_adim_yeni.asp', {receteISlemTipiID:$(this).val(), receteID:$('#receteID').val()})
		})
		

	});
	
	

</script>








