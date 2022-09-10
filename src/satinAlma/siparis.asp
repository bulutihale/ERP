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
    modulAd =   "Satın Alma"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Satınalma Temp Sipariş Oluşturma Ekranı")

yetkiKontrol = yetkibul(modulAd)


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
					Response.Write "<div class=""card-header"">"
						Response.Write "<div class=""col-12 h4 text-left"">Satın Alma Siparişi</div>"
					Response.Write "</div>"
					Response.Write "<form action=""/satinAlma/siparis_kalem_ekle.asp"" method=""post"" id=""siparisform"">"
					Response.Write "<div class=""card-body pt-0"">"
											
						Response.Write "<div class=""row"">"
							Response.Write "<div id=""divCariSec"" class=""col-6"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Cari Seçimi</div>"
								call formselectv2("cariSec","","$('#siparislistesi').load('/satinalma/siparis_kalem_ekle.asp?islem=kontrol&siphash='+this.value);","","formSelect2 cariSec","","cariSec","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3""")
							Response.Write "</div>"
							Response.Write "<div class=""col-1"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Sipariş Tarihi</div>"
								call forminput("siparisTarih",date(),"","Sipariş tarihi","tarih","autocompleteOFF","siparisTarih","")
							Response.Write "</div>"
						Response.Write "</div>"
						
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div id=""divCariSec"" class=""col-6"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Ürün Seçimi</div>"
								call formselectv2("stokSec","","","","formSelect2 stokSec border inpReset","","stokSec","","data-holderyazi=""Ürün adı, stok kodu, barkod"" data-jsondosya=""JSON_stoklar"" data-miniput=""3""")
							Response.Write "</div>"
							Response.Write "<div class=""col-5"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Ürün notları</div>"
								call forminput("kalemNot","","","Ürün için açıklama","inpReset","autocompleteOFF","kalemNot","")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-1"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Miktar</div>"
								call forminput("miktar",miktar,"numara(this,true,false)","miktar","inpReset","","miktar","")
							Response.Write "</div>"
							Response.Write "<div class=""col-2"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Birim</div>"
								call formselectv2("birimSec","","","","formSelect2 birimSec border inpReset","","birimSec","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0""")
							Response.Write "</div>"
							Response.Write "<div class=""col-1"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Fiyat</div>"
								call forminput("birimfiyat",birimfiyat,"numara(this,true,false)","Birim Fiyat","inpReset","","birimfiyat","")
							Response.Write "</div>"
							Response.Write "<div class=""col-1"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Para Birim</div>"
								call formselectv2("pBirimSec","","","","formSelect2 pBirimSec border inpReset","","pBirimSec","","data-holderyazi=""Para Birim"" data-jsondosya=""JSON_paraBirimler"" data-miniput=""0""")
							Response.Write "</div>"
						Response.Write "</div>"
						
						
						
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-2 mt-4"">"
								Response.Write "<button type=""submit"" class=""btn btn-primary form-control"">EKLE</button>"
							Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</form>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		

		
	Response.Write "</div>"
		
	else
		call yetkisizGiris("","","")
	end if

            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-body"">"
						Response.Write "<div id=""siparislistesi""></div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"






'ekli ürün listesi

Response.Write "<scr" & "ipt>"
Response.Write "$(document).ready(function() {"
Response.Write "$('#siparisform').ajaxForm({target:'#siparislistesi'});"
Response.Write "});"
Response.Write "</scr" & "ipt>"




%>
<!--#include virtual="/reg/rs.asp" -->