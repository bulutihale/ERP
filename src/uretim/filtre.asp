<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    modulAd 		=   "satis"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	yetkiKontrol	 = yetkibul(modulAd)

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"

	Response.Write "<div class=""card rounded-top"">"
		Response.Write "<div class=""card-header h5"">Fitreler</div>"
	
		Response.Write "<div class=""card-body"">"
			Response.Write "<form action=""/uretim/uretilenListe.asp"" method=""post"" id=""filtreForm"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-6"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Sipariş No</div>"
					call forminput("siparisNo","","","Sipariş No","","autocompleteOFF","siparisNo","")
				Response.Write "</div>"
			Response.Write "</div>"
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
			
			Response.Write "<div class=""row mt-2"">"
				Response.Write "<div class=""col-lg-6"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Üretim Başlangıç Tarih Aralığı</div>"
					Response.Write "<div class=""border border-dark rounded p-2"">"
						Response.Write "<div class=""col-lg-12"">"
							Response.Write "<div class=""badge badge-secondary rounded-left"">İlk Tarih</div>"
							call forminput("t1",date()-60,"","İlk Tarihi","tarih","autocompleteOFF","t1","")
						Response.Write "</div>"
						Response.Write "<div class=""col-lg-12 "">"
							Response.Write "<div class=""badge badge-secondary rounded-left"">Bitiş Tarih</div>"
							call forminput("t2",date(),"","Son Tarih","tarih","autocompleteOFF","t2","")
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
				
				Response.Write "<div class=""col-lg-6"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Üretim Bitiş Tarih Aralığı</div>"
					Response.Write "<div class=""border border-dark rounded p-2"">"
						Response.Write "<div class=""col-lg-12"">"
							Response.Write "<div class=""badge badge-secondary rounded-left"">İlk Tarih</div>"
							call forminput("t3","","","İlk Tarihi","tarih","autocompleteOFF","t4","")
						Response.Write "</div>"
						Response.Write "<div class=""col-lg-12 "">"
							Response.Write "<div class=""badge badge-secondary rounded-left"">Bitiş Tarih</div>"
							call forminput("t4","","","Son Tarih","tarih","autocompleteOFF","t4","")
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
				
			Response.Write "</div>"
			
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-lg-2 col-sm-6 mt-4"">"
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








