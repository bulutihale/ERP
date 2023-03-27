<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
    ' opener  =   Request.Form("opener")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Telefon Rehberi Ekranı")

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		Response.Write "<form action=""/personel/telefonRehberi.asp"" method=""post"" class=""ortaform"">"
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-6 my-1"">"
		Response.Write "<label class=""sr-only"" for=""inlineFormInputName"">" & translate("Ünvan","","") & "</label>"
		Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Ad Soyad","","") & """ name=""aramaad"" value=""" & aramaad & """>"
		Response.Write "</div>"
		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
				Response.Write "</div>"
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
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">" & translate("Ad Soyad","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Tür","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Dahili","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">GSM</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Email</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Departman","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Ünvan","","") & "</th>"
		Response.Write "</tr></thead><tbody>"
            sorgu = "Select *,personel.departman.departmanAd from personel.telefonRehberi" & vbcrlf
			sorgu = sorgu & " LEFT JOIN personel.departman on personel.departman.departmanID = personel.telefonRehberi.departmanID" & vbcrlf
			sorgu = sorgu & " where personel.telefonRehberi.firmaID = " & firmaID & vbcrlf
			if aramaad = "" then
			else
				sorgu = sorgu & " and (personel.telefonRehberi.ad like N'%" & aramaad & "%')"
			end if
			sorgu = sorgu & " order by ad ASC"
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					Response.Write "<tr>"
					Response.Write "<td>"
                    Response.Write rs("ad")
					Response.Write "</td>"
					Response.Write "<td>"
                    Response.Write rs("tur")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("dahili")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write replace(rs("gsm") & ""," ","")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("email")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("departmanAd")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("unvan")
					Response.Write "</td>"
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
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU












%>