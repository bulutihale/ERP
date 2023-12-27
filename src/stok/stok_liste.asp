<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    rqstokSifirGoster			=   Request.Form("stokSifirGoster")
	rqstokSilinmislerGoster		=   Request.Form("stokSilinmislerGoster")
    rqmamulGoster				=   Request.Form("mamulGoster")
    rqyariMamulGoster			=   Request.Form("yariMamulGoster")
    rqhammaddeGoster			=   Request.Form("hammaddeGoster")
	aramaad		=	trim(Request.Form("aramaad"))
    hata    	=   ""
    modulAd 	=   "Stok"
    Response.Flush()
	call logla("Stok Listesi Ekranı") 
	yetkiKontrol	=	yetkibul("Stok")
	fiyatYetki		=	yetkibul("Satınalma Fiyat")

'###### ANA TANIMLAMALAR


'###### KİŞİSELLEŞTİRİLMİŞ AYARLARI OKU
	if rqstokSifirGoster <> "" then
		stokSifirGoster = rqstokSifirGoster
		call personelAyarGuncelle("stokSifirGoster",rqstokSifirGoster,kid)
	end if
	if rqstokSilinmislerGoster <> "" then
		stokSilinmislerGoster = rqstokSilinmislerGoster
		call personelAyarGuncelle("stokSilinmislerGoster",rqstokSilinmislerGoster,kid)
	end if
	if rqmamulGoster <> "" then
		mamulGoster = rqmamulGoster
		call personelAyarGuncelle("mamulGoster",rqmamulGoster,kid)
	end if
	if rqyariMamulGoster <> "" then
		yariMamulGoster = rqyariMamulGoster
		call personelAyarGuncelle("yariMamulGoster",rqyariMamulGoster,kid)
	end if
	if rqhammaddeGoster <> "" then
		hammaddeGoster = rqhammaddeGoster
		call personelAyarGuncelle("hammaddeGoster",rqhammaddeGoster,kid)
	end if
	if stokSifirGoster = "" then
		stokSifirGoster = "on"
	end if
	if stokSilinmislerGoster = "" then
		stokSilinmislerGoster = "off"
	end if
	if mamulGoster = "on" then
		mDurum = "1"
	else
		mDurum = "0"
	end if
	if yariMamulGoster = "on" then
		ymDurum = "2"
	else
		ymDurum = "0"
	end if
	if hammaddeGoster = "on" then
		hmDurum = "4"
	else
		hmDurum = "0"
	end if

'###### KİŞİSELLEŞTİRİLMİŞ AYARLARI OKU




'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
					Response.Write "<form action=""/stok/stok_liste"" method=""post"" id=""listebuttonform"">"
						call formhidden("stokSifirGoster",stokSifirGoster,"","","","","stokSifirGoster","")
						call formhidden("stokSilinmislerGoster",stokSilinmislerGoster,"","","","","stokSilinmislerGoster","")
						call formhidden("mamulGoster",mamulGoster,"","","","","mamulGoster","")
						call formhidden("yariMamulGoster",yariMamulGoster,"","","","","yariMamulGoster","")
						call formhidden("hammaddeGoster",hammaddeGoster,"","","","","hammaddeGoster","")
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Ürün Adı","","") & """ name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 5 then
								Response.Write "<div class=""col-lg-9 my-1 text-right"">"
									if stokSifirGoster = "on" then
										Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSifirGoster').val('off');$('#listebuttonform').submit();"">" & translate("Stok Sıfır Olanları Gizle","","") & "</button>"
									else
										Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSifirGoster').val('on');$('#listebuttonform').submit();"">" & translate("Stok Sıfır Olanları Göster","","") & "</button>"
									end if
									if stokSilinmislerGoster = "on" then
										Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSilinmislerGoster').val('off');$('#listebuttonform').submit();"">" & translate("Silinmişleri Gizle","","") & "</button>"
									else
										Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSilinmislerGoster').val('on');$('#listebuttonform').submit();"">" & translate("Silinmişleri Göster","","") & "</button>"
									end if
									Response.Write "<button type=""button"" class=""btn btn-warning mr-2"" onClick=""modalajax('/stok/import.asp')"">" & translate("Veri Aktarımı","","") & "</button>"
									' Response.Write "<button type=""button"" class=""btn btn-warning mr-2"" onClick=""netsisSenk('" & firmaStokDB & "')"">" & translate("Muhasebe Yazılımı ile Senkronize Et","","") & "</button>"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/stok/stok_yeni.asp')"">" & translate("Yeni Ürün Ekle","","") & "</button>"
								Response.Write "</div>"
							end if
						Response.Write "</div>"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-12 text-right"">"
								if mamulGoster = "on" then
									Response.Write "<button type=""button"" class=""btn btn-danger mr-2"" onClick=""$('#mamulGoster').val('off');$('#listebuttonform').submit();"">Mamulleri gizle</button>"
								else
									Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#mamulGoster').val('on');$('#listebuttonform').submit();"">Mamulleri Göster</button>"
								end if
								if yariMamulGoster = "on" then
									Response.Write "<button type=""button"" class=""btn btn-danger mr-2"" onClick=""$('#yariMamulGoster').val('off');$('#listebuttonform').submit();"">Yarı mamulleri gizle</button>"
								else
									Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#yariMamulGoster').val('on');$('#listebuttonform').submit();"">Yarı mamulleri göster</button>"
								end if
								if hammaddeGoster = "on" then
									Response.Write "<button type=""button"" class=""btn btn-danger mr-2"" onClick=""$('#hammaddeGoster').val('off');$('#listebuttonform').submit();"">Hammaddeleri gizle</button>"
								else
									Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#hammaddeGoster').val('on');$('#listebuttonform').submit();"">Hammaddeleri göster</button>"
								end if
							Response.Write "</div>"
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
					sorgu = "SELECT" 
					sorgu = sorgu & " t1.stokID,"
					'sorgu = sorgu & " stok.FN_stokSay(" & firmaID & ", t1.stokID) as stokMiktar,"
					sorgu = sorgu & " t1.stokKodu,"
					sorgu = sorgu & " t1.stokAd,"
					sorgu = sorgu & " t1.stokBarcode,"
					sorgu = sorgu & " t1.stokTuru,"
					sorgu = sorgu & " t1.manuelKayit,"
					sorgu = sorgu & " t1.silindi,"
					sorgu = sorgu & " portal.birimler.uzunBirim as urunAnaBirimAd"
					sorgu = sorgu & " FROM stok.stok t1"
					sorgu = sorgu & " LEFT JOIN portal.birimler ON t1.anaBirimID = portal.birimler.birimID"
					sorgu = sorgu & " WHERE"
					sorgu = sorgu & " t1.firmaID =" & firmaID
						if mDurum <> "0" OR ymDurum <> "0" OR hmDurum <> "0" then
							sorgu = sorgu & " AND t1.stokTuru IN (" & mDurum & "," & ymDurum & "," & hmDurum & ")"
						end if
						if aramaad <> "" then
							sorgu = sorgu & " and (t1.stokAd like N'%" & aramaad & "%' OR t1.stokBarcode like N'%" & aramaad & "%' OR t1.stokKodu like N'%" & aramaad & "%')"
						end if
						if stokSifirGoster = "off" then
							sorgu = sorgu & " AND stok.FN_stokSay(" & firmaID & ", t1.stokID) > 0"
						end if
						if stokSilinmislerGoster = "on" then
							sorgu = sorgu & " AND t1.silindi = 0"
						end if
					sorgu = sorgu & " ORDER BY t1.stokKodu ASC"
					rs.open sorgu, sbsv5, 1, 3


					if rs.recordcount > 0 then
						Response.Write "<div class=""table-responsive"">"
						Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark"">"
							Response.Write "<tr>"
							Response.Write "<th scope=""col"">" & translate("Ürün Kodu","","") & "</th>"
							Response.Write "<th scope=""col"">" & translate("Ürün Adı","","") & "</th>"
							Response.Write "<th scope=""col"">" & translate("Barkod","","") & "</th>"
							if fiyatYetki > 0 then
								Response.Write "<th scope=""col"">Son Alış Fiyat</th>"
							end if
							Response.Write "<th scope=""col"" class=""text-center"">" & translate("Stok Miktarı","","")
							Response.Write "</th>"
							Response.Write "<th scope=""col"" class=""text-center"">" & translate("Stok Türü","","") & "</th>"
							Response.Write "<th scope=""col"" class=""text-center"">" & translate("Durum","","") & "</th>"
							Response.Write "<th scope=""col"" class=""text-center"">Depolar</th>"
							if yetkiKontrol >= 5 then
								Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
							end if
							Response.Write "</tr>"
						Response.Write "</thead><tbody>"
							for i = 1 to rs.recordcount
							Response.Flush()
								stokID			=	rs("stokID")
								stokID64	 	=	stokID
								stokID64		=	base64_encode_tr(stokID64)
								stokKodu		=	rs("stokKodu")
								stokAd			=	rs("stokAd")
								urunAnaBirim	=	rs("urunAnaBirimAd")
								stokTuru		=	rs("stokTuru")
								stokBarcode		=	rs("stokBarcode")
								'stokMiktar		=	rs("stokMiktar")
								durum			=	rs("silindi")
								manuelKayit		=	rs("manuelKayit")
								Response.Write "<tr>"
									Response.Write "<td>" & stokKodu & "</td>"
									Response.Write "<td>" & stokAd & "</td>"
									Response.Write "<td>" & stokBarcode & "</td>"
							if fiyatYetki > 0 then
									Response.Write "<td class=""text-right"" onmouseenter=""working('fiyat_"& stokID &"','20px','20px');$('#fiyat_"& stokID &"').load('/stok/urun_fiyat_bul.asp?stokID="&stokID&"');$('#fiyat_"& stokID &"').attr('id','');"">"
										Response.Write "<div id=""fiyat_"& stokID &""" class=""text-right pointer""><i class=""icon arrow-refresh-small""></i></div>"
									Response.Write "</td>"
							end if
									Response.Write "<td class=""text-right"" onmouseenter=""working('stokID_"& stokID &"','20px','20px');$('#stokID_"& stokID &"').load('/stok/urun_miktar_bul.asp?stokID="&stokID&"&birimGonder=3');$('#stokID_"& stokID &"').attr('id','');"">"
										Response.Write "<div id=""stokID_"& stokID &""" class=""text-right pointer""><i class=""icon arrow-refresh-small""></i></div>"
									Response.Write "</td>"
									Response.Write "<td class=""text-right"">"
									if stokTuru = "" then
										Response.Write translate("Tanımlanmamış","","")
									else
										Response.Write arrayDegerBulfn(stokTuru,stokTurDegerler)
									end if
									Response.Write "</td>"
									Response.Write "<td class=""text-right"">" & silindiArr(durum) &  "</td>"
									Response.Write "<td class=""text-right"">"
										'if stokMiktar > 0 then
											Response.Write "<div title=""" & translate("Depolara göre ürün sayıları","","") & """ class=""text-center pointer mr-2"""
												Response.Write " onClick=""modalajax('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "');"">"
												Response.Write "<i class=""icon report-magnify""></i>"
											Response.Write "</div>"
										'end if
									Response.Write "</td>"
									Response.Write "<td class=""text-right"">"
									Response.Write "<div class=""d-flex justify-content-between"">"
									if yetkiKontrol >= 5 then
									Response.Write "<div>"
										'# stok düzenle
											Response.Write "<a title=""" & translate("Ürün Bilgilerini Düzenle","","") & """"
											Response.Write " onClick=""modalajax('/stok/stok_yeni.asp?gorevID=" & stokID64 & "')"">"
											Response.Write "<i class=""icon page-white-edit pointer"
											Response.Write """></i>"
											Response.Write "</a>"
										'# stok düzenle
									Response.Write "</div>"
									Response.Write "<div>"
										'# koli tanımla
											Response.Write "<a title=""Ürün bazında koli tanımları"" class=""ml-2"""
											Response.Write " onClick=""modalajax('/stok/urun_koli_esle.asp?gorevID=" & stokID64 & "')"">"
											Response.Write "<i class=""icon package-add pointer"
											Response.Write """></i>"
											Response.Write "</a>"
										'# koli tanımla
									Response.Write "</div>"
									end if
									Response.Write "<div>"
										'# foto ekle
											Response.Write "<a title=""Ürün görselleri"" class=""ml-2"""
											Response.Write " onClick=""modalajax('/dosya/upload_liste.asp?gorevID=" & stokID & "&gorev=urunGorsel')"">"
											Response.Write "<i class=""icon images pointer"
											Response.Write """></i>"
											Response.Write "</a>"
										'# foto ekle
									Response.Write "</div>"
									Response.Write "</div>"
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

<script>
	// function netsisSenk(netsisStdb) {
	// 	$.post("/stok/stok_netsis_getir.asp", {
	// 		netsisStdb:netsisStdb
	// 	});
	// }
</script>