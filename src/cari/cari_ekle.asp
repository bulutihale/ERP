<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    cariKodu 		=   Request.Form("cariKodu")
    cariAd	 		=   Request.Form("cariAd")
    unvan	 		=   Request.Form("unvan")
    vergiDairesi	=   Request.Form("vergiDairesi")
    vergiNo	 		=   Request.Form("vergiNo")
    sehir	 		=   Request.Form("sehir")
    sehir2	 		=   Request.Form("sehir2")
    telefon	 		=   Request.Form("telefon")
    postakodu	 	=   Request.Form("postakodu")
    email	 		=   Request.Form("email")
    adres	 		=   Request.Form("adres")
    gorevID			=   Request.Form("gorevID")
    cariTur         =   Request.Form("cariTur")
	modulAd 		=   "cari"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


yetkiTeklif	    = yetkibul("Teklif")
yetkiSatis  	= yetkibul("Satış")


if yetkiTeklif >= 3 or yetkiSatis > 1 then
    if gorevID = "" then
        call logla("Cari Ekleme : " & cariAd)
    else
        call logla("Cari Güncelleme : " & cariAd)
    end if
else
    call yetkisizGiris("Bu Alanı Görme Yetkiniz Yok","","")
end if


if cariAd = "" then
	hatamesaj = "Cari Adını Yazın"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


if vergiDairesi = "" then
	hatamesaj = "Vergi Dairesini Yazın"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


if vergiNo = "" then
	hatamesaj = "Vergi Numarasını Yazın"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


if gorevID <> "" then
    if isnumeric(gorevID) = False then
        hatamesaj = "Hatalı Kayıt. Lütfen yeniden deneyin."
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
end if


if gorevID <> "" then
    hatamesaj = "Kayıt Güncellendi : " & cariAd
    sorgu = "Select top 1 * from cari.cari where cariID = " & gorevID
    rs.open sorgu, sbsv5, 1, 3
elseif cariKodu <> "" then
    hatamesaj = "Kayıt Güncellendi : " & cariAd
    sorgu = "Select top 1 * from cari.cari where cariKodu = '" & cariKodu & "' and firmaID = " & firmaID
    rs.open sorgu, sbsv5, 1, 3
else
    hatamesaj = "Kayıt Yapıldı : " & cariAd
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
    if sehir <> "" then
	    rs("sehir")         =   sehir
    end if
	rs("cariTur")           =   cariTur
	rs("manuelKayit")       =   manuelKayit
	rs("telefon")           =   telefon
	rs("fax")               =   fax
    rs("iskonto")           =   iskonto
	rs("adres")             =   adres
	rs("postakodu")         =   postakodu
	rs("email")             =   email
	rs("ilce")              =   ilce

rs.update
rs.close



    call logla(hatamesaj)
    call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")






' call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

' call jsac("/cari/cari_liste.asp")
' modalkapat()





%><!--#include virtual="/reg/rs.asp" -->