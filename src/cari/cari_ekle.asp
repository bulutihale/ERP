<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    cariKodu 		=   Request.Form("cariKodu")
    cariAd	 		=   Request.Form("cariAd")
    gorevID			=   Request.Form("gorevID")
	silindi			=   Request.Form("silindi")
	modulAd 		=   "cari"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Cari Güncelleme: " & depoAd & "")

yetkiKontrol = yetkibul(modulAd)




if cariKodu = "" then
	hatamesaj = "Cari Adını Yazın"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


if yetkiKontrol > 2 then

if gorevID = "" then
    gorevID = 0
end if

            sorgu = "Select top 1 * from cari.cari where cariKodu = '" & cariKodu & "'"
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
				call logla("Yeni cari Ekleniyor: " & cariKodu & "")
			else
				call logla("cari Güncelleniyor: " & cariKodu & "")
            end if
				rs("firmaID")			=	firmaID
                rs("cariKodu")			=	cariKodu
                rs("cariAd")			=	cariAd
                rs("silindi")			=	silindi
            rs.update
            rs.close

end if

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

call jsac("/cari/cari_liste.asp")
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->