<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
	talep	=	Request.QueryString("talep")
	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modulAd =   "Satın Alma"
    modulID =   "88"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


'############ talepten siparişleştirme mi yapılıyor?
	if talep = "evet" then
		talepSipKalemID	=	Request.QueryString("siparisKalemID")
		sorgu = "SELECT t1.stokID, t1.miktar, t1.mikBirimID, t2.stokAd, t1.mikBirim"
		sorgu = sorgu & " FROM teklif.siparisKalem t1"
		sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID AND t1.firmaID = " & firmaID & ""
		sorgu = sorgu & " WHERE t1.id = " & talepSipKalemID
		rs.open sorgu, sbsv5, 1, 3
			stokID		=	rs("stokID")
			stokID64	=	stokID
			stokID64	=	base64_encode_tr(stokID64)
			stokAd		=	rs("stokAd")
			miktar		=	rs("miktar")
			mikBirimID	=	rs("mikBirimID")
			mikBirim	=	rs("mikBirim")

		rs.close
		call logla("Satınalma Talebinden Sipariş Oluştur: id:" & talepSipKalemID)

	else
	call logla("Satınalma Temp Sipariş Oluşturma Ekranı")
	talepSipKalemID	= 0
	end if
'############ talepten siparişleştirme mi yapılıyor?


yetkiKontrol = yetkibul(modulAd)


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
					Response.Write "<div class=""card-header"">"
						Response.Write "<div class=""col-12 h4 text-left"">Satın Alma Siparişi Oluşturma</div>"
					Response.Write "</div>"
					Response.Write "<form action=""/satinAlma/siparis_kalem_ekle.asp"" method=""post"" id=""siparisform"">"
					Response.Write "<div class=""card-body"">"

						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-lg-6 col-sm-12 col-md-12 border border-dark rounded mt-2"">" 
								Response.Write "<div class=""row mt-2"">"
									Response.Write "<div id=""divCariSec"" class=""col-lg-9 col-md-6 col-sm-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Sipariş Verilen Cari Seçimi</div>"
										call formselectv2("cariSec","","$('#siparislistesi').load('/satinalma/siparis_kalem_ekle.asp?islem=kontrol&siphash='+this.value);","","formSelect2 cariSec inpReset","","cariSec","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3""")
									Response.Write "</div>"
									Response.Write "<div class=""col-lg-3 col-md-6 col-sm-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Sipariş Tarihi</div>"
										call forminput("siparisTarih",date(),"","Sipariş tarihi","tarih","autocompleteOFF","siparisTarih","")
									Response.Write "</div>"
								Response.Write "</div>"

								Response.Write "<div class=""row mt-2 mb-2"">"
									Response.Write "<div id=""divCariSec"" class=""col-lg-9 col-md-6 col-sm-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Ürün Seçimi</div>" 
										Response.Write "<div class=""badge badge-warning rounded pointer"" onclick=""stokKartAc($('#stokSec').attr('data-secilenstokid'));"">Stok Kartı</div>"
										if talep = "evet" then
											call formhidden("talepSipKalemID",talepSipKalemID,"","talepSipKalemID","","","talepSipKalemID","") 
											call forminput("stokAd",stokAd,"","stokAd","","","stokAd","readonly")
											Response.Write "<input type=""hidden"" id=""stokSec"" name=""stokSec"" class=""form-control"" value="""&stokID&""" data-secilenstokid="""&stokID64&""">"
										else
				'//NOTE - anaBirimKontrol kod örneği 
										call formselectv2("stokSec","","anaBirimKontrol($(this).val(),$(this).attr('id'))","","formSelect2 stokSec border inpReset","","stokSec","","data-holderyazi=""Ürün adı, stok kodu, barkod"" data-jsondosya=""JSON_stoklar"" data-miniput=""3""")
										end if
									Response.Write "</div>"
									Response.Write "<div class=""col-lg-3 col-md-6 col-sm-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Ürün notları</div>"
										call forminput("kalemNot","","","Ürün için açıklama","inpReset","autocompleteOFF","kalemNot","")
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
										if talep = "evet" then
											call forminput("birimSec",mikBirim,"","birimSec","","","birimSec","readonly")
										else
											call formselectv2("birimSec","","","","formSelect2 birimSec border inpReset anaBirimFiltre","","birimSec","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0""")
										end if
									Response.Write "</div>"
								Response.Write "</div>"
								Response.Write "<div class=""row mt-2 mb-2"">"
									Response.Write "<div class=""col-lg-6 col-sm-12 col-md-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Fiyat</div>"
										call forminput("birimfiyat",birimfiyat,"numara(this,true,false)","Birim Fiyat","inpReset","","birimfiyat","")
									Response.Write "</div>"
									Response.Write "<div class=""col-lg-6 col-sm-12 col-md-6"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Para Birim</div>"
										call formselectv2("pBirimSec","","","","formSelect2 pBirimSec border inpReset","","pBirimSec","","data-holderyazi=""Para Birim"" data-jsondosya=""JSON_paraBirimler"" data-miniput=""0""")
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
 	Response.Write "$('#siparisform').ajaxForm({target:'#siparislistesi'});" 
 Response.Write "});"
 Response.Write "</scr" & "ipt>"




%>
<!--#include virtual="/reg/rs.asp" -->

