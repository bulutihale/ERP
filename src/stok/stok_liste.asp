<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    durum	=   Request.QueryString("durum")
    durum2	=   Request.QueryString("durum2")
		if durum <> "" then q = "" else q = "tumListe" end if
		if durum2 <> "" then q2 = "" else q2 = "sifirGoster" end if
	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modulAd =   "stok"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Stok Listesi Ekranı") 

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
					Response.Write "<form action=""/stok/stok_liste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Ürün adı"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 8 then
								Response.Write "<div class=""col-lg-9 col-sm-6 my-1 text-right"">"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/stok/stok_yeni.asp')"">YENİ ÜRÜN EKLE</button>&nbsp;" 
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
	if hata = "" and yetkiKontrol > 0 then
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
		Response.Write "<th scope=""col"">Barkod</th>"
		Response.Write "<th scope=""col"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col p-0"">Stok</div>"
				Response.Write "<div id=""divDurum2"" class=""col p-0 m-0"">"
					Response.Write "<i class=""mdi mdi-arrow-expand text-danger pointer"" title=""Sıfır stokları göster/gizle"""
						Response.Write " onclick=""working('divDurum2',20,20);$('#ortaalan').load('/stok/stok_liste.asp?durum2=" & q2 & "');"">"
					Response.Write "</i>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</th>"
		Response.Write "<th scope=""col"">Tür</th>"
		Response.Write "<th scope=""col"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col"">Durum</div>"
				Response.Write "<div id=""divDurum"" class=""col p-0 m-0"">"
					Response.Write "<i class=""mdi mdi-arrow-expand text-danger pointer"" title=""Pasif ürünleri göster/gizle"""
						Response.Write " onclick=""working('divDurum',20,20);$('#ortaalan').load('/stok/stok_liste.asp?durum=" & q & "');"">"
					Response.Write "</i>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody>"

            sorgu = "SELECT"
			sorgu = sorgu & " t1.stokID, stok.FN_stokSay(" & firmaID & ", t1.stokID) as stokMiktar, t1.stokKodu, t1.stokAd, t1.stokBarcode," 
			sorgu = sorgu & " CASE WHEN t1.silindi = 1 THEN '<span class=""text-danger"">PASİF</span>' ELSE 'AKTİF' END as durum,"
			sorgu = sorgu & " CASE WHEN t1.stokTuru = '1' THEN 'Mamul' WHEN t1.stokTuru = '2' THEN 'Yarı Mamul' WHEN t1.stokTuru = '3' THEN 'Bileşen' WHEN t1.stokTuru = '4' THEN 'Hammadde' END as stokTuru"
			sorgu = sorgu & " FROM stok.stok t1" 
			sorgu = sorgu & " WHERE firmaID = " & firmaID
			if durum = "tumListe" then
			else	
				sorgu = sorgu & " AND t1.silindi = 0"
			end if
			if durum2 = "" AND  aramaad = "" then
				sorgu = sorgu & " AND stok.FN_stokSay(" & firmaID & ", t1.stokID) > 0"
			end if		
			if aramaad = "" then
			else
				sorgu = sorgu & " and (t1.stokAd like N'%" & aramaad & "%' OR t1.stokBarcode like N'%" & aramaad & "%' OR t1.stokKodu like N'%" & aramaad & "%')"
			end if
			sorgu = sorgu & " order by t1.stokKodu, t1.stokAd ASC"
			rs.open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					stokID			=	rs("stokID")
					stokID64	 	=	stokID
					stokID64		=	base64_encode_tr(stokID64)
					stokKodu		=	rs("stokKodu")
					stokAd			=	rs("stokAd")
					stokTuru		=	rs("stokTuru")
					stokBarcode		=	rs("stokBarcode")
					stokMiktar		=	rs("stokMiktar")
					durum			=	rs("durum")
					Response.Write "<tr>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>" & stokAd & "</td>"
						Response.Write "<td>" & stokBarcode & "</td>"
						Response.Write "<td>" & stokMiktar & "</td>"
						Response.Write "<td>" & stokTuru &  "</td>"
						Response.Write "<td>" & durum &  "</td>"
						Response.Write "<td class=""text-right"">"
						if stokMiktar > 0 then
						Response.Write "<div title=""Depolara göre stok sayıları"" class=""badge badge-pill badge-warning pointer mr-2"""
							Response.Write " onClick=""modalajax('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "');"">"
							Response.Write "<i class=""mdi mdi-numeric-9-plus-box-multiple-outline""></i>"
						Response.Write "</div>"
						end if
					if yetkiKontrol >= 5 then
						'# stok düzenle
						Response.Write "<div title=""" & translate("Stok Düzenle","","") & """ class=""badge badge-pill badge-success"""
							Response.Write " onClick=""modalajax('/stok/stok_yeni.asp?gorevID=" & stokID64 & "');"">"
							Response.Write "<i class=""mdi mdi-account-convert""></i>"
						Response.Write "</div>"
						'# stok düzenle
					end if
						Response.Write "</td>"
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