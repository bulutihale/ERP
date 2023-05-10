<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Ayarlar"
    Response.Flush()
'###### ANA TANIMLAMALAR


Response.Write "<div class=""container-fluid"">"
    Response.Write "<div class=""row"">"
        Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
            Response.Write "<div class=""card"">"
            Response.Write "<div class=""card-body"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-lg-4"">"
                    Response.Write "<div><a href=""/portal/dilolustur.asp"" target=""_blank"" class=""btn btn-info"">Dil Oluştur</a></div>"
                Response.Write "</div>"
                Response.Write "<div class=""col-lg-4"">"
                    Response.Write "<div><a href=""/portal/font"" class=""btn btn-info"">Font Listesi</a></div>"
                Response.Write "</div>"
                Response.Write "<div class=""col-lg-4"">"
                    Response.Write "<div><a href=""/portal/sabit_olustur.asp"" class=""btn btn-info"">Sistem Ayarlarını Tazele</a></div>"
                Response.Write "</div>"



            Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
        Response.Write "</div>"
    Response.Write "</div>"
Response.Write "</div>"


%><!--#include virtual="/reg/rs.asp" -->