<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    modulID =   "137"
    Response.Flush()
    gorevID = Request.QueryString("sablonID")
    islem = Request.QueryString("islem")
'###### ANA TANIMLAMALAR

'### ŞABLON VERİSİNİ AL
    if gorevID <> "" then
        sorgu = "Select top 1 * from toplumail.sablon where firmaID = " & firmaID & " and sablonID = " & gorevID
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            sablonBaslik    =   rs("sablonBaslik")
            sablonIcerik    =  rs("sablonIcerik")
        else
            hata = 1
        end if
        rs.close
    end if
'### ŞABLON VERİSİNİ AL


'### PERSONEL MAİL BİLGİSİNİ AL
    if gorevID <> "" then
        sorgu = "Select top 1 * from personel.personel where id = " & kid
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            personelAd      =   rs("ad")
            personelMail    =  rs("email")
        else
            hata = 1
        end if
        rs.close
    end if
'### PERSONEL MAİL BİLGİSİNİ AL





if sablonIcerik <> "" then

    if mailadresi = "" then
        mailadresi = personelMail
    end if
    mailadresi64 = mailadresi
    mailadresi64 = base64_encode_tr(mailadresi64)
    sablonIcerik    =   Replace(sablonIcerik,"[mailAdresi]",mailadresi)
    sablonIcerik    =   Replace(sablonIcerik,"[buraya]","<a href=""" & sb_mainUrlOnEk & mainUrl & "/unsubscribe.asp?a=" & mailadresi64 & """>buraya</a>")



    Response.Write "<!doctype html>"
    Response.Write "<html xmlns=""http://www.w3.org/1999/xhtml"" xmlns:v=""urn:schemas-microsoft-com:vml"" xmlns:o=""urn:schemas-microsoft-com:office:office"">"
        Response.Write "<head>"
            Response.Write "<meta charset=""UTF-8"">"
            Response.Write "<meta http-equiv=""X-UA-Compatible"" content=""IE=edge"">"
            Response.Write "<meta name=""viewport"" content=""width=device-width, initial-scale=1"">"
            Response.Write "<title>" & sablonBaslik & "</title>"
        Response.Write "</head>"
        Response.Write "<body style=""height: 100%;margin: 0;padding: 0;width: 100%;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FAFAFA;"">"
            Response.Write sablonIcerik
        Response.Write "</body>"
    Response.Write "</html>"
end if



%><!--#include virtual="/reg/rs.asp" -->