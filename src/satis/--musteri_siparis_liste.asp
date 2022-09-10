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
    modulAd =   "satis"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Müşteri Siparişi Listesi Ekranı")

yetkiKontrol = yetkibul(modulAd)


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
					Response.Write "<form action=""/satis/musteri_siparis_liste.asp"" method=""post"" class=""ortaform"">"
					Response.Write "<div class=""form-row align-items-center"">"
					Response.Write "<div class=""col-auto my-1"">"
					Response.Write "<input type=""text"" class=""form-control"" placeholder=""Sipariş Adı"" name=""aramaad"" value=""" & aramaad & """>"
					Response.Write "</div>"
					Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
					if isnull(firmaSSO) = True then
					if yetkiKontrol >= 5 then
						'Response.Write "<div class=""col-sm-3 my-1""><button type=""button"" class=""btn btn-danger"" onClick=""modalajax('/stok/stok_yeni.asp')"">" & translate("YENİ STOK","","") & "</a></div>"
					end if
					end if
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
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"

		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">Tarih</th>"
		Response.Write "<th scope=""col"">Sipariş No</th>"
		Response.Write "<th scope=""col"">Sipariş Adı</th>"
		Response.Write "<th scope=""col"">Cari Adı</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody>"
            sorgu = "SELECT"
			sorgu = sorgu & " t1.id, t1.teklifAd, t1.teklifTarih, t2.cariAd, t1.teklifNo"
			sorgu = sorgu & " FROM teklif.teklif t1"
			sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.cariID = t2.cariID"
			sorgu = sorgu & " WHERE 1 = 1"
			if aramaad = "" then
			else
				sorgu = sorgu & " and (t1.teklifAd like N'%" & aramaad & "%' OR t2.cariAd like N'%" & aramaad & "%' OR t1.teklifNo like N'%" & aramaad & "%')"
			end if
			sorgu = sorgu & " ORDER BY t1.teklifTarih DESC"
			rs.open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					teklifID		=	rs("teklifID")
					teklifID64	 	=	teklifID
					teklifID64		=	base64_encode_tr(teklifID64)
					teklifAd		=	rs("teklifAd")
					teklifTarih		=	rs("teklifTarih")
					teklifNo		=	rs("teklifNo")
					cariAd			=	rs("cariAd")
					Response.Write "<tr>"
						Response.Write "<td>" & teklifTarih & "</td>"
						Response.Write "<td>" & teklifNo & "</td>"
						Response.Write "<td>" & teklifAd & "</td>"
						Response.Write "<td>" & cariAd & "</td>"
					if yetkiKontrol >= 5 then
						Response.Write "<td class=""text-right"">"
						'# stok düzenle
						Response.Write "<div class=""badge badge-pill badge-success pointer"""
							Response.Write " onClick=""$('#ortaalan').load('/satis/teklif_detay.asp?gorevID=" & teklifID64 & "');"">"
							Response.Write "<i class=""mdi mdi-chevron-right""></i>"
						Response.Write "</div>"
						'# stok düzenle
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