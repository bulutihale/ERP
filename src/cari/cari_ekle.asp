<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    kid64		=	ID
    hata    	=   ""
    modulAd 	=   "Cari"
    Response.Flush()
	yetkiKontrol = yetkibul("Cari")
'###### ANA TANIMLAMALAR



'###### ANA TANIMLAMALAR
    cariKodu 		=   Request.Form("cariKodu")
    cariAd	 		=   Request.Form("cariAd")
    unvan	 		=   Request.Form("unvan")
    vergiDairesi	=   Request.Form("vergiDairesi")
    vergiNo	 		=   Request.Form("vergiNo")
    il	 		    =   Request.Form("il")
    telefon	 		=   Request.Form("telefon")
    postakodu	 	=   Request.Form("postakodu")
    email	 		=   Request.Form("email")
    adres	 		=   Request.Form("adres")
    gorevID			=   Request.Form("gorevID")
    cariTur         =   Request.Form("cariTur")
    ulkeID          =   Request.Form("ulkeID")
'###### ANA TANIMLAMALAR



if yetkiKontrol > 5 then
    if gorevID = "" then
        call logla(translate("Cari Ekleme","","") & cariAd)
    else
        call logla(translate("Cari Güncelleme","","") & cariAd)
    end if
else
    hata = translate("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
    call yetkisizGiris(hata,"","")
end if



call rqKontrol(cariAd,translate("Lütfen cari adını yazın","",""),"")


if gorevID <> "" then
    if isnumeric(gorevID) = False then
        hatamesaj = translate("Hatalı Kayıt. Lütfen yeniden deneyin.","","")
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
end if



if gorevID <> "" then
    hatamesaj = translate("Kayıt Güncellendi","","") & " : " & cariAd
    sorgu = "Select top 1 * from cari.cari where cariID = " & gorevID
    rs.open sorgu, sbsv5, 1, 3
' elseif cariKodu <> "" then
'     hatamesaj = translate("Kayıt Güncellendi","","") & " : " & cariAd
'     sorgu = "Select top 1 * from cari.cari where cariKodu = '" & cariKodu & "' and firmaID = " & firmaID
'     rs.open sorgu, sbsv5, 1, 3
else
    hatamesaj = translate("Kayıt Yapıldı","","") & " : " & cariAd
    sorgu = "Select top 1 * from cari.cari"
    rs.open sorgu, sbsv5, 1, 3
    rs.addnew
    rs("manuelKayit")       =   True
end if
    rs("firmaID")           =   firmaID
	rs("cariKodu")          =   cariKodu
	rs("cariAd")            =   cariAd
	rs("unvan")             =   unvan
	rs("vergiDairesi")      =   vergiDairesi
	rs("vergiNo")           =   vergiNo
	rs("il")                =   il
	rs("cariTur")           =   cariTur
	rs("telefon")           =   telefon
	rs("fax")               =   fax
    rs("iskonto")           =   iskonto
	rs("adres")             =   adres
	rs("postakodu")         =   postakodu
	rs("email")             =   email
	rs("ilce")              =   ilce
    rs("ulkeID")            =   ulkeID
rs.update
rs.close



call logla(hatamesaj)

call toastrCagir(hatamesaj, "OK", "right", "success", "otomatik", "")

call jsac("/cari/cari_liste.asp")
modalkapat()

%><!--#include virtual="/reg/rs.asp" -->