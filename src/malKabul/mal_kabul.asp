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
    modulID =   "89"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Mal Kabul Ekranı Giriş")

yetkiKontrol = yetkibul(modulAd)



'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
					Response.Write "<div class=""card-header"">"
						Response.Write "<div class=""col-12 h4 text-center"">Mal Kabul</div>"
					Response.Write "</div>"
					Response.Write "<form action=""/malKabul/mal_kabul_urun_kayit.asp"" method=""post"" class=""ajaxform"">"
						Response.Write "<input id=""inpStokKodu"" class=""inpReset"" name=""stokKodu"" type=""hidden"">"
						Response.Write "<input id=""inpSipKalemID"" class=""inpReset"" name=""siparisKalemID"" type=""hidden"">"
						Response.Write "<input id=""inpstokID"" class=""inpReset"" name=""stokID"" type=""hidden"">"
						Response.Write "<input id=""inpMiktar"" class=""inpReset"" name=""sipMiktar"" type=""hidden"">"
						Response.Write "<input id=""inpTeslimEdilen"" class=""inpReset"" name=""teslimEdilen"" type=""hidden"">"
					Response.Write "<div class=""card-body"">"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-lg-4 col-sm-3 col-md-3"">"
								Response.Write "<span for="""" class=""badge badge-secondary rounded-left"">Cari Seçimi:</span>"
								call formselectv2("cariSec","","$('#divsipListe').load('/malKabul/mal_kabul_siparis_liste.asp',{cariID:$(this).val()});","","formSelect2 cariSec border","","cariSec","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3""")
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-6"">"
								Response.Write "<span for="""" class=""badge badge-secondary rounded-left"">Belge Tarihi:</span>"
								call forminput("belgeTarih",belgeTarih,"","Belge Tarihi","tarih","autocompleteOFF","belgeTarih","")
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-2 col-sm-6"">"
								Response.Write "<span for="""" class=""badge badge-secondary rounded-left"">Belge Numarası:</span>"
								call forminput("belgeNo",belgeNo,"","Belge No","","autocompleteOFF","belgeNo","")
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-6"">"
								Response.Write "<span for="""" class=""badge badge-secondary rounded-left"">Giriş Tarihi:</span>"
								call forminput("girisTarih",date(),"","Geliş tarihi","tarih","autocompleteOFF","girisTarih","")
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-4 col-sm-6"">"
								Response.Write "<span for="""" class=""badge badge-secondary rounded-left"">Giriş Depo Seçimi:</span>"
								call formselectv2("depoSec","","","","formSelect2 depoSec border","","depoSec","","data-holderyazi=""Giriş depo seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-sart=""malKabulizin""")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row"">"
							Response.Write "<div id=""divsipListe"" class=""col-12"">"
							Response.Write "</div>"	
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</form>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
					Response.Write "<div class=""row"">"
						Response.Write "<div id=""divStokRef""></div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		
		Response.Write "</div>"

	end if
'###### ARAMA FORMU
'###### ARAMA FORMU








%>











