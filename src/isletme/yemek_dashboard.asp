<!--#include virtual="/reg/rs.asp" --><%



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	' if hata = "" then
		' Response.Write "<div class=""table-responsive"">"
            sorgu = "Select top 1 * from isletme.yemekListe"
			sorgu = sorgu & " where isletme.yemekListe.firmaID = " & firmaID
            sorgu = sorgu & " and isletme.yemekListe.tarih > '" & tarihsql(date()-1) & "'"
			sorgu = sorgu & " order by isletme.yemekListe.tarih ASC"
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-dark""><a href=""/isletme/yemek"" style=""color:white"">Günlük Yemek Listesi</a></div>"
				Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"


		' Response.Write "<div class=""container-fluid"">"
		' Response.Write "<div class=""row"">"
            for i = 1 to rs.recordcount
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 border-primary border card pricing-card-body "
            ' if opener = "" then
            '     Response.Write "ml-3"
            ' end if
            Response.Write """>"
                Response.Write "<div class=""row parmak"" onClick=""document.location = '/isletme/yemek'"">"
                    Response.Write "<div class=""col-lg-12 text-center badge "
                    if rs("tarih") >= date() then
                        Response.Write "badge-primary"
                    end if
                    Response.Write """>"
                    if rs("tarih") >= date() then
                            Response.Write "<a>" & tarihtr(rs("tarih")) & "</a>"
                    end if
                        Response.Write "</div>"
                    if rs("tarih") >= date() then
                        Response.Write "<div class=""col-lg-12 text-center small"">"
                            Response.Write rs("yemek1")
                        Response.Write "</div>"
                        Response.Write "<div class=""col-lg-12 text-center small"">"
                            Response.Write rs("yemek2")
                        Response.Write "</div>"
                        Response.Write "<div class=""col-lg-12 text-center small"">"
                            Response.Write rs("yemek3")
                        Response.Write "</div>"
                        Response.Write "<div class=""col-lg-12 text-center small"">"
                            Response.Write rs("yemek4")
                        Response.Write "</div>"
                        Response.Write "<div class=""col-lg-12 text-center badge badge-warning small"">"
                            Response.Write "&nbsp;"
                            Response.Write rs("yemek5")
                        Response.Write "</div>"
                    end if
                Response.Write "</div>"
            Response.Write "</div>"
			rs.movenext
			next
        ' Response.Write "</div>"
        ' Response.Write "</div>"

			end if
			rs.close
		' Response.Write "</div>"
	' end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU



				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
%>