<!--#include virtual="/reg/rs.asp" --><%

Response.Flush()

id64 = Request.QueryString("id")

			kid						=	kidbul()
			id						=	id64
			id						=	base64_decode_tr(id)


'###### yetki bul
    modulAd		=   "Teklif"
	yetkiKontrol = 	yetkibul(modulAd)
'###### yetki bul

if yetkiKontrol  >= 3 then


Response.Write "<div class=""container-fluid"">"
Response.Write "<div class=""text-center col-lg-12 mb10"">"

Sorgu = "SELECT tl.tarih, tl.kid, tl.dosyaAd, tl.revNo, tl.cariMailKomut, k.ad FROM dosya.teklif_liste tl INNER JOIN personel.personel k ON tl.kid = k.id WHERE tl.firmaID = " & firmaID & " AND tl.ihaleID = " & id & " ORDER BY tl.id DESC"
rs.open sorgu,sbsv5,1,3

if rs.recordcount = 0 then
	Response.Write "Teklif Oluşturulmamış."
else
	
	Response.Write "<table class=""table table-border"">"
	Response.Write "<tr>"
	Response.Write "<th>Revizyon</th>"
	Response.Write "<th>Tarih</th>"
	Response.Write "<th>Kayıt Eden</th>"
	Response.Write "<th>Teklif Dosyası</th>"
	Response.Write "<th>e-posta</th>"
	Response.Write "</tr>"
	
for i = 1 to rs.recordcount
	Response.Write "<tr>"
	Response.Write "<td>" & rs("revNo") & "</td>"
	Response.Write "<td>" & rs("tarih") & "</td>"
	Response.Write "<td>" & rs("ad") & "</td>"
	Response.Write "<td><a class=""btn"" target=""_blank"" href=""/temp/dosya/" & firmaID  & "/teklifler/" & id64 & "/" & rs("dosyaAd") & """><i class=""fa fa-file-pdf-o""></i></a></td>"
	Response.Write "<td>"
	if rs("cariMailKomut") = "True" then
		Response.Write "<i class=""fa fa-at"" title=""Cariye e-posta gönderme komutu verilmiş.""></i>"
	end if
	Response.Write "</td>"
	Response.Write "</tr>"
rs.movenext
next
rs.close

	Response.Write "</table>"
end if

Response.Write "</div>"
Response.Write "</div>"


	else
		call yetkisizGiris("","","")
	end if

%>