<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	urlBolum1	=	Session("sayfa3")
	urlBolum2	=	Session("sayfa4")
    stokID		=   Request.Form("stokID")
	cariID		=	Request.Form("cariID")
	sayfaURL 	=	"/"&urlBolum1&"/stok_ref_liste.asp"
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
		Response.Write "<table style=""width:100%"" class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col""></th>"
		Response.Write "<th scope=""col"">Kod</th>"
		Response.Write "<th scope=""col"">Ürün Adı</th>"
		Response.Write "<th scope=""col"">Fiyat</th>"
		Response.Write "<th scope=""col"">Cari</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody id=""refTablo"">"
            sorgu = "SELECT"
			sorgu = sorgu & " t1.id as stokRefID, t1.cariUrunRef, t1.cariUrunAd, t2.cariAd, t1.cariUrunFiyat, t1.paraBirim"
			sorgu = sorgu & " FROM stok.stokRef t1"
			sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.cariID = t2.cariID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.silindi = 0" 
			if stokID <> "" then
				sorgu = sorgu & " AND t1.stokID = " & stokID  & ""
			end if
			if cariID <> "" then
				sorgu = sorgu & " AND t1.cariID = " & cariID & ""
			end if
			rs.open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					stokRefID		=	rs("stokRefID")
					cariUrunRef		=	rs("cariUrunRef")
					cariUrunAd		=	rs("cariUrunAd")
					cariAd			=	rs("cariAd")
					cariUrunFiyat	=	rs("cariUrunFiyat")
					paraBirim		=	rs("paraBirim")
					Response.Write "<tr>"
					Response.Write "<td><span class=""pointer"" onclick=""refIptal(" & stokRefID & "," & cariID & ")""><i class=""icon delete""></i></span></td>"
						Response.Write "<td>"
							sayfaParametre = "cariID_"&cariID&"**stokID_"&stokID
			call forminput("cariUrunRef",cariUrunRef,"","","borderless text-left input30","","","onChange=""hucreKaydetGenel('id',"&stokRefID&",'cariUrunRef','stok.stokRef',$(this).val(),'Müşteriye ait ref değiştirilsin mi?','refTablo','"&sayfaURL&"','"&sayfaParametre&"','')""")
						Response.Write "</td>"
						Response.Write "<td>"
							'Response.Write cariUrunAd
			call forminput("cariUrunAd",cariUrunAd,"","","borderless text-left input30","","","onChange=""hucreKaydetGenel('id',"&stokRefID&",'cariUrunAd','stok.stokRef',$(this).val(),'Müşteriye ait Ürün Adı değiştirilsin mi?','refTablo','"&sayfaURL&"','"&sayfaParametre&"','')""")
						Response.Write "</td>"
						Response.Write "<td>"
							Response.Write "<div class=""input-group"">"
			'				Response.Write "<input name=""cariUrunFiyat"" id=""cariUrunFiyat"" type=""text"" class=""form-control text-right bold"" value=""" & cariUrunFiyat & """>"
			call forminput("cariUrunFiyat",cariUrunFiyat,"","","borderless text-right bold","","","onChange=""hucreKaydetGenel('id',"&stokRefID&",'cariUrunFiyat','stok.stokRef',$(this).val(),'Fiyat değiştirilsin mi?','refTablo','"&sayfaURL&"','"&sayfaParametre&"','')""")
  								Response.Write "<div class=""input-group-append"">"
								    Response.Write "<span class=""input-group-text py-0"">" & paraBirim & "</span>"
  								Response.Write "</div>"
		 		call formselectv2("paraBirim",paraBirim,"","","formSelect2 border","","paraBirim","","data-holderyazi=""Para Birimi"" data-jsondosya=""JSON_paraBirimler"" data-miniput=""0"" onChange=""hucreKaydetGenel('id',"&stokRefID&",'paraBirim','stok.stokRef',$(this).val(),'Birim değiştirilsin mi?','refTablo','"&sayfaURL&"','"&sayfaParametre&"','')""")
							Response.Write "</div>"
						
						Response.Write "</td>"
						Response.Write "<td>"
							Response.Write cariAd
						Response.Write "</td>"
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

