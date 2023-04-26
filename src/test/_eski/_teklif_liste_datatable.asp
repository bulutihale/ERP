<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modulAd =   "Teklif"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Teklif Listesi Ekranı")

yetkiTeklif = yetkibul(modulAd)


if yetkiTeklif > 0 then
    call dataTableYap("deneme","Durum,Firma Adı,Teklif Sayı,Teklif Türü,Tarih,Personel,İşlemler","/teklif/json_teklif.asp","","","","","","","","","")
else
    call yetkisizGiris("","","")
end if





























%>