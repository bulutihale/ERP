<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    a		=   Request.QueryString("a")
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    stokID			=   Request.Form("stokID")
    islem           =   Request.Form("islem")
    hareketmiktar   =   Request.Form("hareketmiktar")
    lot             =   Request.Form("lot")
    lotSKT          =   Request.Form("lotSKT")
    girisDepoSec    =   Request.Form("girisDepoSec")

    if islem = "miktarGir" then
        stokHareketTuru = "G"
    elseif islem = "miktarCik" then
        stokHareketTuru = "C"
    end if
    
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Stok Miktarı Güncelleme. İŞLEM: " & islem & " MİKTAR: " & hareketmiktar & "")

yetkiKontrol = yetkibul("Admin")



	call rqKontrol(lotSKT,"Lütfen LOT içim Son Kullanma Tarihi bilgisini yazınız.","")
	call rqKontrol(lot,"Lütfen kayıt yapılacak olan ürüne ait LOT bilgisini yazınız.","")
	call rqKontrol(girisDepoSec,"Lütfen depo seçiniz","")
	call rqKontrol(hareketmiktar,"Lütfen miktar yazınız","")
    


if yetkiKontrol = 9 then

if gorevID = "" then
    gorevID = 0
end if
        sorgu = "SELECT stokKodu, anaBirimID, stok.FN_anaBirimADBul(anaBirimID, 'kad') as anaBirimAd  FROM stok.stok WHERE stokID = " & stokID
        rs.open sorgu, sbsv5, 1, 3
            stokKodu    =   rs("stokKodu")
            anaBirimID  =   rs("anaBirimID")
            anaBirimAd =   rs("anaBirimAd")
        rs.close

             sorgu = "Select * from stok.stokHareket"
			 rs.open sorgu, sbsv5, 1, 3
                 rs.addnew
			 
                rs("firmaID")			=	firmaID
                rs("kid")   			=	kid
                rs("stokKodu")          =   stokKodu
                rs("miktar")            =   hareketmiktar
                rs("miktarBirimID")     =   anaBirimID
                rs("miktarBirim")       =   anaBirimAd
                rs("stokHareketTuru")   =   stokHareketTuru
                rs("depoID")            =   girisDepoSec
                rs("aciklama")          =   "Manuel İşlem " & islem
                rs("belgeNo")           =   "Manuel İşlem " & islem
                rs("belgeTarih")        =   date()
                rs("stokID")            =   stokID
                rs("lot")               =   lot
                rs("lotSKT")            =   tarihsql(lotSKT)
                rs("stokhareketTipi")   =   "M"

            rs.update
               rs.close

end if

'call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")
Response.Write "Kayıt Tamamlandı."
    call jsac("/stok/stok_liste.asp")
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->


