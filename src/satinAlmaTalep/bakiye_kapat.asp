<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
	
	
	siparisKalemID	=	Request.Form("gitDeger")
	islem			=	Request.Form("islem")
<<<<<<< HEAD
    modulAd =   "Satın Alma"
    modulID =   "88"
=======
	modulAd 		=   "depo"
>>>>>>> 2ec0c88fad841fbe6ccde9e69af41c60651d566b
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


<<<<<<< HEAD
yetkiKontrol = yetkibul("depo")
=======
yetkiKontrol = yetkibul(modulAd)
>>>>>>> 2ec0c88fad841fbe6ccde9e69af41c60651d566b






'################### siparisKalem tablosuna kapanacak olan bakiye miktarı yaz
	
            sorgu = "SELECT t2.siparisNo, t2.cariID,"
			sorgu = sorgu & " (t1.miktar - ISNULL((SELECT SUM(t3.miktar) FROM stok.stokHareket t3 WHERE t3.siparisKalemID = t1.id AND t3.silindi = 0),0)) as eksikMiktar, t1.eksikMiktarKapat"
			sorgu = sorgu & " FROM teklif.siparisKalem t1"
			sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
			sorgu = sorgu & " WHERE t1.id= " & siparisKalemID & ""
			rs.open sorgu, sbsv5, 1, 3
			
				
				siparisNo				=	rs("siparisNo")
				cariID					=	rs("cariID")
			if islem = "kapama" then
				eksikMiktar				=	rs("eksikMiktar")
				rs("eksikMiktarKapat")	=	eksikMiktar	
				call logla(siparisNo & " numaralı siparişte "&siparisKalemID&" id kalem bakiye kapatıldı.")
			elseif islem = "kapamaiptal" then
				rs("eksikMiktarKapat")	=	0
				call logla(siparisNo & " numaralı siparişte "&siparisKalemID&" id kalem bakiye kapatma iptal edildi.")
			end if
			rs.update
			rs.close
'################### siparisKalem tablosuna kapanacak olan bakiye miktarı yaz


call toastrCagir("İşlem Yapıldı.", "OK", "right", "success", "otomatik", "")

call modalkapat()

call jsrun("$('#ortaalan').load('/satinAlma/siparis_liste.asp',{cariID:"&cariID&"})")






%><!--#include virtual="/reg/rs.asp" -->















