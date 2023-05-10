<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    modulAd 		=   "Döviz"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    mesaj = "Döviz kurları geçmişi inceleniyor"
    call logla(mesaj)


	'#### TABLO
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		Response.Write "<table class=""table table-sm table-striped table-bordered table-hover mt10""><thead><tr>"
		Response.Write "<th>Tarih</th>"
		Response.Write "<th>USD TCMB</th>"
		Response.Write "<th>USD Özel</th>"
		Response.Write "<th>EUR TCMB</th>"
		Response.Write "<th>EUR Özel</th>"
		Response.Write "<th>GBP TCMB</th>"
		Response.Write "<th>GBP Özel</th>"
		Response.Write "</tr></thead><tbody>"
		sorgu = "Select * from portal.doviz where firmaID = " & firmaID & " order by tarih DESC"
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
		for ri = 1 to rs.recordcount
			Response.Write "<tr>"
			Response.Write "<td>" & rs("tarih") & "</td>"
			Response.Write "<td>" & rs("usdtry") & "</td>"
			Response.Write "<td>" & rs("usdtryCustom") & "</td>"
			Response.Write "<td>" & rs("eurtry") & "</td>"
			Response.Write "<td>" & rs("eurtryCustom") & "</td>"
			Response.Write "<td>" & rs("gbptry") & "</td>"
			Response.Write "<td>" & rs("gbptryCustom") & "</td>"
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

%><!--#include virtual="/reg/rs.asp" -->