<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid = kidbul()

Response.Flush()

yetkiIT = yetkibul("IT")


		Response.Write "<div class=""panel panel-primary mb10 mt10"">"
			Response.Write "<div class=""panel-heading"">Haberler - Güncellemeler"
			if yetkiIT = 9 then
			Response.Write "<a href=""/whatsnew/whatsnew_yeni"" class=""pull-right btn btn-warning"">Yeni Haber Ekle</a>"
			end if
			call clearfix()
			Response.Write "</div>"
			Response.Write "<div class=""panel-body"">"
				Response.Write "<div class=""container-fluid"">"

	'#### FİLTRE
		Response.Write "<form method=""post"" action=""/whatsnew/whatsnew_liste""><div class=""contaner-fluid""><div class=""row""><div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12""><input type=""text"" class=""form-control"" placeholder=""Arama"" name=""q"" /></div></div><div class=""row""><div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12""><button type=""submit"" class=""form-control btn btn-success"">Filtrele</button></div></div></div></form>"
	'#### FİLTRE

	'#### FİLTRE REQUEST
	q = Request.Form("q")
	'#### FİLTRE REQUEST

	'#### TABLO
		Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
		Response.Write "<th nowrap>Tarih</th>"
		Response.Write "<th nowrap>Modul</th>"
		Response.Write "<th nowrap>Ad</th>"
		Response.Write "<th nowrap>Açıklama</th>"
		Response.Write "<th nowrap class=""text-center"">İşlem</th>"
		Response.Write "</tr></thead><tbody>"
		sorgu = "" & vbcrlf
		sorgu = sorgu & "Select " & vbcrlf
		sorgu = sorgu & "*" & vbcrlf
		sorgu = sorgu & "from portal.whatsnew where (firmaID = 0 or firmaID = " & firmaID & ")" & vbcrlf
		if q <> "" then
			sorgu = sorgu & " and (portal.whatsnew.ad like '%" & q & "%' or portal.whatsnew.aciklama like '%" & q & "%')" & vbcrlf
		end if
		sorgu = sorgu & " order by portal.whatsnew.tarih DESC" & vbcrlf
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
			for ri = 1 to rs.recordcount
				kid64 = rs("id")
				kid64 = base64_encode_tr(kid64)
				Response.Write "<tr>"
				Response.Write "<td>" & rs("tarih") & "</td>"
				Response.Write "<td>" & rs("modul") & "</td>"
				Response.Write "<td>" & rs("ad") & "</td>"
				Response.Write "<td>" & rs("aciklama") & "</td>"
				Response.Write "<td class=""text-center""><div class=""btn-group"">"
				Response.Write "<a class=""btn btn-xs btn-default"" title="""" data-toggle=""tooltip"" href=""/whatsnew/whatsnew_yeni?ID=" & kid64 & """ data-original-title=""Düzenle""><i class=""fa fa-pencil""></i></a>"
				Response.Write "</div></td></tr>"
			rs.movenext
			next
		end if
		rs.close
		Response.Write "</table>"
	'#### TABLO


				Response.Write "</div>"'cfluid
			Response.Write "</div>"'pbody
		Response.Write "</div>"'panel




%><!--#include virtual="/reg/rs.asp" -->