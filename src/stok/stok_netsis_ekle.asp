<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    a		=   Request.QueryString("a")
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    stokKodu 		=   Request.Form("stokKodu")
    stokAd	 		=   Request.Form("stokAd")
	stokTuru		=   Request.Form("stokTuru")
    minStok         =   Request.Form("minStok")
    gorevID			=   Request.Form("gorevID")
	silindi			=   Request.Form("silindi")
	kkDepoGiris		=	Request.Form("kkDepoGiris")
    rafOmru         =	Request.Form("rafOmru")
    if rafOmru = "" then
        rafOmru = 0
    end if
    anaBirimID      =   Request.Form("anaBirimID")
	modulAd 		=   "Stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



Response.Flush()


yetkiKontrol = yetkibul(modulAd)



	'call rqKontrol(stokKodu,"Lütfen Stok Seçin","")
	'call rqKontrol(anaBirimID,"Lütfen ürüne ait ana birimi seçin","")

if yetkiKontrol > 2 then

if gorevID = "" then
    gorevID = 0
end if

            sorgu = "Select  * from TBLSTSABIT where STOK_KODU = '" & stokKodu & "'"
			rsS.open sorgu, rsStok, 1, 3
            if rsS.recordcount = 0 then
                rsS.addnew
				call logla("NETSİS veritabanına Yeni Stok Ekleniyor: " & stokKodu & "")
			else
				call logla("NETSİS veritabanında Stok Güncelleniyor: " & stokKodu & "")
            end if
                rsS("STOK_KODU")		=	stokKodu
                rsS("STOK_ADI")			=	stokAd
                rsS("SUBE_KODU")		=	-1
                rsS("ISLETME_KODU")     =   1
            rsS.update
            rsS.close

end if
Response.Write "OK"
'call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")
if a = "hareketKontrol" then
else
    call jsac("/stok/stok_liste.asp")
end if
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->