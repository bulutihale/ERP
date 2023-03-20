<!--#include virtual="/reg/rs.asp" --><%




gelenText = ""


for zi = 1 to LEN(gelenText)

Response.Write "<div class=""row hoverGel default"">"
    Response.Write "<div class=""col-1"">"
        Response.Write mid(gelenText,zi,1)
    Response.Write "</div>"
    Response.Write "<div class=""col-1"">"
        Response.Write ASC(mid(gelenText,zi,1)) & "<br>"
    Response.Write "</div>"
Response.Write "</div>"
next


%>