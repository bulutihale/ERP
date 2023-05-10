<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
	
	
	stokHareketID	=	Request.Querystring("stokHareketID")
    modulAd =   "Mal Kabul"
    modulID =   "89"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


yetkiKontrol = yetkibul(modulAd)






'################### siparisKalem tablosuna kapanacak olan bakiye miktarı yaz
	
            sorgu = "SELECT t1.stokHareketID, t1.silindi, t1.cariID FROM stok.stokHareket t1 WHERE t1.firmaID = " & firmaID & " AND t1.stokHareketID = " & stokHareketID & ""
			rs.open sorgu, sbsv5, 1, 3
			
				cariID			=	rs("cariID")
				rs("silindi")	=	1
				call logla(stokHareketID & " ID stok hareketi silindi.")

			rs.update
			rs.close
'################### siparisKalem tablosuna kapanacak olan bakiye miktarı yaz


call toastrCagir("İşlem Yapıldı.", "OK", "right", "success", "otomatik", "")

call modalkapat()

call jsrun("$('#divsipListe').load('/malKabul/mal_kabul_siparis_liste.asp',{cariID:"&cariID&"})")






%><!--#include virtual="/reg/rs.asp" -->















