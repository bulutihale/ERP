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
    modulAd =   "Kalite Kontrol"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Kalite Kontrol Bekleyen Ürünler Ekranı")

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
					Response.Write "<form action=""/kaliteKontrol/bekleyen_liste.asp"" method=""post"" class=""ortaform"">"
					Response.Write "<div class=""form-row align-items-center"">"
					Response.Write "<div class=""col-auto my-1"">"
					Response.Write "<input type=""text"" class=""form-control"" placeholder=""Ürün adı, kodu, Firma adı"" name=""aramaad"" value=""" & aramaad & """>"
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
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark text-center""><tr>"
		Response.Write "<th scope=""col"">Giriş Tarih</th>"
		Response.Write "<th scope=""col"">Belge No</th>"
		Response.Write "<th scope=""col"">Cari Adı</th>"
		Response.Write "<th scope=""col"">Stok Kodu</th>"
		Response.Write "<th scope=""col"">Ürün Adı</th>"
		Response.Write "<th scope=""col"">Miktar</th>"
		Response.Write "<th scope=""col"">LOT</th>"
		Response.Write "<th scope=""col"">SKT</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody>"
            sorgu = "SELECT"
			sorgu = sorgu & " t1.stokHareketID, t1.stokKodu, t3.stokAd, t1.girisTarih, t2.cariAd, t1.miktar, t1.miktarBirim, t1.lot, t1.lotSKT, t1.belgeNo, t3.stokID, t1.cariID"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.cariID = t2.cariID"
			sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " INNER JOIN stok.depo t4 ON t1.depoID = t4.id"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.silindi = 0 AND t4.depoKategori = 'kalite'"
			sorgu = sorgu & " AND t1.miktar > (SELECT ISNULL(SUM(miktar),0) FROM stok.stokHareket WHERE refHareketID = t1.stokHareketID AND stokHareketTuru = 'C')"
			if aramaad = "" then
			else
				sorgu = sorgu & " and (t1.stokKodu like N'%" & aramaad & "%' OR t3.stokAd like N'%" & aramaad & "%' OR t2.cariAd like N'%" & aramaad & "%')"
			end if
			sorgu = sorgu & " ORDER BY t1.girisTarih DESC"
			rs.open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount = 0 then
				Response.Write "<tr><td colspan=""8"">"
				Response.Write "<div class=""h5"">Kayıt bulunamadı.</div>"
				Response.Write "</td></tr>"
			else
				for i = 1 to rs.recordcount
					stokHareketID		=	rs("stokHareketID")
					stokHareketID64	 	=	stokHareketID
					stokHareketID64		=	base64_encode_tr(stokHareketID64)
					girisTarih			=	rs("girisTarih")
					belgeNo				=	rs("belgeNo")
					cariAd				=	rs("cariAd")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					miktar				=	rs("miktar")
					miktarBirim			=	rs("miktarBirim")
					lot					=	rs("lot")
					lotSKT				=	rs("lotSKT")
					stokID				=	rs("stokID")
					stokID64		 	=	stokID
					stokID64			=	base64_encode_tr(stokID64)
					cariID				=	rs("cariID")
					cariID64		 	=	cariID
					cariID64			=	base64_encode_tr(cariID64)
					Response.Write "<tr>"
						Response.Write "<td>" & girisTarih & "</td>"
						Response.Write "<td>" & belgeNo & "</td>"
						Response.Write "<td>" & cariAd & "</td>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>" & stokAd & "</td>"
						Response.Write "<td class=""text-right"">" & miktar & " " & miktarBirim & "</td>"
						Response.Write "<td class=""text-center"">" & lot & "</td>"
						Response.Write "<td class=""text-center"">" & lotSKT & "</td>"
					if yetkiKontrol >= 5 then
						Response.Write "<td class=""text-right"">"
						'# kalite formu çağır
						Response.Write "<div class=""badge badge-pill badge-info pointer mr-1"" title=""Gelen Malzeme Kalite Kontrol Formu"""
							Response.Write " onClick=""modalajaxfitozelKapat('/kaliteKontrol/kalite_form_yap.asp?formKod=1&stokID=" & stokID64 & "&cariID=" & cariID64 & "&ayiriciTabloAd=stokHareket&ayiriciTabloID=" & stokHareketID64 & "');"">"
							Response.Write "<i class=""mdi mdi-webhook""></i>"
						Response.Write "</div>"
						'# /kalite formu çağır
						'# giriş onayla
						Response.Write "<div class=""badge badge-pill badge-success pointer"""
							Response.Write " onClick=""modalajax('/kaliteKontrol/kontrol_onay.asp?gorevID=" & stokHareketID64 & "');"">"
							Response.Write "<i class=""mdi mdi-chevron-right""></i>"
						Response.Write "</div>"
						'# /giriş onayla
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