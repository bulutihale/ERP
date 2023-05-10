<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	personelID			=	kid
	mobil				=	mobilkontrol()
	hata				=	""
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-dark"">Neler Yeni?</div>"
				Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"
					sorgu = "Select top 20 * from portal.whatsnew where firmaID = 0 or firmaID = " & firmaID & " order by tarih desc,Id desc"
					rs.Open sorgu, sbsv5, 1, 3
					if rs.recordcount > 0 then
						Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
						Response.Write "<th scope=""col"">Tarih</th>"
						Response.Write "<th scope=""col"">Güncelleme</th>"
'						Response.Write "<th scope=""col"">Ayrıntı</th>"
						Response.Write "</tr></thead><tbody>"
						for i = 1 to rs.recordcount
							Response.Write "<tr>"
							Response.Write "<td scope=""col"">" & rs("tarih") & "</td>"
							if rs("tarih") > (date()-7) then
								Response.Write "<td scope=""col""><img src=""/template/star_1_16.png"" style=""width:16px;height:16px"" />" & rs("ad") & "</td>"
							else
								Response.Write "<td scope=""col"">" & rs("ad") & "</td>"
							end if
'							Response.Write "<td scope=""col"">" & rs("aciklama") & "</td>"
							Response.Write "</tr>"
						rs.movenext
						next
						Response.Write "</tbody></table>"
					end if
					rs.close
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"


%>