<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	'ID			=	Request.QueryString("ID")
	'kid64		=	ID
	'opener  	=   Request.Form("opener")
    hata    	=   ""
    modulAd 	=   "Admin"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



yetkiKontrol = yetkibul(modulAd)




	if hata = "" and yetkiKontrol > 0 then


		Response.Write "<div class=""card-deck"">"
			Response.Write "<div class=""col-4"">"
				Response.Write "<div class=""card"" id=""DIV1"">"
					Response.Write "<div class=""card-body"">"
					Response.Write "<h5 class=""card-title"">Ürün Bazlı Maliyet Hesaplama</h5>"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div id=""divUrunSec"" class=""col-12"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Ürün Seçimi</div>"
								call formselectv2("stokSec","","","","formSelect2 stokSec","","stokSec","","data-holderyazi=""Ürün adı, stok kodu, barkod"" data-jsondosya=""JSON_stoklar"" data-miniput=""3""")
							Response.Write "</div>"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div class=""btn btn-info mt-4"" onclick=""modalajaxfit('/satis/recete_maliyet.asp?tumReceteGoster=evet&siparisKalemID=0&cariID=0&stokID='+$('#stokSec').val())"">maliyet hesapla</div>"
							Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""card"" id=""DIV2"">"
				Response.Write "<div class=""card-body"">"
				Response.Write "<h5 class=""card-title"">Fiyat Tarihçe</h5>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
	end if


%>

<script>
</script>