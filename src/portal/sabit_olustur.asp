<!--#include virtual="/temp/sabitler.asp" --><%

'#########
' temp/sabitler_ek.asp dosyasını oluşturur
'#########

'######### sabitleri bozacağımız için db ye manuel bağlanacağız
	set sbsv5=Server.CreateObject("ADODB.Connection")
	baglantibilgileri = "Provider=SQLOLEDB;Data Source=" & sb_dbsunucu & ";Initial Catalog=" & sb_dbad & ";User Id=" & sb_dbuser & ";Password=" & sb_dbpass & ";"
	sbsv5.Open baglantibilgileri
	Set rs = Server.CreateObject("ADODB.Recordset")
'######### sabitleri bozacağımız için db ye manuel bağlanacağız




'#### ön hazırlık
	Set objStream = server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.CharSet = "UTF-8"
'#### ön hazırlık



'dosya içeriği
    objStream.WriteText "<"
    objStream.WriteText "%" & vbcrlf

    '##### OTOMATİK SSL
        objStream.WriteText "mainUrl = Request.ServerVariables(""HTTP_HOST"")" & vbcrlf
        objStream.WriteText "sb_url=mainUrl" & vbcrlf
        objStream.WriteText "if Request.ServerVariables(""SERVER_PORT"") = 443 then" & vbcrlf
        objStream.WriteText "	sb_mainUrlOnEk = ""https://""" & vbcrlf
        objStream.WriteText "	sb_ssl=1" & vbcrlf
        objStream.WriteText "else" & vbcrlf
        objStream.WriteText "	sb_mainUrlOnEk = ""http://""" & vbcrlf
        objStream.WriteText "	sb_ssl=0" & vbcrlf
        objStream.WriteText "end if" & vbcrlf
    '##### OTOMATİK SSL



    sorgu = "Select * from portal.firma where silindi = 0 order by anaFirmaID ASC"
    rs.open sorgu, sbsv5, 1, 3
    for di = 1 to rs.recordcount
        objStream.WriteText "if firmaID = " & rs("id") & " then" & vbcrlf

        objStream.WriteText "sb_firmaAd =	""" & rs("Ad") & """"
        objStream.WriteText "sb_url =	mainUrl"
        objStream.WriteText "sb_logo =	sb_mainUrlOnEk & mainUrl & ""/template/images/tio.jpg"""
        objStream.WriteText "sb_logoMini =	sb_mainUrlOnEk & mainUrl & """ & rs("logo") & """"
        objStream.WriteText "sb_logo128 =	sb_mainUrlOnEk & mainUrl & """ & rs("logo") & """"
        objStream.WriteText "sb_cdnUrl =	sb_mainUrlOnEk & mainUrl & """ & rs("cdnUrl") & """"
        objStream.WriteText "sb_konum =	""" & rs("konum") & """"
        ' objStream.WriteText "sb_yetkiliPersonel						=	""Başar Sönmez|+905053376198"""
        objStream.WriteText "sb_ssl = " & rs("ssl")
	    ' ## SERVİSLER
        objStream.WriteText "sb_activeuserUrl =	""" & rs("activeuserUrl") & """"
        objStream.WriteText "sb_activeuserTime = " & rs("activeuserUrlTimeout")'otomatik veri kontrolü için saniye
	    ' ## SERVİSLER
        objStream.WriteText ""
        objStream.WriteText ""
        objStream.WriteText ""
        objStream.WriteText ""
        objStream.WriteText ""


	' ## YEDEKLEME
	' ## YEDEKLEME
		sb_fizikselPath						=	""C:\web\erp.sbstasarim.com\backup\""
		sb_sqlYedekCompress					=	true
		sb_sqlYedekCloudMail				=	""raptiye210@yahoo.com""
		sb_sqlYedekAlGun					=	7		'dashboard üzerinden otomatik yedek alma. yazılacak
		sb_sqlYedekSilGun					=	30		'yetki sorunu veriyor. onar
	' ## YEDEKLEME
	' ## YEDEKLEME

	'## EMAIL
	'## EMAIL
		sb_mailserver		=	""212.68.61.84:587""
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

	'#### STOK bilgieri dış db den çekilecekse
	'#### STOK bilgieri dış db den çekilecekse
		firmaStokDBvar		=	1
		firmaStokSunucu		=	"."
		firmaStokDB			=	"TIO2022"
		firmaStokdbUSR		=	"sbs_bulutihale"
		firmaStokdbPass		=	"FVDFG@@!!wer3232"
	'#### STOK bilgieri dış db den çekilecekse
	'#### STOK bilgieri dış db den çekilecekse

	'#### CARİ bilgieri dış db den çekilecekse
	'#### CARİ bilgieri dış db den çekilecekse
		firmaCariDBvar		=	1
		firmaCariSunucu		=	"."
		firmaCariDB			=	"TIO2022"
		firmaCaridbUSR		=	"sbs_bulutihale"
		firmaCaridbPass		=	"FVDFG@@!!wer3232"
	'#### CARİ bilgieri dış db den çekilecekse
	'#### CARİ bilgieri dış db den çekilecekse

	
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





















        objStream.WriteText "end if" & vbcrlf
    rs.movenext
    next
    rs.close









    objStream.WriteText "%"
    objStream.WriteText ">"
'dosya içeriği


	
'#### olayı kapat ve dosyaya kaydet
	objStream.SaveToFile Server.Mappath("/temp/sabitler_test.asp"),2
	objStream.Close
	set objStream = Nothing
'#### olayı kapat ve dosyaya kaydet


Response.Write now()
%>