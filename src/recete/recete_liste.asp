<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
	cariID			=	Request.Form("cariID")
	stokID			=	Request.Form("stokID")
    modulAd 		=   "Reçete"
	
	

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	yetkiKontrol	 = yetkibul(modulAd)

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU


call logla("Reçeteler Listelendi")

Response.Write "<div class=""card rounded-top"">"
Response.Write "<div class=""card-header h5"">Üretim Reçeteleri Listesi</div>"

Response.Write "<div class=""card-body"">"
	Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-lg-1 pointer"" onclick=""modalajax('/recete/filtre.asp')""><i class=""mdi mdi-filter table-success rounded""></i></div>"
		if yetkiKontrol >= 5 then
		Response.Write "<div class=""col-lg-11 col-sm-6 my-1 text-right"">"
			Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/recete/recete_yeni.asp')"">YENİ REÇETE</button>&nbsp;"
		Response.Write "</div>"
		end if
	Response.Write "</div>"
		
		
		
		Response.Write "<div class=""table-responsive mt-3"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr class=""text-center"">"
			Response.Write "<th class=""col-2"" scope=""col"">Reçete Adı</th>"
			Response.Write "<th class=""col-1"" scope=""col"">Ürün Kodu</th>"
			Response.Write "<th class=""col-4"" scope=""col"">Ürün Adı</th>"
			Response.Write "<th class=""col-4"" scope=""col"">Cari Adı</th>"
			if yetkiKontrol >= 5 then
				Response.Write "<th class=""col-1"" scope=""col"">İşlem</th>"
			end if
		Response.Write "</tr></thead><tbody>"
		
		
            sorgu = "SELECT"
			sorgu = sorgu & " t1.receteID, t1.receteAd, t2.stokID, t2.stokKodu, t2.stokAd, t3.cariID, t3.cariKodu, t3.cariAd"
			sorgu = sorgu & " FROM recete.recete t1"
			sorgu = sorgu & " LEFT JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " LEFT JOIN cari.cari t3 ON t1.cariID = t3.cariID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.silindi = 0"
			if stokID <> "" then
				sorgu = sorgu & " AND t2.stokID = " & stokID & ""
			end if
			if cariID <> "" then
				sorgu = sorgu & " AND t3.cariID = " & cariID & ""
			end if
			sorgu = sorgu & " ORDER BY t1.receteID"
			rs.open sorgu, sbsv5, 1, 3
			
			if rs.recordcount = 0 then
				Response.Write "<tr><td colspan=""8"" class=""h5"">Reçete kaydı bulunamadı.</td></tr>"
			else
				for i = 1 to rs.recordcount
					receteID			=	rs("receteID")
					receteID64		 	=	receteID
					receteID64			=	base64_encode_tr(receteID64)
					receteAd			=	rs("receteAd")
					stokID				=	rs("stokID")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					cariID				=	rs("cariID")
					cariKodu			=	rs("cariKodu")
					cariAd				=	rs("cariAd")

					Response.Write "<tr>"
						Response.Write "<td>" & receteAd & "</td>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>" & stokAd & "</td>"
						Response.Write "<td>" & cariAd & "</td>"
						if yetkiKontrol >= 5 then
						Response.Write "<td class=""text-right"">"

							if yetkiKontrol >= 5 then
								Response.Write "<div title=""" & translate("Reçete Adımları Düzenle","","") & """ class=""badge badge-pill pointer mr-2"
								Response.Write " badge-warning"
								Response.Write """"
								Response.Write " onClick=""document.location='/recete/recete_adim_liste/" & receteID64 & "'"">"
								Response.Write "<i class=""fa fa-search"
								Response.Write """></i>"
								Response.Write "</div>"
							end if
							
							if yetkiKontrol >= 9 then
								Response.Write "<div title=""Reçete Klonlama"" class=""badge badge-pill pointer mr-2 "
								Response.Write " badge-info"
								Response.Write """"
								Response.Write " onClick=""modalajax('/recete/recete_yeni.asp?gorevID=" & receteID64 & "&islem=kopyala')"">"
								Response.Write "<i class=""mdi mdi-library-plus"
								Response.Write """></i>"
								Response.Write "</div>"
							end if

							if yetkiKontrol >= 5 then
								Response.Write "<div title=""" & translate("Reçete Düzenle","","") & """ class=""badge badge-pill pointer"
								Response.Write " badge-success"
								Response.Write """"
								Response.Write " onClick=""modalajax('/recete/recete_yeni.asp?gorevID=" & receteID64 & "')"">"
								Response.Write "<i class=""mdi mdi-account-convert"
								Response.Write """></i>"
								Response.Write "</div>"
							end if
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
	Response.Write "</div>"'card-body
	Response.Write "</div>"'card
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU







%>












