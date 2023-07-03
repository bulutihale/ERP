<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modulAd =   "Stok"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Stok Listesi Ekranı")

yetkiKontrol = yetkibul(modulAd)


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
					Response.Write "<div class=""row"">"
						Response.Write "<div class=""col-12 h4 text-center"">Cari Stok Ref Eşleştirme</div>"
					Response.Write "</div>"
					Response.Write "<form action=""/stok/stok_ref_ekle.asp"" method=""post"" class=""ajaxform"">"
					Response.Write "<div class=""card-body"">"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-6"">"
								Response.Write "<label for="""" class=""fontkucuk2 font-weight-bold m-0 p-0"">Ürün Seçimi:</label>"
								call formselectv2("stokSec","","$('#divStokRef').load('/stok/stok_ref_liste.asp',{stokID:$(this).val(), cariID:$('#cariSec').val()});","","formSelect2 stokSec border","","stokSec","","data-holderyazi=""Ürün adı, stok kodu, barkod"" data-jsondosya=""JSON_stoklar"" data-miniput=""3""")
							Response.Write "</div>"
							Response.Write "<div class=""col-6"">"
								Response.Write "<label for="""" class=""fontkucuk2 font-weight-bold m-0 p-0"">Cari Seçimi:</label>"
								call formselectv2("cariSec","","$('#divStokRef').load('/stok/stok_ref_liste.asp',{stokID:$('#stokSec').val(), cariID:$(this).val()});","","formSelect2 cariSec border","","cariSec","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3""")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-2"">"
								Response.Write "<label for="""" class=""fontkucuk2 font-weight-bold m-0 p-0"">Carideki Stok Ref:</label>"
								call forminput("cariUrunRef",cariUrunRef,"","Ürünümüzün müşterideki stok kodu","","","cariUrunRef","")
							Response.Write "</div>"
							Response.Write "<div class=""col-2"">"
								Response.Write "<label for="""" class=""fontkucuk2 font-weight-bold m-0 p-0"">Cari için fiyat:</label>"
								call forminput("cariUrunFiyat",cariUrunFiyat,"","Fiyat","","","cariUrunFiyat","")
							Response.Write "</div>"
							Response.Write "<div class=""col-2"">"
								Response.Write "<label for="""" class=""fontkucuk2 font-weight-bold m-0 p-0"">Para Birimi:</label>"
		 		call formselectv2("paraBirim",paraBirim,"","","formSelect2 border","","paraBirim","","data-holderyazi=""Para Birimi"" data-jsondosya=""JSON_paraBirimler"" data-miniput=""0"" data-defdeger=""" & defDeger & """")
							Response.Write "</div>"
							Response.Write "<div class=""col-6"">"
								Response.Write "<label for="""" class=""fontkucuk2 font-weight-bold m-0 p-0"">Carideki Stok Adı:</label>"
								call forminput("cariUrunAd",cariUrunAd,"","Ürümüzün müşterideki stok adı","","","cariUrunAd","")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
							Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</form>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		
						Response.Write "<div id=""divStokRef""></div>"
		
		Response.Write "</div>"

	end if
'###### ARAMA FORMU
'###### ARAMA FORMU








%>


