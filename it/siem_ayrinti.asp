<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    hata    =   ""
    modulAd =   "ITSiemList"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'call logla("Hasta Listesi Ekranı")

yetkiIT = yetkibul("IT")


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiIT > 0 then
        sorgu = "Select top 300 * from IT.cihazlarLog"
	    sorgu = sorgu & " where ip = '" & gorevID & "'"
		sorgu = sorgu & " order by tarih DESC"
		rs.Open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
            Response.Write "<div class=""table-responsive"">"
            Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
            Response.Write "<th scope=""col"">" & translate("Durum","","") & "</th>"
            Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Tarih","","") & "</th>"
            Response.Write "</tr></thead><tbody>"
                    for i = 1 to rs.recordcount
                        Response.Write "<tr"
                        if rs("kontrolPing") = "DEAD" then
                            Response.Write " class=""bg-danger"""
                        else
                            Response.Write " class=""bg-success"""
                        end if
                        Response.Write ">"
                        Response.Write "<td>"
                        Response.Write rs("kontrolPing")
                        Response.Write "</td>"
                        Response.Write "<td>"
                        Response.Write rs("tarih")
                        Response.Write "</td>"
                        Response.Write "</tr>"
                    rs.movenext
                    next
            Response.Write "</tbody>"
            Response.Write "</table>"
            Response.Write "</div>"
		end if
		rs.close
	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU







%><!--#include virtual="/reg/rs.asp" -->