<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
	listeTur		=	Request("listeTur")
	stokID64		=	Request("gorevID")
	ekran			=	Request("ekran")
	stokID			=	stokID64
	stokID			=	base64_decode_tr(stokID)

	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("ihtiyaç analizi ekranı stokID: "&stokID)


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then
		sorgu = "SELECT stokKodu, stokAd FROM stok.stok WHERE stokID = " & stokID
		rs.open sorgu,sbsv5,1,3
			stokKodu	=	rs("stokKodu")
			stokAd		=	rs("stokAd")
		rs.close

		Response.Write "<div class=""bold"">" & stokKodu & " - " & stokAd & "</div>"
	if ekran <> "satinalma" then
		Response.Write "<div class=""col-12 text-right"">"
		Response.Write "<div title=""Depolara göre stok sayıları"" class=""badge badge-pill badge-warning pointer"""
			Response.Write " onClick=""modalajax('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "');"">"
			Response.Write "<i class=""mdi mdi-numeric-9-plus-box-multiple-outline""></i>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if

		sorgu = "SELECT t1.id as ajandaID, t1.bagliAjandaID,"
		sorgu = sorgu & " ISNULL([stok].[FN_receteMiktarBul](t1.id), 1 ) as receteMiktar,"
		sorgu = sorgu & " DATEFROMPARTS(t1.hangiYil, t1.hangiAy, t1.hangiGun) as planTarih,"
		if listeTur = "uretimPlan" then
			sorgu = sorgu & " [stok].[FN_siparisMiktarBul](t1.id, " & firmaID & ") as sipMiktar,"
		elseif listeTur = "kesimPlan" OR listeTur = "transfer" OR listeTur = "kucukKesim" then
			sorgu = sorgu & " [stok].[FN_siparisMiktarBul]( CASE WHEN t1.manuelPlan = 1 THEN t1.id ELSE t1.bagliAjandaID END, " & firmaID & ") as sipMiktar,"
		end if
		sorgu = sorgu & " [stok].[FN_anaBirimADBul](t1.stokID,'kAd') as anaBirim"
		sorgu = sorgu & " FROM portal.ajanda t1"
		sorgu = sorgu & " WHERE t1.stokID = " & stokID & " AND t1.isTur = '" & listeTur & "' AND t1.silindi = 0 AND t1.tamamlandi = 0"
		sorgu = sorgu & " ORDER BY DATEFROMPARTS(t1.hangiYil, t1.hangiAy, t1.hangiGun) ASC"
		rs.open sorgu,sbsv5,1,3
			if rs.recordcount > 0 then
			Response.Write "<div id=""ihtiyacTablo"">"
				Response.Write "<table class=""mt-3"" border=""1"" style=""width:100%"">"
					Response.Write "<thead><tr class=""text-center bold"">"
					Response.Write "<td>Planlanan Kullanım Tarihi</td>"
					Response.Write "<td>İhtiyaç Miktar</td>"
				Response.Write "</tr></thead><tbody>"
				genelIhtiyac = 0
				for zi = 1 to rs.recordcount
				
					ajandaID			=	rs("ajandaID")
					bagliAjandaID		=	rs("bagliAjandaID")
					sipMiktar			=	rs("sipMiktar")
					receteMiktar		=	rs("receteMiktar")
					toplamIhtiyac		=	sipMiktar * receteMiktar
					genelIhtiyac		=	genelIhtiyac + toplamIhtiyac
					planTarih			=	rs("planTarih")
					anaBirim			=	rs("anaBirim")

					Response.Write "<tr>"
						Response.Write "<td>" & tarihtr(planTarih) & "</td>"
						Response.Write "<td class=""text-right""><span class=""help"" data-toggle=""popoverModal"" title=""Bu tarih dahil toplam ihtiyaç:<span class='text-danger'> " & genelIhtiyac & "</span>"">" & toplamIhtiyac & " " & anaBirim &"</span></td>"
						Response.Write "<td class=""text-center"">"
						if ekran <> "satinalma" then
							Response.Write "<span title=""ürün sevki yapılmadan tamamlandı olarak işaretlemek için tıklayın."" onclick=""hucreKaydetGenel('id', "&ajandaID&", 'tamamlandi', 'portal.ajanda', 1, 'işlem tamamlandı olarak işaretlensin mi?', 'ihtiyacTablo', '/uretim/ihtiyac_analiz.asp', 'gorevID_"&stokID64&"**listeTur_"&listeTur&"', '')"">"
								Response.Write "<i class=""icon table-go pointer""></i>"
							Response.Write "<span>"
						end if
						Response.Write "</td>"
					Response.Write "</tr>"
				rs.movenext
				next
				Response.Write "</tbody></table>"
				Response.Write "</div>"
			else
				Response.Write "<div class=""bold"">Kayıt yok</div>"
			end if
		rs.close
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>
