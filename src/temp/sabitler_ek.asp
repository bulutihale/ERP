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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
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
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
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
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
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
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
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
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
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


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
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


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
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
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
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
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
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


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
end if


if firmaID = 12 then
	'## TEMEL TANIMLAR
		sb_firmaAd =	"Polimek Teklif Uygulaması"
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
		sb_mailserver = ""
		sb_mailsender = ""
		sb_mailsenderPass = ""
		sb_mailsenderAd = ""
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
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
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
		sb_sqlYedekAlGun = 7
		sb_sqlYedekSilGun = 30
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
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
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


	'#### MODULLER
		sb_modul_gorevTakip = true
		sb_modul_webmail = true
		sb_modul_teklif = true
	'#### MODULLER
	'#### PERSONEL YETKİLER
		sb_modul="Admin,Cari,Depo,Gelişmiş Teklif,Görev Takip,Kalite Kontrol,Kesimhane,Lojistik,Mal Kabul,Personel,Planlama,Raporlar,Reçete,Satın Alma,Satış,Sterilizasyon,Stok,Teklif,Toplu Mail,Üretim,ÜTS"
		sb_moduller="Admin##Giriş Yapamaz=0,Yönetici=9|Cari##Giriş Yapamaz=0,Yönetici=9|Depo##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Gelişmiş Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Görev Takip##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Görevi Silebilir=6,Bölüm Yöneticisi=7,Genel Yönetici=9|Kalite Kontrol##Giriş Yapamaz=0,Yönetici=9|Kesimhane##Giriş Yapamaz=0,Görüntüleyebilir=1,Kesim Başlatabilir=7,Yönetici=9|Lojistik##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Mal Kabul##Giriş Yapamaz=0,Yönetici=9|Personel##Giriş Yapamaz=0,Personelleri Listeleyebilir=1,Yeni Personel Ekleyebilir=2,Personel Bilgilerini Düzenleyebilir=4,Personel Silebilir=6,Yetkileri Düzenleyebilir=7,Yönetici=9|Planlama##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=3,Onay Verebilir=6,Silebilir=8,Yönetici=9|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9|Reçete##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Satın Alma##Giriş Yapamaz=0,Talepleri Görebilir=1,Talep Oluşturabilir=2,Sipariş Açabilir=5,Yönetici=9|Satış##Giriş Yapamaz=0,Yönetici=9|Sterilizasyon##Giriş Yapamaz=0,Görüntüleyebilir=1,Sterilizasyon Başlatabilir=7,Yönetici=9|Stok##Giriş Yapamaz=0,Görebilir=1,Düzenleyebilir=5,Silebilir=8,Yönetici=9|Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9|Toplu Mail##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6|Üretim##Giriş Yapamaz=0,Görüntüleyebilir=1,Üretim Başlatabilir=7,Yönetici=9|ÜTS##Giriş Yapamaz=0,Yönetici=9"
	'#### PERSONEL YETKİLER
end if


%>