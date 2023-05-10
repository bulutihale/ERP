<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	ihaleID					=	Request.QueryString("ihaleID")
	sipID					=	Request.QueryString("sipID")
	iutID					=	Request.QueryString("iutID")
	call sessiontest()


'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr




Response.Write "<button type=""button"" class=""close"" aria-label=""Close"">"
Response.Write "<span aria-hidden=""true"" onClick=""modalkapat();"">&times;</span>"
Response.Write "</button>"

Response.Write "<form action=""/dosya/lotMiktarKaydet.asp"" method=""post"" class=""ajaxform"">"
Response.Write "<input type=""hidden"" name=""sipID"" value=""" & sipID & """ />"
Response.Write "<input type=""hidden"" name=""ihaleID"" value=""" & ihaleID & """ />"
Response.Write "<input type=""hidden"" name=""iutID"" value=""" & iutID & """ />"
Response.Write "<input type=""hidden"" name=""tablo"" value=""siparisLot"" />"

	Response.Write "<div class=""container-fluid row"">"
		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<label class=""badge"">LOT</label>"
		call clearfix()
		Response.Write "<input class=""form-control"" name=""lot"" id=""lot"">"
		Response.Write "<label class=""badge"">Miktar</label>"
		call clearfix()
		Response.Write "<input class=""form-control"" name=""lotMiktar"" id=""lotMiktar"">"
		Response.Write "</div>"


		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<button type=""submit"" class=""btn form-control btn-success"" onClick=""modalkapat();"">Kaydet</button>"
			call clearfix()
		Response.Write "</div>"
	Response.Write "</div>"
Response.Write "</form>"


%>

