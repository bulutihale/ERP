<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Yedek"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Server.ScriptTimeout = 9000

if sb_sqlYedekCompress = "" then
    sb_sqlYedekCompress = true
end if


mesajicerik = "Yedek almaya başlanıyor"
call logla(mesajicerik)
Response.Write mesajicerik & " : " & now() & "<br />"
Response.Flush()


    dosyaAd = "yedek" & unique() & ".bak"
	' sorgu = "DBCC SHRINKFILE(sbs_tio_log)" & vbcrlf
	' sorgu = "dbcc shrinkdatabase ('" & sb_dbad & "')" & vbcrlf
	sorgu = "BACKUP DATABASE " & sb_dbad & " TO DISK = '" & sb_fizikselPath & dosyaAd & "'"
    if sb_sqlYedekCompress = true then
        sorgu = sorgu & " WITH COMPRESSION"
    end if
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sorgu, sbsv5, 1, 3


mesajicerik = "Yedek alındı"
call logla(mesajicerik)
Response.Write mesajicerik & " : " & now() & "<br />"
Response.Flush()


mesajicerik = "Yedek buluta gönderiliyor"
call logla(mesajicerik)
Response.Write mesajicerik & " : " & now() & "<br />"
Response.Flush()


baslik          =   "Yedek"
icerik          =   "Yedek Ektedir"
gonderen        =   sb_mailsender
gonderenAd      =   sb_mailsenderAd
hedef           =   sb_sqlYedekCloudMail
ekDosya         =   sb_fizikselPath & dosyaAd
basariliMesaj   =   "Yedek buluta gönderildi"
hataMesaj       =   "Yedek buluta <b>gönderilemedi</b>"
call mailgonder(baslik,icerik,gonderen,gonderenAd,hedef,ekDosya,basariliMesaj,hataMesaj,"","","","","")





'###### BURASI YETKİ HATASI VERİYOR. DÜZELTİLECEK
'###### BURASI YETKİ HATASI VERİYOR. DÜZELTİLECEK
	' Set fso = CreateObject("Scripting.FileSystemObject")
	' 	Set ana = fso.GetFolder(sb_fizikselPath)
	' 	Set dosyalar=ana.Files
	' 		for each dosyaa in dosyalar
    '             if cdate(dosyaa.DateLastModified) < date()-sb_sqlYedekSilGun then
    '                 mesajicerik = "Eski yedek dosyası silindi : " & dosyaa.name
    '                 dosyaa.Delete
    '                 call logla(mesajicerik)
    '                 Response.Write mesajicerik & " : " & now() & "<br />"
    '                 Response.Flush()
    '             end if
	' 		next
	' 	Set dosyaa = Nothing
	' 	Set dosyalar = Nothing
	' 	Set ana = Nothing
	' Set fso = Nothing







%><!--#include virtual="/reg/rs.asp" -->