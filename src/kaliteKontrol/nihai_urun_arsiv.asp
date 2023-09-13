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
					Response.Write "<div class=""col-4"">"
					Response.Write "<form action=""/kaliteKontrol/form_arsiv.asp"" method=""post"" class=""ortaform"">"
					Response.Write "<div class=""form-row align-items-center"">"
					Response.Write "<div class=""col-auto my-1"">"
					Response.Write "<input type=""text"" class=""form-control"" placeholder="""" name=""aramaad"" value=""" & aramaad & """>"
					Response.Write "</div>"
					Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
					Response.Write "</div>"
					Response.Write "</form>"
					Response.Write "</div>"
					Response.Write "<div class=""col-8 h3 mt-2"">Nihai Ürün Kontrol Formları</div>"
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
		Response.Write "<th scope=""col"">Ürün Kodu</th>"
		Response.Write "<th scope=""col"">Ürün Adı</th>"
		Response.Write "<th scope=""col"">Üretim Başlangıç</th>"
		Response.Write "<th scope=""col"">Üretim Bitiş</th>"
		Response.Write "<th scope=""col"">LOT</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody>"
            sorgu = "SELECT t1.id as ajandaID, t1.stokID, portal.FN_sipariscariIDbul(" & firmaID & ", t1.id) as cariID,"
			sorgu = sorgu & " t1.baslangicZaman, t1.bitisZaman, t1.uretimLot, t2.stokKodu, t2.stokAd, t3.dosyaPath, t3.dosyaAd"
			sorgu = sorgu & " FROM portal.ajanda t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " LEFT JOIN kalite.degerForm t3 ON t1.id = t3.ayiriciTabloID"
			sorgu = sorgu & " WHERE t1.isTur = 'uretimPlan' AND t1.tamamlandi = 1"
			sorgu = sorgu & " AND t1.silindi = 0"
			sorgu = sorgu & " ORDER BY t1.bitisZaman DESC"
			rs.open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount = 0 then
				Response.Write "<tr><td colspan=""8"">"
				Response.Write "<div class=""h5"">Kayıt bulunamadı.</div>"
				Response.Write "</td></tr>"
			else
				for i = 1 to rs.recordcount
					dosyaPath			=	rs("dosyaPath")
					dosyaAd				=	rs("dosyaAd")
					baslangicZaman		=	rs("baslangicZaman")
					bitisZaman			=	rs("bitisZaman")
					uretimLot			=	rs("uretimLot")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					ajandaID			=	rs("ajandaID")
					ajandaID64			=	ajandaID
					ajandaID64			=	base64_encode_tr(ajandaID64)
					stokID				=	rs("stokID")
					stokID64			=	stokID
					stokID64			=	base64_encode_tr(stokID64)
					cariID				=	rs("cariID")
					cariID64			=	cariID
					cariID64			=	base64_encode_tr(cariID64)
					Response.Write "<tr>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td class="""">" & stokAd & "</td>"
						Response.Write "<td>" & baslangicZaman & "</td>"
						Response.Write "<td>" & bitisZaman & "</td>"
						Response.Write "<td class="""">" & uretimLot & "</td>"
					if yetkiKontrol >= 5 then
						Response.Write "<td class=""text-right"">"
							Response.Write "<div class=""badge badge-pill badge-info pointer mr-1 col-5"" title=""Gelen Malzeme Kalite Kontrol Formu"""
								Response.Write " onClick=""modalajaxfitozelKapat('/kaliteKontrol/kalite_form_yap.asp?formKod=3&stokID=" & stokID64 & "&cariID=" & cariID64 & "&ayiriciTabloAd=ajanda&ayiriciTabloID=" & ajandaID64 & "');"">"
								Response.Write "<i class=""mdi mdi-webhook""></i>"
							Response.Write "</div>"
							Response.Write "<div"
							if not isnull(dosyaAd) then
								Response.Write " class=""badge badge-pill badge-success pointer col-5"""
								Response.Write " onClick=""window.open('" & dosyaPath & dosyaAd & "');"">"
							else
								Response.Write " class=""badge badge-pill badge-danger pointer col-5"""
								Response.Write " onClick=""swal('','Form için PDF oluşturulmamış.');"">"
							end if
								Response.Write "<i class=""mdi mdi-chevron-right""></i>"
							Response.Write "</div>"
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