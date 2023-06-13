<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    kid64		=	ID
    gorevID 	=   Request.QueryString("gorevID")
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
    hata    	=   ""
    modulAd 	=   "Cari"
    Response.Flush()
	yetkiKontrol = yetkibul("Cari")
'###### ANA TANIMLAMALAR


'#### yetkiler
	yetkiKontrol	= yetkibul("Cari")
'#### yetkiler


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
		ulkeID				=	rs("ulkeID")
	rs.close
end if

	if ulkeID <> "" then
		defDeger = defDegerBul("portal.ulkeler", "id", ulkeID, "adTurkce")
	end if




if gorevID = "" then
	call logla(translate("Cari Ayrıntıları Ekranı","",""))
	manuelKayit = true
else
	call logla(translate("Cari Ayrıntıları Ekranı","","") & cariAd)
end if


'### sehirArr
	if hata = "" then
		sorgu = "Select ilID,sehiradi from portal.iller order by sehiradi ASC"
		rs.open sorgu,sbsv5,1,3
			sehirArr = "=|"
			do while not rs.eof
				sehirArr = sehirArr & rs("sehiradi")
				sehirArr = sehirArr & "="
				sehirArr = sehirArr & rs("sehiradi")
				' sehirArr = sehirArr & rs("ilID")
				sehirArr = sehirArr & "|"
				' if rs("sehiradi") = il then
				' 	sehir = rs("ilID")
				' end if
			rs.movenext
			loop
			sehirArr = left(sehirArr,len(sehirArr)-1)
		rs.close
	end if
'### sehirArr





'###### ARAMA FORMU
	if yetkiKontrol >= 5 then
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

				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Cari Kod","","") & "</div>"
					if manuelKayit = False then
						call forminput("cariKodu",cariKodu,"","","","readonly","cariKodu","")
					else
						call forminput("cariKodu",cariKodu,"","","","autocompleteOFF","cariKodu","")
					end if
				Response.Write "</div>"

				Response.Write "<div class=""col-lg-8 col-md-8 col-sm-8 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-danger"">" & translate("Cari Ad","","") & "</div>"
					if manuelKayit = False then
						call forminput("cariAd",cariAd,"","","","readonly","cariAd","")
					else
						call forminput("cariAd",cariAd,"","","","autocompleteOFF","cariAd","")
					end if
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row mt-2"">"
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-danger"">" & translate("Cari Türü","","") & "</div>"
					call formselectv2("cariTur",cariTur,"","","","","cariTur",sb_cariTurArr,"")
				Response.Write "</div>"

				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-danger"">" & translate("Vergi Dairesi","","") & "</div>"
					call forminput("vergiDairesi",vergiDairesi,"","","","autocompleteOFF","vergiDairesi","")
				Response.Write "</div>"

				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-danger"">" & translate("Vergi Numarası","","") & "</div>"
					call forminput("vergiNo",vergiNo,"","","","autocompleteOFF","vergiNo","")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row mt-2"">"
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4 sehirdiv"">"
					Response.Write "<div class=""badge badge-secondary float-start"">" & translate("Şehir","","") & "</div>"
					call formselectv2("il",il,"","","","","il",sehirArr,"")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Ülke</div>"
					call formselectv2("ulkeID","","","","formSelect2 ulkeID border","","ulkeID","","data-holderyazi=""Ülke"" data-jsondosya=""JSON_ulkeler"" data-miniput=""0"" data-defdeger="""&defDeger&"""")
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""row mt-2"">"
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Posta Kodu","","") & "</div>"
					call forminput("postakodu",postakodu,"","","","autocompleteOFF","postakodu","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Email Adresi","","") & "</div>"
					call forminput("email",email,"","","","autocompleteOFF","email","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Telefon","","") & "</div>"
					call forminput("telefon",telefon,"","","","autocompleteOFF","telefon","")
				Response.Write "</div>"
			Response.Write "</div>"

				Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs mb-4"">"
					Response.Write "<div class=""badge badge-secondary"">" & translate("Posta Adresi","","") & "</div>"
					call formtextarea("adres",adres,"","","form-control","","adres","")
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
		hata = translate("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
		call yetkisizGiris(hata,"","")
	end if
'###### ARAMA FORMU


%><!--#include virtual="/reg/rs.asp" -->



<script>
	$(document).ready(function() {
		$('#ulkeID').trigger('mouseenter');
	});
	 
</script>
