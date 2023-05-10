<!--#include virtual="/reg/rs.asp" --><%

	Response.Flush()
	kid						=	kidbul()
	call sessiontest()

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


'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	""
	yetki		=	yetkibul("","","")
'##### YETKİ BUL
'##### YETKİ BUL


if arama <> "" then
	arama = sqlinj(arama)
end if

'######## degerleri al
'######## degerleri al
	NETSISfirma	=	Request.Form("NETSISfirma")
	faturaNo	=	Request.Form("faturaNo")
'######## degerleri al
'######## degerleri al

'#### firmamID tespit et
	sorgu = "SELECT id as firmamID FROM firmalar WHERE id IN (SELECT firmalarID FROM firmalar_entegre WHERE entProgDB = '" & NETSISfirma & "' )"
	rs.open sorgu,sbsv5,1,3
		firmamID = rs("firmamID")
	rs.close


'#### firmamID tespit et

				sorgu = "SELECT fatAna.CARI_KODU, fatAna.TARIH as faturaTarih, fatKalem.INCKEYNO, s.STOK_ADI as stokAD, fatKalem.SIRA, fatDetay.ACIKLAMA1 as LOT, s.BARKOD1 as utsKodNo,"_
				&" fatKalem.STHAR_GCMIK as faturaMiktar, fatKalem.STOK_KODU, ISNULL(c.VERGI_NUMARASI,c2.TCKIMLIKNO) as vergiNo"_
				&" FROM [" & NETSISfirma & "].[dbo].TBLSTHAR fatKalem"_
				&" LEFT JOIN [" & NETSISfirma & "].[dbo].TBLSSATIRAC fatDetay ON fatKalem.INCKEYNO = fatDetay.INCKEYNO"_
				&" INNER JOIN [" & NETSISfirma & "].[dbo].TBLFATUIRS fatAna ON fatKalem.FISNO = fatAna.FATIRS_NO"_
				&" INNER JOIN [" & NETSISfirma & "].[dbo].TBLCASABIT c ON fatAna.CARI_KODU = c.CARI_KOD"_
				&" INNER JOIN [" & NETSISfirma & "].[dbo].TBLCASABITEK c2 ON fatAna.CARI_KODU = c2.CARI_KOD"_
				&" LEFT JOIN [" & NETSISfirma & "].[dbo].TBLSTSABIT s ON s.STOK_KODU = fatKalem.STOK_KODU"_
				&" WHERE fatKalem.STHAR_BGTIP = 'F'"_
				&" AND fatKalem.FISNO = '" & faturaNo & "'"_
				&" ORDER BY fatKalem.SIRA"
'response.Write sorgu

				rs.open sorgu,NETSIS_master,1,3
	
	
			faturaTarih		=	rs("faturaTarih")
			vergiNo			=	rs("vergiNo")
			cariKod			=	rs("CARI_KODU")
	
	
	
	'############# DIV sabit bilgiler
		Response.Write "<div id=""DIVsabitBilgiler"""
			Response.Write " data-firmamid=""" & firmamID & """"
			Response.Write " data-netsisfirma=""" & NETSISfirma & """"
			Response.Write " data-netsiscarikod=""" & cariKod & """"
		Response.Write ">"
	'############# DIV sabit bilgiler
	
	Response.Write "<div class=""card col-lg-12 pl-0 ml-0"">"
		Response.Write "<div class=""card-header"">"
			Response.Write "Fatura Detay."
			
			Response.Write "<button id=""tumFaturaBildir"" data-bildirimtip=""tumFaturaVermeTanimli"" data-bildirim=""tumFaturaVerme"">bildir</button>"
			
		Response.Write "</div>"'card-header
		
	Response.Write "<div class=""card-body pl-1 scroll-ekle3"">"
	if rs.recordcount = 0 then
		Response.Write "Fatura içeriği yok."
	else
	Response.Write "<div id=""utsNo""></div>"
		Response.Write "<div class=""row text-left"">"
			Response.Write "<div class=""col-1 font-weight-bold"">Tarih: </div>"
			Response.Write "<div id=""faturaTarih"" class=""col-2"">" & faturaTarih & "</div>"
			Response.Write "<div class=""col-2 font-weight-bold"">Vergi No: </div>"
		Response.Write "<div id=""vergiNo"" class=""col-2"">" & vergiNo & "</div>"
		'Response.Write "<div id=""vergiNo"" class=""col-2"">4680072123</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row text-left"">"
			Response.Write "<div class=""col-1 font-weight-bold"">Fat No: </div>"
			Response.Write "<div id=""faturaNo"" class=""col-2"">" & faturaNo & "</div>"
			Response.Write "<div class=""col-2 font-weight-bold"">ÜTS No: </div>"
			Response.Write "<div id=""utsNoListe"" class=""col-6"">"
				Response.Write "<div id=""vergiNoSorgula"" class=""col-2 btn btn-sm btn-info my-0 py-0 rounded"">sorgula</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		
		Response.Write "<div class=""row mt-3 font-weight-bold border-bottom"">"
			Response.Write "<div class=""col-1 text-center"">#</div>"
			Response.Write "<div class=""col-2 text-center"">ÜTS Kod</div>"
			Response.Write "<div class=""col-4 text-center"">Ürün</div>"
			Response.Write "<div class=""col-1 text-right"">Miktar</div>"
			Response.Write "<div class=""col-2 text-center"">LOT</div>"
			Response.Write "<div class=""col-2 text-center"">ÜTS Bildirim</div>"
		Response.Write "</div>"
	
	for gi = 1 to rs.recordcount
			INCKEYNO		=	rs("INCKEYNO")
			faturaMiktar	=	rs("faturaMiktar")
			stokKod			=	rs("STOK_KODU")
			stokAD			=	rs("stokAD")
			SIRA			=	rs("SIRA")
			LOT				=	rs("LOT")
			utsKodNo		=	rs("utsKodNo")
			
			
			
	'############## ÜTS bildirimi mükerrer yapılmasın diye utsFlag sistemi kuruldu bildirim döngüsü jquery ile yapıldı.		
		kontrolSonuc	=	utsBildirimKontrol(NETSISfirma, INCKEYNO)
		utsNID			=	kontrolSonuc
		if kontrolSonuc	> 0 then
			utsDurum	= 	"<span class=""text-danger utsIptal"" data-utsnid=""" & utsNID & """ data-bildirimtip=""iptalBildirimTekLot""><i class=""fa fa-undo""></i></span> bildirim var"
			utsFlag		=	" utsYapma "
		else
			utsDurum = "bildirim yapılmamış"
			utsFlag		=	" utsYap "
		end if
			
		Response.Write "<div id=""" & INCKEYNO & """ class=""row fontkucuk2 pointer faturaDetaySatir " & utsFlag & " hoverGel"">"
			Response.Write "<div class=""col-1 text-center"">" & SIRA & "</div>"
			Response.Write "<div class=""col-2 utsKod"" data-inckeyno=""" & INCKEYNO & """>" & utsKodNo & "</div>"
			Response.Write "<div class=""col-4"">" & stokKod & " - " & stokAD & "</div>"
			Response.Write "<div class=""col-1 faturaMiktar text-right"">" & faturaMiktar & "</div>"
			Response.Write "<div class=""col-2 urunLot text-center"">" & LOT & "</div>"
			Response.Write "<div class=""col-2 utsSonuc"">" & utsDurum & "</div>"
		Response.Write "</div>"
		Response.Write "<hr class=""p-0 m-0 bg-danger"">"
		rs.movenext
		next
	end if
		rs.close
	Response.Write "</div>"'card-body
	
	Response.Write "</div>"'card
	
	
	


%>




