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

call logla("Stok Güncelleme: " & stokKodu & "")

yetkiKontrol = yetkibul(modulAd)



	call rqKontrol(stokKodu,"Lütfen Stok Seçin","")
	call rqKontrol(anaBirimID,"Lütfen ürüne ait ana birimi seçin","")

if yetkiKontrol > 2 then

if gorevID = "" then
    gorevID = 0
end if

            sorgu = "Select top 1 * from stok.stok where stokKodu = '" & stokKodu & "'"
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
				call logla("Yeni Stok Ekleniyor: " & stokKodu & "")
			else
				call logla("Stok Güncelleniyor: " & stokKodu & "")
            end if
				rs("firmaID")			=	firmaID
                rs("stokKodu")			=	stokKodu
                rs("stokAd")			=	stokAd
                rs("stokTuru")			=	stokTuru
                rs("silindi")			=	silindi
				rs("kkDepoGiris")		=	kkDepoGiris
                rs("minStok")           =   minStok
                rs("anaBirimID")        =   anaBirimID
                rs("rafOmru")           =   rafOmru
                rs("manuelKayit")       =   1
            rs.update
            rs.close

end if

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")
if a = "hareketKontrol" then
else
    call jsac("/stok/stok_liste.asp")
end if
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->