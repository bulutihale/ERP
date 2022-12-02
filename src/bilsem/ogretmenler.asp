<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid = kidbul()

Response.Flush()

yetki = yetkibul("personel")

if yetki > 0 then

		Response.Write "<div class=""panel panel-primary mb10 mt10"">"
			Response.Write "<div class=""panel-heading"">Personeller"
			if yetki > 5 then
				Response.Write "<a href=""/ik/personel_yeni"" class=""pull-right btn btn-warning"">Yeni Personel Ekle</a>"
			end if
			call clearfix()
			Response.Write "</div>"
			Response.Write "<div class=""panel-body"">"
				Response.Write "<div class=""container-fluid"">"


	'#### FİLTRE
		Response.Write "<form method=""post"" action=""/ik/personel_liste""><div class=""contaner-fluid""><div class=""row""><div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12""><input type=""text"" class=""form-control"" placeholder=""Arama"" name=""q"" /></div></div><div class=""row""><div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12""><button type=""submit"" class=""form-control btn btn-success"">Filtrele</button></div></div></div></form>"
	'#### FİLTRE

	'#### FİLTRE REQUEST
	q = Request.Form("q")
	'#### FİLTRE REQUEST

	'#### TABLO
		Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
		Response.Write "<th nowrap>Adı</th>"
		Response.Write "<th nowrap>Görevi</th>"
		Response.Write "<th nowrap>Cep Telefonu</th>"
		Response.Write "<th nowrap>Email</th>"
		Response.Write "<th nowrap>İşten Ayrılma</th>"
		Response.Write "<th nowrap class=""text-right"">Son Giriş</th>"
		if yetki > 5 then
			Response.Write "<th nowrap class=""text-center"">İşlem</th>"
		end if
		Response.Write "</tr></thead><tbody>"
		sorgu = "" & vbcrlf
		sorgu = sorgu & "Select " & vbcrlf
		sorgu = sorgu & "personel.personel.ad " & vbcrlf
		sorgu = sorgu & ",personel.personel.gorev " & vbcrlf
		sorgu = sorgu & ",personel.personel.ceptelefon " & vbcrlf
		sorgu = sorgu & ",personel.personel.email " & vbcrlf
		sorgu = sorgu & ",personel.personel.expiration " & vbcrlf
		sorgu = sorgu & ",personel.personel.songiris " & vbcrlf
		sorgu = sorgu & ",personel.personel.id " & vbcrlf
		sorgu = sorgu & "from personel.personel " & vbcrlf
		if q <> "" then
			sorgu = sorgu & "where (personel.personel.ad like '%" & q & "%' or personel.personel.email like '%" & q & "%')" & vbcrlf
		else
			sorgu = sorgu & "where (personel.personel.expiration is null or personel.personel.expiration > '" & tarihsql(date()) & "')" & vbcrlf
		end if
		sorgu = sorgu & " and firmaID = " & firmaID & vbcrlf
		sorgu = sorgu & "" & vbcrlf
		sorgu = sorgu & " order by personel.personel.ad asc" & vbcrlf
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
		for ri = 1 to rs.recordcount
			kid64 = rs("id")
			kid64 = base64_encode_tr(kid64)
			if rs("songiris") < date()-90 then
				rs("expiration") = date()-90
				rs.update
			end if
			Response.Write "<tr>"
			Response.Write "<td>"
			Response.Write rs("ad") & "</td>"
			Response.Write "<td>" & rs("gorev") & "</td>"
			Response.Write "<td>" & rs("ceptelefon") & "</td>"
			Response.Write "<td>" & rs("email") & "</td>"
			Response.Write "<td>" & rs("expiration") & "</td>"
			Response.Write "<td class=""text-right"">" & rs("songiris") & "</td>"
			if yetki > 5 then
				Response.Write "<td class=""text-center"">"
				Response.Write "<div class=""btn-group"">"
				Response.Write "<a class=""btn btn-xs btn-default"" title="""" data-toggle=""tooltip"" href=""/ik/personel_yeni?ID=" & kid64 & """ data-original-title=""Düzenle""><i class=""fa fa-pencil""></i></a>"
				Response.Write "</div>"
				Response.Write "</td>"
			end if
			Response.Write "</tr>"
		rs.movenext
		next
		end if
		rs.close
		Response.Write "</table>"
	'#### TABLO


				Response.Write "</div>"'cfluid
			Response.Write "</div>"'pbody
		Response.Write "</div>"'panel


end if

%><!--#include virtual="/reg/rs.asp" -->