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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
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
		firmaStokDBvar = 0
		firmaStokSunucu = "."
		firmaStokDB = "TIO2022"
		firmaStokdbUSR = "sbs_bulutihale"
		firmaStokdbPass = "FVDFG@@!!wer3232"
	'#### STOK bilgieri dış db den çekilecekse


	'#### STOK
		sb_stokKoduZorunlu = True
	'#### STOK


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 0
		firmaCariSunucu = "."
		firmaCariDB = "TIO2022"
		firmaCaridbUSR = "sbs_bulutihale"
		firmaCaridbPass = "FVDFG@@!!wer3232"
	'#### CARİ bilgieri dış db den çekilecekse


	'#### TEKLİF
		sb_TeklifCariAramaLimit = 5
		sb_TeklifFiyatSayi = 2
		sb_TeklifFiyatAd0 = "Teklif Fiyatı"
		sb_TeklifFiyatAd1 = "TL Fiyatı"
		sb_TeklifFiyatAd2 = "USD Fiyatı"
		sb_TeklifFiyatAd3 = "Fiyat 3"
		sb_TeklifFiyatAd4 = "Fiyat 4"
		sb_TeklifFiyatiSirifOlanStoklariGizle = False
		sb_TeklifIskontoSayisi = 2
		sb_TeklifOndalikSayi = 2
		sb_TeklifSayiFormatOn = "TeklifSayi"
		sb_TeklifSayiFormatRakam = 2
		sb_TeklifSayiFormat = "on|4yil|2ay|2gun|rakam"
		sb_kosulFontSize = "11px"
	'#### TEKLİF


	'#### GÖREV TAKİP
		sb_modulAdi = "Görev Takip"
		sb_cariyeGorevVerilsin = False
		sb_etiketEklenebilsin = False
	'#### GÖREV TAKİP


	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Netsis,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS,Yardım"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=3,Düzenleyebilir=5,Maskesiz Görebilir ve Düzenleyebilir=6,Verileri Dışarı Aktarabilir=7,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Netsis##Giriş Yapamaz=0,Senkronizasyonu Çalıştırabilir=2,Fiyatları Güncelleyebilir=4,Yönetici İşlemlerini Yapabilir=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9|Yardım##Sadece Görebilir=0,İçerik Girebilir=5,İçerikleri Güncelleyebilir=6,Yönetici=9"
	'#### PERSONEL YETKİLER


	'#### PORTAL AYARLARI
		geoIPCozumle="off"
		geoIPBlok="off"
		sb_ekMaliyet1="Shipment Cost"
	'#### PORTAL AYARLARI


end if


if firmaID = 6 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"SBS ERP Test"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/gozdegrubu.png"
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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
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


	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Netsis,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS,Yardım"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=3,Düzenleyebilir=5,Maskesiz Görebilir ve Düzenleyebilir=6,Verileri Dışarı Aktarabilir=7,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Netsis##Giriş Yapamaz=0,Senkronizasyonu Çalıştırabilir=2,Fiyatları Güncelleyebilir=4,Yönetici İşlemlerini Yapabilir=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9|Yardım##Sadece Görebilir=0,İçerik Girebilir=5,İçerikleri Güncelleyebilir=6,Yönetici=9"
	'#### PERSONEL YETKİLER


	'#### PORTAL AYARLARI
		geoIPCozumle="off"
	'#### PORTAL AYARLARI


end if


if firmaID = 7 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Polimek Teklif"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/polimek_logo.jpg"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/polimek_logo.jpg"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/polimek_logo.jpg"
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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
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


	'#### STOK
		sb_stokKoduZorunlu = False
	'#### STOK


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 0
		firmaCariSunucu = ""
		firmaCariDB = ""
		firmaCaridbUSR = ""
		firmaCaridbPass = ""
	'#### CARİ bilgieri dış db den çekilecekse


	'#### TEKLİF
		sb_TeklifCariAramaLimit = 5
		sb_TeklifFiyatSayi = 2
		sb_TeklifFiyatAd0 = "Perakende Satış Fiyatı"
		sb_TeklifFiyatAd1 = "Toptan Satış Fiyatı"
		sb_TeklifFiyatAd2 = "USD Fiyatı"
		sb_TeklifFiyatAd3 = "Fiyat 3"
		sb_TeklifFiyatAd4 = "Fiyat 4"
		sb_TeklifFiyatiSirifOlanStoklariGizle = False
		sb_TeklifIskontoSayisi = 2
		sb_TeklifOndalikSayi = 2
		sb_TeklifSayiFormatOn = "polimek"
		sb_TeklifSayiFormatRakam = 2
		sb_TeklifSayiFormat = "on|4yil|2ay|2gun|rakam"
		sb_kosulFontSize = "11px"
	'#### TEKLİF


	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Netsis,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS,Yardım"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=3,Düzenleyebilir=5,Maskesiz Görebilir ve Düzenleyebilir=6,Verileri Dışarı Aktarabilir=7,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Netsis##Giriş Yapamaz=0,Senkronizasyonu Çalıştırabilir=2,Fiyatları Güncelleyebilir=4,Yönetici İşlemlerini Yapabilir=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9|Yardım##Sadece Görebilir=0,İçerik Girebilir=5,İçerikleri Güncelleyebilir=6,Yönetici=9"
	'#### PERSONEL YETKİLER


	'#### PORTAL AYARLARI
		geoIPCozumle="on"
		geoIPBlok="off"
		sb_teklifOlusuncaDownloadOlsun="on"
		sb_teklifAltiGenelIskonto="on"
	'#### PORTAL AYARLARI


end if


if firmaID = 11 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"KAPP Portal"
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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
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
		firmaSSOdb = ""
	'## SSO


	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar = 1
		firmaStokSunucu = "212.156.34.226"
		firmaStokDB = "KAPP2023"
		firmaStokdbUSR = "basar.sonmez"
		firmaStokdbPass = "Powder12@"
	'#### STOK bilgieri dış db den çekilecekse


	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar = 1
		firmaCariSunucu = "212.156.34.226"
		firmaCariDB = "KAPP2023"
		firmaCaridbUSR = "basar.sonmez"
		firmaCaridbPass = "Powder12@"
	'#### CARİ bilgieri dış db den çekilecekse


	'#### TOPLU MAİL
		sb_gonderimT1 = "10:00"
		sb_gonderimT2 = "17:00"
		sb_gonderimMiktari = 1
	'#### TOPLU MAİL


	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Netsis,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS,Yardım"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=3,Düzenleyebilir=5,Maskesiz Görebilir ve Düzenleyebilir=6,Verileri Dışarı Aktarabilir=7,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Netsis##Giriş Yapamaz=0,Senkronizasyonu Çalıştırabilir=2,Fiyatları Güncelleyebilir=4,Yönetici İşlemlerini Yapabilir=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9|Yardım##Sadece Görebilir=0,İçerik Girebilir=5,İçerikleri Güncelleyebilir=6,Yönetici=9"
	'#### PERSONEL YETKİLER


	'#### PORTAL AYARLARI
		geoIPCozumle="off"
		sb_depoEntegrasyon="Netsis"
	'#### PORTAL AYARLARI


end if


if firmaID = 12 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Polikod Teklif"
		sb_url =	mainUrl
		sb_logo = sb_mainUrlOnEk & mainUrl & "/template/images/polikod_logo.jpg"
		sb_logoMini = sb_mainUrlOnEk & mainUrl & "/template/images/polikod_logo.jpg"
		sb_logo128 = sb_mainUrlOnEk & mainUrl & "/template/images/polikod_logo.jpg"
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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
	'## YEDEKLEME


	'## EMAIL
		sb_mailserver = "212.68.61.84:587"
		sb_mailsender = "teknik@sbstasarim.com"
		sb_mailsenderPass = "sgxuewlv12!!@3"
		sb_mailsenderAd = "Polikod Teklif"
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


	'#### TEKLİF
		sb_TeklifCariAramaLimit = 5
		sb_TeklifFiyatSayi = 2
		sb_TeklifFiyatAd0 = "Perakende Satış Fiyatı"
		sb_TeklifFiyatAd1 = "Toptan Satış Fiyatı"
		sb_TeklifFiyatAd2 = "USD Fiyatı"
		sb_TeklifFiyatAd3 = "Fiyat 3"
		sb_TeklifFiyatAd4 = "Fiyat 4"
		sb_TeklifFiyatiSirifOlanStoklariGizle = False
		sb_TeklifIskontoSayisi = 2
		sb_TeklifOndalikSayi = 2
		sb_TeklifSayiFormatOn = "polikod"
		sb_TeklifSayiFormatRakam = 2
		sb_TeklifSayiFormat = "on|4yil|2ay|2gun|rakam"
		sb_kosulFontSize = "11px"
	'#### TEKLİF


	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Netsis,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS,Yardım"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=3,Düzenleyebilir=5,Maskesiz Görebilir ve Düzenleyebilir=6,Verileri Dışarı Aktarabilir=7,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Netsis##Giriş Yapamaz=0,Senkronizasyonu Çalıştırabilir=2,Fiyatları Güncelleyebilir=4,Yönetici İşlemlerini Yapabilir=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9|Yardım##Sadece Görebilir=0,İçerik Girebilir=5,İçerikleri Güncelleyebilir=6,Yönetici=9"
	'#### PERSONEL YETKİLER


	'#### PORTAL AYARLARI
		geoIPCozumle="off"
	'#### PORTAL AYARLARI


end if


%>