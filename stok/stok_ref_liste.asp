﻿<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    stokID	=   Request.Form("stokID")
	cariID	=	Request.Form("cariID")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"

		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">Kod</th>"
		Response.Write "<th scope=""col"">Ürün Adı</th>"
		Response.Write "<th scope=""col"">Cari</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody>"
            sorgu = "SELECT"
			sorgu = sorgu & " t1.cariUrunRef, t1.cariUrunAd, t2.cariAd"
			sorgu = sorgu & " FROM stok.stokRef t1"
			sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.cariID = t2.cariID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID
			if stokID <> "" then
				sorgu = sorgu & " AND t1.stokID = " & stokID  & ""
			end if
			if cariID <> "" then
				sorgu = sorgu & " AND t1.cariID = " & cariID & ""
			end if
			rs.open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					cariUrunRef		=	rs("cariUrunRef")
					cariUrunAd		=	rs("cariUrunAd")
					cariAd			=	rs("cariAd")
					Response.Write "<tr>"
						Response.Write "<td>" & cariUrunRef & "</td>"
						Response.Write "<td>" & cariUrunAd & "</td>"
						Response.Write "<td>" & cariAd & "</td>"
					if yetkiKontrol >= 5 then
						Response.Write "<td class=""text-right"">"
						'# stok düzenle
						Response.Write "<div title=""" & translate("Stok Düzenle","","") & """ class=""badge badge-pill badge-success"""
							'Response.Write " onClick=""modalajax('/stok/stok_yeni.asp?gorevID=" & stokID64 & "');"">"
							Response.Write "<i class=""mdi mdi-account-convert""></i>"
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

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU












%>