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

	fasonAnaID			=	Request("fasonAnaID")

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	if yetkiKontrol = 0 then
		call yetkisizGiris("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
	else

	sorgu = "SELECT t2.stokAd, t1.id as ajandaID"
	sorgu = sorgu & " FROM portal.ajanda t1"
	sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.fasonAnaID = " & fasonAnaID
	rs.open sorgu, sbsv5, 1, 3
		if rs.recordcount = 0 then
			Response.Write "kayıt yok"
		else
			stokAd			=	rs("stokAd")
			ajandaID		=	rs("ajandaID")

			Response.Write "<div class=""card-header text-center bold"">"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-1 btn btn-sm rounded btn-secondary"" "
						Response.Write " onclick=""listeOnayla('onayListe'," & fasonAnaID & ")"" "
						Response.Write " data-toggle=""popoverModal"" "
						Response.Write " title="""&repAscii("toplu onay, işaretli tüm ürünlerin fason depoya kabul işlemini onayla.")&""">"
						Response.Write "<i class=""icon tick""></i>"
					Response.Write "</div>"
					Response.Write "<div class=""col-11"">" & stokAd & "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		end if
	rs.close

	sorgu = "SELECT t1.id as ajandaID, t2.stokKodu, t2.stokAd,"
	sorgu = sorgu & " [stok].[FN_anaBirimADBul] ( t1.stokID, 'kAD' ) as mikBirim, t3.lot, t3.refHareketID, t3.stokHareketTuru,"
	sorgu = sorgu & " t3.stokHareketID, t4.belgeNo, t4.gonderimZamani,"
	sorgu = sorgu & " CASE WHEN t3.miktar is null THEN t1.miktar ELSE t3.miktar END as miktar,"
	sorgu = sorgu & " CASE"
		sorgu = sorgu & " WHEN"
			sorgu = sorgu & " t3.stokHareketTuru = 'GB'"
		sorgu = sorgu & " THEN"
			sorgu = sorgu & " '<input type=""checkbox"" checked=""checked"" value=""' + CAST(t3.stokHareketID AS NVARCHAR) + '"" data-toggle=""popoverModal"" title="""&repAscii("ürün hazırlanmış onay için bekliyor, tik işareti varsa toplu onay işleminde onay verilir ve fason depoya çıkışı yapılır.")&""">'"
		sorgu = sorgu & " END as stokHareketTuruChck,"
	sorgu = sorgu & " CASE WHEN t1.fasonMiktarKilit = 1 THEN '<i class=""fa fa-lock text-success help"" data-toggle=""popoverModal"" title="""&repAscii("fason modülü içerisindeki reçete kalem listesinde kayıtlı miktarlar ajandaya kilitlenmiş.")&"""></i>' ELSE '<i class=""fa fa-unlock text-danger help"" data-toggle=""popoverModal"" title=""miktar KİLİTLENMEMİŞ""></i>' END as miktarKilit,"
	sorgu = sorgu & " CASE" 
		sorgu = sorgu & " WHEN"
			sorgu = sorgu & " t3.stokHareketTuru = 'GB'"
		sorgu = sorgu & " THEN"
			sorgu = sorgu & " '<i class=""fa fa-truck text-danger help"" data-toggle=""popoverModal"" title="""&repAscii("çıkış onayı bekliyor. gönderim için mal kabul depodan çıkış işlemi yapılmış ancak fason depoya kabul işlemi yapılmamış")&"""></i>'"
		sorgu = sorgu & " WHEN"
			sorgu = sorgu & " t3.stokHareketTuru = 'G'"
		sorgu = sorgu & " THEN"
			sorgu = sorgu & " '<i class=""fa fa-building text-warning help"" data-toggle=""popoverModal"" title="""&repAscii("ürün, fason üreticiye teslim edilmiş.")&"""></i>'"
		sorgu = sorgu & " WHEN"
			sorgu = sorgu & " t3.stokHareketTuru is null"
		sorgu = sorgu & " THEN"
			sorgu = sorgu & " '<i class=""fa fa-cube help"" data-toggle=""popoverModal"" title=""" & repAscii("fason depoya çıkış yapılmamış") & """></i>'"
		sorgu = sorgu & " END as stokHareketTuruIkon"
	sorgu = sorgu & " FROM portal.ajanda t1"
	sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
	sorgu = sorgu & " LEFT JOIN stok.stokHareket t3 ON t1.id = t3.ajandaID AND t3.stokHareketTuru IN ('GB','G') AND t3.silindi = 0"
	sorgu = sorgu & " LEFT JOIN fason.fasonDetay t4 ON t3.stokHareketID = t4.gidisStokHareketID"
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.isTur = 'transfer' AND t1.bagliAjandaID = " & ajandaID & ""
	sorgu = sorgu & " ORDER BY t4.belgeNo DESC"
	'Response.Write sorgu
	'Response.end
	rs.open sorgu, sbsv5, 1, 3

	'Response.Write "<div class=""card-body"">"
		Response.Write "<div class=""container"">"

			Response.Write "<div class=""row text-center bold"">"
				Response.Write "<div class=""col-1""></div>"
				Response.Write "<div class=""col-5"">Ürün</div>"
				Response.Write "<div class=""col-3"">LOT</div>"
				Response.Write "<div class=""col-3"">Miktar</div>"
			Response.Write "</div>"
		
		Response.Write "<form id=""onayListe"" action=""/fason/cikis_onay.asp"">"
oncekiBelgeNo		=	""
		for yi = 1 to rs.recordcount
		ajandaID			=	rs("ajandaID")
		ajandaID64			=	ajandaID
		ajandaID64			=	base64_encode_tr(ajandaID64)
		miktar				=	rs("miktar")
		mikBirim			=	rs("mikBirim")
		stokKodu			=	rs("stokKodu")
		stokAd				=	rs("stokAd")
		lot					=	rs("lot")
		miktarKilit			=	rs("miktarKilit")
		stokHareketTuruIkon	=	rs("stokHareketTuruIkon")
		stokHareketTuruChck	=	rs("stokHareketTuruChck")
		refHareketID		=	rs("refHareketID")
		stokHareketTuru		=	rs("stokHareketTuru")
		stokHareketID		=	rs("stokHareketID")
		belgeNo				=	rs("belgeNo")
		gonderimZamani		=	rs("gonderimZamani")

		if belgeNo <> oncekiBelgeNo then
			Response.Write "<div class=""mt-2 border-top border-dark"">" & belgeNo & " - " & gonderimZamani &"</div>"
		end if
			Response.Write "<div id=""kalemDiv"&ajandaID&""" class=""row fontkucuk mt-2 hoverGel pointer rounded"">"
				Response.Write "<div class=""col-2 text-center"">"
					Response.Write "<div class=""row"">"
						Response.Write "<div class=""col m-0 p-0"">"
						 	if stokHareketTuru = "GB" then
								Response.Write "<input type=""checkbox"" name=""listeStokHareketID[]"" class=""chckOnayUrun"" checked=""checked"" value=""" & stokHareketID & """ data-toggle=""popoverModal"" title="""&repAscii("ürün hazırlanmış onay için bekliyor, tik işareti varsa toplu onay işleminde onay verilir ve fason depoya çıkışı yapılır.")&""">"
								'Response.Write "<input type=""checkbox"" name=""c"&yi&""" class=""chckOnayUrun"" checked=""checked"" value=""" & stokHareketID & """>"
							end if
						Response.Write "</div>"
						Response.Write "<div class=""col m-0 p-0"">" & miktarKilit & "</div>"
						Response.Write "<div class=""col m-0 p-0"">" & stokHareketTuruIkon & "</div>"
						if stokHareketTuru = "GB" then
						Response.Write "<div class=""col m-0 p-0 help"" "
							Response.Write " data-toggle=""popoverModal"" "
							Response.Write " title=""" & repAscii("ürünün fason depoya girişi red edilsin,  ana depo çıkış işlemi iptal edilerek çıkış yapılan depo stoklarına geri alınsın.") & """"
							Response.Write " onclick=""urunCevap('red','stokHareketID',"&stokHareketID&",'silindi','stok.stokHareket','1'," & refHareketID & " ,'depoRed','','kalemDiv"&ajandaID&"','fasonCevap','','" & ajandaID64 & "','','','','','','"&fasonAnaID&"')"""
							Response.Write ">"
							Response.Write "<i class=""icon cancel""></i>"
						Response.Write "</div>"
						end if
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""col-4"">" & stokKodu & "<br>" & stokAd & "</div>"
				Response.Write "<div class=""col-3 text-right"">" & lot & "</div>"
				Response.Write "<div class=""col-3 text-right"">" & miktar & " " & mikBirim & "</div>"
			Response.Write "</div>"
		oncekiBelgeNo		=	belgeNo
		rs.movenext
			if not rs.EOF then
				sonrakiBelgeNo				=	rs("belgeNo")
				if belgeNo <> sonrakiBelgeNo OR isnull(sonrakiBelgeNo) then
					Response.Write "<div class=""mt-2 border-bottom border-danger""></div>"
				end if
			end if
		next
		Response.Write "</form>"
		Response.Write "</div>"
	'Response.Write "</div>"

	rs.close




	end if
%><!--#include virtual="/reg/rs.asp" -->










