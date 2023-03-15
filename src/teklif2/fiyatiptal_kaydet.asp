<!--#include virtual="/reg/rs.asp" --><%

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
		id						=	Request.Form("id")
		modulID					=	Request.Form("modulID")
		tablo					=	Request.Form("tablo")
		ihaleUrunID				=	Request.Form("ihaleUrunID")
		islem					=	Request.Form("islem")
	'##### request
	'##### request
	
	
	hatamesaj = "Kayıt başlıyor."
	call logla("Dosya","update",hatamesaj,modulID)

'##### HÜCRE EDIT
'##### HÜCRE EDIT

	'## veritabanı
		if tablo = "ihale_urun" then
			sorgu = "SELECT firmamFiyatiptal, uhde, grupNo, siraNo, sozlesmelerID FROM " & tablo & " WHERE id = " & id
			rs.open sorgu, sbsv5,1,3
			
			if rs("firmamFiyatiptal") = False then
			
					rs("uhde")		=	0
					rs("firmamFiyatiptal") = 1
					rs("sozlesmelerID") = 0
					
						hatamesaj = rs("grupNo")&"-"&rs("siraNo")&" Firmam fiyat geçersiz kaydı."
						call logla("Dosya","update",hatamesaj,modulID)
					
			elseif rs("firmamFiyatiptal") = True then
			
				rs("firmamFiyatiptal") = 0
				
						hatamesaj = rs("grupNo")&"-"&rs("siraNo")&" Firmam fiyat geçerli kaydı."
						call logla("Dosya","update",hatamesaj,modulID)
				
			end if
			rs.update
			rs.close
			
'### ihale_urun tablosu ürün bazında karar pulu hesaplaması
		call kararPuluHesap(id)
'### /ihale_urun tablosu ürün bazında karar pulu hesaplaması			
			
			response.Write "ok|"
			
			
		elseif tablo = "fiyatlar" then
		
			sorgu = "SELECT fiyatiptal, uhde FROM " & tablo & " WHERE id = " & id
			rs.open sorgu, sbsv5,1,3
			
			if rs("fiyatiptal") = False then
			
				rs("uhde")		 = 	0
				rs("fiyatiptal") = 	1
				
						hatamesaj = "Rakip fiyat geçersiz kaydı."
						call logla("Dosya","update",hatamesaj,modulID)

			elseif rs("fiyatiptal") = True then
			
				rs("fiyatiptal") = 	0
			
						hatamesaj = "Rakip fiyat geçerli kaydı."
						call logla("Dosya","update",hatamesaj,modulID)
			
			end if
							
			rs.update
			rs.close
			response.Write "ok|"
		end if
			
			
			
		
			hatamesaj = "Kayıt Başarılı."
			call logla("Dosya","update",hatamesaj,modulID)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		
	'## veritabanı
'##### HÜCRE EDIT
'##### HÜCRE EDIT


%>

