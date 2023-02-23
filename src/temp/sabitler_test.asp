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


if firmaID = 1 then
	sb_firmaAd =	"Çiğli Bilsem"
	sb_url =	mainUrl
	sb_logo =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini =	sb_mainUrlOnEk & mainUrl & ""
	sb_logo128 =	sb_mainUrlOnEk & mainUrl & ""
	sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & "/cdn"
	sb_konum =	"Izmir"
	sb_yetkiliPersonel =	""	sb_ssl = False


' ## SERVİSLER	sb_activeuserUrl =	""
	sb_activeuserTime = 3
' ## SERVİSLER

	sb_fizikselPath="C:\web\erp.sbstasarim.com\backup\"	sb_sqlYedekCompress=true	sb_sqlYedekCloudMail="raptiye210@yahoo.com"	sb_sqlYedekAlGun=	7					end if




if firmaID = 2 then
	sb_firmaAd =	"Agrobest Grup Portal"
	sb_url =	mainUrl
	sb_logo =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini =	sb_mainUrlOnEk & mainUrl & "/template/images/agrobestlogo.png"
	sb_logo128 =	sb_mainUrlOnEk & mainUrl & "/template/images/agrobestlogo.png"
	sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & ""
	sb_konum =	"Izmir"
	sb_yetkiliPersonel =	""	sb_ssl = False


' ## SERVİSLER	sb_activeuserUrl =	""
	sb_activeuserTime = 3
' ## SERVİSLER

	sb_fizikselPath="C:\web\erp.sbstasarim.com\backup\"	sb_sqlYedekCompress=true	sb_sqlYedekCloudMail="raptiye210@yahoo.com"	sb_sqlYedekAlGun=	7					end if




if firmaID = 3 then
	sb_firmaAd =	"Gözde"
	sb_url =	mainUrl
	sb_logo =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini =	sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
	sb_logo128 =	sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
	sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & ""
	sb_konum =	"Izmir"
	sb_yetkiliPersonel =	""	sb_ssl = False


' ## SERVİSLER	sb_activeuserUrl =	""
	sb_activeuserTime = 3
' ## SERVİSLER

	sb_fizikselPath="C:\web\erp.sbstasarim.com\backup\"	sb_sqlYedekCompress=true	sb_sqlYedekCloudMail="raptiye210@yahoo.com"	sb_sqlYedekAlGun=	7					end if




if firmaID = 4 then
	sb_firmaAd =	"Belen Gıda Plasiyer Uygulaması"
	sb_url =	mainUrl
	sb_logo =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini =	sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
	sb_logo128 =	sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
	sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & ""
	sb_konum =	"Izmir"
	sb_yetkiliPersonel =	""	sb_ssl = False


' ## SERVİSLER	sb_activeuserUrl =	""
	sb_activeuserTime = 3
' ## SERVİSLER

	sb_fizikselPath="C:\web\erp.sbstasarim.com\backup\"	sb_sqlYedekCompress=true	sb_sqlYedekCloudMail="raptiye210@yahoo.com"	sb_sqlYedekAlGun=	7					end if




if firmaID = 6 then
	sb_firmaAd =	"SBS IT Servis"
	sb_url =	mainUrl
	sb_logo =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini =	sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
	sb_logo128 =	sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
	sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & ""
	sb_konum =	"Izmir"
	sb_yetkiliPersonel =	""	sb_ssl = False


' ## SERVİSLER	sb_activeuserUrl =	""
	sb_activeuserTime = 3
' ## SERVİSLER

	sb_fizikselPath="C:\web\erp.sbstasarim.com\backup\"	sb_sqlYedekCompress=true	sb_sqlYedekCloudMail="raptiye210@yahoo.com"	sb_sqlYedekAlGun=	7					end if




if firmaID = 7 then
	sb_firmaAd =	"Polimek Teklif"
	sb_url =	mainUrl
	sb_logo =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini =	sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
	sb_logo128 =	sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
	sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & ""
	sb_konum =	"Izmir"
	sb_yetkiliPersonel =	""	sb_ssl = False


' ## SERVİSLER	sb_activeuserUrl =	""
	sb_activeuserTime = 3
' ## SERVİSLER

	sb_fizikselPath="C:\web\erp.sbstasarim.com\backup\"	sb_sqlYedekCompress=true	sb_sqlYedekCloudMail="raptiye210@yahoo.com"	sb_sqlYedekAlGun=	7					end if




if firmaID = 8 then
	sb_firmaAd =	"Umut 2000 Servis Yazılımı"
	sb_url =	mainUrl
	sb_logo =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini =	sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
	sb_logo128 =	sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
	sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & ""
	sb_konum =	"Manisa"
	sb_yetkiliPersonel =	""	sb_ssl = False


' ## SERVİSLER	sb_activeuserUrl =	""
	sb_activeuserTime = 3
' ## SERVİSLER

	sb_fizikselPath="C:\web\erp.sbstasarim.com\backup\"	sb_sqlYedekCompress=true	sb_sqlYedekCloudMail="raptiye210@yahoo.com"	sb_sqlYedekAlGun=	7					end if




if firmaID = 11 then
	sb_firmaAd =	"KAPP"
	sb_url =	mainUrl
	sb_logo =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini =	sb_mainUrlOnEk & mainUrl & ""
	sb_logo128 =	sb_mainUrlOnEk & mainUrl & ""
	sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & ""
	sb_konum =	"Izmir"
	sb_yetkiliPersonel =	""	sb_ssl = False


' ## SERVİSLER	sb_activeuserUrl =	""
	sb_activeuserTime = 3
' ## SERVİSLER

	sb_fizikselPath="C:\web\erp.sbstasarim.com\backup\"	sb_sqlYedekCompress=true	sb_sqlYedekCloudMail="raptiye210@yahoo.com"	sb_sqlYedekAlGun=	7					end if




if firmaID = 9 then
	sb_firmaAd =	"Tio Medikal 2"
	sb_url =	mainUrl
	sb_logo =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logo128 =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & ""
	sb_konum =	"Izmir"
	sb_yetkiliPersonel =	""	sb_ssl = False


' ## SERVİSLER	sb_activeuserUrl =	""
	sb_activeuserTime = 3
' ## SERVİSLER

	sb_fizikselPath="C:\web\erp.sbstasarim.com\backup\"	sb_sqlYedekCompress=true	sb_sqlYedekCloudMail="raptiye210@yahoo.com"	sb_sqlYedekAlGun=	7					end if




if firmaID = 10 then
	sb_firmaAd =	"KAPP"
	sb_url =	mainUrl
	sb_logo =	sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
	sb_logoMini =	sb_mainUrlOnEk & mainUrl & ""
	sb_logo128 =	sb_mainUrlOnEk & mainUrl & ""
	sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & ""
	sb_konum =	"Izmir"
	sb_yetkiliPersonel =	""	sb_ssl = False


' ## SERVİSLER	sb_activeuserUrl =	""
	sb_activeuserTime = 3
' ## SERVİSLER

	sb_fizikselPath="C:\web\erp.sbstasarim.com\backup\"	sb_sqlYedekCompress=true	sb_sqlYedekCloudMail="raptiye210@yahoo.com"	sb_sqlYedekAlGun=	7					end if




%>