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
	cariID	=	Request.Form("cariID")
	t1		=	Request.Form("t1")
	t2		=	Request.Form("t2")
	lot		=	Request.Form("lot")
    hata    =   ""
    modulAd =   "Kalite Kontrol"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	'####### varsayılan tarih sınırları
		if t1 = "" then t1 = date() - 30 end if
		if t2 = "" then t2 = date() end if
	'####### /varsayılan tarih sınırları

call logla("Kalite kontrol formları listendi")

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
					Response.Write "<form action=""/kaliteKontrol/form_arsiv.asp"" method=""post"" class=""ortaform"">"
					Response.Write "<div class=""form-row align-items-center"">"
					Response.Write "<div class=""col-auto my-1"">"
					Response.Write "<input type=""text"" class=""form-control"" placeholder="""" name=""aramaad"" value=""" & aramaad & """>"
					Response.Write "</div>"
					Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
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
		Response.Write "<div class=""col-1 pointer"" onclick=""modalajax('/kaliteKontrol/filtre.asp')""><i class=""mdi mdi-filter table-success rounded""></i></div>"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark text-center""><tr>"
		Response.Write "<th scope=""col"">Giriş Tarih</th>"
		Response.Write "<th scope=""col"">Form</th>"
		Response.Write "<th scope=""col"">Cari Adı</th>"
		Response.Write "<th scope=""col"">Ürün Adı</th>"
		Response.Write "<th scope=""col"">Miktar</th>"
		Response.Write "<th scope=""col"">LOT</th>"
		Response.Write "<th scope=""col"">SKT</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody>"
            sorgu = "SELECT"
			sorgu = sorgu & " t2.cariID, t2.stokID, t2.lotSKT, t2.miktar, t2.miktarBirim, t3.cariAd, t4.stokAd, t5.formAd, t2.girisTarih, t2.lot, t2.belgeNo, t2.stokHareketID,"
			sorgu = sorgu & " t1.dosyaPath, t1.dosyaAd"
			sorgu = sorgu & " FROM kalite.degerForm t1"
			sorgu = sorgu & " INNER JOIN stok.stokHareket t2 ON t1.ayiriciTabloID = t2.stokHareketID"
			sorgu = sorgu & " INNER JOIN cari.cari t3 ON t2.cariID = t3.cariID"
			sorgu = sorgu & " INNER JOIN stok.stok t4 ON t2.stokID = t4.stokID"
			sorgu = sorgu & " INNER JOIN kalite.form t5 ON t1.formID = t5.formID"
			sorgu = sorgu & " WHERE t5.formKod = 1 AND t1.silindi = 0"
			if lot <> "" then
				sorgu = sorgu & " AND t2.lot = '" & lot & "'"
			end if
			if cariID <> "" then
				sorgu = sorgu & " AND t2.cariID = " & cariID & ""
			end if
			if aramaad = "" then
			else
				sorgu = sorgu & " AND (t4.stokKodu like N'%" & aramaad & "%' OR t4.stokAd like N'%" & aramaad & "%' OR t3.cariAd like N'%" & aramaad & "%' OR t2.lot like N'%" & aramaad & "%')"
			end if
			sorgu = sorgu & " AND t2.girisTarih >= '" & tarihsql2(t1) &"' AND t2.girisTarih <= '" & tarihsql2(t2) &"'"
			sorgu = sorgu & " ORDER BY t2.girisTarih DESC"
			rs.open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount = 0 then
				Response.Write "<tr><td colspan=""8"">"
				Response.Write "<div class=""h5"">Kayıt bulunamadı.</div>"
				Response.Write "</td></tr>"
			else
				for i = 1 to rs.recordcount
					formAd				=	rs("formAd")
					dosyaPath			=	rs("dosyaPath")
					dosyaAd				=	rs("dosyaAd")
					stokHareketID		=	rs("stokHareketID")
					stokHareketID64	 	=	stokHareketID
					stokHareketID64		=	base64_encode_tr(stokHareketID64)
					girisTarih			=	rs("girisTarih")
					belgeNo				=	rs("belgeNo")
					cariAd				=	rs("cariAd")
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
						Response.Write "<td class=""fontkucuk2"">" & formAd & "</td>"
						'Response.Write "<td>" & belgeNo & "</td>"
						Response.Write "<td>" & cariAd & "</td>"
						Response.Write "<td>" & stokAd & "</td>"
						Response.Write "<td class=""text-right"">" & miktar & " " & miktarBirim & "</td>"
						Response.Write "<td class=""text-center"">" & lot & "</td>"
						Response.Write "<td class=""text-center"">" & lotSKT & "</td>"
					if yetkiKontrol >= 5 then
						Response.Write "<td class=""text-right"">"


						Response.Write "<div"
						if not isnull(dosyaAd) then
						 	Response.Write " class=""badge badge-pill badge-success pointer"""
							Response.Write " onClick=""window.open('" & dosyaPath & dosyaAd & "');"">"
						else
							Response.Write " class=""badge badge-pill badge-danger pointer"""
							Response.Write " onClick=""swal('','Form için PDF oluşturulmamış.');"">"
						end if
							Response.Write "<i class=""mdi mdi-chevron-right""></i>"
						Response.Write "</div>"

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