<!--#include virtual="/reg/rs.asp" --><%

Response.Write "<div class=""container-fluid"">"
    Response.Write "<div class=""row"">"
        Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
            Response.Write "<div class=""card"">"
            Response.Write "<div class=""card-body"">"
            Response.Write "<div class=""row"">"
                Set fso = CreateObject("Scripting.FileSystemObject")
                Set dosya = fso.OpenTextFile(Server.Mappath("/template/famfamfam/famfamfam.css"), 1)
                satir = 0
                Do Until dosya.AtEndOfStream
                    if satir = 0 then
                        satirIcerik = dosya.Readline
                    end if
                    satirIcerik = dosya.Readline
                    satirIcerik = Replace(satirIcerik,".icon.","")
                    satirIcerikArr = Split(satirIcerik,"{")
                    Response.Write "<div class=""col-lg-2"">"
                    Response.Write "<i class=""mr-3 icon " & satirIcerikArr(0) & """></i>"
                    Response.Write satirIcerikArr(0)
                    Response.Write "</div>"
                    set satirIcerikArr = Nothing
                satir = satir + 1
                Loop
            Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
        Response.Write "</div>"
    Response.Write "</div>"
Response.Write "</div>"

%><!--#include virtual="/reg/rs.asp" -->