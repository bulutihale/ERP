<!--#include virtual="/reg/rs.asp" --><%

    call sessiontest()
    kid		=	kidbul()


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
            sorgu = ""
			sorgu = sorgu & "Select top 50 Zaman from Polimek_Data.dbo.Perbilgi where PersonelId = ("
            sorgu = sorgu & "select PersonelId from Polimek_Data.dbo.Personel where Sicil = ("
            sorgu = sorgu & "Select pdksSicil from personel.personel where id = " & kid
            sorgu = sorgu & ")"
            sorgu = sorgu & ") order by Zaman DESC"
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
                Response.Write "<div class=""row"">"
                    Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                        Response.Write "<div class=""card"">"
                        Response.Write "<div class=""card-header text-white bg-dark""><a style=""color:white"">PDKS Aktiviteleri (son 50)</a></div>"
                        Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"
                            Response.Write "<table class=""table"">"
                            Response.Write "<tr>"
                            Response.Write "<th>"
                            Response.Write "Kart Basılma Zamanı"
                            Response.Write "</th>"
                            Response.Write "</tr>"
                                for i = 1 to rs.recordcount
                                    Response.Write "<tr>"
                                    Response.Write "<td>"
                                    Response.Write rs("Zaman")
                                    Response.Write "</td>"
                                    Response.Write "</tr>"
                                rs.movenext
                                next
                            Response.Write "</table>"
                        Response.Write "</div>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
			end if
			rs.close
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU




%>