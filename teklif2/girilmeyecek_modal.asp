<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	ihaleID64				=	Request.QueryString("id")
	ihaleID					=	base64_decode_tr(ihaleID64)
	ayar_firmaBagimsizCari	=	1
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
	sayfaadi	=	"Dosya Detay"
'##### YETKİ BUL
'##### YETKİ BUL


		sorgu = "SELECT * FROM girilmeyecek_aciklama WHERE ihaleID = " & ihaleID
		rs.open sorgu, sbsv5,1,3
		
		if rs.recordcount > 0 then
			id			=	rs("id")
			aciklama	=	rs("aciklama")
		else
			id = 0
		end if


Response.Write "<button type=""button"" class=""close"" aria-label=""Close"">"
Response.Write "<span aria-hidden=""true"" onClick=""modalkapat();"">&times;</span>"
Response.Write "</button>"

Response.Write "<form action=""/dosya/hucre_kaydet.asp"" method=""post"" class=""ajaxform"">"
Response.Write "<input type=""hidden"" name=""alan"" value=""aciklama"" />"
Response.Write "<input type=""hidden"" name=""id"" value=""" & id & """ />"
Response.Write "<input type=""hidden"" name=""ihaleID"" value=""" & ihaleID & """ />"
Response.Write "<input type=""hidden"" name=""tablo"" value=""girilmeyecek_aciklama"" />"

	Response.Write "<div class=""container-fluid row"">"
		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<label class=""badge"">Açıklama</label>"
		Response.Write "<textarea class=""form-control"" name=""deger"" rows=""5"" id=""aciklama"">" & aciklama & "</textarea>"
		Response.Write "</div>"



		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<button type=""submit"" class=""btn form-control btn-success"" onClick=""modalkapat();"">Kaydet</button>"
			call clearfix()
		Response.Write "</div>"
	Response.Write "</div>"
Response.Write "</form>"


%>

