<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.Form("gorevID")
    hastaID =   Request.Form("hastaID")
    hata    =   ""
    modulAd =   "YHAmeliyat"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Ameliyat Bilgileri Güncelleniyor")

yetkiYabanciHasta = yetkibul("yabancihasta")

'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL
    ameliyatID      =   Request.Form("ameliyatID")
    ameliyatlarID   =   Request.Form("ameliyatlarID")
    ameliyatlarAd   =   Request.Form("ameliyatlarAd")
    doktorID        =   Request.Form("doktorID")
    doktorAd        =   Request.Form("doktorAd")
    hastaneID       =   Request.Form("hastaneID")
    tarih           =   Request.Form("tarih")
    ameliyatNot     =   Request.Form("ameliyatNot")
'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL


'#### VERİ KONTROL
'#### VERİ KONTROL
if hastaneID = "" then
	hatamesaj = translate("Lütfen ameliyatın yapılacağı hastaneyi seçin","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

' if tarih = "" then
' 	hatamesaj = translate("Lütfen ameliyatın yapılacağı tarihi seçin","","")
' 	call logla(hatamesaj)
' 	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
' 	Response.End()
' end if
'#### VERİ KONTROL
'#### VERİ KONTROL

'####### INSERT - UPDATE
'####### INSERT - UPDATE
    sorgu = "Select top 1 * from yabancihasta.ameliyat"
    if ameliyatID <> "" then
	    sorgu = sorgu & " where yabancihasta.ameliyat.ameliyatID = " & ameliyatID
    end if
	rs.Open sorgu, sbsv5, 1, 3
		if ameliyatID = "" then
            rs.addnew
        end if
        rs("ameliyatlarID")     =   ameliyatlarID
        rs("ameliyatlarAd")     =   ameliyatlarAd
        rs("doktorID")          =   doktorID
        rs("doktorAd")          =   doktorAd
        rs("hastaneID")         =   hastaneID
        if tarih = "" then
        rs("tarih")             =   null
        else
        rs("tarih")             =   tarih
        end if
        rs("hastaID")           =   hastaID
        rs("ameliyatNot")       =   ameliyatNot
    rs.update
    gorevID = rs("hastaID")
    rs.close
'####### INSERT - UPDATE
'####### INSERT - UPDATE

call jsacmodal("/yabancihasta/ameliyat_yeni.asp?gorevID=" & hastaID)

call logla("Ameliyat Bilgileri Güncellendi")

call jsac("/yabancihasta/hasta_liste.asp")

%><!--#include virtual="/reg/rs.asp" -->