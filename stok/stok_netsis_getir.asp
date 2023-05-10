<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()

    netsisStdb 		=   Request.Form("netsisStdb")
	modulAd 		=   "Stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



Response.Flush()


yetkiKontrol = yetkibul(modulAd)



	'call rqKontrol(stokKodu,"Lütfen Stok Seçin","")
	'call rqKontrol(anaBirimID,"Lütfen ürüne ait ana birimi seçin","")

if yetkiKontrol > 2 then


            sorgu = "EXEC portal.SP_netsisStokSenk @DBNAME = '" & firmaStokDB & "' , @firmaID = "&firmaID&""
			rs.open sorgu, sbsv5, 1, 3
Response.Write "OK"
end if


'    call jsac("/stok/stok_liste.asp")







%><!--#include virtual="/reg/rs.asp" -->