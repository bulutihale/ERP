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
	sb_firmaAd="TİO"
	sb_url=mainUrl
    sb_logo=sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini=sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logo128=sb_mainUrlOnEk & mainUrl & "/cdn/image/logo_128.png"
	sb_cdnUrl=sb_mainUrlOnEk & mainUrl & "/cdn"
	sb_activeuserUrl="/activeuser.asp"
	sb_activeuserTime=5'saniye
	' sb_activeuserUrl=sb_mainUrlOnEk & mainUrl & "/activeuser.asp"
	sb_konum="izmir"																			'hava durumu için
	sb_yetkiliPersonel="Başar Sönmez|+905053376198"												'destek için. eklenecek
	sb_activeuserUrlTimeout="10000"																'çalışmıyor
	sb_ssl = 1
	sb_fizikselPath = "C:\HostingSpaces\sbstasarim3\tio.sbstasarim.com\backup\"
	sb_sqlYedekCompress = true
	sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
	sb_sqlYedekAlGun	=	7																	'dashboard üzerinden otomatik yedek alma. yazılacak
	sb_sqlYedekSilGun	=	30																	'yetki sorunu veriyor. onar

	'## EMAIL
	sb_mailserver		=	"212.68.61.84:587"
	sb_mailsender		=	"teknik@sbstasarim.com"
	sb_mailsenderPass	=	"sgxuewlv12!!@3"
	sb_mailsenderAd		=	"TIO ERP"
	' sb_portalMail		=	"portal@sbstasarim.com"
	' sb_portalMailUser	=	"portal@sbstasarim.com"
	' sb_portalMailPass	=	"portAl112!"
	' sb_teklifMail		=	"satis@sbstasarim.com"
	' sb_teklifMailUser	=	"satis@sbstasarim.com"
	' sb_teklifMailPass	=	"Sati22^11"

	'## SSO
	firmaSSO			=	""
	firmaSSOAdres		=	""
	firmaSSODomain		=	""
	firmaSSOLdap		=	""
	firmaSSOdb			=	"TIO2022"

    sb_TBLSTSABIT_cache	=   false
    sb_iskontoSayisi	=   0

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

'    sb_datafiat1           =   "SATIS_FIAT1"
'    sb_datafiat2           =   "SATIS_FIAT2"
'    sb_datafiat3           =   ""
'    sb_datafiat4           =   ""
'    sb_birimfiyatDegistir   =   false
'    sb_fiyatiSirifOlanStoklariGizle =   true

end if





if firmaID = 4 then
	sb_firmaAd="Belen Gıda Plasiyer Uygulaması"
	sb_url=mainUrl
    sb_logo=sb_mainUrlOnEk & mainUrl & "/template/images/belenlogo.jpg"
	sb_logoMini=sb_mainUrlOnEk & mainUrl & "/template/images/belenlogo.jpg"
	sb_logo128=sb_mainUrlOnEk & mainUrl & "/cdn/image/logo_128.png"
	sb_cdnUrl=sb_mainUrlOnEk & mainUrl & "/cdn"
	sb_activeuserUrl=sb_mainUrlOnEk & mainUrl & "/activeuser.asp"
	sb_konum="izmir"
	sb_yetkiliPersonel="Başar Sönmez|+905053376198"
	sb_activeuserUrlTimeout="10000"
	sb_ssl = 1
	sb_panelKullanimTuru = "Arge"

	'## SMS

	'## SSO
	firmaSSO		=	"NETSIS"
	firmaSSOAdres	=	""
	firmaSSODomain	=	""
	firmaSSOLdap	=	""
	firmaSSOdb		=	"BELEN2022"

    sb_TBLSTSABIT_cache    =   false
    sb_iskontoSayisi        =   0

    sb_datafiat1           =   "SATIS_FIAT1"
    sb_datafiat2           =   "SATIS_FIAT2"
    sb_datafiat3           =   ""
    sb_datafiat4           =   ""
    sb_birimfiyatDegistir   =   false
    sb_fiyatiSirifOlanStoklariGizle =   true


end if


%>