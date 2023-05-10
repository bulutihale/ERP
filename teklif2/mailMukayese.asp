<!--#include virtual="/reg/rs.asp" --><%

	Response.Flush()
	kid						=	kidbul()

	call sessiontest()


'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr 				=	Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr


'######## degerleri al
'######## degerleri al
ihaleID			=	Request.Form("ihaleID")
aliciEposta		=	Request.Form("eposta")
'######## degerleri al
'######## degerleri al

			


'######### SORGU
'######### SORGU
	sorgu = ""
	sorgu = sorgu & "select "
	sorgu = sorgu & "i.dosyaNo, iu.yaklasikMaliyet, iu.yaklasikMaliyetPB, iu.YMiptal, iu.iptalSebep, "
	sorgu = sorgu & "COALESCE(NULLIF(c.adKisa,''), c.ad) as kurumAD, "
	sorgu = sorgu & "COALESCE(NULLIF(fir.adKisa,''), fir.adUzun) as firmaAD, "
	sorgu = sorgu & "(SELECT tarih_karar FROM sozlesmeler WHERE ihaleID = i.id) as karar, "
	sorgu = sorgu & "i.ad as ihalead, i.ihaleNo, i.tarih_ihale, iu.yerliOran, iu.firmamMarka, iu.uhde, iu.iptal, i.firmaID, "
	sorgu = sorgu & "iu.siraNo, iu.firmamFiyatiptal, iu.ad as urunad, i.id as ihaleID, iu.id as iuID, iu.miktar, iu.birim, iu.firmamFiyat, iu.firmamParaBirim, ISNULL(iu.firmamYerliMali,'False') as firmamYerliMali, "
	sorgu = sorgu & "(select top(1) kursat from kurlar where birim = 1 and datepart(year,tarih) = datepart(year,i.tarih_ihale) and datepart(month,tarih) = datepart(month,i.tarih_ihale) and datepart(day,tarih) = datepart(day,i.tarih_ihale)) as usd, "
	sorgu = sorgu & "(select top(1) kursat from kurlar where birim = 2 and datepart(year,tarih) = datepart(year,i.tarih_ihale) and datepart(month,tarih) = datepart(month,i.tarih_ihale) and datepart(day,tarih) = datepart(day,i.tarih_ihale)) as eur "
	sorgu = sorgu & "from ihale i "
	sorgu = sorgu & "INNER JOIN firmalar fir on i.firmaID = fir.id "
	sorgu = sorgu & "INNER JOIN ihale_urun iu on iu.ihaleID = i.id "
	sorgu = sorgu & "INNER JOIN cariler c on c.id = i.cariID "
	sorgu = sorgu & "INNER JOIN iller il on il.id = c.il "
	sorgu = sorgu & " where i.id = " & ihaleID & " AND i.musteriID = " & musteriID & ""
	rs.open sorgu,sbsv5,1,3
	
	if rs.recordcount = 0 then
		Response.Write "<div class=""alert alert-danger text-center"">Kayıt Bulunamadı</div>"
	else
	ihaleNo 	= 	rs("ihaleNo")
	kararTarih	=	rs("karar")
	
if isnull(kararTarih) then
	mailBaslik	= 	ihaleNo & " mukayese cetveli."
	kararYazi	=	""		
else
	mailBaslik	=	ihaleNo & " Kesinleşen ihale kararı."
	kararYazi	=	"<span style=""color:red;""><b>Karar Tarihi: " & kararTarih &"</b></span><br>"
end if
		
	mailIcerik = ""
	mailIcerik = mailIcerik & kararYazi
	mailIcerik = mailIcerik & "<b>Firmam: </b>" & rs("firmaAd") &"<br>"
	mailIcerik = mailIcerik & "<b>İhale No: </b>" & ihaleNo &"<br>"
	mailIcerik = mailIcerik & "<b>Kurum: </b>" & rs("kurumad")&"<br>"
	mailIcerik = mailIcerik & "<b>İhale Tarihi: </b>" & rs("tarih_ihale")&"<br>"
	mailIcerik = mailIcerik & "<b>İhale Adı: </b>" & rs("ihalead")&"<br>"
	mailIcerik = mailIcerik & "<b>Döviz: usd: </b>" & rs("usd") & " TL <b>eur: </b>" & rs("eur") & " TL"


		mailIcerik = mailIcerik & "<table border=""1"" style=""width:100%;font-size:10px;"">"
		mailIcerik = mailIcerik & "<thead><tr>"
		mailIcerik = mailIcerik & "<th>SıraNo</th>"
		mailIcerik = mailIcerik & "<th>İhale Ürün</th>"
		mailIcerik = mailIcerik & "<th>Yaklaşık Maliyet</th>"
		mailIcerik = mailIcerik & "<th>Miktar</th>"
		mailIcerik = mailIcerik & "<th>Fiyat</th>"
		mailIcerik = mailIcerik & "</tr></thead><tbody>"
		
		
			for ri = 1 to rs.recordcount
			
		iptalStyle			=	""
		YMiptalStyle		=	""
		rakipYerliStyle		=	""
		firmamUhde			=	""
		yerliStyle			=	""
		fiyatiptal			=	""
		
			if rs("iptal") = "True" then
				iptalStyle = "background-color:red;"
			end if
			if rs("YMiptal") = "True" then
				YMiptalStyle = "background-color:red;"
			end if
			
			rakipYerliVar = 0			
			sorgu = "SELECT yerliMali FROM fiyatlar WHERE ihaleID = " & rs("ihaleID") & " AND yerlimali = 'True'"
			rs2.open sorgu,sbsv5,1,3
			
			rakipYerliVar	=	rs2.recordcount
			rs2.close

				mailIcerik = mailIcerik & "<tr>"
				mailIcerik = mailIcerik & "<td align=""center"" style="""&iptalStyle&""">" & rs("siraNo") & "</td>"
				mailIcerik = mailIcerik & "<td>" & rs("urunad") & "<br><span style=""color:red;"">"&rs("iptalSebep")&"</span></td>"
				mailIcerik = mailIcerik & "<td align=""center"" style="""&YMiptalStyle&""">" & rs("yaklasikMaliyet") & " " & rs("yaklasikMaliyetPB") &"</td>"
				mailIcerik = mailIcerik & "<td align=""center"" style="""">" & rs("miktar") & " " & rs("birim") &"</td>"
				
				EURfiyatim				=	0
				USDfiyatim				=	0
				yerliEURfiyatim			=	0
				yerliUSDfiyatim			=	0
				YerliEkleFirmamFiyat 	= 	0
				
			sorgu = "SELECT COALESCE(NULLIF(c.adKisa,''), c.ad) as rakipAD, f.fiyatiptal, f.marka, f.yerliMali, f.fiyat, f.fiyatPB, f.uhde FROM fiyatlar f INNER JOIN cariler c ON f.carilerID = c.id WHERE f.ihaleUrunID = " & rs("iuID")
			rs2.open sorgu,sbsv5,1,3
			
					if len(rs("firmamMarka")) > 0 then
						mailIcerik = mailIcerik & "marka: " & rs("firmamMarka") & "<br>"
					end if


				if rakipYerliVar > 0 AND rs("yerliOran") > 0 AND rs("firmamYerliMali") = "False" then
					yerliStyle = "color:red;"
					YerliEkleFirmamFiyat =	rs("firmamFiyat") + (rs("firmamFiyat")*(rs("yerliOran")/100))
				end if
				
				if rs("uhde") = "True" then
					firmamUhde =  "background-color:yellow;"
				elseif rs("firmamFiyatiptal") = "True" then
					firmamUhde =  "background-color:#9F862F;"
				end if

				mailIcerik = mailIcerik & "<td style="""&firmamUhde&""" align=""center""><span style="""&yerliStyle&""">" & para_basamak(rs("firmamFiyat"))& " " & rs("firmamParaBirim") & "</span><br>"
					EURfiyatim	= rs("firmamFiyat") / rs("eur")
					USDfiyatim	= rs("firmamFiyat") / rs("usd")
					mailIcerik = mailIcerik & "<span style="""&yerliStyle&""">"
						mailIcerik = mailIcerik & para_basamak(EURfiyatim)&" &euro; - "
						mailIcerik = mailIcerik & para_basamak(USDfiyatim)&" $<br>"
					mailIcerik = mailIcerik & "</span>"
					
					if rakipYerliVar > 0 AND rs("yerliOran") > 0 AND rs("firmamYerliMali") = "False" then
						yerliEURfiyatim	= yerliEkleFirmamFiyat / rs("eur")
						yerliUSDfiyatim	= yerliEkleFirmamFiyat / rs("usd")
						mailIcerik = mailIcerik & "(+%"&rs("yerliOran")&") "& yerliEkleFirmamFiyat & " " & rs("firmamParaBirim") & "<br>"
						mailIcerik = mailIcerik & para_basamak(yerliEURfiyatim)&" &euro; - "
						mailIcerik = mailIcerik & para_basamak(yerliUSDfiyatim)&" $<br>"
					end if
				mailIcerik = mailIcerik & "</td>"
				
				EURfiyatRakip 		=	0
				USDfiyatRakip 		=	0
				yerliEURfiyatRakip	=	0
				yerliUSDfiyatRakip	=	0
				yerliEkleRakipFiyat	=	0
				
				for z = 1 to rs2.recordcount
				
		RtdStyle			=	""
					
				if rs("yerliOran") > 0 AND (rakipYerliVar > 0 OR rs("firmamYerliMali") = "True") AND rs2("yerliMali") = "False" then
					rakipYerliStyle = "color:red;"
					yerliEkleRakipFiyat =	rs2("fiyat") + (rs2("fiyat")*(rs("yerliOran")/100))
				end if
				
				if rs2("uhde") = "True" then
					RtdStyle = "background-color:yellow;"
				elseif rs2("fiyatiptal") = "True" then
					RtdStyle =  "background-color:#9F862F;"
				end if
				
					mailIcerik = mailIcerik & "<td style="""&RtdStyle&""" align=""center"">"
					mailIcerik = mailIcerik & rs2("rakipAD")&"<br>"
					if len(rs2("marka")) > 0 then
						mailIcerik = mailIcerik & "marka: " & rs2("marka") & "<br>"
					end if

					mailIcerik = mailIcerik & "<span style=""" & rakipYerliStyle & """>"
					mailIcerik = mailIcerik & para_basamak(rs2("fiyat"))&" " & rs2("fiyatPB") & "<br>"
					mailIcerik = mailIcerik & "</span>"
					
				EURfiyatRakip	= rs2("fiyat") / rs("eur")
				USDfiyatRakip	= rs2("fiyat") / rs("usd")
				mailIcerik = mailIcerik & "<span style=""" & rakipYerliStyle & """>"
				mailIcerik = mailIcerik & para_basamak(EURfiyatRakip)&" &euro; - "
				mailIcerik = mailIcerik & para_basamak(USDfiyatRakip)&" $<br>"
				mailIcerik = mailIcerik & "</span>"
				
				if rs("yerliOran") > 0 AND (rakipYerliVar > 0 OR rs("firmamYerliMali") = "True") AND rs2("yerliMali") = "False" then
					yerliEURfiyatRakip	= yerliEkleRakipFiyat / rs("eur")
					yerliUSDfiyatRakip	= yerliEkleRakipFiyat / rs("usd")
					mailIcerik = mailIcerik & "(+%"&rs("yerliOran")&") "& yerliEkleRakipFiyat & " " & rs2("fiyatPB") & "<br>"
					mailIcerik = mailIcerik & para_basamak(yerliEURfiyatRakip)&" &euro; - "
					mailIcerik = mailIcerik & para_basamak(yerliUSDfiyatRakip)&" $<br>"
				end if
				mailIcerik = mailIcerik & "</td>"
					rs2.movenext
				next
				mailIcerik = mailIcerik & "</tr>"
			rs2.close
			rs.movenext
			next
		mailIcerik = mailIcerik & "</tbody>"
		mailIcerik = mailIcerik & "</table>"

	end if
	rs.close
'######### SORGU
'######### SORGU



 call mailGonder("", mailBaslik, mailIcerik,"","","",ihaleID,aliciEposta)


%>






