<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    stokID	 		=   Request.Form("stokSec")
    cariID	 		=   Request.Form("cariSec")
	cariUrunRef		=   Request.Form("cariUrunRef")
    cariUrunAd		=   Request.Form("cariUrunAd")
	modulAd 		=   "Stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Stok Ref Kayıt")

yetkiKontrol = yetkibul(modulAd)




if stokID = "" OR cariID = "" then 
	hatamesaj = "Stok ve Cari seçimi yapılmalı."
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if cariUrunRef = "" then 
	hatamesaj = "Ürünümüze verilen stok kodu bilgisi girilmeli."
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


if yetkiKontrol > 2 then

if gorevID = "" then
    gorevID = 0
end if

            sorgu = "SELECT top 1 * FROM stok.stokRef WHERE firmaID = " & firmaID & " AND stokID= " & stokID & " AND cariID = " & cariID
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
				rs("firmaID")			=	firmaID
				rs("kid")				=	kid
                rs("stokID")			=	stokID
                rs("cariID")			=	cariID
                rs("cariUrunRef")		=	cariUrunRef
                rs("cariUrunAd")		=	cariUrunAd
				call logla("Yeni Ref Ekleniyor: " & cariUrunRef & "")
				tMesaj	=	"Kayıt Tamamlandı"
			else
				tMesaj	=	"Ref kaydı zaten var."
				call logla(tMesaj & ": " & cariUrunRef & "")
            end if
            rs.update
            rs.close

end if

call toastrCagir(tMesaj, "OK", "right", "success", "otomatik", "")

call jsac("/stok/stok_ref.asp")
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->