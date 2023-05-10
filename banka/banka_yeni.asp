<!--#include virtual="/reg/rs.asp" --><%


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
	Response.Flush()
	call logla("Yeni Banka Bilgisi Ekleme Ekranı Girişi")
	yetkiKontrol = yetkibul("Teklif")
'###### ANA TANIMLAMALAR


	if gorevID <> "" then
		sorgu = "SELECT" & vbcrlf
		sorgu = sorgu & "portal.bankalar.*" & vbcrlf
		sorgu = sorgu & "from portal.bankalar" & vbcrlf
		sorgu = sorgu & "where portal.bankalar.bankalarID = " & gorevID & vbcrlf
		rs.open sorgu, sbsv5, 1, 3
			firmaIDbanka		=  	rs("firmaID")
			bankaID				=  	rs("bankalarID")
			bankaAd				=  	rs("bankaAd")
			hesapAd				=	rs("hesapAd")
			paraBirim			=	rs("paraBirim")
			subeAd				=	rs("subeAd")
			subeNo				=	rs("subeNo")
			hesapNo				=	rs("hesapNo")
			iban				=	rs("iban")
			swiftKod			=	rs("swiftKod")
			silindi				=	rs("silindi")
			defDeger			=	paraBirimID & "###" & paraBirim
		rs.close		
	end if



        '############# firmalar
            sorgu = "Select Ad,Id from portal.firma where portal.firma.Id = " & firmaID & " or portal.firma.anaFirmaID = " & firmaID & vbcrlf
            sorgu = sorgu & "order by Ad ASC" & vbcrlf
            rs.open sorgu,sbsv5,1,3
            ' if rs.recordcount > 0 then
                    degerler = ""
                    do while not rs.eof
                        degerler = degerler & rs("Ad")
                        degerler = degerler & "="
                        degerler = degerler & rs("Id")
                        degerler = degerler & "|"
                    rs.movenext
                    loop
                    firmaDegerler = left(degerler,len(degerler)-1)
            ' end if
            rs.close
        '############# firmalar



        '############# paraBirim
            sorgu = "Select birimID,uzunBirim from portal.birimler where portal.birimler.birimGrup = 'para' and portal.birimler.firmaID = " & firmaID & vbcrlf
            sorgu = sorgu & "order by sira ASC" & vbcrlf
            rs.open sorgu,sbsv5,1,3
            ' if rs.recordcount > 0 then
                    degerler = ""
                    do while not rs.eof
                        degerler = degerler & rs("uzunBirim")
                        degerler = degerler & "="
                        degerler = degerler & rs("uzunBirim")
                        degerler = degerler & "|"
                    rs.movenext
                    loop
                    paraBirimDegerler = left(degerler,len(degerler)-1)
            ' end if
            rs.close
        '############# paraBirim






	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""text-right""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/banka/banka_ekle.asp"" method=""post"" class=""ajaxform"">"
			call formhidden("bankaID",gorevID,"","","","autocompleteOFF","bankaID","")




		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
                Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Firma Adı","","") & "</span>"
				call formselectv2("firmaIDbanka",firmaIDbanka,"","","","","firmaIDbanka",firmaDegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"


		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Hesap Adı","","") & "</span>"
				call forminput("hesapAd",hesapAd,"","","","autocompleteOFF","hesapAd","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Banka Adı","","") & "</span>"
				call forminput("bankaAd",bankaAd,"","","","autocompleteOFF","bankaAd","")
			Response.Write "</div>"
		Response.Write "</div>"


		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
                Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Hesap Döviz Türü","","") & "</span>"
				call formselectv2("paraBirim",paraBirim,"","","","","paraBirim",paraBirimDegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"



		' Response.Write "<div class=""row"">"
		' 	Response.Write "<div class=""col-sm-6 my-1"">"
		' 		Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Hesap Döviz Türü","","") & "</span>"
		' 		call formselectv2("paraBirim",paraBirim,"","","formSelect2 border","","paraBirim","","data-holderyazi=""" & translate("Hesap Döviz Türü","","") & """ data-jsondosya=""JSON_paraBirimler"" data-miniput=""0"" data-defdeger=""" & defDeger & """")
		' 	Response.Write "</div>"
		' Response.Write "</div>"




		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Şube Adı","","") & "</span>"
				call forminput("subeAd",subeAd,"","","","autocompleteOFF","subeAd","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-2 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Şube No","","") & "</span>"
				call forminput("subeNo",subeNo,"","","","autocompleteOFF","subeNo","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Hesap No","","") & "</span>"
				call forminput("hesapNo",hesapNo,"","","","autocompleteOFF","hesapNo","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("SWIFT Kodu","","") & "</span>"
				call forminput("swiftKod",swiftKod,"","","","autocompleteOFF","swiftKod","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("IBAN","","") & "</span>"
				call forminput("iban",iban,"","","","autocompleteOFF","iban","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Kullanım Dışı","","") & "</span>"
				call formselectv2("silindi",int(silindi),"","","silindi","","silindi",HEDegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-auto mt-4""><button type=""submit"" class=""btn btn-primary"">" & translate("Kaydet","","") & "</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if






%><!--#include virtual="/reg/rs.asp" -->




