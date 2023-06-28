<!--#include virtual="/reg/rs.asp" --><%

sessiontest()

'eklemek için

iuID		=	Request("iuID")


sorgu = "SELECT t1.kalemNot"
sorgu = sorgu & " FROM teklifv2.ihale_urun t1"
sorgu = sorgu & " WHERE t1.id = " & iuID
rs.open sorgu,sbsv5,1,3
	if rs.recordcount > 0 then
		kalemNot			=	rs("kalemNot")& ""
		kalemNot			=   Replace(kalemNot,chr(10),"<br />- ")
		kalemNot			=   Replace(kalemNot,chr(13),"<br />- ")

		Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-12"">"
			Response.Write "<div class=""bold mb-4"">Kalem Not içeriği</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-lg-12 col-xs-12 mt10 mb10"">"
			Response.Write kalemNot
		Response.Write "</div>"
		Response.Write "</div>"
	end if
rs.close

%><!--#include virtual="/reg/rs.asp" -->











