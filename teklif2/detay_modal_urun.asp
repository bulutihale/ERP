<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	id						=	Request.QueryString("id")
	ihaleID					=	Request.QueryString("ihaleID")
	ihaleID64				=	ihaleID
	ihaleID64				=	base64_encode_tr(ihaleID64)
	stoklarID				=	Request.QueryString("stoklarID")
	urunsec					=	stoklarID
	stokSart				=	Request.QueryString("stokSart")



'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"Dosya Detay"
'##### YETKİ BUL
'##### YETKİ BUL



Response.Write "<button type=""button"" class=""close"" aria-label=""Close"">"
Response.Write "<span aria-hidden=""true"" onClick=""modalkapat();"">&times;</span>"
Response.Write "</button>"



'Response.Write "<form action=""/teklif2/hucre_kaydet.asp"" method=""post"" class=""ajaxform"">"
Response.Write "<input type=""hidden"" name=""alan"" value=""stoklarID"" />"
Response.Write "<input type=""hidden"" name=""tabloID"" value=""" & id & """ />"
Response.Write "<input type=""hidden"" name=""ihaleID"" value=""" & ihaleID & """ />"
Response.Write "<input type=""hidden"" name=""tablo"" value=""ihale_urun"" />"

	Response.Write "<div class=""container-fluid row"">"
		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<label class=""badge"">Ürün Seçimi</label>"
			call formselectv2("deger","","","","formSelect2 deger","","deger","","data-holderyazi=""Stok adı, stok kodu"" data-sart="""&stokSart&""" data-jsondosya=""JSON_stoklar"" data-miniput=""3""")
		Response.Write "</div>"

		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<button type="""" class=""btn form-control btn-success"" onClick=""ajSave('stoklarID','teklifv2.ihale_urun',"&id&",$('#deger').val())"">Değiştir</button>"
			call clearfix()
		Response.Write "</div>"
	Response.Write "</div>"
'Response.Write "</form>"


%>

