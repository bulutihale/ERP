<!--#include virtual="/reg/rs.asp" --><%
bu dosya teklif2 klasörünün altına gitsin

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=	Request.Form("opener")
    gorevID 	=	Request.QueryString("gorevID")
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "Teklif"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Firma Bilgisi Düzenleme Ekranı Girişi")

yetkiKontrol = yetkibul(modulAd)


	if gorevID <> "" then
		sorgu = "SELECT t1.id as firmaID, t1.ad as firmaAd, t1.adres, t1.telefon, t1.faksNo, t1.vergiNo, t1.vergiDairesi, t1.sehir, t1.ilce, t1.webSite, t1.iletisimEposta"
		sorgu = sorgu & " FROM portal.firma t1"
		sorgu = sorgu & " WHERE t1.id = " & firmaID & " AND t1.id = " & gorevID
		rs.open sorgu, sbsv5, 1, 3
			firmaID				=  	rs("firmaID")
			firmaAd				=  	rs("firmaAd")
			adres				=	rs("adres")
			telefon				=	rs("telefon")
			faksNo				=	rs("faksNo")
			vergiNo				=	rs("vergiNo")
			vergiDairesi		=	rs("vergiDairesi")
			sehir				=	rs("sehir")
			ilce				=	rs("ilce")
			webSite				=	rs("webSite")
			iletisimEposta		=	rs("iletisimEposta")
			
		rs.close		
	end if



	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""text-right""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/firma/firma_ekle.asp"" method=""post"" class=""ajaxform"">"
			call formhidden("firmaID",gorevID,"","","","autocompleteOFF","firmaID","")
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Firma Adı</span>"
				call forminput("firmaAd",firmaAd,"","","","autocompleteOFF","firmaAd","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Adres</span>"
				call forminput("adres",adres,"","","","autocompleteOFF","adres","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Telefon</span>"
				call forminput("telefon",telefon,"","","","autocompleteOFF","telefon","")
			Response.Write "</div>"
		Response.Write "</div>"
		
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Faks No</span>"
				call forminput("faksNo",faksNo,"","","","autocompleteOFF","faksNo","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-2 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Vergi No</span>"
				call forminput("vergiNo",vergiNo,"","","","autocompleteOFF","vergiNo","")
			Response.Write "</div>"
		Response.Write "</div>"
		
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Vergi Dairesi</span>"
				call forminput("vergiDairesi",vergiDairesi,"","","","autocompleteOFF","vergiDairesi","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">ŞEHİR</span>"
				call forminput("sehir",sehir,"","","","autocompleteOFF","sehir","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">İLÇE</span>"
				call forminput("ilce",ilce,"","","","autocompleteOFF","ilce","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Web</span>"
				call forminput("webSite",webSite,"","","","autocompleteOFF","webSite","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">E-posta</span>"
				call forminput("iletisimEposta",iletisimEposta,"","","","autocompleteOFF","iletisimEposta","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-auto mt-4""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if






%><!--#include virtual="/reg/rs.asp" -->




