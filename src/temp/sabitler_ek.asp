<%
mainUrl = Request.ServerVariables("HTTP_HOST")
	sb_url=mainUrl
	if Request.ServerVariables("SERVER_PORT") = 443 then
		sb_mainUrlOnEk = "https://"
		sb_ssl=1
	else
		sb_mainUrlOnEk = "http://"
		sb_ssl=0
	end if



if firmaID = 5 then
	sb_firmaAd="TİO"
	sb_url=mainUrl
    sb_logo=sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini=sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logo128=sb_mainUrlOnEk & mainUrl & "/cdn/image/logo_128.png"
	sb_cdnUrl=sb_mainUrlOnEk & mainUrl & "/cdn"
	sb_activeuserUrl=sb_mainUrlOnEk & mainUrl & "/activeuser.asp"
	sb_konum="izmir"
	sb_yetkiliPersonel="Başar Sönmez|+905053376198"
	sb_activeuserUrlTimeout="10000"
	sb_ssl = 0

	'## EMAIL
	sb_portalMail		=	"portal@sbstasarim.com"
	sb_portalMailUser	=	"portal@sbstasarim.com"
	sb_portalMailPass	=	"portAl112!"
	sb_teklifMail		=	"satis@sbstasarim.com"
	sb_teklifMailUser	=	"satis@sbstasarim.com"
	sb_teklifMailPass	=	"Sati22^11"

	'## SSO
	firmaSSO		=	""
	firmaSSOAdres	=	""
	firmaSSODomain	=	""
	firmaSSOLdap	=	""
	firmaSSOdb		=	"TIO2022"

    sb_TBLSTSABIT_cache    =   false
    sb_iskontoSayisi        =   0

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
	sb_ssl = 0
	' yetkiarr=Array("cimax","cimaxpersonel","cimaxadmin")
'	sb_OTSserverIP="192.168.1.244"
	' sb_OTSserverWS="http://84.51.54.8:3033"
	' sb_OTSserverIP="192.168.1.134"
	'sb_OTSserverWS="http://188.38.209.220:3033"
	' sb_OTSNetworkRange="192.168.1.1-192.168.1.254"
	' sb_otsArizaDakika = 20
'	sb_panelKullanimTuru = "Arge"
'	sb_IpSubnet = "255.255.255.0"
'	sb_IpGateway = "192.168.1.8"
'	sb_uygulama = "thema_ik.asp"


	'## SMS
'	sb_smsOperator="mobilpark"
'	sb_smsYontem="Anında"
'	sb_smsBaslik="BELENGIDA"
'	sb_smsApiUser="5320364444"
'	sb_smsApiPass="011021"

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
%>