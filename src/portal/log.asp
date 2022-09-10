<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid = kidbul()

Response.Flush()

yetki = yetkibul("manager")



	'#### TABLO
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		Response.Write "<table class=""table table-sm table-striped table-bordered table-hover mt10""><thead><tr>"
		Response.Write "<th>Tarih</th>"
		Response.Write "<th>Kid</th>"
		Response.Write "<th>İşlem</th>"
		Response.Write "<th>ip</th>"
		Response.Write "</tr></thead><tbody>"
		sorgu = "Select top(1000) *,(Select personel.personel.ad from personel.personel where personel.personel.id = personel.personel_log.personelID) as kidAd from personel.personel_log where firmaID = '" & firmaID & "' and personelID <> 0"
		if yetki > 5 then
		else
			sorgu = sorgu & " and personelID = " & kid
		end if
		sorgu = sorgu & "order by id desc"
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
		for ri = 1 to rs.recordcount
			Response.Write "<tr>"
			Response.Write "<td>" & rs("tarih") & "</td>"
			Response.Write "<td>" & rs("kidAd") & "</td>"
			Response.Write "<td>" & rs("islem") & "</td>"
			Response.Write "<td>" & rs("ip") & "</td>"
			Response.Write "</td>"
			Response.Write "</tr>"
		rs.movenext
		next
		end if
		rs.close
		Response.Write "</table>"
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	'#### TABLO

'end if

%><!--#include virtual="/reg/rs.asp" -->