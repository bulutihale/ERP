<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


'##### ajax ile gelen sorgu 
'##### ajax ile gelen sorgu 
	arananKelime		=	request.QueryString ("q")
	arananKelime		=	TRIM(arananKelime)
	arananKelime		=	replace(arananKelime,Chr(9),"")
	sart				=	request.QueryString ("sart")

	
'##### /ajax ile gelen sorgu 
'##### /ajax ile gelen sorgu 


	'##### /ÜLKELERİ ÇEK select2 için JSON verisi oluştur
	'##### /ÜLKELERİ ÇEK select2 için JSON verisi oluştur
	
            sorgu = "SELECT"
			sorgu = sorgu & " t1.id as ulkeID,"
			sorgu = sorgu & " t1.adTurkce,"
			sorgu = sorgu & " t1.adEnglish, t1.ulkeKod" 
			sorgu = sorgu & " FROM portal.ulkeler t1" 
			sorgu = sorgu & " WHERE (t1.adTurkce like N'%" & arananKelime & "%' OR t1.adEnglish like N'%" & arananKelime & "%' OR t1.ulkeKod like N'%" & arananKelime & "%')"
			sorgu = sorgu & " ORDER BY t1.adTurkce ASC"
			rs.open sorgu, sbsv5, 1, 3
			
'				
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
				
		 			adEnglish		=	rs("adEnglish")
		 			adTurkce		=	rs("adTurkce")
		 			if sart = "english" AND not isnull(adEnglish) then
		 				ulkeAd = adEnglish
					else
						ulkeAd = adTurkce
		 			end if
			
		' '####### chr13 ve chr10 temizle json patlamasın
		' 		if instr(kontrolString,chr(10)) > 0 OR instr(kontrolString,chr(13)) then
		' 			stokBarcode			=	jsonTemizle(stokBarcode)
		' 			stokAd				=	jsonTemizle(stokAd)
		' 			stokKodu			=	jsonTemizle(stokKodu)
		' 			rs("stokBarcode")	=	stokBarcode
		' 			rs("stokAd")		=	stokAd
		' 			rs("stokKodu")		=	stokKodu
		' 			rs.update
		' 		end if
		' '####### /chr13 ve chr10 temizle json patlamasın
				
				
					Response.Write "{"
					Response.Write """id"":" & rs("ulkeID") & ","
					Response.Write """text"":"""
						Response.Write ulkeAd
					Response.Write """"
					if i < rs.recordcount then
						Response.Write "},"
					else
						Response.Write "}"
					end if	
				rs.movenext
				next
					Response.Write "]"
					Response.Write "}"
				rs.close

	'##### /ÜLKELERİ ÇEK select2 için JSON verisi oluştur
	'##### /ÜLKELERİ ÇEK select2 için JSON verisi oluştur




%>

