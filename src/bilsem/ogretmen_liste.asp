<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid = kidbul()

Response.Flush()

yetki = yetkibul("bilsem")

if yetki > 1 then

		Response.Write "<div class=""panel panel-primary mb10 mt10"">"
			Response.Write "<div class=""panel-heading"">Öğretmenler"
			if yetki > 5 then
				Response.Write "<a href=""/bilsem/ogretmen_yeni"" class=""pull-right btn btn-warning"">Yeni Öğretmen Ekle</a>"
			end if
			call clearfix()
			Response.Write "</div>"
			Response.Write "<div class=""panel-body"">"
				Response.Write "<div class=""container-fluid"">"


	'#### FİLTRE
		Response.Write "<form method=""post"" action=""/bilsem/ogretmen_liste""><div class=""contaner-fluid""><div class=""row""><div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12""><input type=""text"" class=""form-control"" placeholder=""Arama"" name=""q"" /></div></div><div class=""row""><div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12""><button type=""submit"" class=""form-control btn btn-success"">Filtrele</button></div></div></div></form>"
	'#### FİLTRE

	'#### FİLTRE REQUEST
	q = Request.Form("q")
	'#### FİLTRE REQUEST

	'#### TABLO
		Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
		Response.Write "<th nowrap>Adı</th>"
		Response.Write "<th nowrap>Branşı</th>"
		if yetki > 5 then
			Response.Write "<th nowrap class=""text-center"">İşlem</th>"
		end if
		Response.Write "</tr></thead><tbody>"
		sorgu = "" & vbcrlf
		sorgu = sorgu & "Select " & vbcrlf
		sorgu = sorgu & "bilsem.ogretmen.ogretmenAd " & vbcrlf
		sorgu = sorgu & ",bilsem.ogretmen.ogretmenBrans " & vbcrlf
		sorgu = sorgu & ",bilsem.ogretmen.ogretmenID " & vbcrlf
		sorgu = sorgu & "from bilsem.ogretmen " & vbcrlf
		sorgu = sorgu & "where " & vbcrlf
		if q <> "" then
			sorgu = sorgu & " (bilsem.ogretmen.ogretmenAd like '%" & q & "%') and " & vbcrlf
		end if
		sorgu = sorgu & "  firmaID = " & firmaID & vbcrlf
		sorgu = sorgu & " and silindi = 0" & vbcrlf
		sorgu = sorgu & "" & vbcrlf
		sorgu = sorgu & " order by bilsem.ogretmen.ogretmenAd asc" & vbcrlf
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
		for ri = 1 to rs.recordcount
			kid64 = rs("ogretmenID")
			kid64 = base64_encode_tr(kid64)
			Response.Write "<tr>"
			Response.Write "<td>"
			Response.Write rs("ogretmenAd") & "</td>"
			Response.Write "<td>"
			Response.Write rs("ogretmenBrans") & "</td>"
			if yetki > 5 then
				Response.Write "<td class=""text-center"">"
				Response.Write "<div class=""btn-group"">"
				Response.Write "<a class=""btn btn-xs btn-default"" title="""" data-toggle=""tooltip"" href=""/bilsem/ogretmen_yeni?ID=" & kid64 & """ data-original-title=""Düzenle""><i class=""fa fa-pencil""></i></a>"
				if yetki > 6 then
					Response.Write "<a class=""btn btn-xs btn-danger"" title="""" data-toggle=""tooltip"" onClick="""
					Response.Write "bootmodal('Kaydı silmek istediğinize emin misiniz?','custom','/bilsem/ogretmen_sil.asp?ID=" & kid64 & "','','Evet','Hayır','btn-danger','btn-success','','ajax','','','')"
					Response.Write """ data-original-title=""Sil""><i class=""fa fa-trash""></i></a>"
				end if
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