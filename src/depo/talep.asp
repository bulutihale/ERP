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
    modulAd =   "Lojistik"
    modulID =   "88"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Depo Transfer Talebi Oluşturma Ekranı")

yetkiKontrol = yetkibul(modulAd)


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiKontrol >= 5 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
					Response.Write "<div class=""card-header"">"
						Response.Write "<div class=""col-12 h4 text-left"">Depo Transfer Talebi Oluşturma</div>"
					Response.Write "</div>"
					Response.Write "<form action=""/depo/talep_kalem_ekle.asp"" method=""post"" id=""siparisform"">"
					Response.Write "<div class=""card-body"">"

						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-lg-6 col-sm-12 col-md-12 border border-dark rounded mt-2"">" 
								Response.Write "<div class=""row mt-2"">"

									Response.Write "<div id=""divCariSec"" class=""col-lg-9 col-md-6 col-sm-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Ürün Seçimi</div>" 
										Response.Write "<div class=""badge badge-warning rounded pointer"" onclick=""stokKartAc($('#stokSec').attr('data-secilenstokid'));"">Stok Kartı</div>"
				'//NOTE - anaBirimKontrol kod örneği 
										call formselectv2("stokSec","","anaBirimKontrol($(this).val(),$(this).attr('id'));","","formSelect2 stokSec border inpReset","","stokSec","","data-holderyazi=""Ürün adı, stok kodu, barkod"" data-jsondosya=""JSON_stoklar"" data-miniput=""3""")
									Response.Write "</div>"

									Response.Write "<div class=""col-lg-3 col-md-6 col-sm-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Talep Tarihi</div>"
										call forminput("siparisTarih",date(),"","Talep tarihi","","autocompleteOFF","siparisTarih","readonly")
									Response.Write "</div>"
								Response.Write "</div>"

								Response.Write "<div class=""row mt-2 mb-2"">"
									Response.Write "<div class=""col-9"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Talep Eden Depo Seçimi</div>"
										call formselectv2("talepEdenDepoID","","","","formSelect2 depoSec border","","talepEdenDepoID","","data-holderyazi=""Talep eden depo seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0""")
									Response.Write "</div>"
								Response.Write "</div>"
							Response.Write "</div>"

							Response.Write "<div class=""col-lg-6 col-sm-12 col-md-12 border border-dark rounded mt-2"">"
								Response.Write "<div class=""row mt-2"">"
									Response.Write "<div class=""col-lg-6 col-sm-12 col-md-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Miktar</div>"
										Response.Write "<div class=""badge badge-warning rounded pointer"" onclick=""anaBirimMiktarHesap('miktar',$('#stokSec').val())"">Hesap</div>"
										call forminput("miktar",miktar,"numara(this,true,false)","miktar","inpReset","","miktar","")
									Response.Write "</div>"
									Response.Write "<div class=""col-lg-6 col-sm-12 col-md-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Birim</div>"
										call formselectv2("birimSec","","","","formSelect2 birimSec border inpReset anaBirimFiltre","","birimSec","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0""")
										'call formselectv2("birimSec","","","","formSelect2 birimSec border inpReset ","","birimSec","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-sartOzel=""t1.uzunBirim='Adet'""")
									Response.Write "</div>"
								Response.Write "</div>"
								Response.Write "<div class=""row mt-2 mb-2"">"
									Response.Write "<div class=""col-lg-12 col-md-6 col-sm-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Ürün notları</div>"
										call forminput("kalemNot","","","Ürün için açıklama","inpReset","autocompleteOFF","kalemNot","")
									Response.Write "</div>"
								Response.Write "</div>"
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-lg-12 col-sm-12 col-md-12 mt-4 text-center"">"
								Response.Write "<div class=""col-12""><button type=""submit"" class=""btn btn-primary col-lg-6 col-md-12 col-sm-12"">KAYDET</button></div>"
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
Response.Write "$('#siparislistesi').load('/depo/talep_kalem_ekle.asp?islem=kontrol&siphash=0');"
Response.Write "$('#siparisform').ajaxForm({target:'#siparislistesi'});"
Response.Write "});"
Response.Write "</scr" & "ipt>"




%>
<!--#include virtual="/reg/rs.asp" -->