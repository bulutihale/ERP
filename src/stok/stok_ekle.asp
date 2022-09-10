<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    stokKodu 		=   Request.Form("stokKodu")
    stokAd	 		=   Request.Form("stokAd")
	stokTuru		=   Request.Form("stokTuru")
    gorevID			=   Request.Form("gorevID")
	silindi			=   Request.Form("silindi")
	kkDepoGiris		=	Request.Form("kkDepoGiris")
	modulAd 		=   "Stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Stok Güncelleme: " & stokKodu & "")

yetkiKontrol = yetkibul(modulAd)




if stokKodu = "" then
	hatamesaj = "Stok Kodu Yazın"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


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
            rs.update
            rs.close

end if

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

call jsac("/stok/stok_liste.asp")
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->