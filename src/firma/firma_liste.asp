<!--#include virtual="/reg/rs.asp" --><%

bu dosya teklif2 klasörünün altına gitsin
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
    opener  =   Request.QueryString("opener")
	modulAd =   "Teklif"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Firma Bilgileri Ekranı")


yetkiKontrol = yetkibul(modulAd)


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				'Response.Write "<div class=""row"">"
					Response.Write "<form action=""/firma/firma_liste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Banka adı"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 3 then
								Response.Write "<div class=""col-lg-9 col-sm-6 my-1 text-right"">"
									'Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/banka/banka_yeni.asp')"">YENİ BANKA EKLE</button>&nbsp;"
								Response.Write "</div>"
							end if
						Response.Write "</div>"
					Response.Write "</form>"
				'Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


    



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" then
	if yetkiKontrol > 0 then
		Response.Write "<div class=""table-responsive"">"
		
		
            sorgu = "Select t1.Id as firmaID, t1.ad as firmaAd, t1.adres, t1.telefon, t1.faksNo, t1.vergiNo, t1.vergiDairesi, t1.sehir, t1.ilce, t1.webSite, t1.iletisimEposta"
			sorgu = sorgu & " FROM portal.firma t1"
			sorgu = sorgu & " WHERE t1.Id = " & firmaID
			rs.Open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount > 0 then
			
				

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"

		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark"">"
			Response.Write "<tr class=""text-center"">"
					Response.Write "<th scope=""col"">Firma Adı</th>"
					Response.Write "<th scope=""col"">Adres</th>"
					Response.Write "<th scope=""col"">Telefon</th>"
					'Response.Write "<th scope=""col"">Faks</th>"
					Response.Write "<th scope=""col"">Vergi No</th>"
					Response.Write "<th scope=""col"">Vergi Dairesi</th>"
					Response.Write "<th scope=""col"">Şehir</th>"
					Response.Write "<th scope=""col"">İlçe</th>"
					Response.Write "<th scope=""col"">Web</th>"
					Response.Write "<th scope=""col"">e-posta</th>"


					
			Response.Write "</tr></thead>"
			
					
					for i = 1 to rs.recordcount
					firmaAd			=	rs("firmaAd")
					adres			=	rs("adres")
					telefon			=	rs("telefon")
					firmaID			=	rs("firmaID")
					firmaID64	 	=	firmaID
					firmaID64		=	base64_encode_tr(firmaID64)
					vergiNo			=	rs("vergiNo")
					vergiDairesi	=	rs("vergiDairesi")
					sehir			=	rs("sehir")
					ilce			=	rs("ilce")
					webSite			=	rs("webSite")
					iletisimEposta	=	rs("iletisimEposta")
					
			Response.Write "<tr>"
				Response.Write "<td class="""">" & firmaAd & "</td>"
				Response.Write "<td class="""">" & adres & "</td>"
				Response.Write "<td class="""">" & telefon & "</td>"
				Response.Write "<td class="""">" & vergiNo & "</td>"
				Response.Write "<td class="""">" & vergiDairesi & "</td>"
				Response.Write "<td class="""">" & sehir & "</td>"
				Response.Write "<td class="""">" & ilce & "</td>"
				Response.Write "<td class="""">" & webSite & "</td>"
				Response.Write "<td class="""">" & iletisimEposta & "</td>"
				Response.Write "<td class=""text-right"">"
					if yetkiKontrol > 2 then
						Response.Write "<div title=""" & translate("Firma Düzenle","","") & """ class=""badge badge-pill "
						Response.Write " badge-success"
						Response.Write """"
						Response.Write " onClick=""modalajax('/firma/firma_yeni.asp?gorevID=" & firmaID64 & "')"">"
						Response.Write "<i class=""mdi mdi-account-convert"
						Response.Write """></i>"
						Response.Write "</div>"
					end if
				Response.Write "</td>"
					
			Response.Write "</tr>"
					rs.movenext
					next
		Response.Write "</table>"
	Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "</div>"
			end if
			
			rs.close
		Response.Write "</div>"
	
	else
		call yetkisizGiris("","","")
	end if
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU












%>