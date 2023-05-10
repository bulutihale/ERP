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
		tablo					=	Request.Form("tablo")
		ihaleUrunID				=	Request.Form("ihaleUrunID")
		islem					=	Request.Form("islem")
		modulID					=	Request.Form("modulID")
		ihaleID					=	Request.Form("modulID")
	'##### request
	'##### request
	
	hatamesaj = "Uhde kayıt ediliyor"
	call logla("Dosya","update",hatamesaj,modulID)

'##### HÜCRE EDIT
'##### HÜCRE EDIT

	'## veritabanı
		if tablo = "ihale_urun" then
		
			sorgu = "SELECT kararPuluTutar, uhde, firmamFiyatiptal, iptal, grupNo, siraNo FROM " & tablo & " WHERE id = " & id
			rs.open sorgu, sbsv5,1,3
			
			
				if rs("uhde") = False AND rs("iptal") = False then
					rs("uhde")				=	1
					rs("firmamFiyatiptal") 	=	0
					
						sorgu2 = "SELECT uhde FROM fiyatlar WHERE ihaleUrunID = " & id
						rs2.open sorgu2, sbsv5,1,3

							if rs2.recordcount > 0 then 
								for ui = 1 to rs2.recordcount
									rs2("uhde") = 0
									rs2.update
								rs2.movenext
								next
							end if
						rs2.close
					response.Write "ok|"
					
						hatamesaj = rs("grupNo")&"-"&rs("siraNo")&" Ürün firmam uhdesinde işaretlendi."
						call logla("Dosya","update",hatamesaj,modulID)
						
				elseif rs("uhde") = True AND rs("iptal") = False then
						rs("uhde")				=	0
					response.Write "ok|"
							hatamesaj = rs("grupNo")&"-"&rs("siraNo")&" Firmam Uhdesinde işareti kaldırıldı."
							call logla("Dosya","update",hatamesaj,modulID)
				elseif rs("iptal") = True then
					response.Write "uruniptal|"
				end if
					rs.update
				rs.close
			
			
		elseif tablo = "fiyatlar" then
		
			sorgu = "SELECT uhde FROM " & tablo & " WHERE id = " & id
			rs.open sorgu, sbsv5,1,3
			uhdeF =	rs("uhde")
			rs.close
			
			sorgu = "SELECT iptal FROM ihale_urun WHERE id = " & ihaleUrunID
			rs.open sorgu, sbsv5,1,3
			kalemIptal = rs("iptal")
			rs.close
			
			if uhdeF = False AND kalemIptal = False then
		
				sorgu = "SELECT uhde, id, fiyatiptal FROM " & tablo & " WHERE ihaleUrunID = " & ihaleUrunID
				rs.open sorgu, sbsv5,1,3
	
					if rs.recordcount > 0 then 
						for i = 1 to rs.recordcount
							rs("uhde") = 0
								if rs("id") = int(id) then
									rs("uhde") 			=	1
									rs("fiyatiptal")	=	0
								end if
								
							rs.update
						rs.movenext
						next
							hatamesaj = "Ürün Rakip uhdesinde işaretlendi."
							call logla("Dosya","update",hatamesaj,modulID)
					end if
				rs.close
			
				sorgu = "SELECT uhde, kararPuluTutar FROM ihale_urun WHERE id = " & ihaleUrunID
				rs.open sorgu, sbsv5,1,3
				rs("uhde") = 0
				rs("kararPuluTutar")	=	null
				rs.update
				rs.close
				response.Write "ok|"
			elseif uhdeF = True AND kalemIptal = False then
				sorgu = "SELECT uhde FROM " & tablo & " WHERE id = " & id
				rs.open sorgu, sbsv5,1,3
				rs("uhde") = 0
				rs.update
				rs.close
				response.Write "ok|"
			elseif kalemIptal = True then
				response.Write "uruniptal|"
				
					hatamesaj = "Ürün Rakip uhdesinde işareti kaldırıldı."
					call logla("Dosya","update",hatamesaj,modulID)
			end if
		end if
		
'### ihale_urun tablosu ürün bazında karar pulu hesaplaması
		call kararPuluHesap(id)
'### /ihale_urun tablosu ürün bazında karar pulu hesaplaması			
		
			
			hatamesaj = "Uhde Kaydı Başarılı."
			call logla("Dosya","update",hatamesaj,modulID)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
			
		
	'## veritabanı
'##### HÜCRE EDIT
'##### HÜCRE EDIT


%>