<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    modul = modulAd
    Response.Flush()
'###### ANA TANIMLAMALAR

    adresID         =   Request.QueryString("adresID")
    adresGrupID     =   Request.QueryString("adresGrupID")



        sorgu = "Select * from toplumail.adres where adresID = " & adresID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
            rs("silindi") = 1
            rs.update
            adres = rs("adres")
        end if
        rs.close

call logla("Email gönderim listesinden silindi :" & adres)




adresGrupID64   =   adresGrupID
adresGrupID64   =   base64_encode_tr(adresGrupID64)
call jsac("/toplumail/adres_liste.asp?adresGrupID64=" & adresGrupID64)

%><!--#include virtual="/reg/rs.asp" -->