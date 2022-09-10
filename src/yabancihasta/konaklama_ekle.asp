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
    modulAd =   "YHKonaklama"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'###### FORM BİLGİLERİ
'###### FORM BİLGİLERİ
                konaklamaID          =   Request.Form("konaklamaID")
                otelID              =   Request.Form("otelID")
                otelAd              =   Request.Form("otelAd")
                otelCheckIn         =   Request.Form("otelCheckIn")
                otelCheckOut           =   Request.Form("otelCheckOut")
                otelKisiSayisi           =   Request.Form("otelKisiSayisi")
                otelOdaTipi              =   Request.Form("otelOdaTipi")
                otelYatakTipi              =   Request.Form("otelYatakTipi")
'###### FORM BİLGİLERİ
'###### FORM BİLGİLERİ

call logla("Konaklama Bilgileri Güncelleniyor")

yetkiYabanciHasta = yetkibul("yabancihasta")

if otelAd = "" then
	hatamesaj = translate("Lütfen konaklama yerini seçin","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


if otelCheckIn = "" or otelCheckOut = "" then
	hatamesaj = translate("Lütfen konaklama tarihini seçin","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if otelKisiSayisi = "" or otelOdaTipi = "" or otelYatakTipi = ""  then
	hatamesaj = translate("Lütfen konaklama ayrıntılarını seçin","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


otelCheckIn     =   cdate(otelCheckIn)
otelCheckOut    =   cdate(otelCheckOut)

if otelCheckIn > otelCheckOut then
	hatamesaj = translate("Hatalı konaklama tarihi seçtiniz. Giriş tarihi, çıkış tarihinden sonra olamaz","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if



'####### INSERT - UPDATE
'####### INSERT - UPDATE
    sorgu = "Select top 1 * from yabancihasta.konaklama"
    if konaklamaID <> "" then
	    sorgu = sorgu & " where yabancihasta.konaklama.konaklamaID = " & konaklamaID
    end if
	rs.Open sorgu, sbsv5, 1, 3
		if konaklamaID = "" then
            rs.addnew
        end if
        rs("hastaID")           =   gorevID
        rs("otelAd")        =   otelAd
        rs("otelCheckIn")         =   otelCheckIn
        rs("otelCheckOut")    =   otelCheckOut
        rs("otelKisiSayisi")      =   otelKisiSayisi
        rs("otelOdaTipi")       =   otelOdaTipi
        rs("otelYatakTipi")  =   otelYatakTipi
        rs.update
    rs.close
'####### INSERT - UPDATE
'####### INSERT - UPDATE

	hatamesaj = "Konaklama Bilgileri Güncellendi"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")

call jsacmodal("/yabancihasta/konaklama_yeni.asp?gorevID=" & gorevID)

call jsac("/yabancihasta/hasta_liste.asp")

%><!--#include virtual="/reg/rs.asp" -->