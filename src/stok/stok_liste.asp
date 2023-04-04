<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    rqstokSifirGoster			=   Request.Form("stokSifirGoster")
    rqstokSilinmislerGoster	=   Request.Form("stokSilinmislerGoster")
	aramaad		=	Request.Form("aramaad")
    hata    	=   ""
    modulAd 	=   "Stok"
    Response.Flush()
	call logla("Stok Listesi Ekranı") 
	yetkiKontrol = yetkibul("Stok")
'###### ANA TANIMLAMALAR


'###### KİŞİSELLEŞTİRİLMİŞ AYARLARI OKU
	if rqstokSifirGoster <> "" then
		stokSifirGoster = rqstokSifirGoster
		call personelAyarGuncelle("stokSifirGoster",rqstokSifirGoster,kid)
	end if
	if rqstokSilinmislerGoster <> "" then
		stokSilinmislerGoster = rqstokSilinmislerGoster
		call personelAyarGuncelle("stokSifirGoster",rqstokSilinmislerGoster,kid)
	end if
	if stokSifirGoster = "" then
		stokSifirGoster = "on"
	end if
	if stokSilinmislerGoster = "" then
		stokSilinmislerGoster = "off"
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
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Ürün Adı","","") & """ name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 5 then
								Response.Write "<div class=""col-lg-9 col-sm-3 my-1 text-right"">"
									if stokSifirGoster = "on" then
										Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSifirGoster').val('off');$('#listebuttonform').submit();"">" & translate("Stok Sıfır Olanları Göster","","") & "</button>"
									else
										Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSifirGoster').val('on');$('#listebuttonform').submit();"">" & translate("Stok Sıfır Olanları Gizle","","") & "</button>"
									end if
									if stokSilinmislerGoster = "on" then
										Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSilinmislerGoster').val('off');$('#listebuttonform').submit();"">" & translate("Silinmişleri Gizle","","") & "</button>"
									else
										Response.Write "<button type=""button"" class=""btn btn-info mr-2"" onClick=""$('#stokSilinmislerGoster').val('on');$('#listebuttonform').submit();"">" & translate("Silinmişleri Göster","","") & "</button>"
									end if
									Response.Write "<button type=""button"" class=""btn btn-warning mr-2"" onClick=""modalajax('/stok/import.asp')"">" & translate("Veri Aktarımı","","") & "</button>"
									Response.Write "<button type=""button"" class=""btn btn-warning mr-2"" onClick=""netsisSenk('" & firmaStokDB & "')"">" & translate("Muhasebe Yazılımı ile Senkronize Et","","") & "</button>"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/stok/stok_yeni.asp')"">" & translate("Yeni Ürün Ekle","","") & "</button>"
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
					sorgu = sorgu & "stok.stok.stokID," & vbcrlf
					sorgu = sorgu & "stok.FN_stokSay(7, stok.stok.stokID) as stokMiktar," & vbcrlf
					sorgu = sorgu & "stok.stok.stokKodu," & vbcrlf
					sorgu = sorgu & "stok.stok.stokAd," & vbcrlf
					sorgu = sorgu & "stok.stok.stokBarcode," & vbcrlf
					sorgu = sorgu & "stok.stok.stokTuru," & vbcrlf
					sorgu = sorgu & "stok.stok.manuelKayit," & vbcrlf
					sorgu = sorgu & "stok.stok.silindi," & vbcrlf
					sorgu = sorgu & "portal.birimler.uzunBirim as urunAnaBirimAd"  & vbcrlf
					sorgu = sorgu & "FROM stok.stok" & vbcrlf
					sorgu = sorgu & "LEFT JOIN portal.birimler ON stok.stok.anaBirimID = portal.birimler.birimID" & vbcrlf
					sorgu = sorgu & "WHERE" & vbcrlf
					sorgu = sorgu & "stok.stok.firmaID in (select Id from portal.firma where portal.firma.anaFirmaID = " & firmaID & " OR portal.firma.Id = " & firmaID & ")" & vbcrlf
					' sorgu = sorgu & "AND stok.stok.silindi = 0" & vbcrlf
					if aramaad <> "" then
						sorgu = sorgu & " and (stok.stok.stokAd like N'%" & aramaad & "%' OR stok.stok.stokBarcode like N'%" & aramaad & "%' OR stok.stok.stokKodu like N'%" & aramaad & "%')"
					end if
					if stokSifirGoster = "on" then
						sorgu = sorgu & " AND stok.FN_stokSay(" & firmaID & ", stok.stok.stokID) > 0" & vbcrlf
					end if
					if stokSilinmislerGoster = "on" then
						sorgu = sorgu & " AND stok.stok.silindi = 0" & vbcrlf
					end if
					sorgu = sorgu & "order by stok.stok.stokKodu ASC" & vbcrlf
					rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount > 0 then
						Response.Write "<div class=""table-responsive"">"
						Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark"">"
							Response.Write "<tr>"
							Response.Write "<th scope=""col"">" & translate("Ürün Kodu","","") & "</th>"
							Response.Write "<th scope=""col"">" & translate("Ürün Adı","","") & "</th>"
							Response.Write "<th scope=""col"">" & translate("Barkod","","") & "</th>"
							Response.Write "<th scope=""col"" class=""text-right"">" & translate("Stok Miktarı","","")
							Response.Write "</th>"
							Response.Write "<th scope=""col"" class=""text-right"">" & translate("Stok Türü","","") & "</th>"
							Response.Write "<th scope=""col"" class=""text-right"">" & translate("Durum","","")
							Response.Write "<th scope=""col"" class=""text-right"">" & translate("Entegrasyon","","")
								' Response.Write "<div class=""row"">"
								' 	Response.Write "<div class=""col"">"  & "</div>"
									' Response.Write "<div id=""divDurum"" class=""col p-0 m-0"">"
									' 	Response.Write "<i class=""mdi mdi-arrow-expand text-danger pointer"" title=""" & translate("Pasif ürünleri göster / gizle","","") & """"
									' 		Response.Write " onclick=""working('divDurum',20,20);$('#ortaalan').load('/stok/stok_liste.asp?durum=" & q & "');"">"
									' 	Response.Write "</i>"
									' Response.Write "</div>"
								' Response.Write "</div>"
							Response.Write "</th>"
							if yetkiKontrol >= 5 then
								Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
							end if
							Response.Write "</tr>"
						Response.Write "</thead><tbody>"
							for i = 1 to rs.recordcount
								stokID			=	rs("stokID")
								stokID64	 	=	stokID
								stokID64		=	base64_encode_tr(stokID64)
								stokKodu		=	rs("stokKodu")
								stokAd			=	rs("stokAd")
								urunAnaBirim	=	rs("urunAnaBirimAd")
								stokTuru		=	rs("stokTuru")
								stokBarcode		=	rs("stokBarcode")
								stokMiktar		=	rs("stokMiktar")
								durum			=	rs("silindi")
								manuelKayit		=	rs("manuelKayit")
								Response.Write "<tr>"
									Response.Write "<td>" & stokKodu & "</td>"
									Response.Write "<td>" & stokAd & "</td>"
									Response.Write "<td>" & stokBarcode & "</td>"
									Response.Write "<td class=""text-right"">" & stokMiktar & " " & translate(urunAnaBirim,"","") &"</td>"
									Response.Write "<td class=""text-right"">"
									if stokTuru = "" then
										Response.Write translate("Tanımlanmamış","","")
									else
										Response.Write arrayDegerBulfn(stokTuru,stokTurDegerler)
									end if
									Response.Write "</td>"
									Response.Write "<td class=""text-right"">" & silindiArr(durum) &  "</td>"
									Response.Write "<td class=""text-right"">"
									Response.Write truefalse(manuelKayit,"yokvar")
									Response.Write "</td>"
									Response.Write "<td class=""text-right"">"
									if stokMiktar > 0 then
										Response.Write "<div title=""" & translate("Depolara göre ürün sayıları","","") & """ class=""badge badge-pill badge-warning pointer mr-2"""
											Response.Write " onClick=""modalajax('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "');"">"
											Response.Write "<i class=""mdi mdi-numeric-9-plus-box-multiple-outline""></i>"
										Response.Write "</div>"
									end if
									if yetkiKontrol >= 5 then
										'# stok düzenle
											Response.Write "<a title=""" & translate("Ürün Bilgilerini Düzenle","","") & """"
											Response.Write " onClick=""modalajax('/stok/stok_yeni.asp?gorevID=" & stokID64 & "')"">"
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

            ' sorgu = "SELECT"
			' sorgu = sorgu & " t1.stokID, stok.FN_stokSay(" & firmaID & ", t1.stokID) as stokMiktar, t1.stokKodu, t1.stokAd, t1.stokBarcode," 
			' sorgu = sorgu & " CASE WHEN t1.silindi = 1 THEN '<span class=""text-danger"">PASİF</span>' ELSE 'AKTİF' END as durum, stok.FN_anaBirimADBul(t1.stokID,'kAd') as urunAnaBirim,"
			' sorgu = sorgu & " CASE WHEN t1.stokTuru = '1' THEN 'Mamul' WHEN t1.stokTuru = '2' THEN 'Yarı Mamul' WHEN t1.stokTuru = '3' THEN 'Bileşen' WHEN t1.stokTuru = '4' THEN 'Hammadde' END as stokTuru"
			' sorgu = sorgu & " FROM stok.stok t1" 
			' sorgu = sorgu & " WHERE firmaID = " & firmaID
			' if durum = "tumListe" then
			' else	
			' 	sorgu = sorgu & " AND t1.silindi = 0"
			' end if
			' if durum2 = "" AND  aramaad = "" then
			' 	sorgu = sorgu & " AND stok.FN_stokSay(" & firmaID & ", t1.stokID) > 0"
			' end if		
			' if aramaad = "" then
			' else
			' 	sorgu = sorgu & " and (t1.stokAd like N'%" & aramaad & "%' OR t1.stokBarcode like N'%" & aramaad & "%' OR t1.stokKodu like N'%" & aramaad & "%')"
			' end if
			' sorgu = sorgu & " order by t1.stokKodu, t1.stokAd ASC"



%><!--#include virtual="/reg/rs.asp" -->

<script>
	// function netsisSenk(netsisStdb) {
	// 	$.post("/stok/stok_netsis_getir.asp", {
	// 		netsisStdb:netsisStdb
	// 	});
	// }
</script>