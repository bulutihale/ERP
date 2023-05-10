<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    modul   =   Request.QueryString("modul")
    hata    =   ""
    modulAd =   "Etiket"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


modul = base64_decode_tr(modul)


    sorgu = "Select * from portal.dosya where modulID = " & gorevID & " and modul = '" & modul & "' order by dosyaID desc"
	rs.Open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
            dosyaID = rs("dosyaID")
            dosyaUzanti = rs("dosyaUzanti")
            dosyaAciklama = rs("dosyaAciklama")
            dosyaAdi = rs("dosyaID") & "." & rs("dosyaUzanti")
        end if
    rs.close



Response.Write "<div class=""text-center h3 text-info"">" & dosyaAciklama & "</div>"
if dosyaUzanti = "jpg" or dosyaUzanti = "png" then
    Response.Write "<div class=""center""><img src=""/temp/dosya/" & dosyaAdi & """ class=""img-fluid mx-auto d-block"" /></div>"
end if
if dosyaUzanti = "pdf" then
    Response.Write "<div class=""text-center""><a href=""/temp/dosya/" & dosyaAdi & """ target=""_blank"">" & translate("Dosyayı İndir","","") & "</a>"
end if


%><!--#include virtual="/reg/rs.asp" -->