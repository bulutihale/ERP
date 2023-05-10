<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()
	
	
	stoklarID	=	Request.Querystring("stoklarID")
	firmaID		=	Request.Querystring("firmaID")
	cariID		=	Request.Querystring("cariID")

	if stoklarID = 0 then
		Response.Write "<div style=""width:900px"" class=""h6 text-danger text-center"">Stok karşılığı seçilmemiş. Kayıtlar çekilemiyor.</div>"
		Response.End
	elseif cariID = "" then
		Response.Write "<div style=""width:900px"" class=""h6 text-danger text-center"">Dosyaya ait cari, henüz NETSİS'te tanımlı olmadığı için daha önce fatura kesilmemiş. Kayıtlar çekilemiyor.</div>"
		Response.End
	end if

'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr


	'###### netsis'ten çekmek için ürüne ait NETSİS stok kodunu bul
		sorgu = "SELECT ad as stokAd, muhStokKod FROM stoklar WHERE id = " & stoklarID
		rs.open sorgu,sbsv5,1,3
			muhStokKod	=	rs("muhStokKod")
			stokAd		=	rs("stokAd")
		rs.close
	'###### /netsis'ten çekmek için ürüne ait NETSİS stok kodunu bul
	
	'###### netsis'ten çekmek için ürüne ait NETSİS cari kodunu bul
		sorgu = "SELECT ad as cariAd, muhCariKod FROM cariler WHERE id = " & cariID
		rs.open sorgu,sbsv5,1,3
			muhCariKod	=	rs("muhCariKod")
			cariAd		=	rs("cariAd")
		rs.close
	'###### /netsis'ten çekmek için ürüne ait NETSİS cari kodunu bul
	
	
	
	Response.Write "<div style=""width:900px"" class=""h6 text-info text-center"">" & cariAd & "</div>"
	Response.Write "<div class=""text-left"">" & stokAd & "</div>"
	Response.Write "<hr>"
	Response.Write "<div class=""row text-center bold"">"
		Response.Write "<div class=""col-2"">Miktar</div>"
		Response.Write "<div class=""col-2"">Fiyat</div>"
		Response.Write "<div class=""col-2"">Tarih</div>"
		Response.Write "<div class=""col-3"">USD Kur</div>"
	Response.Write "</div>"
	'###### firmaya ait NETSİS geçmişe dönük NETSİS dönemlerini bul
	
		sorgu = "SELECT entProgDB FROM firmalar_entegre WHERE firmalarID = " & firmaID & " ORDER BY id DESC"
		rs.open sorgu,sbsv5,1,3
		
		for yi = 1 to rs.recordcount
		
			entProgDB	=	rs("entProgDB")
			
			sorgu = "SELECT t1.STHAR_GCMIK, t1.STHAR_NF, t1.STHAR_TARIH, t1.OLCUBR,"
			sorgu = sorgu &" CASE WHEN t1.OLCUBR = 1 THEN t2.OLCU_BR1 WHEN t1.OLCUBR = 2 THEN t2.OLCU_BR2 END as birim"
			sorgu = sorgu &" FROM [" & entProgDB & "].[dbo].TBLSTHAR t1"
			sorgu = sorgu &" INNER JOIN [" & entProgDB & "].[dbo].TBLSTSABIT t2 ON t1.STOK_KODU = t2.STOK_KODU"
			sorgu = sorgu &" WHERE t1.STHAR_FTIRSIP='1'"
			sorgu = sorgu &" AND t1.STOK_KODU = '" & muhStokKod & "'"
			sorgu = sorgu &" AND t1.STHAR_ACIKLAMA = '" & muhCariKod & "'"
			sorgu = sorgu &" ORDER BY t1.STHAR_TARIH DESC"
			rs1.open sorgu,NETSIS_master,1,3
			
				if rs1.recordcount > 0 then
					for gi = 1 to rs1.recordcount
						faturaMiktar	=	formatnumber(rs1("STHAR_GCMIK"),0)
						faturaFiyat		=	formatnumber(rs1("STHAR_NF"),2)
						faturaTarih		=	rs1("STHAR_TARIH")
						eurArr			=	dovizKuruBul(faturaTarih, "USD")
						USDkur			=	eurArr(0)
						kurTarih		=	eurArr(1)
						birim			=	rs1("birim")
						if isnumeric(faturaFiyat) AND isnumeric(USDkur) then
							faturaUSDfiyat	=	formatnumber((faturaFiyat / USDkur),2)
						end if
						Response.Write "<div class=""row hoverGel"">"
							Response.Write "<div class=""col-2 text-right"">" & faturaMiktar & " " & birim & "</div>"
							Response.Write "<div class=""col-2 text-right""><b>" & faturaFiyat & " TL</b> (" & faturaUSDfiyat & " $)</div>"
							Response.Write "<div class=""col-2 text-right"">" & faturaTarih & "</div>"
							Response.Write "<div class=""col-3 text-center fontkucuk2"">" & USDkur & " TL (" & kurTarih & ")" & "</div>"
						Response.Write "</div>"
					rs1.movenext
					next
				end if
			rs1.close
		
		
		
		rs.movenext
		next
		
		
		
		
		
		rs.close


%>
