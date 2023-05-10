<!--#include virtual="/reg/rs.asp" --><%


	kid						=	kidbul()
	cariID					=	Request.QueryString("cariID")
	ihaleID					=	Request.QueryString("ihaleID")
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


'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"Cari Notlar"
'##### YETKİ BUL
'##### YETKİ BUL

sorgu = "SELECT teslimatKosul FROM ihale where id = " & ihaleID
rs.open sorgu,sbsv5,1,3
	teslimatKosul = rs("teslimatKosul")
rs.close


sorgu = "SELECT cariNotlar FROM cariler WHERE id =" & cariID
rs.open sorgu,sbsv5,1,3

cariNotlar			=	rs("cariNotlar")
rs.close
Response.Write "<button type=""button"" class=""close"" aria-label=""Close"">"
Response.Write "<span aria-hidden=""true"" onClick=""modalkapat();"">&times;</span>"
Response.Write "</button>"

Response.Write "<form action=""/dosya/hucre_kaydet.asp"" method=""post"" class=""ajaxform"">"
Response.Write "<input type=""hidden"" name=""alan"" value=""cariNotlar"" />"
Response.Write "<input type=""hidden"" name=""id"" value=""" & cariID & """ />"
Response.Write "<input type=""hidden"" name=""tablo"" value=""cariler"" />"

		Response.Write "<label class=""badge"">Teslimat notları</label>"
		Response.Write "<textarea disabled class=""form-control"" name=""deger"" rows=""5"" id=""cariNotlar"">" & teslimatKosul & "</textarea>"

	Response.Write "<div class=""container-fluid row"">"
		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<label class=""badge"">Cari ile ilgili notlar</label>"
		call clearfix()
		Response.Write "<textarea class=""form-control"" name=""deger"" rows=""5"" id=""cariNotlar"">" & cariNotlar & "</textarea>"
		Response.Write "</div>"


		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<button type=""submit"" class=""btn form-control btn-success"" onClick=""modalkapat();"">Kaydet</button>"
			call clearfix()
		Response.Write "</div>"
	Response.Write "</div>"
Response.Write "</form>"


%>

