<!--#include virtual="/reg/rs.asp" --><%




	'##### request
	'##### request
		kid						=	kidbul()
		id						=	Request.Form("id")
		tablo					=	Request.Form("tablo")
		deger1					=	Request.Form("deger1")'sipariş silmede "kacinciSiparis" degeri gelir, teslimat faturası silmede "kacinciTeslimat" değeri gelir.
		deger2					=	Request.Form("deger2")'teslimat faturası silmede "kacinciSiparis" değeri gelir.
		modulID					=	Request.Form("modulID")
	'##### request
	'##### request
	
	
	

'##### KAYIT SİL
'##### KAYIT SİL

	
	
	'#### ihale_urun tablosundan stok karşılığı siliniyorsa
		if tablo = "ihale_urun" AND deger1 = "stokKarsilik" then
			sorgu = "SELECT stoklarID FROM teklifv2.ihale_urun WHERE id = " & id
			rs.open sorgu, sbsv5,1,3
			rs("stoklarID") = 0
			rs.update
			rs.close
	'#### /ihale_urun tablosundan stok karşılığı siliniyorsa
		else
			sorgu = "SELECT * FROM teklifv2." & tablo & " WHERE id = " & id & ""
			rs.open sorgu, sbsv5,1,3
				
				rs.delete
				rs.update
			rs.close
		end if
		
		
		
'##### /KAYIT SİL
'##### /KAYIT SİL
		
'##### ihale_urun'DEN ÜRÜN SİLİNİYORSA RAKİP FİYATLAR, AKTARIM BİLGİLERİ VE EK ÜRÜNLER DE SİLİNSİN
'##### ihale_urun'DEN ÜRÜN SİLİNİYORSA RAKİP FİYATLAR, AKTARIM BİLGİLERİ VE EK ÜRÜNLER DE SİLİNSİN

		if tablo = "ihale_urun" AND deger1 <> "stokKarsilik" then
	
	'#### rakip fiyatları siliniyor
			sorgu = "SELECT * FROM teklifv2.fiyatlar WHERE ihaleUrunID = " & id & ""
			rs.open sorgu, sbsv5,1,3
			if rs.recordcount > 0  then
				for i = 1 to rs.recordcount
					rs.delete
					rs.update
				rs.movenext
				next
			end if
			rs.close
			
		end if
		
'##### /ihale_urun'DEN ÜRÜN SİLİNİYORSA RAKİP FİYATLAR, AKTARIM BİLGİLERİ VE EK ÜRÜNLER DE SİLİNSİN
'##### /ihale_urun'DEN ÜRÜN SİLİNİYORSA RAKİP FİYATLAR, AKTARIM BİLGİLERİ VE EK ÜRÜNLER DE SİLİNSİN




			
			response.Write "ok|"
		
			hatamesaj = "Silindi."
			call logla(hatamesaj)
		


%>