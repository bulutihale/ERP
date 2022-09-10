<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
    opener  =   Request.QueryString("opener")
	modulAd =   "Yemek"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Yemek Listesi Ekranı")


yetkiManager = yetkibul("manager")


    if opener = "" then
        if yetkiManager > 2 then
            Response.Write "<div class=""col-sm-3 my-1"">"
            Response.Write "<button type=""button"" class=""btn btn-danger"" onClick=""modalajax('/isletme/yemek_yeni.asp')"">YENİ GÜN EKLE</button>&nbsp;"
            randnumber = unique()
            Response.Write "<A type=""button"" class=""btn btn-danger"" STYLE=""color:white"" href=""/temp/yemeklistesi.xls"" target=""_blank"">EXCEL</A>"
            Response.Write "</div>"
        end if
    end if

haftabasi = weekday(date()-1)


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" then
		Response.Write "<div class=""table-responsive"">"
            sorgu = "Select top 30 * from isletme.yemekListe"
			sorgu = sorgu & " where isletme.yemekListe.firmaID = " & firmaID
            sorgu = sorgu & " and isletme.yemekListe.tarih > '" & tarihsql(date()-haftabasi) & "'"
			sorgu = sorgu & " order by isletme.yemekListe.tarih ASC"
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
            for i = 1 to rs.recordcount
			Response.Write "<div class=""col-lg-2 col-md-3 col-sm-4 col-xs-12 mt-3 border-primary border card pricing-card-body mr-3 "
            if opener = "" then
                Response.Write "ml-3"
            end if
            Response.Write """>"
                Response.Write "<div class=""row"">"
                    Response.Write "<div class=""col-lg-12 text-center badge "
                    if rs("tarih") >= date() then
                        Response.Write "badge-primary"
                    end if
                    Response.Write """>"
                    if rs("tarih") >= date() then
                        if yetkiManager > 2 then
                            Response.Write "<a class=""parmak"" onClick=""modalajax('/isletme/yemek_yeni.asp?gorevID=" & rs("yemekListeID") & "')"">" & tarihtr(rs("tarih")) & "</a>"
                        else
                            Response.Write tarihtr(rs("tarih"))
                        end if
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
        Response.Write "</div>"
        Response.Write "</div>"

			end if
			rs.close
		Response.Write "</div>"
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU












%>