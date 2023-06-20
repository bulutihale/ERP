<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    siparisKalemID	=	Request("siparisKalemID")
	anastokID		=	Request("stokID")
	cariID			=	Request("cariID")
	receteID		=	Request("receteID")
	
	modulAd 		=   "Admin"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
'call logla("Sipariş kalemi maliyet hesabı siparisKalemID:"&siparisKalemID)

yetkiKontrol = yetkibul(modulAd)




	Response.Write "<div class=""text-right""><span data-dismiss=""modal"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
				
		 '### cari için  özel reçete var mı? yoksa normal reçeteyi al
		 		ekSorgu		=	" AND t1.cariID = " & cariID
		 		ekSorgu2	=	" AND t1.cariID = 0"

		 	sorgu = "SELECT t1.receteID"
		 	sorgu = sorgu & " FROM recete.recete t1"
		 	sorgu = sorgu & " WHERE t1.stokID = " & anastokID & " AND t1.silindi = 0 AND t1.firmaID = " & firmaID
		 	ilkSorgu 	=	sorgu & ekSorgu
		 	ikinciSorgu	=	sorgu & ekSorgu2
		 	rs.open ilkSorgu, sbsv5,1,3
		 		if rs.recordcount  = 0 then
		 			rs.close
		 			rs.open ikinciSorgu, sbsv5,1,3
		 			if rs.recordcount = 0 then
		 				call jsrun("swal('','Ürün için reçete oluşturulmamış, maliyet hesaplanamaz.','warning')")
		 				Response.End()
		 			else
						Response.Write "<div class=""col-12"">"
							Response.Write "<div class=""badge badge-warning rounded"">Reçete</div>"
							call formselectv2("receteID","","","","formSelect2 receteID border","","receteID","","data-holderyazi=""Reçete"" data-jsondosya=""JSON_recete"" data-miniput=""0"" data-sartozel=""(stokID="& anastokID & " AND cariID = 0)"" onchange=""$('#anaDIV').load('/satis/recete_maliyet.asp #anaDIV >*',{siparisKalemID:"&siparisKalemID&",stokID:"&anastokID&",cariID:"&cariID&",receteID:$(this).val()})""")
						Response.Write "</div>"
		 			end if
		 		else
					Response.Write "<div class=""col-12"">"
						Response.Write "<div class=""badge badge-warning rounded"">Reçete</div>"
						call formselectv2("receteID","","","","formSelect2 receteID border","","receteID","","data-holderyazi=""Reçete"" data-jsondosya=""JSON_recete"" data-miniput=""0"" data-sartozel=""(stokID="& anastokID & " AND cariID =" & cariID & ")"" onchange=""$('#anaDIV').load('/satis/recete_maliyet.asp #anaDIV >*',{siparisKalemID:"&siparisKalemID&",stokID:"&anastokID&",cariID:"&cariID&",receteID:$(this).val()})""")
					Response.Write "</div>"
		 		end if
		 	rs.close
		 '### cari için  özel reçete var mı? yoksa normal reçeteyi al

Response.Write "<div id=""anaDIV"" class=""scroll-ekle3"">"


if receteID = "" then
	Response.Write "<div class=""container mt-3"">"
		Response.Write "<div class=""row mb-3"">"
			Response.Write "<div class=""col-12 text-danger text-left bold"">Reçete Seçimi yapılmadı.</div>"
		Response.Write "</div>"
	Response.Write "</div>"
else



'######## maliyetin tamamını hesaplamak için "siparisMiktar" bulunmalı eğer sipariş yoksa miktar = 1 olsun
	if siparisKalemID > 0 then
		sorgu = "SELECT"
		sorgu = sorgu & " t3.stokID, t3.stokKodu, t3.stokAd,"
		sorgu = sorgu & " t4.cariAd, t2.cariID,"
		sorgu = sorgu & " t1.miktar as siparisMiktar, t1.mikBirim"
		sorgu = sorgu & " FROM teklif.siparisKalem t1"
		sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
		sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
		sorgu = sorgu & " INNER JOIN cari.cari t4 ON t2.cariID = t4.cariID"
		sorgu = sorgu & " WHERE"
		sorgu = sorgu & " t1.id = " & siparisKalemID & ""
		rs.open sorgu, sbsv5, 1, 3

			anastokID		=	rs("stokID")
			cariID			=	rs("cariID")
			stokKodu		=	rs("stokKodu")
			stokAd			=	rs("stokAd")
			cariAd			=	rs("cariAd")
			siparisMiktar	=	rs("siparisMiktar")
			mikBirim		=	rs("mikBirim")
		rs.close
	else
		siparisMiktar = 1
	end if
'######## maliyetin tamamını hesaplamak için "siparisMiktar" bulunmalı eğer sipariş yoksa miktar = 1 olsun



	'############ iş gücü maliyetini db den çek "firmam --> genel tanımlar menüsünden tanımlanır
		sorgu = "SELECT isgucuSaatlikPara,"
		sorgu = sorgu &" (isgucuSaatlikPara / 60) as isgucuDakikaPara,"
		sorgu = sorgu &" (isgucuSaatlikPara / 3600) as isgucuSaniyePara,"
		sorgu = sorgu &" isgucuSaatlikPB FROM isletme.genelSabit WHERE firmaID = " & firmaID
		rs1.open sorgu, sbsv5, 1, 3
			if rs1.recordcount > 0 then
				isgucuSaatlikPara	=	rs1("isgucuSaatlikPara")
				isgucuDakikaPara	=	rs1("isgucuDakikaPara")
				isgucuSaniyePara	=	rs1("isgucuSaniyePara")
				isgucuSaatlikPB		=	rs1("isgucuSaatlikPB")
			end if
		rs1.close
	'############ iş gücü maliyetini db den çek "firmam --> genel tanımlar menüsünden tanımlanır



	if hata = "" and yetkiKontrol > 2 then

	Response.Write "<div class=""container"">"
		Response.Write "<div class=""row mb-3"">"
			Response.Write "<div class=""col-2 text-danger text-right"">Saat Ücret:</div>"
			Response.Write "<div class=""col-2 bold text-left"">" & isgucuSaatlikPara & " " & isgucuSaatlikPB & "</div>"
			Response.Write "<div class=""col-2 text-info text-right"">Dakika Ücret:</div>"
			Response.Write "<div class=""col-2 bold text-left"">" & isgucuDakikaPara & " " & isgucuSaatlikPB & "</div>"
			Response.Write "<div class=""col-2 text-warning text-right"">Saniye Ücret:</div>"
			Response.Write "<div class=""col-2 bold text-left"">" & isgucuSaniyePara & " " & isgucuSaatlikPB & "</div>"
		Response.Write "</div>"
	Response.Write "</div>"

		sorgu = ""
		sorgu = sorgu & " SELECT "
		sorgu = sorgu & " t1.receteAdimID, t1.islemAciklama, ISNULL(t1.birimMaliyet,0) as birimMaliyet,"
		sorgu = sorgu & " t2.ad as islemAd,"
		sorgu = sorgu & " t1.stokID,"
		sorgu = sorgu & " t3.stokAd,"
		sorgu = sorgu & " t3.stokKodu,"
		sorgu = sorgu & " t1.isGucuSayi,"
		sorgu = sorgu & " t1.miktar,"
		sorgu = sorgu & " t1.miktarBirim,"
		sorgu = sorgu & " t1.sira,"
		sorgu = sorgu & " t1.altReceteID,"
		sorgu = sorgu & " t4.receteAd"
		sorgu = sorgu & " FROM recete.receteAdim t1"
		sorgu = sorgu & " INNER JOIN recete.receteIslemTipi t2 ON t2.receteIslemTipiID =  t1.receteIslemTipiID"
		sorgu = sorgu & " LEFT JOIN stok.stok t3 ON  t3.stokID =  t1.stokID"
		sorgu = sorgu & " LEFT JOIN recete.recete t4 ON  t4.receteID =  t1.altReceteID"
		sorgu = sorgu & " WHERE t1.receteID = " & receteID
		sorgu = sorgu & " AND t1.silindi = 0"
		sorgu = sorgu & " ORDER BY t1.sira ASC"	
		rs.open sorgu, sbsv5, 1, 3

	if rs.recordcount > 0 then
		Response.Write "<table class=""table table-sm table-striped table-bordered table-hover"">"
			Response.Write "<thead class=""thead-dark fixed-top"" style=""position: sticky;box-shadow: 0 0 10px rgba(0, 0, 0, 0.9);>"
				Response.Write "<tr class=""text-center"">"
					Response.Write "<th class=""col-1"">Sıra</th>"
					Response.Write "<th class=""col-1"">İşlem Tipi</th>"
					Response.Write "<th class=""col-4"">Açıklama</th>"
					Response.Write "<th class=""col-1"">Birim Miktar</th>"
					Response.Write "<th class=""col-1"">İhtiyaç Miktar</th>"
					Response.Write "<th class=""col-1"">İşgücü Sayı</th>"
					Response.Write "<th class=""col-1"">Birim Maliyet</th>"
					Response.Write "<th class=""col-1"">1Ad için Maliyet</th>"
				Response.Write "</tr>"
			Response.Write "</thead>"
		Response.Write "<tbody>"
		
		toplamBirimMaliyetPara	=	0

			for i = 1 to rs.recordcount
				altReceteID		=	rs("altReceteID")
				receteAd		=	rs("receteAd")
				islemAd			=	rs("islemAd")
				stokID			=	rs("stokID")
				stokID64		=	stokID
				stokID64		=	base64_encode_tr(stokID64)
				isGucuSayi		=	rs("isGucuSayi")
				miktar			=	rs("miktar")
				miktarBirim		=	rs("miktarBirim")
				stokAd			=	rs("stokAd")
				stokKodu		=	rs("stokKodu")
				islemAciklama	=	rs("islemAciklama")
				receteAdimID	=	rs("receteAdimID")
				receteAdimID64	=	receteAdimID
				receteAdimID64	=	base64_encode_tr(receteAdimID64)
				ihtiyacMiktar	=	cdbl(miktar) * cdbl(siparisMiktar)

				if miktarBirim = "SN" then
					isgucuBirimMaliyet	=	isgucuSaniyePara
				elseif miktarBirim = "DK" then
					isgucuBirimMaliyet	=	isgucuDakikaPara
				end if


				birimMaliyet		=	rs("birimMaliyet")
				birimMaliyetPara	=	0

		if isnull(stokID) then
			if birimMaliyet = 0 then
				birimMaliyetPara=	isgucuBirimMaliyet * miktar * isGucuSayi
			else
				birimMaliyetPara=	birimMaliyet * miktar * isGucuSayi
			end if
		else
				birimMaliyetPara=	birimMaliyet * miktar
		end if

			if not isnull(stokID) then
				trClass 		=	" bg-warning "
			else
				trClass 		=	""
			end if

				Response.Write "<tr class=""" & trClass & """>"
					Response.Write "<td class=""text-center bold"">" & i & "</td>"
					Response.Write "<td class=""text-left "">" & islemAd &"</td>"
					Response.Write "<td class=""text-left"">"
						Response.Write "<div>" & stokKodu & " - " & stokAd & "</div>"
						Response.Write "<div class=""fontkucuk2 font-italic text-info pl-3"">" & islemAciklama & "</div>"
					Response.Write "</td>"
					Response.Write "<td class=""text-right"">" & miktar & " " & miktarBirim & "</td>"
					Response.Write "<td class=""text-right"">" & ondalikKontrol(ihtiyacMiktar) & " " & miktarBirim & "</td>"
					Response.Write "<td class=""text-center bold"">"
					if isnull(stokID) then
						Response.Write isGucuSayi
					end if
					Response.Write "</td>"
					Response.Write "<td class=""text-right"">"
					if not isnull(stokID) AND altReceteID = 0 then
						Response.Write "<div onclick=""modalajax('/satis/urun_gelis_fiyat.asp?stokID="&stokID&"&receteAdimID="&receteAdimID&"');""><i class=""icon page-go pointer""></i></div>"
						postDeger1	=	"stokID_"&anastokID&"**cariID_"&cariID&"**siparisKalemID_"&siparisKalemID&"**receteID_"&receteID&""
						call forminput("birimMaliyet",birimMaliyet,"","","text-center bold text-success birimMaliyet","autocompleteOFF","birimMaliyet_"&receteAdimID&"","onchange=""hucreKaydetGenel('receteAdimID','"&receteAdimID&"','birimMaliyet','recete.receteAdim',$(this).val(),'','anaDIV','/satis/recete_maliyet','"&postDeger1&"','')""")
					elseif altReceteID > 0 then
						Response.Write "<div class=""text-center""><span class=""help"" onclick=""swal('','Ürüne ait alt reçete mevcut<br><br> alt reçete maliyetleri zaten ürün maliyetine ekleneceği için fiyat girişi yapılamaz.','warning')""><i class=""icon error-delete ""></i></span></div>"
					end if
					Response.Write "</td>"
					Response.Write "<td class=""text-right"">" & birimMaliyetPara & "</td>"
				Response.Write "</tr>"
						if altReceteID > 0 then
							Response.Write "<tr>"
								Response.Write "<td></td>"
								Response.Write "<td colspan=""7"">"
									Response.Write "<hr class="""" style=""border-top: 2px solid;"">"								
									Response.Write "<div class=""fontkucuk2 font-italic text-danger"">" & receteAd & " reçetesi.</div>"
									call altReceteGetir(altReceteID,fn1,ihtiyacMiktar,"bg-info")
									Response.Write "<tr><td></td><td colspan=""7""><hr class="""" style=""border-top: 2px solid;""></td></tr>"
								Response.Write "</td>"
							Response.Write "</tr>"
						end if
					toplamBirimMaliyetPara	=	toplamBirimMaliyetPara + birimMaliyetPara
			rs.movenext
			next
			' Response.Write "<tr>"
			' 	Response.Write "<td colspan=""7""></td>"
			' 	Response.Write "<td>" & toplamBirimMaliyetPara & "</td>"
			' Response.Write "</tr>"

		Response.Write "</tbody>"
		Response.Write "</table>"
	end if




end if
end if
	Response.Write "<div class=""footer fixed-bottom bg-dark"" style=""position: sticky;box-shadow: 0 0 10px rgba(0, 0, 0, 0.9);"">"
		Response.Write "<div class=""text-right bold text-light"" style=""font-size:18pt;"">" & formatnumber(toplamBirimMaliyetPara,2) & "<div>"
	Response.Write "</div>"
Response.Write "</div>"



sub altReceteGetir(subAltReceteID,conn,subihtiyacMiktar,arkaRenk)

		sorgu = ""
		sorgu = sorgu & " SELECT "
		sorgu = sorgu & " t1.receteAdimID, t1.islemAciklama, ISNULL(t1.birimMaliyet,0) as subbirimMaliyet,"
		sorgu = sorgu & " t2.ad as islemAd,"
		sorgu = sorgu & " t1.stokID,"
		sorgu = sorgu & " t3.stokAd,"
		sorgu = sorgu & " t3.stokKodu,"
		sorgu = sorgu & " t1.isGucuSayi,"
		sorgu = sorgu & " t1.miktar,"
		sorgu = sorgu & " t1.miktarBirim,"
		sorgu = sorgu & " t1.sira,"
		sorgu = sorgu & " t1.altReceteID,"
		sorgu = sorgu & " t4.receteAd"
		sorgu = sorgu & " FROM recete.receteAdim t1"
		sorgu = sorgu & " INNER JOIN recete.receteIslemTipi t2 ON t2.receteIslemTipiID =  t1.receteIslemTipiID"
		sorgu = sorgu & " LEFT JOIN stok.stok t3 ON  t3.stokID =  t1.stokID"
		sorgu = sorgu & " LEFT JOIN recete.recete t4 ON  t4.receteID =  t1.altReceteID"
		sorgu = sorgu & " WHERE t1.receteID = " & subAltReceteID
		sorgu = sorgu & " AND t1.silindi = 0"
		sorgu = sorgu & " ORDER BY t1.sira ASC"	
		conn.open sorgu, sbsv5, 1, 3

		
			if conn.recordcount > 0 then
				for zi = 1 to conn.recordcount

				if conn("miktarBirim") = "SN" then
					subisgucuBirimMaliyet	=	isgucuSaniyePara
				elseif conn("miktarBirim") = "DK" then
					subisgucuBirimMaliyet	=	isgucuDakikaPara
				end if

				
				sub2ihtiyacMiktar	= subihtiyacMiktar
				sub2ihtiyacMiktar	=	cdbl(conn("miktar")) * cdbl(subihtiyacMiktar)

				subbirimMaliyet		=	conn("subbirimMaliyet")
				subbirimMaliyetPara	=	0

		if isnull(conn("stokID")) then
			if subbirimMaliyet = 0 then
				subbirimMaliyetPara=	subisgucuBirimMaliyet * conn("miktar") * conn("isGucuSayi")
			else
				subbirimMaliyetPara=	subbirimMaliyet * conn("miktar") * conn("isGucuSayi")
			end if
		else
				subbirimMaliyetPara=	subbirimMaliyet * conn("miktar")
		end if
				
						Response.Write "<tr class=""" & arkaRenk & """>"
							Response.Write "<td class=""bg-light""></td>"
							Response.Write "<td class=""text-left "">" & conn("islemAd") & "</td>"
							Response.Write "<td class=""text-left fontkucuk2"">"
								Response.Write "<div>" & conn("stokKodu") & " - " & conn("stokAd") & "</div>"
								Response.Write "<div class=""fontkucuk2 font-italic pl-3"">" & conn("islemAciklama") & "</div>"


							Response.Write "</td>"
							Response.Write "<td class=""text-right"">" & conn("miktar") & " " & conn("miktarBirim") & "</td>"
							Response.Write "<td class=""text-right"">" & ondalikKontrol(sub2ihtiyacMiktar) & " " & conn("miktarBirim") & "</td>"
							Response.Write "<td class=""text-center bold"">"
							if isnull(conn("stokID")) then
								Response.Write conn("isGucuSayi")
							end if
							Response.Write "</td>"
							Response.Write "<td class=""text-right"">"
							if not isnull(conn("stokID")) AND conn("altReceteID") = 0 then
								Response.Write "<div onclick=""modalajax('/satis/urun_gelis_fiyat.asp?stokID="&conn("stokID")&"&receteAdimID="&conn("receteAdimID")&"');""><i class=""icon page-go pointer""></i></div>"
								postDeger1	=	"stokID_"&anastokID&"**cariID_"&cariID&"**siparisKalemID_"&siparisKalemID&"**receteID_"&receteID&""
								call forminput("subbirimMaliyet",subbirimMaliyet,"","","text-center bold text-success subbirimMaliyet","autocompleteOFF","birimMaliyet_"&conn("receteAdimID"),"onchange=""hucreKaydetGenel('receteAdimID','"&conn("receteAdimID")&"','birimMaliyet','recete.receteAdim',$(this).val(),'','anaDIV','/satis/recete_maliyet','"&postDeger1&"','')""")
							elseif conn("altReceteID") > 0 then
								Response.Write "<div class=""text-center""><span class=""help"" onclick=""swal('','Ürüne ait alt reçete mevcut<br><br> alt reçete maliyetleri zaten ürün maliyetine ekleneceği için fiyat girişi yapılamaz.','warning')""><i class=""icon error-delete ""></i></span></div>"
							end if
							Response.Write "</td>"
							Response.Write "<td class=""text-right"">" & subbirimMaliyetPara & "</td>"
						Response.Write "</tr>"
						toplamBirimMaliyetPara = toplamBirimMaliyetPara + subbirimMaliyetPara
						cizgiKod=""
						cizgiKod1=""
						cizgiKod = cizgiKod & "<tr><td></td><td colspan=""7""><hr class="""" style=""border-top: 2px solid;""></td></tr>"
						cizgiKod1 = cizgiKod & "<tr><td class=""bg-light""></td><td colspan=""7""><div class=""fontkucuk2 font-italic text-danger"">" & conn("receteAd") & " reçetesi.</div></td></tr>"

						if conn("altReceteID") > 0 then
							Response.Write "<tr>"
								if fn2.state <> 1 then
									Response.Write cizgiKod1
									call altReceteGetir(conn("altReceteID"),fn2,sub2ihtiyacMiktar,"bg-success")
								elseif fn3.state <> 1 then
									Response.Write cizgiKod1
									call altReceteGetir(conn("altReceteID"),fn3,sub2ihtiyacMiktar,"bg-secondary")
								end if
							Response.Write "</tr>"

						end if

				conn.movenext
				next
			end if
		conn.close
end sub



%><!--#include virtual="/reg/rs.asp" -->









