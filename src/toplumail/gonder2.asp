<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    Response.Flush()
'###### ANA TANIMLAMALAR

'###### verileri çek
    sablonID        =   Request.Form("sablonID")
    adresGrupID     =   Request.Form("adresGrupID")
    mailAccountID   =   Request.Form("mailAccountID")
'###### verileri çek

'###### VERİ KONTROLÜ
    if sablonID = "" then
        hatamesaj = "Lütfen şablon seçin"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if adresGrupID = "" then
        hatamesaj = "Lütfen hedef kitleyi seçin"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if mailAccountID = "" then
        hatamesaj = "Lütfen maili gönderecek hesabı seçin"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
'###### VERİ KONTROLÜ

call logla("Gönderim yapılacak mailler hazırlanıyor")

'###### İŞLEM
    sorgu = "INSERT into toplumail.gonderim" & vbcrlf
    sorgu = sorgu & "select getdate() as tarih," & kid & " as kid," & firmaID & " as firmaID,'Beklemede' as durum," & sablonID & " as sablonID,adresID," & mailAccountID & " as mailAccountID from toplumail.adres" & vbcrlf
    sorgu = sorgu & "where adresGrupID = " & adresGrupID & vbcrlf
    sorgu = sorgu & "and adresID not in (select adresID from toplumail.gonderim where durum in ('Beklemede','Gönderildi','Blacklist') and sablonID = " & sablonID & ")" & vbcrlf
    ' buraya blacklist gelicek
    ' Response.Write sorgu
    ' Response.End()
    rs.open sorgu,sbsv5,3,3
'###### İŞLEM

        hatamesaj = "Gönderim listesi oluşturuldu. Gönderim başlıyor"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-success","","","","","")


%><!--#include virtual="/reg/rs.asp" -->