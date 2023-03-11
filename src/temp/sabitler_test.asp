<%


	'## SSL
		mainUrl = Request.ServerVariables("HTTP_HOST")
		sb_url=mainUrl
		if Request.ServerVariables("SERVER_PORT") = 443 then
			sb_mainUrlOnEk = "https://"
			sb_ssl=1
		else
			sb_mainUrlOnEk = "http://"
			sb_ssl=0
		end if
	'## SSL


if firmaID = 1 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Çiğli Bilsem"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & ""
		sb_logoMini = sb_mainUrlOnEk & mainUrl & ""
		sb_logo128 = sb_mainUrlOnEk & mainUrl & ""
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Izmir"
		sb_yetkiliPersonel = ""
		sb_ssl = False
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "Çiğli Bilsem"
	'## EMAIL


	'## SSO
		firmaSSO = ""
		firmaSSOAdres = ""
		firmaSSODomain = ""
		firmaSSOLdap = ""
		firmaSSOdb = ""
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 0
		firmaStokSunucu = ""
		firmaStokDB = ""
		firmaStokdbUSR = ""
		firmaStokdbPass = ""
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 0
		firmaCariSunucu = ""
		firmaCariDB = ""
		firmaCaridbUSR = ""
		firmaCaridbPass = ""
	'#### CARİ bilgieri dış db den çekilecekse


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


if firmaID = 2 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Agrobest Grup Portal"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/agrobestlogo.png"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/agrobestlogo.png"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/agrobestlogo.png"
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Izmir"
		sb_yetkiliPersonel = ""
		sb_ssl = False
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "Agrobest Grup Portal"
	'## EMAIL


	'## SSO
		firmaSSO = "ADC"
		firmaSSOAdres = "/adc/auth.asp"
		firmaSSODomain = "agrobestgroup"
		firmaSSOLdap = "LDAP://agrobestgroup.local:389"
		firmaSSOdb = ""
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 0
		firmaStokSunucu = ""
		firmaStokDB = ""
		firmaStokdbUSR = ""
		firmaStokdbPass = ""
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 0
		firmaCariSunucu = ""
		firmaCariDB = ""
		firmaCaridbUSR = ""
		firmaCaridbPass = ""
	'#### CARİ bilgieri dış db den çekilecekse


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


if firmaID = 3 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Gözde"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Izmir"
		sb_yetkiliPersonel = ""
		sb_ssl = False
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "Gözde"
	'## EMAIL


	'## SSO
		firmaSSO = ""
		firmaSSOAdres = ""
		firmaSSODomain = ""
		firmaSSOLdap = ""
		firmaSSOdb = ""
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 0
		firmaStokSunucu = ""
		firmaStokDB = ""
		firmaStokdbUSR = ""
		firmaStokdbPass = ""
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 0
		firmaCariSunucu = ""
		firmaCariDB = ""
		firmaCaridbUSR = ""
		firmaCaridbPass = ""
	'#### CARİ bilgieri dış db den çekilecekse


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


if firmaID = 4 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Belen Gıda Plasiyer Uygulaması"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Izmir"
		sb_yetkiliPersonel = ""
		sb_ssl = False
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "Belen Gıda Plasiyer Uygulaması"
	'## EMAIL


	'## SSO
		firmaSSO = "NETSIS"
		firmaSSOAdres = ""
		firmaSSODomain = ""
		firmaSSOLdap = ""
		firmaSSOdb = ""
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 0
		firmaStokSunucu = ""
		firmaStokDB = ""
		firmaStokdbUSR = ""
		firmaStokdbPass = ""
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 0
		firmaCariSunucu = ""
		firmaCariDB = ""
		firmaCaridbUSR = ""
		firmaCaridbPass = ""
	'#### CARİ bilgieri dış db den çekilecekse


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


if firmaID = 5 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Tio Medikal"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Izmir"
		sb_yetkiliPersonel = ""
		sb_ssl = True
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "Tio Medikal"
	'## EMAIL


	'## SSO
		firmaSSO = ""
		firmaSSOAdres = ""
		firmaSSODomain = ""
		firmaSSOLdap = ""
		firmaSSOdb = "TIO2022"
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 1
		firmaStokSunucu = "."
		firmaStokDB = "TIO2022"
		firmaStokdbUSR = "sbs_bulutihale"
		firmaStokdbPass = "FVDFG@@!!wer3232"
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 1
		firmaCariSunucu = "."
		firmaCariDB = "TIO2022"
		firmaCaridbUSR = "sbs_bulutihale"
		firmaCaridbPass = "FVDFG@@!!wer3232"
	'#### CARİ bilgieri dış db den çekilecekse


	'#### TEKLİF
		sb_TeklifCariAramaLimit = 5
		sb_TeklifFiyatSayi = 2
		sb_TeklifFiyatAd0 = "Teklif Fiyatı"
		sb_TeklifFiyatAd1 = "Perakende Fiyat"
		sb_TeklifFiyatAd2 = "Toptan Fiyat"
		sb_TeklifFiyatAd3 = "Fiyat 3"
		sb_TeklifFiyatAd4 = "Fiyat 4"
		sb_TeklifFiyatiSirifOlanStoklariGizle = False
		sb_TeklifIskontoSayisi = 2
		sb_TeklifOndalikSayi = 2
		sb_TeklifSayiFormatOn = "TeklifSayi"
		sb_TeklifSayiFormatRakam = 2
		sb_TeklifSayiFormat = "on|4yil|2ay|2gun|rakam"
	'#### TEKLİF


	'#### GÖREV TAKİP
		sb_modulAdi = "Görev Takip"
		sb_cariyeGorevVerilsin = False
		sb_etiketEklenebilsin = False
	'#### GÖREV TAKİP


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


if firmaID = 6 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"SBS IT Servis"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Izmir"
		sb_yetkiliPersonel = ""
		sb_ssl = False
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "SBS IT Servis"
	'## EMAIL


	'## SSO
		firmaSSO = ""
		firmaSSOAdres = ""
		firmaSSODomain = ""
		firmaSSOLdap = ""
		firmaSSOdb = ""
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 0
		firmaStokSunucu = ""
		firmaStokDB = ""
		firmaStokdbUSR = ""
		firmaStokdbPass = ""
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 0
		firmaCariSunucu = ""
		firmaCariDB = ""
		firmaCaridbUSR = ""
		firmaCaridbPass = ""
	'#### CARİ bilgieri dış db den çekilecekse


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


if firmaID = 7 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Polimek Teklif"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Izmir"
		sb_yetkiliPersonel = ""
		sb_ssl = False
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "Polimek Teklif"
	'## EMAIL


	'## SSO
		firmaSSO = ""
		firmaSSOAdres = ""
		firmaSSODomain = ""
		firmaSSOLdap = ""
		firmaSSOdb = ""
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 0
		firmaStokSunucu = ""
		firmaStokDB = ""
		firmaStokdbUSR = ""
		firmaStokdbPass = ""
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 0
		firmaCariSunucu = ""
		firmaCariDB = ""
		firmaCaridbUSR = ""
		firmaCaridbPass = ""
	'#### CARİ bilgieri dış db den çekilecekse


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


if firmaID = 8 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Umut 2000 Servis Yazılımı"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Manisa"
		sb_yetkiliPersonel = ""
		sb_ssl = False
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "Umut 2000 Servis Yazılımı"
	'## EMAIL


	'## SSO
		firmaSSO = ""
		firmaSSOAdres = ""
		firmaSSODomain = ""
		firmaSSOLdap = ""
		firmaSSOdb = ""
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 0
		firmaStokSunucu = ""
		firmaStokDB = ""
		firmaStokdbUSR = ""
		firmaStokdbPass = ""
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 0
		firmaCariSunucu = ""
		firmaCariDB = ""
		firmaCaridbUSR = ""
		firmaCaridbPass = ""
	'#### CARİ bilgieri dış db den çekilecekse


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


if firmaID = 11 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"KAPP"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/kapp.png"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/kapp.png"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/kapp.png"
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Izmir"
		sb_yetkiliPersonel = ""
		sb_ssl = False
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "KAPP"
	'## EMAIL


	'## SSO
		firmaSSO = ""
		firmaSSOAdres = ""
		firmaSSODomain = ""
		firmaSSOLdap = ""
		firmaSSOdb = "KAPP2023"
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 1
		firmaStokSunucu = ""
		firmaStokDB = "KAPP2023"
		firmaStokdbUSR = ""
		firmaStokdbPass = ""
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 1
		firmaCariSunucu = ""
		firmaCariDB = "KAPP2023"
		firmaCaridbUSR = ""
		firmaCaridbPass = ""
	'#### CARİ bilgieri dış db den çekilecekse


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


if firmaID = 9 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Tio Medikal 2"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/tio.jpg"
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Izmir"
		sb_yetkiliPersonel = ""
		sb_ssl = False
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "Tio Medikal 2"
	'## EMAIL


	'## SSO
		firmaSSO = ""
		firmaSSOAdres = ""
		firmaSSODomain = ""
		firmaSSOLdap = ""
		firmaSSOdb = "TIO2022"
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 1
		firmaStokSunucu = "."
		firmaStokDB = "TIO2022"
		firmaStokdbUSR = "sbs_bulutihale"
		firmaStokdbPass = "FVDFG@@!!wer3232"
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 1
		firmaCariSunucu = "."
		firmaCariDB = "TIO2022"
		firmaCaridbUSR = "sbs_bulutihale"
		firmaCaridbPass = "FVDFG@@!!wer3232"
	'#### CARİ bilgieri dış db den çekilecekse


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


if firmaID = 10 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"KAPP"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/kapp.png"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/kapp.png"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/kapp.png"
		sb_cdnUrl = sb_mainUrlOnEk & mainUrl & "/cdn"
		sb_konum =	"Izmir"
		sb_yetkiliPersonel = ""
		sb_ssl = False
		'## SERVİSLER
			sb_activeuserUrl =	"/activeuser.asp"
			sb_activeuserTime = 30
		'## SERVİSLER
	'## TEMEL TANIMLAR


	'## YEDEKLEME
		sb_fizikselPath = "C:\web\erp.sbstasarim.com\backup\"
		sb_sqlYedekCompress = True
		sb_sqlYedekCloudMail = "raptiye210@yahoo.com"
		sb_sqlYedekAlGun = "7"
		sb_sqlYedekSilGun = "30"
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "KAPP"
	'## EMAIL


	'## SSO
		firmaSSO = ""
		firmaSSOAdres = ""
		firmaSSODomain = ""
		firmaSSOLdap = ""
		firmaSSOdb = "KAPP2023"
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 1
		firmaStokSunucu = ""
		firmaStokDB = "KAPP2023"
		firmaStokdbUSR = ""
		firmaStokdbPass = ""
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 1
		firmaCariSunucu = ""
		firmaCariDB = ""
		firmaCaridbUSR = ""
		firmaCaridbPass = ""
	'#### CARİ bilgieri dış db den çekilecekse


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
end if


%>