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

call logla("Refakatci Bilgileri Güncelleniyor")

yetkiYabanciHasta = yetkibul("yabancihasta")

'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL
    refakatciAd         =   Request.Form("refakatciAd")
    refakatciPasaport   =   Request.Form("refakatciPasaport")
    refakatciID         =   Request.Form("refakatciID")
'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL


'#### VERİ KONTROL
'#### VERİ KONTROL
    if refakatciAd = "" then
        hatamesaj = "Refakatci adını yazın"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
'#### VERİ KONTROL
'#### VERİ KONTROL


'####### INSERT - UPDATE
'####### INSERT - UPDATE
    sorgu = "Select top 1 * from yabancihasta.refakatci"
    if refakatciID <> "" then
	    sorgu = sorgu & " where yabancihasta.refakatci.refakatciID = " & refakatciID
    end if
	rs.Open sorgu, sbsv5, 1, 3
		if refakatciID = "" then
            rs.addnew
        end if
        rs("refakatciAd")       =   refakatciAd
        rs("refakatciPasaport")    =   refakatciPasaport
        rs("tarih")            =   now()
        rs("firmaID")        =   firmaID
        rs("personelID")    =   kid
        rs("hastaID")       =   hastaID
    rs.update
    rs.close
'####### INSERT - UPDATE
'####### INSERT - UPDATE

call jsacmodal("/yabancihasta/refakatci_yeni.asp?gorevID=" & hastaID)

call logla("Refakatci Bilgileri Güncellendi")

%><!--#include virtual="/reg/rs.asp" -->