<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    kid64		=	ID
	aramaad		=	Request.Form("aramaad")
    hata    	=   ""
    modulAd 	=   "Cari"
    Response.Flush()
	call logla(translate("Cari Listesi Ekranı","",""))
	yetkiKontrol = yetkibul("Cari")
'###### ANA TANIMLAMALAR


'#### yetkiler
	yetkiKontrol	= yetkibul("Cari")
'#### yetkiler


'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
					Response.Write "<form action=""/cari/cari_liste"" method=""post"" id=""listebuttonform"">"
						' call formhidden("stokSifirGoster",stokSifirGoster,"","","","","stokSifirGoster","")
						' call formhidden("stokSilinmislerGoster",stokSilinmislerGoster,"","","","","stokSilinmislerGoster","")
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Müşteri Adı","","") & """ name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 5 then
								Response.Write "<div class=""col-lg-9 col-sm-3 my-1 text-right"">"
									' if stokSifirGoster = "on" then
									' 	Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSifirGoster').val('off');$('#listebuttonform').submit();"">" & translate("Stok Sıfır Olanları Gizle","","") & "</button>"
									' else
									' 	Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSifirGoster').val('on');$('#listebuttonform').submit();"">" & translate("Stok Sıfır Olanları Göster","","") & "</button>"
									' end if
									' if stokSilinmislerGoster = "on" then
									' 	Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSilinmislerGoster').val('off');$('#listebuttonform').submit();"">" & translate("Silinmişleri Gizle","","") & "</button>"
									' else
									' 	Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSilinmislerGoster').val('on');$('#listebuttonform').submit();"">" & translate("Silinmişleri Göster","","") & "</button>"
									' end if
									if yetkiKontrol >= 7 then
										Response.Write "<button type=""button"" class=""btn btn-warning mr-2"" onClick=""modalajax('/cari/import.asp')"">" & translate("Veri Aktarımı","","") & "</button>"
									end if
									' Response.Write "<button type=""button"" class=""btn btn-warning mr-2"" onClick=""netsisSenk('" & firmaStokDB & "')"">" & translate("Muhasebe Yazılımı ile Senkronize Et","","") & "</button>"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/cari/cari_yeni.asp')"">" & translate("Yeni Cari Ekle","","") & "</button>"
								Response.Write "</div>"
							end if
						Response.Write "</div>"
					Response.Write "</form>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### ARAMA FORMU










'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
					sorgu = "SELECT" & vbcrlf
					sorgu = sorgu & "cari.cari.cariID," & vbcrlf
					sorgu = sorgu & "cari.cari.cariKodu," & vbcrlf
					sorgu = sorgu & "cari.cari.cariAd," & vbcrlf
					sorgu = sorgu & "cari.cari.telefon," & vbcrlf
					sorgu = sorgu & "cari.cari.email," & vbcrlf
					sorgu = sorgu & "cari.cari.il," & vbcrlf
					sorgu = sorgu & "cari.cari.cariTur," & vbcrlf
					sorgu = sorgu & "cari.cari.manuelKayit," & vbcrlf
					sorgu = sorgu & "cari.cari.silindi" & vbcrlf
					sorgu = sorgu & "FROM cari.cari" & vbcrlf
					sorgu = sorgu & "WHERE" & vbcrlf
					sorgu = sorgu & "cari.cari.firmaID in (select Id from portal.firma where portal.firma.anaFirmaID = " & firmaID & " OR portal.firma.Id = " & firmaID & ")" & vbcrlf
					if aramaad <> "" then
						sorgu = sorgu & " and (cari.cari.cariAd like N'%" & aramaad & "%' OR cari.cari.vergiNo like N'%" & aramaad & "%' OR cari.cari.cariKodu like N'%" & aramaad & "%')"
					end if
					' if stokSilinmislerGoster = "on" then
						sorgu = sorgu & " AND cari.cari.silindi = 0" & vbcrlf
					' end if
					sorgu = sorgu & "order by cari.cari.cariAd ASC" & vbcrlf
					rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount > 0 then
						Response.Write "<div class=""table-responsive"">"
						Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark"">"
							Response.Write "<tr>"
							Response.Write "<th scope=""col"">" & translate("Cari Kodu","","") & "</th>"
							Response.Write "<th scope=""col"">" & translate("Firma Adı","","") & "</th>"
							Response.Write "<th scope=""col"">" & translate("Telefonu","","") & "</th>"
							Response.Write "<th scope=""col"">" & translate("Email","","") & "</th>"
							Response.Write "<th scope=""col"">" & translate("Şehir","","") & "</th>"
							Response.Write "<th scope=""col"">" & translate("Firma Türü","","") & "</th>"
							Response.Write "<th scope=""col"" class=""text-right"">" & translate("Entegrasyon","","")
							Response.Write "</th>"
								Response.Write "<th scope=""col"" class=""text-right"">" & translate("İşlem","","") & "</th>"
							Response.Write "</tr>"
						Response.Write "</thead><tbody>"
							for i = 1 to rs.recordcount
								cariID			=	rs("cariID")
								cariID64	 	=	cariID
								cariID64		=	base64_encode_tr(cariID64)
								cariKodu		=	rs("cariKodu")
								cariAd			=	rs("cariAd")
								telefon			=	rs("telefon")
								email			=	rs("email")
								il				=	rs("il")
								cariTur			=	rs("cariTur")
								durum			=	rs("silindi")
								manuelKayit		=	rs("manuelKayit")
								Response.Write "<tr>"
									Response.Write "<td>" & cariKodu & "</td>"
									Response.Write "<td>" & cariAd & "</td>"
									Response.Write "<td>" & kvkkMaske(telefon,6,yetkiKontrol) & "</td>"
									Response.Write "<td>" & kvkkMaske(email,6,yetkiKontrol) & "</td>"
									Response.Write "<td>" & il & "</td>"
									Response.Write "<td>" & arrayDegerBulfn(cariTur,sb_cariTurArr) & "</td>"
									Response.Write "<td class=""text-right"">"
									Response.Write truefalse(manuelKayit,"yokvar")
									Response.Write "</td>"
									Response.Write "<td class=""text-right"">"
									if yetkiKontrol >= 5 then
										'# stok düzenle
											Response.Write "<a title=""" & translate("Cari Bilgilerini Düzenle","","") & """"
											Response.Write " onClick=""modalajax('/cari/cari_yeni.asp?gorevID=" & cariID64 & "')"">"
											Response.Write "<i class=""icon page-white-edit parmak"
											Response.Write """></i>"
											Response.Write "</a>"
										'# stok düzenle
									end if
									Response.Write "</td>"
								Response.Write "</tr>"
								Response.Flush()
							rs.movenext
							next
						Response.Write "</tbody>"
						Response.Write "</table>"
						Response.Write "</div>"
					else
						bilgi = translate("Seçtiğiniz kriterlerde kayıt bulunamadı","","")
						call yetkisizGiris(bilgi,"","")
					end if
					rs.close
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	else
		hata = translate("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
		call yetkisizGiris(hata,"","")
	end if
'####### SONUÇ TABLOSU



%><!--#include virtual="/reg/rs.asp" -->