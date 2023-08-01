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
	cariID				=	request.QueryString ("cariID") 'LEFT JOIN de cariID için kullan
	sartOzel			=	request.QueryString ("sartOzel")
	
'##### /ajax ile gelen sorgu 
'##### /ajax ile gelen sorgu 


	'##### /STOKLARI ÇEK select2 için JSON verisi oluştur
	'##### /STOKLARI ÇEK select2 için JSON verisi oluştur
	
            sorgu = "SELECT"
			sorgu = sorgu & " t1.id as stokRefID,"
			sorgu = sorgu & " t2.stokKodu,"
			sorgu = sorgu & " t2.stokAd, t2.stokAdEn, t2.stokBarcode, t1.cariUrunRef, t1.cariUrunAd" 
			sorgu = sorgu & " FROM stok.stokRef t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			if cariID <> "" then
				sorgu = sorgu & " AND t1.cariID = " & cariID & ""
			end if 
			sorgu = sorgu & " WHERE t1.silindi = 0"
				sorgu = sorgu & " AND (t1.cariUrunAd like N'%" & arananKelime & "%'"
					sorgu = sorgu & " OR t1.cariUrunRef like N'%" & arananKelime & "%')"
					sorgu = sorgu & " and t1.firmaID = " & firmaID
			if sartOzel <> "" then
				sorgu = sorgu & " AND " & sartOzel
			end if
			sorgu = sorgu & " ORDER BY t2.stokAd ASC"
			rs.open sorgu, sbsv5, 1, 3
			
'			stokAd = rs("stokBarcode")
'				for i = 1 to len(stokAd)
'			
'			response.write Asc(mid(stokAd,i,1)) & " <> "
'			response.write mid(stokAd,i,1) & "<br />"
'				next
'			
'				response.end
'				
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
				
		'####### chr13 ve chr10 temizle json patlamasın
					stokBarcode		=	rs("stokBarcode")
					stokAd			=	rs("stokAd")
					stokAdEN		=	rs("stokAdEN")
					cariUrunRef		=	rs("cariUrunRef")
					cariUrunAd		=	rs("cariUrunAd")
					if sart = "english" AND not isnull(stokAdEN) then
						stokAd = stokAdEn
					end if
					stokKodu		=	rs("stokKodu")
					kontrolString	= 	stokBarcode & stokAd & stokKodu
			
				if instr(kontrolString,chr(10)) > 0 OR instr(kontrolString,chr(13)) then
					stokBarcode			=	jsonTemizle(stokBarcode)
					stokAd				=	jsonTemizle(stokAd)
					stokKodu			=	jsonTemizle(stokKodu)
					rs("stokBarcode")	=	stokBarcode
					rs("stokAd")		=	stokAd
					rs("stokKodu")		=	stokKodu
					rs.update
				end if
		'####### /chr13 ve chr10 temizle json patlamasın
				
				
					Response.Write "{"
					Response.Write """id"":" & rs("stokRefID") & ","
					Response.Write """text"":"""
					if stokKodu <> "" then
						Response.Write stokKodu & " -- "
					end if
					if cariUrunRef <> "" then
						Response.Write cariUrunRef & " -- "
						Response.Write cariUrunAd
					else
						Response.Write stokAd
					end if
					if stokBarcode <> "" then
						Response.Write " -- " & stokBarcode
					end if
					Response.Write """"
					'Response.Write ","
					'Response.Write """disabled"":true"
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

	'##### /STOKLARI ÇEK select2 için JSON verisi oluştur
	'##### /STOKLARI ÇEK select2 için JSON verisi oluştur




%>

