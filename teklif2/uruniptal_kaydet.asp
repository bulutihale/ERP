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
	'##### request
	'##### request
	
	
	hatamesaj = "Kayıt başlıyor."
	call logla("Dosya","update",hatamesaj,modulID)

'##### HÜCRE EDIT
'##### HÜCRE EDIT

	'## veritabanı
			sorgu = "SELECT iptal, uhde, sozlesmelerID, kararPuluTutar, iptalSebep FROM " & tablo & " WHERE id = " & id
			rs.open sorgu, sbsv5,1,3
			
			
			if rs("iptal") = False then
				rs("iptal") = True
				rs("uhde") = False
				rs("sozlesmelerID") = False
				rs("kararPuluTutar")	=	null
				
				sorgu2 = "SELECT uhde FROM fiyatlar WHERE ihaleUrunID = " & id
				rs2.open sorgu2, sbsv5,1,3
				
					if rs2.recordcount > 0 then 
						for ui = 1 to rs.recordcount
							rs2("uhde") = False
							rs2.update
						rs2.movenext
						next
					end if
				rs2.close
				
			else
				rs("iptal") = False
				rs("iptalSebep") = null
			end if
			rs.update
			rs.close
			
'### ihale_urun tablosu ürün bazında karar pulu hesaplaması
		call kararPuluHesap(id)
'### /ihale_urun tablosu ürün bazında karar pulu hesaplaması			
			
			response.Write "ok|"
			
			
			
			
			
		
			hatamesaj = "Kayıt Başarılı."
			call logla("Dosya","update",hatamesaj,modulID)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		
	'## veritabanı
'##### HÜCRE EDIT
'##### HÜCRE EDIT


%>

