﻿<!--#include virtual="/temp/sabitler.asp" --><%

'#########
' temp/sabitler_ek.asp dosyasını oluşturur
'#########

'######### sabitleri bozacağımız için db ye manuel bağlanacağız
	set sbsv5=Server.CreateObject("ADODB.Connection")
	baglantibilgileri = "Provider=SQLOLEDB;Data Source=" & sb_dbsunucu & ";Initial Catalog=" & sb_dbad & ";User Id=" & sb_dbuser & ";Password=" & sb_dbpass & ";"
	sbsv5.Open baglantibilgileri
	Set rs = Server.CreateObject("ADODB.Recordset")
	Set rs1 = Server.CreateObject("ADODB.Recordset")
'######### sabitleri bozacağımız için db ye manuel bağlanacağız




'#### ön hazırlık
	Set objStream = server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.CharSet = "UTF-8"
'#### ön hazırlık



'dosya içeriği
    objStream.WriteText "<"
    objStream.WriteText "%" & vbcrlf

        '########## SSL
            objStream.WriteText vbcrlf & vbcrlf
            objStream.WriteText vbtab & "'## SSL" & vbcrlf
            objStream.WriteText vbtab & vbtab & "mainUrl = Request.ServerVariables(""HTTP_HOST"")" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_url=mainUrl" & vbcrlf
            objStream.WriteText vbtab & vbtab & "if Request.ServerVariables(""SERVER_PORT"") = 443 then" & vbcrlf
            objStream.WriteText vbtab & vbtab & vbtab & "sb_mainUrlOnEk = ""https://""" & vbcrlf
            objStream.WriteText vbtab & vbtab & vbtab & "sb_ssl=1" & vbcrlf
            objStream.WriteText vbtab & vbtab & "else" & vbcrlf
            objStream.WriteText vbtab & vbtab & vbtab & "sb_mainUrlOnEk = ""http://""" & vbcrlf
            objStream.WriteText vbtab & vbtab & vbtab & "sb_ssl=0" & vbcrlf
            objStream.WriteText vbtab & vbtab & "end if" & vbcrlf
            objStream.WriteText vbtab & "'## SSL" & vbcrlf
            objStream.WriteText vbcrlf & vbcrlf
        '########## SSL


    sorgu = "Select * from portal.firma where silindi = 0 order by anaFirmaID ASC"
    rs.open sorgu, sbsv5, 1, 3
    for di = 1 to rs.recordcount
        objStream.WriteText "if firmaID = " & rs("id") & " then" & vbcrlf

        '########## TEMEL BİLGİLER
            objStream.WriteText vbtab & "'## TEMEL TANIMLAR" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_firmaAd =	""" & rs("Ad") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_url =	mainUrl" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_logo = sb_mainUrlOnEk & mainUrl & """ & rs("logo") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_logoMini = sb_mainUrlOnEk & mainUrl & """ & rs("logo") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_logo128 = sb_mainUrlOnEk & mainUrl & """ & rs("logo") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_cdnUrl = sb_mainUrlOnEk & mainUrl & """ & rs("cdnUrl") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_konum =	""" & rs("konum") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_yetkiliPersonel = """ & rs("yetkiliPersonel") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_ssl = " & rs("ssl") & vbcrlf
            objStream.WriteText vbtab & vbtab & "'## SERVİSLER" & vbcrlf
            objStream.WriteText vbtab & vbtab & vbtab & "sb_activeuserUrl =	""" & rs("activeuserUrl") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & vbtab & "sb_activeuserTime = " & rs("activeuserUrlTimeout")		 & vbcrlf			'otomatik veri kontrolü için saniye
            objStream.WriteText vbtab & vbtab & "'## SERVİSLER" & vbcrlf
            objStream.WriteText vbtab & "'## TEMEL TANIMLAR" & vbcrlf
            objStream.WriteText vbcrlf & vbcrlf
        '########## TEMEL BİLGİLER


        '########## YEDEKLEME
            objStream.WriteText vbtab & "'## YEDEKLEME" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_fizikselPath = """ & rs("fizikselPath") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_sqlYedekCompress = " & rs("sqlYedekCompress") & "" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_sqlYedekCloudMail = """ & rs("sqlYedekCloudMail") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_sqlYedekAlGun = " & rs("sqlYedekAlGun") & "" & vbcrlf										'dashboard üzerinden otomatik yedek alma. yazılacak
            objStream.WriteText vbtab & vbtab & "sb_sqlYedekSilGun = " & rs("sqlYedekSilGun") & "" & vbcrlf											'yetki sorunu veriyor. onar
            objStream.WriteText vbtab & "'## YEDEKLEME" & vbcrlf
            objStream.WriteText vbcrlf & vbcrlf
        '########## YEDEKLEME


        '########## EMAİL GÖNDERİM
            objStream.WriteText vbtab & "'## EMAIL" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_mailserver = """ & rs("mailserver") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_mailsender = """ & rs("mailsender") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_mailsenderPass = """ & rs("mailsenderPass") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "sb_mailsenderAd = """ & rs("mailsenderAd") & """" & vbcrlf
            objStream.WriteText vbtab & "'## EMAIL" & vbcrlf
            objStream.WriteText vbcrlf & vbcrlf
        '########## EMAİL GÖNDERİM

        '########## SSO
            objStream.WriteText vbtab & "'## SSO" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaSSO = """ & rs("SSO") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaSSOAdres = """ & rs("SSOAdres") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaSSODomain = """ & rs("SSODomain") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaSSOLdap = """ & rs("SSOLdap") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaSSOdb = """ & rs("SSOdb") & """" & vbcrlf
            objStream.WriteText vbtab & "'## SSO" & vbcrlf
            objStream.WriteText vbcrlf & vbcrlf
        '########## SSO


        '########## STOK
            objStream.WriteText vbtab & "'#### STOK bilgieri dış db den çekilecekse" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaStokDBvar = " & rs("StokDBvar") & "" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaStokSunucu = """ & rs("StokSunucu") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaStokDB = """ & rs("StokDB") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaStokdbUSR = """ & rs("StokdbUSR") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaStokdbPass = """ & rs("StokdbPass") & """" & vbcrlf
            objStream.WriteText vbtab & "'#### STOK bilgieri dış db den çekilecekse" & vbcrlf
            objStream.WriteText vbcrlf & vbcrlf

            sorgu = "Select * from stok.stokAyar where silindi = 0 and firmaID = " & rs("Id")
            rs1.open sorgu, sbsv5, 1, 3
            if rs1.recordcount > 0 then
            for dii = 1 to rs1.recordcount
                objStream.WriteText vbtab & "'#### STOK" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_stokKoduZorunlu = " & rs1("stokKoduZorunlu") & "" & vbcrlf
                objStream.WriteText vbtab & "'#### STOK" & vbcrlf
                objStream.WriteText vbcrlf & vbcrlf
            rs1.movenext
            next
            end if
            rs1.close
        '########## STOK


        '########## CARİ
            objStream.WriteText vbtab & "'#### CARİ bilgieri dış db den çekilecekse" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaCariDBvar = " & rs("CariDBvar") & "" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaCariSunucu = """ & rs("CariSunucu") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaCariDB = """ & rs("CariDB") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaCaridbUSR = """ & rs("CaridbUSR") & """" & vbcrlf
            objStream.WriteText vbtab & vbtab & "firmaCaridbPass = """ & rs("CaridbPass") & """" & vbcrlf
            objStream.WriteText vbtab & "'#### CARİ bilgieri dış db den çekilecekse" & vbcrlf
            objStream.WriteText vbcrlf & vbcrlf
        '########## CARİ


        '########## TEKLİF
            sorgu = "Select * from teklif.teklifAyar where silindi = 0 and firmaID = " & rs("Id")
            rs1.open sorgu, sbsv5, 1, 3
            if rs1.recordcount > 0 then
            for dii = 1 to rs1.recordcount
                objStream.WriteText vbtab & "'#### TEKLİF" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_TeklifCariAramaLimit = " & rs1("TeklifCariAramaLimit") & "" & vbcrlf								'arama formundan kaç adet cari dönsün
                objStream.WriteText vbtab & vbtab & "sb_TeklifFiyatSayi = " & rs1("TeklifFiyatSayi") & "" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_TeklifFiyatAd0 = """ & rs1("TeklifFiyatAd0") & """" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_TeklifFiyatAd1 = """ & rs1("TeklifFiyatAd1") & """" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_TeklifFiyatAd2 = """ & rs1("TeklifFiyatAd2") & """" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_TeklifFiyatAd3 = """ & rs1("TeklifFiyatAd3") & """" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_TeklifFiyatAd4 = """ & rs1("TeklifFiyatAd4") & """" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_TeklifFiyatiSirifOlanStoklariGizle = " & rs1("TeklifFiyatiSirifOlanStoklariGizle") & "" & vbcrlf				'yazılacak
                objStream.WriteText vbtab & vbtab & "sb_TeklifIskontoSayisi = " & rs1("TeklifIskontoSayisi") & "" & vbcrlf								'teklif hazırlanırken kaç iskontoya izin verilsin
                objStream.WriteText vbtab & vbtab & "sb_TeklifOndalikSayi = " & rs1("TeklifOndalikSayi") & "" & vbcrlf									'teklif toplamlarında tamsayıdan sonra kaç ondalık karakter olsun
                objStream.WriteText vbtab & vbtab & "sb_TeklifSayiFormatOn = """ & rs1("TeklifSayiFormatOn") & """" & vbcrlf				'teklif sayısının önünde yer alır
                objStream.WriteText vbtab & vbtab & "sb_TeklifSayiFormatRakam = " & rs1("TeklifSayiFormatRakam") & "" & vbcrlf								'kaç hane olacak
                objStream.WriteText vbtab & vbtab & "sb_TeklifSayiFormat = """ & rs1("TeklifSayiFormat") & """" & vbcrlf	'bu kısmını yazmadım
                objStream.WriteText vbtab & vbtab & "sb_kosulFontSize = """ & rs1("kosulFontSize") & """" & vbcrlf	
                objStream.WriteText vbtab & "'#### TEKLİF" & vbcrlf
                objStream.WriteText vbcrlf & vbcrlf
            rs1.movenext
            next
            end if
            rs1.close
        '########## TEKLİF

        '########## GÖREV
            sorgu = "Select * from IT.gorevAyar where silindi = 0 and firmaID = " & rs("Id")
            rs1.open sorgu, sbsv5, 1, 3
            if rs1.recordcount > 0 then
            for dii = 1 to rs1.recordcount
                objStream.WriteText vbtab & "'#### GÖREV TAKİP" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_modulAdi = """ & rs1("modulAdi") & """" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_cariyeGorevVerilsin = " & rs1("cariyeGorevVerilsin") & "" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_etiketEklenebilsin = " & rs1("etiketEklenebilsin") & "" & vbcrlf
                objStream.WriteText vbtab & "'#### GÖREV TAKİP" & vbcrlf
                objStream.WriteText vbcrlf & vbcrlf
            rs1.movenext
            next
            end if
            rs1.close
        '########## GÖREV


        '########## GÖREV
            sorgu = "Select * from toplumail.topluMailAyar where silindi = 0 and firmaID = " & rs("Id")
            rs1.open sorgu, sbsv5, 1, 3
            if rs1.recordcount > 0 then
            for dii = 1 to rs1.recordcount
                objStream.WriteText vbtab & "'#### TOPLU MAİL" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_gonderimT1 = """ & rs1("gonderimT1") & """" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_gonderimT2 = """ & rs1("gonderimT2") & """" & vbcrlf
                objStream.WriteText vbtab & vbtab & "sb_gonderimMiktari = " & rs1("gonderimMiktari") & "" & vbcrlf
                objStream.WriteText vbtab & "'#### TOPLU MAİL" & vbcrlf
                objStream.WriteText vbcrlf & vbcrlf
            rs1.movenext
            next
            end if
            rs1.close
        '########## GÖREV


        ' objStream.WriteText vbtab & "'#### MODULLER" & vbcrlf
        ' objStream.WriteText vbtab & vbtab & "sb_modul_gorevTakip = true" & vbcrlf       'bu iptal olmuş olabilir. kontrol et
        ' objStream.WriteText vbtab & vbtab & "sb_modul_webmail = true" & vbcrlf          'bu iptal olmuş olabilir. kontrol et
        ' objStream.WriteText vbtab & vbtab & "sb_modul_teklif = true" & vbcrlf           'bu iptal olmuş olabilir. kontrol et
        ' objStream.WriteText vbtab & "'#### MODULLER" & vbcrlf
        ' objStream.WriteText vbcrlf & vbcrlf


        '########## PERSONEL YETKİLER
            objStream.WriteText vbtab & "'#### PERSONEL YETKİLER" & vbcrlf
                ' sorgu = "SELECT distinct modulAd + ',' FROM portal.moduller FOR XML PATH('')"
                sorgu = "select replace(replace( STUFF((SELECT distinct modulAd + ',' FROM portal.moduller FOR XML PATH('')), 1, 0, '') ,'<yetkiParametre>',''),'</yetkiParametre>','') [yetkiler]"
                rs1.open sorgu, sbsv5, 1, 3
                    moduladlari = rs1(0)
                    moduladlari2 = len(moduladlari)
                    moduladlari3 = left(moduladlari,moduladlari2-1)
                    objStream.WriteText vbtab & vbtab & "sb_modul=""" & moduladlari3 & """" & vbcrlf
                rs1.close
                sorgu = "Select * from portal.moduller order by modulAd ASC,yetki ASC"
                rs1.open sorgu, sbsv5, 1, 3
                if rs1.recordcount > 0 then
                    sonmodulad = ""
                    modulSatir = ""
                        for dii = 1 to rs1.recordcount
                            if sonmodulad <> rs1("modulAd") then
                                if sonmodulad = "" then
                                    modulSatir = modulSatir & rs1("modulAd") & "##"
                                else
                                    modulSatir = modulSatir & "|" & rs1("modulAd") & "##"
                                end if
                            else
                                modulSatir = modulSatir & ","
                            end if
                            modulSatir = modulSatir & rs1("yetkiAd") & "=" & rs1("yetki")
                            sonmodulad = rs1("modulAd")
                        rs1.movenext
                        next
                        objStream.WriteText vbtab & vbtab & "sb_moduller=""" & modulSatir & """" & vbcrlf
                end if
                rs1.close
            objStream.WriteText vbtab & "'#### PERSONEL YETKİLER" & vbcrlf
            objStream.WriteText vbcrlf & vbcrlf
        '########## PERSONEL YETKİLER




        '########## PORTAL AYARLARI - EN ALTA KOYDUK Kİ YUKARIDAKİ AYARLARI BASTIRSIN
            sorgu = "Select * from portal.portalAyar where firmaID = " & rs("Id")
            rs1.open sorgu, sbsv5, 1, 3
            if rs1.recordcount > 0 then
            objStream.WriteText vbtab & "'#### PORTAL AYARLARI" & vbcrlf
            for dii = 1 to rs1.recordcount
                objStream.WriteText vbtab & vbtab & rs1("ayarAd") & "=" & """" & rs1("ayarDeger") & """" & vbcrlf
            rs1.movenext
            next
            objStream.WriteText vbtab & "'#### PORTAL AYARLARI" & vbcrlf
            objStream.WriteText vbcrlf & vbcrlf
            end if
            rs1.close
        '########## PORTAL AYARLARI



        objStream.WriteText "end if" & vbcrlf
        objStream.WriteText vbcrlf & vbcrlf
    rs.movenext
    next
    rs.close

    objStream.WriteText "%"
    objStream.WriteText ">"
'dosya içeriği


	
'#### olayı kapat ve dosyaya kaydet
	objStream.SaveToFile Server.Mappath("/temp/sabitler_ek.asp"),2
	objStream.Close
	set objStream = Nothing
'#### olayı kapat ve dosyaya kaydet



Response.Write now()


Response.Redirect "/"
%>