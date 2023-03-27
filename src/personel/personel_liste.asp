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
    modulAd =   "Personel"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Personel Listesi Ekranı")

yetkiKontrol = yetkibul(modulAd)



'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				'Response.Write "<div class=""row"">"
					Response.Write "<form action=""/personel/personel_liste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Ad Soyad","","") & """ name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 5 then
								Response.Write "<div class=""col-lg-9 col-sm-6 my-1 text-right"">"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/personel/personel_yeni.asp')"">" & translate("Yeni Personel Ekle","","") & "</button>"
								Response.Write "</div>"
							end if
						Response.Write "</div>"
					Response.Write "</form>"
				'Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"

	end if
'###### ARAMA FORMU
'###### ARAMA FORMU



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"

		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">" & translate("Firma Adı","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Ad Soyad","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Pozisyon","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">GSM</th>"
		Response.Write "<th scope=""col"">" & translate("Son Giriş","","") & "</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody>"
            sorgu = "Select" & vbcrlf
			sorgu = sorgu & "personel.personel.id," & vbcrlf
			sorgu = sorgu & "personel.personel.ad," & vbcrlf
			sorgu = sorgu & "personel.personel.gorev," & vbcrlf
			sorgu = sorgu & "personel.personel.ceptelefon," & vbcrlf
			sorgu = sorgu & "personel.personel.songiris," & vbcrlf
			sorgu = sorgu & "portal.firma.Ad as firmaAd" & vbcrlf
			sorgu = sorgu & "from personel.personel" & vbcrlf
			sorgu = sorgu & "INNER JOIN portal.firma on (portal.firma.Id = " & firmaID & " or portal.firma.anaFirmaID = " & firmaID & ") and portal.firma.Id = personel.personel.firmaID" & vbcrlf
			sorgu = sorgu & "where" & vbcrlf
			' sorgu = sorgu & "personel.personel.firmaID = " & firmaID & vbcrlf
			' sorgu = sorgu & "personel.personel.firmaID in (select Id from portal.firma where Id = " & firmaID & " or anaFirmaID = " & firmaID & ")" & vbcrlf
			sorgu = sorgu & " (personel.personel.expiration >= '" & tarihsql(date()) & "' or personel.personel.expiration is null )" & vbcrlf
			sorgu = sorgu & " and (personel.personel.songiris > '" & tarihsql(date()-30) & "' or personel.personel.songiris is null )" & vbcrlf
			if aramaad = "" then
			else
				sorgu = sorgu & " and (personel.personel.ad like N'%" & aramaad & "%')" & vbcrlf
			end if
			sorgu = sorgu & " order by personel.personel.ad ASC" & vbcrlf
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					personelID	=	rs("id")
					Response.Write "<tr>"
					Response.Write "<td>"
                    Response.Write rs("firmaAd")
					Response.Write "</td>"
					Response.Write "<td>"
                    Response.Write rs("ad")
					Response.Write "</td>"
					Response.Write "<td>"
                    Response.Write rs("gorev")
					Response.Write "</td>"
                    Response.Write "<td>"
					if isnull(rs("ceptelefon")) = True then
						Response.Write "&nbsp;"
					else
                    	Response.Write replace(rs("ceptelefon")," ","")
					end if
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("songiris")
					Response.Write "</td>"
					if yetkiKontrol >= 5 then
						Response.Write "<td class=""text-right"">"
						'# personel bilgileri
						personelID64 = personelID
						personelID64= base64_encode_tr(personelID64)
						Response.Write "<a title=""" & translate("Grup Atamaları","","") & """"
						Response.Write " onClick=""modalajax('/personel/grup_modal.asp?gorevID=" & personelID64 & "');"">"
						Response.Write "<i class=""icon group mr-2 parmak"
						Response.Write """></i>"
						Response.Write "</a>"

						Response.Write "<a title=""" & translate("Personel Yetkileri","","") & """"
						Response.Write " onClick=""modalajax('/personel/yetki.asp?gorevID=" & personelID64 & "');"">"
						Response.Write "<i class=""icon lock mr-2 parmak"
						Response.Write """></i>"
						Response.Write "</a>"

						Response.Write "<a title=""" & translate("Personel Bilgilerini Düzenle","","") & """"
						Response.Write " onClick=""modalajax('/personel/personel_yeni.asp?gorevID=" & personelID64 & "');"">"
						Response.Write "<i class=""icon user-edit parmak"
						Response.Write """></i>"
						Response.Write "</a>"
						'# personel bilgileri
						Response.Write "</td>"
					end if
					Response.Write "</tr>"
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"

				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"

	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU












%>