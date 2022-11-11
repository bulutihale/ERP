<!--#include virtual="/reg/rs.asp" --><%


' firmatipi = cariTur
' iskonto = sil
' ilce = sil
' il = sehir


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    kid64		=	ID
    gorevID 	=   Request.QueryString("gorevID")
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "cari"
	cariTurArr	=	"Son Kullanıcı=3|Bayi=2|Tedarikçi=8"
	Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


	yetkiTeklif	    = yetkibul("Teklif")
	yetkiSatis  	= yetkibul("Satış")


if gorevID <> "" then
	sorgu = "Select top 1 * from cari.cari where firmaID = " & firmaID & " AND cariID = " & gorevID
	rs.open sorgu, sbsv5, 1, 3
		cariKodu			=	rs("cariKodu")'
		cariAd				=	rs("cariAd")'
		unvan				=	rs("unvan")'
		vergiDairesi		=	rs("vergiDairesi")'
		vergiNo				=	rs("vergiNo")'
		il					=	rs("il")
		cariTur				=	rs("cariTur")
		manuelKayit			=	rs("manuelKayit")
		telefon				=	rs("telefon")
		fax					=	rs("fax")
		iskonto				=	rs("iskonto")
		adres				=	rs("adres")
		postakodu			=	rs("postakodu")
		email				=	rs("email")
		ilce				=	rs("ilce")
		silindi				=	rs("silindi")
	rs.close
end if


manuelKayit = True


if cariKodu = "" then
	call logla("Cari Düzenleme Ekranı Girişi")
else
	call logla("Cari Düzenleme Ekranı : " & cariAd)
end if


'### sehirArr
'### sehirArr
	if hata = "" then
		sorgu = "Select ilID,sehiradi from portal.iller order by sehiradi ASC"
		rs.open sorgu,sbsv5,1,3
			sehirArr = "=|"
			do while not rs.eof
				sehirArr = sehirArr & rs("sehiradi")
				sehirArr = sehirArr & "="
				sehirArr = sehirArr & rs("ilID")
				sehirArr = sehirArr & "|"
				if rs("sehiradi") = il then
					sehir = rs("ilID")
				end if
			rs.movenext
			loop
			sehirArr = left(sehirArr,len(sehirArr)-1)
		rs.close
	end if
'### sehirArr
'### sehirArr





'###### ARAMA FORMU
'###### ARAMA FORMU
	if yetkiTeklif >= 3 or yetkiSatis > 1 then
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/cari/cari_ekle.asp"" method=""post"" class=""ajaxform"">"
		Response.Write "<input type=""hidden"" name=""gorevID"" value=""" & gorevID & """ />"

			if manuelKayit = False then
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs mb-4 text-center h3 text-danger"">"
						Response.Write "Bu kayıt muhasebe programı ile senkronizedir.<br />Buradan güncellenemez"
					Response.Write "</div>"
				Response.Write "</div>"
			end if


			Response.Write "<div class=""row mt-2"">"
				'## Cari Kodu
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Cari Kod","","") & "</div>"
					if manuelKayit = False then
						call forminput("cariKodu",cariKodu,"","","","readonly","cariKodu","")
					else
						call forminput("cariKodu",cariKodu,"","","","autocompleteOFF","cariKodu","")
					end if
				Response.Write "</div>"
				'## Cari Kodu
				'## Cari Ad
				Response.Write "<div class=""col-lg-8 col-md-8 col-sm-8 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-danger"">" & translate("Cari Ad","","") & "</div>"
					if manuelKayit = False then
						call forminput("cariAd",cariAd,"","","","readonly","cariAd","")
					else
						call forminput("cariAd",cariAd,"","","","autocompleteOFF","cariAd","")
					end if
				Response.Write "</div>"
				'## Cari Ad
				'## unvan
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-danger"">" & translate("Cari Türü","","") & "</div>"
					call formselectv2("cariTur",cariTur,"","","","","cariTur",cariTurArr,"")
				Response.Write "</div>"
				'## unvan
				'## unvan
				Response.Write "<div class=""col-lg-8 col-md-8 col-sm-8 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Ünvan","","") & "</div>"
					call forminput("unvan",unvan,"","","","autocompleteOFF","unvan","")
				Response.Write "</div>"
				'## unvan
				'## unvan
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-danger"">" & translate("Vergi Dairesi","","") & "</div>"
					call forminput("vergiDairesi",vergiDairesi,"","","","autocompleteOFF","vergiDairesi","")
				Response.Write "</div>"
				'## unvan
				'## unvan
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-danger"">" & translate("Vergi Numarası","","") & "</div>"
					call forminput("vergiNo",vergiNo,"","","","autocompleteOFF","vergiNo","")
				Response.Write "</div>"
				'## unvan
				'## unvan
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4 sehirdiv"">"
					Response.Write "<div class=""badge badge-secondary float-start"">" & translate("Şehir","","") & "</div>"
					Response.Write "<div class=""float-right"">"
						Response.Write "<button class=""btn btn-success btn-sm"" type=""submit"">" & translate("Şehir Ekle","","") & "</button>"
					Response.Write "</div>"
					call formselectv2("sehir",sehir,"","","","","sehir",sehirArr,"")
				Response.Write "</div>"
				'## unvan
				'## unvan
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4 sehir2div d-none"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Şehir Adını Yazın","","") & "</div>"
					call forminput("sehir2","","","","","autocompleteOFF","sehir2","")
				Response.Write "</div>"
				'## unvan
				'## unvan
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Telefon","","") & "</div>"
					call forminput("telefon",telefon,"","","","autocompleteOFF","telefon","")
				Response.Write "</div>"
				'## unvan
				'## unvan
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Posta Kodu","","") & "</div>"
					call forminput("postakodu",postakodu,"","","","autocompleteOFF","postakodu","")
				Response.Write "</div>"
				'## unvan
				'## unvan
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Email Adresi","","") & "</div>"
					call forminput("email",email,"","","","autocompleteOFF","email","")
				Response.Write "</div>"
				'## unvan
				'## unvan
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Posta Adresi","","") & "</div>"
					call formtextarea("adres",adres,"","","","","adres","")
				Response.Write "</div>"
				'## unvan
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs"">"
				if manuelKayit = False then
					Response.Write "<button class=""form-control btn btn-success"" type=""submit"" disabled>" & translate("Kaydet","","") & "</button>"
				else
					Response.Write "<button class=""form-control btn btn-success"" type=""submit"">" & translate("Kaydet","","") & "</button>"
				end if
			Response.Write "</div>"

			Response.Write "</div>"

		Response.Write "</form>"
	else
		call yetkisizGiris("Bu Alanı Görme Yetkiniz Yok","","")
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%><!--#include virtual="/reg/rs.asp" -->