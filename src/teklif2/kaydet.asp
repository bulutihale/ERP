<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    hata    =   ""
    modulAd =   "Teklif"
    modulID =   "109"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


	'##### request
	'##### request
		tip						=	Request.Form("tip")
		ad						=	Request.Form("ad_" & tip)
		ikn						=	Request.Form("ikn_" & tip)
		tarih					=	Request.Form("tarih_ihale_" & tip)
		ilanTarih				=	Request.Form("ilanTarih_" & tip)
		eEksiltme				=	Request.Form("eEksiltme_" & tip)
		bayiKurumID				=	Request.Form("bayikurum")
		cariID					=	Request.Form("cariID")
		yeniCariVergiNo			=	Request.Form("yeniCariVergiNo")
		yeniCariAd				=	Request.Form("yeniCariAd")
		firmaID					=	Request.Form("firmasec")
		dosyaSorumlu			=	Request.Form("dosyaSorumlu")
		grupIhale				=	Request.Form("grupIhale_" & tip)
		teklifGecerlikAcik		=	Request.Form("teklifGecerlikAcik")
		bayiDosyaTipi			=	Request.Form("bayiDosyaTipi")
		odemeVadeBayi			=	Request.Form("odemeVadeBayi")
		teklifGecerlikBayi		=	Request.Form("teklifGecerlikBayi")
		teslimatSureBayi		=	Request.Form("teslimatSureBayi")
		odemeVadeOzHast			=	Request.Form("odemeVadeOzHast")
		teklifGecerlikOzHast	=	Request.Form("teklifGecerlikOzHast")
		teslimatSureOzHast		=	Request.Form("teslimatSureOzHast")
		dosyaKayitTip			=	"M"
		durum					=	"normal"
		teslimatKosulAcik		=	Request.Form("teslimatKosulAcik")
		odemeKosulAcik			=	Request.Form("odemeKosulAcik")
		teklifGecerlikeihale	=	Request.Form("teklifGecerlikeihale")
		teslimatKosuleihale		=	Request.Form("teslimatKosuleihale")
		odemeKosuleihale		=	Request.Form("odemeKosuleihale")
		if bayiDosyaTipi = "stok" then
			tarih = date()
		end if
		
	'##### request
	'##### request

	hatamesaj = "Kayıt Başlıyor"
	call logla("Teklif Listesi Ekranı")


	'##### doğrulama
	'##### doğrulama
	
	if tip = "ozel_hast" then
		odemeVade		=	odemeVadeOzHast
		teklifGecerlik	=	teklifGecerlikOzHast
		teslimatSure	=	teslimatSureOzHast
	elseif tip = "bayi" then
		odemeVade		=	odemeVadeBayi
		teklifGecerlik	=	teklifGecerlikBayi
		teslimatSure	=	teslimatSureBayi
	elseif tip = "acik" then
		teklifGecerlik	=	teklifGecerlikAcik
		teslimatKosul	=	teslimatKosulAcik
		odemeKosul		=	odemeKosulAcik
	elseif tip = "eihale" then
		teklifGecerlik	=	teklifGecerlikeihale
		teslimatKosul	=	teslimatKosuleihale
		odemeKosul		=	odemeKosuleihale
	end if
	
	if odemeVade = "" then
		odemeVade = null
	end if
	
	if teklifGecerlik = "" then
		teklifGecerlik = null
	end if
	
	if teslimatSure = "" then
		teslimatSure = null
	end if
	
	if ilanTarih = "" then
		ilanTarih = null
	end if
	
		call rqKontrol(tip,"Lütfen dosya tipini seçin","")
		call rqKontrol(firmaID,"Lütfen firmanızı seçin","")
		call rqKontrol(ad,"Dosya Adı girilmemiş.","")
		call rqKontrol(tarih,"Tarih girilmemiş.","")
	
	if cariID = "" AND yeniCariVergiNo = "" then
		hatamesaj = "Lütfen cari seçin veya Kayıtlı olmayan cari teklifi oluşturmak için vergi numarası girişi yapın."
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	if ikn = "" and tip <> "yaklasik_mal" and tip <> "dog_temin" and tip <> "ozel_hast" and tip <> "bayi" then
		hatamesaj = "İKN girilmemiş."
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	
	
	'##### doğrulama
	'##### doğrulama


'##### DOSYA KAYDET
'##### DOSYA KAYDET
	if tip = "is_arttir" then
		veri_bol 		=	split(ikn,"_")
		anaDosyaID 		=	veri_bol(0)
		cariID			=	veri_bol(1)
		ikn				=	veri_bol(2)
	else
		anaDosyaID		=	0
	end if
	
	if tip = "yaklasik_mal" then
		tarih 			=	date()
	end if
	'## veritabanı
		sorgu = "SELECT * FROM dosya.ihale ORDER BY id DESC"
		rs.open sorgu, sbsv5,1,3
			'##### DOSYA NO OLUŞTUR
			'##### DOSYA NO OLUŞTUR
				if rs.recordcount = 0 then
					dosyaNo_p2	=	"00001"
					dosyaNo 	=	year(date()) & "_" & dosyaNo_p2
				else
					dosyaNo		=	rs("dosyaNo")
					dosyaNo_p2	=	right(dosyaNo,5)
					if int(left(dosyaNo,4)) <> int(year(date())) then
						dosyaNo_p2 = "00000"
					end if
					dosyaNo_p2	=	int(dosyaNo_p2)
					dosyaNo_p2	=	dosyaNo_p2+1
					dosyaNo_p2	=	1000000 + dosyaNo_p2
					dosyaNo_p2	=	right(dosyaNo_p2,5)
					dosyaNo		=	year(date()) & "_" & dosyaNo_p2
				end if
			'##### /DOSYA NO OLUŞTUR
			'##### /DOSYA NO OLUŞTUR
			rs.addnew
				rs("anaDosyaID")		=	anaDosyaID
				rs("cariID")			=	cariID
				rs("kid")				=	kid
				rs("dosyaNo") 			=	dosyaNo
				rs("ihaleTipi")			=	tip
				rs("ikn") 				=	ikn
				rs("durum")				=	durum
				rs("tarih_ihale")		=	tarih
				rs("ilanTarih")			=	ilanTarih
				rs("ad") 				=	ad
				rs("firmaID")			=	firmaID
				rs("bayiDosyaTipi")		=	bayiDosyaTipi
				rs("odemeVade")			=	odemeVade
				rs("teklifGecerlik")	=	teklifGecerlik
				rs("teslimatSure")		=	teslimatSure
				rs("dosyaKayitTip")		=	dosyaKayitTip
				rs("teslimatKosul")		=	teslimatKosul
				rs("odemeKosul")		=	odemeKosul
				rs("yaklasikMalGoster")	= 	"False"
				rs("yerliOranGoster") 	=	"False"
				rs("yeniCariVergiNo")	=	yeniCariVergiNo
				rs("yeniCariAd")		=	yeniCariAd
				
				if tip = "yaklasik_mal" OR bayiDosyaTipi = "bayiYaklasik" then
					rs("mukayeseDurum")		=	"yaklasik"
				end if
				if bayiDosyaTipi = "stok" then
					rs("yaklasikMalGoster")	= 	"False"
					rs("yerliOranGoster") 	=	"False"
					rs("mukayeseDurum")		=	"stok alımı"
				end if
				rs("dosyaSorumlu")		= 	dosyaSorumlu
				
				if bayiKurumID = "" then
				else 
					rs("bayiKurumID")		=	bayiKurumID
				end if
				if grupIhale = "evet" then
					rs("grupIhale") = 1
				end if
				if eEksiltme = "evet" then
					rs("eEksiltme") = 1
				end if
			rs.update
			modulID = rs("id")
		rs.close
		
			hatamesaj = "Kayıt Başarılı."
			call logla(hatamesaj)
			
		
		call jsrun("$(location).attr('href','/teklif2/detay/" & base64_encode_tr(modulID) & "')")
		
		
	'## veritabanı
'##### /DOSYA KAYDET
'##### /DOSYA KAYDET






%>
