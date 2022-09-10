<%
mainUrl = Request.ServerVariables("HTTP_HOST")

if sayfasonu = True then
	' sb_firmaAd="Belen Gıda "
	' sb_url=mainUrl
	' if Request.ServerVariables("SERVER_PORT") = 443 then
	' 	sb_mainUrlOnEk = "https://"
	' 	sb_ssl=1
	' else
	' 	sb_mainUrlOnEk = "http://"
	' 	sb_ssl=0
	' end if
' 	sb_logo=sb_mainUrlOnEk & mainUrl & "/cdn/image/logo_300.png"
' 	sb_logoMini=sb_mainUrlOnEk & mainUrl & "/cdn/image/logo_200.png"
' 	sb_logo128=sb_mainUrlOnEk & mainUrl & "/cdn/image/logo_128.png"
' 	sb_cdnUrl=sb_mainUrlOnEk & mainUrl & "/cdn"
' 	sb_activeuserUrl=sb_mainUrlOnEk & mainUrl & "/activeuser.asp"
' 	sb_konum="izmir"
' 	sb_yetkiliPersonel="Başar Sönmez|+905053376198"
' 	sb_activeuserUrlTimeout="10000"
' 	sb_ssl = 1
' 	' yetkiarr=Array("cimax","cimaxpersonel","cimaxadmin")
' '	sb_OTSserverIP="192.168.1.244"
' 	' sb_OTSserverWS="http://84.51.54.8:3033"
' 	' sb_OTSserverIP="192.168.1.134"
' 	'sb_OTSserverWS="http://188.38.209.220:3033"
' 	' sb_OTSNetworkRange="192.168.1.1-192.168.1.254"
' 	' sb_otsArizaDakika = 20
' 	sb_panelKullanimTuru = "Arge"
' 	sb_IpSubnet = "255.255.255.0"
' 	sb_IpGateway = "192.168.1.8"
' 	sb_uygulama = "thema_ik.asp"
else
	'## DB
	sb_dbsunucu="."
	sb_dbad="sbs_tio"
	sb_dbuser="sbs_bulutihale"
	sb_dbpass="FVDFG@@!!wer3232"
end if
%>