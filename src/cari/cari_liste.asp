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
    modulAd =   "cari"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Cari Listesi Ekranı")

'#### yetkiler
'#### yetkiler
	yetkiKontrol	= yetkibul(modulAd)
	yetkiTeklif	    = yetkibul("Teklif")
	yetkiSatis  	= yetkibul("Satış")
'#### yetkiler
'#### yetkiler


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
					Response.Write "<form action=""/cari/cari_liste.asp"" method=""post"" class=""ortaform"">"
					Response.Write "<div class=""form-row align-items-center"">"
					Response.Write "<div class=""col-6 my-1"">"
					Response.Write "<input type=""text"" class=""form-control"" placeholder=""Cari Adı, Cari Kodu"" name=""aramaad"" value=""" & aramaad & """>"
					Response.Write "</div>"
					Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
					' if isnull(firmaSSO) = True then
					if yetkiTeklif >= 3 or yetkiSatis > 1 then
						Response.Write "<div class=""col-auto my-1""><button type=""button"" class=""btn btn-danger"" onClick=""modalajaxfit('/cari/cari_yeni.asp')"">" & translate("YENİ CARİ","","") & "</a></div>"
					end if
					' end if
					Response.Write "</div>"
					Response.Write "</form>"
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"

	end if
'###### ARAMA FORMU
'###### ARAMA FORMU



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then
		Response.Write "<div class=""container-fluid scroll-ekle3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"

		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">Kod</th>"
		Response.Write "<th scope=""col"">Cari Adı</th>"
		Response.Write "<th scope=""col"">İl</th>"
		Response.Write "<th scope=""col"">Vergi No</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody>" 
            sorgu = "SELECT"
			sorgu = sorgu & " t1.cariID,"
			sorgu = sorgu & " t1.cariKodu,"
			sorgu = sorgu & " t1.cariAd, t1.il, t1.vergiNo" 
			sorgu = sorgu & " FROM cari.cari t1" 
			sorgu = sorgu & " WHERE firmaID = " & firmaID
			if aramaad = "" then
			else
				sorgu = sorgu & " and (t1.cariAd like N'%" & aramaad & "%' OR t1.vergiNo like N'%" & aramaad & "%' OR t1.cariKodu like N'%" & aramaad & "%')"
			end if
			sorgu = sorgu & " ORDER BY t1.cariAd ASC"
			rs.open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					cariID			=	rs("cariID")
					cariID64	 	=	cariID
					cariID64		=	base64_encode_tr(cariID64)
					cariKodu		=	rs("cariKodu")
					cariAd			=	rs("cariAd")
					il				=	rs("il")
					vergiNo			=	rs("vergiNo")
					Response.Write "<tr>"
						Response.Write "<td>" & cariKodu & "</td>"
						Response.Write "<td>" & cariAd & "</td>"
						Response.Write "<td>" & il & "</td>"
						Response.Write "<td>" & vergiNo &  "</td>"
					if yetkiKontrol >= 5 then
						Response.Write "<td class=""text-right"" nowrap>"
						'# cari düzenle
						Response.Write "<div title=""" & translate("Cari Düzenle","","") & """ class=""badge badge-pill "
						Response.Write " badge-success"
						Response.Write """"
						Response.Write " onClick=""modalajaxfit('/cari/cari_yeni.asp?gorevID=" & cariID64 & "');"">"
						Response.Write "<i class=""mdi mdi-account-convert"
						Response.Write """></i>"
						Response.Write "</div>"
						'# cari düzenle
						'# cari düzenle
						Response.Write "<div title=""" & translate("Cari Düzenle","","") & """ class=""ml-1 badge badge-pill "
						Response.Write " badge-success"
						Response.Write """"
						Response.Write " onClick=""modalajaxfit('/cari/cari_yetkili.asp?gorevID=" & cariID64 & "');"">"
						Response.Write "<i class=""mdi mdi-account-multiple-outline"
						Response.Write """></i>"
						Response.Write "</div>"
						'# cari düzenle
						'# cari düzenle
						teklif64 = cariID & "|"
						teklif64 =	base64_encode_tr(teklif64)
						Response.Write "<a href=""/teklif/teklif_yeni/" & teklif64 & """ title=""" & translate("Teklif Ver","","") & """ class=""ml-1 badge badge-pill "
						Response.Write " badge-warning"
						Response.Write """"
						Response.Write " "">"
						Response.Write "<i class=""mdi mdi-basket-unfill"
						Response.Write """></i>"
						Response.Write "</a>"
						'# cari düzenle
						Response.Write "</td>"
					end if
					Response.Write "</tr>"
					Response.Flush()
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"

				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"

	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU


%>


<script>








$( document ).ready(function() {
alert();
$(".demo").qrcode({

   text:'https://www.jqueryscript.net',
    mode: 1,
    label:'jQueryScript.Net',
    fontname:'sans',
    fontcolor:'#000'

});

});

</script>