<%
'##### OTOMATİK SSL
'##### OTOMATİK SSL
	mainUrl = Request.ServerVariables("HTTP_HOST")
	sb_url=mainUrl
	if Request.ServerVariables("SERVER_PORT") = 443 then
		sb_mainUrlOnEk = "https://"
		sb_ssl=1
	else
		sb_mainUrlOnEk = "http://"
		sb_ssl=0
	end if
'##### OTOMATİK SSL
'##### OTOMATİK SSL



if firmaID = 5 then
	sb_firmaAd								=	"TİO"
	sb_url									=	mainUrl
    sb_logo									=	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini								=	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logo128								=	sb_mainUrlOnEk & mainUrl & "/cdn/image/logo_128.png"
	sb_cdnUrl								=	sb_mainUrlOnEk & mainUrl & "/cdn"
	sb_konum								=	"izmir"		'hava durumu için
	sb_yetkiliPersonel						=	"Başar Sönmez|+905053376198"			'destek personeli için
	sb_ssl									=	1		'SSL var mı?



	' ## SERVİSLER
	' ## SERVİSLER
		sb_activeuserUrl					=	"/activeuser.asp"
		sb_activeuserTime					=	30			'otomatik veri kontrolü için saniye
	' ## SERVİSLER
	' ## SERVİSLER

	' ## YEDEKLEME
	' ## YEDEKLEME
		sb_fizikselPath						=	"C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress					=	true
		sb_sqlYedekCloudMail				=	"raptiye210@yahoo.com"
		sb_sqlYedekAlGun					=	7		'dashboard üzerinden otomatik yedek alma. yazılacak
		sb_sqlYedekSilGun					=	30		'yetki sorunu veriyor. onar
	' ## YEDEKLEME
	' ## YEDEKLEME

	'## EMAIL
	'## EMAIL
		sb_mailserver		=	"212.68.61.84:587"
		sb_mailsender		=	"teknik@sbstasarim.com"
		sb_mailsenderPass	=	"sgxuewlv12!!@3"
		sb_mailsenderAd		=	"TIO ERP"
	'## EMAIL
	'## EMAIL

	'## SSO
	'## SSO
		firmaSSO			=	""
		firmaSSOAdres		=	""
		firmaSSODomain		=	""
		firmaSSOLdap		=	""
		firmaSSOdb			=	"TIO2022"
	'## SSO
	'## SSO

	'## TEKLİF
	'## TEKLİF
		sb_TeklifCariAramaLimit	=	5		'arama formundan kaç adet cari dönsün
		sb_TeklifFiyatSayi		=	2
		sb_TeklifFiyatAd0		=	"Teklif Fiyatı"
		sb_TeklifFiyatAd1		=	"Perakende Fiyat"
		sb_TeklifFiyatAd2		=	"Toptan Fiyat"
		sb_TeklifFiyatAd3		=	"Fiyat 3"
		sb_TeklifFiyatAd4		=	"Fiyat 4"
		sb_TeklifFiyatiSirifOlanStoklariGizle =   false		'yazılacak
    	sb_TeklifIskontoSayisi  =   2							'teklif hazırlanırken kaç iskontoya izin verilsin
		sb_TeklifOndalikSayi	=	2							'teklif toplamlarında tamsayıdan sonra kaç ondalık karakter olsun
		sb_TeklifSayiFormatOn		=	"TeklifSayi"				'teklif sayısının önünde yer alır
		sb_TeklifSayiFormatRakam	=	2						'kaç hane olacak
		sb_TeklifSayiFormat			=	"on|4yil|2ay|2gun|rakam"						'bu kısmını yazmadım
	'## TEKLİF
	'## TEKLİF

	' ## GÖREV TAKİP
	' ## GÖREV TAKİP
		sb_modulAdi				=	"Görev Takip"
		sb_cariyeGorevVerilsin	=	false
		sb_etiketEklenebilsin	=	true
	' ## GÖREV TAKİP
	' ## GÖREV TAKİP

	' ## MODULLER
	' ## MODULLER
		sb_modul_gorevTakip		=	true
		sb_modul_webmail		=	true
		sb_modul_teklif			=	true
	' ## MODULLER
	' ## MODULLER
end if

if firmaID = 6 then
	sb_firmaAd="SBS TASARIM"
	sb_url=mainUrl
    sb_logo=sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini=sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logo128=sb_mainUrlOnEk & mainUrl & "/cdn/image/logo_128.png"
	sb_cdnUrl=sb_mainUrlOnEk & mainUrl & "/cdn"
	sb_activeuserUrl=sb_mainUrlOnEk & mainUrl & "/activeuser.asp"
	sb_konum="izmir"
	sb_yetkiliPersonel="Başar Sönmez|+905053376198" 
	sb_activeuserUrlTimeout="10000"
	sb_ssl = 1

	'## SMS

	'## EMAIL
	sb_portalMail		=	"portal@sbstasarim.com"
	sb_portalMailUser	=	"portal@sbstasarim.com"
	sb_portalMailPass	=	"portAl112!"
	sb_teklifMail		=	"satis@sbstasarim.com"
	sb_teklifMailUser	=	"satis@sbstasarim.com"
	sb_teklifMailPass	=	"Sati22^11"

	' firmaLogo	=	rs("logo")
	' firmaLogo2	=	rs("logoMini")
	firmaSSO		=	""
	firmaSSOAdres	=	""
	firmaSSODomain	=	""
	firmaSSOLdap	=	""
	firmaSSOdb		=	"TIO2022"

    sb_TBLSTSABIT_cache    =   false
    sb_iskontoSayisi        =   0
end if





if firmaID = 4 then
	sb_firmaAd								=	"Belen Gıda Plasiyer Uygulaması"
	sb_url									=	mainUrl
    sb_logo									=	sb_mainUrlOnEk & mainUrl & "/template/images/belenlogo.jpg"
	sb_logoMini								=	sb_mainUrlOnEk & mainUrl & "/template/images/belenlogo.jpg"
	sb_logo128								=	sb_mainUrlOnEk & mainUrl & "/cdn/image/logo_128.png"
	sb_cdnUrl								=	sb_mainUrlOnEk & mainUrl & "/cdn"
	' ## SERVİSLER
	' ## SERVİSLER
		sb_activeuserUrl					=	"/activeuser.asp"
		sb_activeuserTime					=	30			'otomatik veri kontrolü için saniye
	' ## SERVİSLER
	' ## SERVİSLER
	sb_konum								=	"izmir"		'hava durumu için
	sb_yetkiliPersonel						=	"Başar Sönmez|+905053376198"			'destek personeli için
	sb_ssl									=	1		'SSL var mı?
	' ## YEDEKLEME
	' ## YEDEKLEME
		sb_fizikselPath						=	"C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress					=	true
		sb_sqlYedekCloudMail				=	"raptiye210@yahoo.com"
		sb_sqlYedekAlGun					=	7		'dashboard üzerinden otomatik yedek alma. yazılacak
		sb_sqlYedekSilGun					=	30		'yetki sorunu veriyor. onar
	' ## YEDEKLEME
	' ## YEDEKLEME


	'## EMAIL
	'## EMAIL
		sb_mailserver		=	"212.68.61.84:587"
		sb_mailsender		=	"teknik@sbstasarim.com"
		sb_mailsenderPass	=	"sgxuewlv12!!@3"
		sb_mailsenderAd		=	"TIO ERP"
	'## EMAIL
	'## EMAIL


	'## SSO
	'## SSO
		firmaSSO		=	"NETSIS"
		firmaSSOAdres	=	""
		firmaSSODomain	=	""
		firmaSSOLdap	=	""
		firmaSSOdb		=	"BELEN2022"
	'## SSO
	'## SSO


	'## SİPARİŞ MODULÜ İÇİN
	'## SİPARİŞ MODULÜ İÇİN
		sb_datafiat1           =   "FIYAT1"
		sb_datafiat2           =   "FIYAT2"
		sb_datafiat3           =   "FIYAT3"
		sb_datafiat4           =   ""
		sb_birimfiyatDegistir  =   false
		sb_fiyatiSirifOlanStoklariGizle =   true
    	sb_iskontoSayisi       =   4
	'## SİPARİŞ MODULÜ İÇİN
	'## SİPARİŞ MODULÜ İÇİN

    ' sb_TBLSTSABIT_cache    =   false

	' ## GÖREV TAKİP
	' ## GÖREV TAKİP
		sb_modulAdi				=	"Görev Takip"
		sb_cariyeGorevVerilsin	=	false
		sb_etiketEklenebilsin	=	false
	' ## GÖREV TAKİP
	' ## GÖREV TAKİP


	' ## MODULLER
	' ## MODULLER
		sb_modul_gorevTakip		=	false
		sb_modul_webmail		=	false
		sb_modul_teklif			=	false
	' ## MODULLER
	' ## MODULLER













end if




if firmaID = 8 then
	sb_firmaAd								=	"Cimax"
	sb_url									=	mainUrl
    sb_logo									=	sb_mainUrlOnEk & mainUrl & "/template/images/cimax_logo.png"
	sb_logoMini								=	sb_mainUrlOnEk & mainUrl & "/template/images/cimax_logo.png"
	sb_logo128								=	sb_mainUrlOnEk & mainUrl & "/cdn/image/logo_128.png"
	sb_cdnUrl								=	sb_mainUrlOnEk & mainUrl & "/cdn"
	' ## SERVİSLER
	' ## SERVİSLER
		sb_activeuserUrl					=	"/activeuser.asp"
		sb_activeuserTime					=	30			'otomatik veri kontrolü için saniye
	' ## SERVİSLER
	' ## SERVİSLER
	sb_konum								=	"izmir"		'hava durumu için
	sb_yetkiliPersonel						=	"Başar Sönmez|+905053376198"			'destek personeli için
	sb_ssl									=	1		'SSL var mı?
	' ## YEDEKLEME
	' ## YEDEKLEME
		sb_fizikselPath						=	"C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress					=	true
		sb_sqlYedekCloudMail				=	"raptiye210@yahoo.com"
		sb_sqlYedekAlGun					=	7		'dashboard üzerinden otomatik yedek alma. yazılacak
		sb_sqlYedekSilGun					=	30		'yetki sorunu veriyor. onar
	' ## YEDEKLEME
	' ## YEDEKLEME

	'## EMAIL
	'## EMAIL
		sb_mailserver		=	"212.68.61.84:587"
		sb_mailsender		=	"teknik@sbstasarim.com"
		sb_mailsenderPass	=	"sgxuewlv12!!@3"
		sb_mailsenderAd		=	"Cimax ERP"
	'## EMAIL
	'## EMAIL

	'## SSO
	'## SSO
		firmaSSO			=	""
		firmaSSOAdres		=	""
		firmaSSODomain		=	""
		firmaSSOLdap		=	""
		firmaSSOdb			=	""
	'## SSO
	'## SSO

	' ## GÖREV TAKİP
	' ## GÖREV TAKİP
		sb_modulAdi				=	"Görev Takip"
		sb_cariyeGorevVerilsin	=	true
		sb_etiketEklenebilsin	=	true
	' ## GÖREV TAKİP
	' ## GÖREV TAKİP


	' ## MODULLER
	' ## MODULLER
		sb_modul_gorevTakip		=	true
		sb_modul_webmail		=	false
		sb_modul_teklif			=	false
	' ## MODULLER
	' ## MODULLER



end if


%>