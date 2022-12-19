<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR




if hata = "" then
    Response.Write "<div class=""row"">"
        Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs-6"">"
            Response.Write "<div class=""card"">"
            Response.Write "<div class=""card-header text-white bg-dark"">İşlem Log</div>"
            Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"
                Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 border-primary border card pricing-card-body "
                Response.Write """>"
                        Response.Write "<div class=""row text-white bg-dark"">"
                            Response.Write "<div class=""col"">Tarih</div>"
                            Response.Write "<div class=""col"">İşlem</div>"
                        Response.Write "</div>"
                    sorgu = "SELECT TOP(10) t1.tarih, t1.islem FROM personel.personel_log t1 WHERE t1.personelID = " & kid & " AND t1.firmaID = " & firmaID & " ORDER BY id DESC"
	                rs.Open sorgu, sbsv5, 1, 3
                    if rs.recordcount > 0 then
                        for di = 1 to rs.recordcount
                        tarih       =   rs("tarih")
                        islem       =   rs("islem")
                        Response.Write "<div class=""row fontkucuk2"">"
                            Response.Write "<div class=""col-3"">" & tarih & "</div>"
                            Response.Write "<div class=""col-9"">" & islem & "</div>"
                        Response.Write "</div>"
                        rs.movenext
                        next
                    end if
                    rs.close
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
        Response.Write "</div>"
    Response.Write "</div>"
else
    call yetkisizGiris(hata,"","")
end if
%><!--#include virtual="/reg/rs.asp" -->