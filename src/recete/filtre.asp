<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    modulAd =   "Reçete"
    modulID =   "97"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	yetkiKontrol	 = yetkibul(modulAd)

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU

		Response.Write "<div class=""row rounded justify-content-between card-header p-0 border-secondary mb-2"">"
			Response.Write "<div class=""h5 p-2"">Filtreler</div>"
			Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "</div>"

	Response.Write "<div class=""card rounded-top"">"
	
		Response.Write "<div class=""card-body"">"
			Response.Write "<form action=""/recete/recete_liste.asp"" method=""post"" id=""filtreForm"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-12 mt-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Cari Seçimi</div>"
					call formselectv2("cariID","","","","formSelect2 cariID","","cariID","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3""")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-12 mt-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Stok Seçimi</div>"
					call formselectv2("stokID","","","","formSelect2 stokID","","stokID","","data-holderyazi=""Stok adı, stok kodu"" data-jsondosya=""JSON_stoklar"" data-miniput=""3""")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-2 mt-4"">"
					Response.Write "<button type=""submit"" class=""btn btn-primary form-control"">FİLTRE</button>"
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "</form>"
		Response.Write "</div>"'card-body
	Response.Write "</div>"'card
	



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU


Response.Write "<scr" & "ipt>"
Response.Write "$(document).ready(function() {"
Response.Write "$('#filtreForm').ajaxForm({target:'#ortaalan'});"
Response.Write "});"
Response.Write "</scr" & "ipt>"




%>








