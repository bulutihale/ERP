<!--#include virtual="/reg/rs.asp" --><%


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


call logla("Yeni Banka Bilgisi Ekleme Ekranı Girişi")

yetkiKontrol = yetkibul(modulAd)


	if gorevID <> "" then
		sorgu = "SELECT t1.bankaID, t1.bankaAd, t1.paraBirimID, t1.subeAd, t1.subeNo, t1.hesapNo, t1.iban, t1.silindi, t2.kisaBirim as paraBirim, t1.swiftKod"
		sorgu = sorgu & " FROM portal.bankalar t1"
		sorgu = sorgu & " LEFT JOIN portal.birimler t2 ON t1.paraBirimID = t2.birimlerID"
		sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.bankalar = " & gorevID
		rs.open sorgu, sbsv5, 1, 3
			bankaID				=  	rs("bankaID")
			bankaAd				=  	rs("bankaAd")
			paraBirimID			=	rs("paraBirimID")
			paraBirim			=	rs("paraBirim")
			subeAd				=	rs("subeAd")
			subeNo				=	rs("subeNo")
			hesapNo				=	rs("hesapNo")
			iban				=	rs("iban")
			swiftKod			=	rs("swiftKod")
			silindi				=	rs("silindi")
			defDeger			=	paraBirimID&"###"&paraBirim
			
		rs.close		
	end if



	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""text-right""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/banka/banka_ekle.asp"" method=""post"" class=""ajaxform"">"
			call formhidden("bankaID",gorevID,"","","","autocompleteOFF","bankaID","")
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Banka Adı</span>"
				call forminput("bankaAd",bankaAd,"","","","autocompleteOFF","bankaAd","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Hesap Döviz Türü</span>"
				call formselectv2("paraBirim",paraBirim,"","","formSelect2 border","","paraBirim","","data-holderyazi=""Hesap Döviz Türü"" data-jsondosya=""JSON_paraBirimler"" data-miniput=""0"" data-defdeger="""&defDeger&"""")
			Response.Write "</div>"
		Response.Write "</div>"
		
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Şube Adı</span>"
				call forminput("subeAd",subeAd,"","","","autocompleteOFF","subeAd","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-2 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Şube No</span>"
				call forminput("subeNo",subeNo,"","","","autocompleteOFF","subeNo","")
			Response.Write "</div>"
		Response.Write "</div>"
		
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Hesap No</span>"
				call forminput("hesapNo",hesapNo,"","","","autocompleteOFF","hesapNo","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">SWIFT Kodu</span>"
				call forminput("swiftKod",swiftKod,"","","","autocompleteOFF","swiftKod","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">IBAN</span>"
				call forminput("iban",iban,"","","","autocompleteOFF","iban","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Kullanım Dışı</span>"
				call formselectv2("silindi",int(silindi),"","","silindi","","silindi",HEDegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"


		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-auto mt-4""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if






%><!--#include virtual="/reg/rs.asp" -->




