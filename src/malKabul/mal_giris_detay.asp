<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	siparisKalemID	=	Request.Querystring("siparisKalemID")
	stokID			=	Request.Querystring("stokID")
    modulAd =   "Mal Kabul"
    modulID =   "89"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	yetkiKontrol	= yetkibul(modulAd)
	satinalmaYetki	= yetkibul("Satın Alma")
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
		Response.Write "<div class=""text-right"" data-dismiss=""modal""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr class=""text-center"">"
		Response.Write "<th scope=""col""></th>"
		Response.Write "<th scope=""col"">Kod</th>"
		Response.Write "<th scope=""col"">Ürün Adı</th>"
		Response.Write "<th scope=""col"">Miktar</th>"
		Response.Write "<th scope=""col"">LOT</th>"
		Response.Write "<th scope=""col"">Belge No</th>"
		Response.Write "<th scope=""col"">Belge Tarih</th>"
		Response.Write "<th scope=""col"">Açıklama</th>"
		Response.Write "<th scope=""col"">Görsel</th>"
		Response.Write "</tr></thead><tbody>"
		
            sorgu = "SELECT"
			sorgu = sorgu & " t1.stokHareketID, t1.stokKodu, t1.miktar, t1.miktarBirim, t1.belgeNo, t1.belgeTarih, t2.stokAd, t1.aciklama, t1.lot"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.siparisKalemID = " & siparisKalemID & " AND t1.stokID = " & stokID & " AND t1.silindi = 0"
			sorgu = sorgu & " ORDER BY t1.tarih"
			rs.open sorgu, sbsv5, 1, 3
' response.Write sorgu
			
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					stokHareketID		=	rs("stokHareketID")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					aciklama			=	rs("aciklama")
					aciklamaL			=	LEFT(aciklama,20)
					if LEN(aciklama) > 20 then aciklamaL = aciklamaL&"..." end if 
					miktar				=	rs("miktar")
					miktarBirim			=	rs("miktarBirim")
					belgeNo				=	rs("belgeNo")
					belgeTarih			=	rs("belgeTarih")
					lot					=	rs("lot")
					
				

					
					Response.Write "<tr>"
						Response.Write "<td class=""text-center"">"
							if yetkiKontrol >= 8 OR satinalmaYetki > 5 then
							Response.Write "<span"
						Response.Write " onClick=""bootmodal('Silinsin mi?','custom','/malKabul/stok_hareket_sil.asp?stokHareketID="&stokHareketID&"','','SİL','İPTAL','','','','ajax','','','')"""
							Response.Write " class=""btn btn-sm border rounded fontkucuk2 bg-danger"">"
								Response.Write "<i class=""mdi mdi-delete-forever""></i>"
							Response.Write "</span>"
							end if
						Response.Write "</td>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>" & stokAd & "</td>"
						Response.Write "<td class=""text-right"">" & miktar & " " & miktarBirim & "</td>"
						Response.Write "<td class=""text-right"">" & lot & "</td>"
						Response.Write "<td class=""text-center"">" & belgeNo & "</td>"
						Response.Write "<td class=""text-center"">" & belgeTarih & "</td>"
						Response.Write "<td class=""text-center pointer"" onclick=""$(this).html('" & aciklama & "')"">" & aciklamaL & "</td>"
						Response.Write "<td class=""text-center"">"
							Response.Write "<div>"
								'# foto ekle
									Response.Write "<a title=""Gelen ürün görseli yüklemek için tıklayınız"" class=""ml-2"""
									Response.Write " onClick=""modalajax('/dosya/upload_liste.asp?gorevID=" & stokHareketID & "&gorev=malKabulGorsel')"">"
									Response.Write "<i class=""icon images pointer"
									Response.Write """></i>"
									Response.Write "</a>"
								'# foto ekle
							Response.Write "</div>"
						Response.Write "</td>"
					Response.Write "</tr>"
					Response.Flush()
				rs.movenext
				next
			end if
			rs.close
			sorgu = "SELECT ISNULL(t1.eksikMiktarKapat,0) as eksikMiktarKapat FROM teklif.siparisKalem t1 WHERE t1.id = " & siparisKalemID
			rs.open sorgu, sbsv5, 1, 3
				eksikMiktarKapat	=	rs("eksikMiktarKapat")
			rs.close
					Response.Write "<tr class=""text-danger bold""><td>&nbsp;</td></tr>"
					Response.Write "<tr class=""text-danger bold"">"
						Response.Write "<td class=""text-center"">İptal Sipariş:</td>"
						Response.Write "<td class=""text-center"">" & eksikMiktarKapat & "</td>"
						Response.Write "<td class=""text-center"">"
						
						if satinalmaYetki > 5 then
							Response.Write "<span class=""btn btn-sm border rounded fontkucuk2 btnEksikKapat bg-danger"" data-islem=""kapamaiptal"" data-deger="""&siparisKalemID&""" data-stokid=""" & stokID & """><i class=""mdi mdi-delete-forever""></i></span>"
						end if
						Response.Write "</td>"
					Response.Write "</tr>"
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU







%>








