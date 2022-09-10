<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    gorevID =   Request.Form("gorevID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    hata    =   ""
    modulAd =   "YHÖdeme"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'###### FORM BİLGİLERİ
'###### FORM BİLGİLERİ
    paketFiyat          =   Request.Form("paketFiyat")
    kaparoFiyat         =   Request.Form("kaparoFiyat")
    dekontNo1           =   Request.Form("dekontNo1")
    dekontNo2           =   Request.Form("dekontNo2")
    banka1              =   Request.Form("banka1")
    banka2              =   Request.Form("banka2")
'###### FORM BİLGİLERİ
'###### FORM BİLGİLERİ

call logla("Ödeme Bilgileri Güncelleniyor")

yetkiYabanciHasta = yetkibul("yabancihasta")

if paketFiyat = "" or kaparoFiyat = "" then
	hatamesaj = translate("Please type surgery price informations","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if
if dekontNo1 = "" then
	hatamesaj = translate("Please type GG number","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if isnumeric(paketFiyat) = False or isnumeric(kaparoFiyat) = False then
	hatamesaj = translate("Please type price","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

'####### INSERT - UPDATE
'####### INSERT - UPDATE
    sorgu = "Select top 1 * from yabancihasta.odeme"
    if gorevID <> "" then
	    sorgu = sorgu & " where yabancihasta.odeme.hastaID = " & gorevID
    end if
	rs.Open sorgu, sbsv5, 1, 3
		if rs.recordcount = 0 then
            rs.addnew
        end if
        rs("paketFiyat")    =   paketFiyat
        rs("kaparoFiyat")   =   kaparoFiyat
        rs("hastaID")       =   gorevID
        rs("personelID")    =   kid
        rs("dekontNo1")    =   dekontNo1
        rs("dekontNo2")    =   dekontNo2
        rs("banka1")        =   banka1
        rs("banka2")        =   banka2
        rs.update
    rs.close
'####### INSERT - UPDATE
'####### INSERT - UPDATE

	hatamesaj = translate("Ödeme Bilgileri Güncellendi","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")

%><!--#include virtual="/reg/rs.asp" -->