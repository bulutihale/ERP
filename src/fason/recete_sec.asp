<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    call sessiontest()
    kid		=	kidbul()

	modulAd 		=   "Fason" 

	'##### YETKİ BUL
	'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
	'##### YETKİ BUL
	'##### YETKİ BUL

	siparisKalemID			=	Request("id")
	mamulStokID				=	Request("stokID")
	fasonAnaID				=	Request("fasonAnaID")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()

call logla("Fason planlaması için reçete seçimi siparisKalemID: " & siparisKalemID & "")


			sorgu = "SELECT miktar as fasonFirmaMiktar FROM fason.fasonAna WHERE id = " & fasonAnaID
			rs.open sorgu, sbsv5, 1, 3
				fasonFirmaMiktar	=	rs("fasonFirmaMiktar")
			rs.close

            sorgu = "SELECT"
			sorgu = sorgu & " t1.sipMiktar, t1.miktarFason, t1.mikBirim"
			sorgu = sorgu & " FROM teklif.siparisKalem t1"
			sorgu = sorgu & " WHERE t1.id = " & siparisKalemID
			rs.open sorgu, sbsv5, 1, 3

				sipMiktar	=	rs("sipMiktar")
				miktarFason	=	rs("miktarFason")
				mikBirim	=	rs("mikBirim")
			rs.close

            sorgu = "SELECT"
			sorgu = sorgu & " t1.receteID"
			sorgu = sorgu & " FROM portal.ajanda t1"
			sorgu = sorgu & " WHERE t1.siparisKalemID = " & siparisKalemID & " AND t1.silindi = 0"
			rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				receteID	=	rs("receteID")
			end if
			rs.close

            sorgu = "SELECT"
			sorgu = sorgu & " t1.receteID, t1.stokID as mamulStokID, t2.stokKodu, t2.stokAd, t1.receteID, t3.receteAd"
			sorgu = sorgu & " FROM portal.ajanda t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " INNER JOIN recete.recete t3 ON t1.receteID = t3.receteID"
			sorgu = sorgu & " WHERE t1.siparisKalemID = " & siparisKalemID & " AND t1.silindi = 0"
			sorgu = sorgu & " AND t1.fasonAnaID = " & fasonAnaID
			rs.open sorgu, sbsv5, 1, 3


				
		Response.Write "<div id=""recetelerDIV"" class=""card mt-3"">"
			Response.Write "<div class=""row"">"
			Response.Write "</div>"
		Response.Write "<div class=""card-header text-white bg-info"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-lg-3 col-sm-6 text-left"">Reçeteler</div>" 
			Response.Write "</div>"
		Response.Write "</div>"
			if rs.recordcount > 0 then

			Response.Write "<div class=""card-body"">"
					Response.Write "<div class=""row mt-2 border-dark border-bottom bold text-center"">"
						Response.Write "<div class=""col-lg-2 col-sm-4"">FASON MİKTAR</div>"
						Response.Write "<div class=""col-lg-3 col-sm-4"">ÜRÜN</div>"
						Response.Write "<div class=""col-lg-3 col-sm-4"">REÇETE</div>"
					Response.Write "</div>"
				for di = 1 to rs.recordcount
					mamulStokID		=	rs("mamulStokID")
					receteID		=	rs("receteID")
					receteAd		=	rs("receteAd")
					stokKodu		=	rs("stokKodu")
					stokAd			=	rs("stokAd")
					Response.Write "<div class=""row mt-2 border-warning border-bottom"">"
						Response.Write "<div class=""col-lg-2 col-sm-4 text-center""><span class=""bg-warning rounded bold p-1"">" & fasonFirmaMiktar &  " " & mikBirim & "</span></div>"
						Response.Write "<div class=""col-lg-4 col-sm-4""><span class=""font-italic"">" & stokKodu &  " - " & stokAd & "</span></div>"
						Response.Write "<div class=""col-lg-3 col-sm-4"">" & receteAd &  "</div>"
						Response.Write "<div class=""col-lg-3 col-sm-4""><div onclick=""working('divReceteKalemler','30px','30px');$('#divReceteKalemler').load('/fason/recete_kalem.asp',{receteID:"&receteID&",siparisKalemID:"&siparisKalemID&",fasonAnaID:"&fasonAnaID&"})"" class=""btn btn-sm btn-secondary"">reçete kalemleri</div></div>"
					Response.Write "</div>"
				rs.movenext
				next
			Response.Write "</div>"
			else
				Response.Write "<div class=""container"">"
					if cdbl(sipMiktar) > cdbl(miktarFason) then
						if receteID = "" then
				'######## siparişin tamamı fason değil bir kısmını kendimiz üreteceğiz ama reçete seçimi yapılmamış
					Response.Write "<div class=""row"">"
						Response.Write "<div class=""m-5 text-danger rounded""><span class=""bold"">Üretim Planlaması yapılmamış ve reçete seçilmemiş, (üretim planlaması modülü kullanılarak) reçete seçildikten sonra fason modülünde işleme devam edilebilir.</span> <br><span class=""font-italic fontkucuk2"">Siparişin bir kısmı tarafımızca üretilecek ve kalan kısmı fason üretici tarafından üretilecekse öncelikle kendi üretimimizin planlanması ve reçetesinin seçilmesi gerekir.</span> </div>"
					Response.Write "</div>"
				'######## /siparişin tamamı fason değil bir kısmını kendimiz üreteceğiz ama reçete seçimi yapılmamış
					else
					Response.Write "<div class=""row"">"
						Response.Write "<div class=""m-5 text-success bold rounded"">Üretim Planlaması yapılmış ve reçete seçilmiş, fason üreticiye hammadde ve yarımamullerin gönderileceği tarih seçilmeli.</div>"
					Response.Write "</div>"
					Response.Write "<div class=""row"">"
Response.Write "<div class=""btn btn-sm btn-info border rounded"" onclick=""modalajaxfit('/ajanda/ajanda.asp?yer=modal&isTur=fason&siparisKalemID=" & siparisKalemID & "&receteID="&receteID&"&fasonAnaID="&fasonAnaID&"')"">SEÇ</div>"
					Response.Write "</div>"
						'Response.End()
					end if
					else
					'###### siparişin tamamı fasona gidecek ama reçete seçilmesi lazım
							Response.Write "<div class=""row mt-4"">"
								Response.Write "<div class=""col bold text-danger"">Siparişteki ürünlerin tamamı fason sürecine yönlendirilmiş ve reçete seçilmemiş, reçete olmadan fason üretim planlanamaz.</div>"
							Response.Write "</div>"
							Response.Write "<div class=""row mt-4"">"
								Response.Write "<div class=""btn btn-danger"" onclick=""modalajaxfit('/recete/recete_sec.asp?cariID=0&stokID="&mamulStokID&"&yer=modal&isTur=fason&siparisKalemID="&siparisKalemID&"&fasonAnaID="&fasonAnaID&"')"">Reçete Seç</div>"
							Response.Write "</div>"
					'###### /siparişin tamamı fasona gidecek ama reçete seçilmesi lazım
					end if
				Response.Write "</div>"
			
			end if
		Response.Write "</div>"
			rs.close

		'################### /REÇETE ID BUL, cariye özel reçete var mı?
		'################### /REÇETE ID BUL, cariye özel reçete var mı?



%><!--#include virtual="/reg/rs.asp" -->






