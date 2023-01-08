<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifID = Request.QueryString("teklifID")
'###### ANA TANIMLAMALAR


'### SAYFA ID TESPİT ET
    if teklifID = "" then
        if hata = "" then
            if gorevID = "" then
                gorevID64 = Session("sayfa5")

                if gorevID64 = "" then
                else
                    gorevID		=	gorevID64
                    gorevID		=	base64_decode_tr(gorevID)
                end if
            else
                if isnumeric(gorevID) = False then
                    gorevID		=	base64_decode_tr(gorevID)
                end if
                gorevID		=	int(gorevID)
                gorevID64	=	gorevID
                gorevID64	=	base64_encode_tr(gorevID64)
            end if
        end if
        teklifID = gorevID
    end if
'### SAYFA ID TESPİT ET




            Response.Write "<div class=""container-fluid scroll-ekle3"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
                        Server.execute "/portal/pdf.asp"
                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"




%><!--#include virtual="/reg/rs.asp" -->