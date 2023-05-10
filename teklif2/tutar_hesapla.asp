<!--#include virtual="/reg/rs.asp" -->
<%
	call sessiontest()
	Response.Flush()

'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr 				= 	Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr



	'##### request
	'##### request
		kid						=	kidbul()
		ihaleID					=	request.Form("id")
	'##### request
	'##### request
	
	'#################### her bir kaleme ait karar pulu tutarını tekrar hesapla ve ihale_urun tablosua kaydet.
			sorgu = "SELECT iu.id FROM ihale_urun iu"_
				&" LEFT JOIN ihale i ON i.id = iu.ihaleID"_
				&" WHERE i.id = " & ihaleID
				rs.open sorgu, sbsv5,1,3
			
				for ri = 1 to rs.recordcount
					iuID = rs("id")
					call kararPuluHesap(iuID)
				rs.movenext
				next
				rs.close
	'#################### /her bir kaleme ait karar pulu tutarını tekrar hesapla ve ihale_urun tablosua kaydet.
	
	
		'#### teslim edilen faturadan sonra dosyaya ait teslimatların tamamı bitmiş mi? bitti ise db "teslimatBitti" alanına kayıt yaz.
			call teslimatBittiKontrol(ihaleID)
		'#### /teslim edilen faturadan sonra dosyaya ait teslimatların tamamı bitmiş mi? bitti ise db "teslimatBitti" alanına kayıt yaz.
	
	sorgu = "SELECT isnull(i.netsisDOVIZTIP,'TL') AS dosyaPB FROM ihale i WHERE i.id = " & ihaleID
	rs.open sorgu, sbsv5,1,3
	
	paraBirim = rs("dosyaPB")
	rs.close
	
	
				istirakTutarYaz = istirakTutar(ihaleID)
				Response.Write istirakTutarYaz
			Response.Write "|"
				uhdeYaz = uhdeTutar(ihaleID)
				Response.Write uhdeYaz
			Response.Write "|"
				bakiyeTutarYaz = bakiyeTutar(ihaleID)
				Response.Write bakiyeTutarYaz
			Response.Write "|"
				kararPuluYaz = toplamKararPulu(ihaleID)
				Response.Write kararPuluYaz
			Response.Write "|"
				sozlesmePuluYaz	=	toplamSozlesmePulu(ihaleID)
				Response.Write sozlesmePuluYaz
			Response.Write "|"
				call kikPayiHesap(ihaleID)
			Response.Write "|"
				Response.Write paraBirim

%>

